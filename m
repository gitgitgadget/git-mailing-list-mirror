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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AE1C433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370996197F
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhCWNox (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhCWNoj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E990CC0613D9
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so1162155wma.0
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pOHqh+Af5P0jXkTT9g9iWoHBkxvTMOM1AiMZUVBuQro=;
        b=Agm0Ba0ZbOHLvXlYFNJJMQNgzXrvc/gkdkA0pHLhUDfeM3NSYrZK2IZHBPexp3oHAZ
         94wvASfmKWKnmmnAwGhrftIAq3zUrqHpmopuV2W5cULp936uUGKavHbjEClXA57FVAmW
         FP/OlUzvC5Yv3AjjWXwEyCRouIqz9MBQdsKWCLD+cbBi281DMoFfbWlgh5eRsgbuMkCV
         35ZmxEUWxns25JTMAX8CTdnE8zg3DQXzyR859QrVi8iYg12APAvNEph7M+8vGxpsY3tZ
         y1/JcGNQhr9DrlUOtQAz70RzhG0QiDYNdITSBgQNQRzAbT9YPWeTm1mh++P/AjFhHCYM
         JzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pOHqh+Af5P0jXkTT9g9iWoHBkxvTMOM1AiMZUVBuQro=;
        b=qcFqDUR9bv1alpAVWaIsVnWvBB13ZA1QwfTzHtMlfRjTwLRbBtMVVXMmyj3YEUbbfY
         4j1nrVQ2ulnctSisMuigB0EXN12eIFQD4HUR4d1IcFLf4nqOlwcvg899SYL05qI1gRZI
         zrn2wK7lft5YjFrx8npUXJLgbYoEseRsC0J8TKQ44+zSCJ8m2PBX/TY4N8psb+dGDDvf
         bRTt2kJ42CRuCg4bCK1KMlSWXVdIP4yVerzyNxNjNXVGw7G7KEH7TJjVoBvqpCacNy7q
         0Krajb6lXRHU6/XJuTk34qppbPMBYAHMYXdZa539NO9CZZjOC4k7PGRgabwLNLDiCk3Z
         aocQ==
X-Gm-Message-State: AOAM531kf6tEZyaigTbtTfgo/FeiQIjX0xLFeACQyH3ccQFhgxASgGxL
        rnoDO2x759AdyEuNlvYBqzvVtr4CZvk=
X-Google-Smtp-Source: ABdhPJxlLZ2o1hOcviR/22i0/geWt1Xv62EvGmbIuRLFRbv0bZb2fVTuE5K0YMPn99LPEATFRjsH1A==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr3385604wma.141.1616507075631;
        Tue, 23 Mar 2021 06:44:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w22sm2633442wmi.22.2021.03.23.06.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:35 -0700 (PDT)
Message-Id: <6b3b6d86385d7d8430644e6248996ee469041c3f.1616507069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:13 +0000
Subject: [PATCH v4 05/20] sparse-index: implement ensure_full_index()
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

We will mark an in-memory index_state as having sparse directory entries
with the sparse_index bit. These currently cannot exist, but we will add
a mechanism for collapsing a full index to a sparse one in a later
change. That will happen at write time, so we must first allow parsing
the format before writing it.

Commands or methods that require a full index in order to operate can
call ensure_full_index() to expand that index in-memory. This requires
parsing trees using that index's repository.

Sparse directory entries have a specific 'ce_mode' value. The macro
S_ISSPARSEDIR(ce->ce_mode) can check if a cache_entry 'ce' has this type.
This ce_mode is not possible with the existing index formats, so we don't
also verify all properties of a sparse-directory entry, which are:

 1. ce->ce_mode == 0040000
 2. ce->flags & CE_SKIP_WORKTREE is true
 3. ce->name[ce->namelen - 1] == '/' (ends in dir separator)
 4. ce->oid references a tree object.

These are all semi-enforced in ensure_full_index() to some extent. Any
deviation will cause a warning at minimum or a failure in the worst
case.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache.h        | 13 ++++++-
 read-cache.c   |  9 +++++
 sparse-index.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index bb317abc91fb..136dd496c95d 100644
--- a/cache.h
+++ b/cache.h
@@ -204,6 +204,8 @@ struct cache_entry {
 #error "CE_EXTENDED_FLAGS out of range"
 #endif
 
+#define S_ISSPARSEDIR(m) ((m) == S_IFDIR)
+
 /* Forward structure decls */
 struct pathspec;
 struct child_process;
@@ -319,7 +321,14 @@ struct index_state {
 		 drop_cache_tree : 1,
 		 updated_workdir : 1,
 		 updated_skipworktree : 1,
-		 fsmonitor_has_run_once : 1;
+		 fsmonitor_has_run_once : 1,
+
+		 /*
+		  * sparse_index == 1 when sparse-directory
+		  * entries exist. Requires sparse-checkout
+		  * in cone mode.
+		  */
+		 sparse_index : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	struct object_id oid;
@@ -722,6 +731,8 @@ int read_index_from(struct index_state *, const char *path,
 		    const char *gitdir);
 int is_index_unborn(struct index_state *);
 
+void ensure_full_index(struct index_state *istate);
+
 /* For use with `write_locked_index()`. */
 #define COMMIT_LOCK		(1 << 0)
 #define SKIP_IF_UNCHANGED	(1 << 1)
diff --git a/read-cache.c b/read-cache.c
index 1e9a50c6c734..dd3980c12b53 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -101,6 +101,9 @@ static const char *alternate_index_output;
 
 static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
 {
+	if (S_ISSPARSEDIR(ce->ce_mode))
+		istate->sparse_index = 1;
+
 	istate->cache[nr] = ce;
 	add_name_hash(istate, ce);
 }
@@ -2273,6 +2276,12 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	trace2_data_intmax("index", the_repository, "read/cache_nr",
 			   istate->cache_nr);
 
+	if (!istate->repo)
+		istate->repo = the_repository;
+	prepare_repo_settings(istate->repo);
+	if (istate->repo->settings.command_requires_full_index)
+		ensure_full_index(istate);
+
 	return istate->cache_nr;
 
 unmap:
diff --git a/sparse-index.c b/sparse-index.c
index 82183ead563b..7095378a1b28 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -1,8 +1,104 @@
 #include "cache.h"
 #include "repository.h"
 #include "sparse-index.h"
+#include "tree.h"
+#include "pathspec.h"
+#include "trace2.h"
+
+static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
+{
+	ALLOC_GROW(istate->cache, nr + 1, istate->cache_alloc);
+
+	istate->cache[nr] = ce;
+	add_name_hash(istate, ce);
+}
+
+static int add_path_to_index(const struct object_id *oid,
+			     struct strbuf *base, const char *path,
+			     unsigned int mode, void *context)
+{
+	struct index_state *istate = (struct index_state *)context;
+	struct cache_entry *ce;
+	size_t len = base->len;
+
+	if (S_ISDIR(mode))
+		return READ_TREE_RECURSIVE;
+
+	strbuf_addstr(base, path);
+
+	ce = make_cache_entry(istate, mode, oid, base->buf, 0, 0);
+	ce->ce_flags |= CE_SKIP_WORKTREE;
+	set_index_entry(istate, istate->cache_nr++, ce);
+
+	strbuf_setlen(base, len);
+	return 0;
+}
 
 void ensure_full_index(struct index_state *istate)
 {
-	/* intentionally left blank */
+	int i;
+	struct index_state *full;
+	struct strbuf base = STRBUF_INIT;
+
+	if (!istate || !istate->sparse_index)
+		return;
+
+	if (!istate->repo)
+		istate->repo = the_repository;
+
+	trace2_region_enter("index", "ensure_full_index", istate->repo);
+
+	/* initialize basics of new index */
+	full = xcalloc(1, sizeof(struct index_state));
+	memcpy(full, istate, sizeof(struct index_state));
+
+	/* then change the necessary things */
+	full->sparse_index = 0;
+	full->cache_alloc = (3 * istate->cache_alloc) / 2;
+	full->cache_nr = 0;
+	ALLOC_ARRAY(full->cache, full->cache_alloc);
+
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		struct tree *tree;
+		struct pathspec ps;
+
+		if (!S_ISSPARSEDIR(ce->ce_mode)) {
+			set_index_entry(full, full->cache_nr++, ce);
+			continue;
+		}
+		if (!(ce->ce_flags & CE_SKIP_WORKTREE))
+			warning(_("index entry is a directory, but not sparse (%08x)"),
+				ce->ce_flags);
+
+		/* recursively walk into cd->name */
+		tree = lookup_tree(istate->repo, &ce->oid);
+
+		memset(&ps, 0, sizeof(ps));
+		ps.recursive = 1;
+		ps.has_wildcard = 1;
+		ps.max_depth = -1;
+
+		strbuf_setlen(&base, 0);
+		strbuf_add(&base, ce->name, strlen(ce->name));
+
+		read_tree_at(istate->repo, tree, &base, &ps,
+			     add_path_to_index, full);
+
+		/* free directory entries. full entries are re-used */
+		discard_cache_entry(ce);
+	}
+
+	/* Copy back into original index. */
+	memcpy(&istate->name_hash, &full->name_hash, sizeof(full->name_hash));
+	istate->sparse_index = 0;
+	free(istate->cache);
+	istate->cache = full->cache;
+	istate->cache_nr = full->cache_nr;
+	istate->cache_alloc = full->cache_alloc;
+
+	strbuf_release(&base);
+	free(full);
+
+	trace2_region_leave("index", "ensure_full_index", istate->repo);
 }
-- 
gitgitgadget

