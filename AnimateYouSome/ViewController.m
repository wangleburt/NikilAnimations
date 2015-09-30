//
//  ViewController.m
//  AnimateYouSome
//
//  Created by Chris Meill on 9/29/15.
//  Copyright (c) 2015 :D. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect boxFrame = (CGRect){0, 0, 100, 100};
    boxFrame.origin.x = CGRectGetMidX(self.view.frame)/2 - CGRectGetWidth(boxFrame)/2;
    UIImageView *box = [[UIImageView alloc] initWithFrame:boxFrame];
    box.image = [UIImage imageNamed:@"sign"];
    [self.view addSubview:box];
    
    [self doBounceAnimationForView:box];
    
    boxFrame = (CGRect){0, 0, 100, 100};
    boxFrame.origin.x = CGRectGetMaxX(self.view.frame)*.75 - CGRectGetWidth(boxFrame)/2;
    box = [[UIImageView alloc] initWithFrame:boxFrame];
    box.image = [UIImage imageNamed:@"sign"];
    [self.view addSubview:box];
    
    [self doSwayAnimationForView:box];
}

- (void)doBounceAnimationForView:(UIView *)view
{
    view.layer.anchorPoint = CGPointMake(0.5, 1);
    view.center = (CGPoint){view.center.x, CGRectGetMaxY(self.view.frame)};
    
    [UIView animateWithDuration:0.15f delay:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
        view.transform = CGAffineTransformMakeScale(1, 0.9);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.07f animations:^{
            view.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                view.transform = CGAffineTransformMakeTranslation(0, -20);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    view.transform = CGAffineTransformMakeTranslation(0, 0);
                } completion:^(BOOL finished) {
                    [self doBounceAnimationForView:view];
                }];
            }];
        }];
    }];
}

- (void)doSwayAnimationForView:(UIView *)view
{
    view.layer.anchorPoint = CGPointMake(0.5, 1);
    view.center = (CGPoint){view.center.x, CGRectGetMaxY(self.view.frame)};
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = @(-M_PI/10);
    animation.toValue = @(M_PI/10);
    animation.duration = 0.8;
    animation.repeatCount = HUGE_VAL;
    animation.autoreverses = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [view.layer addAnimation:animation forKey:@"sway"];
}

@end
