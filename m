Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D97612018A
	for <e@80x24.org>; Thu, 30 Jun 2016 06:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbcF3Go0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 02:44:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:38182 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751547AbcF3GoY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 02:44:24 -0400
Received: (qmail 23597 invoked by uid 102); 30 Jun 2016 06:37:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 02:37:31 -0400
Received: (qmail 5852 invoked by uid 107); 30 Jun 2016 06:37:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 02:37:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2016 02:37:25 -0400
Date:	Thu, 30 Jun 2016 02:37:25 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/Makefile: add a rule to re-run previously-failed tests
Message-ID: <20160630063725.GC15380@sigill.intra.peff.net>
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 09:02:37AM +0200, Johannes Schindelin wrote:

> It is the most convenient way to determine which tests failed after
> running the entire test suite, in parallel, to look for left-over "trash
> directory.t*" subdirectories in the t/ subdirectory.

As Junio noted, this doesn't work with --root. I have sometimes used:

  grep 'failed [^0]' test-results/*

for this purpose.

> This patch automates the process of determinig which tests failed
> previously and re-running them; It turned out to be quite convenient
> when trying to squash bugs that crept in during rebases.

I suspect your response will be "perl tools on Windows are too painful
to use", but the "prove" tool which comes with perl can do this and more
(e.g., running the failed tests first, and then following up with the
others to double-check), and our test suite supports it quite well.

  $ grep -B1 PROVE config.mak
  # run tests in parallel, with slow ones first to keep pipelines full
  GIT_PROVE_OPTS = -j16 --state=slow,save

  $ cd t
  $ make prove
  ... reports some test failed ...
  $ prove --state=failed
  ... re-runs just the failed test ...

-Peff
