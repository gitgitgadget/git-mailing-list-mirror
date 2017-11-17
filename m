Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41F61202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 22:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932814AbdKQWGh (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 17:06:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:32978 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932716AbdKQWGf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 17:06:35 -0500
Received: (qmail 9108 invoked by uid 109); 17 Nov 2017 22:06:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Nov 2017 22:06:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28897 invoked by uid 111); 17 Nov 2017 22:06:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 17 Nov 2017 17:06:49 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Nov 2017 17:06:33 -0500
Date:   Fri, 17 Nov 2017 17:06:33 -0500
From:   Jeff King <peff@peff.net>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] config: avoid "write_in_full(fd, buf, len) != len"
 pattern
Message-ID: <20171117220633.6yoovfgpbr3rsykr@sigill.intra.peff.net>
References: <20171115124043.17147-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171115124043.17147-1-phillip.wood@talktalk.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 15, 2017 at 12:40:43PM +0000, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> As explained in commit 06f46f237 (avoid "write_in_full(fd, buf, len)
> != len" pattern, 2017–09–13) the return value of write_in_full() is
> either -1 or the requested number of bytes. As such comparing the
> return value to an unsigned value such as strbuf.len will fail to
> catch errors. Change the code to use the preferred '< 0' check.

Thanks for catching this. I wondered at first how I missed these obvious
cases, but the answer is that they were added after my commit. :)

There's one more case in write_section() that uses "==". That's not
actually wrong, but I wonder if we'd want to make it "< 0" for
consistency.

-Peff
