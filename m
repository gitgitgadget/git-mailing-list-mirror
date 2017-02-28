Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F857201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 14:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbdB1Ofw (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 09:35:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:35664 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751431AbdB1Ofv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 09:35:51 -0500
Received: (qmail 30870 invoked by uid 109); 28 Feb 2017 14:28:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 14:28:04 +0000
Received: (qmail 26527 invoked by uid 111); 28 Feb 2017 14:28:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 09:28:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 09:28:02 -0500
Date:   Tue, 28 Feb 2017 09:28:02 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Use time_t
Message-ID: <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1488231002.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 10:30:20PM +0100, Johannes Schindelin wrote:

> One notable fallout of this patch series is that on 64-bit Linux (and
> other platforms where `unsigned long` is 64-bit), we now limit the range
> of dates to LONG_MAX (i.e. the *signed* maximum value). This needs to be
> done as `time_t` can be signed (and indeed is at least on my Ubuntu
> setup).
> 
> Obviously, I think that we can live with that, and I hope that all
> interested parties agree.

I do not just agree, but I think the move to a signed timestamp is a big
improvement. Git's object format is happy to represent times before
1970, but the code is not. I know this has been a pain for people who
import ancient histories into Git.

It looks from the discussion like the sanest path forward is our own
signed-64bit timestamp_t. That's unfortunate compared to using the
standard time_t, but hopefully it would reduce the number of knobs (like
TIME_T_IS_INT64) in the long run.

-Peff
