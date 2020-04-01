Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5B0C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 19:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDF7206F6
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 19:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbgDAT5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:57:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:58824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732397AbgDAT5J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 15:57:09 -0400
Received: (qmail 5635 invoked by uid 109); 1 Apr 2020 19:57:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Apr 2020 19:57:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15326 invoked by uid 111); 1 Apr 2020 20:07:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Apr 2020 16:07:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Apr 2020 15:57:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] commit-graph: fix buggy --expire-time option
Message-ID: <20200401195708.GA3063415@coredump.intra.peff.net>
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
 <xmqqo8sb56m2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8sb56m2.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 01, 2020 at 12:49:25PM -0700, Junio C Hamano wrote:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> > index 53b2e6b4555..4e4efcaff22 100755
> > --- a/t/t5324-split-commit-graph.sh
> > +++ b/t/t5324-split-commit-graph.sh
> > @@ -210,8 +210,10 @@ test_expect_success 'test merge stragety constants' '
> >  		git config core.commitGraph true &&
> >  		test_line_count = 2 $graphdir/commit-graph-chain &&
> >  		test_commit 15 &&
> > -		git commit-graph write --reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
> > +		touch -m -t 201801010000.00 $graphdir/extra.graph &&
> 
> We have "test-tool chmtime" since 17e48368 (Add test-chmtime: a
> utility to change mtime on files, 2007-02-24) and refrained from
> using "touch -t" anywhere in our tests.  Can we use it here, too?

There are a couple new ones added last year in t5319. Nobody has
complained yet, but I wonder if it's a matter of time.

-Peff
