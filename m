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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEAFC433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51C122D04
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbhAYRuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730979AbhAYRuH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:50:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A2AC061797
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:19 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h9so3568961wrr.9
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bM7h5tZklpRmsUG1HJvppNFZIAHSL84NVJpJrjtxJEE=;
        b=CpG46/A65PkH7pO1dsjXvT3YYUcqu9f3Rl0r1p7xgNpI/bgLg5H+I7Ed/t6s6G2d4Y
         efE+SxvTZCNq0F3W5aGQDri7cH/1zJh6JaVkuRDi1UdFcNcfCbIaIL2oCf63X2ibKYN+
         x+QWFDaCuAjlZXgbJ4Y/ZKuM0WBjvk9ENKlXa0SV+9hljimbOY0i+VTTBkdDm7hf94RI
         e3GiUddpWUFrCz5BEZuGznSNvmt8mT8JtyrIfcOt51IyNeF8bEpOF4uJDwOa07/0DPgt
         fAIgblq7DsslC6q/ud6E2xTlvVrz3mQqiSOBmgbIg8QNQBaAbcgFZ/5jpIV9sWb4M9Kc
         sXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bM7h5tZklpRmsUG1HJvppNFZIAHSL84NVJpJrjtxJEE=;
        b=MoF1M7c+ets657tzIJMMRI3o/BvCQQL6jum/NYnvCuQf9nBDKgtYjhsk64G1EtJ4VE
         A2IGhQxk6ltdH+jcdGwk/TaM0bDxNLPBykKpQZs1PExh63FaS8ap/z1XNQqb8XJH37FM
         /NYCCtZp50g7RFudh8FrAUikzb1c77bdW1fQsvkfIAZPFQPCQy9UkCmjgRwTMlW003Je
         zSY6hSlPCf9iWcu6seugxmrDmFbczwfk9zgSKHfV762gndoaC7My+c2az6o0cJcMu6BL
         F42GUwExEXilz94VnjNLn/KZlmue6mA46ChM95p/rg0icC5jtsxq/ZgSYKA04EZowX1A
         s9UA==
X-Gm-Message-State: AOAM533fg4F9RxDWn6WWktuQYxKYNJGvNpZkU5GyWPsAjZMxYymL5uny
        MkD9DzoA7zqRGtkpR7b7IM2xCV9hDL8=
X-Google-Smtp-Source: ABdhPJzqCszeCOK7PNxC/Fk3TmgKrvLDLQ7sBRD/jLAGV1Y6hMCDOaKdu6yklWjvfXYDtoesA15LMw==
X-Received: by 2002:a5d:654f:: with SMTP id z15mr2261463wrv.46.1611596537999;
        Mon, 25 Jan 2021 09:42:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h1sm20453349wrr.73.2021.01.25.09.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:17 -0800 (PST)
Message-Id: <ebbe8569dcc16f2ae235c4167be0e72a53982982.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:41:48 +0000
Subject: [PATCH 02/27] sparse-index: implement ensure_full_index()
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

We will mark an in-memory index_state as having sparse directory entries
with the sparse_index bit. These currently cannot exist, but we will add
a mechanism for collapsing a full index to a sparse one in a later
change. That will happen at write time, so we must first allow parsing
the format before writing it.

Commands or methods that require a full index in order to operate can
call ensure_full_index() to expand that index in-memory. This requires
parsing trees using that index's repository.

Sparse directory entries have a specific 'ce_mode' value. The macro
S_ISSPARSEDIR(ce) can check if a cache_entry 'ce' has this type. This
ce_mode is not possible with the existing index formats, so we don't
also verify all properties of a sparse-directory entry, which are:

 1. ce->ce_mode == 01000755
 2. ce->flags & CE_SKIP_WORKTREE is true
 3. ce->name[ce->namelen - 1] == '/' (ends in dir separator)
 4. ce->oid references a tree object.

These are all semi-enforced in ensure_full_index() to some extent. Any
deviation will cause a warning at minimum or a failure in the worst
case.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache.h        | 11 +++++-
 read-cache.c   |  9 +++++
 sparse-index.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++-
 sparse-index.h |  1 +
 4 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index f9c7a603841..884046ca5b8 100644
--- a/cache.h
+++ b/cache.h
@@ -204,6 +204,10 @@ struct cache_entry {
 #error "CE_EXTENDED_FLAGS out of range"
 #endif
 
+#define CE_MODE_SPARSE_DIRECTORY 01000755
+#define SPARSE_DIR_MODE 0100
+#define S_ISSPARSEDIR(m) ((m)->ce_mode == CE_MODE_SPARSE_DIRECTORY)
+
 /* Forward structure decls */
 struct pathspec;
 struct child_process;
@@ -249,6 +253,8 @@ static inline unsigned int create_ce_mode(unsigned int mode)
 {
 	if (S_ISLNK(mode))
 		return S_IFLNK;
+	if (mode == SPARSE_DIR_MODE)
+		return CE_MODE_SPARSE_DIRECTORY;
 	if (S_ISDIR(mode) || S_ISGITLINK(mode))
 		return S_IFGITLINK;
 	return S_IFREG | ce_permissions(mode);
@@ -319,7 +325,8 @@ struct index_state {
 		 drop_cache_tree : 1,
 		 updated_workdir : 1,
 		 updated_skipworktree : 1,
-		 fsmonitor_has_run_once : 1;
+		 fsmonitor_has_run_once : 1,
+		 sparse_index : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	struct object_id oid;
@@ -721,6 +728,8 @@ int read_index_from(struct index_state *, const char *path,
 		    const char *gitdir);
 int is_index_unborn(struct index_state *);
 
+void ensure_full_index(struct index_state *istate);
+
 /* For use with `write_locked_index()`. */
 #define COMMIT_LOCK		(1 << 0)
 #define SKIP_IF_UNCHANGED	(1 << 1)
diff --git a/read-cache.c b/read-cache.c
index ecf6f689940..1097ecbf132 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -101,6 +101,9 @@ static const char *alternate_index_output;
 
 static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
 {
+	if (S_ISSPARSEDIR(ce))
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
index 82183ead563..1e70244dc13 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -1,8 +1,100 @@
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
+		if (!S_ISSPARSEDIR(ce)) {
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
+	istate->cache = full->cache;
+	istate->cache_nr = full->cache_nr;
+	istate->cache_alloc = full->cache_alloc;
+
+	free(full);
+
+	trace2_region_leave("index", "ensure_full_index", istate->repo);
 }
diff --git a/sparse-index.h b/sparse-index.h
index 8dda92032e2..a2777dcac59 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -3,5 +3,6 @@
 
 struct index_state;
 void ensure_full_index(struct index_state *istate);
+int convert_to_sparse(struct index_state *istate);
 
 #endif
\ No newline at end of file
-- 
gitgitgadget

