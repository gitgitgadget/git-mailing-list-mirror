Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DE5C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A96D207F7
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfG4rmpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgFLSl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgFLSl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 14:41:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9C3C03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:41:59 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id j4so836019plk.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tCbciSfOl4NqGI53R9zKGBPjcfw2zGRKBLoO/OdL3zg=;
        b=kfG4rmpgLD6EcUYRoUwbbZOZqKxZ0oro9RC6b2n8QnRoYxbZYCry18mmafa5gkXzkh
         2vj68NqyiYSubb54p3aeAaPjIK2XGDHsuQjf04WG9ZA2kpz4Qdnmt7zqaFc1VEh7cesh
         xXk+2phSJd2+qMrfHBbO06VV13oRzAiONklmaZ93a3Os5Sw5V9qN+1gWpOVJaHIJCIhH
         gV4XW6U5eiZH3edvvbxIfJrcIu2yVY3/wWWBpbO+9hfhxZY04bsyk0HluUzryuFhh3xi
         adTlIWFpkcUSzILXEt5bKeT0M8il0GWwB2aTFYZ7nVSGJlIaJfApWcA0m1cKC6VsjGPb
         50aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tCbciSfOl4NqGI53R9zKGBPjcfw2zGRKBLoO/OdL3zg=;
        b=BDkbc0qog39K9MqgZ2w8x9FEmxvYn3x92MW96l8RxAYxKzfoOZFsGbdf20Y2Ww3ouR
         MgqGx50qWPpxJSck3EEZC4LhLghq5wftBDnUz8VfixG1XAleeJt4WQ01UBbf8xaq5rjV
         c3UUNCNLgauNNoNa0paX1aWw+u4YIEZbcbTxxwL1acdhRXdvN+q1sJtyNCXeGmZ0ewNa
         6mbSrG+avLEeeErm1DN6IP9SrbYF6mNTNhDAkjU8EG9jsvGt+r0EM+k0xlOTClE6q/Fl
         GB4bibWfGoNNO2wt/6hE/5MtWFR3vIb6Vi0/6NGhCfQFW52lHfw6COTbhfPpFVqZbReT
         PPjQ==
X-Gm-Message-State: AOAM533w0NIUXuhOeTtP6H08CgRmceCK/bz4mly1STfRl7lf/OZ0Xb8b
        OMyLpE+mafxMFQVT0ew8fng2Hiwy
X-Google-Smtp-Source: ABdhPJzyJLHfQXOOu4pfC5Nxyk8ytAIH8ZcJL7YK4OYohSDsI38JoEiM9UTL8TcpUvlqzi/sjI9ZEg==
X-Received: by 2002:a17:90a:64c9:: with SMTP id i9mr251765pjm.135.1591987318072;
        Fri, 12 Jun 2020 11:41:58 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:307:970b:360c:5006:374c:b8c0])
        by smtp.gmail.com with ESMTPSA id k12sm5985535pgm.11.2020.06.12.11.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 11:41:56 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jnareb@gmail.com
Subject: [GSoC Patch v3 0/4] Move generation, graph_pos to a slab
Date:   Sat, 13 Jun 2020 00:10:10 +0530
Message-Id: <20200612184014.1226972-1-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The struct commit is used in many contexts. However, members
`generation` and `graph_pos` are only used for commit graph related
operations and otherwise waste memory.

This wastage would have been more pronounced as we transition to
generation number v2, which uses 64-bit generation number instead of
current 32-bits.

While the overall test suite runs slightly faster than master
(series: 27m10s, master: 27ms34s, faster by 2.35%), certain commands
like `git merge-base --is-ancestory` are slowed by nearly 40% as
discovered by SDEZER Gabor [1].

Derrick Stolee believes the slow down is attributable to the underlying
algorithm rather than the slowness of commit-slab access [2] and we will
follow-up on that in a later series.

I did not mention maximum RSS in the commit messages as they were nearly
identical (series: 68104kb, master: 68040kb, fewer by <0.1%). This leads
me to conclude that either the test using maximum memory involves commit
graph or did not involve the struct commit at all. The move to
commit-slab reduces memory footprint for the cases where struct commit
is used but members generation and graph position are not. Average RSS
would have been a good and more representative measure, but 
unfortunately time(1) could not measure it on my system.

With this, I feel the patch will require minor fixes, if any. I am
moving ahead with working the next step of "Implement Generation Number
v2" that is proper handling of commit-graph format change.

Based on the discussions, I feel we should compute both generation
number v1 and the date offset value with storing date offsets in a new
chunk as the cost is mostly from walking the commits.

Abhishek Kumar (4):
  alloc: introduce parsed_commits_count
  commit-graph: introduce commit_graph_data_slab
  commit: move members graph_pos, generation to a slab
  commit-graph: minimize commit_graph_data_slab access

 alloc.c                         |   6 +-
 blame.c                         |   2 +-
 bloom.c                         |   7 +-
 commit-graph.c                  | 122 ++++++++++++++++++++++++--------
 commit-graph.h                  |  10 +++
 commit-reach.c                  |  69 +++++++++++-------
 commit.c                        |   8 ++-
 contrib/coccinelle/commit.cocci |  18 +++++
 revision.c                      |  20 +++---
 9 files changed, 188 insertions(+), 74 deletions(-)

-- 
2.27.0

Changes in v3:
- Introduce alloc commit to fix the failing diff-submodule test.
- Elaborate on performance and slow down noticed in the commit message.

Changes in v2:
- Introduce struct commit_graph_data.
- Merge `graph_pos`, `generation` slabs into a single,
  `commit_graph_data` slab.
- Use graph position for an intermediate check for generation, saving
  the cost of initializing generation numbers.
- Add an follow-up patch caching results of slab access in local
  variables.
- Move coccinelle transformation to commit.coccinelle instead of
  creating new scripts.
- Elaborate on removing default values from init_commit_node().
- Revert moving macro constants (e.g. COMMIT_NOT_FROM_GRAPH,
  GENERATION_NUMBER_ZERO) from commit.h to commit-graph.h

CI Build: https://travis-ci.com/github/abhishekkumar2718/git  
