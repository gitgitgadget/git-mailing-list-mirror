Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92F8E1F453
	for <e@80x24.org>; Wed,  1 May 2019 18:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfEASHz (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 14:07:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:45976 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725973AbfEASHz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 14:07:55 -0400
Received: (qmail 23162 invoked by uid 109); 1 May 2019 18:07:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 May 2019 18:07:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20625 invoked by uid 111); 1 May 2019 18:08:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 01 May 2019 14:08:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2019 14:07:52 -0400
Date:   Wed, 1 May 2019 14:07:52 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 1/2] archive: replace write_or_die() calls with
 write_block_or_die()
Message-ID: <20190501180752.GA4109@sigill.intra.peff.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <7a9525a78a7b7b237150b9264cf675a4a0b37267.1555110278.git.gitgitgadget@gmail.com>
 <20190413013451.GB2040@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1904261026070.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904261026070.45@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 26, 2019 at 10:28:12AM -0400, Johannes Schindelin wrote:

> > > +static gzFile gzip;
> > > [...]
> > > +       if (gzip) {
> >
> > Is it OK for us to ask about the truthiness of this opaque type? That
> > works if it's really a pointer behind the scenes, but it seems like it
> > would be equally OK for zlib to declare it as a struct.
> >
> > It looks OK in my version of zlib, and that library tends to be fairly
> > conservative so I wouldn't be surprised if it was that way back to the
> > beginning and remains that way for eternity. But it feels like a bad
> > pattern.
> 
> It is even part of the public API that `gzFile` is `typedef`'d to a
> pointer. So I think in the interest of simplicity, I'll leave it at that
> (but I'll mention this in the commit message).

I think that's probably OK. My biggest concern is that we'd notice if
our assumption changes, but I think modern compilers would generally
complain about checking a tautological truth value.

-Peff
