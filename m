Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E217202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbdIVQW4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:22:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:46996 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752055AbdIVQWy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:22:54 -0400
Received: (qmail 26156 invoked by uid 109); 22 Sep 2017 16:22:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 16:22:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4444 invoked by uid 111); 22 Sep 2017 16:23:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Sep 2017 12:23:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Sep 2017 12:22:51 -0400
Date:   Fri, 22 Sep 2017 12:22:51 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] cache.h: hex2chr() - avoid -Wsign-compare warnings
Message-ID: <20170922162251.kx2w5u4falztcpnh@sigill.intra.peff.net>
References: <ae537e7e-2c3d-f7f3-28f4-451c37c01bbb@ramsayjones.plus.com>
 <20170922054748.iseinawwwfw56vis@sigill.intra.peff.net>
 <89beb424-2cc0-bfe3-7847-c11035bfec70@ramsayjones.plus.com>
 <20170922161159.hkw4id4kpnwo7jou@sigill.intra.peff.net>
 <20170922161817.iy5tpexouxn5uwsb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170922161817.iy5tpexouxn5uwsb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2017 at 12:18:17PM -0400, Jeff King wrote:

> > I think if this function is fed an empty string that it will also read
> > past the end of the buffer for in[1]. It shouldn't matter, since the NUL
> > in in[0] would cause us to return an error regardless, but it's still
> > undefined behavior.
> 
> This is still a bug, though.

Last message, I promise. ;)

I started on the minimal fix for this, but actually it's OK by virtue of
its sole caller first checking that we have enough length (because we're
not parsing a string, in fact, but a ptr/len buffer).

So all is well, though I think get_hex_color() does serve as a poor
example if somebody were to try to adapt it generally (hopefully they
wouldn't, since hex2chr() is already globally available).

Sorry for the all the noise.

-Peff
