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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5362EC4332B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3807165108
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbhCPQnv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238863AbhCPQnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F32AC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v15so10828153wrx.4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tG7+YZdwAKze8gBAJEZBRIJJgY5B1vbHrx8V3JKD0do=;
        b=jcXnsCWb+1t0rm0aki+GHNjzuEjevWNtafJHQDe7XhMUeqfTyicTh7Gy4cvJEL3lZo
         GYTQSkCtiwQF6QkKpf3ksB9O21l6n1ES0tC+exU800f89uwLd+k8PRpY4wovTQ+SorAu
         Joy75h+tTy5OPU5epdjgVrRK/mgjw/vOrqjMlOpB3jUoVWIHozNUQCab2flDG8xsFMS3
         2P4Gb0kuJ6s4+Zb3EB36CSwQ8LeFTdRC6o3TavCAcfLOcSyvfjcZAmeu4mDwaKjTi/LS
         caQ5rAl7cMhYx+dzpprzZFTFXFjIf02zK0ijxFJYp+0XwOuuUs1W00uVRMNej3S4np0q
         DiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tG7+YZdwAKze8gBAJEZBRIJJgY5B1vbHrx8V3JKD0do=;
        b=dkS3gQfULV2v6wljml5l5iAyun0FRql/uqKPTqjallLB1TqEsV5r8pvKeqdUTB+mUR
         GWSea4PVs9iJVziKvsMhNGYRvD0T7y+Qbu9pn8ARLsB8tn0ZsFWn/o87HkT0P1+kjyYY
         MeLSLW0BWVmBKFP3xquvwQ8pzPvw7qC+hfLGk5DyOdWmDM3baCwsvGLbhGZBktBPAlul
         ru4RI3vwoxKDn0NUq9ynja3XA8YUi5Pzmq1Ht6l8K3gYs+51LIqZR5bH0EQHgCf1buQQ
         PyHdHto/IYJpUOWczL4JAuZet9G0rRXMxorRKUeqjQViMm+z49tgqhYU8pU7Zflf1uvC
         JwTA==
X-Gm-Message-State: AOAM532eRQy5fh4ek8f9JtxCKMlAkIMeR3QI0Bs6GZDBTb3DS+SKLtN1
        fVoywUK20NdfBy0x4CMN22Xkl2lKnK0=
X-Google-Smtp-Source: ABdhPJyHymXRenL4GGaoKqZjDxmE0hAgyjjBJcxsG9BNvpunWs0nzxO89M8BLtQXTUMUnpPHrUXPbQ==
X-Received: by 2002:adf:e38f:: with SMTP id e15mr5651808wrm.321.1615912987891;
        Tue, 16 Mar 2021 09:43:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm22648275wru.46.2021.03.16.09.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:07 -0700 (PDT)
Message-Id: <4472118cf903d8dbcfdefe68af9166711d4ad6c6.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:42:47 +0000
Subject: [PATCH v3 04/20] sparse-index: add guard to ensure full index
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
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
index dfb0f1000fa3..89b1d5374107 100644
--- a/Makefile
+++ b/Makefile
@@ -985,6 +985,7 @@ LIB_OBJS += setup.o
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

