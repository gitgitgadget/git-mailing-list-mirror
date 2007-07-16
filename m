From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 6/6] Add git-rewrite-commits
Date: Mon, 16 Jul 2007 12:24:07 +0200
Message-ID: <20070716102407.GL999MdfPADPa@greensroom.kotnet.org>
References: <11842671631744-git-send-email-skimo@liacs.nl>
 <11842671631635-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0707141140510.14781@racer.site>
 <20070715144435.GH999MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707160054340.14781@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 12:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IANkW-0003wy-58
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 12:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542AbXGPKYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 06:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755443AbXGPKYL
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 06:24:11 -0400
Received: from psmtp03.wxs.nl ([195.121.247.12]:51023 "EHLO psmtp03.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031AbXGPKYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 06:24:10 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp03.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JL900A6XOW7QY@psmtp03.wxs.nl> for git@vger.kernel.org; Mon,
 16 Jul 2007 12:24:08 +0200 (MEST)
Received: (qmail 2443 invoked by uid 500); Mon, 16 Jul 2007 10:24:07 +0000
In-reply-to: <Pine.LNX.4.64.0707160054340.14781@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52655>

On Mon, Jul 16, 2007 at 01:38:11AM +0100, Johannes Schindelin wrote:
> On Sun, 15 Jul 2007, Sven Verdoolaege wrote:
> > > > +	if (path_pruning &&
> > > > +	    !(commit->object.flags & (TREECHANGE | UNINTERESTING)))
> > > > +		return 1;
> > > 
> > > Why only with "path_pruning"?  Ah yes.  Because otherwise, you would 
> > > assume "A" in "A..B" to be pruned.
> > 
> > TREECHANGE is only set when path pruning is in effect.
> > If I didn't check for path_pruning, then all commits would be
> > considered to have been pruned.  (Or am I missing something?
> > Honestly, I found all that TREECHANGE stuff difficult to follow.)
> 
> AFAICT TREECHANGE means that parents were rewritten.

I think you'll find that if all commits touch a path in the
path specifiers then all commits will have TREECHANGE set and
so no parents will be rewritten.

> > revision.c itself is also riddled with "prune_fn && ".
> > Wouldn't it make sense to invert the meaning of this bit and call
> > it, say, PRUNED, so that the default is off and you would only
> > have to check if the bit was set ?
> 
> You meant the TREECHANGE bit?  No.

Yes.  Why?

> BTW what do you plan to do about my objection to UNINTERESTING, given the 
> example "git rewrite-commits A..B x/y"?

That was based on an apparent misunderstanding of my code
that I tried to address above.  I did not intend to do what
you claim I do and a quick test confirms that my code does
indeed not to what you claim it does.

More specifically, the history will not be cut off at A
because A is marked UNINTERESTING and is therefore not considered
to have been pruned.
A commit is considered pruned if it was either explicitly marked
as such or if TREECHANGE is not set, but the later check (in is_pruned)
is only done on commits that were checked for tree changes.

skimo
