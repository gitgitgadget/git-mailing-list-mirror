Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C409C433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 09:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09FC8610E6
	for <git@archiver.kernel.org>; Sat, 15 May 2021 09:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhEOJUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 05:20:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:55406 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230448AbhEOJUf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 05:20:35 -0400
Received: (qmail 23335 invoked by uid 109); 15 May 2021 09:19:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 May 2021 09:19:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8234 invoked by uid 111); 15 May 2021 09:19:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 May 2021 05:19:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 May 2021 05:19:21 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t: avoid sed-based chain-linting in some expensive cases
Message-ID: <YJ+SGfD7kPEW6ysn@coredump.intra.peff.net>
References: <YJzGcZpZ+E9R0gYd@coredump.intra.peff.net>
 <CAN0heSp3mXQeqeC_Zd==bBoJCCWe-NzJsomuUf6MTxy7+WZ1wA@mail.gmail.com>
 <YJ4PHbVoQ8+ubfBK@coredump.intra.peff.net>
 <CAN0heSrjPJG_OGyV2dt9bOfkd07He=kBUKQ-+w5JXNae+YH7qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrjPJG_OGyV2dt9bOfkd07He=kBUKQ-+w5JXNae+YH7qg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 14, 2021 at 10:52:35AM +0200, Martin Ågren wrote:

> > Yeah, I suspect that would work in general. But it seems like even more
> > complexity (now you have a cache of "I linted this script at time X and
> > it was good" that has to be written). It does increase the possible
> > savings though (up to perhaps 100 or so seconds of parallel CPU in my
> > case).
> 
> Yeah, I thought about the cache. I guess it would be a list of
> known-good test script hashes / blob IDs. But what I actually meant was
> to check whether the mtime was way back in the past. It's not fool-proof
> though. You could have a network-mounted disk where the date is way off,
> or you could hack up the test script, wait for several weeks and *then*
> run it. ;)

Ah, I see. You'd set some date for "this is so old you've probably run
the linting on it by now". Yeah, that is less complex to implement. It
does feel awfully magical, though.

-Peff
