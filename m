Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF4F71FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 16:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933216AbcLNQB3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 11:01:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:56444 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932575AbcLNQB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 11:01:29 -0500
Received: (qmail 4506 invoked by uid 109); 14 Dec 2016 16:01:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 16:01:26 +0000
Received: (qmail 26092 invoked by uid 111); 14 Dec 2016 16:02:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 11:02:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 11:01:24 -0500
Date:   Wed, 14 Dec 2016 11:01:24 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v9 3/5] http: always warn if libcurl version is too old
Message-ID: <20161214160123.a6a7fve5qz5xgg7n@sigill.intra.peff.net>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481679637-133137-4-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481679637-133137-4-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 05:40:35PM -0800, Brandon Williams wrote:

> diff --git a/transport.c b/transport.c
> index e1ba78b..fbd799d 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -700,11 +700,6 @@ void transport_check_allowed(const char *type)
>  		die("transport '%s' not allowed", type);
>  }
>  
> -int transport_restrict_protocols(void)
> -{
> -	return !!protocol_whitelist();
> -}
> -

This function was subtly broken as of patch 2 of the series. It's
probably not a big deal in the long run, but should the series be
re-ordered to put this one first?

I think the commit message would need adjusted, but it probably should
mention the reasons this is a good idea even _without_ the new config
system. Namely that even when there's no protocol whitelist, newer
versions of curl have all of the other non-http protocols disabled.

I wonder if anybody is actually using a version of curl old enough to
trigger this. If so, they're going to get the warning every time they
fetch via http. We might need to stick it behind an "advice.*" config
option, though I'm inclined to leave it as-is and see if anybody
actually complains.

-Peff
