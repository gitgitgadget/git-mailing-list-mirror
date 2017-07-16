Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EDFE20357
	for <e@80x24.org>; Sun, 16 Jul 2017 10:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbdGPK2S (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 06:28:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:41956 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751048AbdGPK2S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 06:28:18 -0400
Received: (qmail 24080 invoked by uid 109); 16 Jul 2017 10:28:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 10:28:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24522 invoked by uid 111); 16 Jul 2017 10:28:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 06:28:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Jul 2017 06:28:16 -0400
Date:   Sun, 16 Jul 2017 06:28:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/1] bswap: convert get_be16, get_be32 and put_be32 to
 inline functions
Message-ID: <20170716102815.gl24fbfzlom2ena3@sigill.intra.peff.net>
References: <56f1263c-a0b4-260b-7e23-881e21119041@web.de>
 <06c5bc39-d2c4-3436-97a7-9faa7c0519ca@web.de>
 <20170716102704.2yywbidmmjv7zfxh@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170716102704.2yywbidmmjv7zfxh@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2017 at 06:27:04AM -0400, Jeff King wrote:

> On Sat, Jul 15, 2017 at 09:22:50PM +0200, René Scharfe wrote:
> 
> > Simplify the implementation and allow callers to use expressions with
> > side-effects by turning the macros get_be16, get_be32 and put_be32 into
> > inline functions.
> > 
> > Signed-off-by: Rene Scharfe <l.s.r@web.de>
> > ---
> > All these redundant casts started to bother me, so I tried to come up
> > with nice and clean inline functions.  Successfully?  You tell me.
> > They are longer, but less cluttered.  Would it punish -O0 builds?  Is
> > it all worth it?
> 
> I do think the end result is a lot more readable. On gcc 6 at least, the
> function seems[1] to end up inlined even with -O0.

For my footnote. I was just going to show the test file I compiled:

  #include "git-compat-util.h"
  uint32_t foo(const char *x)
  {
	return get_be32(x);
  }

It's possible the optimizer may behave differently on a more complicated
input, but it does show that -O0 is still willing to inline.

-Peff
