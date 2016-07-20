Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 013581F744
	for <e@80x24.org>; Wed, 20 Jul 2016 18:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbcGTSHF (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 14:07:05 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60876 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941AbcGTSHE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 14:07:04 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476CE1F744;
	Wed, 20 Jul 2016 18:07:02 +0000 (UTC)
Date:	Wed, 20 Jul 2016 18:07:02 +0000
From:	Eric Wong <e@80x24.org>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] config.mak.uname: set PERL_PATH for FreeBSD 5.0+
Message-ID: <20160720180702.GA13404@starla>
References: <20160720025630.GA71874@plume>
 <alpine.DEB.2.20.1607201322350.14111@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607201322350.14111@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Eric,
> 
> On Wed, 20 Jul 2016, Eric Wong wrote:
> 
> > diff --git a/config.mak.uname b/config.mak.uname
> > index a88f139..6c29545 100644
> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -202,6 +202,11 @@ ifeq ($(uname_S),FreeBSD)
> >  		NO_UINTMAX_T = YesPlease
> >  		NO_STRTOUMAX = YesPlease
> >  	endif
> > +	R_MAJOR := $(shell expr "$(uname_R)" : '\([0-9]*\)\.')
> > +
> > +	ifeq ($(shell test "$(R_MAJOR)" -ge 5 && echo 1),1)
> > +		PERL_PATH = /usr/local/bin/perl
> > +	endif
> 
> In keeping with other uname_R usage, should this not read
> 
> 	# Since FreeBSD 5.0, Perl is part of the core
> 	ifneq ($(shell expr "$(uname_R)" : '[1-4]\.'),2)
> 		PERL_PATH = /usr/local/bin/perl
> 	endif
> 
> instead?

That's fine; however I don't use `expr` often, so it required
a little more time to realize the '2' means 2 characters were
matched.

Also, my use of a numeric comparison may be more future-proof
in case FreeBSD decides to have /usr/bin/perl again.

I also wonder why we don't use `which` to search for somewhat
standard path components, instead.  Something like:

  PERL_PATH = $(shell PATH=/bin:/usr/bin:/usr/local/bin which perl)
