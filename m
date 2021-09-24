Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F12EC433FE
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2122E61212
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344190AbhIXWBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 18:01:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:54976 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344237AbhIXWBB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 18:01:01 -0400
Received: (qmail 19843 invoked by uid 109); 24 Sep 2021 21:59:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 21:59:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14058 invoked by uid 111); 24 Sep 2021 21:59:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 17:59:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 17:59:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, The Grey Wolf <greywolf@starwolf.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
Message-ID: <YU5KOpGkS5sH4iFJ@coredump.intra.peff.net>
References: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
 <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com>
 <YU49+Y+nRhl1mgof@coredump.intra.peff.net>
 <xmqqa6k1slxe.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6k1slxe.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 02:28:29PM -0700, Junio C Hamano wrote:

> > But as you note, "=" is somewhat problematic, and without that we can't
> > use the "usual" operators. Plus there's no usual operator for globbing. ;)
> > So embedding it in the name is fine by me (and mostly a bikeshed thing
> > anyway).
> 
> Perhaps.  I am not sure if we deeply care about "git -c var=val" in
> this case, especially since this is part of includeif, though.  It
> may be more important to keep the syntax useful and extensible for
> everyday use than for one-off "git -c" testing.

Yeah, see my comments later in that mail. :)

> > I agree we don't really need a "/i" variant here.
> 
> Case insensitive environment variable names, no, but case
> insensitive matching of values, maybe?  But I'd be happy to see us
> start very minimally (even just envEQ alone without any other
> frills, or optionally envNE to negate it, would be fine by me).

Yeah, as long as we leave the door open syntactically, I think it is OK.

> > Should we allow whitespace around key names and values? E.g.:
> >
> >   [includeIf "env: FOO: bar"]
> >
> > is IMHO more readable (even more so if we had infix operators like
> > "==").
> 
> This asserts what? FOO=" bar"?

Whoops, that should have been "envIs", asserting that $FOO contains
"bar".

As I said, I think it matters more with the infix operators, as:

  [includeIf "env:FOO == bar"]

is more readable than:

  [includeIf "env:FOO==bar"]

But I do think:

  [includeIf "envIs:FOO:bar"]

is harder to read than even:

  [includeIf "envIs:FOO: bar"]

-Peff
