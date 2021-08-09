Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4661C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 18:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84CA60F02
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 18:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhHISJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 14:09:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:42644 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhHISJU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 14:09:20 -0400
Received: (qmail 2035 invoked by uid 109); 9 Aug 2021 18:08:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Aug 2021 18:08:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1628 invoked by uid 111); 9 Aug 2021 18:08:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Aug 2021 14:08:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Aug 2021 14:08:58 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] detect-compiler: clang updates
Message-ID: <YRFvOp+3kjfYdi0q@coredump.intra.peff.net>
References: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net>
 <20210806205235.988761-1-gitster@pobox.com>
 <87bl6aypke.fsf@evledraar.gmail.com>
 <YQ3suvJfspzRNPL9@coredump.intra.peff.net>
 <875ywiyn4y.fsf@evledraar.gmail.com>
 <YQ6VJW0AwkouDnDe@coredump.intra.peff.net>
 <8735rlz5r2.fsf@evledraar.gmail.com>
 <YQ6bTm6DxeJLhmeA@coredump.intra.peff.net>
 <CAPUEsph1ZqE9KtT7ooJEa=jURq+=cG78MXwPxahb7f0YXYHL7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEsph1ZqE9KtT7ooJEa=jURq+=cG78MXwPxahb7f0YXYHL7g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 07, 2021 at 05:30:39PM -0700, Carlo Arenas wrote:

> On Sat, Aug 7, 2021 at 7:40 AM Jeff King <peff@peff.net> wrote:
> > The distinction does not matter for our script (where we only care about
> > "clang4" and up). I guess the most relevant test would be to get XCode
> > 8.x and see what it says. I expect it to claim "clang 8.1.0" or similar,
> > but actually be clang-3. And therefore not support
> > -Wtautological-constant-out-of-range-compare.
> 
> uses Xcode 7.3 (based on clang 3.8) and either does support that flag
> or ignores it silently
> 
>   https://www.travis-ci.com/github/carenas/git/builds/234772346
> 
> the same was observed with Xcode 8
> 
> both error later and fail to build because of a valid (but harmless)
> -Wformat-extra-args warning that doesn't trigger in later versions

Thanks for testing. I think I was wrong that clang4 is the limit for
that option, though. It comes originally from:

  https://lore.kernel.org/git/20180317160832.GB15772@sigill.intra.peff.net/

where clang4 just happened to be the oldest thing I had access to at the
time, so we used that as a minimum. So probably all of our "clang4"
could really be "any clang" (but it is probably OK to leave it as-is).

-Peff
