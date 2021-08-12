Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A256C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 23:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76FBD6103E
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 23:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbhHLXXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 19:23:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:46432 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230244AbhHLXXr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 19:23:47 -0400
Received: (qmail 25636 invoked by uid 109); 12 Aug 2021 23:23:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Aug 2021 23:23:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26448 invoked by uid 111); 12 Aug 2021 23:23:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Aug 2021 19:23:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Aug 2021 19:23:20 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 18/25] t5326: test multi-pack bitmap behavior
Message-ID: <YRWtaBtZfRKvKrpk@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
 <3258ccfc1cc99038e43a37bd2d53c9d30a4f22ae.1627420428.git.me@ttaylorr.com>
 <YRWMYg2rvv7HjGE+@coredump.intra.peff.net>
 <YRWi3KHM2iunQ02f@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRWi3KHM2iunQ02f@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 06:38:20PM -0400, Taylor Blau wrote:

> > This is brittle with respect to Git's delta heuristics, of course, but I
> > don't think there's a better way to do it with pack-objects. And this is
> > not the first test to make similar assumptions. I think you can
> > construct a known set of deltas using lib-pack.sh. It may get a bit
> > complicated. As an alternative, maybe it makes sense to confirm that the
> > deltas are set up as expected? You can do it with cat-file
> > --batch-check.
> 
> Yeah, I definitely agree that this test is brittle. But it would fail if
> our assumptions about what gets delta'd with what changes, because we do
> check that 'a' is a delta on top of 'b' (see the call to have_delta
> towards the end of this test). That have_delta helper does use
> `--batch-check=%(deltabase)`, which is (I think) the cat-file invocation
> you're mentioning.

Doh, I totally missed that. I was expecting to verify it earlier in the
test as a pre-condition, but it works just fine where it is. So yeah,
you are already doing the thing I was suggesting.

-Peff
