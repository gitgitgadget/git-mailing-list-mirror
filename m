From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pulling Already up-to-date linux-2.6 repo takes ~8 minutes?
Date: Thu, 18 Oct 2007 01:48:34 -0400
Message-ID: <20071018054834.GH14735@spearce.org>
References: <1192678865.20353.14.camel@Homer.simpson.net> <20071018045001.GA14735@spearce.org> <1192684150.7390.15.camel@Homer.simpson.net> <1192685971.7390.21.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:48:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiOFW-0007CV-QQ
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 07:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbXJRFsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 01:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbXJRFsj
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 01:48:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52001 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbXJRFsi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 01:48:38 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiOFE-0008GX-W7; Thu, 18 Oct 2007 01:48:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 39BD320FBAE; Thu, 18 Oct 2007 01:48:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1192685971.7390.21.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61484>

Mike Galbraith <efault@gmx.de> wrote:
> Dang.  git was happy with everything above except the checkout -b
> master, so I can't get off the dangling limb I'm on, and onto a solid
> branch.
> 
> root@Homer: git checkout -b master
> git checkout: branch master already exists
> root@Homer: git branch
> * (no branch)
>   master

Look to see if there's anything on your current master branch that
you don't want/need anymore:

	$ git log ..master

If that comes up empty (no output) or you mean to discard those
changes then you can just force create the branch and check it out:

	$ git branch -f master
	$ git checkout master

On the other hand if you want to keep those changes then you should
consider creating a different branch than master, or merging master
first:

	$ git merge master


> root@Homer: time git pull
> remote: Total 48507 (delta 38878), reused 44654 (delta 35166)
...

Well, you downloaded everything again.  However...

> 3419 objects were added to complete this thin pack.
> * refs/remotes/origin/master: fast forward to branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
>   old..new: 86a71db..d85714d

This time we actually stored a remote tracking branch.

So although we didn't actually merge Linus' current version into
your detached HEAD we did save it under a remote tracking branch
(named "origin/master") so the next time you run git-pull we won't
actually need to download that data again.  We already have it,
and know we have it.

Its just not in your current branch.

> You are not currently on a branch; you must explicitly
> specify which branch you wish to merge:
>   git pull <remote> <branch>

If you finish switching to a real branch with a configured remote
and merge entry then this message should go away and you should be
able to efficiently pull Linus' tree into your own.

-- 
Shawn.
