Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B859A202F8
	for <e@80x24.org>; Mon, 13 Mar 2017 12:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbdCMMxa (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 08:53:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:43112 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751260AbdCMMx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 08:53:28 -0400
Received: (qmail 5502 invoked by uid 109); 13 Mar 2017 12:53:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 12:53:27 +0000
Received: (qmail 17902 invoked by uid 111); 13 Mar 2017 12:53:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 08:53:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Mar 2017 08:53:24 -0400
Date:   Mon, 13 Mar 2017 08:53:24 -0400
From:   Jeff King <peff@peff.net>
To:     "Bernhard E. Reiter" <bernhard.reiter@intevation.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>, gnupg-devel@gnupg.org
Subject: Re: Stable GnuPG interface, git should use GPGME
Message-ID: <20170313125324.ahznmrwflqvdrnnn@sigill.intra.peff.net>
References: <201703101100.15214.bernhard.reiter@intevation.de>
 <CA+55aFxk7F103LADnmwc8wFySYQNiK6TcCQ0WSj+UTP-GihgcQ@mail.gmail.com>
 <201703131214.31588.bernhard.reiter@intevation.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201703131214.31588.bernhard.reiter@intevation.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 12:14:17PM +0100, Bernhard E. Reiter wrote:

> Using a completely different OpenPGP implementation maybe a potential use case 
> for keeping a configuration option around. I did not deeply examine what git 
> really needs. Usually a different implementation will have quite a different 
> command line interface, so it may require substaintial work to come up with a 
> wrapper about that other OpenPGP implementation to provide the same command 
> line interface as GnuPG.

The existing config option will have to stay, period. If we take it
away, then we'd be breaking existing setups that do anything more exotic
than point it at a particular gpg binary.

So I think the possible patches in this area are:

  - adding gpgme support (probably as an optional build-time dependency)
    along with a config option to use it instead of gpg.program (or
    possibly just "gpg.program = gpgme" to trigger it).

  - defaulting to gpgme (when it's compiled in) instead of gpg.program

The first one by itself shouldn't hurt anybody, aside from carrying some
extra code around.

We'd have to see how the first one goes before considering the second.
If we hit a point where people have problems and the advice is "just set
gpg.program to gpgme", then that's a good sign that the default should
be flipped.

-Peff
