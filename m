From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What commands can and can not be used with bare repositories?
Date: Sat, 30 Dec 2006 20:57:32 -0500
Message-ID: <20061231015732.GB5082@spearce.org>
References: <E1H0poE-0000qd-Ee@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 02:57:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0pxI-0008SM-98
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 02:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWLaB5h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 20:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWLaB5h
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 20:57:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38541 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932622AbWLaB5g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 20:57:36 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0pwx-0007WE-4Y; Sat, 30 Dec 2006 20:57:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B54D420FB65; Sat, 30 Dec 2006 20:57:32 -0500 (EST)
To: Theodore Ts'o <tytso@mit.edu>
Content-Disposition: inline
In-Reply-To: <E1H0poE-0000qd-Ee@candygram.thunk.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35647>

Theodore Ts'o <tytso@mit.edu> wrote:
> What isn't documented is what commands actually can deal with a bare
> repository.  At the moment, it looks like a bare repository can be a
> target of a git pull, push, and merge commands

Sorry but 'git merge' cannot be used in a bare repository (no working
directory to update during the merge) and 'git merge' can only work on
the current repository, which rules out the bare repository.

> and it can be a source
> for a git clone, but that seems to be about it.  All other commands,
> such as "git log" blow up with the error message "Not a git repository".

Try "git --bare log".  Or "git --git-dir=/path/to log".

> This to me seems a bit lame, since why isn't a "bare repository" also a
> "git repository"?  All of the information is there for "git log" to
> work.  Commands that require a working directory obviously can't work,
> but there are plenty of git commands for which there's no reason why
> they shouldn't be able to operate on a bare repository.  For example,
> "git repack", "git log", "git fetch", etc.

Actually most commands work on a bare repository.
Very few don't: the ones that require a working directory.
E.g. status/revert/cherry-pick/commit/am/merge/pull.  (You can
pull from a bare repository, but you cannot run pull *in* a bare
repository.)

> confused, but maybe we could fix that.  What if we were to change "git
> clone --bare" to create the .git -> . symlink, and then add a check to
> commands that require a working directory to see if ".git" is a symlink
> to ., and if so, give an error message, "operation not supported on bare
> repository"?

No.  Better would be to make git's repository setup logic
automatically detect if "." is a Git repository, and if so let the
commands that work without a working directory run.

-- 
Shawn.
