Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3D61F597
	for <e@80x24.org>; Fri, 20 Jul 2018 17:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388255AbeGTSeo (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 14:34:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:54292 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388118AbeGTSeo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 14:34:44 -0400
Received: (qmail 29747 invoked by uid 109); 20 Jul 2018 17:45:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Jul 2018 17:45:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30070 invoked by uid 111); 20 Jul 2018 17:45:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 20 Jul 2018 13:45:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2018 13:45:24 -0400
Date:   Fri, 20 Jul 2018 13:45:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
Message-ID: <20180720174524.GB22486@sigill.intra.peff.net>
References: <20180719203259.GA7869@sigill.intra.peff.net>
 <20180719203901.GA8079@sigill.intra.peff.net>
 <xmqqmuumdetr.fsf@gitster-ct.c.googlers.com>
 <20180720010808.GC2179@sigill.intra.peff.net>
 <xmqqa7qmckwi.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7qmckwi.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 02:32:29AM -0700, Junio C Hamano wrote:

> > Contrast this with memcpy(). This is on Microsoft's SDL banned list[1],
> > but I think it's silly for it to be. I would never add it to this list.
> 
> A tangent, but is that because they want you to use memmove()
> instead so that you do not have to worry about overlapping copies,
> perhaps?

That was my first thought, too, but nope. They recommend memcpy_s()
instead. Which in my opinion adds very little value, while missing the
most common misuse of memcpy I've seen in practice (the overlapping
thing).

Helpers like our COPY_ARRAY() are much more useful for preventing sizing
mistakes, IMHO. But again, I'd never ban memcpy. The right tool for
encouraging COPY_ARRAY() is coccinelle (because the matching is
complicated, but also because we can mechanically turn it into the right
thing, whereas a strcpy is going to require some manual reworking).

-Peff
