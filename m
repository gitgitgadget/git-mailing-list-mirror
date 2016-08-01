Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 672FD1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 23:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447AbcHAXq2 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 19:46:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:53002 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755408AbcHAXqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 19:46:25 -0400
Received: (qmail 25007 invoked by uid 102); 1 Aug 2016 23:46:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 19:46:12 -0400
Received: (qmail 19842 invoked by uid 107); 1 Aug 2016 23:46:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 19:46:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 19:46:08 -0400
Date:	Mon, 1 Aug 2016 19:46:08 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Eric Wong <e@80x24.org>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/1 v2] pager: move pager-specific setup into the build
Message-ID: <20160801234608.rsrrsnzywt5k7uzl@sigill.intra.peff.net>
References: <20160801214937.4752-1-e@80x24.org>
 <20160801214937.4752-2-e@80x24.org>
 <xmqq1t28gkhf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1t28gkhf.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 04:03:40PM -0700, Junio C Hamano wrote:

> Eric Wong <e@80x24.org> writes:
> 
> > From: Junio C Hamano <gitster@pobox.com>
> >
> > Allowing PAGER_ENV to be set at build-time allows us to move
> > pager-specific knowledge out of our build.  Currently, this
> > allows us to set a better default for FreeBSD where more(1)
> > is the same binary as less(1).
> 
> Thanks for resurrecting, but I am not sure what "a better default"
> is from the above description and with the patch.  Even though a
> naive reading of the above (i.e. "less" and "more" are the same)
> makes me expect that the patch will give the same set of default
> environment settings to those on FreeBSD, you give LESS=FRX and
> MORE=-R, i.e. they are configured differently.

I wondered about this, too. They are the same binary, but calling less
as "more" (or setting LESS_IS_MORE) causes less to behave "like more".
Looking at the manpage, none the usual FRX options is affected. So in
theory we could just set MORE=FRX on FreeBSD.

That would be bad a idea in general, as other non-less implementations
of more might get confused.  "more" is in POSIX, and so is $MORE (and it
does not understand any of our options).

You could also make the knob "MORE_IS_LESS" or something, and just
blindly copy $LESS to $MORE. That's a bad idea, though, if somebody does
stick one of the incompatible flags in the build options.

-Peff
