Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2100C54EEB
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 09:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D2720719
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 09:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgCVJvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 05:51:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:46968 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726866AbgCVJvi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 05:51:38 -0400
Received: (qmail 27383 invoked by uid 109); 22 Mar 2020 09:51:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Mar 2020 09:51:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31252 invoked by uid 111); 22 Mar 2020 10:01:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2020 06:01:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Mar 2020 05:51:37 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jonathantanmy@google.com,
        christian.couder@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/2] Slightly simplify partial clone user experience
Message-ID: <20200322095137.GB635598@coredump.intra.peff.net>
References: <pull.586.git.1584638887.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.586.git.1584638887.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 05:28:05PM +0000, Derrick Stolee via GitGitGadget wrote:

> This was something discussed briefly at the contributor summit: users will
> have a hard time remembering git clone --filter=blob:none <url>. This series
> simply adds a --partial option that is equivalent to --filter=blob:none,
> with the ability to specify a size using --partial=<size> that is equivalent
> to --filter=blob:limit=<size>.

I have mixed feelings on this. I do like making things less arcane for
users. But are we locking in a behavior for --partial that we might not
want to live with forever? I.e., the current thinking for partial clones
is to fetch no blobs at all, get all commits and trees, apply sparse
filters, and then fault in the blobs we need. But imagine we later grow
the ability to easily avoid fetching all of the trees. Would we regret
having the simple name "--partial" taken?

-Peff
