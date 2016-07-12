Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7A7A1FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 16:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbcGLQJZ (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 12:09:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:43563 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751254AbcGLQJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 12:09:25 -0400
Received: (qmail 9849 invoked by uid 102); 12 Jul 2016 16:09:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 12:09:25 -0400
Received: (qmail 4144 invoked by uid 107); 12 Jul 2016 16:09:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 12:09:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2016 12:09:21 -0400
Date:	Tue, 12 Jul 2016 12:09:21 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.9.1
Message-ID: <20160712160921.GA2965@sigill.intra.peff.net>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
 <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net>
 <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607120927410.6426@virtualbox>
 <xmqqpoqj6i3d.fsf@gitster.mtv.corp.google.com>
 <20160712151630.GE613@sigill.intra.peff.net>
 <CAPc5daWcb5bfgsxMP0vCrQ7gBdeYBgefzPNHztaaCKzqbCv2aQ@mail.gmail.com>
 <20160712153520.GG613@sigill.intra.peff.net>
 <xmqqlh167tjd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlh167tjd.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 08:41:42AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I am not certain that there is a modern system with 32-bit time_t. We
> > know there are systems with 32-bit unsigned long, and I think that is
> > what produced the results people saw. I'd expect even 32-bit systems to
> > use "int64_t" or similar for their time_t these days.
> 
> OK.

In case it wasn't clear, I was mostly guessing there. So I dug a bit
further, and indeed, I am wrong. Linux never bumped to a 64-bit time_t
on i386 because of the ABI headaches.

That being said, I still think the "clamp to time_t" strategy is
reasonable. Unless you are doing something really exotic like pretending
to be from the future, nobody will care for 20 years. And at that point,
systems with a 32-bit time_t are going to have to do _something_,
because time() is going to start returning bogus values. So as long as
we behave reasonably (e.g., clamping values and not generating wrapped
nonsense), I think that's a fine solution.

-Peff
