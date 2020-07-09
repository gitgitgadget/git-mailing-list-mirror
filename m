Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D57BC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 23:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA46920672
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 23:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgGIXCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:02:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:53736 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgGIXCw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 19:02:52 -0400
Received: (qmail 6364 invoked by uid 109); 9 Jul 2020 23:02:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jul 2020 23:02:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26603 invoked by uid 111); 9 Jul 2020 23:02:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jul 2020 19:02:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Jul 2020 19:02:51 -0400
From:   Jeff King <peff@peff.net>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] diff: check for merge bases before assigning sym->base
Message-ID: <20200709230251.GC664420@coredump.intra.peff.net>
References: <20200707235436.GH9782@camp.crustytoothpaste.net>
 <20200708043819.GA2303891@coredump.intra.peff.net>
 <CAPx1GvfLpTR-weVQcWm5iX59cmCh2Gad+vU=ESqqLkCq-O5RmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPx1GvfLpTR-weVQcWm5iX59cmCh2Gad+vU=ESqqLkCq-O5RmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 08, 2020 at 10:05:44AM -0700, Chris Torek wrote:

> > I don't see anything within this function guaranteeing that rpos is set,
> > either, though I suspect it is OK due to how the revision parser works.
> 
> Yes, I am depending on the revision parser to balance the left and
> right items.  I thought about having a BUG check but it seemed
> unnecessary.  On the other hand, I'm avoiding depending on its
> *placement* of left and right items.  Being more defensive might
> be good here.

I could go either way with adding a BUG (and it definitely doesn't need
to hold up this fix). I strongly suspect that getting a LEFT without a
RIGHT would be a bug in the rev parser, not this code. But seeing a
BUG() here might be a more friendly way of being informed of that than a
segfault. :)

-Peff
