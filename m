Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 808FA1F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 21:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750807AbdAaVfq (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 16:35:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:47489 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbdAaVfq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 16:35:46 -0500
Received: (qmail 30092 invoked by uid 109); 31 Jan 2017 21:35:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Jan 2017 21:35:13 +0000
Received: (qmail 5304 invoked by uid 111); 31 Jan 2017 21:35:14 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Jan 2017 16:35:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jan 2017 22:35:08 +0100
Date:   Tue, 31 Jan 2017 22:35:08 +0100
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] add SWAP macro
Message-ID: <20170131213507.uiwmkkcg7umvd3f4@sigill.intra.peff.net>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <alpine.DEB.2.20.1701301643260.3469@virtualbox>
 <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org>
 <alpine.DEB.2.20.1701302158110.3469@virtualbox>
 <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de>
 <20170130222157.GC35626@google.com>
 <8e94756a-c3a5-9b81-268d-d0f36876f710@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e94756a-c3a5-9b81-268d-d0f36876f710@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 31, 2017 at 10:03:01PM +0100, René Scharfe wrote:

> > Perhaps we could disallow a side-effect operator in the macro.  By
> > disallow I mean place a comment at the definition to the macro and
> > hopefully catch something like that in code-review.  We have the same
> > issue with the `ALLOC_GROW()` macro.
> 
> SWAP(a++, ...) is caught by the compiler, SWAP(*a++, ...) works fine.
> Technically that should be enough. :)  A comment wouldn't hurt, of course.

One funny thing is that your macro takes address-of itself, behind the
scenes. I wonder if it would be more natural for it to take
pointers-to-objects, making it look more like a real function (i.e.,
SWAP(&a, &b) instead of SWAP(a, b)". And then these funny corner cases
become quite obvious in the caller, because the caller is the one who
has to type "&".

-Peff
