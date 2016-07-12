Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2DB41FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 13:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbcGLNq6 (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 09:46:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:43439 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750936AbcGLNq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 09:46:57 -0400
Received: (qmail 3570 invoked by uid 102); 12 Jul 2016 13:46:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 09:46:56 -0400
Received: (qmail 2787 invoked by uid 107); 12 Jul 2016 13:47:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 09:47:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2016 09:46:52 -0400
Date:	Tue, 12 Jul 2016 09:46:52 -0400
From:	Jeff King <peff@peff.net>
To:	Andreas Schwab <schwab@linux-m68k.org>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
Message-ID: <20160712134652.GA613@sigill.intra.peff.net>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
 <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net>
 <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607120927410.6426@virtualbox>
 <mvmtwfve22e.fsf@hawking.suse.de>
 <alpine.DEB.2.20.1607121249390.6426@virtualbox>
 <mvmh9bvdnae.fsf@hawking.suse.de>
 <alpine.DEB.2.20.1607121520310.6426@virtualbox>
 <mvmd1mjdluz.fsf@hawking.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mvmd1mjdluz.fsf@hawking.suse.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 03:31:00PM +0200, Andreas Schwab wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi Andreas,
> >
> > On Tue, 12 Jul 2016, Andreas Schwab wrote:
> >
> >> Johannes Schindelin <schindelin@wisc.edu> writes:
> >> 
> >> >> PRIuMAX isn't compatible with time_t.
> >> >
> >> > That statement is wrong.
> >> 
> >> No, it isn't.  PRIuMAX is for uintmax_t, and time_t is not uintmax_t
> >> (even if they happen to have the same representation).
> >
> > Sigh.
> >
> > So if it is wrong, what is right?
> 
> The right thing is to add a cast, of course.

In general, I think the right cast for time_t should be to (intmax_t),
and the formatting string should be PRIdMAX (which, as an aside, needs
an entry in git-compat-util.h).

In this particular code (show_date_relative), though, I think you can
get away with treating it as unsigned, because it's not actually a
time_t but rather a difference. And we handle the negative difference at
the top of the function already ("in the future").

-Peff
