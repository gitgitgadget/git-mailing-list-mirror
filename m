Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E234C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E49060F6B
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhJHETT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 00:19:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:35574 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhJHETS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 00:19:18 -0400
Received: (qmail 2744 invoked by uid 109); 8 Oct 2021 04:17:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Oct 2021 04:17:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30601 invoked by uid 111); 8 Oct 2021 04:17:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Oct 2021 00:17:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Oct 2021 00:17:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 10/9 v2] test-mergesort: use repeatable random numbers
Message-ID: <YV/GUg3yXDfuS3BA@coredump.intra.peff.net>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
 <522fba5e-1048-3377-45c1-7107b55dc6e1@web.de>
 <xmqq7dew7aqd.fsf@gitster.g>
 <87o887q0s9.fsf@evledraar.gmail.com>
 <850aa059-61d9-0eba-5809-e0c27a19dfb4@web.de>
 <xmqqee9210a1.fsf@gitster.g>
 <a3eeb255-56e3-eb22-ebf7-e9f04c95fa44@web.de>
 <b73452fa-f5b0-0ab4-25e8-7494637c49f5@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b73452fa-f5b0-0ab4-25e8-7494637c49f5@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 08, 2021 at 06:04:42AM +0200, René Scharfe wrote:

> Use MINSTD to generate pseudo-random numbers consistently instead of
> using rand(3), whose output can vary from system to system, and reset
> its seed before filling in the test values.  This gives repeatable
> results across versions and systems, which simplifies sharing and
> comparing of results between developers.

Nice. As a bonus, I noticed that Coverity complains about the use of
rand() as a security red-flag (even though of course we don't care about
its quality here). This should get rid of it by hiding the same thing in
a custom implementation. ;)

We have a similar LCG in t/helper/test-genrandom.c, but I don't think
there's any reason this needs to be factored into a shared one. And in
particular, I'd be loathe to change the genrandom one, as it may create
small bugs in the test suite (cases where we rely on hashes of the data
having particular attributes).

-Peff
