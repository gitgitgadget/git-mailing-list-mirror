Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB2D20986
	for <e@80x24.org>; Wed, 19 Oct 2016 21:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941852AbcJSVFX (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 17:05:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:59676 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933143AbcJSVFW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 17:05:22 -0400
Received: (qmail 18514 invoked by uid 109); 19 Oct 2016 21:05:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 21:05:21 +0000
Received: (qmail 17729 invoked by uid 111); 19 Oct 2016 21:05:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 17:05:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 17:05:19 -0400
Date:   Wed, 19 Oct 2016 17:05:19 -0400
From:   Jeff King <peff@peff.net>
To:     Jan Keromnes <janx@linux.com>
Cc:     git@vger.kernel.org
Subject: Re: [regression] `make profile-install` fails in 2.10.1
Message-ID: <20161019210519.ubk5q54rrvbafch7@sigill.intra.peff.net>
References: <CAA6PgK5vtnZSqqZafMVGoy0Rv38=8e__uQvXaf2SyPePHuPjJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAA6PgK5vtnZSqqZafMVGoy0Rv38=8e__uQvXaf2SyPePHuPjJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 01:15:56PM +0200, Jan Keromnes wrote:

> - Problem: Is there a way to `make profile-install` but ignore
> occasional test failures, as these are not critical to get a useful
> hardware profile? (Note: In a previous thread, Dennis Kaarsemaker
> mentioned this is fixing a symptom, not the root cause, but it would
> still be great to get a working profile in spite of occasional test
> failures.)

No, there isn't a way currently. I agree with Dennis that we do want to
ultimately fix the flaky tests, but at the same time, it does seem
reasonable to use a partial test run for your profile results.

I suspect you'd need to switch the call to:

  $(MAKE) PROFILE=GEN -j1 -k test || true

to make it best-effort.

> - Related problem: `t3700-add.sh` fails again in 2.10.1 for me. More
> details below, and I can provide further debug information if you
> don't already know the problem.

I can't reproduce any problems with raciness there, but there is a known
problem with running the script as root (which I guess you might be
doing from your "make prefix=/usr" call). There's some discussion in
http://public-inbox.org/git/20161010035756.38408-1-jeremyhu@apple.com/T/#u,
but it looks like the patch stalled.

-Peff
