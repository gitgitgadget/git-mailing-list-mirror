From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Looking for a way to set up Git correctly
Date: Thu, 11 Nov 2010 14:25:02 +0100
Message-ID: <20101111132502.GB23423@nibiru.local>
References: <BD94CB4FDD0C4462804E316F814A3CCA@denny>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 14:38:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGXLy-0002EQ-71
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 14:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029Ab0KKNiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 08:38:01 -0500
Received: from caprica.metux.de ([82.165.128.25]:43792 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753242Ab0KKNiA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 08:38:00 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oABDe1IA027642
	for <git@vger.kernel.org>; Thu, 11 Nov 2010 14:40:01 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oABDdjH4027586
	for git@vger.kernel.org; Thu, 11 Nov 2010 14:39:45 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oABDP2D8004894
	for git@vger.kernel.org; Thu, 11 Nov 2010 14:25:02 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <BD94CB4FDD0C4462804E316F814A3CCA@denny>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161248>

* Dennis <denny@dennymagicsite.com> wrote:

Hi,

> Now, this can be either really simple or really complicated.  My first 
> question is:  how do I set the repository up in the proper way where I 
> could work on all 3 projects separately, with additional possibility of 
> working on branch1 only and later committing my changes to branch2 and 
> branch3.  

As first step you could create 3 separate git repos in each directory
and add everything to it (git init, git add -A, git commit). Then 
rename the branches properly (so instead of "master", they'll be called
"branch1", "branch2", "branch2" or something like that). Create another
(maybe bare) repo elsewhere, add it as remote to the three other ones
and push their branches upwards. Now you have 4 repos, 3 for working
on the individual branches and another for collecting them all (hub model).
You could also choose to throw the first three away and only work in
the last one.

> (Since projects are virtually identical, a fix in one branch 
> usually needs to be propagated to other branches)

In your case, cherry-pick might be the right for you.
You could also do a little bit refactoring, making a 4th branch which
the other 3 are then rebased onto. Then you could do your fixes in that
branch and merged into or rebase the other 3 onto that one.

> My second question is that each branch has a huge folder with image data. 
> By huge I mean 1 to 4Gb, depending on the branch.  Since images are not 
> directly relevant to the development work, is there a way to not include 
> those folders in git?

see .gitignore file.
nevertheless it might be useful to also have all the images in the
repo for backup reasons.

BTW: if you're concerned about disk space, you could add the object dir
of the 4th (hub) repository to the 3 working repos (run git-gc in the
hub repo before that!). Next gc runs will remove the objects that are
already present in the hub. But beware! If you remove something in the
hub repo and run git-gc there, you could loose objects in the other repos!
(maybe it would be wise to add the 3 working repos as remotes in the
hub and always run an git remote update before git-gc in the hub).


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
