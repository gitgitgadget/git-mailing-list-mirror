Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 374A51F454
	for <e@80x24.org>; Mon,  4 Nov 2019 19:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfKDT7a (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 14:59:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:38584 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729489AbfKDT73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 14:59:29 -0500
Received: (qmail 3992 invoked by uid 109); 4 Nov 2019 19:59:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Nov 2019 19:59:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6223 invoked by uid 111); 4 Nov 2019 20:02:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Nov 2019 15:02:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Nov 2019 14:59:28 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Fix locking issues with git fetch --multiple
 --jobs=<n> and fetch.writeCommitGraph
Message-ID: <20191104195928.GC20900@sigill.intra.peff.net>
References: <pull.443.git.1572740518.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.443.git.1572740518.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 03, 2019 at 12:21:55AM +0000, Johannes Schindelin via GitGitGadget wrote:

> The git fetch command recently learned to extend the --jobs=<n> option to
> cover the --multiple mode: it will run multiple fetches in parallel.
> 
> Together with the recent support to write commit-graphs automatically after
> each fetch by setting fetch.writeCommitGraph, this led to frequent issues
> where the commit-graph-chain.lock file could not be created because a
> parallel job had already created it.
> 
> This pair of patches first introduces the command-line option 
> --write-commit-graph (together with the --no-* variant) and then uses it to
> avoid writing the commit-graph until all fetch jobs are complete.

Thanks, the whole thing looks clearly explained and the patches
themselves look good. And having "--[no-]write-commit-graph" is a good
thing even independent of the problem you're fixing.

I wondered if it was worth having a test in the second patch, but I
think it would be inherently racy. So it's probably not worth the
trouble.

-Peff
