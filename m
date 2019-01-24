Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C8A21F453
	for <e@80x24.org>; Thu, 24 Jan 2019 19:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfAXTFB (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 14:05:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:47736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725951AbfAXTFA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:05:00 -0500
Received: (qmail 9619 invoked by uid 109); 24 Jan 2019 19:05:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 19:05:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31273 invoked by uid 111); 24 Jan 2019 19:05:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 14:05:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 14:04:59 -0500
Date:   Thu, 24 Jan 2019 14:04:59 -0500
From:   Jeff King <peff@peff.net>
To:     Lucy Phipps <landfillbaby69@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: [PATCH] optimize PNGs with FileOptimizer 13.50.2431 (x86)
 and ZopfliPNG 1.0.2
Message-ID: <20190124190458.GA29828@sigill.intra.peff.net>
References: <20190124180755.6124-1-landfillbaby@outlook.com>
 <CAGZ79kZAhL6jz9i1-v09y0b3KGCokANN6eZYgXgU1w9_ymFZFg@mail.gmail.com>
 <CAGOd_F8f=dURFE0H3qjMONy32nrSsXs5KHnogsosfwK92-KbYw@mail.gmail.com>
 <CAGOd_F8A7Tfgb8cD1qvi2WDKYXLp=Zf_Yopb38gFpRQoj0tcdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGOd_F8A7Tfgb8cD1qvi2WDKYXLp=Zf_Yopb38gFpRQoj0tcdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 06:34:29PM +0000, Lucy Phipps wrote:

> honestly i just like optimizing files. the test images still work but
> one of them is half the size as before. i don't know if it needs to be
> bigger. it doesn't make any actual difference

I'm not sure if we actually see any benefit to optimizing them, though.

Optimizing a file which is served to many clients makes sense. So these:

> > >  gitweb/static/git-favicon.png | Bin 115 -> 106 bytes
> > >  gitweb/static/git-logo.png    | Bin 207 -> 204 bytes

should be optimized (and largely already are, from the byte counts).

But these:

> > >  t/test-binary-1.png           | Bin 5660 -> 2603 bytes
> > >  t/test-binary-2.png           | Bin 275 -> 217 bytes

never go anywhere except developer's working trees. And since the
history is kept in Git, we keep the original version of the file, too.
So this is actually making git.git slightly _larger_, even though
checked-out file in the working tree is smaller.

I'm not sure that's worth the tradeoff.

-Peff
