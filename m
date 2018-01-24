Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F03E1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 19:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932135AbeAXTvZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 14:51:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:55892 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752424AbeAXTvY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 14:51:24 -0500
Received: (qmail 26496 invoked by uid 109); 24 Jan 2018 19:51:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Jan 2018 19:51:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27996 invoked by uid 111); 24 Jan 2018 19:52:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 14:52:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 14:51:22 -0500
Date:   Wed, 24 Jan 2018 14:51:22 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] travis-ci: don't run the test suite as root in the
 32 bit Linux build
Message-ID: <20180124195122.GA7278@sigill.intra.peff.net>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com>
 <20180122133220.18587-5-szeder.dev@gmail.com>
 <20180123164340.GG13068@sigill.intra.peff.net>
 <CAM0VKjkRGxAjjibHbJPmC6KZDFL67WEhN1VFqEjbsQAZbgCB8A@mail.gmail.com>
 <20180124155622.GB15803@sigill.intra.peff.net>
 <20180124180142.GA26290@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180124180142.GA26290@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 01:01:42PM -0500, Jeff King wrote:

> Just for fun, I tried running:
> 
>   cd t
>   best-of-five make GIT_PROVE_OPTS='-j3'
>   best-of-five make GIT_PROVE_OPTS='-j3 --state=slow,save'
>   best-of-five make GIT_PROVE_OPTS='-j3 --shuffle'
> [...]
> I wonder what is different between my setup and Travis. I guess one
> is that I use a tmpfs for the test-root. I wonder if that could throw
> off the relative timings, or the importance of parallelization.

I just tried again without a tmpfs (actually, with
GIT_TEST_OPTS=--verbose-log, which matches Travis) and still got the
"prove" version as only about 10s faster. So I dunno. My disk is an SSD,
so that probably _is_ faster than Travis's disks, and maybe that would
matter.

I'm giving up on finding it. If you happen to have a recipe for
reproducing a larger speedup with "--state=slow,save", I'd be curious to
see it. But don't spend much time on it on my account. The existing
prove-caching setup is there and working, so even in the worst case if
it's not helping, it's not actively hurting much.

-Peff
