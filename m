Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08F9F1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 19:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeC3TQX (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 15:16:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:49202 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752206AbeC3TQW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 15:16:22 -0400
Received: (qmail 26169 invoked by uid 109); 30 Mar 2018 19:16:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 19:16:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32053 invoked by uid 111); 30 Mar 2018 19:17:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 15:17:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 15:16:20 -0400
Date:   Fri, 30 Mar 2018 15:16:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: A potential approach to making tests faster on Windows
Message-ID: <20180330191620.GA32338@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
 <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
 <20180329194159.GB2939@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
 <87fu4hwgfa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fu4hwgfa.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 08:45:45PM +0200, Ævar Arnfjörð Bjarmason wrote:

> I've wondered for a while whether it wouldn't be a viable approach to
> make something like an interpreter for our test suite to get around this
> problem, i.e. much of it's very repetitive and just using a few shell
> functions we've defined, what if we had C equivalents of those?

I've had a similar thought, though I wonder how far we could get with
just shell. I even tried it out with test_cmp:

  https://public-inbox.org/git/20161020215647.5no7effvutwep2xt@sigill.intra.peff.net/

But Johannes Sixt pointed out that they already do this (see
mingw_test_cmp in test-lib-functions).

I also tried to explore a few numbers about process invocations to see
if running shell commands is the problem:

  https://public-inbox.org/git/20161020123111.qnbsainul2g54z4z@sigill.intra.peff.net/

There was some discussion there about whether the problem is programs
being exec'd, or if it's forks due to subshells. And if it is programs
being exec'd, whether it's shell programs or if it is simply that we
exec Git a huge number of times.

-Peff
