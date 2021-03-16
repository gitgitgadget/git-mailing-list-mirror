Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BC0C4332D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5976502A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhCPCOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhCPCNu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:50 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6A1C061762
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 12so4203843wmf.5
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lSnOoQ4PEi3NQt4nfUjymhSjU1LCc6F2l1kHCtsuNGg=;
        b=DswYWHKp5chMQUqZG3cFHTS/b6gzJ0UaG1n0/ki1wFA6yVVCvYxpPk2bCcrqvfGsMB
         f/TqjkY6E+bgSMbxAanvPuzxLlIllVFdCPLtUxAPpS2AyB7XTyCtBxCsIsM4R5sLeRDE
         w0VfnBZjchAqvgdMJ0L+BPMKBd91Ru+oA8ex2LvLKRVrHWULNiZCQuSs+QzU0e+FMpIS
         lctaNevqwSbDY45M6b9fXjxYVKetEq1JXng9BQrAspHXA5zEBBHxxGIBkQVSo5sqX1mp
         qYMHSlEIN56KQMMVxmHvgWnboA8QYUkc+mQD6z6RlS85C68bN8sb+wFhttcuu8+SzgHX
         QFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lSnOoQ4PEi3NQt4nfUjymhSjU1LCc6F2l1kHCtsuNGg=;
        b=YyIEedurjdlQNmFHh1m3zi45qkqsXvPwbQpmScp39TEIBpqKeHhQ45xpb7sy9n7gFu
         yg8RVnALJ9EWgWpKlQzTiN/ggefAyIwdJ8gF0hDPwWYeqg0jltUpUXnV5r2Myxy9tC9P
         i9B2ytSeZO0R4bZeTq9R8oVgpbQuYPUteKsj1GM8XyQHJ52LBrvvNpJWNBX246xkDu+L
         oKX5r0obtdvb8RP29xCG7CHmrc/tP2wAU0l+wzgrSDSy4UNaTDufo77boSMFyxqrh+QP
         Q1mBHMJQMDqRx5JCU/xMpDs4FSm/cvdo7Fl9ZVtAuo+ZQnlYqmHvlCMmMWRZv4vpoRvF
         s9lA==
X-Gm-Message-State: AOAM531X2wr/eST6irfDDrRp/HPrX0Soo03uhVkAeIguBTQ3HE8edHcb
        r/Cjc4fEY5hVxBndKl+GnHlNXbzpzecRng==
X-Google-Smtp-Source: ABdhPJzZfFGai226aqZWeImw/tj31r1HBZQ/QTUoNi3+Gh06NadDyzivGm4GqZtqLuN+bCMsX375AQ==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr2338302wmo.36.1615860828551;
        Mon, 15 Mar 2021 19:13:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 20/29] tree-walk.h API: rename get_tree_entry() to get_tree_entry_mode()
Date:   Tue, 16 Mar 2021 03:13:03 +0100
Message-Id: <20210316021312.13927-21-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the get_tree_entry() function to get_tree_entry_mode(). This
change is only a search-replacement of the name and indentation of the
argument lists.

A subsequent commits will add get_tree_entry_type() and
get_tree_entry_all() functions. Those changes will be much easier to
read if we do this rename first.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c              |  8 ++++----
 blame.c                |  6 +++---
 builtin/rm.c           |  2 +-
 builtin/update-index.c |  2 +-
 line-log.c             |  2 +-
 match-trees.c          |  6 +++---
 merge-recursive.c      | 18 +++++++++---------
 notes.c                |  2 +-
 object-name.c          |  6 +++---
 tree-walk.c            | 14 +++++++-------
 tree-walk.h            |  6 +++---
 11 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/archive.c b/archive.c
index 254e15c8d03..ab031079580 100644
--- a/archive.c
+++ b/archive.c
@@ -482,10 +482,10 @@ static void parse_treeish_arg(const char **argv,
 		unsigned short mode;
 		int err;
 
-		err = get_tree_entry(ar_args->repo,
-				     &tree->object.oid,
-				     prefix, &tree_oid,
-				     &mode);
+		err = get_tree_entry_mode(ar_args->repo,
+					  &tree->object.oid,
+					  prefix, &tree_oid,
+					  &mode);
 		if (err || !S_ISDIR(mode))
 			die(_("current working directory is untracked"));
 
diff --git a/blame.c b/blame.c
index 83babc41d08..9e0543e13d4 100644
--- a/blame.c
+++ b/blame.c
@@ -102,8 +102,8 @@ static void verify_working_tree_path(struct repository *r,
 		const struct object_id *commit_oid = &parents->item->object.oid;
 		struct object_id blob_oid;
 		unsigned short mode;
-		int ret = get_tree_entry(r, commit_oid, path, &blob_oid,
-					 &mode);
+		int ret = get_tree_entry_mode(r, commit_oid, path, &blob_oid,
+					      &mode);
 
 		if (!ret && oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
 			return;
@@ -1239,7 +1239,7 @@ static int fill_blob_sha1_and_mode(struct repository *r,
 {
 	if (!is_null_oid(&origin->blob_oid))
 		return 0;
-	if (get_tree_entry(r, &origin->commit->object.oid, origin->path, &origin->blob_oid, &origin->mode))
+	if (get_tree_entry_mode(r, &origin->commit->object.oid, origin->path, &origin->blob_oid, &origin->mode))
 		goto error_out;
 	if (oid_object_info(r, &origin->blob_oid, NULL) != OBJ_BLOB)
 		goto error_out;
diff --git a/builtin/rm.c b/builtin/rm.c
index 4858631e0f0..4617388b29a 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -179,7 +179,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 		 * way as changed from the HEAD.
 		 */
 		if (no_head
-		     || get_tree_entry(the_repository, head, name, &oid, &mode)
+		     || get_tree_entry_mode(the_repository, head, name, &oid, &mode)
 		     || ce->ce_mode != create_ce_mode(mode)
 		     || !oideq(&ce->oid, &oid))
 			staged_changes = 1;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 79087bccea4..070510d6a88 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -603,7 +603,7 @@ static struct cache_entry *read_one_ent(const char *which,
 	struct object_id oid;
 	struct cache_entry *ce;
 
-	if (get_tree_entry(the_repository, ent, path, &oid, &mode)) {
+	if (get_tree_entry_mode(the_repository, ent, path, &oid, &mode)) {
 		if (which)
 			error("%s: not in %s branch.", path, which);
 		return NULL;
diff --git a/line-log.c b/line-log.c
index 75c8b1acfff..4790dda4607 100644
--- a/line-log.c
+++ b/line-log.c
@@ -503,7 +503,7 @@ static void fill_blob_sha1(struct repository *r, struct commit *commit,
 	unsigned short mode;
 	struct object_id oid;
 
-	if (get_tree_entry(r, &commit->object.oid, spec->path, &oid, &mode))
+	if (get_tree_entry_mode(r, &commit->object.oid, spec->path, &oid, &mode))
 		die("There is no path %s in the commit", spec->path);
 	fill_filespec(spec, &oid, 1, mode);
 
diff --git a/match-trees.c b/match-trees.c
index f3e192ca74d..0faacd8f4ae 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -293,7 +293,7 @@ void shift_tree(struct repository *r,
 		if (!*del_prefix)
 			return;
 
-		if (get_tree_entry(r, hash2, del_prefix, shifted, &mode))
+		if (get_tree_entry_mode(r, hash2, del_prefix, shifted, &mode))
 			die("cannot find path %s in tree %s",
 			    del_prefix, oid_to_hex(hash2));
 		return;
@@ -321,12 +321,12 @@ void shift_tree_by(struct repository *r,
 	unsigned candidate = 0;
 
 	/* Can hash2 be a tree at shift_prefix in tree hash1? */
-	if (!get_tree_entry(r, hash1, shift_prefix, &sub1, &mode1) &&
+	if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &mode1) &&
 	    S_ISDIR(mode1))
 		candidate |= 1;
 
 	/* Can hash1 be a tree at shift_prefix in tree hash2? */
-	if (!get_tree_entry(r, hash2, shift_prefix, &sub2, &mode2) &&
+	if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &mode2) &&
 	    S_ISDIR(mode2))
 		candidate |= 2;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index df4b369902f..bbbb68e15bc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -487,7 +487,7 @@ static int get_tree_entry_if_blob(struct repository *r,
 {
 	int ret;
 
-	ret = get_tree_entry(r, tree, path, &dfs->oid, &dfs->mode);
+	ret = get_tree_entry_mode(r, tree, path, &dfs->oid, &dfs->mode);
 	if (S_ISDIR(dfs->mode)) {
 		oidcpy(&dfs->oid, &null_oid);
 		dfs->mode = 0;
@@ -1886,9 +1886,9 @@ static int tree_has_path(struct repository *r, struct tree *tree,
 	struct object_id hashy;
 	unsigned short mode_o;
 
-	return !get_tree_entry(r,
-			       &tree->object.oid, path,
-			       &hashy, &mode_o);
+	return !get_tree_entry_mode(r,
+				    &tree->object.oid, path,
+				    &hashy, &mode_o);
 }
 
 /*
@@ -2541,11 +2541,11 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 	 * the various handle_rename_*() functions update the index
 	 * explicitly rather than relying on unpack_trees() to have done it.
 	 */
-	get_tree_entry(opt->repo,
-		       &tree->object.oid,
-		       pair->two->path,
-		       &re->dst_entry->stages[stage].oid,
-		       &re->dst_entry->stages[stage].mode);
+	get_tree_entry_mode(opt->repo,
+			    &tree->object.oid,
+			    pair->two->path,
+			    &re->dst_entry->stages[stage].oid,
+			    &re->dst_entry->stages[stage].mode);
 
 	/*
 	 * Record the original change status (or 'type' of change).  If it
diff --git a/notes.c b/notes.c
index 688d03ee9cd..ef138606146 100644
--- a/notes.c
+++ b/notes.c
@@ -1021,7 +1021,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 		return;
 	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, &object_oid))
 		die("Cannot use notes ref %s", notes_ref);
-	if (get_tree_entry(the_repository, &object_oid, "", &oid, &mode))
+	if (get_tree_entry_mode(the_repository, &object_oid, "", &oid, &mode))
 		die("Failed to read notes tree referenced by %s (%s)",
 		    notes_ref, oid_to_hex(&object_oid));
 
diff --git a/object-name.c b/object-name.c
index 64202de60b1..7e3b2d6d739 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1704,7 +1704,7 @@ static void diagnose_invalid_oid_path(struct repository *r,
 	if (is_missing_file_error(errno)) {
 		char *fullname = xstrfmt("%s%s", prefix, filename);
 
-		if (!get_tree_entry(r, tree_oid, fullname, &oid, &mode)) {
+		if (!get_tree_entry_mode(r, tree_oid, fullname, &oid, &mode)) {
 			die(_("path '%s' exists, but not '%s'\n"
 			    "hint: Did you mean '%.*s:%s' aka '%.*s:./%s'?"),
 			    fullname,
@@ -1903,8 +1903,8 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 					filename, oid, &oc->symlink_path,
 					&oc->mode);
 			} else {
-				ret = get_tree_entry(repo, &tree_oid, filename, oid,
-						     &oc->mode);
+				ret = get_tree_entry_mode(repo, &tree_oid, filename, oid,
+							  &oc->mode);
 				if (ret && only_to_die) {
 					diagnose_invalid_oid_path(repo, prefix,
 								   filename,
diff --git a/tree-walk.c b/tree-walk.c
index e88187e3714..7819ff3e0ec 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -591,17 +591,17 @@ static int find_tree_entry(struct repository *r, struct tree_desc *t,
 			oidcpy(result, &oid);
 			return 0;
 		}
-		return get_tree_entry(r, &oid, name + entrylen, result,
-				      mode);
+		return get_tree_entry_mode(r, &oid, name + entrylen, result,
+					   mode);
 	}
 	return -1;
 }
 
-int get_tree_entry(struct repository *r,
-		   const struct object_id *tree_oid,
-		   const char *name,
-		   struct object_id *oid,
-		   unsigned short *mode)
+int get_tree_entry_mode(struct repository *r,
+			const struct object_id *tree_oid,
+			const char *name,
+			struct object_id *oid,
+			unsigned short *mode)
 {
 	int retval;
 	void *tree;
diff --git a/tree-walk.h b/tree-walk.h
index 478a659ee2b..eb9b9de6ccc 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -174,9 +174,9 @@ struct traverse_info {
  * The third and fourth parameters are set to the entry's sha1 and
  * mode respectively.
  */
-int get_tree_entry(struct repository *, const struct object_id *, const char *,
-		   struct object_id *,
-		   unsigned short *);
+int get_tree_entry_mode(struct repository *, const struct object_id *, const char *,
+			struct object_id *,
+			unsigned short *);
 
 /**
  * Generate the full pathname of a tree entry based from the root of the
-- 
2.31.0.rc2.211.g1d0b8788b3

