Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0568EC54EE9
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 04:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiIKEvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 00:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiIKEvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 00:51:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EEC43E6E
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 21:51:14 -0700 (PDT)
Received: (qmail 18226 invoked by uid 109); 11 Sep 2022 04:51:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 11 Sep 2022 04:51:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31423 invoked by uid 111); 11 Sep 2022 04:51:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Sep 2022 00:51:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Sep 2022 00:51:12 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] plugging some list-objects-filter leaks
Message-ID: <Yx1pQKfmVZegmYzM@coredump.intra.peff.net>
References: <Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net>
 <15688f6a-4757-e201-9106-663899e35fec@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15688f6a-4757-e201-9106-663899e35fec@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 09, 2022 at 10:20:37AM -0400, Derrick Stolee wrote:

> > Of course we can drop the passing flag, but I figured it would probably
> > be an easy fix. Famous last words. It turned into quite a rabbit hole of
> > actual leaks (albeit small and bounded per process) and some
> > questionable memory ownership semantics.
> 
> Reading the patches, you make good arguments about the various trade-
> offs in these sticky places. I agree with you in all cases, mostly
> because the alternatives would not be any better unless we did a _lot_
> of work to rewrite a lot more code than these patches. Even then, the
> benefit is unclear.

Thanks for looking them over. I wondered if I was just being lazy and/or
cowardly in not teaching callers to initialize the filter struct
specifically (rather than memset to zero).

So of course I started looking at it, and of course it was way more
complicated than you'd imagine. So I have no regrets in drawing the line
where I did in this leak-plugging series.

But now that I did do it, it turned out to reveal other oddities in the
filter code! So I'll post that as a separate series on top. Even if we
don't go all the way with the cleanup, we should at least fix the
oddities.

> > Here's the series I came up with. I'm cc-ing Stolee as the last person
> > unfortunate enough to have touched this area. :)
> 
> Lucky me!

It's the gift that keeps on giving. Guess what you're about to get cc'd
on. ;)

-Peff
