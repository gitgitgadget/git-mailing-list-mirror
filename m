Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ADC7203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 02:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965083AbcKKCKC (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 21:10:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:41494 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935107AbcKKCKB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 21:10:01 -0500
Received: (qmail 28894 invoked by uid 109); 11 Nov 2016 02:10:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Nov 2016 02:10:00 +0000
Received: (qmail 10096 invoked by uid 111); 11 Nov 2016 02:10:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 21:10:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2016 21:09:58 -0500
Date:   Thu, 10 Nov 2016 21:09:58 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: do not redundantly calculate tag refmap
Message-ID: <20161111020958.ozzbwrvmo5fdf3jj@sigill.intra.peff.net>
References: <1478823208-10647-1-git-send-email-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1478823208-10647-1-git-send-email-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2016 at 04:13:28PM -0800, Jonathan Tan wrote:

> builtin/fetch.c redundantly calculates refmaps for tags twice. Remove
> the first calculation.
> 
> This is only a code simplification and slight performance improvement -
> the result is unchanged, as the redundant refmaps are subsequently
> removed by the invocation to "ref_remove_duplicates" anyway.
> 
> This was introduced in commit c5a84e9 ("fetch --tags: fetch tags *in
> addition to* other stuff", 2013-10-29) when modifying the effect of the
> --tags parameter to "git fetch". The refmap-for-tag calculation was
> copied instead of moved.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> 
> (I noticed this when working on something in this file.)

Coincidentally I noticed this a few weeks ago, too, while working on
[1], but didn't follow it up. Mainly I was worried there was something
hidden or clever going on, but I think it really is just a case of the
code growing the two calls over time. So this looks good to me. Thanks
for digging it up.

-Peff

[1] http://public-inbox.org/git/20161024132932.i42rqn2vlpocqmkq@sigill.intra.peff.net/
