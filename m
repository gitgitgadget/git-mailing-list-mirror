Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B8F1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeAZS1h (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:27:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:59024 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751434AbeAZS1h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:27:37 -0500
Received: (qmail 15269 invoked by uid 109); 26 Jan 2018 18:27:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Jan 2018 18:27:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17268 invoked by uid 111); 26 Jan 2018 18:28:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 26 Jan 2018 13:28:15 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jan 2018 13:27:35 -0500
Date:   Fri, 26 Jan 2018 13:27:35 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/10] t5812: add 'test_i18ngrep's missing filename
 parameter
Message-ID: <20180126182734.GB27618@sigill.intra.peff.net>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180126123708.21722-3-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180126123708.21722-3-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 01:37:00PM +0100, SZEDER Gábor wrote:

> The second 'test_i18ngrep' invocation in the test 'curl redirects
> respect whitelist' is missing its filename parameter.  This has
> remained unnoticed since its introduction in f4113cac0 (http: limit
> redirection to protocol-whitelist, 2015-09-22), because it would only
> cause the test to fail if Git was built with a sufficiently old
> libcurl version.  The test's two ||-chained 'test_i18ngrep'
> invocations are supposed to check that either one of the two patterns
> is present in 'git clone's error message.  As it happens, the first
> invocation covers the error message from any reasonably up-to-date
> libcurl, thus the second invocation, the one without the filename
> parameter, isn't executed at all.  Apparently no one has run the test
> suite's httpd tests with such an old libcurl in the last 2+ years, or
> at least they haven't bothered to notify us about the failed test.

Interesting find.

The "too old" curl is older than 7.19.4, which we actually fail to build
with since v2.12.0. So they probably did not even get as far as the
tests. ;)

> Fix this by consolidating the two patterns into a single extended
> regexp, eliminating the need for an ||-chained second 'test_i18ngrep'
> invocation.

OK. Once upon a time I think we had trouble with "grep -E", since some
older systems had only "egrep". But I see we've introduced some "grep
-E" invocations as far back as 2013 and nobody has complained, so it's
probably fine.

-Peff
