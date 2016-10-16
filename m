Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7A142098B
	for <e@80x24.org>; Sun, 16 Oct 2016 19:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757156AbcJPTnL (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 15:43:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:58081 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756546AbcJPTnK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 15:43:10 -0400
Received: (qmail 28109 invoked by uid 109); 16 Oct 2016 19:42:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Oct 2016 19:42:41 +0000
Received: (qmail 23537 invoked by uid 111); 16 Oct 2016 19:43:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Oct 2016 15:43:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Oct 2016 15:42:38 -0400
Date:   Sun, 16 Oct 2016 15:42:38 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/25] sequencer: completely revamp the "todo" script
 parsing
Message-ID: <20161016194238.wbge2pas5xr46av7@sigill.intra.peff.net>
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
 <cover.1476120229.git.johannes.schindelin@gmx.de>
 <4e73ba3e8c1700259ffcc3224d1f66e6a760142d.1476120229.git.johannes.schindelin@gmx.de>
 <933b13d6-5f24-c03a-a1a0-712ceb8ddcc8@web.de>
 <20161015171926.qgtvrjcaqwb436hx@sigill.intra.peff.net>
 <d9f4f658-94fb-cb9e-7da8-3a2fac120a9e@web.de>
 <20161015174656.fmgk3le2b34nnjpx@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610161006080.197091@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610161006080.197091@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 16, 2016 at 10:09:12AM +0200, Johannes Schindelin wrote:

> > Good catch. It technically needs to check the lower bound, too. In
> > theory, if somebody wanted to add an enum value that is negative, you'd
> > use a signed cast and check against both 0 and ARRAY_SIZE(). In
> > practice, that is nonsense for this case, and using an unsigned type
> > means that any negative values become large, and the check catches them.
> 
> I am pretty certain that I disagree with that warning: enums have been
> used as equivalents of ints for a long time, and will be, for a long time
> to come.

I'm not sure I agree. IIRC, Assigning values outside the range of an enum has
always been fishy according to the standard, and a compiler really is
allowed to allocate a single bit for storage for this enum.

> Given that this test is modified to `if (command < TODO_NOOP)` later, I
> hope that you agree that it is not worth the trouble to appease that
> compiler overreaction?

I don't mind if there are transient warnings on some compilers in the
middle of a series, but I'm not sure when "later" is. The tip of "pu"
has this warning right now when built with clang.

I'm happy to test the TODO_NOOP version against clang (and prepare a
patch on top if it still complains), but that doesn't seem to have
Junio's tree at all yet.

-Peff
