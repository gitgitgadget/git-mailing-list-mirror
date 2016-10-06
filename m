Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A4A9207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 19:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934742AbcJFTXp (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 15:23:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:53573 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934706AbcJFTXm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 15:23:42 -0400
Received: (qmail 31018 invoked by uid 109); 6 Oct 2016 19:23:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 19:23:42 +0000
Received: (qmail 30739 invoked by uid 111); 6 Oct 2016 19:23:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 15:23:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2016 15:23:40 -0400
Date:   Thu, 6 Oct 2016 15:23:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rich Felker <dalias@libc.org>, Git <git@vger.kernel.org>,
        musl@lists.openwall.com
Subject: Re: Regression: git no longer works with musl libc's regex impl
Message-ID: <20161006192339.3yddgxxk7jn7zfqx@sigill.intra.peff.net>
References: <20161004150848.GA7949@brightrain.aerifal.cx>
 <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
 <20161004154045.GT19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610041802310.35196@virtualbox>
 <CACBZZX4XPqZauD_M_ieOwVauT1fi3MQb4+6taELQaRG9M-Kz_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4XPqZauD_M_ieOwVauT1fi3MQb4+6taELQaRG9M-Kz_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2016 at 09:18:29PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Oct 4, 2016 at 6:08 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > As to making NO_REGEX conditional on REG_STARTEND: you are talking about
> > apples and oranges here. NO_REGEX is a Makefile flag, while REG_STARTEND
> > is a C preprocessor macro.
> >
> > Unless you can convince the rest of the Git developers (you would not
> > convince me) to simulate autoconf by compiling an executable every time
> > `make` is run, to determine whether REG_STARTEND is defined, this is a
> > no-go.
> 
> But just to clarify, does anyone have any objection to making our
> configure.ac compile a C program to check for this sort of thing?
> Because that seems like the easiest solution to this class of problem.

No, I think that is the exact purpose of configure.ac and autoconf.

It would be neat if we could auto-fallback during the build. Rich
suggested always compiling compat/regex.c, and just having it be a noop
at the preprocessor level. I'm not sure if that would work, though,
because we'd have to include the system "regex.h" to know if we have
REG_STARTEND, at which point it is potentially too late to compile our
own regex routines (we're potentially going to conflict with the system
declarations).

-Peff
