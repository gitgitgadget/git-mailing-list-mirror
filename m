Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7A6208DC
	for <e@80x24.org>; Sun, 27 Aug 2017 18:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbdH0SZr (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Aug 2017 14:25:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:50428 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751272AbdH0SZr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Aug 2017 14:25:47 -0400
Received: (qmail 26548 invoked by uid 109); 27 Aug 2017 18:25:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 27 Aug 2017 18:25:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28600 invoked by uid 111); 27 Aug 2017 18:26:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 27 Aug 2017 14:26:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Aug 2017 14:25:45 -0400
Date:   Sun, 27 Aug 2017 14:25:45 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
Message-ID: <20170827182545.e7athkdqkjnxrpna@sigill.intra.peff.net>
References: <20170827073732.546-1-martin.agren@gmail.com>
 <20170827154152.4n2ykna7e4l27fyn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170827154152.4n2ykna7e4l27fyn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 27, 2017 at 11:41:52AM -0400, Jeff King wrote:

> Ouch. So this means that git since v2.11 is basically leaking every
> non-byte pack sent by upload-pack (so all of the ref advertisement and
> want/have negotiation).

Determined experimentally that the answer is: yes.

The increase in ref advertisement is roughly linear with the size of
your packed-refs, so for most people this wasn't a big deal (and even if
you have insanely large packed-refs, it's "only" 2-3x the RAM;
potentially a problem, but only if you're close to the tipping point
already).

-Peff
