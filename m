Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A531F461
	for <e@80x24.org>; Wed,  4 Sep 2019 03:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfIDDIc (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 23:08:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:38610 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727065AbfIDDIb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 23:08:31 -0400
Received: (qmail 9679 invoked by uid 109); 4 Sep 2019 03:08:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Sep 2019 03:08:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10998 invoked by uid 111); 4 Sep 2019 03:10:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Sep 2019 23:10:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Sep 2019 23:08:30 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, garimasigit@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
Message-ID: <20190904030829.GB28836@sigill.intra.peff.net>
References: <pull.328.git.gitgitgadget@gmail.com>
 <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 02, 2019 at 07:22:02PM -0700, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The commit-graph feature is now on by default, and is being
> written during 'git gc' by default. Typically, Git only writes
> a commit-graph when a 'git gc --auto' command passes the gc.auto
> setting to actualy do work. This means that a commit-graph will
> typically fall behind the commits that are being used every day.
> 
> To stay updated with the latest commits, add a step to 'git
> fetch' to write a commit-graph after fetching new objects. The
> fetch.writeCommitGraph config setting enables writing a split
> commit-graph, so on average the cost of writing this file is
> very small. Occasionally, the commit-graph chain will collapse
> to a single level, and this could be slow for very large repos.
> 
> For additional use, adjust the default to be true when
> feature.experimental is enabled.

Seems like a good time to do it. We'd eventually want a similar option
for updating it on the receiving side of a push, too. I don't insist
that come at the same time, but we should at least have a plan about how
it will look to the user.

Do we want to to have fetch.writeCommitGraph, receive.writeCommitGraph,
and then a master transfer.writeCommitGraph?

-Peff
