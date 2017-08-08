Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF1B20899
	for <e@80x24.org>; Tue,  8 Aug 2017 22:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbdHHW6y (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 18:58:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:60900 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751965AbdHHW6y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 18:58:54 -0400
Received: (qmail 28334 invoked by uid 109); 8 Aug 2017 22:58:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Aug 2017 22:58:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23504 invoked by uid 111); 8 Aug 2017 22:59:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Aug 2017 18:59:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Aug 2017 18:58:51 -0400
Date:   Tue, 8 Aug 2017 18:58:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] sha1_file: avoid comparison if no packed hash matches
 the first byte
Message-ID: <20170808225851.kgbyrlqrtlurzc73@sigill.intra.peff.net>
References: <0c1f898c-46c4-033d-001b-114b17d7d36f@web.de>
 <xmqq3791adfi.fsf@gitster.mtv.corp.google.com>
 <20170808225231.3l7gyoxxvghsvtv7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808225231.3l7gyoxxvghsvtv7@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2017 at 06:52:31PM -0400, Jeff King wrote:

> > Interesting.  I see that we still have the conditional code to call
> > out to sha1-lookup.c::sha1_entry_pos().  Do we need a similar change
> > over there, I wonder?  Alternatively, as we have had the experimental
> > sha1-lookup.c::sha1_entry_pos() long enough without anybody using it,
> > perhaps we should write it off as a failed experiment and retire it?
> 
> There is also sha1_pos(), which seems to have the same problem (and is
> used in several places).

Actually, I take it back. The problem happens when we enter the loop
with no entries to look at. But both sha1_pos() and sha1_entry_pos()
return early before hitting their do-while loops in that case.

-Peff
