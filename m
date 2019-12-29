Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B426DC2D0C0
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 06:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D66208C4
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 06:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfL2GDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 01:03:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:54842 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725800AbfL2GDK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 01:03:10 -0500
Received: (qmail 20710 invoked by uid 109); 29 Dec 2019 06:03:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 29 Dec 2019 06:03:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4973 invoked by uid 111); 29 Dec 2019 06:08:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Dec 2019 01:08:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 29 Dec 2019 01:03:08 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
Message-ID: <20191229060308.GA220034@coredump.intra.peff.net>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <20191222093036.GA3449072@coredump.intra.peff.net>
 <fc30441a-1bb7-73e5-43f6-6e26824e04f6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc30441a-1bb7-73e5-43f6-6e26824e04f6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 26, 2019 at 09:21:36AM -0500, Derrick Stolee wrote:

> Here are some recommendations (to Garima) for how to proceed with these
> patches. Please let me know if anyone disagrees.
> 
> >   [1/3]: commit-graph: examine changed-path objects in pack order
> 
> This one is best kept as its own patch, as it shows a clear reason why
> we want to do the sort-by-position. It would also be a complicated
> patch to include this logic along with the first use of
> compute_bloom_filters().

Yeah, I'd agree this one could be a separate patch. It does need more
work, though (as you found out, it does not cover --reachable at all).

The position counter also probably ought to be an unsigned (or even a
uint32_t, which we usually consider a maximum bound for number of
objects).

-Peff
