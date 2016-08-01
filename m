Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 283691F855
	for <e@80x24.org>; Mon,  1 Aug 2016 22:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbcHAWBA (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 18:01:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:52917 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752000AbcHAWA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 18:00:57 -0400
Received: (qmail 20255 invoked by uid 102); 1 Aug 2016 22:00:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 18:00:58 -0400
Received: (qmail 18799 invoked by uid 107); 1 Aug 2016 22:01:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 18:01:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 18:00:54 -0400
Date:	Mon, 1 Aug 2016 18:00:54 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Paul Tan <pyokagan@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] reset cached ident date before creating objects
Message-ID: <20160801220054.jita2awuaoebjhhp@sigill.intra.peff.net>
References: <CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
 <20160729155012.GA29773@sigill.intra.peff.net>
 <xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
 <20160729180517.GA14953@sigill.intra.peff.net>
 <CACRoPnS2kDRLiY8KX3K4Havh7d1GWy3mUXSiYCzw45BznuwYeA@mail.gmail.com>
 <20160730024135.oaqtjpo5l2e3dam2@sigill.intra.peff.net>
 <xmqqbn1cl6qv.fsf@gitster.mtv.corp.google.com>
 <20160801180047.sgzqgh7pvp2qzwug@sigill.intra.peff.net>
 <20160801193659.hag2yax2rniczkbo@sigill.intra.peff.net>
 <xmqqinvkgno8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinvkgno8.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 02:54:47PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I also didn't go looking for other spots which might want similar
> > treatment. Junio mentioned that the sequencer code still uses an
> > external commit process, so cherry-pick/revert are OK. git-fast-import
> > creates a stream of commits, but already deals with this issue in a
> > separate way. And I couldn't think of other programs that want to make a
> > string of commits.
> 
> Thanks.  I wonder if do_commit() may be a more appropriate place to
> reset this, but the difference only would matter in "am --resolved",
> and a call to do_commit() it has will always be the first commit in
> the process, so there would not be anything to clear, which would in
> turn mean that it would not make any difference.

Yeah, you may be right. I didn't actually find that spot. I was focused
on the looping aspect. And seeing how complex the loop was, my thought
was to just put it at the top, so we know it happens once per iteration.
But I think do_commit() is a reasonble spot, too (as long as it comes
before the call to fmt_ident(), of course).

-Peff
