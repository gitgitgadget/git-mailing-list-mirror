Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C94CB1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 16:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbeCQQMM (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 12:12:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:60872 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753283AbeCQQML (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 12:12:11 -0400
Received: (qmail 23408 invoked by uid 109); 17 Mar 2018 16:12:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 17 Mar 2018 16:12:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6504 invoked by uid 111); 17 Mar 2018 16:13:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 17 Mar 2018 12:13:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Mar 2018 12:12:08 -0400
Date:   Sat, 17 Mar 2018 12:12:08 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] travis-ci: enable more warnings on travis linux-gcc
 job
Message-ID: <20180317161208.GA25113@sigill.intra.peff.net>
References: <20180303014605.10603-1-pclouds@gmail.com>
 <20180316193355.20161-1-pclouds@gmail.com>
 <20180316212208.GC12333@sigill.intra.peff.net>
 <CACsJy8A3_itjs0MRar+Aog=0yZDuAK2-x4MU=Rvqh2C6Le-7Aw@mail.gmail.com>
 <D8137CD9-9E11-4FBC-B89B-907C007FC6E9@gmail.com>
 <20180317145923.GA24689@duynguyen.home>
 <20180317160832.GB15772@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180317160832.GB15772@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 12:08:32PM -0400, Jeff King wrote:

> +case "$($CC --version 2>&1)" in
> +gcc*)
> +	print_flags gcc
> +	;;
> +clang*)
> +	print_flags clang
> +	;;
> +*)
> +	: unknown compiler family
> +	;;
> +esac

By the way, one annoying thing is that running "cc --version" when "cc"
is actually "gcc" will print something like:

  cc (Debian 7.3.0-11) 7.3.0

even though it supports all of the gcc knobs.  This means that:

  make DEVELOPER=1

without further config won't get these knobs, because we (rightly)
default CC=cc.

Probably this detection could be a bit more clever, like:

  cc*Free Software Foundation")
	print_flags gcc

or something. I don't have any non-gcc/clang compilers to test with, so
I'm not sure what they even print for "--version" (if anything).

-Peff
