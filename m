Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EE731F403
	for <e@80x24.org>; Fri, 15 Jun 2018 17:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936371AbeFORvO (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 13:51:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:45994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932194AbeFORvO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 13:51:14 -0400
Received: (qmail 23037 invoked by uid 109); 15 Jun 2018 17:51:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 17:51:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23270 invoked by uid 111); 15 Jun 2018 17:51:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Jun 2018 13:51:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2018 13:51:12 -0400
Date:   Fri, 15 Jun 2018 13:51:12 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luat Nguyen <root@l4w.io>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] ewah: drop ewah_serialize_native function
Message-ID: <20180615175111.GD3067@sigill.intra.peff.net>
References: <20180615032850.GA23241@sigill.intra.peff.net>
 <20180615033228.GC20390@sigill.intra.peff.net>
 <afbd5335-ef0d-5ca5-84ab-bdfa8bdc50bb@ramsayjones.plus.com>
 <ab6378a8-3728-7fa8-da08-b58ec768dbfe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab6378a8-3728-7fa8-da08-b58ec768dbfe@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 10:15:50AM -0400, Derrick Stolee wrote:

> > Hmm, if you are in the mood to drop ewah dead code, how about:
> > 
> >    ewah/bitmap.o   - bitmap_clear
> >    ewah/bitmap.o   - bitmap_each_bit
> >    ewah/ewah_bitmap.o      - ewah_and
> >    ewah/ewah_bitmap.o      - ewah_and_not
> >    ewah/ewah_bitmap.o      - ewah_not
> >    ewah/ewah_bitmap.o      - ewah_or
> > 
> > ... in addition to these *(de)serialize* functions. ;-)
> > 
> 
> Normally, I would say we should keep this folder as close to the "original"
> [1] as possible, so we could more easily take improvements to that library.
> However, it appears that code is not being updated. Perhaps this is in favor
> of other EWAH libraries [2] or other compressed bitmap formats [3].

The ewok library was written specifically for Git, as a port of Daniel
Lemire's original EWAH work, since at the time there was no pure-C
implementation of EWAH (that might even still be the case -- I don't
know).

We pulled it out into a separate library with the thought that maybe
other people would find it useful. But I don't specifically know of any
other users of the library, nor do I think Vicent has spent any time on
it since writing it for Git (I know I haven't).

So yeah, I think it is fine to just consider this "our" code and chop it
up as we see fit (and you can see we've already tweaked it for things
like allocating consistently with our other code).

One thing that gave me pause on ripping out more code is that I have
some bitmap-related patches on my send-to-upstream list, and I wasn't
sure if they used any of this code. But I checked against your patches,
and no, this can all go (which makes sense -- my patches are about using
.bitmap files in more places, so they build at a higher level).

So your patches look good to me, modulo the declarations that Ramsay
noticed should be removed, too.

-Peff
