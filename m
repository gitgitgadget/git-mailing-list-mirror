Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923842018F
	for <e@80x24.org>; Tue, 12 Jul 2016 01:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbcGLBPo (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 21:15:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:43233 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932117AbcGLBPn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 21:15:43 -0400
Received: (qmail 2731 invoked by uid 102); 12 Jul 2016 01:15:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 21:15:37 -0400
Received: (qmail 4239 invoked by uid 107); 12 Jul 2016 01:15:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 21:15:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2016 21:15:33 -0400
Date:	Mon, 11 Jul 2016 21:15:33 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
Message-ID: <20160712011533.GA28601@sigill.intra.peff.net>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
 <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net>
 <20160712005611.GA16810@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160712005611.GA16810@dcvr.yhbt.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 12:56:11AM +0000, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
> > Otherwise, we'll have to skip the test, perhaps with something like the
> > patch below. I suspect the problem is actually the size of "unsigned
> > long", not time_t, as we use that internally for a bunch of time
> > computation.
> 
> We should probably be using int64_t for time calculations;
> "unsigned long" is 32-bits on 32-bit x86 systems.

I'd agree (or probably just "time_t", which I would hope would be a
future-proof length even on 32-bit systems).

It's just that it's baked into a lot of different function interfaces
and structs in the code, and nobody has taken the time to review and
change it all (since it doesn't actually affect current timestamps and
won't for a while).

-Peff
