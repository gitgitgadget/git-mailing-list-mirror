Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2A6C43381
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 21:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4555464E31
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 21:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhBJVMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 16:12:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:56918 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233608AbhBJVLp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 16:11:45 -0500
Received: (qmail 1271 invoked by uid 109); 10 Feb 2021 21:10:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Feb 2021 21:10:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23993 invoked by uid 111); 10 Feb 2021 21:10:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Feb 2021 16:10:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Feb 2021 16:10:58 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 07/12] test-lib-functions: move function to lib-bitmap.sh
Message-ID: <YCRL4lq5eQnPLwK1@coredump.intra.peff.net>
References: <20210209214159.22815-1-avarab@gmail.com>
 <20210209214159.22815-8-avarab@gmail.com>
 <20210210205645.GE1015009@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210210205645.GE1015009@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 09:56:45PM +0100, SZEDER Gábor wrote:

> > +test_bitmap_traversal () {
> > +	if test "$1" = "--no-confirm-bitmaps"
> > +	then
> > +		shift
> > +	elif cmp "$1" "$2"
> > +	then
> > +		echo >&2 "identical raw outputs; are you sure bitmaps were used?"
> > +		return 1
> 
> Since you converted two 'error's to BUG earlier in this series...
> 
> This helper function was added in ea047a8eb4 (t5310: factor out bitmap
> traversal comparison, 2020-02-14), and so I Cc: its author and quote
> part of its commit message:
> 
>     While we're at it, let's also try to confirm that the bitmap output did
>     indeed use bitmaps. Since the code internally falls back to the
>     non-bitmap path in some cases, the tests are at risk of becoming trivial
>     noops.
>     
>     This is a bit fragile, as not all outputs will differ (e.g., looking at
>     only the commits from a fully-bitmapped pack will end up exactly the
>     same as the normal traversal order, since it also matches the pack
>     order). So we'll provide an escape hatch by which tests can disable this
>     check (which should only be used after manually confirming that bitmaps
>     kicked in).
> 
> Shouldn't this be a BUG as well?  I think this should be a BUG.

I dunno. I guess you are thinking of the case where somebody adds a new
caller but fails to invoke Git correctly. Which would be a bug in the
test script.

But it could also easily be due to Git changing how it behaves in a
certain circumstance. And maybe the solution is changing the test to
adapt, or maybe we just found a bug in Git.

TBH, I do not care that much either way. Either way, I think somebody
would notice the problem.

-Peff
