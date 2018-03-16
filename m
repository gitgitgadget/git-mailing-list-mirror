Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B7A1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbeCPVWL (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:22:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:60082 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750921AbeCPVWL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:22:11 -0400
Received: (qmail 10367 invoked by uid 109); 16 Mar 2018 21:22:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Mar 2018 21:22:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1142 invoked by uid 111); 16 Mar 2018 21:23:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Mar 2018 17:23:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Mar 2018 17:22:08 -0400
Date:   Fri, 16 Mar 2018 17:22:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] travis-ci: enable more warnings on travis linux-gcc
 job
Message-ID: <20180316212208.GC12333@sigill.intra.peff.net>
References: <20180303014605.10603-1-pclouds@gmail.com>
 <20180316193355.20161-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180316193355.20161-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 08:33:55PM +0100, Nguyễn Thái Ngọc Duy wrote:

> We have DEVELOPER config to enable more warnings, but since we can't set
> a fixed gcc version to all devs, that has to be a bit more conservative.
> On travis, we know almost exact version to be used (bumped to 6.x for
> more warnings), we could be more aggressive.

Certainly it makes sense to dial up any static checks we can for the
Travis environment, but...

> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 3735ce413f..f6f346c468 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -7,6 +7,22 @@
>  
>  ln -s "$cache_dir/.prove" t/.prove
>  
> +if [ "$jobname" = linux-gcc ]; then
> +	gcc-6 --version
> +	cat >config.mak <<-EOF
> +	CC=gcc-6
> +	CFLAGS = -g -O2 -Wall
> +	CFLAGS += -Wextra
> +	CFLAGS += -Wmissing-prototypes
> +	CFLAGS += -Wno-empty-body
> +	CFLAGS += -Wno-maybe-uninitialized
> +	CFLAGS += -Wno-missing-field-initializers
> +	CFLAGS += -Wno-sign-compare
> +	CFLAGS += -Wno-unused-function
> +	CFLAGS += -Wno-unused-parameter
> +	EOF
> +fi

Why isn't this just turning on DEVELOPER=1 if we know we have a capable
compiler?

-Peff
