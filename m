Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484091F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 20:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbfJVUGR (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 16:06:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:55158 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731806AbfJVUGR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 16:06:17 -0400
Received: (qmail 31450 invoked by uid 109); 22 Oct 2019 20:06:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 22 Oct 2019 20:06:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18470 invoked by uid 111); 22 Oct 2019 20:09:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Oct 2019 16:09:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Oct 2019 16:06:16 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: is commitGraph useful on the server side?
Message-ID: <20191022200615.GA12270@sigill.intra.peff.net>
References: <20191022165112.GA4960@chatter.i7.local>
 <e0e294a7-bd3c-2174-a922-c5893b0945c2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0e294a7-bd3c-2174-a922-c5893b0945c2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 22, 2019 at 03:44:28PM -0400, Derrick Stolee wrote:

> I'm biased, but I think the commit-graph is generally really good to have
> in almost all cases. I actually do not know of a good reason to _not_ have
> it.

A lot depends on how much you do on the server. If you're serving a web
interface that runs things like `rev-list`, or `for-each-ref
--contains`, etc, then you should see a big improvement.

If you're _just_ serving fetches with `upload-pack`, you might see some
small improvement during fetch negotiation. But I suspect it would be
dwarfed by the cost of actually generating packs. Likewise, the
traversal there will be dominated by accessing trees (and if that is
expensive, then you ought to be using reachability bitmaps).

But I agree that there's no reason _not_ to use them.

-Peff
