Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0655A1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 14:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388696AbeGKOui (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 10:50:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:55300 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726689AbeGKOuh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 10:50:37 -0400
Received: (qmail 11237 invoked by uid 109); 11 Jul 2018 14:45:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Jul 2018 14:45:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7573 invoked by uid 111); 11 Jul 2018 14:45:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 11 Jul 2018 10:45:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jul 2018 10:45:55 -0400
Date:   Wed, 11 Jul 2018 10:45:55 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [RFC PATCH 4/4] t/lib-httpd: sort log based on timestamp to
 avoid occasional failure
Message-ID: <20180711144555.GA15269@sigill.intra.peff.net>
References: <20180614123107.11608-1-szeder.dev@gmail.com>
 <20180614123107.11608-5-szeder.dev@gmail.com>
 <20180614175325.GA14935@sigill.intra.peff.net>
 <CAM0VKjmXoOaYFrkNJzNp_wgzReaXSZHiDCtJRADX0RRG123wPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjmXoOaYFrkNJzNp_wgzReaXSZHiDCtJRADX0RRG123wPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 02:53:23PM +0200, SZEDER Gábor wrote:

> > I.e., could we have a situation where we make a request, the client
> > finishes, and then we look at the logs, but nothing has been written by
> > apache yet?
> 
> That's possible, I suppose.  Highly improbable, but possible.  Or the
> log entries can be written only partially by the time we look at them.

Digging into earlier cases I had seen on my local box, my impression was
that this was the problem I was seeing (not reordering). But it's
entirely possible that I was confused by reordering. I've been trying to
reproduce, but after 5 minutes of t5561 running in a tight loop under
high load, I haven't gotten a single failure.

> Anyway, I would prefer not to do anything about it just yet, because
> I'm curious :) and I'd like to see whether this actually happens in
> practice.

I can't reproduce for now, so I'm happy either way. :)

> > What if the test script provides the in-order expectation, but we check
> > only the unordered version (by sorting both actual and expected output
> > on the fly)? That would give us a more relaxed check most of the time,
> > but somebody digging in to a failure could run the ordered diff (or we
> > could even show it automatically on failure instead of just using
> > test_cmp).
> 
> this is the fix I'll go for in v2.

Great. That seems much simpler to reason about. I'll take a look.

-Peff
