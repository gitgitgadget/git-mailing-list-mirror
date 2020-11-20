Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C264C388F9
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 00:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD4722249
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 00:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgKTAO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 19:14:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:36192 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgKTAO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 19:14:59 -0500
Received: (qmail 463 invoked by uid 109); 20 Nov 2020 00:14:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Nov 2020 00:14:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1237 invoked by uid 111); 20 Nov 2020 00:14:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Nov 2020 19:14:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Nov 2020 19:14:58 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] tests: make sure nested lazy prereqs work reliably
Message-ID: <20201120001458.GA274082@coredump.intra.peff.net>
References: <20201118190414.32616-1-szeder.dev@gmail.com>
 <20201119155824.GB25426@coredump.intra.peff.net>
 <20201119175608.GA132922@coredump.intra.peff.net>
 <xmqqd009xh19.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd009xh19.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 19, 2020 at 11:50:26AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I took a look at converting some of the existing tests. This seems to
> > work. It's a bit longer to read, perhaps, but I kind of like that the
> > expected outcome is all laid out. It also pollutes the test output less
> > (e.g., if you wanted to count up skipped tests in the whole suite, you'd
> > get a bunch of noise from t0000 for these uninteresting skips).
> >
> > Thoughts? I think this is something I'd do on top of your patch.
> 
> Yes, it looks nice as the expectation is expressed much clearly.

OK, then here's the whole thing. I ended up with a few more cleanups,
too. This is all on top of Gábor's patches. It's conceptually
independent, but the textual wrangling was annoying enough it didn't
make any sense to require you to do it again during merging. ;) Plus I
do not think either topic is high-risk nor urgent enough to worry too
much about one blocking the other.

The diffstat is scary, but it's mostly the final patch, which is pretty
mechanical.

  [1/4]: t0000: keep clean-up tests together
  [2/4]: t0000: run prereq tests inside sub-test
  [3/4]: t0000: run cleaning test inside sub-test
  [4/4]: t0000: consistently use single quotes for outer tests

 t/t0000-basic.sh | 570 +++++++++++++++++++++++------------------------
 1 file changed, 284 insertions(+), 286 deletions(-)

-Peff
