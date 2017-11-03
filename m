Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3585D20450
	for <e@80x24.org>; Fri,  3 Nov 2017 18:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbdKCSim (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 14:38:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:45740 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751415AbdKCSik (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 14:38:40 -0400
Received: (qmail 32417 invoked by uid 109); 3 Nov 2017 18:38:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Nov 2017 18:38:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3656 invoked by uid 111); 3 Nov 2017 18:38:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Nov 2017 14:38:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Nov 2017 14:38:36 -0400
Date:   Fri, 3 Nov 2017 14:38:36 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Andrew Baumann <Andrew.Baumann@microsoft.com>
Subject: Re: [PATCH] setup: avoid double slashes when looking for HEAD
Message-ID: <20171103183836.zpsspuj2xbufuu7u@sigill.intra.peff.net>
References: <9322728aaa3010c0b71574eb5876548487d66885.1509713589.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9322728aaa3010c0b71574eb5876548487d66885.1509713589.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 03, 2017 at 01:58:02PM +0100, Johannes Schindelin wrote:

> From: Jeff King <peff@peff.net>
> 
> Andrew Baumann reported that when called outside of any Git worktree,
> `git rev-parse --is-inside-work-tree` eventually tries to access
> `//HEAD`, i.e.  any `HEAD` file in the root directory, but with a double
> slash.
> 
> This double slash is not only unintentional, but is allowed by the POSIX
> standard to have a special meaning. And most notably on Windows, it
> does, where it refers to a UNC path of the form `//server/share/`.
> 
> As a consequence, afore-mentioned `rev-parse` call not only looks for
> the wrong thing, but it also causes serious delays, as Windows will try
> to access a server called `HEAD`.  Let's simply avoid the unintended
> double slash.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks, this explanation looks good to me (and the patch is flawless, of
course ;) ).

-Peff
