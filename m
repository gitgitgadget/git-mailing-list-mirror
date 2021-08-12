Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBB5C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 21:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D93460E52
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 21:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhHLVIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 17:08:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:46006 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232081AbhHLVIG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 17:08:06 -0400
Received: (qmail 25034 invoked by uid 109); 12 Aug 2021 21:07:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Aug 2021 21:07:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25552 invoked by uid 111); 12 Aug 2021 21:07:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Aug 2021 17:07:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Aug 2021 17:07:39 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 18/25] t5326: test multi-pack bitmap behavior
Message-ID: <YRWNm+HlgBE5E0ia@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
 <3258ccfc1cc99038e43a37bd2d53c9d30a4f22ae.1627420428.git.me@ttaylorr.com>
 <YRWMYg2rvv7HjGE+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRWMYg2rvv7HjGE+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 05:02:26PM -0400, Jeff King wrote:

> > +# We'll be writing our own midx and bitmaps, so avoid getting confused by the
> > +# automatic ones.
> > +GIT_TEST_MULTI_PACK_INDEX=0
> > +GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
> 
> This latter variable doesn't do anything at this point in the series.
> Probably not a big deal (it is simply a noop until then), but if it's
> not hard, it may make sense to bump the "respect ... WRITE_BITMAP" patch
> earlier in the series.

Reading the other patches, I guess you ordering was to "fix" each of the
tests preemptively, and then add the knob at the end. That's OK by me.
For an alternate test-mode like this, I usually wouldn't worry about
bisectability, but it doesn't hurt. Somebody reading the commits later
won't have any trouble finding the definition of the WRITE_BITMAP
variable added in the subsequent patch.

> > +test_expect_success '--no-bitmap is respected when bitmaps exist' '
> > +	git multi-pack-index write --bitmap &&
> > +
> > +	test_commit respect--no-bitmap &&
> > +	GIT_TEST_MULTI_PACK_INDEX=0 git repack -d &&
> 
> Do we need to set this env variable? We've already set it to 0 at the
> top of the script.

By the way, there were a few more of these later in the script that
could be cleaned up, too.

-Peff
