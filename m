From: Ilya Dogolazky <ilya.dogolazky@nokia.com>
Subject: Re: git-p4: commits are visible in history after 'git p4 clone',
 but not a single file present
Date: Tue, 12 Jun 2012 12:37:47 +0300
Message-ID: <4FD70DEB.7040506@nokia.com>
References: <4FD5C263.9010307@nokia.com> <CAE5ih79Lgc8vF0v=vTGZSwASsGwQWs2Q7h_AkW67RBfi-R=DCA@mail.gmail.com> <4FD6440C.7090900@nokia.com> <4FD67530.1090002@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 11:38:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeNYE-0001Vf-5O
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 11:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab2FLJiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 05:38:00 -0400
Received: from smtp.nokia.com ([147.243.1.47]:40586 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682Ab2FLJh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 05:37:58 -0400
Received: from [172.21.81.167] (esdhcp09nok081167.ntc.nokia.com [172.21.81.167])
	by mgw-sa01.nokia.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with ESMTP id q5C9blDI024014;
	Tue, 12 Jun 2012 12:37:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FD67530.1090002@diamand.org>
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199776>

Hi Luke!

 > #!/bin/sh
 > export P4PORT=localhost:1234
 > mkdir db cli
 > ( cd db && p4d & )
 > sleep 2
 > ( cd cli && EDITOR=: p4 client && date >foo.c &&
 >   p4 add foo.c && p4 submit -d 'x' )
 > git-p4 clone //depot@all

I installed p4d on my machine and executed the above script.
It works, the file foo.c is visible in the copy and one line patch is 
visible by "git log -p". Everything is fine!

Then I realize, that the "git-p4" call in your script is communicating 
with the p4 daemon directly, which is much more simple setup than I 
tried to use before. Then I changed the clone command: instead of
  $ git p4 clone //kalma/xxx/yyy@all
I now tried
  $ git p4 clone //xxx/yyy@all
after setting P4PORT etc to point to the company's perforce server. And 
it worked!

Then I even tried
$ git p4 clone //xxx@all
And it worked too (creating a huge git repository with the whole project).

Until today I tried to use the following setup: first clone the whole 
perforce repository with p4 command line client to my machine ('kalma' 
is its name) and then make a git repository by "git-p4 clone" from this 
intermediate location (and it seems I did something wrong there: files 
were visible in the intermediate location after the first step, but not 
in the end location after git-p4). I read it somewhere in documentation 
claiming that it's the only way to use git-p4. But now I see, that it 
seems not to be necessary. Please clarify, is it okay to skip this 
intermediate location and use git-p4 in the same way as your script does?

And another question, probably connected to above: Now I did this:
$ git p4 clone //xxx/yyy@all
$ cd yyy/zzz
$ edit readme.txt (which was already present there)
$ git commit readme.txt
$ git p4 rebase (Current branch master is up to date)
$ git p4 submit

That last step failed with following messages:
Submitting change 20073
... //xxx/yyy/zzz/readme.txt -  warning: cannot submit from non-stream 
client
No files to submit.
Submit failed -- fix problems above then use 'p4 submit -c 20073'.

Is it somehow related to my setup?

Cheers,

Ilya
