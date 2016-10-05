Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1C3C1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 16:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754384AbcJEQMC (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 12:12:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:52814 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754260AbcJEQMB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 12:12:01 -0400
Received: (qmail 29677 invoked by uid 109); 5 Oct 2016 16:12:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Oct 2016 16:12:01 +0000
Received: (qmail 18074 invoked by uid 111); 5 Oct 2016 16:12:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Oct 2016 12:12:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Oct 2016 12:11:58 -0400
Date:   Wed, 5 Oct 2016 12:11:58 -0400
From:   Jeff King <peff@peff.net>
To:     James B <jamesbond3142@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        musl@lists.openwall.com, Rich Felker <dalias@libc.org>,
        git@vger.kernel.org
Subject: Re: [musl] Re: Regression: git no longer works with musl libc's
 regex impl
Message-ID: <20161005161158.62o7qmpwxdgf6zzk@sigill.intra.peff.net>
References: <20161004150848.GA7949@brightrain.aerifal.cx>
 <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
 <20161004154045.GT19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610041802310.35196@virtualbox>
 <20161005090625.683fdbbfac8164125dee6469@gmail.com>
 <alpine.DEB.2.20.1610051231390.35196@virtualbox>
 <20161005225934.770d73b7d491d4bf4816411d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161005225934.770d73b7d491d4bf4816411d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 05, 2016 at 10:59:34PM +1100, James B wrote:

> Number downloads does not make first-tier platform. You know that as
> well as everyone else.
> 
> First-tier support is the decision made by the maintainers that the
> entire features of the software must be available on those first tier
> platforms. So if Windows is indeed first-tier platform for git, it
> means any features that don't work on git version of Windows must not
> be used/developed or even castrated. That's a scary thought.

Prepare to be scared, then, I guess. Ever since the msysgit project
started years ago, we have made concessions in the code to work both
with POSIX-ish systems and with the msys layer. E.g., see how git-daemon
does not fork(), but actually re-spawns itself to handle connections.

When possible we try to put our abstractions at a level where they can
be implemented in a performant way on all platforms (the git-daemon
things is probably the _most_ ugly in that respect; I think nobody has
really cared about the performance enough to add back in a forking code
path for POSIX systems).

> So this decision that "Windows is now a first-tier platform for git" -
> is your own opinion, or is this the collective opinion of *all* the
> git maintainers?

There is only one maintainer of git: Junio. However, you'll note that I
also used "we" in the paragraphs above. And that is because the approach
I am talking about is something that has been done over the course of
many years by many members of the development community.

You may disagree with that approach, but it is nothing new. The msysgit
project started in 2007.

> Well thank you for being honest. I can see now why you responded the
> way you did (and still do). By being employed by Microsoft, and
> especially paid to work on Git for Windows, you have all the
> incentives to make it work best on Windows, and to make it as its
> first-tier platform within the limitation of Windows.

Please don't insinuate that Johannes is a Microsoft shill. He has been
working on the Windows port of Git for over 9 years, and was only
employed by Microsoft this year. Furthermore, his original REG_STARTEND
patch actually did a run-time fallback of NUL-terminating the input
buffers. It was _I_ who suggested that we should simply push people
towards our compat/regex routines instead. So if you want to be mad at
somebody, be mad at me.

-Peff
