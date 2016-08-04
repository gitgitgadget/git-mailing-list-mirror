Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DFD320193
	for <e@80x24.org>; Thu,  4 Aug 2016 17:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933959AbcHDRxd (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 13:53:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:54843 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758806AbcHDRxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 13:53:32 -0400
Received: (qmail 6851 invoked by uid 102); 4 Aug 2016 17:53:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 13:53:32 -0400
Received: (qmail 14006 invoked by uid 107); 4 Aug 2016 17:54:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 13:54:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2016 13:53:28 -0400
Date:	Thu, 4 Aug 2016 13:53:28 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3] pager: move pager-specific setup into the build
Message-ID: <20160804175328.tkjkoo34b43bvwsb@sigill.intra.peff.net>
References: <20160801214937.4752-1-e@80x24.org>
 <20160801214937.4752-2-e@80x24.org>
 <20160803161911.dxucq7f2pvnoovoc@sigill.intra.peff.net>
 <xmqq4m718tay.fsf@gitster.mtv.corp.google.com>
 <20160803210821.GA17510@whir>
 <xmqqziot7dv6.fsf@gitster.mtv.corp.google.com>
 <20160804034301.GA31427@starla>
 <20160804053405.ifjjryejgbwkkatt@sigill.intra.peff.net>
 <20160804113410.GA13908@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160804113410.GA13908@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 11:34:10AM +0000, Eric Wong wrote:

> > > --- a/config.mak.uname
> > > +++ b/config.mak.uname
> > > @@ -209,6 +209,7 @@ ifeq ($(uname_S),FreeBSD)
> > >  	HAVE_PATHS_H = YesPlease
> > >  	GMTIME_UNRELIABLE_ERRORS = UnfortunatelyYes
> > >  	HAVE_BSD_SYSCTL = YesPlease
> > > +	PAGER_ENV = LESS=FRX LV=-c MORE=FRX
> > >  endif
> > 
> > Is it worth setting up PAGER_ENV's default values before including
> > config.mak.*, and then using "+=" here? That avoids this line getting
> > out of sync with the usual defaults.
> 
> Good point, but it makes ordering problematic for folks
> who want to override it config.mak or command-line.

I'm not sure it changes much for them. Their "=" in config.mak, etc,
would override our default, and anything on the command line overrides
all of the in-Makefile stuff anyway. The only difference would be if
they use "+=" in config.mak, but there I think it would be an
improvement.

I'm OK to leave it as-is until somebody actually cares, though.

> > I know you said you don't like string parsing in C. Here is a patch (on
> > top of yours) that converts the parsing to shell, and generates a
> > pre-built array-of-struct (this is similar to the big series I posted
> > long ago, but just touching this one spot, not invading the whole
> > Makefile). Feel free to ignore it as over-engineered, but I thought I'd
> > throw it out there in case it appeals.
> 
> Yeah, but I'd rather not introduce more complexity into the
> build process, either (unless it's a performance-sensitive part,
> which this is not).  Also, while my original 2/2 to make it
> configurable at runtime was discarded, I wouldn't rule out
> somebody making a compelling case for it and it would be
> an easier change from the parse-at-runtime code.

Yeah, I had similar thoughts while writing it.

Your v4 patch looks fine to me.

-Peff
