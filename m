Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6039C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 02:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAA561BF9
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 02:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhKQDBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 22:01:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:60700 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232816AbhKQDBI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 22:01:08 -0500
Received: (qmail 21805 invoked by uid 109); 17 Nov 2021 02:58:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Nov 2021 02:58:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6514 invoked by uid 111); 17 Nov 2021 02:58:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Nov 2021 21:58:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Nov 2021 21:58:09 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/1] git-compat-util: add a test balloon for C99
 support
Message-ID: <YZRvwfIaAODilQc3@coredump.intra.peff.net>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-2-sandals@crustytoothpaste.net>
 <YZOh370ZMMqSADUE@coredump.intra.peff.net>
 <YZRedzMSodOYjjPP@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZRedzMSodOYjjPP@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 01:44:23AM +0000, brian m. carlson wrote:

> > Do most compilers understand -std=gnu99? It seems like we're breaking
> > the out-of-the-box build for everything that isn't gcc or clang.
> 
> I'm pretty sure -Wall is GCC- and clang-specific, as is -Wl,-rpath, so I
> think we've already crossed that bridge.  There are places in
> config.mak.uname where they're specifically overridden for that reason.

That's a good point. I guess we don't really have good data on how many
people will be (newly) affected either way.

> > I understand that older versions of gcc (prior to 5.1.0, from my
> > digging) default to gnu89, and so they would be broken _without_ this.
> > So it is a tradeoff one way or the other. But somehow this seems
> > backwards to me. We should assume that modern compilers support C99 out
> > of the box, and put the burden on older ones to trigger C99 support in
> > whatever non-portable way they need.
> 
> We'll have to adjust the CI job that builds with GCC 4.8, but I can do
> that.  I just am not eager to hear complaints from people that it
> doesn't work out of the box, especially since CentOS 7 is going to hit
> this case.

Nor am I. I wonder if there's a way we can make it work out of the box
everywhere. Using detect-compiler more widely would be one way to do
that, though that's a bigger change to the Makefile in general. I kind
of wonder if we could just assume in config.mak.uname that Linux will
always have a compiler that understands -std=gnu99.

-Peff
