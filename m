Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9C27207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 19:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934666AbcJFT2P (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 15:28:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:53589 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbcJFT2O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 15:28:14 -0400
Received: (qmail 31328 invoked by uid 109); 6 Oct 2016 19:28:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 19:28:13 +0000
Received: (qmail 30894 invoked by uid 111); 6 Oct 2016 19:28:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 15:28:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2016 15:28:11 -0400
Date:   Thu, 6 Oct 2016 15:28:11 -0400
From:   Jeff King <peff@peff.net>
To:     Rich Felker <dalias@libc.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git <git@vger.kernel.org>, musl@lists.openwall.com
Subject: Re: Regression: git no longer works with musl libc's regex impl
Message-ID: <20161006192811.xy5iahvczigfgapa@sigill.intra.peff.net>
References: <20161004150848.GA7949@brightrain.aerifal.cx>
 <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
 <20161004154045.GT19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610041802310.35196@virtualbox>
 <CACBZZX4XPqZauD_M_ieOwVauT1fi3MQb4+6taELQaRG9M-Kz_w@mail.gmail.com>
 <20161006192339.3yddgxxk7jn7zfqx@sigill.intra.peff.net>
 <20161006192500.GS19318@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161006192500.GS19318@brightrain.aerifal.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2016 at 03:25:00PM -0400, Rich Felker wrote:

> > No, I think that is the exact purpose of configure.ac and autoconf.
> > 
> > It would be neat if we could auto-fallback during the build. Rich
> > suggested always compiling compat/regex.c, and just having it be a noop
> > at the preprocessor level. I'm not sure if that would work, though,
> > because we'd have to include the system "regex.h" to know if we have
> > REG_STARTEND, at which point it is potentially too late to compile our
> > own regex routines (we're potentially going to conflict with the system
> > declarations).
> 
> If you have autoconf testing for REG_STARTEND at configure time then
> compat/regex.c can #include "config.h" and test for HAVE_REG_STARTEND
> rather than for REG_STARTEND, or something like that.

Right, that part is easy; we do not even have to touch compat/regex.c,
because we already have such a knob in the Makefile (NO_REGEX), and
autoconf just needs to tweak that knob.

My question was whether we could do it without running a separate
compile (via autoconf or via the Makefile), and I think the answer is
"no".

-Peff
