From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Second parent for reverts
Date: Wed, 9 May 2007 16:22:24 -0400
Message-ID: <20070509202224.GG3141@spearce.org>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org> <Pine.LNX.4.64.0705092206540.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 09 22:22:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlsgG-0006Jk-3R
	for gcvg-git@gmane.org; Wed, 09 May 2007 22:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbXEIUWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 16:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754012AbXEIUWa
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 16:22:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33771 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbXEIUWa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 16:22:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hlsfx-0001dS-FQ; Wed, 09 May 2007 16:22:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 98AD820FBAE; Wed,  9 May 2007 16:22:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705092206540.4167@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46782>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 9 May 2007, Daniel Barkalow wrote:
> 
> > The discussion about having a header to specify, for a revert commit, 
> > what it reverts made me realize that this header *would* be useful, but 
> > that we don't need a *new* header for it. I think that the right method 
> > is to add the parent of the reverted commit as a second parent for the 
> > revert.
> 
> I am not so sure. In a sense, you are correct. But everybody who does "git 
> log --no-merges" would no longer see reverts. Which is somewhat incorrect.

Right.

I've actually done what Daniel just talked about doing in one of my
"production" repositories.  I did it by hand as a developer had
created a bad merge and accidentially reverted 800 files during
that merge.  80 or so commits later along a public non-rewinding
branch coworkers realized things weren't right, and asked me
to fix the mess.  As I wanted to save the blame data when I
reverted-the-revert I did what Daniel suggests.

But since the revert-the-revert wasn't really an interesting point
in history, and neither was the bad merge, I don't really care that
neither shows up with --no-merges.  The original bad merge was a
simple honest mistake made by a developer who was new to Git, and
was only caused because merge-recursive wasn't installed properly
on that system.


As Dscho says, most reverts are interesting points in time.  *Why*
a particular revert was done is important.

And so I have to disagree quite a bit with Daniel's idea, for exactly
that reason.  If I'm looking at a block of code in a file I want to
know why its there.  If blame tells me its a revert of something,
that tells me we tried another path and it didn't work out.  I might
be sitting here looking at this line because I'm thinking of redoing
whatever it was that wasn't good!

So that revert commit message better say why that thing didn't
work out.

If I really do care about the source of that line, I can always
re-run blame on the parent of the reverted commit (hence why ^
is so nice as a suffix on a commit-ish!) and examine the line again.

Hmm.  I should teach git-gui to parse out the revert message and
let you click into its parent.  Simple enough.  Maybe it will be
in 0.7.0.  Maybe it won't be.  ;-)

-- 
Shawn.
