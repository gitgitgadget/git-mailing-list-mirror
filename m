Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D28321F453
	for <e@80x24.org>; Thu, 14 Feb 2019 06:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390238AbfBNGw3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 01:52:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:43872 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389635AbfBNGw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 01:52:29 -0500
Received: (qmail 3865 invoked by uid 109); 14 Feb 2019 06:52:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 06:52:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7537 invoked by uid 111); 14 Feb 2019 06:52:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 01:52:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 01:52:27 -0500
Date:   Thu, 14 Feb 2019 01:52:27 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-httpd: pass GIT_TEST_SIDEBAND_ALL through Apache
Message-ID: <20190214065226.GA22932@sigill.intra.peff.net>
References: <20190214063513.32041-1-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214063513.32041-1-tmz@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 01:35:13AM -0500, Todd Zullinger wrote:

> 07c3c2aa16 ("tests: define GIT_TEST_SIDEBAND_ALL", 2019-01-16) added
> GIT_TEST_SIDEBAND_ALL to the apache.conf PassEnv list.  Avoid warnings
> from Apache when the variable is unset, as we do for GIT_VALGRIND* and
> GIT_TRACE, from f628825481 ("t/lib-httpd: handle running under
> --valgrind", 2012-07-24) and 89c57ab3f0 ("t: pass GIT_TRACE through
> Apache", 2015-03-13), respectively.
> 
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> I missed this with rc0, but poking through build logs I noticed a number
> of 'AH01506: PassEnv variable GIT_TEST_SIDEBAND_ALL was undefined'
> warnings.
> 
> I think exporting this in lib-httpd.sh like we do for GIT_VALGRIND* and
> GIT_TRACE is the way to go, as opposed to in test-lib.sh, as we do for
> things like GNUPGHOME.  But I could easily be wrong about that.

Yeah, I think this is the right place to put it (and this approach is
the right thing to do).

> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index 216281eabc..0dfb48c2f6 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -91,6 +91,7 @@ HTTPD_DOCUMENT_ROOT_PATH=$HTTPD_ROOT_PATH/www
>  # hack to suppress apache PassEnv warnings
>  GIT_VALGRIND=$GIT_VALGRIND; export GIT_VALGRIND
>  GIT_VALGRIND_OPTIONS=$GIT_VALGRIND_OPTIONS; export GIT_VALGRIND_OPTIONS
> +GIT_TEST_SIDEBAND_ALL=$GIT_TEST_SIDEBAND_ALL; export GIT_TEST_SIDEBAND_ALL
>  GIT_TRACE=$GIT_TRACE; export GIT_TRACE

I applaud your attempt to alphabetize, but the existing list is already
out of order. ;) I don't think it really matters much either way,
though.

-Peff
