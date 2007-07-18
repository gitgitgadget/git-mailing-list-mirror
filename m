From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] Add git-rewrite-commits
Date: Wed, 18 Jul 2007 12:02:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707181153200.14781@racer.site>
References: <11842671631744-git-send-email-skimo@liacs.nl>
 <11842671631635-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0707141140510.14781@racer.site>
 <20070715144435.GH999MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707160054340.14781@racer.site> <20070716102407.GL999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Wed Jul 18 13:03:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB7JP-0000qF-H5
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 13:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972AbXGRLDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 07:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755990AbXGRLDP
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 07:03:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:40906 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755794AbXGRLDO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 07:03:14 -0400
Received: (qmail invoked by alias); 18 Jul 2007 11:03:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 18 Jul 2007 13:03:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lYTo9xEKl8ZdsxARaYEX9F5Cp/r++WHZArioBsh
	GHTTZ70ly25w+3
X-X-Sender: gene099@racer.site
In-Reply-To: <20070716102407.GL999MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52849>

Hi,

On Mon, 16 Jul 2007, Sven Verdoolaege wrote:

> On Mon, Jul 16, 2007 at 01:38:11AM +0100, Johannes Schindelin wrote:
> > On Sun, 15 Jul 2007, Sven Verdoolaege wrote:
> > > > > +	if (path_pruning &&
> > > > > +	    !(commit->object.flags & (TREECHANGE | UNINTERESTING)))
> > > > > +		return 1;
> > > > 
> > > > Why only with "path_pruning"?  Ah yes.  Because otherwise, you would 
> > > > assume "A" in "A..B" to be pruned.
> > > 
> > > TREECHANGE is only set when path pruning is in effect.
> > > If I didn't check for path_pruning, then all commits would be
> > > considered to have been pruned.  (Or am I missing something?
> > > Honestly, I found all that TREECHANGE stuff difficult to follow.)
> > 
> > AFAICT TREECHANGE means that parents were rewritten.
> 
> I think you'll find that if all commits touch a path in the
> path specifiers then all commits will have TREECHANGE set and
> so no parents will be rewritten.

The code suggests otherwise.

But I really have to wonder: why do you play games with TREECHANGE?  I had 
the impression that commit->parents is set appropriately by the revision 
walker, and that you do not have to do _anything_ for that to work.

Maybe the "--grep" thing does not yet.  But then you should fix it in 
revision.c.  Not in builtin-rewrite-commits.c

> > > revision.c itself is also riddled with "prune_fn && ".
> > > Wouldn't it make sense to invert the meaning of this bit and call
> > > it, say, PRUNED, so that the default is off and you would only
> > > have to check if the bit was set ?
> > 
> > You meant the TREECHANGE bit?  No.
> 
> Yes.  Why?

Why invert the meaning of a perfectly fine bit?  Because you can?  It is 
working right now, and it is not even a buglet, so what is there to fix?

> > BTW what do you plan to do about my objection to UNINTERESTING, given 
> > the example "git rewrite-commits A..B x/y"?
> 
> That was based on an apparent misunderstanding of my code
> that I tried to address above.  I did not intend to do what
> you claim I do and a quick test confirms that my code does
> indeed not to what you claim it does.
> 
> More specifically, the history will not be cut off at A
> because A is marked UNINTERESTING and is therefore not considered
> to have been pruned.

Why do you test for TREECHANGE | UNINTERESTING then?

> A commit is considered pruned if it was either explicitly marked
> as such or if TREECHANGE is not set, but the later check (in is_pruned)
> is only done on commits that were checked for tree changes.

I don't understand.  What do you mean by "a commit is pruned"?  Does it 
mean that this commit was left out from the revision walk?  What does that 
have to do with TREECHANGE, which means that the parents set was modified?

Ciao,
Dscho
