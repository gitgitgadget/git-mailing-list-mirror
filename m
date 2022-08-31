Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC063C0502C
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 15:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiHaPMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHaPMR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 11:12:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E49D3ECF
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 08:12:15 -0700 (PDT)
Received: (qmail 14901 invoked by uid 109); 31 Aug 2022 15:12:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 31 Aug 2022 15:12:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14300 invoked by uid 111); 31 Aug 2022 15:12:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Aug 2022 11:12:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Aug 2022 11:12:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
Message-ID: <Yw96ThG8yV4ULROj@coredump.intra.peff.net>
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
 <xmqqwnax438x.fsf@gitster.g>
 <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
 <xmqqfshl3pbp.fsf@gitster.g>
 <220825.86ilmg4mil.gmgdl@evledraar.gmail.com>
 <Ywh6v8oo3nRl/O5h@coredump.intra.peff.net>
 <xmqqczcnymtd.fsf@gitster.g>
 <220829.86k06r2v6z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220829.86k06r2v6z.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2022 at 12:29:09PM +0200, Ævar Arnfjörð Bjarmason wrote:

> My reading of this is that you're misimpression that unused.cocci and
> Jeff's UNUSED macro are two ways to the same end-goal, and that if we
> keep the macro we could lose the coccinelle rule.

Ah, I didn't think of that, but yeah, that would explain Junio's
position a bit more.

> But they're doing completely orthogonal checks, the unused.cocci is
> finding code that's *actually used* accordingn to the compiler, but which
> we know results in code that's functionally unused.

Right. They're two separate types of "unused", and they should actually
complement each other (e.g., if we drop an unused strbuf parameter, then
a calling function may find that it is now doing nothing but
init/release on the strbuf). So we'd want both.

-Peff
