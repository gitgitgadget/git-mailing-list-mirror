From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-reset and clones
Date: Thu, 16 Mar 2006 15:53:56 +0100
Message-ID: <44197C04.5080400@op5.se>
References: <Pine.LNX.4.64.0603161424310.5276@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 16 15:54:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJtrY-00041R-SD
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 15:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWCPOx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 09:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWCPOx6
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 09:53:58 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:45789 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751184AbWCPOx6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 09:53:58 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id EF0656BD21; Thu, 16 Mar 2006 15:53:56 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Paul Jakma <paul@clubi.ie>
In-Reply-To: <Pine.LNX.4.64.0603161424310.5276@sheen.jakma.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17638>

Paul Jakma wrote:
> Hi,
> 
> Next dumb question:
> 
> If a git repository has a reset HEAD~X done, then any later pulls in 
> clone repositories get /really/ upset, with:
> 
> $ git pull
> * refs/heads/origin: does not fast forward to branch 'master' of 
> /home/paul/foo-git/;
> 
> Type of thing. This seems to be a similar issue to:
> 
>     http://www.gelato.unsw.edu.au/archives/git/0510/10767.html
> 
> The question is has this improved at all since last year? Is there 
> anything the origin repository maintainer (the one who did reset) can do 
> to recover from this?
> 
> I'm guessing the answer is:
> 
> Yes:
> 
> 1. where git-reset has already been done, manually update the
>   refs back to the previous HEAD
> 2. then use git-revert, and continue to use git-revert only.
> 
> My question then would be, presuming some innocent repository maintainer 
> has already done 1, what's the easiest way to accomplish 1?
> 
> (they shouldn't have done it obviously, but assume they're git newbies, 
> made an honest mistake and now need to recover, preferably without 
> having to involve those who pull).
> 

I *think* this should work. Get a backup before trying. Note that I'm 
assuming "git reset" hasn't been run several times, or you'll have to 
replace ORIGIN with whatever HEAD pointed to before the first reset.

In mothership-repo:
	git checkout master
	git branch next-master ORIGIN
	git rebase next-master; # fix conflicts and commit
	git branch -d master
	git checkout -b master next-master
	git -d next-master
	git revert (the bad commits)

Some shortcuts can be taken if we're not to use git commands the entire 
way, but this is easier to explain to those newbie-ish people you mentioned.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
