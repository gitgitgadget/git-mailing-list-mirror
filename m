Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE7BF1FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 05:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbdFNFCS (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 01:02:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:39664 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbdFNFCS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 01:02:18 -0400
Received: (qmail 29571 invoked by uid 109); 14 Jun 2017 05:02:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 05:02:18 +0000
Received: (qmail 8064 invoked by uid 111); 14 Jun 2017 05:02:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 01:02:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 01:02:15 -0400
Date:   Wed, 14 Jun 2017 01:02:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: t1308-config-set.sh fails on current master
Message-ID: <20170614050215.c32crnjifah6cxae@sigill.intra.peff.net>
References: <20170614011514.sh4euddp44hjbu4u@sunbase.org>
 <20170614012535.GU133952@aiede.mtv.corp.google.com>
 <20170614021739.erkdifufziwiqjxp@sunbase.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170614021739.erkdifufziwiqjxp@sunbase.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2017 at 04:17:40AM +0200, Øyvind A. Holm wrote:

> > Interesting.  I'm not able to reproduce it, but of course that doesn't
> > mean much.
> 
> I'll admit that I have a somewhat special build system, but it's been 
> working great since I created it 7 months ago, and I run the test suite 
> every time I install a new git. I'm using the Makefile located at
> 
>   https://gitlab.com/sunny256/src-other/blob/master/devel/git/Makefile
> 
> It's only doing regular stuff like "make configure", "./configure", etc, 
> but I'm mentioning it in case the Makefile reveals something 
> interesting. The git installation is in a non-standard location, the 
> newest version of git I've installed is for example located under 
> /usr/src-other/pool/git.master.v2.13.1-394-g41dd4330a121/ .

I couldn't reproduce either with my usual build, but I don't usually use
autoconf. Running:

  make configure
  ./configure
  make
  (cd t && ./t1308-*)

does fail for me. The problem is that the generated config.mak.autogen
sets the wrong value for FREAD_READS_DIRECTORIES (and overrides the
default entry for Linux from config.mak.uname. So the configure script
needs to be fixed.

-Peff
