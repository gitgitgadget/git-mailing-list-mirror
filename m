Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC3301FAE2
	for <e@80x24.org>; Wed,  7 Feb 2018 13:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753913AbeBGNXH (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 08:23:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:43582 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753794AbeBGNXH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 08:23:07 -0500
Received: (qmail 8093 invoked by uid 109); 7 Feb 2018 13:23:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Feb 2018 13:23:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30104 invoked by uid 111); 7 Feb 2018 13:23:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Feb 2018 08:23:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Feb 2018 08:23:05 -0500
Date:   Wed, 7 Feb 2018 08:23:05 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: BUG: fetch in certain repo always gives "did not send all
 necessary objects"
Message-ID: <20180207132304.GC16018@sigill.intra.peff.net>
References: <CABPp-BHVD19ZoAmWhQd9aN-v+qB7Ryq9Z-wobLYtJf_b6RWgzQ@mail.gmail.com>
 <CAGZ79kYstN9ATPGKZjnk-hJ6jRsx9Oz0b2hQ5cTiqVqMNDCsyA@mail.gmail.com>
 <CABPp-BHkLLrJDTQwHTYpqC0Cg7Wv_wDr14Fq_LXneg+OzzRngg@mail.gmail.com>
 <CACsJy8CUgmyw6Ug6wQEFaj9Ze45mZfRoE4J16zVv5usT791Kmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CUgmyw6Ug6wQEFaj9Ze45mZfRoE4J16zVv5usT791Kmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 07, 2018 at 06:08:40PM +0700, Duy Nguyen wrote:

> > And/or ideas of what steps could cause corruption so I can send out a
> > PSA to help users avoid it?
> 
> There is another thing we could do. One bad HEAD should not abort the
> entire operation (at least if it's not the current worktree's HEAD).
> We could still give a warning and move on, or don't warn at all and
> let "git worktree prune" collect it (which I see from your message
> that it also fails to do).

Whether that's safe or not depends very much on what the caller intends
to do with the ref. Skipping broken refs in "git prune" is a bad idea,
for instance.

-Peff
