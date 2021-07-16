Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDBAC12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D695613FB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhGPTG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 15:06:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:52216 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhGPTGz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 15:06:55 -0400
Received: (qmail 21628 invoked by uid 109); 16 Jul 2021 19:04:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Jul 2021 19:04:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11960 invoked by uid 111); 16 Jul 2021 19:04:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 15:04:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 15:03:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4] test-lib-functions: use test-tool for [de]packetize()
Message-ID: <YPHYHx9W4HSRMmq+@coredump.intra.peff.net>
References: <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
 <patch-1.1-546974eed59-20210716T153909Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-546974eed59-20210716T153909Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 05:41:33PM +0200, Ævar Arnfjörð Bjarmason wrote:

> I ejected changing/adding test code for this v4. This keeps the
> compatibility wrappers and just narrowly changes the things that need
> a packetize_raw() to use that new helper.
> 
> I left the simpler packetize() case as a "printf", it could also use
> the test tool, but in case someone cares about process overhead on say
> Windows this entire change should be strictly better than the status
> quo.

This looks fine to me. I actually did like some of the readability
improvements possible in the other patches, but they can still be easily
built on top if we care to.

Using "test-tool pkt-line unpack" doesn't behave exactly like
depacketize:

  - as noted earlier, it drops stuff after a NUL

  - it says "0000" instead of "FLUSH"

But we don't seem to depend on either of those in any tests, so it's a
good time to switch. :)

-Peff
