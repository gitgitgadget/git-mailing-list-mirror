From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] "-x" tracing option for tests
Date: Tue, 14 Oct 2014 09:44:15 -0400
Message-ID: <20141014134415.GA20675@peff.net>
References: <20141010060636.GA15057@peff.net>
 <xmqqd29v4yl1.fsf@gitster.dls.corp.google.com>
 <20141013210729.GA15969@peff.net>
 <543CE44E.5050009@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 14 15:44:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe2Op-0004rA-UY
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 15:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbaJNNoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 09:44:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:58310 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755316AbaJNNoT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 09:44:19 -0400
Received: (qmail 11715 invoked by uid 102); 14 Oct 2014 13:44:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Oct 2014 08:44:19 -0500
Received: (qmail 16041 invoked by uid 107); 14 Oct 2014 13:44:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Oct 2014 09:44:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Oct 2014 09:44:15 -0400
Content-Disposition: inline
In-Reply-To: <543CE44E.5050009@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 14, 2014 at 10:52:30AM +0200, Michael Haggerty wrote:

> >> Is your plan to reroll the prune-mtime stuff on top of these?  The
> >> additional safety those patches would give us is valuable and they
> >> are pretty straight-forward---I was hoping to have them in the 2.2
> >> release.
> > 
> > Yes, I've delayed while thinking about the issues that Michael raised.
> > There are basically two paths I see:
> > 
> >   1. These do not solve all problems/races, but are a solid base and
> >      sensible path forward for further changes which we can worry about
> >      later.
> > 
> >   2. There is a better way to provide prune safety, and these patches
> >      will get in the way of doing that.
> > 
> > I wanted to make sure we are on path (1) and not path (2). :)
> 
> FWIW I think we are on path (1).

Good. :)

I was preparing this to re-send, but I realized there is one snag. I
mentioned that we should probably be ignoring already-broken links from
recent objects to missing objects. For the traversal in pack-objects, we
can use revs->ignore_missing_links for this. But for the one in
git-prune itself, we use mark_reachable, which does not respect that
option.

I think mark_reachable's traversal is essentially the same as the one in
list-objects.c, and the two can be merged. I'll look into that, but I
ran out of time for it tonight (er, this morning. Oops).

-Peff
