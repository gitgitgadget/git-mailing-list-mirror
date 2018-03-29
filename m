Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9F51F404
	for <e@80x24.org>; Thu, 29 Mar 2018 21:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeC2Vv4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 17:51:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:48072 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750735AbeC2Vv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 17:51:56 -0400
Received: (qmail 29933 invoked by uid 109); 29 Mar 2018 21:51:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 21:51:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22874 invoked by uid 111); 29 Mar 2018 21:52:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 17:52:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 17:51:54 -0400
Date:   Thu, 29 Mar 2018 17:51:54 -0400
From:   Jeff King <peff@peff.net>
To:     Erik E Brady <brady@cisco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] credential: ignore SIGPIPE when writing to credential
 helpers
Message-ID: <20180329215153.GJ2939@sigill.intra.peff.net>
References: <20180329175501.GE31833@sigill.intra.peff.net>
 <20180329180056.9941-1-brady@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180329180056.9941-1-brady@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 11:00:56AM -0700, Erik E Brady wrote:

> The credential subsystem can trigger SIGPIPE when writing to an
> external helper if that helper closes its stdin before reading the
> whole input. Normally this is rare, since helpers would need to read
> that input to make a decision about how to respond, but:
> 
> 1. It's reasonable to configure a helper which only handles "get"
>    while ignoring "store".  Such a handler might not read stdin
>    for "store", thereby rapidly closing stdin upon helper exit.
> 
> 2. A broken or misbehaving helper might exit immediately. That's an
>    error, but it's not reasonable for it to take down the parent Git
>    process with SIGPIPE.
> 
> Even with such a helper, seeing this problem should be rare. Getting
> SIGPIPE requires the helper racily exiting before we've written the
> fairly small credential output.
> 
> Signed-off-by: Erik E Brady <brady@cisco.com>
> ---
>  credential.c | 3 +++
>  1 file changed, 3 insertions(+)

This version looks good to me. Thanks!

-Peff
