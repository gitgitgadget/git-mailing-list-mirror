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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BA3C4332B
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EECF64FEF
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhCJTbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbhCJTbM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7C1C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u14so24630641wri.3
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ci4zHD7vVaPFH9zfZ+LuihC6A8oJNG9I5+iHGD8+TSs=;
        b=Cy/yf3dNim5ix05/Xin78dVKCCDNY2zsclh66yc/bcYS32nJd1M4wgzkWYVtSzYPUv
         JH5u+bB8Ihc+YDd6Z/zKKGSXSKuI25KTAylzPVFykUbNWx2Csv60E91z+OvasQxNfQn+
         KkRvnGKlbMak5uBYbJBV8JG7VwLKD7vKJZHHwn5skH4HqvLsDgPNu2bI6ana3sNuPtrH
         s/EnzqlysCkQ3fvV38RzCQK6TkbVLMvhtxG+ME0ahES1CZjRqFaAFpm/DbjRNh8q0XPf
         iqw7zk9DsBWNuqn1B8Vsg+sM8KCGATYAcj4pdmw+cTYRWYGmffk0C5r8170fmYK1YHLf
         rsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ci4zHD7vVaPFH9zfZ+LuihC6A8oJNG9I5+iHGD8+TSs=;
        b=feubholsw4rVF3dxFo7g/HCZLnXf5RxkM8QtFPxrLn8HcehWjKLhtoFBw9/qKM0FqU
         f5jqg32hHMM8WN6/Y7vrk0MzzamvvT0T04H/NdBxgsGmsSTOyJ0WaxpieKrpuRvguKgZ
         o/OO86j4ZRN9R/bnDt2ebRuM+0icrwvvm7hVuhARqOKBLzKuz76AjIIpruWH0ubwHI3k
         +GOHAwQF79GBMgk9Wqe54hmtqiTUPgK52CcjYsWLWpnVPBmFSzasnW32XYhEF60Iz1dy
         4M3AZa5xlx6abl04lYb+3aZ9o4daAOdKpKR4thfdDvmJvGxzBQ+h6DBRY/vneK9eZlr0
         ZZWw==
X-Gm-Message-State: AOAM532BWSzH7c+x6+VCdNB9aa+VYNmLPAlefZ5O3hhykrV20cT4rnNY
        UjIQfpccLJ0+XUXVQ66rrJFx2v0Y+14=
X-Google-Smtp-Source: ABdhPJzjAcqaqFFVly1LAT9wXAt7QEt1/L0/XZvkJN4WUEDC5r/KAYOtr5344V5w2jUE/DIcRl8ZKQ==
X-Received: by 2002:a5d:4905:: with SMTP id x5mr5058020wrq.201.1615404670490;
        Wed, 10 Mar 2021 11:31:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm348026wru.46.2021.03.10.11.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:10 -0800 (PST)
Message-Id: <399ddb0bad56c69ff9d9591f5e8eacf52cf50a15.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:30:48 +0000
Subject: [PATCH v2 05/20] sparse-index: implement ensure_full_index()
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
 sparse-index.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index d92814961405..1f0b42264606 100644
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
index 29144cf879e7..97dbf2434f30 100644
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
@@ -2255,6 +2258,12 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
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
index 82183ead563b..316cb949b74b 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -1,8 +1,101 @@
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
+				struct strbuf *base, const char *path,
+				unsigned int mode, int stage, void *context)
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
+		read_tree_recursive(istate->repo, tree,
+				    ce->name, strlen(ce->name),
+				    0, &ps,
+				    add_path_to_index, full);
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
+	free(full);
+
+	trace2_region_leave("index", "ensure_full_index", istate->repo);
 }
-- 
gitgitgadget

