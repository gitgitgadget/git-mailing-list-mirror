Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D702070F
	for <e@80x24.org>; Wed, 14 Sep 2016 21:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765696AbcINVHx (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 17:07:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35792 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765183AbcINVHs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 17:07:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id 133so2226735wmq.2
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zkzf7etrhOoL4215sRDECGUTD7buxkU8rCSO4KFdaZk=;
        b=XFj+/avEBy4IXx4aq77w7oqja3FOug3giF9D3TXIhdckRYAH37EL9I9iMMS2gi8Hp6
         jFQ7M/llhF9izW+XMclWy3KXjrThHnO0LEThvexdabYF7BAK9suA+M086Ua8Dbvw39gq
         p1Gv165HpsOzw0bnCAt8EMecpq0G2nxX9OIhxkKPtBTLt1lculkXCvFjsMmkfJRyheKM
         JZ0EeK0qVOAPP7fdGGe5pRBFXGRB9qPu+Wn6UJPXUqvkxQzEdBsvN4uCwxYEy27QKEW0
         1CCG+J5Vv6wbb4ROcFW9hECKdsXs47HXEY/NQTxhFFqxWaSlaMRFHoi1S3WGxPG4Q3PO
         n+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zkzf7etrhOoL4215sRDECGUTD7buxkU8rCSO4KFdaZk=;
        b=SYxJeaJQlU4oTE9v9ga70OsqQlDak8Vf8QLFTErVHCUid/faCM6dp+6TQLEEfC8uvd
         utCwRUAZi1tjYpiF86ZYe/uzw7EEPn80oOli0DLmHf46sNtyQ67fZGcTdF3wjMd+lXkE
         w7VwS9uSJnNyLi91BC5Is/pkG58Gj4znkF+/1X1kYD92kcQfZabdzDsls1LprUwTMlxR
         7zjH/3GxZEu3V8wybujRGkBL2Cpmyly3Y/eBVkDyavM7l3efjXAPlJimP6N4ZizaYAxN
         d+T3fGO3WWM80WvM6VLjCXuICerWV9shGqIPJ54aDOouZzSvmvdA2RaYzCG+l1F9UFyx
         rZtA==
X-Gm-Message-State: AE9vXwPOdeKhcz1bYQP6cffUqdx0ybNgJ7CteaAqCiTtTD2Dt7J+fu9KbG0hXlYf3DVxiw==
X-Received: by 10.28.153.211 with SMTP id b202mr2466548wme.7.1473887266251;
        Wed, 14 Sep 2016 14:07:46 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id b188sm12536342wmg.24.2016.09.14.14.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Sep 2016 14:07:45 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 4/4] add: modify already added files when --chmod is given
Date:   Wed, 14 Sep 2016 22:07:47 +0100
Message-Id: <20160914210747.15485-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160914210747.15485-1-t.gummerer@gmail.com>
References: <20160912210818.26282-1-t.gummerer@gmail.com>
 <20160914210747.15485-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the chmod option was added to git add, it was hooked up to the diff
machinery, meaning that it only works when the version in the index
differs from the version on disk.

As the option was supposed to mirror the chmod option in update-index,
which always changes the mode in the index, regardless of the status of
the file, make sure the option behaves the same way in git add.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/add.c      | 47 ++++++++++++++++++++++++++++-------------------
 builtin/checkout.c |  2 +-
 builtin/commit.c   |  2 +-
 cache.h            | 10 +++++-----
 read-cache.c       | 14 ++++++--------
 t/t3700-add.sh     | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 91 insertions(+), 34 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index b1dddb4..595a0b2 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -26,10 +26,25 @@ static int patch_interactive, add_interactive, edit_interactive;
 static int take_worktree_changes;
 
 struct update_callback_data {
-	int flags, force_mode;
+	int flags;
 	int add_errors;
 };
 
+static void chmod_pathspec(struct pathspec *pathspec, int force_mode)
+{
+	int i;
+	
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+
+		if (pathspec && !ce_path_match(ce, pathspec, NULL))
+			continue;
+
+		if (chmod_cache_entry(ce, force_mode) < 0)
+			fprintf(stderr, "cannot chmod '%s'", ce->name);
+	}
+}
+
 static int fix_unmerged_status(struct diff_filepair *p,
 			       struct update_callback_data *data)
 {
@@ -65,8 +80,7 @@ static void update_callback(struct diff_queue_struct *q,
 			die(_("unexpected diff status %c"), p->status);
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
-			if (add_file_to_index(&the_index, path,
-					data->flags, data->force_mode)) {
+			if (add_file_to_index(&the_index, path,	data->flags)) {
 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
 					die(_("updating files failed"));
 				data->add_errors++;
@@ -84,15 +98,14 @@ static void update_callback(struct diff_queue_struct *q,
 	}
 }
 
-int add_files_to_cache(const char *prefix, const struct pathspec *pathspec,
-	int flags, int force_mode)
+int add_files_to_cache(const char *prefix,
+		       const struct pathspec *pathspec, int flags)
 {
 	struct update_callback_data data;
 	struct rev_info rev;
 
 	memset(&data, 0, sizeof(data));
 	data.flags = flags;
-	data.force_mode = force_mode;
 
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
@@ -281,7 +294,7 @@ static int add_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static int add_files(struct dir_struct *dir, int flags, int force_mode)
+static int add_files(struct dir_struct *dir, int flags)
 {
 	int i, exit_status = 0;
 
@@ -294,8 +307,7 @@ static int add_files(struct dir_struct *dir, int flags, int force_mode)
 	}
 
 	for (i = 0; i < dir->nr; i++)
-		if (add_file_to_index(&the_index, dir->entries[i]->name,
-				flags, force_mode)) {
+		if (add_file_to_index(&the_index, dir->entries[i]->name, flags)) {
 			if (!ignore_add_errors)
 				die(_("adding files failed"));
 			exit_status = 1;
@@ -308,7 +320,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int exit_status = 0;
 	struct pathspec pathspec;
 	struct dir_struct dir;
-	int flags, force_mode;
+	int flags;
 	int add_new_files;
 	int require_pathspec;
 	char *seen = NULL;
@@ -342,13 +354,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
 
-	if (!chmod_arg)
-		force_mode = 0;
-	else if (!strcmp(chmod_arg, "-x"))
-		force_mode = 0666;
-	else if (!strcmp(chmod_arg, "+x"))
-		force_mode = 0777;
-	else
+	if (chmod_arg && ((chmod_arg[0] != '-' && chmod_arg[0] != '+') ||
+			  chmod_arg[1] != 'x' || chmod_arg[2]))
 		die(_("--chmod param '%s' must be either -x or +x"), chmod_arg);
 
 	add_new_files = !take_worktree_changes && !refresh_only;
@@ -441,11 +448,13 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	plug_bulk_checkin();
 
-	exit_status |= add_files_to_cache(prefix, &pathspec, flags, force_mode);
+	exit_status |= add_files_to_cache(prefix, &pathspec, flags);
 
 	if (add_new_files)
-		exit_status |= add_files(&dir, flags, force_mode);
+		exit_status |= add_files(&dir, flags);
 
+	if (chmod_arg && pathspec.nr)
+		chmod_pathspec(&pathspec, chmod_arg[0]);
 	unplug_bulk_checkin();
 
 finish:
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8672d07..a83c78f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -548,7 +548,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 * entries in the index.
 			 */
 
-			add_files_to_cache(NULL, NULL, 0, 0);
+			add_files_to_cache(NULL, NULL, 0);
 			/*
 			 * NEEDSWORK: carrying over local changes
 			 * when branches have different end-of-line
diff --git a/builtin/commit.c b/builtin/commit.c
index bb9f79b..1cba3b7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -397,7 +397,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	 */
 	if (all || (also && pathspec.nr)) {
 		hold_locked_index(&index_lock, 1);
-		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, 0);
+		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
diff --git a/cache.h b/cache.h
index 35c8d1c..cd8e9fe 100644
--- a/cache.h
+++ b/cache.h
@@ -367,8 +367,8 @@ extern void free_name_hash(struct index_state *istate);
 #define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&the_index, (pos), (new_name))
 #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
 #define remove_file_from_cache(path) remove_file_from_index(&the_index, (path))
-#define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags), 0)
-#define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags), 0)
+#define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags))
+#define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
 #define chmod_cache_entry(ce, flip) chmod_index_entry(&the_index, (ce), (flip))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
@@ -582,8 +582,8 @@ extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_IGNORE_ERRORS	4
 #define ADD_CACHE_IGNORE_REMOVAL 8
 #define ADD_CACHE_INTENT 16
-extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags, int force_mode);
-extern int add_file_to_index(struct index_state *, const char *path, int flags, int force_mode);
+extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
+extern int add_file_to_index(struct index_state *, const char *path, int flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
 extern int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
 extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
@@ -1821,7 +1821,7 @@ void packet_trace_identity(const char *prog);
  * return 0 if success, 1 - if addition of a file failed and
  * ADD_FILES_IGNORE_ERRORS was specified in flags
  */
-int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags, int force_mode);
+int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags);
 
 /* diff.c */
 extern int diff_auto_refresh_index;
diff --git a/read-cache.c b/read-cache.c
index 8924f2e..016bbcb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -627,7 +627,7 @@ void set_object_name_for_intent_to_add_entry(struct cache_entry *ce)
 	hashcpy(ce->sha1, sha1);
 }
 
-int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags, int force_mode)
+int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags)
 {
 	int size, namelen, was_same;
 	mode_t st_mode = st->st_mode;
@@ -656,11 +656,10 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	else
 		ce->ce_flags |= CE_INTENT_TO_ADD;
 
-	if (S_ISREG(st_mode) && force_mode)
-		ce->ce_mode = create_ce_mode(force_mode);
-	else if (trust_executable_bit && has_symlinks)
+
+	if (trust_executable_bit && has_symlinks) {
 		ce->ce_mode = create_ce_mode(st_mode);
-	else {
+	} else {
 		/* If there is an existing entry, pick the mode bits and type
 		 * from it, otherwise assume unexecutable regular file.
 		 */
@@ -719,13 +718,12 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	return 0;
 }
 
-int add_file_to_index(struct index_state *istate, const char *path,
-	int flags, int force_mode)
+int add_file_to_index(struct index_state *istate, const char *path, int flags)
 {
 	struct stat st;
 	if (lstat(path, &st))
 		die_errno("unable to stat '%s'", path);
-	return add_to_index(istate, path, &st, flags, force_mode);
+	return add_to_index(istate, path, &st, flags);
 }
 
 struct cache_entry *make_cache_entry(unsigned int mode,
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 2978cb9..0a962a6 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -349,4 +349,54 @@ test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
 	test_mode_in_index 100755 foo2
 '
 
+test_expect_success 'git add --chmod=[+-]x changes index with already added file' '
+	echo foo >foo3 &&
+	git add foo3 &&
+	git add --chmod=+x foo3 &&
+	test_mode_in_index 100755 foo3 &&
+	echo foo >xfoo3 &&
+	chmod 755 xfoo3 &&
+	git add xfoo3 &&
+	git add --chmod=-x xfoo3 &&
+	test_mode_in_index 100644 xfoo3
+'
+
+test_expect_success 'file status is changed after git add --chmod=+x' '
+	echo "AM foo4" >expected &&
+	echo foo >foo4 &&
+	git add foo4 &&
+	git add --chmod=+x foo4 &&
+	git status -s foo4 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'no file status change if no pathspec is given' '
+	>foo5 &&
+	>foo6 &&
+	git add foo5 foo6 &&
+	git add --chmod=+x &&
+	test_mode_in_index 100644 foo5 &&
+	test_mode_in_index 100644 foo6
+'
+
+test_expect_success 'no file status change if no pathspec is given in subdir' '
+	mkdir sub &&
+	(
+		cd sub &&
+		>sub-foo1 &&
+		>sub-foo2 &&
+		git add . &&
+		git add --chmod=+x &&
+		test_mode_in_index 100644 sub-foo1 &&
+		test_mode_in_index 100644 sub-foo2
+	)
+'
+
+test_expect_success 'all statuses changed in folder if . is given' '
+	git add --chmod=+x . &&
+	test $(git ls-files --stage | grep ^100644 | wc -l) -eq 0 &&
+	git add --chmod=-x . &&
+	test $(git ls-files --stage | grep ^100755 | wc -l) -eq 0
+'
+
 test_done
-- 
2.10.0.304.gf2ff484

