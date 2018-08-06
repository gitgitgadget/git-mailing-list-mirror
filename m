Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0A94208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 13:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeHFPtG (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 11:49:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:43728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727541AbeHFPtG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 11:49:06 -0400
Received: (qmail 8932 invoked by uid 109); 6 Aug 2018 13:39:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Aug 2018 13:39:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25311 invoked by uid 111); 6 Aug 2018 13:39:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 Aug 2018 09:39:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2018 09:39:55 -0400
Date:   Mon, 6 Aug 2018 09:39:55 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add a script to diff rendered documentation
Message-ID: <20180806133954.GA31282@sigill.intra.peff.net>
References: <20180803205204.GA3790@sigill.intra.peff.net>
 <20180805204930.GA202464@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180805204930.GA202464@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 05, 2018 at 08:49:31PM +0000, brian m. carlson wrote:

> > +parallel=8
> 
> I'm not sure -j8 is a great default.  There are still a lot of
> two-core/four-thread machines out there, such as my laptop (from 2016).
> Maybe we should default this to 1 unless -j is provided, like make does.

I agree that "8" is arbitrary and probably not universally applicable. I
was just hoping to not have to say "-j8" every time I ran it (I already
"alias make='make -j8'" in my shell, but obviously it doesn't kick in
inside a script).

I guess some other options are:

  1. Respect a config variable. Which seems funny, since this isn't a
     git command.

  2. Respect an environment variable (we already do a similar thing with
     GIT_PERF_MAKE_OPTS, though it feels pretty clumsy).

     I've also considered just setting MAKEFLAGS=-j8 in my environment,
     but it always seemed like an abuse of a variable intended for
     communicating between makes.

  3. Default to number of CPUs, which is what a lot of other threading
     in Git does. Unfortunately getting that from the shell is
     non-trivial. I'm OK with $(grep -c ^processor /proc/cpuinfo), but
     people on non-Linux platforms would have to fill in their own
     implementation.

-Peff
