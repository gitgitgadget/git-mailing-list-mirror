From: Shawn Pearce <spearce@spearce.org>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Fri, 10 Mar 2006 11:23:22 -0500
Message-ID: <20060310162322.GB7004@spearce.org>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk> <20060227222600.GA11797@spearce.org> <tnx1wxmig75.fsf@arm.com> <20060301145105.GB3313@spearce.org> <b0943d9e0603010708l72cb14d1w@mail.gmail.com> <20060301155043.GA3706@spearce.org> <b0943d9e0603091400o2cd0291h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 17:24:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHkOp-0003pu-6M
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 17:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWCJQX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 11:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbWCJQX2
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 11:23:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:16098 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751787AbWCJQX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 11:23:27 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FHkOd-00055j-58; Fri, 10 Mar 2006 11:23:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 195F320FBAC; Fri, 10 Mar 2006 11:23:22 -0500 (EST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0603091400o2cd0291h@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17479>

Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 01/03/06, Shawn Pearce <spearce@spearce.org> wrote:
> > Speaking of making StGIT faster: earlier we were talking about how
> > git-diff|git-apply is faster than a 3 way git-read-tree on large
> > merges when there are many structural changes in the tree due to
> > the smaller number of process spawns required.
> >
> > You might want to take a look at pg--merge-all: This is sort of based
> > on git-merge-recursive, but I've gotten it down to just a handful
> > of process spawns, aside from the stupidity of git-checkout-index.
> 
> Trying to implement this, I've just noticed that git-read-tree has a
> --aggressive option which takes care of the file removals. Adding this
> option lowered the pushing time in StGIT from ~2 min to under 2
> seconds (merges between 2.6.14 and the latest kernel). There's
> probably no need to deal with file removals in pg--merge-all anymore.


Thanks for the heads up.  I'll have to add that in.  In case you
didn't notice the list traffic I have added a --stage=all switch to
git-checkout-index to grab into temporary files all unmerged stages.

I'm still working on integrating that into pg--merge-all but the
idea is to save on the fork/exec of git-unpack-file when I get into
the diff portion of the merge process.  At least on Cygwin (a place
where I'm really using pg) it will save time as the forks are so
expensive there.  Linux users may not see any improvement from it.

I also added --stdin to git-checkout-index but pg--merge-all is
still using xargs.  I just haven't had time to convert it over and
push it up to my public repo.  Hopefully I'll get both of those
done this weekend.

I've started to get busy with an Eclipse plugin for GIT so my work
with pg is likely going to slow down a little (besides its doing
most of what I need at this point).  But the next thing I was going
to try to add to GIT to boost pg's performance was to integrate
a diff library, so we aren't forking out a diff process for every
file we need to extract a diff for.

-- 
Shawn.
