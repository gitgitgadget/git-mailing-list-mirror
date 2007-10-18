From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pulling Already up-to-date linux-2.6 repo takes ~8 minutes?
Date: Thu, 18 Oct 2007 00:50:02 -0400
Message-ID: <20071018045001.GA14735@spearce.org>
References: <1192678865.20353.14.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 06:50:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiNKt-00009S-OS
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 06:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbXJREuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 00:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbXJREuI
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 00:50:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50464 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbXJREuG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 00:50:06 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiNKa-0005Gx-Lh; Thu, 18 Oct 2007 00:50:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5AD8020FBAE; Thu, 18 Oct 2007 00:50:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1192678865.20353.14.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61467>

Mike Galbraith <efault@gmx.de> wrote:
> git_pull_linus scriptlet:
> 
> #!/bin/sh
> (cd linux-2.6; git pull git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git)
> (cd linux-2.6; git pull -t git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git)
> 
> root@Homer: time ./git_pull_linus
...
> remote: Total 48507 (delta 38878), reused 44654 (delta 35166)

Well, Linus and crew are pretty busy beavers.  Its shocking how
fast they can make a dam^H^H^Hoperating system better.  :-)

...
> Already up-to-date.
> You are not currently on a branch; you must explicitly
> specify which branch you wish to merge:
>   git pull <remote> <branch>

The problem here is you aren't on a branch, you are on a detached
HEAD.  So we must have setup the wrong thing in .git/FETCH_HEAD
and we didn't actually merge.

What version of git is this, exactly (`git version`)?


I'd suggest making your life a little bit easier.  Consider creating
a remote that points to Linus:

  $ git remote add linus git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
  $ git checkout -b master   ; # or any other branch
  $ git config branch.master.remote linus
  $ git config branch.master.merge refs/heads/master

Now you can update from Linus with just:

  $ git pull

Provided you are on branch "master", or whatever other branches
you setup those branch.*.remote and branch.*.merge configuration
options for.

-- 
Shawn.
