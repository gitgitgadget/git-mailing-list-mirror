Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50DB51FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 13:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbcLENIq (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 08:08:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:51724 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbcLENIp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 08:08:45 -0500
Received: (qmail 22622 invoked by uid 109); 5 Dec 2016 13:08:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 13:08:30 +0000
Received: (qmail 4344 invoked by uid 111); 5 Dec 2016 13:09:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 08:09:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2016 08:08:28 -0500
Date:   Mon, 5 Dec 2016 08:08:28 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>
Subject: Re: [PATCH 0/6] restricting http redirects
Message-ID: <20161205130828.3yk2y6yschthoyx6@sigill.intra.peff.net>
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 04:03:37AM -0500, Jeff King wrote:

> Jann Horn brought up on the git-security list some interesting
> social-engineering attacks around the way Git handles HTTP redirects.
> These patches are my attempt to harden our redirect handling against
> these attacks.

There's one other possible attack I thought of while discussing [1],
that is worth mentioning.

We limited the number of http redirects in b25811646 (http: limit
redirection depth, 2015-09-22). But what about http-alternates? Could
you redirect to yourself via http-alternates and convince a client to
loop infinitely?

It looks like no, because we do not seem to handle recursive
alternates at all in the http walker. Which means that repositories with
recursive local alternates cannot be fetched over dumb-http. But it also
means that we don't have to worry about limiting the recursion depth.

-Peff

[1] http://public-inbox.org/git/fe33de5b5f0b3da68b249cc4a49a6d7@3c843fe6ba8f3c586a21345a2783aa0/
