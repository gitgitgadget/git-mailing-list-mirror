Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B0371FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 23:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbcFXXWK (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 19:22:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:60241 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750996AbcFXXWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 19:22:09 -0400
Received: (qmail 13303 invoked by uid 102); 24 Jun 2016 23:22:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 19:22:08 -0400
Received: (qmail 24606 invoked by uid 107); 24 Jun 2016 23:22:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 19:22:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 19:22:06 -0400
Date:	Fri, 24 Jun 2016 19:22:06 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 1/4] t5000: test tar files that overflow ustar headers
Message-ID: <20160624232206.GA28664@sigill.intra.peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net>
 <20160623232041.GA3668@sigill.intra.peff.net>
 <xmqq1t3mh0vg.fsf@gitster.mtv.corp.google.com>
 <20160624190744.GA32118@sigill.intra.peff.net>
 <20160624205858.GA23315@sigill.intra.peff.net>
 <xmqqk2hedxas.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2hedxas.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 03:41:47PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The difference in time between the two is measurable on my system, but
> > it's only a few milliseconds (for 4096 bytes). So maybe it's not worth
> > worrying about (though as a general technique, it does make me worry
> > that it's easy to get wrong in a way that will fail racily).
> 
> Yeah, GNU dd has iflag=fullblock, but if we assume GNU, we can
> safely assume "head -c", so I do not think of a way to do this
> portably enough.

Thinking on it more, "head -c" is _not_ what one would want in all
cases. It would work here, but not in t9300, for instance, where the
code is trying to read an exact number of bytes from a fifo. I don't
think "head" makes any promises about buffering and may read extra
bytes.

So I dunno. "dd" generally does make such promises, or perhaps the perl
sysread() solution in t9300 is not so bad.

-Peff
