Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 334361F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 13:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeJJVWM (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 17:22:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:35444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726515AbeJJVWM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 17:22:12 -0400
Received: (qmail 22743 invoked by uid 109); 10 Oct 2018 13:59:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Oct 2018 13:59:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17138 invoked by uid 111); 10 Oct 2018 13:59:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Oct 2018 09:59:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2018 09:59:52 -0400
Date:   Wed, 10 Oct 2018 09:59:52 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
Message-ID: <20181010135952.GA2933@sigill.intra.peff.net>
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
 <20181005124048.GT23446@localhost>
 <20181005162517.GB11254@sigill.intra.peff.net>
 <20181005183904.GV23446@localhost>
 <20181005190216.GB17482@sigill.intra.peff.net>
 <20181005195413.GX23446@localhost>
 <20181009031542.GD6250@sigill.intra.peff.net>
 <20181010114441.GD23446@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181010114441.GD23446@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 01:44:41PM +0200, SZEDER Gábor wrote:

> > So that's really weird and counter-intuitive, since we should be doing
> > strictly less work. I know that spatch tries to parallelize itself,
> > though from my tests, 1.0.4 does not. I wonder if the version in Travis
> > differs in that respect and starts too many threads, and the extra time
> > is going to contention and context switches.
> 
> I don't think it does any parallel work.
> 
> Here is the timing again from my previous email:
> 
>   960.50user 22.59system 16:23.74elapsed 99%CPU (0avgtext+0avgdata 1606156maxresident)k
> 
> Notice that 16:23 is 983s, and that it matches the sum of the user and
> system times.  I usually saw this kind of timing with CPU-intensive
> single-threaded programs, and if there were any parallelization, then I
> would expect the elapsed time to be at least somewhat smaller than the
> other two.

Ah, right, I should have been able to figure that out myself. So scratch
that theory. My "hypervisor stalling our memory reads" theory is still
plausible, but I don't know how we would test it.

I guess in some sense it doesn't matter. If it's slower, we're not
likely to be able to fix that. So I guess we just need the fallback to
the current behavior.

-Peff
