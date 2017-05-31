Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9C841FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbdEaVEv (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:04:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:60772 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751041AbdEaVEv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:04:51 -0400
Received: (qmail 14660 invoked by uid 109); 31 May 2017 21:04:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 21:04:48 +0000
Received: (qmail 8602 invoked by uid 111); 31 May 2017 21:05:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 17:05:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 May 2017 17:04:48 -0400
Date:   Wed, 31 May 2017 17:04:48 -0400
From:   Jeff King <peff@peff.net>
To:     Irving Rabin <irving@edmodo.com>
Cc:     git@vger.kernel.org
Subject: Re: Coloring
Message-ID: <20170531210448.6kolid5umzyasxnc@sigill.intra.peff.net>
References: <CAD1ypiWOcKaLJJzZC=gw75EDFnw_1ZqC94B5p9i722T-sijN1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD1ypiWOcKaLJJzZC=gw75EDFnw_1ZqC94B5p9i722T-sijN1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 11:33:31AM -0700, Irving Rabin wrote:

> Specifically, if the field is supposed to be white, it doesn't mean it
> should be literally 0xFFFFFF. It should be the color that I have
> configured as White color for my console emulator.
> 
> I like light-screen terminals, and I configure my ANSI colors in the
> way that they are clearly visible on the background and clearly
> distinct between themselves. In my terminal settings background is
> light-yellow, Black is black, Yellow is brown, Red is dark red,
> Magenta is purple and White is dark gray. I set it once and I can use
> it everywhere - all Unix commands work correctly, I can edit
> highlighted source code in Vim, and all my color settings are
> respected.

Git outputs ANSI color codes, which are interpreted by your terminal.
You _can_ configure Git to send 24-bit color codes if your terminal
supports it, but by default it uses the traditional set of limited color
and attribute codes.

What does running the following snippet in your shell look like?

-- >8 --

while read name code; do
	printf '\033[%sm%s\033[m\n' "$code" "$name"
done <<-\EOF
normal
bold 1
red 31
green 32
yellow 33
blue 34
magenta 35
cyan 36
bold-red 1;31
bold-green 1;32
bold-yellow 1;33
bold-blue 1;34
bold-magenta 1;35
bold-cyan 1;36
EOF

-- 8< --

If any of the colors are not what you expect, is there a pattern? E.g.,
I wouldn't be surprised if "bold" shows up as bright white. In many
modern terminal emulators, the bold variants need to be configured
separately from the non-bold ones, and default to lighter variants of
their non-bold counterparts. The solution there would be to check your
terminal emulator config.

If it does all look as you'd expect, try adding "| less -R" to the end of
the "done <<-\EOF" line. Most of Git's output goes through that pager
(though I _think_ it's mostly just passing through the ANSI codes, so it
wouldn't have any effect).

-Peff
