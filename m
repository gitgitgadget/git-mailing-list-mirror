Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109401F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 21:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeJJEZL (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 00:25:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:34672 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727862AbeJJEZL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 00:25:11 -0400
Received: (qmail 9205 invoked by uid 109); 9 Oct 2018 21:06:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Oct 2018 21:06:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10053 invoked by uid 111); 9 Oct 2018 21:05:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 09 Oct 2018 17:05:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Oct 2018 17:06:20 -0400
Date:   Tue, 9 Oct 2018 17:06:20 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] commit-graph: write a Bloom filter containing
 changed paths for each commit
Message-ID: <20181009210620.GA9563@sigill.intra.peff.net>
References: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181009193445.21908-1-szeder.dev@gmail.com>
 <20181009193445.21908-3-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181009193445.21908-3-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 09, 2018 at 09:34:43PM +0200, SZEDER Gábor wrote:

> Creating the Bloom filter is sloooow.  Running it on git.git takes
> about 23s on my hardware, while
> 
>   git log --format='%H%n%P' --name-only --all >/dev/null
> 
> gathers all the information necessary for that in about 5.3s.

That command won't open the trees for merges at all. But your
implementation here looks like it does a diff against each parent of a
merge. Adding "-m" would be a more accurate comparison, I think.

Though I find that puzzling, because "-m --name-only" seems to take
about 20x longer, not 3x. So perhaps I'm missing something.

-Peff
