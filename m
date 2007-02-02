From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Question: next, master and pu branches
Date: Fri, 2 Feb 2007 01:00:30 -0500
Message-ID: <20070202060030.GA20442@spearce.org>
References: <200702021142.08975.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 07:00:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCrTb-00020C-Oy
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 07:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423111AbXBBGAe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 01:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423112AbXBBGAe
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 01:00:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37545 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423111AbXBBGAe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 01:00:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCrTM-0003kR-8W; Fri, 02 Feb 2007 01:00:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7DCC220FBAE; Fri,  2 Feb 2007 01:00:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200702021142.08975.litvinov2004@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38456>

Alexander Litvinov <litvinov2004@gmail.com> wrote:
> Can somebody explain the meaning of next and pu branches

Within git.git:

  maint: Current stable release.  Receives bug fixes for the
  current release.

  master: Stable development tip.  The tip of this branch will be
  used to create the next stable release.

  next: Topics which are pretty stable and are likely to be merged
  into master soon are merged here first, to make them visible to
  a wider community and get more testing.

  pu: aka "Proposed Updates".  Junio publishes a number of branches
  here and continously rebases this branch.  Topics here may make
  it into next (and then later master), or may not and just be
  dropped forever.

>and some documenation 
> about using topic branches.

What about Documentation/howto/using-topic-branches.txt ?
 
> My development model use two branches now: stable release and develment 
> branch. All changes in the stable release branch are bug-fix only changes. 
> All (or most) of them must go to development release. Now I do this using 
> cherry-pick but it is not easy to track what was merged especialy when merge 
> pruduce confic resloved by hands. Stable branch live long life, much more 
> than 100 commits. 
> 
> It seems topic branches can help me here, but reading Documentation under git 
> sources teach to make topic branch from the branch point and then merge it to 
> both branches. This can work while stable branch has short life and was not 
> heavily rewritten. 
> 
> If there any technique that can help me ?

The easiest way to do this is to create a new topic branch from
the merge base of the two branches (see git-merge-base's docs for
details).  Make the fix on this branch, test it, then merge it into
your development branch.

If additional changes are needed, go back to the topic branch,
fix it there, then remerge the topic to your development branch.

When the topic is finally ready, merge it to your stable branch.

This is what the documentation suggests, because it works, and
works well.  This is how Junio manages `next` (which is the same
as your development branch) and `master` (which is about the same
as your stable branch).

You can let git-rerere help you to manage conflicts which might
reoccur during merges.  If you create the .git/rr-cache directory
then git-commit and git-merge will automatically use git-rerere to
help you.


If you are cherry-picking stuff back and forth this gets really hard,
as you point out.  The tools don't help you very well here, as there
isn't enough data to figure out what is where.  You can try using
git-cherry to tell you which commits are in both branches, but it
has limited usefulness if the commits are making different changes.

-- 
Shawn.
