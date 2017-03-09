particle[] particles;
Nebula[] web;
int dimx = 800, dimy = 600;
void setup(){
   noStroke();
   particles = new particle[200];
   web = new Nebula[5000];
   size(800, 600);
   background(0);
   for(int i = 0; i < particles.length; i++){
     particles[i] = new NormalParticle();
   }
   for(int i = 0; i < web.length; i++){
     web[i] = new Nebula();
   }
   particles[0] = new OddBallParticle();
   particles[1] = new JumboParticle();
}
void draw(){
  fill(0,0,0,33);
  if(mousePressed == false)
  background(0);
  else
  rect(0,0,dimx,dimy);
  
  for(int i = 0; i < particles.length; i++){
    particles[i].move();
    particles[i].show();
  }
  for(int i = 0; i < web.length; i ++){
    web[i].move();
    web[i].show();
  }
}

class NormalParticle implements particle{
  double v, theta, x = 0, y = 0;
  int r, g, b, size;
  NormalParticle(){
    r = (int)(Math.random() * 255);
    g = (int)(Math.random() * 160);
    b = 255-r;
    v = Math.random()*7 + 3;
    theta = Math.random()*2*Math.PI;
    x = dimx/2;
    y = dimy/2;
    size = 5 + (int)(Math.random()*5);
  }
  public void move(){
    x += v*Math.cos(theta);
    y += v*Math.sin(theta);
    if(x > dimx || y > dimy || x < 0 || y < 0){
    x = mouseX;
    y = mouseY;
    }
  }
  public void show(){
    fill(r,g,b);
    ellipse((float)x,(float)y, size/2, size/2);
    fill(r,g,b,50);
    ellipse((float)x,(float)y, size, size);
    fill(255,255,255,20);
    ellipse((float)x,(float)y, size*2, size*2);
    fill(255,255,255,10);
    ellipse((float)x,(float)y, size*3, size*3);
  }
  
}
class OddBallParticle implements particle{
  int x, y, size, r, g, b;
  double dx, dy, vx, vy;
  OddBallParticle(){ //constructor
    x = (int)(Math.random()*dimx); //random start position
    y = (int)(Math.random()*dimy);
    vx = 0; //initial velocities are zero
    vy = 0;
    size = (int)(Math.random()*20) + 9; //size is randomized
    r = 255;
    g = 255;
    b = 255;
  }
  void show(){
    fill(r,g,b);
    ellipse(x,y,size,size);
    fill(r,g,b,15);
    ellipse(x,y,3*size,3*size);
  }
  void move(){
    dx = mouseX - x;
    dy = mouseY - y;

      vx += Math.signum(dx); //velocity is increased if dx is positive, decreased if negative
      vy += Math.signum(dy);
      while(vx>10){
        vx -= 1;
      }
      while(vy>10){
        vy -= 1;
      }
      while(vx<-10){
        vx += 1;
      }
      while(vy<-10){
        vy += 1;
      }
    x += vx;
    y += vy;
  }
}

class JumboParticle extends NormalParticle{
 void show(){
   fill(r,g,b);
   ellipse((float)(x), (float)(y), 50, 50);
 }
 void move(){
   x += v*Math.cos(theta);
   y += v*Math.sin(theta);
   if(x > dimx){
     theta = Math.PI - theta;
   }
   if(y > dimy){
     theta *= -1;
   }
   if(x < 0){
     theta = Math.PI - theta;
   }
   if(y < 0){
     theta *= -1;
   }
 }
}

public interface particle{
  public void move();
  public void show();
}

class Nebula{
  double x, y;
  int r, g, b, size;
  Nebula(){
    if(Math.random() < .5){
      r = 150 + (int)(Math.random()*105);
      g = (int)(Math.random()*20);
      b = 15 + (int)(Math.random()*105);
    }
    else{
      r = 100 + (int)(Math.random()*155);
      g = 40 + (int)(Math.random()*25);
      b = (int)(Math.random()*18);
    }
    x = Math.random()*dimx;
    y = Math.random()*dimy;
    size = 3 + (int)(Math.random()*3);
  }
  void move(){
    x += Math.random()*2 - 1;
    y += Math.random()*2 - 1;
    if(x < 0||y < 0||x > dimx||y > dimy){
    x = Math.random()*dimx;
    y = Math.random()*dimy;
    }
  }
  void show(){
    fill(r, g, b, 80);
    ellipse((float)x, (float)y, size, size);
  }
}
