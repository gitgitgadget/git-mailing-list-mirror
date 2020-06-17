Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40DAC433E2
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 09:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7422166E
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 09:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5x1CBdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgFQJQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQJQR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 05:16:17 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D04C061573
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 02:16:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jz3so698896pjb.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 02:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RM1f0BIa6E8/FkIIbRGcN2r2OLIktbG+zOVa0o/WVvE=;
        b=i5x1CBdim2HxtRX5vcCkYyru3Tk7Nw7mZz7XuikfsHd1WOp5ZDHAj0d2LQpQOSImQB
         ZQcBLg8IPT5B6KiFq+levQQJvTQqk6zHB2IAM6+xK2TxMaoYYRCNUScObndf1ij5bGgt
         S8E6Fx6KguxfhsxmYS308vgnzjuFARXBgK4o7GADkovHiDlgJEb8rC3JMC4iUI/jB4IE
         33aqIK04/L3dYykATI9l1EoWsq+G3hMWAbSAp2hBfz+SSoNohX7Bd4fuOHGIYst2nhon
         8FytkFbf/lolMD5iQ2SObNuowJDOJwwSlEtFx1xljuHkFQ8pgRuLiLc3roAmXQ79lb8P
         fIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RM1f0BIa6E8/FkIIbRGcN2r2OLIktbG+zOVa0o/WVvE=;
        b=Nn/1QcRIZE0VvHO7SgpPnkQ4hWSg8S4CamcyCsfYAGkEdCOxcK3wKPHii7mAEqj4pq
         zxmNKAliP1QrglZleo09UQl7FHNaDApU7eXMugjsRUnkrxnlT00wST9ekFnne76uw1Zg
         m9taY5R48ogtcJZUO5aOr9O9dCZfhdXRXxwgz99fcwIHVFMViOmd49hOwGllR14q2z8s
         OppLUJyciwEjXvMW3tACMxyveGkUXIoL7vR9xirqxvFj9xNDMmwGVvprFLqDqOJvYr3K
         OfPM/4+daoYmiggInBFVPY/9t1d5G9CeY11mgI3D3P+CmANShdxScVBICcdK4lWbc0xe
         I/vA==
X-Gm-Message-State: AOAM533BoEvzwtBnEmOabrCMHfujbOu5oJtNHwV98AAvg9I8g70U5v3d
        Tmv4sEOpc5WgKHloDutGYKayueQt
X-Google-Smtp-Source: ABdhPJx2N2uRva3Q2mkFomg/eWregn6adIjcN0TouEiYv3zN8auAjobNtLfjS7hkY2bquFrrU1cupQ==
X-Received: by 2002:a17:90a:898a:: with SMTP id v10mr6674090pjn.95.1592385375662;
        Wed, 17 Jun 2020 02:16:15 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:40b:ccca:8c2b:e6b:e670:4483])
        by smtp.gmail.com with ESMTPSA id r8sm17162110pgn.19.2020.06.17.02.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 02:16:14 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, stolee@gmail.com
Subject: [GSOC Patch v4 0/4] Move generation, graph_pos to a slab
Date:   Wed, 17 Jun 2020 14:44:07 +0530
Message-Id: <20200617091411.14650-1-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The struct commit is used in many contexts. However, members
`generation` and `graph_pos` are only used for commit graph related
operations and otherwise waste memory.

This wastage would have been more pronounced as we transition to
generation nuber v2, which uses 64-bit generation number instead of
current 32-bits.

While the overall test suite runs as fast as master
(series: 26m48s, master: 27m34s, faster by 2.87%), certain commands
like `git merge-base --is-ancestor` were slowed by 40% as discovered
by Szeder Gábor [1]. After minimizing commit-slab access, the slow down
persists but is closer to 20%.

Derrick Stolee believes the slow down is attributable to the underlying
algorithm rather than the slowness of commit-slab access [2] and we will
follow-up in a later series.

Abhishek Kumar (4):
  object: drop parsed_object_pool->commit_count
  commit-graph: introduce commit_graph_data_slab
  commit: move members graph_pos, generation to a slab
  commit-graph: minimize commit_graph_data_slab access

 alloc.c                         |  18 +++--
 alloc.h                         |   2 +-
 blame.c                         |   2 +-
 blob.c                          |   2 +-
 bloom.c                         |   7 +-
 builtin/commit-graph.c          |   2 +-
 builtin/fsck.c                  |   2 +-
 commit-graph.c                  | 130 ++++++++++++++++++++++++--------
 commit-graph.h                  |  10 +++
 commit-reach.c                  |  69 ++++++++++-------
 commit.c                        |  12 +--
 commit.h                        |   2 -
 contrib/coccinelle/commit.cocci |  18 +++++
 object.c                        |   4 +-
 object.h                        |   3 +-
 refs.c                          |   2 +-
 revision.c                      |  20 +++--
 t/helper/test-reach.c           |   2 +-
 tag.c                           |   2 +-
 tree.c                          |   2 +-
 20 files changed, 217 insertions(+), 94 deletions(-)

-- 
2.27.0

Changes in v4:
- Fix segfault while initializing commit_graph_data_slab.
- Fix the "commit index should have unique values" more cleanly

Changes in v3:
- Introduce alloc commit to fix the failing diff-submodule test.
- Elaborate on perforamnce and the slow down in commit message

Changes in v2:
- Introduce struct commit_graph_data
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
  GENERATION_NUMBER_ZERO0 from commit.h to commit-graph.h
