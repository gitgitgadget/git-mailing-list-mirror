Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0EF1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 23:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391311AbeIVFtR (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 01:49:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:55784 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725756AbeIVFtR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 01:49:17 -0400
Received: (qmail 8833 invoked by uid 109); 21 Sep 2018 23:58:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Sep 2018 23:58:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10095 invoked by uid 111); 21 Sep 2018 23:57:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 21 Sep 2018 19:57:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2018 19:58:03 -0400
Date:   Fri, 21 Sep 2018 19:58:03 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 2/2] commit-reach: fix memory and flag leaks
Message-ID: <20180921235803.GB3437@sigill.intra.peff.net>
References: <pull.39.v2.git.gitgitgadget@gmail.com>
 <pull.39.v3.git.gitgitgadget@gmail.com>
 <b2e0ee49788bfbf2182df7a93694333568552962.1537542323.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2e0ee49788bfbf2182df7a93694333568552962.1537542323.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 08:05:27AM -0700, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The can_all_from_reach_with_flag() method uses 'assign_flag' as a
> value we can use to mark objects temporarily during our commit walk.
> The intent is that these flags are removed from all objects before
> returning. However, this is not the case.
> 
> The 'from' array could also contain objects that are not commits, and
> we mark those objects with 'assign_flag'. Add a loop to the 'cleanup'
> section that removes these markers.
> 
> Also, we forgot to free() the memory for 'list', so add that to the
> 'cleanup' section.

Urgh, ignore most of my response to patch 1, then. I saw there was a
patch 2, but thought it was just handling the free().

The flag-clearing here makes perfect sense.

-Peff
