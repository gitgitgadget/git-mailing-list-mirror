From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Understanding version 4 packs
Date: Sun, 25 Mar 2007 16:31:41 -0400
Message-ID: <20070325203141.GA12376@spearce.org>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk> <alpine.LFD.0.83.0703241913110.18328@xanadu.home> <20070325083530.GA25523@bohr.gbar.dtu.dk> <20070325091806.GH25863@spearce.org> <Pine.LNX.4.64.0703251004580.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Eriksen <s022018@student.dtu.dk>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 25 22:31:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVZNa-0001xD-Ex
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 22:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbXCYUbv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 16:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbXCYUbv
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 16:31:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59781 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbXCYUbu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 16:31:50 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HVZNG-0008Fi-Ll; Sun, 25 Mar 2007 16:31:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5D37F20FBAE; Sun, 25 Mar 2007 16:31:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703251004580.6730@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43062>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sun, 25 Mar 2007, Shawn O. Pearce wrote:
> > >
> > > What happens to the paths, that do not have a correponding entry in the
> > > path name table, because they are not among the 65535 most frequent
> > > paths in the pack?
> > 
> > They don't appear in the table.  And any tree that uses them is
> > forced to use the "legacy" OBJ_TREE encoding.  Which is what we
> > have now in pack v2, and in loose objects.
> 
> Would it hurt too much to just make it four bytes, and avoid that issue?
> 
> Special cases - and *especially* special cases that are hard to trigger in 
> the first place - equal bugs. And bugs are much much worse than trying to 
> save a little bit of space.

Worth exploring.  When I get back to rebasing that topic onto
Junio's tree I'll try a 4 byte index and see what kind of damage
it does on space on large projects (Mozilla, linux-2.6, Eclipse).
You may be right, an 8 byte record may just be worth the cost.
 
> > The author_time field is not present if flags & 128 is true.
> > If flags & 128 is false, its present, and uses the same encoding
> > as commit_time.  Why is this field optional?  Because its not
> > uncommon for it to match commit_time!  ;-)
> 
> If the author time is the same as the commit time, most of the time the 
> author is the same as the committer too, no? So the field should be 
> conditional not for the author_time, but for the combination, no?

Excellent observation.  I'll make that change at the same time that I
fix the meaning of flags & 128 to mean "more data follows".  Thanks!

-- 
Shawn.
