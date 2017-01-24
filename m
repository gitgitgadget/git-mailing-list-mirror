Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DBAE1F89C
	for <e@80x24.org>; Tue, 24 Jan 2017 13:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbdAXNoe (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 08:44:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:43801 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750734AbdAXNod (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 08:44:33 -0500
Received: (qmail 7331 invoked by uid 109); 24 Jan 2017 13:44:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 13:44:32 +0000
Received: (qmail 22886 invoked by uid 111); 24 Jan 2017 13:44:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 08:44:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jan 2017 08:44:30 -0500
Date:   Tue, 24 Jan 2017 08:44:30 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] string-list: make string_list_sort() reentrant
Message-ID: <20170124134430.am6yzskkcp2vq6a5@sigill.intra.peff.net>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
 <20170123235445.qsejumltutd2vrhd@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701241233390.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.20.1701241233390.3469@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 12:44:10PM +0100, Johannes Schindelin wrote:

> Hi Peff,
> 
> On Mon, 23 Jan 2017, Jeff King wrote:
> 
> > Is there any interest in people adding the ISO qsort_s() to their libc
> > implementations? It seems like it's been a fair number of years by now.
> 
> Visual C supports it *at least* since Visual Studio 2005:
> 
> https://msdn.microsoft.com/en-us/library/4xc60xas(v=vs.80).aspx
> 
> With René's patch, we have an adapter for GNU libc, and if anybody comes
> up with the (equally trivial) adapter for BSD libc's qsort_r(), we have a
> lot of bases covered.

Sadly, no. Microsoft's qsort_s() is not compatible with the ISO C one.
And BSD's qsort_r() has a similar problem acting as a wrapper, because
the order of arguments in the callback functions is different (so you'd
have to actually wrap the callback, too, and rearrange the arguments for
each call, or do some macro trickery).

Gory details are in:

  https://stackoverflow.com/questions/39560773/different-declarations-of-qsort-r-on-mac-and-linux/39561369

and the original thread:

  http://public-inbox.org/git/3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de/

-Peff
