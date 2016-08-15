Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B05451F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 18:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbcHOSrg (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 14:47:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:55665 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752316AbcHOSrf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 14:47:35 -0400
Received: (qmail 3534 invoked by uid 109); 15 Aug 2016 18:47:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 18:47:33 +0000
Received: (qmail 17950 invoked by uid 111); 15 Aug 2016 18:47:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 14:47:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 14:47:31 -0400
Date:	Mon, 15 Aug 2016 14:47:31 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr
Subject: Re: [PATCH 2/2] checkout: do not mention detach advice for explicit
 --detach option
Message-ID: <20160815184730.eevqogqrxp2zp43q@sigill.intra.peff.net>
References: <20160815184021.12396-1-sbeller@google.com>
 <20160815184021.12396-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160815184021.12396-2-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 11:40:21AM -0700, Stefan Beller wrote:

> When a user asked for a detached HEAD specifically with `--detach`,
> we do not need to give advice on what a detached HEAD state entails as
> we can assume they know what they're getting into as they asked for it.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
>  Junio writes:
>  > It might be controversial how the second from the last case should
>  > behave, though.
>  
>  I agree. I think if the advice is configured explicitly we can still give it.
>  That makes the code a bit more complicated though.

So....I guess. But has anybody in the history of git ever explicitly
configured advice.* to true?

It has never produced any change of behavior, and the whole point of
"advice.*" was that git would advise by default, and you would use
advice.* to shut it up once you were sufficiently educated.

I don't think doing it this way is _wrong_. It just feels sort of
pointlessly over-engineered. It's also a little weird that all of the:

  if (advice_foo)

will trigger because "advice_foo" is set to -1. I think it does the
right thing, but it feels like a bug (the value is now a tri-state, and
we silently collapse two states into one).

-Peff
