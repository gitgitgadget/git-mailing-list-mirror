Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CF4C388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 20:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F5C22201
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 20:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgKUUXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 15:23:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:37560 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbgKUUXM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 15:23:12 -0500
Received: (qmail 12603 invoked by uid 109); 21 Nov 2020 20:23:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 21 Nov 2020 20:23:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19791 invoked by uid 111); 21 Nov 2020 20:23:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Nov 2020 15:23:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 21 Nov 2020 15:23:10 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 3/4] grep: simplify color setup
Message-ID: <20201121202310.GA972561@coredump.intra.peff.net>
References: <cover.1605972564.git.martin.agren@gmail.com>
 <d6e43bc540bc682bb46d54e579a7101d0d2c462d.1605972564.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6e43bc540bc682bb46d54e579a7101d0d2c462d.1605972564.git.martin.agren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 21, 2020 at 07:31:09PM +0100, Martin Ågren wrote:

> The previous commit left us with only one user of the one-line wrapper
> `color_set()`. We could inline it, but note how we're `xsnprintf()`-ing
> all the entries in one array into another array of the same type. We
> might as well just `memcpy()` everything into place.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  Cc-ing Peff, who initially introduced this helper. After having inlined
>  the function into the for loop, it seemed better to just copy the whole
>  array. Happy to hear arguments against.

No, this is way better than the existing code. I introduced it to get
away from strcpy(), but this is better still. But...

>  Come to think of it, I suppose we could copy the whole struct and not
>  just the color array. Hmmm...

Yes, this seems even better. If our goal is just to start our new
grep_opt the same as grep_defaults, then a single-line struct copy
(whether through assignment or memcpy) is even clearer and more
maintainable.

-Peff
