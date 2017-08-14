Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C29420899
	for <e@80x24.org>; Mon, 14 Aug 2017 22:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbdHNW5T (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 18:57:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:38682 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752619AbdHNW5S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 18:57:18 -0400
Received: (qmail 29762 invoked by uid 109); 14 Aug 2017 22:57:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 22:57:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6820 invoked by uid 111); 14 Aug 2017 22:57:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 18:57:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Aug 2017 18:57:16 -0400
Date:   Mon, 14 Aug 2017 18:57:16 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Ben Peart <peartben@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: add style build rule
Message-ID: <20170814225716.p5airw6j5o6dszbn@sigill.intra.peff.net>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
 <20170814213046.107576-3-bmwill@google.com>
 <xmqqd17xu6qg.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbAp0p8-y-UpamU0J65A2P0B9r7KEWM0ZCBv=x4E77sGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbAp0p8-y-UpamU0J65A2P0B9r7KEWM0ZCBv=x4E77sGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 03:28:50PM -0700, Stefan Beller wrote:

> >> +.PHONY: style
> >> +style:
> >> +     git clang-format --style file --diff --extensions c,h
> >
> > Did we get "git clang-format" subcommand, or is "s/git //" implied
> > somewhere?
> 
> You need to have clang-format installed (debian/Ubuntu package, or
> however it is named in your distribution), which provides this command
> for us.

Sadly it is called git-clang-format-3.8, git-clang-format-5.0, etc, in
the Debian packages. I think we need a CLANG_FORMAT variable that can be
overridden.

I am surprised that there's no base "git-clang-format" symlink for the
default version. There is for "clang-format" and "clang" themselves. So
arguably this is a bug in the Debian packaging.

I suspect the "-p" version is going to be the one people invoke the most
often. Should it take the coveted "make style" slot, and the diff get
pushed off to another target?

I was also confused at first that the "-p" version requires you to stage
the changes first. I don't know if we can make that less confusing via a
"make style". Or if it's just something people would get used to. But
sadly it makes the command not-quite orthogonal to "make test" in the
workflow. You can't "make style && make test && git add -p".  You have
to add first, then check style, then you'd want to test that result to
make sure it didn't change the meaning of the code.

-Peff
