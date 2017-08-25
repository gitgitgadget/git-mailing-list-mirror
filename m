Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14358208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 17:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754697AbdHYREP (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 13:04:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:49228 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754410AbdHYREP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 13:04:15 -0400
Received: (qmail 31886 invoked by uid 109); 25 Aug 2017 17:04:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Aug 2017 17:04:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19629 invoked by uid 111); 25 Aug 2017 17:04:43 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Aug 2017 13:04:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Aug 2017 10:04:12 -0700
Date:   Fri, 25 Aug 2017 10:04:12 -0700
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ThreadSanitizer: add suppressions
Message-ID: <20170825170411.qo6miyd46hfg6jzw@sigill.intra.peff.net>
References: <cover.1502780343.git.martin.agren@gmail.com>
 <cover.1503323390.git.martin.agren@gmail.com>
 <09bbbcd1429a28774ea2d8c67ef6106ab558c296.1503323391.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09bbbcd1429a28774ea2d8c67ef6106ab558c296.1503323391.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2017 at 07:43:48PM +0200, Martin Ågren wrote:

> Add a file .tsan-suppressions and list two functions in it: want_color()
> and transfer_debug(). Both of these use the pattern
> 
> 	static int foo = -1;
> 	if (foo < 0)
> 		foo = bar();
> 
> where bar always returns the same non-negative value. This can cause
> ThreadSanitizer to diagnose a race when foo is written from two threads.
> That is indeed a race, although it arguably doesn't matter in practice
> since it's always the same value that is written.
> 
> Add NEEDSWORK-comments to the functions so that this problem is not
> forever swept way under the carpet.
> 
> The suppressions-file is used by setting the environment variable
> TSAN_OPTIONS to, e.g., "suppressions=$(pwd)/.tsan-suppressions". Observe
> that relative paths such as ".tsan-suppressions" might not work.

This looks good to me.

-Peff
