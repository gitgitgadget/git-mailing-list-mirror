Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0ED71F42D
	for <e@80x24.org>; Thu, 31 May 2018 06:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753868AbeEaGHl (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 02:07:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:57484 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753803AbeEaGHk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 02:07:40 -0400
Received: (qmail 13713 invoked by uid 109); 31 May 2018 06:07:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 May 2018 06:07:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9580 invoked by uid 111); 31 May 2018 06:07:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 May 2018 02:07:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2018 02:07:38 -0400
Date:   Thu, 31 May 2018 02:07:38 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 1/3] usage: extract `prefix_suffix_lines()` from
 `advise()`
Message-ID: <20180531060738.GF17344@sigill.intra.peff.net>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
 <cover.1527279322.git.martin.agren@gmail.com>
 <90ac0a41563f070a840076521d8935ad7c21beb9.1527279322.git.martin.agren@gmail.com>
 <20180529213957.GF7964@sigill.intra.peff.net>
 <xmqqfu29gbqp.fsf@gitster-ct.c.googlers.com>
 <xmqq4lipel8a.fsf@gitster-ct.c.googlers.com>
 <CAN0heSqmhaKrxYSUKWcxWFR0QwZPOG9kueBPJv6jnMNJpb+aMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqmhaKrxYSUKWcxWFR0QwZPOG9kueBPJv6jnMNJpb+aMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 12:26:40PM +0200, Martin Ågren wrote:

> >>> So perhaps:
> >>>
> >>>   void report_lines(FILE *out,
> >>>                     const char *color, const char *color_reset,
> >>>                  const char *prefix, const char *msg);
> >>>
> >>> or something?
> >>
> >> Sounds good to me.  And if you hate the repeated "error:" prefix
> >> that makes the prefix on the second and subsequent lines included in
> >> cutting and pasting, we could use the two-prefix idea elsewhere in
> >> the thread, too.
> 
> (That also gets rid of the minor strangeness of my series to introduce an
> overly broad `suffix` and use it only for resetting color, not actually
> for giving any textual suffix.)

Yeah, that "suffix" argument left me scratching my head at first. :)

> Somehow it feels slightly cleaner to me, at least on first thought, to
> try to decouple the indenting from the translating and line-wrapping.
> But as noted above, the indenting does affect how the line-wrapping
> should/may be done.

Yeah, agreed. Once report_lines() (or whatever we call it) knows what
the prefix is, it is capable of handling indentation on its own either
by repeating the prefix or by computing its visual width and outputting
appropriate spaces (which we can probably never get perfect without
knowing about the terminal, but we could at least make an approximation,
or even use some ANSI magic -- we could even make it run-time
configurable, though I'm not sure anybody would care that much).

-Peff
