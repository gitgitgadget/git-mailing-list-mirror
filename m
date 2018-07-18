Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BBB21F597
	for <e@80x24.org>; Wed, 18 Jul 2018 20:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeGRVYC (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 17:24:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:51728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729281AbeGRVYC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 17:24:02 -0400
Received: (qmail 18191 invoked by uid 109); 18 Jul 2018 20:44:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Jul 2018 20:44:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3419 invoked by uid 111); 18 Jul 2018 20:44:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 18 Jul 2018 16:44:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2018 16:44:25 -0400
Date:   Wed, 18 Jul 2018 16:44:24 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] add core.usereplacerefs config option
Message-ID: <20180718204424.GA1483@sigill.intra.peff.net>
References: <20180718201702.GA15306@sigill.intra.peff.net>
 <c36c1b42-3f37-b32d-08a8-2ced5d254149@gmail.com>
 <20180718203152.GA26110@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718203152.GA26110@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 04:31:52PM -0400, Jeff King wrote:

> Since Stefan's patch logically undoes e1111cef23, I think that's why he
> put in the comment to move back to the old name.
> 
> Personally, I do not find one name any more informative than the other,
> and would be happy to leave it as-is (dropping the comment).
> 
> But I'm also fine with following through on the "do". According to
> c3c36d7de2, that was waiting for a calmer time in the code base. I guess
> the best way to find out is to write the patch and see how terribly it
> conflicts with pu. :)

It turns out there are no conflicts right now, aside from the patch I
just sent. And perhaps your commit-graph work is going to add another
reference, if you take my suggestion in the other thread. ;)

So I remain ambivalent, but here is the patch to do so, with mine now on
top (the only difference is s/read/check/ in the variable name).

But note that while changing this, I noticed a leftover bit from
c3c36d7de2 that should be dealt with in either case. I put that at the
front of the series.

  [1/3]: check_replace_refs: fix outdated comment
  [2/3]: check_replace_refs: rename to read_replace_refs
  [3/3]: add core.usereplacerefs config option

 Documentation/config.txt | 5 +++++
 builtin/fsck.c           | 2 +-
 builtin/index-pack.c     | 2 +-
 builtin/pack-objects.c   | 2 +-
 builtin/prune.c          | 2 +-
 builtin/replace.c        | 2 +-
 builtin/unpack-objects.c | 2 +-
 builtin/upload-pack.c    | 2 +-
 cache.h                  | 6 ++----
 config.c                 | 5 +++++
 environment.c            | 4 ++--
 git.c                    | 2 +-
 log-tree.c               | 2 +-
 replace-object.c         | 2 +-
 replace-object.h         | 2 +-
 t/t6050-replace.sh       | 6 ++++++
 16 files changed, 31 insertions(+), 17 deletions(-)

-Peff
