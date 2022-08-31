Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A571ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 15:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiHaPYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiHaPYN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 11:24:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49E2D87E2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 08:24:12 -0700 (PDT)
Received: (qmail 14927 invoked by uid 109); 31 Aug 2022 15:24:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 31 Aug 2022 15:24:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14436 invoked by uid 111); 31 Aug 2022 15:24:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Aug 2022 11:24:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Aug 2022 11:24:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
Message-ID: <Yw99GwZ/MVaK9D0b@coredump.intra.peff.net>
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
 <xmqqwnax438x.fsf@gitster.g>
 <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
 <xmqqfshl3pbp.fsf@gitster.g>
 <220825.86ilmg4mil.gmgdl@evledraar.gmail.com>
 <Ywh6v8oo3nRl/O5h@coredump.intra.peff.net>
 <xmqqczcnymtd.fsf@gitster.g>
 <20220831084403.GA13663@szeder.dev>
 <220831.867d2oa95p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220831.867d2oa95p.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2022 at 02:13:51PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Removing coccinelle rules because we're seeing slowness somewhere seems
> particularly short-sighted to me.
> 
> Maybe we do run into intractable problems somewhere with it being slow,
> and we'd also like to cater to more "interactive" use.

Agreed. I'm not wild about how long it takes to run either, but if it's
producing useful results, it seems worth it to pay the CPU (and I think
unused.cocci did find some useful results already). There's a point at
which the CPU use becomes intractable, but I don't think we're there
yet.

> There's nothing in unused.cocci that we either aren't running into
> elsewhere, or wouldn't run into if we had 10x the coccinelle rules we
> have now (which I think would be a good direction, we should rely on it
> more heavily).

From past experience, I suspect the "<... ...>" operator is what's
expensive. I don't see an easy way of avoiding it here, though.

I'm more skeptical on more coccinelle in general, just because I've
spent so many hours fighting with it for both output and performance
reasons. But if somebody else is willing to do that work, I'm OK with
it. I have often wondered if our rules are sufficiently simple that
libclang plus some light scripting might get us similar results with
less hassle. But maybe that's a rabbit hole.

-Peff
