From: Shawn Pearce <spearce@spearce.org>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Wed, 1 Mar 2006 10:50:43 -0500
Message-ID: <20060301155043.GA3706@spearce.org>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk> <20060227222600.GA11797@spearce.org> <tnx1wxmig75.fsf@arm.com> <20060301145105.GB3313@spearce.org> <b0943d9e0603010708l72cb14d1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 16:51:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FETbK-0000l1-Cz
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 16:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWCAPuu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 10:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWCAPuu
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 10:50:50 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:10473 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932402AbWCAPut (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 10:50:49 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FETb9-00005i-0k; Wed, 01 Mar 2006 10:50:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1E07220FBBF; Wed,  1 Mar 2006 10:50:43 -0500 (EST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0603010708l72cb14d1w@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16981>

Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 01/03/06, Shawn Pearce <spearce@spearce.org> wrote:
> > True.  The constant reapplication does really slow it down.  So does
> > grabbing the reverse patch and seeing if it applies backwards
> > cleanly.  Neither operation is fast, and neither is really going
> > to be fast.
> 
> I realised that, depending on the number of patches merged upstream,
> using this option can make StGIT faster. That's because when pushing a
> patch (without the --merged option), StGIT first tries a diff | apply
> followed by a three-way merge (even slower) if the former method
> fails. This means that for all the patches merged upstream, StGIT
> tries both methods since diff | apply fails anyway. With the --merged
> option, StGIT would only try the reverse-diff | apply and, if this
> succeeds, it will skip the normal push methods.

Speaking of making StGIT faster: earlier we were talking about how
git-diff|git-apply is faster than a 3 way git-read-tree on large
merges when there are many structural changes in the tree due to
the smaller number of process spawns required.

You might want to take a look at pg--merge-all: This is sort of based
on git-merge-recursive, but I've gotten it down to just a handful
of process spawns, aside from the stupidity of git-checkout-index.
(My recent git-checkout-index patches are working to correct that.)

-- 
Shawn.
