Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0083CC34968
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E63A24784
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfLMTwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:52:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:46330 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728896AbfLMTwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 14:52:16 -0500
Received: (qmail 3414 invoked by uid 109); 13 Dec 2019 19:52:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Dec 2019 19:52:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29873 invoked by uid 111); 13 Dec 2019 19:56:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Dec 2019 14:56:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Dec 2019 14:52:15 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        git@vger.kernel.org
Subject: Re: Parallel fetch and commit graph writing results in locking
 failure (even on linux)
Message-ID: <20191213195215.GA862734@coredump.intra.peff.net>
References: <492636883.190386.1576264842701@ox.hosteurope.de>
 <bdb9201f-b77f-ab3c-251f-d902c76fa9bc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdb9201f-b77f-ab3c-251f-d902c76fa9bc@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 02:35:47PM -0500, Derrick Stolee wrote:

> I don't think so. I think you just found a bug where the
> fetch.writeCommitGraph logic doesn't work with parallel fetch
> jobs (only one can write at a time).
> 
> I believe the fix would be to write the commit-graph after
> all of the jobs have completed, which should mean we need to
> move the call to write_commit_graph_reachable() somewhere else
> inside builtin/fetch.c.

This should be fixed in master by bcb06e204c (Merge branch
'js/fetch-multi-lockfix', 2019-12-01), I think.


-Peff
