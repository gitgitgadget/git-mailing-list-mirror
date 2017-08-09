Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D2B8208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 21:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbdHIVNV (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 17:13:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:33808 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752066AbdHIVNU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 17:13:20 -0400
Received: (qmail 28120 invoked by uid 109); 9 Aug 2017 21:13:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 21:13:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31221 invoked by uid 111); 9 Aug 2017 21:13:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 17:13:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 17:13:18 -0400
Date:   Wed, 9 Aug 2017 17:13:18 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] http: drop support for curl < 7.16.0
Message-ID: <20170809211317.5znle4vq4zxf56af@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <20170809120157.il4ktf75wscqoyic@sigill.intra.peff.net>
 <CAGZ79kYUn_V81pRHsAuOoqNOpjfnng2NqLu7jPK93GM=LuvywQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYUn_V81pRHsAuOoqNOpjfnng2NqLu7jPK93GM=LuvywQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 10:29:04AM -0700, Stefan Beller wrote:

> >  Documentation/config.txt |  3 +--
> >  http-push.c              | 23 --------------------
> >  http-walker.c            | 12 -----------
> >  http.c                   | 56 +-----------------------------------------------
> >  http.h                   | 20 +----------------
> >  remote-curl.c            |  4 ----
> >  6 files changed, 3 insertions(+), 115 deletions(-)
> 
> `git grep USE_CURL_MULTI` also yields
> Documentation/config.txt
> t/t5540-http-push-webdav.sh
> 
> Would these also need adaption in this patch?

That one threw me off for a minute. How does a test even know about
USE_CURL_MULTI?

But it is just a bad error message. :) You cannot fix it by compiling
with "make USE_CURL_MULTI=1". The right message is more like "skipping
http-push tests, your curl is too old".

But that does mean there's another problem: Makefile can drop its
conditional curl_check for http-push.o. I'll add that to a re-roll.

-Peff
