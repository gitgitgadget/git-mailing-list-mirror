Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E9EC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F041660EE3
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240999AbhIPWiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:38:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:49546 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234419AbhIPWiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 18:38:16 -0400
Received: (qmail 8727 invoked by uid 109); 16 Sep 2021 22:36:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Sep 2021 22:36:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9983 invoked by uid 111); 16 Sep 2021 22:36:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Sep 2021 18:36:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Sep 2021 18:36:54 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v2 4/7] p5326: create missing 'perf-tag' tag
Message-ID: <YUPHBv3d5p67NAnJ@coredump.intra.peff.net>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631657157.git.me@ttaylorr.com>
 <a8c6e845adf559a96e37c973fea16da8a42e7cba.1631657157.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8c6e845adf559a96e37c973fea16da8a42e7cba.1631657157.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 06:06:09PM -0400, Taylor Blau wrote:

> Some of the tests in test_full_bitmap rely on having a tag named
> perf-tag in place. We could create it in test_full_bitmap(), but we want
> to have it in place before the repack starts.

I wondered how p5326 ever could have worked without this.

But I think the answer is that it was added in a parallel-ish branch via
540cdc11ad (pack-bitmap: avoid traversal of objects referenced by
uninteresting tag, 2021-03-22).

If that had then been merged with the midx-bitmap topic, we would have
seen a conflict as yours tried to delete the surrounding tests that got
moved into lib-bitmap.sh. But we didn't see such a merge.  Your
9387fbd646 (p5310: extract full and partial bitmap tests, moves the
perf-tag test, so p5326 was broken then (well, in the follow-on commit
that introduced it).

Knowing the history of the midx-bitmap series, I'm almost certain what
happened is that it got rebased, and you probably _did_ see a textual
conflict, which you resolved correctly, moving the perf-tag test into
lib-bitmap.sh But you missed the semantic conflict that p5326 also
needed to add in the setup step.

All of which is to say this looks fine to me. ;) I was just talking out
loud to try to understand what had happened.

-Peff
