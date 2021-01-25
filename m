Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C400DC433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA1822B3B
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbhAYSAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730597AbhAYR4V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:56:21 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E39C061225
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:36 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j18so48028wmi.3
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dbe4mlp/ovuriEiQ0skOC1I1wriOtqEa/5rVRQODJfY=;
        b=W8XuZKsGWAQC8/qjQyKj0WbQ6NqOrrFygulHqXOdChae1PqLccW/0Dy5OBdQAwGxx5
         OujlKzb4lGhb0B6EGUrr0tBFRocC7kXxns4dPjL5GIsmSiikCkqhZkEhkgAk+4h8fIm0
         Xuly0oE1ls/0TzaVS561WDZ09ztvnLZ//rBlBDLZoTMY3XPp2E6wE+mD2jahgL2VBKKx
         hCKRC6PpFBNud7GfTaMEpc1adWGkJAGi8aoFFlmnSUlB8BwmC+7FQnV1ostgaJGYwgBW
         Me8BkBt9EdxaqSXO1usIoB5izCFVsNeo7Wh8Cd2dS8NU5X33+7OjD2hBLf9Ylapf4GEg
         FkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dbe4mlp/ovuriEiQ0skOC1I1wriOtqEa/5rVRQODJfY=;
        b=t0InW7NJAek4kyq/wmTgFA7C6GwTyeVbqE6TytxIMzxsvs2J57DH3EXt/GGpRI79jH
         UVJgngybRxntLloBpJjpeha4rX9is81mNNmqyArWkWLDkuZF6O8BFlTROTGQdIq5LeaD
         6ACmJMfoMXyGV59kWwIKfUw5OwIo5FwvgmVqFlmQS3syufUB3mB/SoyCxQ840znSX+Xz
         hto12hGFIpQ/U47urlhk5K+UIfdOy4ljTumKJav/AAqw3c0zpyB/2JhsUuJa5AoL/lhl
         Y///sjjQBSHGvbwPvv4vcfXhIWE5e4c0Y497zDqC+GioYmwbMnVo1S7o/CjOww35CLDs
         sFMg==
X-Gm-Message-State: AOAM5309YuKR9vtpcXlDimfO4qNUFoiKbkxAAQNwJE8XZgck0Vgu/BkS
        I/qrwhCHS8vRsdAdOICJtBXj8pN06Tg=
X-Google-Smtp-Source: ABdhPJx8NsYij8TgDvZs2PC00D7oTtyU594wPRozWotrU3yv2/QEAqZq79IvQbPwD5wfEcZdNsymJw==
X-Received: by 2002:a1c:de09:: with SMTP id v9mr1255612wmg.0.1611596554946;
        Mon, 25 Jan 2021 09:42:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12sm43399wmc.10.2021.01.25.09.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:34 -0800 (PST)
Message-Id: <b40872d34d45220bc9f3ff11a9b5f49dc34942a9.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:42:08 +0000
Subject: [PATCH 22/27] add: allow operating on a sparse-only index
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

Replace enough callers to ensure_full_index() to instead call
expand_to_path() to reduce how often 'git add' expands a sparse index in
memory (before writing a sparse index again).

One non-obvious case is index_name_pos_also_unmerged() which is only hit
on the Windows platform (in my tests). Use expand_to_path() instead of
ensure_full_index().

Add a test to check that 'git add -A' and 'git add <file>' does not
expand the index at all, as long as <file> is not within a sparse
directory.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                            |  3 +++
 dir.c                                    |  8 ++++----
 read-cache.c                             | 10 +++++-----
 sparse-index.c                           | 18 ++++++++++++++----
 t/t1092-sparse-checkout-compatibility.sh | 14 ++++++++++++++
 5 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index a825887c503..b73f8d51de6 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -491,6 +491,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	add_new_files = !take_worktree_changes && !refresh_only && !add_renormalize;
 	require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
 	/*
diff --git a/dir.c b/dir.c
index c786fa98d0e..21998c7c4b7 100644
--- a/dir.c
+++ b/dir.c
@@ -18,6 +18,7 @@
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
 #include "submodule-config.h"
+#include "sparse-index.h"
 
 /*
  * Tells read_directory_recursive how a file or directory should be treated.
@@ -899,9 +900,9 @@ static int read_skip_worktree_file_from_index(struct index_state *istate,
 {
 	int pos, len;
 
-	ensure_full_index(istate);
-
 	len = strlen(path);
+
+	expand_to_path(istate, path, len, 0);
 	pos = index_name_pos(istate, path, len);
 	if (pos < 0)
 		return -1;
@@ -1707,8 +1708,7 @@ static enum exist_status directory_exists_in_index(struct index_state *istate,
 	if (ignore_case)
 		return directory_exists_in_index_icase(istate, dirname, len);
 
-	ensure_full_index(istate);
-
+	expand_to_path(istate, dirname, len, 0);
 	pos = index_name_pos(istate, dirname, len);
 	if (pos < 0)
 		pos = -pos-1;
diff --git a/read-cache.c b/read-cache.c
index 78910d8f1b7..8c974829497 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -647,7 +647,7 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
 	int pos;
 	struct cache_entry *ce;
 
-	ensure_full_index(istate);
+	expand_to_path(istate, path, namelen, 0);
 
 	pos = index_name_pos(istate, path, namelen);
 	if (pos >= 0)
@@ -724,8 +724,6 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	int hash_flags = HASH_WRITE_OBJECT;
 	struct object_id oid;
 
-	ensure_full_index(istate);
-
 	if (flags & ADD_CACHE_RENORMALIZE)
 		hash_flags |= HASH_RENORMALIZE;
 
@@ -733,6 +731,8 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		return error(_("%s: can only add regular files, symbolic links or git-directories"), path);
 
 	namelen = strlen(path);
+	expand_to_path(istate, path, namelen, 0);
+
 	if (S_ISDIR(st_mode)) {
 		if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
 			return error(_("'%s' does not have a commit checked out"), path);
@@ -1104,7 +1104,7 @@ static int has_dir_name(struct index_state *istate,
 	size_t len_eq_last;
 	int cmp_last = 0;
 
-	ensure_full_index(istate);
+	expand_to_path(istate, ce->name, ce->ce_namelen, 0);
 
 	/*
 	 * We are frequently called during an iteration on a sorted
@@ -1349,7 +1349,7 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 {
 	int pos;
 
-	ensure_full_index(istate);
+	expand_to_path(istate, ce->name, ce->ce_namelen, 0);
 
 	if (option & ADD_CACHE_JUST_APPEND)
 		pos = istate->cache_nr;
diff --git a/sparse-index.c b/sparse-index.c
index bf8dce9a09b..a201f3b905c 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -286,6 +286,7 @@ static int in_expand_to_path = 0;
 void expand_to_path(struct index_state *istate,
 		    const char *path, size_t pathlen, int icase)
 {
+	struct cache_entry *ce = NULL;
 	struct strbuf path_as_dir = STRBUF_INIT;
 	int pos;
 
@@ -320,13 +321,22 @@ void expand_to_path(struct index_state *istate,
 
 	if (pos < 0)
 		pos = -pos - 1;
+	if (pos < istate->cache_nr)
+		ce = istate->cache[pos];
 
 	/*
-	 * Even if the path doesn't exist, if the value isn't exactly a
-	 * sparse-directory entry, then there is no need to expand the
-	 * index.
+	 * If we didn't land on a sparse directory, then there is
+	 * nothing to expand.
 	 */
-	if (istate->cache[pos]->ce_mode != CE_MODE_SPARSE_DIRECTORY)
+	if (ce && !S_ISSPARSEDIR(ce))
+		goto cleanup;
+	/*
+	 * If that sparse directory is not a prefix of the path we
+	 * are looking for, then we don't need to expand.
+	 */
+	if (ce &&
+	    (ce->ce_namelen >= path_as_dir.len ||
+	     strncmp(ce->name, path_as_dir.buf, ce->ce_namelen)))
 		goto cleanup;
 
 	trace2_region_enter("index", "expand_to_path", istate->repo);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 09650f0755c..ae594ab880c 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -390,6 +390,20 @@ test_expect_success 'sparse-index is expanded and converted back' '
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
 		git -C sparse-index -c core.fsmonitor="" reset --hard &&
 	test_region index convert_to_sparse trace2.txt &&
+	test_region index ensure_full_index trace2.txt &&
+
+	rm trace2.txt &&
+	echo >>sparse-index/README.md &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index -c core.fsmonitor="" add -A &&
+	test_region index convert_to_sparse trace2.txt &&
+	test_region index ensure_full_index trace2.txt &&
+
+	rm trace2.txt &&
+	echo >>sparse-index/extra.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index -c core.fsmonitor="" add extra.txt &&
+	test_region index convert_to_sparse trace2.txt &&
 	test_region index ensure_full_index trace2.txt
 '
 
-- 
gitgitgadget

