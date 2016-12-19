Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CCEC1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 20:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756336AbcLSUAi (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 15:00:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:58683 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753225AbcLSUAg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 15:00:36 -0500
Received: (qmail 25182 invoked by uid 109); 19 Dec 2016 20:00:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Dec 2016 20:00:36 +0000
Received: (qmail 465 invoked by uid 111); 19 Dec 2016 20:01:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Dec 2016 15:01:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Dec 2016 15:00:34 -0500
Date:   Mon, 19 Dec 2016 15:00:34 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     larsxschneider@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v1] t0021: fix flaky test
Message-ID: <20161219200034.nkcjfrey5vvakmkf@sigill.intra.peff.net>
References: <B3D96792-047D-4C91-8DCC-60C800B2861B@gmail.com>
 <20161218123748.72101-1-larsxschneider@gmail.com>
 <6e0ea8b0-181a-2ab6-5bab-4f8dfa1d76fa@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e0ea8b0-181a-2ab6-5bab-4f8dfa1d76fa@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 05:24:32PM +0000, Ramsay Jones wrote:

> > t0021.15 creates files, adds them to the index, and commits them. All
> > this usually happens in a test run within the same second and Git cannot
> > know if the files have been changed between `add` and `commit`.  Thus,
> > Git has to run the clean filter in both operations. Sometimes these
> > invocations spread over two different seconds and Git can infer that the
> > files were not changed between `add` and `commit` based on their
> > modification timestamp. The test would fail as it expects the filter
> > invocation. Remove this expectation to make the test stable.
> [...]
> I applied this to the pu branch and ran the test by hand
> 48 times in a row without failure. (the most trials without
> error beforehand was 24).

The original also fails nearly-instantly under my stress script[1], and
it runs for several minutes with this patch.

It might be instructive to try all of the tests under that script, but
it would require a fair bit of patience (and to some degree, people
running "make -j32 test" accomplishes the same thing over time).

-Peff

[1] https://github.com/peff/git/blob/meta/stress
