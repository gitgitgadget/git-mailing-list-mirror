From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Use case I don't know how to address
Date: Sat, 05 Sep 2009 08:02:04 +0100
Message-ID: <4AA20CEC.8060408@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 09:03:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjpJQ-0006ob-Ly
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 09:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbZIEHCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 03:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbZIEHCF
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 03:02:05 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:51963 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753161AbZIEHCE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Sep 2009 03:02:04 -0400
Received: from [172.23.170.142] (helo=anti-virus02-09)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1MjpHh-0004IW-L7
	for git@vger.kernel.org; Sat, 05 Sep 2009 08:02:05 +0100
Received: from [77.103.217.152] (helo=wol.chandlerfamily.org.uk)
	by asmtp-out2.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1MjpHh-0002yt-7I
	for git@vger.kernel.org; Sat, 05 Sep 2009 08:02:05 +0100
Received: from kanga.local ([192.168.0.30])
	by wol.chandlerfamily.org.uk with esmtp (Exim 4.69)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1MjpHg-0001o5-Tb
	for git@vger.kernel.org; Sat, 05 Sep 2009 08:02:04 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090701)
X-SA-Exim-Connect-IP: 192.168.0.30
X-SA-Exim-Mail-From: alan@chandlerfamily.org.uk
X-SA-Exim-Scanned: No (on wol.chandlerfamily.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127785>

I have a use case that I don't know how to address.  I have a feeling 
that the way I propose is not using git to its best advantage, and am 
therefore asking for advice.

As an intermittent software developer I have been using git for a long 
time to track software (GPL licenced) I have developed for a web site 
that I operate supporting a fan club. [Ajax based Chat, a real time Air 
Hockey Game with associated club Ladder, and an American Football 
Results Picking Competition]

Each application uses a pattern like that shown below

Basically I have two branches that interact as follows

        2' - 2a - 3' - 4'  SITE
       /         /    /
1 -  2  ------ 3  - 4  MASTER

I develop and test Locally on the master branch, in the commit 2a I 
update settings (such as database password etc that I need for the 
site), and then progressively merge commits made on master when I am 
happy that they work in the test environment.  A git hook rsyncs the 
site branch to site on each merge or commit on that branch.

The master branch is also pushed to my public git repository (which is 
why passwords are changed on the site branch.  The change made back in 
2a is "remembered" by git, so provided I don't go editing the password 
on the master branch things work fine.

My applications tend to be "skinned" (if that is the right word for the 
html page that forms the backdrop for them) with the fan club web site 
look and feel.  However, I am now trying to make a demo site on my home 
server for these applications, and as such I would like to remove the 
fan club skinning and add my own look and feel.  In fact there are other 
changes necessary, because many of the applications use the associated 
fan club membership information of the user to display - so generically, 
I need to make quite a lot of modifications to make it all work and 
would end up with 4 branches as shown, with the difference in commits 
between 4 and 5 as that major work to update the application.


        2' - 2a - 3' - 4'  SITE
       /         /    /
1 -  2  ------ 3  - 4  TEST
                      \
                        5  ------ 6  MASTER
                         \         \
                           5' - 5a- 6' DEMO


As you can see, in the process I have renamed Master to Test - the 
transition to 5a adds passwords to access the database on my demo site.

The problem comes when I want to now merge back further work that I did 
on the master branch (the 5-6 transition) to the fan club site


        2' - 2a - 3' - 4' ----------------- 6' SITE
       /         /    /                    /
1 -  2  ------ 3  - 4  ------------6'''- 6a TEST
                      \            /
                        5  ------ 6  MASTER
                         \         \
                           5''- 5a- 6'' DEMO


What will happen is the changes made in 4->5 will get applied to the 
(now) Test branch as part of the 6->6'' merge, and I will be left having 
to add a new commit, 6a, to undo them all again.  Given this is likely 
to be quite a substantial change I want to try and avoid it if possible.

Is there any way I could use git to remember the 4->5 transition, 
reverse it and apply it back to the Test branch before hand.


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
