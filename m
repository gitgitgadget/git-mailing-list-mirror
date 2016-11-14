Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA2C71F858
	for <e@80x24.org>; Mon, 14 Nov 2016 17:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932956AbcKNRBJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 12:01:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:42848 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932515AbcKNRBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 12:01:09 -0500
Received: (qmail 8278 invoked by uid 109); 14 Nov 2016 17:01:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 17:01:08 +0000
Received: (qmail 2377 invoked by uid 111); 14 Nov 2016 17:01:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 12:01:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2016 12:01:06 -0500
Date:   Mon, 14 Nov 2016 12:01:06 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>
Subject: Re: [PATCH] t0021, t5615: use $PWD instead of $(pwd) in PATH-like
 shell variables
Message-ID: <20161114170105.btnohk2777ddaiul@sigill.intra.peff.net>
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de>
 <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com>
 <fa11def5-a878-a5c8-6e7b-627ea8cda7e2@kdbg.org>
 <2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org>
 <xmqqa8d53ky9.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611121237230.3746@virtualbox>
 <xmqqtwbcyyfe.fsf@gitster.mtv.corp.google.com>
 <0BEC2674-20B5-4AD1-851A-97CA34C0CE7F@gmail.com>
 <35d3a07d-5d2f-aedd-94bc-4d92e5aa4661@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35d3a07d-5d2f-aedd-94bc-4d92e5aa4661@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2016 at 05:35:56PM +0100, Torsten Bögershausen wrote:

> > What is the goal for 'pu'?
> 
> > (1) Builds clean on all platforms + passes all tests
> Yes
> > (2) Builds clean on all platforms
> Yes
> > (3) Builds clean on Linux
> Yes
> > (4) Just makes new topics easily available to a broader audience
> Yes

I'd have answered differently, though I think in the end we agree on the
outcome.

I think the only thing that matters is (4). It _usually_ builds and
passes all tests, but not always. But the point is that nobody should
care in particular about "pu". What we care about is whether the
individual topics will build and pass before they are merged to master
(or even "next").

So "pu" is a tool, because you can test all of the topics at once and
find out early if there are any problems. And it's good to investigate
problems there before topics hit next (though they are also often caught
in review, or by people trying the broken topic on their various
platforms, or sometimes Junio even pushes out a known-broken state in pu
and mentions it in "What's cooking").

So yes, it should do all of those things, but we don't necessarily
expect that it will never be broken. That's expected to happen from time
to time, and the purpose of the branch. With respect to Lars' original
point:

> > Git 'pu' does not compile on macOS right now:
> > builtin/bisect--helper.c:299:6: error: variable 'good_syn' is used uninitialized 
> > whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]

The next step is to make sure that the topic author is aware (in this
case, one assumes it's pb/bisect).

Better still is to make a patch that can either be applied on top, or
squashed as appropriate. I know that Ramsay Jones does this, for
example, with some of his sparse-related checks, and I'm pretty sure
from the turnaround-time that he runs it against "pu".

-Peff
