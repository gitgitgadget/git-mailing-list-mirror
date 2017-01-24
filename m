Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00EF1F437
	for <e@80x24.org>; Tue, 24 Jan 2017 20:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750759AbdAXUjw (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 15:39:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:44057 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbdAXUjw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 15:39:52 -0500
Received: (qmail 3344 invoked by uid 109); 24 Jan 2017 20:39:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 20:39:51 +0000
Received: (qmail 5009 invoked by uid 111); 24 Jan 2017 20:39:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 15:39:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jan 2017 15:39:49 -0500
Date:   Tue, 24 Jan 2017 15:39:49 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [DEMO][PATCH v2 6/5] compat: add a qsort_s() implementation
 based on GNU's qsort_r(1)
Message-ID: <20170124203949.46lbmiyj26xx4hrk@sigill.intra.peff.net>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
 <9f8b564d-ec9f-abc9-77f6-aa84c6e78b7a@web.de>
 <xmqq60l5sihz.fsf@gitster.mtv.corp.google.com>
 <4e416167-2a33-0943-5738-79b4da5f2c11@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e416167-2a33-0943-5738-79b4da5f2c11@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 07:00:03PM +0100, René Scharfe wrote:

> > I do worry about having to support more implementations in the
> > future that have different function signature for the comparison
> > callbacks, which will make things ugly, but this addition alone
> > doesn't look too bad to me.
> 
> It is unfair of me to show a 5% speedup and then recommend to not
> include it. ;-)  That difference won't be measurable in real use cases
> and the patch is not necessary.  This patch is simple, but the overall
> complexity (incl. #ifdefs etc.) will be lower without it.

I care less about squeezing out the last few percent performance and
more that somebody libc qsort_r() might offer some other improvement.
For instance, it could sort in-place to lower memory use for some cases,
or do some clever thing that gives more than a few percent in the real
world (something like TimSort).

I don't know to what degree we should care about that.

> But here's another one, with even higher performance and with an even
> bigger recommendation to not include it! :)  It veers off into another
> direction: Parallel execution.  It requires thread-safe comparison
> functions, which might surprise callers.  The value 1000 for the minimum
> number of items before threading kicks in is just a guess, not based on
> measurements.  So it's quite raw -- and I'm not sure why it's still a
> bit slower than sort(1).

Fun, but probably insane for our not-very-threadsafe code base. :)

-Peff
