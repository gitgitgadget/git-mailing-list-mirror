Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2479C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9F823440
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 20:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392800AbhATUBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 15:01:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:33354 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbhATT7D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 14:59:03 -0500
Received: (qmail 28874 invoked by uid 109); 20 Jan 2021 19:58:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Jan 2021 19:58:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25668 invoked by uid 111); 20 Jan 2021 19:58:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Jan 2021 14:58:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 Jan 2021 14:58:21 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@gitlab.com
Subject: Re: [PATCH v2 2/3] ls-refs.c: initialize 'prefixes' before using it
Message-ID: <YAiLXUDTdMpdGG5b@coredump.intra.peff.net>
References: <cover.1611080326.git.me@ttaylorr.com>
 <cover.1611158549.git.me@ttaylorr.com>
 <5fc081b2d554db305400ec52fac8683a3ed59597.1611158549.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fc081b2d554db305400ec52fac8683a3ed59597.1611158549.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 11:04:25AM -0500, Taylor Blau wrote:

> From: Jacob Vosmaer <jacob@gitlab.com>
> 
> Correctly initialize the "prefixes" strvec using strvec_init() instead
> of simply zeroing it via the earlier memset().
> 
> There's no way to trigger a crash, since the first 'ref-prefix' command
> will initialize the strvec via the 'ALLOC_GROW' in 'strvec_push_nodup()'
> (the alloc and nr variables are already zero'd, so the call to
> ALLOC_GROW is valid).

For people not familiar with strvec, I think there's a missing bit of
explanation between those two paragraphs: an initialized strvec does not
point to NULL, but to a dummy array with a single NULL value in it. That
explains why it might crash. :)

That nit (and the one I mentioned in the previous patch) aside, these
patches look good to me (and I am OK with or without the nits
addressed).

-Peff
