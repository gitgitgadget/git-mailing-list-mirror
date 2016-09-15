Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 058F02070F
	for <e@80x24.org>; Thu, 15 Sep 2016 18:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbcIOStM (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 14:49:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:43842 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752706AbcIOStL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 14:49:11 -0400
Received: (qmail 21891 invoked by uid 109); 15 Sep 2016 18:49:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 18:49:10 +0000
Received: (qmail 11227 invoked by uid 111); 15 Sep 2016 18:49:21 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 14:49:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2016 11:49:07 -0700
Date:   Thu, 15 Sep 2016 11:49:07 -0700
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] object: measure time needed for resolving hash collisions
Message-ID: <20160915184906.hocai2ho4mkx6n6s@sigill.intra.peff.net>
References: <20160915020141.32000-1-sbeller@google.com>
 <20160915064701.c4ishixuynbzpgwx@sigill.intra.peff.net>
 <CAGZ79kZ-rLVijKj31uYgYrLkSCCOaLKWrr8u=6LXnd=gmma+xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ-rLVijKj31uYgYrLkSCCOaLKWrr8u=6LXnd=gmma+xQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 09:26:22AM -0700, Stefan Beller wrote:

> > It may also be possible to really micro-optimize it on some platforms,
> > because we know the size in advance (I'd kind of expect the compiler to
> > do that, but if we're ending up in glibc memcmp then it sounds like it
> > is not the case).
> 
> That stackoverflow link suggests that glibc already has microoptimisations
> for a variety of platforms.

It's definitely micro-optimized in glibc. What I was trying to say is
that if we are hitting the glibc implementation, then we know we are
handling the "20" at runtime. Whereas the compiler should know that "20"
is a constant, and could in theory skip the memcmp() call entirely in
favor of something like an unrolled loop.

-Peff
