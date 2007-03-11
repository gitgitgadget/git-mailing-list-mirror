From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: use binary search in tree_content_remove
Date: Sun, 11 Mar 2007 16:19:12 -0400
Message-ID: <20070311201912.GA12457@spearce.org>
References: <<20070310191515.GA3416@coredump.intra.peff.net>> <20070310192131.GB3875@coredump.intra.peff.net> <20070310192304.GB3416@coredump.intra.peff.net> <20070310194012.GA5126@coredump.intra.peff.net> <20070311033833.GB10781@spearce.org> <20070311163412.GB7110@coredump.intra.peff.net> <20070311165432.GA13555@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 21:19:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQUVo-0002TY-Kk
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 21:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbXCKUTU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 16:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbXCKUTU
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 16:19:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49007 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbXCKUTT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 16:19:19 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQUVF-0002QT-Cz; Sun, 11 Mar 2007 16:18:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5162420FBAE; Sun, 11 Mar 2007 16:19:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070311165432.GA13555@coredump.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41972>

Jeff King <peff@peff.net> wrote:
> On Sun, Mar 11, 2007 at 12:34:13PM -0400, Jeff King wrote:
> 
> > > I'm plastering over the problem by resorting a tree strictly by
> > > name after it has been written out and the deleted entries have
> > > been filtered out.
> > I wonder if we could make this a bit cleaner by actually using the git
> > sort in the first place. I will take a look...
> 
> Hrm, it's not that hard to pass the mode around and use
> base_name_compare, but I don't think that's enough. Any time we turn an
> entry into a tree, we'll have to resort. I think your patch is simpler
> and less error prone.

Yes, but it gets worse.  We delete an entry by setting the mode to
0 in version 1, but leaving the entry in the tree so that the entry
will show up in version 0 during delta generation.

So what happens if we delete the tree entry, then modify it in
the same commit?  We can't find it if we are searching with mode
included.

Sidenote: I have the same sorting problems in jgit.  It all comes
down to how annoying the tree format is, in that entries are sorted
by both name and mode, but only name makes the entry be unique.

Right now I'm not sure how to resolve this, short of the bandaid
patch I put onto the end of your series.   :-(

-- 
Shawn.
