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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940D2C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A90622D50
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbhAYRvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbhAYRuH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:50:07 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C23FC06178A
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:18 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id u14so38584wml.4
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u5K9PFa5Vfs4PYusDpkPAqQOyigt8N/TlkTHkWaruOk=;
        b=U8K5wG6K36HGSdduah12yIYbBTJhLTFcCFyZsyxu+1XYd3CoGEG7qdut71uCdkfxT3
         c/Hw2MtW/aM9id3+3ABpTrpK8FtS3MkjSUC8ZW+S8qyo9xWgWxOyECjV76sLg4D1/MGC
         gJa1isRUgWQx9qR3bd99oihXFCfdGPLIzzVkR8kYFRwEd/nUnbuD04Bogt1K+d2wkbTB
         hicpb5PyT9zDdWY1/+6tljq7MmKM4E73pJz2+v7Xl9nrcbrYLWln0pt6qEENd4Sy4mvu
         T9JEtz9BZHCDxOqdldhKfyitLdcLxRbYyYVP6CeQ9zu3ik9yP2AG3NHfqi73530tY7JV
         SrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u5K9PFa5Vfs4PYusDpkPAqQOyigt8N/TlkTHkWaruOk=;
        b=HeGTzp6MQ+l49D3q5vZxZN/uhID7uXY3BQ4j45OnQ7rz0RAhdMHAsr6qI48ciiQ1cS
         p5/zoNUp0p4M5+yPP6Qn9QMPrtzi84JSj3RbpqxzTLBFihdIZ7kSR93vBgZD/Gy47xwa
         mbJf4ZwuovZny394FIZqym9k6MA08k37BwePYFuM/vnHok00yoDzctOf6QVrGZ/y6lwH
         gLEM9XTVfaNtaRWaCRQjo/+kkzbhNr9j91Rbks6ZnlJBqnwZP+hfANssz8wS4l6dsi+3
         jQFhLBqbU81JzYqf5VyZgpplec14IdPUFZOIwAsOK0LV6sdYjlMPkPbcs3hsCawAPbTP
         15/A==
X-Gm-Message-State: AOAM533VgH5uZdHR1AR+LkH/gJ+vDWXnQ1e1uQlaG9DIjRwHTJcxulsL
        1Z/YN687nGVlb7i6IY2qdpgmfZ2zrIc=
X-Google-Smtp-Source: ABdhPJw1BjrarTqyxTe8PlcVVg5XG0yrzHPDGrSV59x9qJdv1l5bXhuOrk93cP/hjgxIuWNv9mlmgw==
X-Received: by 2002:a1c:a549:: with SMTP id o70mr1137845wme.71.1611596537063;
        Mon, 25 Jan 2021 09:42:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm9274276wrq.87.2021.01.25.09.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:16 -0800 (PST)
Message-Id: <3c31623f6aeef0b00fc51b4476c503da607c2ae5.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:41:47 +0000
Subject: [PATCH 01/27] sparse-index: add guard to ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
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
index 7b64106930a..77564ae3b78 100644
--- a/Makefile
+++ b/Makefile
@@ -999,6 +999,7 @@ LIB_OBJS += sha1-name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
+LIB_OBJS += sparse-index.o
 LIB_OBJS += split-index.o
 LIB_OBJS += stable-qsort.o
 LIB_OBJS += strbuf.o
diff --git a/repo-settings.c b/repo-settings.c
index f7fff0f5ab8..d63569e4041 100644
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
index c98298acd01..a8acae002f7 100644
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
index b385ca3c94b..e06a2301569 100644
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
index 00000000000..82183ead563
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
index 00000000000..8dda92032e2
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
\ No newline at end of file
-- 
gitgitgadget

