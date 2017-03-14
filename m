Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D674201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 16:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbdCNQcB (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 12:32:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:44001 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750819AbdCNQcA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 12:32:00 -0400
Received: (qmail 14663 invoked by uid 109); 14 Mar 2017 16:31:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Mar 2017 16:31:59 +0000
Received: (qmail 5464 invoked by uid 111); 14 Mar 2017 16:32:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Mar 2017 12:32:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Mar 2017 12:31:56 -0400
Date:   Tue, 14 Mar 2017 12:31:56 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Wincent Colaiuta <win@wincent.com>,
        Mislav =?utf-8?B?TWFyb2huacSH?= <mislav.marohnic@gmail.com>
Subject: Re: [PATCH] add--interactive: do not expand pathspecs with ls-files
Message-ID: <20170314163156.qhfvdphqohbexm4h@sigill.intra.peff.net>
References: <20170314163024.et2cp5e3imrrrf7k@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170314163024.et2cp5e3imrrrf7k@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 14, 2017 at 12:30:24PM -0400, Jeff King wrote:

>   2. Even when it does work, it's really slow. The pathspec
>      code is not optimized for huge numbers of paths. Here's
>      the same case without the ulimit:
> 
>        $ time git add -p drivers
>        No changes.
> 
>        real	0m16.559s
>        user	0m53.140s
>        sys	0m0.220s

By the way, I wondered how we managed to consume more CPU than
wall-clock time. I think the answer is that diff-files does the pathspec
matching during the threaded preload stage.

-Peff
