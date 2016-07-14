Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17F0E203BD
	for <e@80x24.org>; Thu, 14 Jul 2016 21:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbcGNVc0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 17:32:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:45001 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750876AbcGNVcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 17:32:25 -0400
Received: (qmail 16994 invoked by uid 102); 14 Jul 2016 21:32:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 17:32:25 -0400
Received: (qmail 9738 invoked by uid 107); 14 Jul 2016 21:32:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 17:32:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 17:32:22 -0400
Date:	Thu, 14 Jul 2016 17:32:22 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
Message-ID: <20160714213222.GA20645@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
 <20160630090857.GB17463@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607141745420.6426@virtualbox>
 <19a2d02e-3918-3bc9-db34-66e12ab950e4@kdbg.org>
 <xmqqa8hkrvu5.fsf@gitster.mtv.corp.google.com>
 <3d71cf3a-44c7-0620-0375-fb7ecf2fac13@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d71cf3a-44c7-0620-0375-fb7ecf2fac13@kdbg.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 10:52:55PM +0200, Johannes Sixt wrote:

> > Dscho?  I'll revert the merge of 'js/t0006-for-v2.9.2' out of
> > 'next' so that we can replace it with your newer version, but it
> > needs to be massaged to lose the strong linkage with "time", as
> > it is no longer "is our time big enough", I would think.
> 
> My first thought was that this is not warranted because t0006 is about
> commit time stamps, but the huge-tar breakage is file sizes, and the cases
> should be treated differently.
> 
> But on second thought, under the hood, both boil down to the size of
> unsigned long in our implementation. It may make sense to tie both cases to
> the same prerequisite.
> 
> On third thought, however, I think the two requirements could diverge in the
> future. The file size case should depend on the size of size_t. The
> timestamp case may become dependent on the size of time_t if we decide to
> move timestamp handling away from unsigned long: in modern(!) Microsoft
> SDKs, time_t is 64 bits, but unsigned long is 32 bits, in both the 32-bit
> and 64-bit environments!

The tar tests actually cover both: big files and big timestamps.

I think as long as the prereq is labeled LONG_IS_64BIT, we can then
adjust the appropriate tests if and when they become runnable on more
systems.

If we move to time_t everywhere, I think we'll need an extra
TIME_T_IS_64BIT, but we can cross that bridge when we come to it.

Likewise I think we'll need SIZE_T_IS_64BIT eventually (for real 32-bit
systems; LLP64 systems like Windows will then be able to run the test).

-Peff
