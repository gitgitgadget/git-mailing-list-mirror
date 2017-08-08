Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAAF3208B5
	for <e@80x24.org>; Tue,  8 Aug 2017 22:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbdHHWwe (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 18:52:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:60884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751965AbdHHWwe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 18:52:34 -0400
Received: (qmail 28012 invoked by uid 109); 8 Aug 2017 22:52:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Aug 2017 22:52:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23468 invoked by uid 111); 8 Aug 2017 22:52:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Aug 2017 18:52:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Aug 2017 18:52:31 -0400
Date:   Tue, 8 Aug 2017 18:52:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] sha1_file: avoid comparison if no packed hash matches
 the first byte
Message-ID: <20170808225231.3l7gyoxxvghsvtv7@sigill.intra.peff.net>
References: <0c1f898c-46c4-033d-001b-114b17d7d36f@web.de>
 <xmqq3791adfi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq3791adfi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2017 at 03:43:13PM -0700, Junio C Hamano wrote:

> > @@ -2812,7 +2812,7 @@ off_t find_pack_entry_one(const unsigned char *sha1,
> >  			hi = mi;
> >  		else
> >  			lo = mi+1;
> > -	} while (lo < hi);
> > +	}
> >  	return 0;
> >  }
> 
> Interesting.  I see that we still have the conditional code to call
> out to sha1-lookup.c::sha1_entry_pos().  Do we need a similar change
> over there, I wonder?  Alternatively, as we have had the experimental
> sha1-lookup.c::sha1_entry_pos() long enough without anybody using it,
> perhaps we should write it off as a failed experiment and retire it?

There is also sha1_pos(), which seems to have the same problem (and is
used in several places).

-Peff
