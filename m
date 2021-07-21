Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17B6C07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 08:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83296100C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 08:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbhGUH2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 03:28:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:55848 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235919AbhGUH2C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 03:28:02 -0400
Received: (qmail 7195 invoked by uid 109); 21 Jul 2021 08:08:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 08:08:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32193 invoked by uid 111); 21 Jul 2021 08:08:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 04:08:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 04:08:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 6/6] commit-graph: show usage on "commit-graph
 [write|verify] garbage"
Message-ID: <YPfWA4uA6OTKeOd9@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
 <patch-6.6-5c1694e071e-20210720T113707Z-avarab@gmail.com>
 <20210720174739.GA2025@szeder.dev>
 <20210720175530.GA23408@szeder.dev>
 <YPcU3LSpa/r5nFCP@nand.local>
 <87lf60vfyn.fsf@evledraar.gmail.com>
 <YPdEeBGi3RVrB/fu@nand.local>
 <87im14unfd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87im14unfd.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 09:26:38AM +0200, Ævar Arnfjörð Bjarmason wrote:

> <digression>
> 
> I do think in general this recent proliferation of t/helper over new
> plumbing built-ins has sent git a bit in the wrong direction.
> 
> E.g. I think the likes of t/helper/test-pkt-line.c should really be a
> plumbing tool, the same goes for many (but not all) the test tool, we
> could just document them as being "unstable plumbing" or whatever.

FWIW, I agree with you here. These kind of "inspection" tools are handy
when you are debugging something. Building a copy of test-tool on a
production system is only a mild inconvenience for me, but not being
able to ask a user things like "what does git pack-bitmap --dump
.git/objects/pack*.bitmap say" is occasionally quite annoying.

The flip side is that we expect the overall quality of user-visible
tools to be a bit higher, and we're generally on the hook to keep
supporting them. Maybe that's solvable with documentation. I dunno.

> But I think I've been losing that argument recently, e.g. after [1]
> (which I argued we should put into git-ls-files) even things like git's
> basic idea of the state of the index are exposed in some helpers, but
> not corresponding plumbing.

Yeah. I wish "ls-files --debug" showed more of the extension data, for
example.

> Anyway, even if we assume that's an argument that would carry the day in
> general I'd find it hard to justify git-env--helper being a thing that
> should be exposed to users or post-"make install", it's purely for the
> use of our own test suite.

Yeah, I'd agree with that. The most valuable helpers to me are the ones
that help us understand what Git is seeing, or what's in a binary file
format. Obscure-case "functional" helpers are less likely to be
generally useful.

-Peff
