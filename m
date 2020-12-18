Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC91C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2F320793
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbgLRGUC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 01:20:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:37494 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732650AbgLRGUC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 01:20:02 -0500
Received: (qmail 10497 invoked by uid 109); 18 Dec 2020 06:19:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Dec 2020 06:19:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11861 invoked by uid 111); 18 Dec 2020 06:19:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Dec 2020 01:19:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Dec 2020 01:19:20 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
Message-ID: <X9xJ6BHM9VY0/yLs@coredump.intra.peff.net>
References: <20201211210508.2337494-1-jonathantanmy@google.com>
 <87blewwoil.fsf@evledraar.gmail.com>
 <xmqqim94e4et.fsf@gitster.c.googlers.com>
 <878s9zx2ul.fsf@evledraar.gmail.com>
 <X9ghqMo5WS8FrBEz@coredump.intra.peff.net>
 <xmqq8s9zaica.fsf@gitster.c.googlers.com>
 <X9g9Y9LWc0NtHlQn@coredump.intra.peff.net>
 <xmqq7dpi5tvl.fsf@gitster.c.googlers.com>
 <X9pUc2HXUr3+WHbR@coredump.intra.peff.net>
 <xmqqft4531xl.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqft4531xl.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 12:56:22PM -0800, Junio C Hamano wrote:

> > I think:
> >
> >   git checkout --guess origin
> >
> > would make sense to dereference origin/HEAD to "foo", as if we had said
> > "git checkout foo". That's the explicit part that seems safe. My
> > question is whether:
> >
> >   git checkout origin
> >
> > should likewise do so.
> 
> I see.  I think "--guess" is by default true, so unless you have
> checkout.guess=false configured, my answer to the above question is
> yes.

Yes, I agree with the current definition of "--guess", the two would be
the same. I'm just concerned that people will be unhappy with changing
the behavior of the latter, so everything else (the "tri-state --guess"
thing) is an attempt to band-aid over that.

If we decide it's not a concern worth addressing, then I agree the two
should behave the same. I'm just not convinced it won't annoy people who
are used to how "git checkout" works now with non-local branches.

-Peff
