From: Yann Dirson <ydirson@altern.org>
Subject: Re: using stgit/guilt for public branches
Date: Fri, 4 May 2007 23:37:41 +0200
Message-ID: <20070504213741.GC19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070425122048.GD1624@mellanox.co.il> <20070425191838.GA6267@filer.fsl.cs.sunysb.edu> <200704252337.05851.robin.rosenberg.lists@dewire.com> <20070503205836.GA19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070504052042.GA4829@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
	Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri May 04 23:38:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk5UN-0004LK-Hg
	for gcvg-git@gmane.org; Fri, 04 May 2007 23:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161584AbXEDViX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 17:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161590AbXEDViX
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 17:38:23 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:49893 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161584AbXEDViW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 17:38:22 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D51BB5F005;
	Fri,  4 May 2007 23:38:20 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 0994A1F15A; Fri,  4 May 2007 23:37:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070504052042.GA4829@mellanox.co.il>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46218>

On Fri, May 04, 2007 at 08:20:59AM +0300, Michael S. Tsirkin wrote:
> > Quoting Yann Dirson <ydirson@altern.org>:
> > Subject: Re: using stgit/guilt for public branches
> > 
> > On Wed, Apr 25, 2007 at 11:37:05PM +0200, Robin Rosenberg wrote:
> > > onsdag 25 april 2007 skrev Josef Sipek:
> > > > On Wed, Apr 25, 2007 at 03:20:49PM +0300, Michael S. Tsirkin wrote:
> > > [...]
> > > > > I am concerned that publishing a git branch managed by stg/guilt
> > > > > would present problems: it seems that every time patches are re-ordered,
> > > > > a patch is re-written or removed, or we update from upstream,
> > > > > everyone who pulls the tree branch will have a hard-to-resolve conflict.
> > > > > 
> > > > > Is that really a problem? If so, would it be possible to work around this
> > > > > somehow?
> > > > 
> > > > I thought about this problem a while back when I was trying to decide how to
> > > > manage the Unionfs git repository. I came to the conclusion, that there was
> > > > no clean way of doing this (at least not using guilt - I can't really speak
> > > > for stgit, as I don't know how it does things exactly).
> > > 
> > > StGit has the same problem. Publishing such a branch is only for viewing if
> > > you want to publish the tip, like the pu branch in the Git repo. You shouldn't
> > > merge from pu either.
> > 
> > You are right, in that what can be done with such branches is limited.
> > BUT you can safely "stg branch --create" off any remote stgit stack.
> > Then you can "stg rebase origin/master" to port your stack to the new
> > tip of the remote stack.
> 
> OK.
> What happens if someone clones the repo, then reorders patches,
> drops some of them, adds new patches in the middle of the stack?

You can't do that out of the box, since you don't get a real stack
when you clone it, you only get the refs.  You would need to uncommit
patches manually, and there will not be much support to help you.

Now you're forcing me to unveil my secret plans :)

1. it would be quite easy to reconstruct a full-fledged stack from
those refs, and since you get the remote patchlogs, we could also
fetch any former version of the patch that would be still available
(more work for "stg clone")

2. if noone beats me to doing that, I'll enhance patchlogs some day to
record branching in patchlogs (eg. from "stg branch --clone" or "stg
pick"), as well as merges (eg. from "stg sync")

Note that proper merging from patchlog history will require working at
the meta-diff (ie. "diffs of diffs of trees") level, just like proper
merging at tree-level requires working at the diff level.  I don't
think we have the tools for this yet, so we still have a long way to
go :)


Best regards,
-- 
Yann.
