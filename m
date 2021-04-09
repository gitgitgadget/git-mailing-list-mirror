Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991F7C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB21610D0
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhDIPzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:55:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:46352 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233019AbhDIPzt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:55:49 -0400
Received: (qmail 31866 invoked by uid 109); 9 Apr 2021 15:55:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 15:55:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12642 invoked by uid 111); 9 Apr 2021 15:55:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 11:55:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 11:55:35 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 7/8] pack-bitmap: implement combined filter
Message-ID: <YHB49723aQrh13yF@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <fac3477d979058da0430b974a34f7c7f866bf456.1615813673.git.ps@pks.im>
 <YGygV1mesbJzdPr5@coredump.intra.peff.net>
 <YHA359zqnw7MV8Bp@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHA359zqnw7MV8Bp@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 01:17:59PM +0200, Patrick Steinhardt wrote:

> > Before this patch, I think your test:
> > 
> > > +test_expect_success 'combine filter' '
> > > +	git rev-list --objects --filter=blob:limit=1000 --filter=object:type=blob tag >expect &&
> > > +	git rev-list --use-bitmap-index \
> > > +		     --objects --filter=blob:limit=1000 --filter=object:type=blob tag >actual &&
> > > +	test_bitmap_traversal expect actual
> > > +'
> > 
> > would pass anyway, because we'd just skip using bitmaps. Is there a way
> > we can tell that the bitmap code actually kicked in? Maybe a perf test
> > would make it clear (those aren't always run, but hopefully we'd
> > eventually notice a regression there).
> 
> I think that's not actually true. Note that we're using
> `test_bitmap_traversal`:

Ah, right. I forgot about the hackery in test_bitmap_traversal() to let
us tell the difference (even though I was the one who wrote it, I still
consider it hackery ;) ).

So yes, this is a good test that we are allowing the combine filter.

-Peff
