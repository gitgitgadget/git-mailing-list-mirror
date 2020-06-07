Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C7BC433DF
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 19:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E562073B
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 19:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a22XQFe+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFGTeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 15:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGTeb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 15:34:31 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08BC08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 12:34:31 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 64so694964pfv.11
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KqwyX+3w7vrVkWsb3B/xln4OGXHs2KZdTpaM6HlRcOI=;
        b=a22XQFe+VKHjvBvVAM4UDGBeDnb0KqNqrGvyn8znAvERq+nL06PbaJlj4dhcNqZFxG
         LYHiBCfQT93IFsLpFJdE6U2X7BBGm5lf58nyGRC0XycqINnwje7GS15KvqSGZg4cYswJ
         QTEem7OrfWEuE7snUqAC7mPMPPsITXPTJ+fOk/SMJd9F/K9kmD3tRpIGCakdhZLuQubG
         +Q3Y+U8mC2jmnX/3sfxjaXCRtqR/Jr2+o4j5xwKtU9eE/EDrVqCRhyx3LYVjKqvWb97e
         bH0xrrmzDjopCfjS8rcYdi1YA+8UYJVmkF51Bh8sq3I88hwSOw+7oWx1cBirEoLi6fZI
         H6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqwyX+3w7vrVkWsb3B/xln4OGXHs2KZdTpaM6HlRcOI=;
        b=k5NYgz1fG7FahRRHC9fmZWZfQLvt302W4jZG3eEBBjm8eS+ut+Ddm0d2krVL/8B2Kv
         3vkFKS3ooDdG8Tm0fZQhUXbGHJQjGRMcBRme6kaiC+nQX0qGzQYT3mA52VnLKJ8WK829
         x1gqbv2pefFLTx0cUgomo3zKRwkuZnACdJZbs3rIQQbv2sJQR0mUagSd1lVxMqI9JU/G
         RcK52bWwTre5bGQ6gSllmwrGARH0xJ8PoBcpa2fPq2fntLK+dWJ4XoxrjrdY9Bg0a9oR
         lqyZoHEQ7miBoetOhlH4tSvFa7AYrtqWEoOQSjalz+wI2nSnNWbiQemBeafcDWncoInC
         CCNQ==
X-Gm-Message-State: AOAM531AAQfiyqPe+oXCZaNFL3uIe3EroUMOjxKT3q7Q18SwuVbBvwuO
        L6PBHRIaBBxOnSLI4OAYDCimKEPQ
X-Google-Smtp-Source: ABdhPJzpXW0WhUUlK+p1J/iXRJWP066BHrHXJLWZhPX6w3Mzc4MELdQxX9mzxhvIgCXDlMJI18LX8A==
X-Received: by 2002:a63:444a:: with SMTP id t10mr17897155pgk.149.1591558470417;
        Sun, 07 Jun 2020 12:34:30 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:58e:925f:60d1:f386:43d2:4abb])
        by smtp.gmail.com with ESMTPSA id n69sm158595pfd.171.2020.06.07.12.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 12:34:29 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, stolee@gmail.com
Subject: [GSOC Patch v2 0/4] Move generation, graph_pos to a slab
Date:   Mon,  8 Jun 2020 01:02:33 +0530
Message-Id: <20200607193237.699335-1-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
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
generation number v2, which uses 64-bite generation number instead of
current 32-bits.

Abhishek Kumar (4):
  commit-graph: introduce commit_graph_data_slab
  commit: move members graph_pos, generation to a slab
  commit-graph: use generation directly when writing commit-graph
  commit-graph: minimize commit_graph_data_slab access

 alloc.c                         |   2 -
 blame.c                         |   2 +-
 bloom.c                         |   7 +-
 commit-graph.c                  | 127 ++++++++++++++++++++++++--------
 commit-graph.h                  |  10 +++
 commit-reach.c                  |  69 ++++++++++-------
 commit.c                        |   8 +-
 contrib/coccinelle/commit.cocci |  18 +++++
 revision.c                      |  20 +++--
 9 files changed, 190 insertions(+), 73 deletions(-)

-- 
2.27.0

Thanks to Dr. Stolee, Dr. Narebski and Junio for their excellent
suggestions.

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

About the failing diff-submodule related tests, I came up with a
plausible explanation but could be wrong on this:

Commit slabs rely on uniqueness of commit->index to access data. But
submodules are repositories on their own, alloc_commit_index(), which
relies on repository->parsed_objects->commit_count no longer returns
unique values.

A commit belong to super repo and another belonging to submodule might
have the same index but different generation and graph positions.

This could be fixed by defining commit index as maximum of commit index
of all repositories + 1 but I have no idea how that would impact other
code.

Thoughts on this?

Regards
Abhishek
