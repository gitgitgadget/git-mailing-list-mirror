Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F58211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 04:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbeLEE5R (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 23:57:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:59350 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726031AbeLEE5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 23:57:16 -0500
Received: (qmail 30730 invoked by uid 109); 5 Dec 2018 04:57:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 04:57:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27996 invoked by uid 111); 5 Dec 2018 04:56:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Dec 2018 23:56:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Dec 2018 23:57:15 -0500
Date:   Tue, 4 Dec 2018 23:57:15 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] test-lib: consolidate naming of test-results paths
Message-ID: <20181205045714.GC12284@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181204163457.15717-2-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 04, 2018 at 05:34:55PM +0100, SZEDER Gábor wrote:

> There are two places where we strip off any leading path components
> and the '.sh' suffix from the test script's pathname, and there are
> two places where we construct the filename of test output files in
> 't/test-results/'.  The last patch in this series will add even more.
> 
> Factor these out into helper variables to avoid repeating ourselves.

Makes sense.

> +TEST_NAME="$(basename "$0" .sh)"
> +TEST_RESULTS_BASE="$TEST_OUTPUT_DIRECTORY/test-results/$TEST_NAME"

Hmm, since we are building up this BASE variable anyway, why not:

  TEST_RESULTS_DIR=$TEST_OUTPUT_DIRECTORY/test-results
  TEST_RESULTS_BASE=$TEST_RESULTS_DIR/$TEST_NAME

? That saves having to run `dirname` on it later.

I guess one could argue that saying "the directory name of the file I'm
writing" is more readable. I just generally try to avoid extra
manipulation of the strings when possible (especially in shell).

-Peff
