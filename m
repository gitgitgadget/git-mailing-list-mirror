From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Merge strategy 'applyreject'
Date: Wed, 13 Sep 2006 17:38:20 -0400
Message-ID: <20060913213820.GC30782@spearce.org>
References: <20060913210817.GA30782@spearce.org> <ee9spf$h98$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 23:38:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNcR9-0005fj-A1
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 23:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWIMViY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 17:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWIMViY
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 17:38:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59523 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751211AbWIMViX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 17:38:23 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GNcQv-0006pL-FM; Wed, 13 Sep 2006 17:38:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6CAA820E49A; Wed, 13 Sep 2006 17:38:20 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ee9spf$h98$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26954>

Jakub Narebski <jnareb@gmail.com> wrote:
> > ---
> >  .gitignore               |    1 +
> >  Makefile                 |    1 +
> >  git-merge-applyreject.sh |   26 ++++++++++++++++++++++++++
> >  git-merge.sh             |    2 +-
> >  4 files changed, 29 insertions(+), 1 deletions(-)
> 
> But where documentation (Documentation/merge-strategies.txt)? 

If its interesting I'll document it.  I just threw it together and
tossed it out there to see what others thought of the general idea.
 
> > +#!/bin/sh
> > +#
> > +# Simple merge strategy which produces reject files on failed merges.
> > +# Only handles two heads and one merge base, thus the command line
> > +# parameters must be:  base -- head1 head2
> 
> We can always get the base using git-merge-base, so the arguments could
> be either "base -- head1 head2", or just "head1 head2".

Actually the merge driver (git-merge.sh) feeds us the arguments like
that.
 
> Does "git pull -s applyreject . head2" works (when on head1) with
> this patch? Does the unified driver git-merge works correctly?

Yes.  That's how I tested it.

> > +git-diff --binary -M $base $incoming \
> > +     | git-apply --index --reject --verbose
> 
> --index or --cached?

I believe that --index is correct.  I want to patch the file in
the working directory, not the one that's currently in the index.
I also want to update the index if the patch applied cleanly.

-- 
Shawn.
