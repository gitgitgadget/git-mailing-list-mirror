Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 948F8203C3
	for <e@80x24.org>; Wed, 20 Jul 2016 16:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbcGTQEN (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 12:04:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:47595 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752179AbcGTQEL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 12:04:11 -0400
Received: (qmail 16429 invoked by uid 102); 20 Jul 2016 16:04:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 12:04:11 -0400
Received: (qmail 22357 invoked by uid 107); 20 Jul 2016 16:04:34 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 12:04:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 10:03:57 -0600
Date:	Wed, 20 Jul 2016 10:03:57 -0600
From:	Jeff King <peff@peff.net>
To:	Jeff Hostetler <jeffhost@microsoft.com>
Cc:	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v1 2/6] Status and checkout unit tests for
 --porcelain[=<n>]
Message-ID: <20160720160357.GA25076@sigill.intra.peff.net>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-3-git-send-email-jeffhost@microsoft.com>
 <20160720160007.GB24902@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160720160007.GB24902@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 10:00:07AM -0600, Jeff King wrote:

> On Tue, Jul 19, 2016 at 06:10:54PM -0400, Jeff Hostetler wrote:
> 
> > +test_expect_failure '--porcelain=bogus with stuff to commit returns ok' '
> > +	echo bongo bongo bongo >>file &&
> > +	git commit -m next -a --porcelain=bogus
> > +'
> 
> Hrm. That seems unexpected to me. Shouldn't it complain about
> --porcelain=bogus?

Pondering more, did you mean:

  test_expect_success '--porcelain=bogus complains about format' '
	echo bongo bongo bongo >>file &&
	test_must_fail git commit -m next -a --porcelain=bogus
  '

?

expect_failure is for tests which we _want_ to succeed, but do not yet
(so they get annotated in test results appropriately). expect_success is
for an outcome we expect to happen, but which may involve specific steps
returning failure.

The names are kind of confusing in that regard.

I wonder if just "test_expect" would be a better name for
test_expect_success, and an argument or environment variable to trigger
"we know this is currently broken" rather than having a separate
test_expect_failure function. That's clearly outside the scope of your
series, of course.

-Peff
