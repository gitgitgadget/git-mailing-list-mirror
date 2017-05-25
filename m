Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0423320A04
	for <e@80x24.org>; Thu, 25 May 2017 18:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936618AbdEYSEN (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 14:04:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:57997 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762237AbdEYSEM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 14:04:12 -0400
Received: (qmail 19396 invoked by uid 109); 25 May 2017 18:04:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 May 2017 18:04:09 +0000
Received: (qmail 21902 invoked by uid 111); 25 May 2017 18:04:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 May 2017 14:04:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 May 2017 14:04:07 -0400
Date:   Thu, 25 May 2017 14:04:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tyler Brazier <tylerbrazier@gmail.com>, git@vger.kernel.org
Subject: Re: `pull --rebase --autostash` fails when fast forward in dirty repo
Message-ID: <20170525180407.ni2oed5wk3qsd2ch@sigill.intra.peff.net>
References: <CAAZatrCaoB7EXVrCvC9RKmO02G5xcp8GPBaJefHfv7zAXVpL3Q@mail.gmail.com>
 <20170523131231.zqjkymypbilv6tyf@sigill.intra.peff.net>
 <xmqqa863jiyf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa863jiyf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 07:40:08AM +0900, Junio C Hamano wrote:

> > But I notice on the run_merge() code path that we do still invoke
> > git-merge.
> 
> ... wouldn't that what we want even when the merge happens to be a
> fast-forward one?  I am not sure what you meant by this, but...

I just meant that if the point of the optimization was to avoid invoking
git-rebase (because it's slow), then we're still not optimizing out a
process. It only helps at all because "rebase" (being a shell script)
may be slower to start and realize it's a fast-forward than "merge".

But once that is no longer true of git-rebase, then there is no purpose
to the optimization.

> > And rebase has been getting faster as it is moved to C code
> > itself. So is this optimization even worth doing anymore?
> 
> ...that might be something worth thinking about---my gut feeling
> tells me something but we should go by a measurement, not by gut
> feeling of a random somebody.

Yeah, I'd agree. I had the impression the original change was motivated
by gut feeling.

-Peff
