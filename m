Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2CBC433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 10:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A782313E
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 10:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbhAOKEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 05:04:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:57100 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbhAOKEk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 05:04:40 -0500
Received: (qmail 32718 invoked by uid 109); 15 Jan 2021 10:04:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Jan 2021 10:04:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26190 invoked by uid 111); 15 Jan 2021 10:04:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Jan 2021 05:04:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Jan 2021 05:04:00 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/6] tests: add a "set -o pipefail" for a patched bash
Message-ID: <YAFokKRE6KDd6avN@coredump.intra.peff.net>
References: <20191115040909.GA21654@sigill.intra.peff.net>
 <20210114233515.31298-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114233515.31298-7-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 15, 2021 at 12:35:15AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Makes it useful for something like the git test suite. With vanilla
> bash and GIT_TEST_PIPEFAIL=true we'll fail 4 tests in my one-off test.
> 
> With my patched bash the only tests we need to skip are those that are
> explicitly testing that a piped command returned SIGPIPE.
> 
> As Jeff noted in [3] that count isn't reliable, as more will fail in a
> way that's hard to reproduce due to the racy nature of vanilla "set -o
> pipefail"

Yeah, the count is IMHO not important. Without a way to globally ignore
sigpipe for pipefail, we're left with annotating callers. Which means it
has now become much easier for people to introduce tests which racily
fail. That is much worse than the problem you are trying to solve here. ;)

So it does not matter much how many cases we have. The fact that it
would be easy to introduce new ones makes it unworkable IMHO (without
the bash patch, I mean).

-Peff
