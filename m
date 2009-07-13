From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Re: Pushing to GitHub doesn't push all branches
Date: Mon, 13 Jul 2009 10:12:17 +0200
Message-ID: <h3eqap$cov$1@ger.gmane.org>
References: <h37fga$5ie$1@ger.gmane.org> <4A575416.2090304@drmicha.warpmail.net> <h37lh2$q3s$1@ger.gmane.org> <4A57639D.4020305@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 10:14:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQGfM-0002gj-Ou
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 10:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbZGMINd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 04:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbZGMINc
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 04:13:32 -0400
Received: from main.gmane.org ([80.91.229.2]:54098 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227AbZGMINb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 04:13:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MQGfC-0007Es-QO
	for git@vger.kernel.org; Mon, 13 Jul 2009 08:13:30 +0000
Received: from 41.177.20.228 ([41.177.20.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 08:13:30 +0000
Received: from graemeg by 41.177.20.228 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 08:13:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 41.177.20.228
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <4A57639D.4020305@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123175>

Michael J Gruber wrote:
> 
> Please don't! That's what we're here for ;)

:) Thanks.


> git for-each-ref --shell --format="git push -f origin :%(refname)"
> refs/remotes/|while read line; do eval $line;done

OK, done this. 'git ls-remote github' doesn't show any remotes/* 
references anymore.

Oh by the way, I followed your advice and renamed 'origin' to 'github' 
so it makes a bit more sense. I used the following command:

   $ git remote rename origin github


> 
> git config remote.origin.push '+refs/remotes/*:refs/heads/*'

OK, I've done this, but I'm not 100% sure what this means. This is what 
I think (from reading various git help and users guide). Any branches I 
have which track remote references (from svn repository) will be pushed 
to github as various head references (normal branches).  Is this correct?

On our server, which contain the svn cloned repository and the one that 
is only used for syncing svn -> our server -> github, I had to add a new 
commit which represents the svn-ignore meta data to a .gitignore file. I 
noticed I had to manually to a 'git checkout master' & 'git merge 
remotes/trunk' to pull in new updates. I thin pushed that to github.

So what is my twice hourly cron script supposed to look like? Is the 
following still ok?

========[ script executed by cron every 30 minutes ]============
#!/bin/sh
GIT="/usr/local/bin/git"

# FPC repository
cd /mnt/samba/git/fpc.git/
$GIT checkout master
$GIT svn fetch
$GIT gc --auto
$GIT push github master
==============================

Or do I need to add a new line after '$GIT svn fetch' that does a merge.

==============================
$GIT svn fetch
$GIT merge remotes/trunk
...
push to github
==============================


Also what do I do with the other branch I want to track. It's called 
remotes/fixes_2_2.

I believe I need to first create a local branch.

   git branch --track fixes_2_2 remotes/fixes_2_2

What do I need to modify in my cron script to keep both the master & 
fixes_2_2 branches in sync with SubVersion and push both to GitHub. I 
want Github to show two branches: master & fixes_2_2



Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
