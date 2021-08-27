Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453D0C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 02:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF0460ED3
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 02:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbhH0C1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 22:27:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:60404 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231641AbhH0C1U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 22:27:20 -0400
Received: (qmail 5578 invoked by uid 109); 27 Aug 2021 02:26:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Aug 2021 02:26:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11250 invoked by uid 111); 27 Aug 2021 02:26:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Aug 2021 22:26:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Aug 2021 22:26:31 -0400
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        allred.sean@gmail.com, git <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] checkout: make delayed checkout respect --quiet and
 --no-progress
Message-ID: <YShNV1isGfxO1QZn@coredump.intra.peff.net>
References: <YF2b8LLhE0vjc7mg@coredump.intra.peff.net>
 <d1405b781915c085ac8a8965dadf3efbe1b0f6aa.1629915330.git.matheus.bernardino@usp.br>
 <87bl5lccx0.fsf@evledraar.gmail.com>
 <CAHd-oW7Z8TXZTRmSN0FkCpqEzz7-chJwYbDqyJaQ_ETW8xoG+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd-oW7Z8TXZTRmSN0FkCpqEzz7-chJwYbDqyJaQ_ETW8xoG+Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 11:26:46AM -0300, Matheus Tavares Bernardino wrote:

> > > +for mode in pathspec branch
> > > +do
> > > +     case "$mode" in
> > > +     pathspec) opt='.' ;;
> > > +     branch) opt='-f HEAD' ;;
> > > +     esac
> > > +
> > > +     test_expect_success PERL,TTY "delayed checkout shows progress by default only on tty ($mode checkout)" '
> >
> > All of the PERL,TTY can just be TTY, since TTY itself checks PERL.
> 
> I don't mind changing that, but isn't it a bit clearer for readers to
> have both dependencies explicitly?

No just clearer, but the perl dependency of TTY is an implementation
detail. It's conceivable that we could end up converting it to another
language (e.g., I recall there are at least some races with the stdin
mechanism, according to [0]).

-Peff

[0] https://lore.kernel.org/git/20190520125016.GA13474@sigill.intra.peff.net/
