Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F495C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbiDMUFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbiDMUEn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B7B7CDC3
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p18so3346746wru.5
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bpr5J1HNLv4JIm4Du6h8y4lS+ZjlRfTkWVS5x6pU54Q=;
        b=dGots9v5n/ScirCDJfwOMy3nUoOl5eOQVToW+CHGw6qtv05es3ukRyFYiBAhsYe3B5
         uhYeHDvrBJrnjRVo6H4eSCSduIJXU74VZkBNkNNvaYG7b9SHQuVGIDZYLgPwtRK7gwZZ
         M8yH5nJej8n1Z5gXvNMT6e5+kmGYu0uWzNEiVx4U+Svss/SrlKauMThBbCz4BhQKDT/m
         8jwrK4aFzSEySd55hdNpuI6yZZ8vYS+khCVO0n/m9VOavg/x8slB8bnqTm4LqsCA13Ks
         iaxOKzD2CifbS3GErMGZu0Z4sT7extIecxB9HwP8WbMrHIpcTPCPtdfv9tzLWI6h8ex+
         2j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpr5J1HNLv4JIm4Du6h8y4lS+ZjlRfTkWVS5x6pU54Q=;
        b=lP6EG0sv2DPYk01D60Vb62YY6p6nQTYfmlYXMPCOyxfIVrvniIpt1VJrLQ/nNg5Rza
         w2MHcC44XLboCwtd8xHflDc0roFZyH347b99a6NXKMQFuPZq+quTbLnfEul+OinhVqnw
         jiM+5rEkbEc0K2gCkTPVEzceIK6e4cuaHOqkPKe2xfrpne6w3r7kWJjjaW8LrIZGDJ/r
         www1Ogpm1/0QzvFi01rEF15tScRCHXzpiK5bBO82NNVLnG8QJ36lVfY68jNu4jVOfWC9
         /ql/WirgvX7VTALAvaP/zzy9VldQQp71hTmSXVRuoxtD+MgPv8aXC42WHNermce3NmIX
         zvLA==
X-Gm-Message-State: AOAM5315/Ov7zaxCS1S8JJvKOa5P+RxxpL0fUPvJe/S+BdiqiNBr01Xm
        p4jyLwP/0/2KGsVuIckLNmcLb3fklqPJBQ==
X-Google-Smtp-Source: ABdhPJxw8vzQc35a74g38+tJu1IEUcSKNf78wboahTqdHXTN+GSKFaj53Ge/NeKIcqrzxXSr2Mprdw==
X-Received: by 2002:a5d:64eb:0:b0:207:a762:b36b with SMTP id g11-20020a5d64eb000000b00207a762b36bmr375749wri.470.1649880135009;
        Wed, 13 Apr 2022 13:02:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 15/27] revisions API users: use release_revisions() for "prune_data" users
Date:   Wed, 13 Apr 2022 22:01:44 +0200
Message-Id: <patch-v6-15.27-71d59de2fe1-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use release_revisions() for users of "struct rev_list" that reach into
the "struct rev_info" and clear the "prune_data" already.

In a subsequent commit we'll teach release_revisions() to clear this
itself, but in the meantime let's invoke release_revisions() here to
clear anything else we may have missed, and for reasons of having
consistent boilerplate.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/add.c | 1 +
 diff-lib.c    | 1 +
 wt-status.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index f507d2191cd..115a26ea633 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -143,6 +143,7 @@ int add_files_to_cache(const char *prefix,
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	clear_pathspec(&rev.prune_data);
+	release_revisions(&rev);
 	return !!data.add_errors;
 }
 
diff --git a/diff-lib.c b/diff-lib.c
index d6800274bd5..0f16281253f 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -642,6 +642,7 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 	if (diff_cache(&revs, tree_oid, NULL, 1))
 		exit(128);
 	clear_pathspec(&revs.prune_data);
+	release_revisions(&revs);
 	return 0;
 }
 
diff --git a/wt-status.c b/wt-status.c
index f9100621375..a14fad1e03a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -617,6 +617,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_files(&rev, 0);
 	clear_pathspec(&rev.prune_data);
+	release_revisions(&rev);
 }
 
 static void wt_status_collect_changes_index(struct wt_status *s)
-- 
2.36.0.rc2.843.g193535c2aa7

