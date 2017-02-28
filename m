Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B52201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbdB1UM3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:12:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:35900 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbdB1UM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:12:26 -0500
Received: (qmail 19223 invoked by uid 109); 28 Feb 2017 20:04:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 20:04:26 +0000
Received: (qmail 29580 invoked by uid 111); 28 Feb 2017 20:04:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 15:04:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 15:04:23 -0500
Date:   Tue, 28 Feb 2017 15:04:23 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Use time_t
Message-ID: <20170228200423.33dghyephxsmxrx6@sigill.intra.peff.net>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
 <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>
 <f6b57868-0173-48d9-86cb-79780f7e301b@web.de>
 <xmqqa896kuve.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa896kuve.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 10:55:49AM -0800, Junio C Hamano wrote:

> > Glibc will get a way to enable 64-bit time_t on 32-bit platforms
> > eventually
> > (https://sourceware.org/glibc/wiki/Y2038ProofnessDesign). Can
> > platforms that won't provide a 64-bit time_t by 2038 be actually used
> > at that point?  How would we get time information on them?  How would
> > a custom timestamp_t help us?
> 
> That's a sensible "wait, let's step back a bit".  I take it that you
> are saying "time_t is just fine", and I am inclined to agree.
> 
> Right now, they may be able to have future timestamps ranging to
> year 2100 and switching to time_t would limit their ability to
> express future time to 2038 but they would be able to express
> timestamp in the past to cover most of 20th century.  Given that
> these 32-bit time_t software platforms will die off before year 2038
> (either by underlying hardware getting obsolete, or software updated
> to handle 64-bit time_t), the (temporary) loss of 2038-2100 range
> would not be too big a deal to warrant additional complexity.

For what it's worth, I'm on board with just using time_t if it reduces
the overall complexity. I agree that the "loss" of far-future timestamp
handling is unlikely to matter between now and 2038, and those systems
will have to figure out their time_t problems by then. By actually using
time_t we get to piggy-back on their solution.

-Peff
