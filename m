Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626BAC433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 19:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9CE61205
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 19:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350418AbhITTWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 15:22:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:51068 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347703AbhITTUN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 15:20:13 -0400
Received: (qmail 2140 invoked by uid 109); 20 Sep 2021 19:18:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Sep 2021 19:18:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21811 invoked by uid 111); 20 Sep 2021 19:18:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 15:18:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 15:18:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 3/6] commit-graph: turn on commit-graph by default
Message-ID: <YUjekM1tscZJykzr@coredump.intra.peff.net>
References: <pull.292.v3.git.gitgitgadget@gmail.com>
 <pull.292.v4.git.gitgitgadget@gmail.com>
 <651e2d526b2a3f6c63c64cfe1f049eef94d39c07.1565721461.git.gitgitgadget@gmail.com>
 <xmqq8rzsdqlq.fsf@gitster.g>
 <YUfjIjgk2IwcJNI8@camp.crustytoothpaste.net>
 <8841729f-9310-c393-caa9-4b209909ea5d@gmail.com>
 <8735pzbbtk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735pzbbtk.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 03:30:38PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Thus the anti-pattern, yes set defaults for some members to -1, but not
> the entire struct. The only value we should memset a whole bag-of-stuff
> config struct to is 0, as that's the only sensible default & plays well
> with other C semantics.

FWIW, I agree. I had to scratch my head for a moment at why a memset of
"-1" would work at all on multi-byte types. I think it's better avoided
in the name of readability and obviousness, not to mention the trap it
leaves for items that don't sensibly initialize with it (like, say,
pointers).

As an aside, memset to 0 is _also_ undefined for pointers, but we long
ago decided not to care, as no real-world systems have a problem with
this.

-Peff
