Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2263FC54EE9
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 04:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIKE5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 00:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIKE5l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 00:57:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B172E9CD
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 21:57:40 -0700 (PDT)
Received: (qmail 18235 invoked by uid 109); 11 Sep 2022 04:57:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 11 Sep 2022 04:57:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31467 invoked by uid 111); 11 Sep 2022 04:57:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Sep 2022 00:57:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Sep 2022 00:57:38 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 0/4] list-objects-filter cleanups
Message-ID: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the recent jk/plug-list-object-filter-leaks topic[1], I stopped short
of fixing all of the callers to actually initialize the filter struct
beyond zero-ing it.

This series does the cleanup that I was afraid to do there. :)

I think the end result is less confusing and error-prone. And as you can
see in patch 4, it matches how the code originally hoped to be written,
but the author was also afraid of the zero-initialization thing.

It is kind of churny, and carries some risk of regression (if I missed a
spot). IMHO it's worth it, but even if we don't take it, we should pick
up the first two patches, which are small bug-lets that the conversion
turned up.

These patches should be applied on top of jk/plug-list-object-filter-leaks,
which is currently in next.

  [1/4]: list-objects-filter: don't memset after releasing filter struct
  [2/4]: list-objects-filter: handle null default filter spec
  [3/4]: list-objects-filter: add and use initializers
  [4/4]: list-objects-filter: convert filter_spec to a strbuf

 builtin/clone.c               |  2 +-
 builtin/fetch-pack.c          |  1 +
 builtin/fetch.c               |  2 +-
 builtin/submodule--helper.c   |  8 ++--
 bundle.h                      |  1 +
 list-objects-filter-options.c | 75 ++++++++++++++---------------------
 list-objects-filter-options.h |  5 ++-
 revision.c                    |  1 +
 transport-helper.c            |  2 +
 transport.c                   |  1 +
 upload-pack.c                 |  1 +
 11 files changed, 47 insertions(+), 52 deletions(-)

-Peff

[1] https://lore.kernel.org/git/Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net/
