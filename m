Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67962C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 17:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BF40613B7
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 17:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhDFRRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 13:17:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:42744 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233060AbhDFRRm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 13:17:42 -0400
Received: (qmail 8157 invoked by uid 109); 6 Apr 2021 17:17:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Apr 2021 17:17:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30505 invoked by uid 111); 6 Apr 2021 17:17:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Apr 2021 13:17:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Apr 2021 13:17:33 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/8] uploadpack.txt: document implication of
 `uploadpackfilter.allow`
Message-ID: <YGyXrVElnVSALuDU@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <270ff80dacff96f441e12954b059a68300157f2d.1615813673.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <270ff80dacff96f441e12954b059a68300157f2d.1615813673.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 02:14:31PM +0100, Patrick Steinhardt wrote:

> When `uploadpackfilter.allow` is set to `true`, it means that filters
> are enabled by default except in the case where a filter is explicitly
> disabled via `uploadpackilter.<filter>.allow`. This option will not only
> enable the currently supported set of filters, but also any filters
> which get added in the future. As such, an admin which wants to have
> tight control over which filters are allowed and which aren't probably
> shouldn't ever set `uploadpackfilter.allow=true`.
> 
> Amend the documentation to make the ramifications more explicit so that
> admins are aware of this.

It might help to guide the admin a bit more here. What are we really
worried about? Probably that an expensive filter would be added that
would make an admin with a public-facing server unhappy.

Maybe we should be more explicit about our recommendations, like:

  This defaults to `true` for historical reasons, but that includes
  expensive-to-compute filters (both existing ones like `sparse`, but
  also future ones). A safer value is to set this to `false` and
  mark individual filters as allowed.

But then of course somebody wonders which set are expensive and which
ones are not. And really, "expensive" here is not that expensive. It is
"do not support bitmaps".

So I wonder if this concern is overblown in the first place. People who
care about using only bitmap-supported filters probably already set this
to "false". And vaguely calling things "expensive" is probably being
overly scary. But in that case, I'm not sure we even need to add a
reminder that future ones will also be enabled (OTOH, I do not mind it
so much; it is encouraging people to set this to false and mark
individual ones as allowed).

-Peff
