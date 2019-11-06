Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99ADB1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 04:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfKFEJ4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:09:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:40126 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727266AbfKFEJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:09:56 -0500
Received: (qmail 17718 invoked by uid 109); 6 Nov 2019 04:09:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Nov 2019 04:09:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19370 invoked by uid 111); 6 Nov 2019 04:13:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Nov 2019 23:13:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Nov 2019 23:09:55 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rynus@gmail.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] commit-graph: use start_delayed_progress()
Message-ID: <20191106040955.GD4307@sigill.intra.peff.net>
References: <pull.450.git.1572969955.gitgitgadget@gmail.com>
 <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
 <78bd6bc2c02f1daf13938a738d8eae56b5f6b74c.1572984842.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78bd6bc2c02f1daf13938a738d8eae56b5f6b74c.1572984842.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 05, 2019 at 08:14:02PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When writing a commit-graph, we show progress along several commit
> walks. When we use start_delayed_progress(), the progress line will
> only appear if that step takes a decent amount of time.
> 
> However, one place was missed: computing generation numbers. This is
> normally a very fast operation as all commits have been parsed in a
> previous step. But, this is showing up for all users no matter how few
> commits are being added.

Yep, makes sense (especially that it should all the other progress as
part of the same process).

> Now that we changed this method, very fast commands show no progess at
> all. This means we need to stop testing for seeing these progress lines
> in the test suite.

I think this is OK for now, though it does make me wonder if
"--progress" ought to perhaps override "delayed" in some instances,
since it's a positive signal from the caller that they're interested in
seeing progress.

-Peff
