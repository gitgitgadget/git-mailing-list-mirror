Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1ECE1FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 11:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753824AbcIDLkT (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 07:40:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34543 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753195AbcIDLkP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 07:40:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id v143so9136072wmv.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 04:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LLuxz3S1YiKV48osH2oZebmKEuRiJ7dLNEgh7Zp2+rA=;
        b=IQsyq2udq3duvYynTuxwz8Db6wrF8H3UnjLRdsNBwo0YFGn1PDbRyCQbvce69uzfid
         LRYXTyRhKbGYSR8/Q3zQhFhr6euUvlS+1Tshj8XTJNge9JxvaqiXPztmpkZxzBGfhWZ1
         eKL3NKaJYAGIP90qHem08XCgYsiOb3l6bMsNhu4COFNoeRLulDY0JMN9bFiM3yTaEc4S
         0jZ+LLSAoOOJhyt5/ymDP7S0EGIxXZH/+fvun8/czVa/380d1hf5dPMVPaTbfKhPDIJ9
         9uzXPloWhIn32O5YbolgbpfzqN/pZnH5slxdHv1Drz6X3nppZOcp9rXiQWU54YapJoHZ
         QgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LLuxz3S1YiKV48osH2oZebmKEuRiJ7dLNEgh7Zp2+rA=;
        b=jIWk6yPgs8JG2b5Vg8fUjLAtfKQbqJfWPkgFJHUfnWrrDgnIR4L815g+MZZo0rKkXZ
         l2j3cXyjoyoWR7XVtHttywq2DKmrI+W1oKVYg6b8t9Dxop7gQeon8B/DHTTWBBimzx41
         K/3X7rl5P9+O8KNu5G5X+x39BvElOJ8jqlN296ktE/hVjiSFqVjeZYTcLOMewwiDOUuW
         VmVVvhsJKYZ03Trtdgt+9xIFgcmRIr5sjRuaCW90tOPTh7vp8jlp4neiqJvuqXOuXhVi
         bqBb9/Tylt81ha9UNzxew3in0bm7RVqR3CuQfEjtb3c3pCwFHl1PiNEDZJO5AyAhRAus
         3gJQ==
X-Gm-Message-State: AE9vXwM6irEUhhEhJMYCqo6Mm/8uqrwaytDwGIDlK3Qr6E380iCsOfRGF/0jZ9vvlZRydg==
X-Received: by 10.28.147.69 with SMTP id v66mr10592605wmd.70.1472989213955;
        Sun, 04 Sep 2016 04:40:13 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id bc5sm14146541wjb.37.2016.09.04.04.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Sep 2016 04:40:13 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        git@vger.kernel.org,
        =?UTF-8?q?Ingo=20Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 4/4] add: modify already added files when --chmod is given
Date:   Sun,  4 Sep 2016 12:39:54 +0100
Message-Id: <20160904113954.21697-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484
In-Reply-To: <20160904113954.21697-1-t.gummerer@gmail.com>
References: <xmqq4m5zutyc.fsf@gitster.mtv.corp.google.com>
 <20160904113954.21697-1-t.gummerer@gmail.com>
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

Reported-by: Jan Keromnes <janx@linux.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/add.c      | 36 +++++++++++++++++++++++++-----------
 builtin/checkout.c |  2 +-
 builtin/commit.c   |  2 +-
 cache.h            | 10 +++++-----
 read-cache.c       | 14 ++++++--------
 t/t3700-add.sh     | 21 +++++++++++++++++++++
 6 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index b1dddb4..892198a 100644
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
@@ -441,11 +453,13 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	plug_bulk_checkin();
 
-	exit_status |= add_files_to_cache(prefix, &pathspec, flags, force_mode);
+	exit_status |= add_files_to_cache(prefix, &pathspec, flags);
 
 	if (add_new_files)
-		exit_status |= add_files(&dir, flags, force_mode);
+		exit_status |= add_files(&dir, flags);
 
+	if (force_mode)
+		chmod_pathspec(&pathspec, force_mode);
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
index 77e3dc8..7a1ade0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -387,7 +387,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	 */
 	if (all || (also && pathspec.nr)) {
 		hold_locked_index(&index_lock, 1);
-		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, 0);
+		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
diff --git a/cache.h b/cache.h
index 44a4f76..eb6d6b8 100644
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
 #define chmod_cache_entry(ce, force_mode) chmod_index_entry(&the_index, (ce), (force_mode))
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
 extern int chmod_index_entry(struct index_state *, struct cache_entry *ce, int force_mode);
 extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
@@ -1820,7 +1820,7 @@ void packet_trace_identity(const char *prog);
  * return 0 if success, 1 - if addition of a file failed and
  * ADD_FILES_IGNORE_ERRORS was specified in flags
  */
-int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags, int force_mode);
+int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags);
 
 /* diff.c */
 extern int diff_auto_refresh_index;
diff --git a/read-cache.c b/read-cache.c
index 367be57..b92d72e 100644
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
index 2978cb9..62c7f71 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -349,4 +349,25 @@ test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
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
 test_done
-- 
2.10.0.304.gf2ff484

