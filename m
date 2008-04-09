From: Ingo Molnar <mingo@elte.hu>
Subject: git annoyances
Date: Wed, 9 Apr 2008 12:14:28 +0200
Message-ID: <20080409101428.GA2637@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 12:15:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjXKy-0004hf-JG
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 12:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbYDIKOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 06:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbYDIKOl
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 06:14:41 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:53262 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630AbYDIKOl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 06:14:41 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1JjXK3-0006AW-64
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Wed, 09 Apr 2008 12:14:39 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id F27BF3E21D8; Wed,  9 Apr 2008 12:14:27 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79095>


i just had a rather annoying session with git - here's the dump and 
commentary, in case anyone is interested in usability fineprint.

it was with git-core-1.5.4.3-2.fc8 - so if it's all fixed/improved in 
1.5.5, or if this is blatant user error for which i deserve to be 
punished then my apologies!

usually i just have a single git repo that tracks everything 
interesting, but this time i did something i rarely do: i tried to merge 
one local tree of mine into another local tree of mine. So i had no 
commands (or even concepts) cached in my short-term memory that would 
achieve this goal, i just tried the commands that i thought to be 
'obvious', without applying much (or any) IQ to those commands:

 $ cd linux-2.6-sched-devel.git

 $ git-remote add ~/linux-2.6-x86.git

 $ git-remote show x86
  * remote x86
    URL: /home/mingo/linux-2.6-x86.git
  New remote branches (next fetch will store in remotes/x86)
  base for-akpm for-linus latest master testing

 $ git-merge x86/latest
 x86/latest - not something we can merge

 #
 # ho hum. Not something 'we' can merge. Do i care? :-) There's no 
 # actionable reference given to the user about how to resolve this 
 # problem. So i kept on trying:
 #

 $ git-fetch x86/latest
 fatal: 'x86/latest': unable to chdir or not a git archive
 fatal: The remote end hung up unexpectedly

 $ git-pull x86/latest
 fatal: 'x86/latest': unable to chdir or not a git archive
 fatal: The remote end hung up unexpectedly

 #
 # hm. two fatal messages, suggesting that there's something really 
 # wrong while there's nothing wrong.
 #

what got me going after experimenting around some more was this exact 
command:

 $ git-pull x86 latest

(that fetch+merge went problem-free.)

but it was a PITA and all of git's messages about the problem were not 
only unhelpful, they confused me into looking for problems where there 
were none IMO. I was starting to wonder whether i have to have some git 
daemon running on that box for example. But in retrospect IMO it was 
rather clear from the outset what i wanted git to do (merge the tip of 
my other tree into the tip of this tree, on the local box, no frills), i 
just didnt figure out the exact command to do it.

another (minor) usability annoyance: one of the first things i tried was 
to verify the remote setup, via:

$ git-remote show

which gave me this answer:

 Usage: git remote show <remote>

then i tried git-remote show -a (to list all repositories, etc.) - what 
i didnt figure out was to show all repositories is to do a simple 
"git-remote". I think "git-remote show" should output all repositories, 
or at least indicate it in its help line what to do to get such a list. 
(for us poor sobs forgetting commandline details ;)

also, the first natural thing i did was to just type:

 $ git-merge ~/linux-2.6-x86.git/

which i naively assumed would sort things out for me and provide some 
reasonable default behavior - but instead it just gave an annoyingly 
unhelpful error message:

 /home/mingo/linux-2.6-x86.git/ - not something we can merge

there should really be a consciously established "route of failure 
resolution" - directing people towards relevant sources of information 
or commands when the git command-line utilities return some error due to 
user incompetence. Otherwise users just guess around and get frustrated.

also, i think this session also probably matches the newbie's experience 
about git, and making certain git operations so hard to achieve is 
certainly not a reassuring experience for them either. [ Or shall they 
all be filtered out as fundamentally incompetent people? ;-) ]

	Ingo
