Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A80C1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 19:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbeDFTVt (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 15:21:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:56256 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751298AbeDFTVs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 15:21:48 -0400
Received: (qmail 24387 invoked by uid 109); 6 Apr 2018 19:21:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 19:21:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28625 invoked by uid 111); 6 Apr 2018 19:22:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 15:22:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 15:21:46 -0400
Date:   Fri, 6 Apr 2018 15:21:46 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Lazy-load trees when reading commit-graph
Message-ID: <20180406192146.GC921@sigill.intra.peff.net>
References: <20180403120057.173849-1-dstolee@microsoft.com>
 <20180406190919.167092-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180406190919.167092-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 06, 2018 at 07:09:30PM +0000, Derrick Stolee wrote:

> Derrick Stolee (4):
>   treewide: rename tree to maybe_tree
>   commit: create get_commit_tree() method
>   treewide: replace maybe_tree with accessor methods
>   commit-graph: lazy-load trees for commits

I gave this only a cursory read, but it addresses my concern from the
previous round.

If I were doing it myself, I probably would have folded patches 1 and 3
together. They are touching all the same spots, and it would be an error
for any case converted in patch 1 to not get converted in patch 3. I'm
assuming you caught them all due to Coccinelle, though IMHO it is
somewhat overkill here. By folding them together the compiler could tell
you which spots you missed.

And going forward, I doubt it is going to be a common error for people
to use maybe_tree directly. Between the name and the warning comment,
you'd have to really try to shoot yourself in the foot with it. The
primary concern was catching people using the existing "tree" name,
whose semantics changed.

All that said, I'm fine with having it done this way, too.

-Peff
