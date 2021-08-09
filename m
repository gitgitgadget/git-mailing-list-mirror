Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23308C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 18:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B1161019
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 18:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhHISKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 14:10:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:42656 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhHISKg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 14:10:36 -0400
Received: (qmail 2050 invoked by uid 109); 9 Aug 2021 18:10:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Aug 2021 18:10:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1651 invoked by uid 111); 9 Aug 2021 18:10:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Aug 2021 14:10:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Aug 2021 14:10:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Re: [PATCH v2 0/3] detect-compiler: clang updates
Message-ID: <YRFvh34fzNdxLOPc@coredump.intra.peff.net>
References: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net>
 <20210806205235.988761-1-gitster@pobox.com>
 <87bl6aypke.fsf@evledraar.gmail.com>
 <YQ3suvJfspzRNPL9@coredump.intra.peff.net>
 <875ywiyn4y.fsf@evledraar.gmail.com>
 <YQ6VJW0AwkouDnDe@coredump.intra.peff.net>
 <8735rlz5r2.fsf@evledraar.gmail.com>
 <YQ6bTm6DxeJLhmeA@coredump.intra.peff.net>
 <87zgttxo3i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zgttxo3i.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 07, 2021 at 05:36:57PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Hmm, now I'm really confused, though. Is that really clang 12 (for which
> > there is no 12.0.5; 12.0.1 is the latest version, shipped in July)? Or
> > is it XCode 12, shipping with LLVM 11, according to the table in:
> >
> >   https://en.wikipedia.org/wiki/Xcode#Xcode_11.x_-_13.x_(since_SwiftUI_framework)
> >
> > (sorry, there are actually _two_ tables with that same anchor on the
> > page; the one you want is the second one, under "Toolchain versions").
> >
> > The distinction does not matter for our script (where we only care about
> > "clang4" and up). I guess the most relevant test would be to get XCode
> > 8.x and see what it says. I expect it to claim "clang 8.1.0" or similar,
> > but actually be clang-3. And therefore not support
> > -Wtautological-constant-out-of-range-compare.
> >
> > If we can't get easily get hold of such a platform, then maybe that is a
> > good indication that this conversation is too academic for now, and we
> > should wait until somebody wants to add a more recent version-specifier
> > to config.mak.dev. ;)
> 
> I think it's clang 12.0.5, and Apple just takes upstream versions and
> increments them, e.g. I found this:
> https://gist.github.com/yamaya/2924292
> 
> So you can presumably rely on it for having clang 12 features, and we'd
> only ever care about the clang_major...

From the reading I've done, I'm unconvinced that this is _actually_
clang 12, and they aren't simply doing funky things with the version
numbers. But since we lack an easy test of how the different versions
behave (even my suggested clang4 test turned out not to be robust!), it
probably doesn't matter much either way.

-Peff
