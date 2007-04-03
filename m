From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fsck missing dangling commits that are candidate heads?
Date: Tue, 3 Apr 2007 15:47:50 -0400
Message-ID: <20070403194750.GG27706@spearce.org>
References: <loom.20070403T213135-68@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergio Callegari <scallegari@arces.unibo.it>
X-From: git-owner@vger.kernel.org Tue Apr 03 21:47:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYoz0-0003NB-Jb
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 21:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbXDCTr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 15:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422658AbXDCTrz
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 15:47:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48396 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422646AbXDCTrz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 15:47:55 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HYoym-0005Ji-PR; Tue, 03 Apr 2007 15:47:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 07E2A20FBAE; Tue,  3 Apr 2007 15:47:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <loom.20070403T213135-68@post.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43645>

Sergio Callegari <scallegari@arces.unibo.it> wrote:
> on git 1.5.0.6, I have done the following:
> git commit -a
> git reset HEAD^         (assume a mistake)
> git fsck
> 
> the last fsck shows nothing...
> Is this correct? Shouldn't the latest commit (the one made unreachable by the
> reset) be reported as dangling and as a candidate branch head?
> 
> Also git lost-found misses the commit...
> But it is there... I can find it manually in the object database and tag it.
> 
> Also git gc --prune seems to miss the commit... so when we gc useless objects
> appear to be kept around.

Right.  This is the reflog in action.  Your current branch has two
reflogs, .git/logs/HEAD and .git/logs/refs/heads/$foo, where $foo
is your current branch name.  Both of these logs mention the commit
you are looking for, so they aren't considered dangling garbage,
nor are they pruneable.

Use `git log -g` or `git log -g $foo` to look at the reflog for
HEAD and $foo to locate the commit in question.

-- 
Shawn.
