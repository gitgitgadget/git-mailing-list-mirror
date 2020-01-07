Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6FEC33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 15:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFE22081E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 15:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgAGPgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:36:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:59250 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727559AbgAGPgw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 10:36:52 -0500
Received: (qmail 13311 invoked by uid 109); 7 Jan 2020 15:36:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Jan 2020 15:36:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31924 invoked by uid 111); 7 Jan 2020 15:42:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2020 10:42:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jan 2020 10:36:51 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, brad@brad-smith.co.uk,
        sunshine@sunshineco.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] graph: replace assert() with graph_assert() macro
Message-ID: <20200107153651.GB20591@coredump.intra.peff.net>
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
 <5dd305d2f0de43a70b46336c8f1a62437e0511e1.1578408947.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5dd305d2f0de43a70b46336c8f1a62437e0511e1.1578408947.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 07, 2020 at 02:55:46PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The assert() macro is sometimes compiled out. Instead, switch these into
> BUG() statements using our own custom macro.
> 
> Reported-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

I can buy the argument that compiling with and without NDEBUG can lead
to confusion. But if that is the case, wouldn't it be so for all of the
assert() calls, not just ones in the graph code?

Previous discussions[1] seemed to conclude that having a kernel-style
BUG_ON() is probably the right way forward. I.e., replace this:

> +#define graph_assert(exp) if (!(exp)) { BUG("assert failed: "#exp""); }

with something similar in git-compat-util.h. Even if we don't convert
everybody to it immediately, it would be available for use.

At any rate, I think this patch (and the third one) can be post-v2.25.
But we'd want the first one before the release.

-Peff

[1] https://lore.kernel.org/git/20171122223827.26773-1-sbeller@google.com/
