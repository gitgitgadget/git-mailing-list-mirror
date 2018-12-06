Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 233CB211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 05:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbeLFFf2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 00:35:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:60648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728758AbeLFFf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 00:35:27 -0500
Received: (qmail 32157 invoked by uid 109); 6 Dec 2018 05:35:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Dec 2018 05:35:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6580 invoked by uid 111); 6 Dec 2018 05:34:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Dec 2018 00:34:55 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2018 00:35:25 -0500
Date:   Thu, 6 Dec 2018 00:35:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a
 test repeatedly under load
Message-ID: <20181206053525.GA29481@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-4-szeder.dev@gmail.com>
 <20181205054408.GE12284@sigill.intra.peff.net>
 <20181205103454.GJ30222@szeder.dev>
 <20181205213625.GD19936@sigill.intra.peff.net>
 <xmqqefavbj28.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefavbj28.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 06, 2018 at 09:22:23AM +0900, Junio C Hamano wrote:

> > So the right number of waits is either "1" or "2". Looping means we do
> > too many (which is mostly a harmless noop) or too few (in the off chance
> > that you have only a single job ;) ). So it works out in practice.
> 
> Well, if you time your ^C perfectly, no number of waits is right, I
> am afraid.  You spawn N processes and while looping N times waiting
> for them, you can ^C out of wait before these N processes all die,
> no?

Each "wait" will try to collect all processes, but may be interrupted by
a signal. So the correct number is actually "1 plus the number of times
the user hits ^C". I had assumed the user was just hitting it once,
though putting the wait into the trap means we do that "1 plus" thing
anyway.

I could also see an argument that subsequent ^C's should exit
immediately, but I think we are getting well into the realm of
over-engineering.

-Peff
