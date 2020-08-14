Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E5DC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 18:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1814020771
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 18:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmpDyEt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgHNSHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 14:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgHNSHX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 14:07:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8754EC061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 11:07:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so8647572wma.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 11:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ORTy7wgHCaKOHsCLyL1vtAPF9hWLvbE7MJAqJmmfX9w=;
        b=PmpDyEt77Zr/lqjFDysLorOl/M9/8VwOhY1yaToWgDL7qImNf8O91GBhPAWjH7Z2/m
         3+idBv719B8K4NLy7LPjxoZjz7wElRuhfcWct5SnhWpwSolvWPfeUviUbDuZbXcKtv9C
         yO0FxhiHZVPCqFFa1SgOrnV+2SF4QjXGGA8KVEtkwmbuDqSq63BuQuFVbnzoy3YrQNoG
         m2TtodulJ4EUlvk/muUukgNZEXFzv1t4w9Al0KObdDWRqJgRYgaRmnPlKINaNf3RyZku
         xaRyQZlHiXTMFBkhjFj94Aok5paYYNIXvCQhdcI5O8b6EvtPh3uOwmMWDn02xIaWBRbV
         xjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ORTy7wgHCaKOHsCLyL1vtAPF9hWLvbE7MJAqJmmfX9w=;
        b=J+/w9w3EO//ly7vb8Nrp1yfgdR6hPzLY0zOIwP0fz/Gl+CiomJ3/twiQ11ySptkQxM
         9TlSUeAuza4BElNjbKtXfdDhJHiheBK8YDUjXXw1NM8AFAwkD2fWYebqpOOvUy28FdRH
         6s21Qr0W2NSkXyFYuJOzVVHXBdzDOU6fdF/eIufJNUCGcDkP2lOc0b0Aeegu30R6pLXY
         7VYRPMRC/Qy+/SU8fdGuzt5aPaGsd3pfFkcC/kswEmTjh8nXG0RLFtGTgIZZ0B+6B/no
         HEOMEaKlugurBygCJYk5tq7s7GPdn9SzT4gE1Ay2Y9Ci3dp85TsuyLL6+Kd4pE7z4ufV
         Bfdg==
X-Gm-Message-State: AOAM5311Jv2+3kiC14EuLlcMJcFCxkijPDb4R8cppDoxG4wg3iSuGzeM
        vUwycyONYa/St1+Ai1MUHAuEWN68QcU=
X-Google-Smtp-Source: ABdhPJy/UYtJV0e4qioZASKLm0HOnUPepioBUlbzvjFS0ogzCVVz994rZqscBjOjHV3eTNF1g5fPQg==
X-Received: by 2002:a7b:c923:: with SMTP id h3mr3465784wml.142.1597428441973;
        Fri, 14 Aug 2020 11:07:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f131sm16743994wme.40.2020.08.14.11.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 11:07:21 -0700 (PDT)
Message-Id: <pull.703.git.1597428440.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 18:07:17 +0000
Subject: [PATCH 0/3] SHA-256: Update commit-graph and multi-pack-index formats
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, sandals@crustytoothpaste.net,
        me@ttaylorr.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed [1], there is some concern around binary file formats requiring
the context of the repository config in order to infer hash lengths. Two
formats that were designed with the hash transition in mind (commit-graph
and multi-pack-index) have bytes available to indicate the hash algorithm
used. Let's actually update these formats to be more self-contained with the
two hash algorithms being available.

[1] 
https://lore.kernel.org/git/CAN0heSp024=Kyy7gdQ2VSetk_5iVhj_qdT8CMVPcry_AwWrhHQ@mail.gmail.com/

This merges cleanly with tb/bloom-improvements, but both that branch and
this patch series have merge conflicts with the corrected commit date patch
series [2].

[2] 
https://lore.kernel.org/git/pull.676.v2.git.1596941624.gitgitgadget@gmail.com/

In particular, the following conflict can be resolved in the "obvioius" way:

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< HEAD
    header: 43475048 1 $OID_VERSION 3 $NUM_BASE
================================
    header: 43475048 1 1 4 $NUM_BASE
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> abhishek/corrected_commit_date

Instead use:

    header: 43475048 1 $OID_VERSION 4 $NUM_BASE

But, it also needs the following fix to actually work with this series:

diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 211ec625d2..09f133792c 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -464,7 +464,7 @@ test_expect_success 'setup repo for mixed generation commit-graph-chain' '
        GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split=no-merge &&
        test-tool read-graph >output &&
        cat >expect <<-EOF &&
-       header: 43475048 1 1 4 1
+       header: 43475048 1 $OID_VERSION 4 1
        num_commits: 2
        chunks: oid_fanout oid_lookup commit_metadata
        EOF
@@ -482,7 +482,7 @@ test_expect_success 'does not write generation data chunk if not present on exis
        git commit-graph write --reachable --split=no-merge &&
        test-tool read-graph >output &&
        cat >expect <<-EOF &&
-       header: 43475048 1 1 4 2
+       header: 43475048 1 $OID_VERSION 4 2
        num_commits: 3
        chunks: oid_fanout oid_lookup commit_metadata
        EOF

If this is the way we want to go with the formats, then I'll assist
coordinating these textual and semantic merge conflicts.

Thanks, -Stolee

Derrick Stolee (3):
  t/README: document GIT_TEST_DEFAULT_HASH
  commit-graph: use the hash version byte
  multi-pack-index: use hash version byte

 .../technical/commit-graph-format.txt         |  9 +++-
 Documentation/technical/pack-format.txt       |  7 ++-
 commit-graph.c                                |  6 ++-
 midx.c                                        | 32 +++++++++++---
 t/README                                      |  3 ++
 t/helper/test-read-midx.c                     |  8 +++-
 t/t4216-log-bloom.sh                          |  8 +++-
 t/t5318-commit-graph.sh                       | 37 +++++++++++++++-
 t/t5319-multi-pack-index.sh                   | 43 +++++++++++++++++--
 t/t5324-split-commit-graph.sh                 |  8 +++-
 10 files changed, 142 insertions(+), 19 deletions(-)


base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-703%2Fderrickstolee%2Fcommit-graph-256-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-703/derrickstolee/commit-graph-256-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/703
-- 
gitgitgadget
