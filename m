Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9139AC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 20:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F76661074
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 20:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhDIUMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 16:12:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:47086 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233610AbhDIUMI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 16:12:08 -0400
Received: (qmail 2003 invoked by uid 109); 9 Apr 2021 20:11:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 20:11:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16443 invoked by uid 111); 9 Apr 2021 20:11:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 16:11:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 16:11:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 05/10] userdiff: add and use for_each_userdiff_driver()
Message-ID: <YHC1CZoOBJFwQIx8@coredump.intra.peff.net>
References: <20210224195129.4004-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
 <patch-05.11-64ea5e8443f-20210324T014604Z-avarab@gmail.com>
 <YFuPMMMYicFK6A/S@coredump.intra.peff.net>
 <87im5gp2ze.fsf@evledraar.gmail.com>
 <YFvaYokQJpvwSzJ6@coredump.intra.peff.net>
 <87czvoowg2.fsf@evledraar.gmail.com>
 <YF1UuNBrAWvHSCp1@coredump.intra.peff.net>
 <87czv3gs3q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87czv3gs3q.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 09:44:57PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I really like PCRE myself, but is it portable/common enough for us to
> > start using it for baked-in funcname patterns? I sort of assumed there
> > were exotic platforms where libpcre wouldn't build (or at least it would
> > be inconvenient or uncommon to have it). And it would be nice to degrade
> > those gracefully (or at least better than "I guess you don't get any
> > builtin funcnames. Tough luck").
> 
> I think it's as portable as git, the JIT backend isn't, but PCRE itself
> is portably C code, and e.g. everything that python, PHP and any other
> number of things that depend on PCRE has had PCRE ported to it.
> 
> That plan involves an "git rm -r compat/regex" and a compat/pcre
> instead, I have some long-left-over patches for that.

OK. I was more worried about platforms where it was cumbersome to
install pcre. If we are shipping it as a vendored library, then at least
the dependency management is on us, and not the user. I do worry a
little about running into complications with building or debugging it.
It would be importing a lot of new code (that in theory we never need to
look at, but that is not always how it works...). And while it may build
portably everywhere, that may involve extra work and not integrate with
our build knobs (e.g., it looks like it uses autoconf)

-Peff
