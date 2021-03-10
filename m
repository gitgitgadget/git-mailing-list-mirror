Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784F8C4332D
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C06A64FF2
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhCJTbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbhCJTbL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:11 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA05C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:11 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so11809985wml.2
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ygaDs5wlP7UHuBKjOsrDT3aRtt2dHHpJXltd1v63C3s=;
        b=trLepgkNTwHBKHnOeqeRZ/99Aub5WT8CqV3i2ZuVO/xxvTXUFq4uvDniZ2/DMGy+wf
         f+GmUVS9anCkkv/7rmG9kvQtftisAfcN1MGsi5XtvmznG1nrQ0IAIhwDUn0Ofqn5qcuL
         4Gl/UPeX5O2zp3hpx5d6Zje01M3AK704iKoLsVrPCwRhAhcls6ixKfs8EMKdVhdT40+9
         rsYCENS4Jq5f8LKam9XW0m8d4zdg/Rnf00sJS/O2pR6qOj57KPkpiUQh2mECzue8Qjv6
         rek8wRNAPfC9cr5QnPicmKmyM+DTAAmECO0uHML+bV8ukEoo6RbH67aM14A0su0Bl1DB
         RVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ygaDs5wlP7UHuBKjOsrDT3aRtt2dHHpJXltd1v63C3s=;
        b=Wq2tS3ZwykoYmV5MFJ2RWQ2JAPWGlDOhnmPnlmGBOV+Ds3F7HaapHu8PYRFVgRiUzg
         WVmZxkiJiddi2w8+6m6VzbljiKbU560fRL2KMjCxtvxbARY8H/nT9DDK8fOiBVhwe5xe
         gtwEiNkzqeXINUv345fM7SnOaWTy1mO0MJyK9tIzVnrjk4cc9ad23MPxVWxhNIe0R+IV
         gyXNATchB+FIPY+LL/xhK/dOorHHGvg+AGJ5jB0oEnyM/d4az0LWL+0lNH//FQk5DHRd
         4L1VLwwXAXtQjwvh7Fpw1OvbL6TO6XB/BENgNpHJJD+Uv9J7dvrIWKYRJrsXQVSXgtbt
         UyWg==
X-Gm-Message-State: AOAM531M9hnPredrF48PzDVbPFxodSh8CcUX7B0yjLdsCdcyfs/cfGCp
        HTZZk0IiCorzr+HUgJcziDjnTAp8RPc=
X-Google-Smtp-Source: ABdhPJyFcU4Ua4gwPEBRhTX0UlgNcPDi/CsKnCj26VAiC1VIZFwhRU43vreNo0U2lRY4ectLJPEEJA==
X-Received: by 2002:a05:600c:224e:: with SMTP id a14mr4778237wmm.57.1615404669865;
        Wed, 10 Mar 2021 11:31:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11sm309970wrv.88.2021.03.10.11.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:09 -0800 (PST)
Message-Id: <6e21f776e883cef25f63829caf338298252ebaca.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:30:47 +0000
Subject: [PATCH v2 04/20] sparse-index: add guard to ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Upcoming changes will introduce modifications to the index format that
allow sparse directories. It will be useful to have a mechanism for
converting those sparse index files into full indexes by walking the
tree at those sparse directories. Name this method ensure_full_index()
as it will guarantee that the index is fully expanded.

This method is not implemented yet, and instead we focus on the
scaffolding to declare it and call it at the appropriate time.

Add a 'command_requires_full_index' member to struct repo_settings. This
will be an indicator that we need the index in full mode to do certain
index operations. This starts as being true for every command, then we
will set it to false as some commands integrate with sparse indexes.

If 'command_requires_full_index' is true, then we will immediately
expand a sparse index to a full one upon reading from disk. This
suffices for now, but we will want to add more callers to
ensure_full_index() later.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile        |  1 +
 repo-settings.c |  8 ++++++++
 repository.c    | 11 ++++++++++-
 repository.h    |  2 ++
 sparse-index.c  |  8 ++++++++
 sparse-index.h  |  7 +++++++
 6 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 sparse-index.c
 create mode 100644 sparse-index.h

diff --git a/Makefile b/Makefile
index 5a239cac20e3..3bf61699238d 100644
--- a/Makefile
+++ b/Makefile
@@ -980,6 +980,7 @@ LIB_OBJS += setup.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
+LIB_OBJS += sparse-index.o
 LIB_OBJS += split-index.o
 LIB_OBJS += stable-qsort.o
 LIB_OBJS += strbuf.o
diff --git a/repo-settings.c b/repo-settings.c
index f7fff0f5ab83..d63569e4041e 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -77,4 +77,12 @@ void prepare_repo_settings(struct repository *r)
 		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
 
 	UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_DEFAULT);
+
+	/*
+	 * This setting guards all index reads to require a full index
+	 * over a sparse index. After suitable guards are placed in the
+	 * codebase around uses of the index, this setting will be
+	 * removed.
+	 */
+	r->settings.command_requires_full_index = 1;
 }
diff --git a/repository.c b/repository.c
index c98298acd017..a8acae002f71 100644
--- a/repository.c
+++ b/repository.c
@@ -10,6 +10,7 @@
 #include "object.h"
 #include "lockfile.h"
 #include "submodule-config.h"
+#include "sparse-index.h"
 
 /* The main repository */
 static struct repository the_repo;
@@ -261,6 +262,8 @@ void repo_clear(struct repository *repo)
 
 int repo_read_index(struct repository *repo)
 {
+	int res;
+
 	if (!repo->index)
 		repo->index = xcalloc(1, sizeof(*repo->index));
 
@@ -270,7 +273,13 @@ int repo_read_index(struct repository *repo)
 	else if (repo->index->repo != repo)
 		BUG("repo's index should point back at itself");
 
-	return read_index_from(repo->index, repo->index_file, repo->gitdir);
+	res = read_index_from(repo->index, repo->index_file, repo->gitdir);
+
+	prepare_repo_settings(repo);
+	if (repo->settings.command_requires_full_index)
+		ensure_full_index(repo->index);
+
+	return res;
 }
 
 int repo_hold_locked_index(struct repository *repo,
diff --git a/repository.h b/repository.h
index b385ca3c94b6..e06a23015697 100644
--- a/repository.h
+++ b/repository.h
@@ -41,6 +41,8 @@ struct repo_settings {
 	enum fetch_negotiation_setting fetch_negotiation_algorithm;
 
 	int core_multi_pack_index;
+
+	unsigned command_requires_full_index:1;
 };
 
 struct repository {
diff --git a/sparse-index.c b/sparse-index.c
new file mode 100644
index 000000000000..82183ead563b
--- /dev/null
+++ b/sparse-index.c
@@ -0,0 +1,8 @@
+#include "cache.h"
+#include "repository.h"
+#include "sparse-index.h"
+
+void ensure_full_index(struct index_state *istate)
+{
+	/* intentionally left blank */
+}
diff --git a/sparse-index.h b/sparse-index.h
new file mode 100644
index 000000000000..09a20d036c46
--- /dev/null
+++ b/sparse-index.h
@@ -0,0 +1,7 @@
+#ifndef SPARSE_INDEX_H__
+#define SPARSE_INDEX_H__
+
+struct index_state;
+void ensure_full_index(struct index_state *istate);
+
+#endif
-- 
gitgitgadget

