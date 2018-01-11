Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA4D1F404
	for <e@80x24.org>; Thu, 11 Jan 2018 06:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeAKGUv (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 01:20:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:40838 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750916AbeAKGUv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 01:20:51 -0500
Received: (qmail 16587 invoked by uid 109); 11 Jan 2018 06:20:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Jan 2018 06:20:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21219 invoked by uid 111); 11 Jan 2018 06:21:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Jan 2018 01:21:24 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jan 2018 01:20:49 -0500
Date:   Thu, 11 Jan 2018 01:20:49 -0500
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'git mailing list' <git@vger.kernel.org>
Subject: Re: [PATCH] Replaced read with xread in transport-helper.c to fix
 SSIZE_MAX overun in t5509
Message-ID: <20180111062048.GA31213@sigill.intra.peff.net>
References: <010f01d38a9e$a5c4f290$f14ed7b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <010f01d38a9e$a5c4f290$f14ed7b0$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 11, 2018 at 12:40:05AM -0500, Randall S. Becker wrote:

> This fix was needed on HPE NonStop NSE where SSIZE_MAX is less than
> BUFFERSIZE resulting in EINVAL. The call to read in transport-helper.c
> was the only place outside of wrapper.c.

For my own curiosity, what is SSIZE_MAX on your platform? BUFFERSIZE is
only 64k. Do you really have 16-bit size_t?

I wondered if you would also need to set MAX_IO_SIZE, but it looks like
we default it to SSIZE_MAX.

-Peff
