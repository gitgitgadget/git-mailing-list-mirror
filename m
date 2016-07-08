Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C17952023C
	for <e@80x24.org>; Fri,  8 Jul 2016 09:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166AbcGHJZO (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 05:25:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:41893 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754093AbcGHJZN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 05:25:13 -0400
Received: (qmail 5714 invoked by uid 102); 8 Jul 2016 09:25:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:25:15 -0400
Received: (qmail 12020 invoked by uid 107); 8 Jul 2016 09:25:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:25:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 05:25:10 -0400
Date:	Fri, 8 Jul 2016 05:25:10 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] write_file: add format attribute
Message-ID: <20160708092510.GB17072@sigill.intra.peff.net>
References: <20160708090400.GA26594@sigill.intra.peff.net>
 <20160708091241.GG10152@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160708091241.GG10152@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 08, 2016 at 05:12:41AM -0400, Jeff King wrote:

> I had also hoped it would help with confusing write_file()
> and write_file_buf(), since the former's "..." can make it
> match the signature of the latter. But given that the buffer
> for write_file_buf() is generally not a string literal, the
> compiler won't complain unless -Wformat-nonliteral is on,
> and that creates a ton of false positives elsewhere in the
> code base.

I poked around at the results of compiling with -Wformat-nonliteral, but
gave up at trying to make it work. There are a number of clever uses of
formats that would be hard to do otherwise. There are also several cases
where a format string is used multiple times and we want to avoid
repeating it. But using #define doesn't work, because we want to be able
to translate it.

I did find a little bit of low-hanging fruit, though.

  [1/2]: walker: let walker_say take arbitrary formats
  [2/2]: avoid using sha1_to_hex output as printf format

These are totally independent of the main series, so they can be a
separate topic, go on top, or just get dropped entirely if it's not
worth the trouble.

-Peff
