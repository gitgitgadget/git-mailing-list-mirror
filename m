Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0904520374
	for <e@80x24.org>; Tue,  5 Mar 2019 19:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCETPW (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 14:15:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:39768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726249AbfCETPV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 14:15:21 -0500
Received: (qmail 20170 invoked by uid 109); 5 Mar 2019 19:15:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 19:15:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1620 invoked by uid 111); 5 Mar 2019 19:15:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 05 Mar 2019 14:15:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2019 14:15:19 -0500
Date:   Tue, 5 Mar 2019 14:15:19 -0500
From:   Jeff King <peff@peff.net>
To:     Fabio Aiuto <polinice83@libero.it>
Cc:     git@vger.kernel.org
Subject: Re: Can't build first git commit
Message-ID: <20190305191519.GA12791@sigill.intra.peff.net>
References: <1551729517.4092.1.camel@libero.it>
 <20190304204007.GA32691@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190304204007.GA32691@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 04, 2019 at 03:40:07PM -0500, Jeff King wrote:

> You can patch the Makefile, or just override it like:
> 
>   make LIBS='-lcrypto -lz'
> 
> which builds for me on current Debian unstable. I don't think you can
> actually fetch with that old build, but I used periodically check that
> Git v1.0 can fetch happily from GitHub. I haven't in a while, so let me
> know if you try it and it doesn't work. ;)

I just tried this, and it does indeed work. I had to build v1.0.0 with

  make NO_OPENSSL=Nope

I think the issue is that some old code embedded openssl's BIGNUM in a
struct, and later versions of openssl stopped publicly defining the
types.

I was able to clone git://github.com/git/git with the result, though of
course it chokes no the sha1collisiondetection submodule. You can still
use "git log", though, and checkout older commits.

-Peff
