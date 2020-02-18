Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FBBC34049
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F148321D56
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgBRT7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:59:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:47118 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728351AbgBRT7C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 14:59:02 -0500
Received: (qmail 19978 invoked by uid 109); 18 Feb 2020 19:59:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 19:59:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22019 invoked by uid 111); 18 Feb 2020 20:08:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 15:08:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 14:59:01 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/15] rev-list: make --count work with --objects
Message-ID: <20200218195901.GB21774@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182220.GF150965@coredump.intra.peff.net>
 <3230c8c9-5208-3161-324e-c0ce948ee5b3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3230c8c9-5208-3161-324e-c0ce948ee5b3@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 01:05:35PM -0500, Derrick Stolee wrote:

> On 2/14/2020 1:22 PM, Jeff King wrote:
> > +test_expect_success 'rev-list --count' '
> > +	count=$(git rev-list --count HEAD) &&
> > +	git rev-list HEAD >actual &&
> > +	test_line_count = $count actual
> > +'
> > +
> > +test_expect_success 'rev-list --count --objects' '
> > +	count=$(git rev-list --count --objects HEAD) &&
> > +	git rev-list --objects HEAD >actual &&
> > +	test_line_count = $count actual
> > +'
> 
> I suppose these tests work, although I would probably
> prefer precomputed explicit expected counts instead
> of asking rev-list for the correct answer to a
> rev-list command. This is still fine, because we test
> that the non-count versions return the correct results,
> but I would hate for a bug to affect both modes equally
> and cause these tests to pass.

I was hoping it would make the tests a bit less brittle. And as you
note, we should be checking the enumeration results themselves more
carefully in other tests, so I find it fairly unlikely to see a bug that
doesn't trigger _any_ test failure.

-Peff
