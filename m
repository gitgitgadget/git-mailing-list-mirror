Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC70420798
	for <e@80x24.org>; Thu,  5 Jan 2017 19:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761354AbdAEQrJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 11:47:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:35607 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759553AbdAEQqq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 11:46:46 -0500
Received: (qmail 828 invoked by uid 109); 5 Jan 2017 16:45:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Jan 2017 16:45:59 +0000
Received: (qmail 10093 invoked by uid 111); 5 Jan 2017 16:46:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Jan 2017 11:46:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jan 2017 11:45:57 -0500
Date:   Thu, 5 Jan 2017 11:45:57 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] asciidoctor: fix user-manual to be built by
 `asciidoctor`
Message-ID: <20170105164556.b3bzeqqzx4pvni4z@sigill.intra.peff.net>
References: <cover.1483373021.git.johannes.schindelin@gmx.de>
 <3c160f81a88cf8697f2459bb7f2a3e27fb3e469c.1483373021.git.johannes.schindelin@gmx.de>
 <20170104080852.bmlmtzxhjx4qt74f@sigill.intra.peff.net>
 <1D7C66EA-E87A-4154-ACAC-8045D28477D2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1D7C66EA-E87A-4154-ACAC-8045D28477D2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 05, 2017 at 11:05:29AM +0100, Lars Schneider wrote:

> > The git-scm.com site uses asciidoctor, too, and I think I have seen some
> > oddness with the rendering though. So in general I am in favor of making
> > things work under both asciidoc and asciidoctor.
> 
> I am not familiar with both tools but it sounds to me as if "asciidoctor"
> is kind of the "lowest common denominator". Is this true? If yes, would it
> make sense to switch TravisCI [1] to asciidocter if this change gets merged?

I don't think that's quite true.

The two programs produce different output for certain inputs. We tend to
see the cases where asciidoc produces the desired output and asciidoctor
doesn't, because traditionally the documentation was written _for_
asciidoc. So whenever asciidoctor diverges, it looks like a bug.

If people start developing and checking their work using asciidoctor[1],
then we'll see bugs going in the other direction.

As far as CI goes, I am not altogether convinced of the usefulness of
building the documentation. It's very expensive, and the failure mode is
rarely "whoops, running `make doc` failed". It's almost always that the
output looks subtly wrong, but that's very hard to check automatically.

[1] I think we've also traditionally considered asciidoc to be the
    definitive toolchain, and people using asciidoctor are free to
    submit patches to make things work correctly in both places. I'm not
    opposed to changing that attitude, as it seems like asciidoctor is
    faster and more actively maintained these days. But I suspect our
    build chain would need some improvements. Last time I tried building
    with AsciiDoctor it involved a lot manual tweaking of Makefile
    variables. It sounds like Dscho is doing it regularly, though. It
    should probably work out of the box (with something like
    USE_ASCIIDOCTOR=Yes) if we expect people to actually rely on it.
