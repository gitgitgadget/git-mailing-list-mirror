Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D59EA20562
	for <e@80x24.org>; Mon, 30 Oct 2017 18:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbdJ3SDh (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 14:03:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:40376 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752389AbdJ3SDg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 14:03:36 -0400
Received: (qmail 9857 invoked by uid 109); 30 Oct 2017 18:03:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Oct 2017 18:03:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25556 invoked by uid 111); 30 Oct 2017 18:03:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Oct 2017 14:03:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Oct 2017 11:03:34 -0700
Date:   Mon, 30 Oct 2017 11:03:34 -0700
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        gitster@pobox.com, chriscool@tuxfamily.org, t.gummerer@gmail.com,
        l.s.r@web.de, jsorianopastor@gmail.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] read_index_from(): Skip verification of the cache
 entry order to speed index loading
Message-ID: <20171030180334.ddursnmj5wqgimqu@sigill.intra.peff.net>
References: <20171018142725.10948-1-benpeart@microsoft.com>
 <20171024144544.7544-1-benpeart@microsoft.com>
 <11666ccf-6406-d585-f519-7a1934c2973a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11666ccf-6406-d585-f519-7a1934c2973a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 30, 2017 at 08:48:48AM -0400, Ben Peart wrote:

> Any updates or thoughts on this one?  While the patch has become quite
> trivial, it does results in a savings of 5%-15% in index load time.

I like the general direction of avoiding the check during each read.
But...

> I thought the compromise of having this test only run when DEBUG is defined
> should limit it to developer builds (hopefully everyone developing on git is
> running DEBUG builds :)).  Since the test is trying to detect buggy code
> when writing the index, I thought that was the right time to test/catch any
> issues.

I certainly don't build with DEBUG. It traditionally hasn't done
anything useful. But I'm also not convinced that this is a likely way to
find bugs in the first place, so I'm OK missing out on it.

But what we probably _do_ need is to make sure that "git fsck" would
detect such an out-of-order index. So that developers and users alike
can diagnose suspected problems.

-Peff
