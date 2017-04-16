Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 724521FA14
	for <e@80x24.org>; Sun, 16 Apr 2017 04:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbdDPEnK (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 00:43:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:34220 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbdDPEnI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 00:43:08 -0400
Received: (qmail 2287 invoked by uid 109); 16 Apr 2017 04:43:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 04:43:07 +0000
Received: (qmail 13094 invoked by uid 111); 16 Apr 2017 04:43:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 00:43:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Apr 2017 00:43:05 -0400
Date:   Sun, 16 Apr 2017 00:43:05 -0400
From:   Jeff King <peff@peff.net>
To:     Nathan McSween <nwmcsween@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [REQ] Allow alternatives to gpg
Message-ID: <20170416044305.dutwxrkdlv7rgj7p@sigill.intra.peff.net>
References: <9727e699-d97b-e8f2-ca48-574fc4f014af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9727e699-d97b-e8f2-ca48-574fc4f014af@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2017 at 08:10:41PM -0700, Nathan McSween wrote:

> I would like to try to make git signing pluggable, this would allow for
> using tools such as signify[1].
> Now I'm wondering if this endeavor is worth taking and what would need to be
> changed besides
> gpg-interface?
> 
> [1] http://man.openbsd.org/signify

I haven't used signify, but I have played around a bit with using gpgsm
with git. You can actually get pretty far without writing any code by
tweaking gpg.program, as long as:

  - your tool can generate and verify detached signatures

  - it follows the gpg command-line convention (or you wrap it in a
    script which converts the two)

There are a few quirks around detecting the "BEGIN PGP MESSAGE" block.
It's not necessary for tag signatures, but is for commit signatures
(IIRC). There's some discussion in this thread:

  http://public-inbox.org/git/1459432304-35779-1-git-send-email-cmn@dwim.me/T/#u

Which isn't to say we shouldn't teach Git natively to understand more
encryption types. But it may be useful to prototype and get experience
first by plugging the tool in via the config.

(I don't have opinions on signify itself as a tool for general purpose
signatures).

-Peff
