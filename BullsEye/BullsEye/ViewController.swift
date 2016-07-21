//
//  ViewController.swift
//  BullsEye
//
//  Created by Guido on 7/18/16.
//  Copyright © 2016 Guido J. Medina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel:  UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showAlert() {
        //constant below now uses abs()function to get absolute value
        
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        
        var title: String
        if difference == 0 {
            title = "Perfect Score!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50 }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        
       
        //var difference = currentValue - targetValue
      //  if difference < 0 {
       //     difference = difference * -1
       // }
        
        //  if currentValue > targetValue {
       //     difference = currentValue - targetValue
      //  } else if targetValue > currentValue {
       //     difference = targetValue - currentValue}
      //  else { difference = 0
      //  }
        
        
        let message = "You scored \(points) points!"
                   // + "\nThe target value is: \(targetValue)"
                    //+ "\nThe difference is \(difference)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        //Added a closure to the handler action
        let action = UIAlertAction(title: "OK", style: .Default,
                                   handler: { action in
                                              self.startNewRound()
                                              self.updateLabels()
                                             } )
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
    }
}

