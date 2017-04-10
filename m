Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A152820966
	for <e@80x24.org>; Mon, 10 Apr 2017 16:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbdDJQgO (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 12:36:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:59257 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751792AbdDJQgA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 12:36:00 -0400
Received: (qmail 8999 invoked by uid 109); 10 Apr 2017 16:36:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 16:36:00 +0000
Received: (qmail 26531 invoked by uid 111); 10 Apr 2017 16:36:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 12:36:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 12:35:58 -0400
Date:   Mon, 10 Apr 2017 12:35:58 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test
 script
Message-ID: <20170410163557.gn3mlcalfhhncbtt@sigill.intra.peff.net>
References: <20170410125911.6800-1-szeder.dev@gmail.com>
 <20170410135837.2ukgksfxdlcfqldy@sigill.intra.peff.net>
 <CAM0VKj=4Utapk9iFasChkPSdkWxB5WiHtpZGPUYKMC5LKrnGXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKj=4Utapk9iFasChkPSdkWxB5WiHtpZGPUYKMC5LKrnGXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 06:31:54PM +0200, SZEDER Gábor wrote:

> Indeed this seems to work, and luckily we don't need that much
> hackery.  When there is a single variable assignment and the expansion
> of a command substitution is assigned to the variable, then the exit
> status is that of the command inside the command substitution, i.e.
> 
>   $ v=$(false) ; echo $?
>   1
> 
> This means we can write this simply as:
> 
>   doesnt_matter=$(git gc --auto 9>&1)
> 
> It's still hackery :)

Heh. Yeah, I would call that _more_ hackery in that it's much more
clever. But it is shorter. :)

I think as long as the trickery is documented that's OK (and calling it
doesnt_matter and explaining in the commit message is fine by me;
hopefully that name would induce somebody to look in the history).

> OTOH, this makes it possible to continue the test reliably after the
> gc finished in the background, so we could also check that there is
> only a single pack file left, i.e. that the detached gc did what it
> was supposed to do.

Yes, I think the test can and should check the after-gc state.

-Peff
