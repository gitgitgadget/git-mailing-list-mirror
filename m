Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 806F020357
	for <e@80x24.org>; Tue, 11 Jul 2017 08:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755444AbdGKIYj (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 04:24:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:36708 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754510AbdGKIYi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 04:24:38 -0400
Received: (qmail 30285 invoked by uid 109); 11 Jul 2017 08:24:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 08:24:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14186 invoked by uid 111); 11 Jul 2017 08:24:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 04:24:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 04:24:35 -0400
Date:   Tue, 11 Jul 2017 04:24:35 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Peter Eckersley <peter.eckersley@gmail.com>, git@vger.kernel.org
Subject: Re: Weirdness with git change detection
Message-ID: <20170711082435.a53iuw26oxawcfyq@sigill.intra.peff.net>
References: <CAOYJvnJ1FxevnWf+Aj0-5r6WfmfPkzWhOk_n4y4Yz7HvvfvaBQ@mail.gmail.com>
 <d047a884-b698-c25b-59e9-3a2704f79fb3@web.de>
 <20170711070618.dq52o67ixvjudafg@sigill.intra.peff.net>
 <CAOYJvnLCwR7CkG32E_r5BcVm5tFt5zsgYe7TUW3hVGBtQBHzGw@mail.gmail.com>
 <20170711073433.ghcz3lku3ux54fib@sigill.intra.peff.net>
 <decbd316-5194-120d-824e-b5cee1f0822c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <decbd316-5194-120d-824e-b5cee1f0822c@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 10:20:43AM +0200, Torsten Bögershausen wrote:

> > No problem. I actually think it would be interesting if Git could
> > somehow detect and warn about this situation. But the obvious way to do
> > that would be to re-run the clean filter directly after checkout. And
> > doing that all the time is expensive.
> 
> Would it be possible to limit the round-trip-check to "git reset --hard" ?
> If yes, possibly many users are willing to pay the price, if Git tells
> the "your filters don't round-trip". (Including CRLF conversions)

Anything's possible, I suppose. But I don't think I'd want that feature
turned on myself.

> > Perhaps some kind of "lint" program would be interesting to warn of
> > possible misconfigurations. Of course people would have to run it for it
> > to be useful. :)
> 
> What do you have in mind here ?
> Don't we need to run some content through the filter(s)?

I was thinking of a tool that could run a series of checks on the
repository and nag about potential problems. One of them could be doing
a round-trip repo->clean->smudge for each file.

Another one might be warning about files that differ only in case.

The idea being that users could run "git lint" if they suspect something
funny is going on. I dunno. It may be a dead-end. Most such
oddities are better detected and handled during actual git operations if
we can. So this would really just be for things that are too expensive
to detect in normal operations.

-Peff
