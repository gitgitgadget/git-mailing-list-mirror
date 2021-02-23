Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277D0C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F5D64D99
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhBWUPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbhBWUPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:15:16 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D6AC06178C
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:34 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l13so3576360wmg.5
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ygaDs5wlP7UHuBKjOsrDT3aRtt2dHHpJXltd1v63C3s=;
        b=blmjSDKpbiI3PDnGVGXIJ3iWctN8KwdwcG++9QFf7+Wvr4j+dzb/BhzGz62T4YQ7iF
         ltuSc7Ng2PICltdNU2Ecxawza0BbkXMMRH2dnCN2dXCrO+VXgaoWHiEEf26YEy9Z6V/+
         D7P+Ps9c/IOL+WAQIytDMBj1F2Dm1PaoCh2gt2MN094rlioSCmou0nu2XESk16ijE8hi
         C5ub7/7d1IrsU59644bVhe6gvpq4pbe5jY+V+Y3gk+oYRo2QtEYyjAOvKOZJVJBjpPl1
         WvGJGgCR2aPXBT0vg4izcWSx9jsxx9UuRMAMI+UyIObPlAlQRdKxP29FINoH1OHl6bii
         CHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ygaDs5wlP7UHuBKjOsrDT3aRtt2dHHpJXltd1v63C3s=;
        b=ZyrCxqpnZMvyqqDPjPy29vi/tv7bu32K7XcSr06DKMYqeCjnuCeYNnneiLnWjIHmH5
         eoy7cxesYRQi9etsS+QiWamc3hZTazubyy0kLIh8zrZe8Ycv4+XAXuG2cVIrUdMKFEYW
         HJQ5Dhdd1GyWE3TXgm6kUXfYL49KNn4zqoa3AsGzmYdQ2LvKXTmLIC0/yF5safyIEZfD
         9mvS8UPasBoWxEu4iwZMG5qazFZrqGwT50Ji1ah8C7MO3ZlngmJhngAsg+Pd/Df/AGM0
         ggZXHljg9v3Gi1UNdXsG1KCfvm7VvP21yTigCTpv8igYoDgPYnJsCB2J7oAlzJzVxtBv
         abbg==
X-Gm-Message-State: AOAM530DqgxZqlhcl94iWfs2DwTfFeoJVo0OIrnrWfdhtFZAiI0ilNyz
        GPhTcquzAjjmZh8OKvOnuXmWVte+qxg=
X-Google-Smtp-Source: ABdhPJyknZZVHQ7axHSbM39/v+DuHqL4wGt13e6CMz59aMYLDD84FUQzFxtVi5DyXVuDOFAR1O9wKg==
X-Received: by 2002:a7b:c1c4:: with SMTP id a4mr399253wmj.123.1614111273575;
        Tue, 23 Feb 2021 12:14:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5sm16995533wrh.38.2021.02.23.12.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:33 -0800 (PST)
Message-Id: <01da4c48a1fa94188faf45ab1e23b98ecb4164d5.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:13 +0000
Subject: [PATCH 04/20] sparse-index: add guard to ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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

