Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B37B1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 17:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755491AbdCJR5Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 12:57:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:42082 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755341AbdCJR5X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 12:57:23 -0500
Received: (qmail 22153 invoked by uid 109); 10 Mar 2017 17:57:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 17:57:21 +0000
Received: (qmail 9653 invoked by uid 111); 10 Mar 2017 17:57:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 12:57:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Mar 2017 12:57:19 -0500
Date:   Fri, 10 Mar 2017 12:57:19 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        allan.x.xavier@oracle.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
Message-ID: <20170310175719.cxol7d262n2rlcb2@sigill.intra.peff.net>
References: <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
 <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
 <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
 <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
 <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
 <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
 <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
 <c553da50-e5ca-d064-e75c-46e5a5042935@web.de>
 <20170310081759.yka476hnw4w3mghs@sigill.intra.peff.net>
 <04f4849c-e1e0-f0ac-5b1e-10a343391db4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04f4849c-e1e0-f0ac-5b1e-10a343391db4@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 05:20:13PM +0100, René Scharfe wrote:

> > I think this misses the other two cases: (*dst, src) and (*dst, *src).
> 
> ... and that's why I left them out.  You can't get dst vs. *dst wrong with
> structs (at least not without the compiler complaining); only safe
> transformations are included in this round.

I don't think the transformation could be wrong without the original
code being wrong.

I'm also not sure why mine would be unsafe and yours would be safe. It
seems like the other way around, because mine will do:

  *dst = ...

which would fail unless "dst" is a pointer. Whereas in yours, we end up
with:

  dst = ...

and somebody mistaking pointer assignment for a struct copy would not
notice.

But either way, I don't think we can have a rule like "you can use
struct assignment only if you don't have a pointer for the destination".
That's too arcane to expect developers and reviewers to follow. We
should either allow struct assignment or not.

Or have I totally misunderstood your point?

-Peff
