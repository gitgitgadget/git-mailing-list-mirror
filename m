Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71FF2208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 21:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbdHIVRi (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 17:17:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:33834 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752047AbdHIVRh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 17:17:37 -0400
Received: (qmail 28326 invoked by uid 109); 9 Aug 2017 21:17:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 21:17:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31275 invoked by uid 111); 9 Aug 2017 21:18:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 17:18:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 17:17:35 -0400
Date:   Wed, 9 Aug 2017 17:17:35 -0400
From:   Jeff King <peff@peff.net>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] http: drop support for curl < 7.16.0
Message-ID: <20170809211734.dcyo2gppznzk6kng@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <20170809120157.il4ktf75wscqoyic@sigill.intra.peff.net>
 <xmqq1sok7i82.fsf@gitster.mtv.corp.google.com>
 <38dfdc54-65ea-694a-4b72-fe0006a008cf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38dfdc54-65ea-694a-4b72-fe0006a008cf@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 08:03:05PM +0200, Nicolas Morey-Chaisemartin wrote:

> >> -#if LIBCURL_VERSION_NUM >= 0x071700
> >> -/* Use CURLOPT_KEYPASSWD as is */
> >> -#elif LIBCURL_VERSION_NUM >= 0x070903
> >> -#define CURLOPT_KEYPASSWD CURLOPT_SSLKEYPASSWD
> >> -#else
> >> -#define CURLOPT_KEYPASSWD CURLOPT_SSLCERTPASSWD
> >> -#endif
> >> -
> > This part I am not sure.  Don't we still need to substitute
> > CURLOPT_KEYPASSWD with CURLOPT_SSLKEYPASSWD for versions below
> > 071700, e.g. 071000 which is 7.16.0?
> According to the documentation:
> 
> https://curl.haxx.se/libcurl/c/CURLOPT_KEYPASSWD.html
> This option was known as CURLOPT_SSLKEYPASSWD up to 7.16.4 and
> CURLOPT_SSLCERTPASSWD up to 7.9.2.
> 
> 
> So the patch breaks things (broken for 7.16.[0-4]). But the series
> does not as the next patch ensure at least 7.19.4

But the #ifdef above says 071700, which is 7.23.0. I wonder if we just
got it wrong back then (maybe hex confusion with 7.17.0?). I have a
build setup for old versions of curl, so I'll double-check that 7.19.4
builds with KEYPASSWD. And dig in the history to see if there's any
comment on this mismatch.

-Peff
