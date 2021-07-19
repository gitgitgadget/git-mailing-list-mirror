Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286ACC12002
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 09:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D5A6100C
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 09:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhGSIT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 04:19:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:53396 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235739AbhGSIT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 04:19:56 -0400
Received: (qmail 30624 invoked by uid 109); 19 Jul 2021 08:33:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Jul 2021 08:33:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10969 invoked by uid 111); 19 Jul 2021 08:33:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Jul 2021 04:33:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 19 Jul 2021 04:33:54 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Message-ID: <YPU48uSCxXbsjvGW@coredump.intra.peff.net>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <YPUrSB8+zEur+ZBt@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPUrSB8+zEur+ZBt@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 19, 2021 at 09:35:36AM +0200, Patrick Steinhardt wrote:

> On Tue, Jul 13, 2021 at 06:07:12PM -0700, Junio C Hamano wrote:
> [snip]
> > * ps/perf-with-separate-output-directory (2021-07-02) 1 commit
> >  - perf: fix when running with TEST_OUTPUT_DIRECTORY
> > 
> >  Test update.
> > 
> >  What's the status of this one?
> 
> From my point of view this is ready, but it's still missing reviews so
> far. The lack of interest seems to indicate that nobody has hit the
> issue so far, and I wonder why that is. Am I the only one who sets
> TEST_OUTPUT_DIRECTORY to a tmpfs directory in his config.mak to speed up
> tests?

I had marked it to look at, but just hadn't gotten around to it. I just
gave it a review (but the upshot is that it looks fine to me).

I don't set TEST_OUTPUT_DIRECTORY myself; instead I do:

  GIT_TEST_OPTS = --root=/path/to/tmpfs

TBH, I had never really considered using TEST_OUTPUT_DIRECTORY for this
(--root predates it, and was written explicitly for the tmpfs case). But
I also think --root is more convenient:

  - "make test" will run in the tmpfs for speed, but "./t1234-foo.sh -i"
    will run locally, which makes it easy to "cd" in to inspect the
    result

  - likewise, I find accessing the results in t/test-results/*.out a
    little more convenient

But all of that is preference. I don't think you're wrong to use
TEST_OUTPUT_DIRECTORY this way, but the above points might be
interesting to you.

-Peff
