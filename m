Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A170CC2BBD4
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A99123A5B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgLRFnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:43:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:37360 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbgLRFnK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:43:10 -0500
Received: (qmail 10056 invoked by uid 109); 18 Dec 2020 05:42:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Dec 2020 05:42:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11287 invoked by uid 111); 18 Dec 2020 05:42:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Dec 2020 00:42:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Dec 2020 00:42:29 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Sangeeta <sangunb09@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t/perf: fix test_export() failure with BSD `sed`
Message-ID: <X9xBRXW7/tXsqLT5@coredump.intra.peff.net>
References: <20201216073907.62591-1-sunshine@sunshineco.com>
 <xmqq5z514lj5.fsf@gitster.c.googlers.com>
 <CAPig+cR+4Wh4Sgk6UhUML4SHqaQsvYmw_77ih+oec2YmqQJCCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cR+4Wh4Sgk6UhUML4SHqaQsvYmw_77ih+oec2YmqQJCCg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 02:29:26PM -0500, Eric Sunshine wrote:

> > Oh, does anybody need to clear test_export_ to an empty string (or
> > unset it), by the way?
> 
> Perhaps a test_unexport() might be handy in the distant future, but
> presently there is only a single call to test_export() in the entire
> suite, so it's probably not worth worrying about now.

I actually wonder if we could drop test_export entirely. I assume you
mean the call in p0001. It is inside a test_expect_success block, where
we don't need to do anything fancier than just "export". It is already
running in the main script's environment, just like a normal test. If it
were in a test_perf, then we would need to take special care to get it
back into the main script.

There are some calls in p0000 like that, but they are really about
testing test_export itself.

-Peff
