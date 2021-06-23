Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21755C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07F460249
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFWWX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:23:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:58798 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhFWWX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 18:23:28 -0400
Received: (qmail 7837 invoked by uid 109); 23 Jun 2021 22:20:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Jun 2021 22:20:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7231 invoked by uid 111); 23 Jun 2021 22:21:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jun 2021 18:21:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Jun 2021 18:21:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Message-ID: <YNOz1GD/8+CaUvRz@coredump.intra.peff.net>
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <YNIBRboFiCRAq3aA@nand.local>
 <8735t93h0u.fsf@evledraar.gmail.com>
 <YNI3WVu5SK7pHI7T@coredump.intra.peff.net>
 <87r1gs1hfx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1gs1hfx.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 09:54:06PM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> > Just to be clear, I would be happy to drop the "oops, the tests barf if
> > you recompile halfway through" feature away if it made things more
> > robust overall (i.e., if we always did an atomic rename-into-place). I
> > just consider it the fact that we do clobber to be an accidental feature
> > that is not really worth "fixing". But if we care about "oops, make was
> > interrupted and now you have a stale build artifact with a bogus
> > timestamp" type of robustness, and "the tests barf" goes away as a side
> > effect, I won't complain.
> 
> ..and "this behavior is really annoying on one platform we target, and
> the fix is rather trivial".

Yeah, that's a fine reason, too. I'm not entirely clear on what the
problem is, though, or why this is the best solution (I expect you
probably explained it in an earlier thread/series, but if so it went in
one ear and out the other on my end).

> > That's a pretty big departure from our current Makefile style, though.
> > And I don't feel like it buys us a lot. Having a pretty generic and
> > typical Makefile is nice for people coming to the project (I have
> > noticed that most people are not well versed in "make" arcana).
> 
> I still think just doing "&& mv $@+ $@" is the simplest in this case, we
> already have that in a dozen places in the Makefile, I wanted to add it
> to a dozen or so more.
> 
> It's a common pattern already, I'd think if anything applying it
> uniformly would make things easier to read, even if we didn't get more
> portability & the ability to run stuff concurrently when you have "make"
> active as bonus.

Yeah, and I'm OK with that direction, too.

-Peff
