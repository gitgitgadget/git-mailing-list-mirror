Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F21C54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 23:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D03720728
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 23:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgDZXOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 19:14:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:40434 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726196AbgDZXOL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 19:14:11 -0400
Received: (qmail 7464 invoked by uid 109); 26 Apr 2020 23:14:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 26 Apr 2020 23:14:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18247 invoked by uid 111); 26 Apr 2020 23:25:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Apr 2020 19:25:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 26 Apr 2020 19:14:10 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Paul Smith <paul@mad-scientist.net>, Git List <git@vger.kernel.org>
Subject: Re: Git configure with static curl is failing
Message-ID: <20200426231410.GA1702090@coredump.intra.peff.net>
References: <9d9fe8376e47a9f5330cd644c76d96987fc67c57.camel@mad-scientist.net>
 <20200426194729.GD6421@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200426194729.GD6421@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 26, 2020 at 07:47:29PM +0000, brian m. carlson wrote:

> On 2020-04-26 at 19:01:54, Paul Smith wrote:
> > The problem appears to be that configure.ac is not using curl-config to
> > obtain the correct options to link with curl.  If I run
> > /other/curl/bin/curl-config --lib I get the proper flags:
> > 
> >   $ /other/curl/bin/curl-config --libs
> >   -L/other/curl/lib -lcurl -lssl -lz -lcrypto -ldl -lpthread
> > 
> > If configure.ac tried to use $CURLDIR/bin/curl-config --libs to obtain
> > the right linker options, then the link test for curl would work.
> 
> It doesn't surprise me that configure.ac doesn't use curl-config.  The
> configure script is generally not used by the main developers in favor
> of just using the makefile itself.
> 
> While we should fix that, the makefile does use curl-config, so if you
> just use it with any appropriate options without running configure, it
> will probably work for you.

Usually, yes, though it doesn't use `curl-config --cflags` properly. See
the series at [1]. What's there now, though might be enough for Paul's
case (if it's just a link-time issue).

I do think the autoconf code could do a better job of using curl-config,
along with a few other improvements. I left some thoughts in that
thread.

-Peff

[1] https://lore.kernel.org/git/20200326080540.GA2200522@coredump.intra.peff.net/
