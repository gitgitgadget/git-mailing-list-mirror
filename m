From: Shawn Pearce <spearce@spearce.org>
Subject: Git user survey and `git pull`
Date: Thu, 21 Sep 2006 12:24:01 -0400
Message-ID: <20060921162401.GD3934@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 21 18:25:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQRLP-0001vq-U9
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 18:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWIUQYI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 12:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWIUQYI
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 12:24:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:2465 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751308AbWIUQYF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 12:24:05 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQRLB-0004RY-Q7
	for git@vger.kernel.org; Thu, 21 Sep 2006 12:23:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7ADE020FB16; Thu, 21 Sep 2006 12:24:01 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27484>

I just saw this comment under question 20:

    git-pull's behavior of merging in the first refspec to the
    current branch is very bad and has caused us serious repository
    issues in xorg.

Most of the folks I've been teaching Git to recently have found `git
fetch` to be a very counterintuitive command for fetching things.
Especially since `git push` is what's used to send changes to
the remote repository.  They also find `git pull . foo` as a
counterintuitive way to merge changes.

Basically I'm seeing users run `git pull` when they probably
should have run just `git fetch`; the pull obviously also merges
the first refspec in .git/remotes/origin to the current branch
and that's usually not what the user wanted, especially when the
upstream remote has several branches that the user may be tracking
(e.g. stable, dev, experimental).


I think its probably too late to change the UI[*1*] but I think
it is definately an issue for folks learning Git.  Calling push
push, fetch fetch and fetch+merge pull is probably a design flaw.
IMHO it probably should have been something like:

  Current            Shoulda Been
  ---------------    ----------------
  git-push           git-push
  git-fetch          git-pull
  git-pull . foo     git-merge foo
  git-pull           git-pull --merge
  git-merge          git-merge-driver

in other words pull does the download and doesn't automatically
start a merge unless --merge was also given and git-merge is a
cleaner wrapper around the Grand Unified Merge Driver that makes
it easier to start a merge.


[*1*] I bet a lot of scripts are currently based on the core
      Git Poreclain level functions.  I try to avoid them myself
      in scripts and go right to the plumbing but not everyone
      does that.

-- 
Shawn.
