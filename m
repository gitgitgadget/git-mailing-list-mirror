Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7CEEB64D9
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 00:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjGHAbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 20:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGHAbc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 20:31:32 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF98E1FD8
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 17:31:30 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-c6833e6e326so2783216276.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 17:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1688776290; x=1691368290;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpoLQpfYfYNs5c47bh8N/29ITgrOvxeMzmQfi23R03c=;
        b=QAbUkJs/62j9bN0j/pyIzpTcf3zqG2+kHbru9sIVsOuc2acVsiISh2Kp2EoaZr10jt
         0HXYzQod/WHRKJkQcSPWumW68kZBCcy1nYBN+hNkaolMXp0lAs7Y/WBlUsWs7WeolRGB
         jBPDTgI7x4TQpbdEcJpFgsnJhcC27xb6GVQQ0wxBdqjxW0Q7YGOpIcUvOeWWWaTnXfOR
         EbAB1cFgv+FfuXpCH1jAQAEvh3o5TSRUiMATtARiuT9JA3ARjjXmwE8tmrNFSGNul5mx
         7VyVFWqBucYznL0H0j+72tJdHplNref2wH26YZyXek2Wri0VpNp3quppy6K7aJ6vWFYe
         re5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688776290; x=1691368290;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpoLQpfYfYNs5c47bh8N/29ITgrOvxeMzmQfi23R03c=;
        b=hFNiyaCS8fjmbP0yGnBSW0bJVjf9FdZ/eEdIi0P4or5qYbJpts0OABy5XsUPB+NRvi
         weORDyTxySZupvCKYQl2TEsja3bgzCkbuVqb0fuLBCRfdvM0nMnKQYhuChxg+ZRII+Q3
         s+QruUELRZdls50BcSOTPcsejyVuwUuHjqekkYy4BexKS43uxQo7F0OzhIte10uPcBkJ
         5y6OvhN+EFlqJ5xrPK3YTflA/2ESSa6BS+5Qg6bgQIL13c1XwSvUp9iX2NW8vqKgoBxJ
         F97qmokwCXNvqZagIEiZD9V/KB7TaaqC7dY6dNMh4cyJOHRmqTdtOgBTrnYY4NurTyH7
         Gu9A==
X-Gm-Message-State: ABy/qLbrWvIFJj4b3YuwoCl8Ps6MqjvTCW9ni/boSgJQ0QSqaBmP/rzZ
        GyFLXrZaN6WVWT13IsU3cvUIoOetF4YIinjhytQ0WQ==
X-Google-Smtp-Source: APBJJlEVeONv3Lp/4+CFwO4S+Lq3DevpmnC22eqjKpv2z7br90rUoDsbAyvi749v3vngHBLWs+k0Rg==
X-Received: by 2002:a5b:44a:0:b0:c0b:7483:5cf0 with SMTP id s10-20020a5b044a000000b00c0b74835cf0mr5155768ybp.65.1688776289865;
        Fri, 07 Jul 2023 17:31:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x26-20020a25acda000000b00c4ec3a3f695sm1266192ybd.46.2023.07.07.17.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 17:31:29 -0700 (PDT)
Date:   Fri, 7 Jul 2023 20:31:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 0/6] fsck: squelch progress output with `--no-progress`
Message-ID: <cover.1688776280.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This short series addresses a pair of issues where the `commit-graph
verify` and `multi-pack-index verify` steps of `git fsck` produce output
regardless of whether or not `fsck` was invoked with the
`--no-progress` option or not.

The first two patches address the commit-graph and MIDX issues
respectively. The final four patches further clean up the output of
`git commit-graph verify --progress` when verifying multi-layer graphs
to produce a single progress meter instead of one per graph layer.

Before, the output of `git commit-graph verify` on a repository with a
commit-graph chain with two layers looked like:

    $ git.compile commit-graph verify
    Verifying commits in commit graph: 100% (4356/4356), done.
    Verifying commits in commit graph: 100% (131912/131912), done.

After this patch series, the output instead looks as follows:

    $ git.compile commit-graph verify
    Verifying commits in commit graph: 100% (136268/136268), done.

Thanks in advance for your review.

Taylor Blau (6):
  fsck: suppress commit-graph output with `--no-progress`
  fsck: suppress MIDX output with `--no-progress`
  commit-graph.c: extract `verify_one_commit_graph()`
  commit-graph.c: iteratively verify commit-graph chains
  commit-graph.c: pass progress to `verify_one_commit_graph()`
  commit-graph.c: avoid duplicated progress output during `verify`

 builtin/fsck.c                |  8 ++++++
 commit-graph.c                | 53 +++++++++++++++++++++++------------
 t/t5318-commit-graph.sh       | 10 +++++++
 t/t5319-multi-pack-index.sh   | 12 ++++++++
 t/t5324-split-commit-graph.sh |  3 +-
 5 files changed, 67 insertions(+), 19 deletions(-)

-- 
2.41.0.242.g6eec849fa5a
