Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C53A820193
	for <e@80x24.org>; Sat, 13 Aug 2016 09:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbcHMJJv (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 05:09:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:54698 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752395AbcHMJJv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 05:09:51 -0400
Received: (qmail 2050 invoked by uid 109); 13 Aug 2016 09:09:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Aug 2016 09:09:49 +0000
Received: (qmail 27624 invoked by uid 111); 13 Aug 2016 09:09:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Aug 2016 05:09:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Aug 2016 05:09:48 -0400
Date:	Sat, 13 Aug 2016 05:09:48 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] correct FLEXPTR_* example in comment
Message-ID: <20160813090947.uj6hurji5o6cwxge@sigill.intra.peff.net>
References: <57AEE1E1.3080901@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57AEE1E1.3080901@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 13, 2016 at 11:01:21AM +0200, René Scharfe wrote:

> This section is about "The FLEXPTR_* variants", so use FLEXPTR_ALLOC_STR
> in the example.

Oops, yeah. Your patch is clearly an improvement.

Since this is obviously an easy mistake to make (using one form rather
than the other), I wondered if the compiler would catch it.

I think it would catch an accidental use of FLEXPTR instead of FLEX,
because it involves an attempted assignment of an array. But I don't
think we would catch the reverse; we'd just write the data directly on
top of the pointer. That would probably crash immediately at runtime, so
if you exercise the code at all in tests, it is OK. But something to be
aware of.

I suppose it could assert(sizeof((x)->flexname) == FLEX_ALLOC) or
something, but I'm not sure if it is worth worrying about.

-Peff
