Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC221F597
	for <e@80x24.org>; Fri,  3 Aug 2018 13:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeHCPEo (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 11:04:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:41684 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731997AbeHCPEn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 11:04:43 -0400
Received: (qmail 2277 invoked by uid 109); 3 Aug 2018 13:08:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Aug 2018 13:08:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1412 invoked by uid 111); 3 Aug 2018 13:08:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 03 Aug 2018 09:08:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2018 09:08:25 -0400
Date:   Fri, 3 Aug 2018 09:08:25 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PoC] coccinelle: make Coccinelle-related make targets more
 fine-grained
Message-ID: <20180803130824.GC4671@sigill.intra.peff.net>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
 <20180802115522.16107-1-szeder.dev@gmail.com>
 <20180802180155.GD15984@sigill.intra.peff.net>
 <20180802183145.GA23690@sigill.intra.peff.net>
 <20180803062144.GB237521@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180803062144.GB237521@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 02, 2018 at 11:21:44PM -0700, Jonathan Nieder wrote:

> > diff --git a/Makefile b/Makefile
> > index d616c0412..86fdcf567 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2674,15 +2674,17 @@ COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
> >  else
> >  COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
> >  endif
> > +COCCI_COMBINED = contrib/coccinelle/combined.cocci
> 
> I like this approach.

I was pretty pleased with myself, too, but I had a lingering doubt about
whether just cat-ing the files was legitimate. It sounds from the
response elsewhere that it's not (but just happens to work now for out
limited case). But it also sounds like there may be even better options.

> > I guess you could even replace "COCCI_COMBINED" with "COCCI_PATCH" in
> > most of the targets, and that would let people do individual:
> > 
> >   make COCCI_PATCH=contrib/coccinelle/foo.cocci coccicheck
> 
> The issue here is that the dependencies for foo.cocci become
> unreliable, so I'd rather have a separate target for that (e.g.
> depending on FORCE) if we go that way.

Can you be more specific? I don't see how it's unreliable, unless you
mean that anything relying on "coccicheck" would depend on the exact
value of COCCI_PATCH.

But it may all be moot anyway, based no the responses elsewhere in the
thread.

-Peff
