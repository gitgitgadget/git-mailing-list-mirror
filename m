Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42301C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 22:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354064AbhLFWIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 17:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhLFWIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 17:08:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D46C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 14:05:09 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d9so25354273wrw.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 14:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MlVMFdR2dwewlNJsk94SPHbtexyRRdII8MQUVyRtGsY=;
        b=Jd7qaiJxtnDAkCTm/hoim5lkiPRjhUUU8Y2b2NHrKWVq0PPcccIL/5V+okB2SkvIIa
         ylzh25P4wbMmp1MRVq5fd+UdcwXqsd8fbRg4M/QVza6MiZlRkYar5kfgEJUkDp8O4qS+
         gUlf+OCyKUOAAAHNQ28m3yxTv6KXaxwBhlHkECrgI8mElWRFsVKRlzu38uYD9ENciS6J
         KuoTsSRplF9Ph7qu5ez1Cjpff5aBMMFSXJQ+PvPfOFVqcjacgaVfflO7pMzES5/sbSFM
         j0X6Z5DfJ0+6EDY7txidZTYMy4KL7PcNafj7Rbh07pcM5gwtwJPLw1BdBLX/qwM/ucPO
         xcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MlVMFdR2dwewlNJsk94SPHbtexyRRdII8MQUVyRtGsY=;
        b=ilXrCdIzDiJl71RKUhvszyCU9CDAwhudpN+WEcILZOwISaTVlxR5mb68JNwIzeJMsz
         DEaekxwKwfi4T1D7V1SmaEDjDJwrnXF7X/jUFinRH1xxMifBdT/Zd7WlBPK6Hg0gkHnT
         lSAaoezIyN+l9EAVeJqs0YNj69JrlJfhlnRILFneX9n2rkeeObhm3+h38uirRFrlis6l
         +41eb9u6fKcDjecmLD7VZl2DFrIqEgKQlQZBcoYrAI0KVKhkxybOmYudCXtPWqGT+VSN
         du6y1Qaw1yRk3kjabl6mZDql6tHO323rpF2s5DJ/NjsxrnOkjWA5bBChHAnTxEg9v4O/
         citA==
X-Gm-Message-State: AOAM533x69X0SyfkFeorHVWDPdz4aFFyj/a6STRvzJOeJcxNRv3cpDlo
        K9xMOVwir+KtQdRSr62ASi8Qi9CC/CY=
X-Google-Smtp-Source: ABdhPJyzLlhPw+tiSGpQM1IpamrmtjZYkbma3coTtXZkf0qi9PeeAkVQqpLxCotdBAm5m+sP8Md27A==
X-Received: by 2002:a5d:6dc1:: with SMTP id d1mr45664948wrz.282.1638828307715;
        Mon, 06 Dec 2021 14:05:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o25sm593550wms.17.2021.12.06.14.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 14:05:07 -0800 (PST)
Message-Id: <cccb388807002c844e0833aa7ab85e93fa4e4e50.1638828305.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1091.v3.git.1638828305.gitgitgadget@gmail.com>
References: <pull.1091.v2.git.1638750965.gitgitgadget@gmail.com>
        <pull.1091.v3.git.1638828305.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 22:05:04 +0000
Subject: [PATCH v3 1/2] tmp-objdir: new API for creating temporary writable
 databases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The tmp_objdir API provides the ability to create temporary object
directories, but was designed with the goal of having subprocesses
access these object stores, followed by the main process migrating
objects from it to the main object store or just deleting it.  The
subprocesses would view it as their primary datastore and write to it.

Here we add the tmp_objdir_replace_primary_odb function that replaces
the current process's writable "main" object directory with the
specified one. The previous main object directory is restored in either
tmp_objdir_migrate or tmp_objdir_destroy.

For the --remerge-diff usecase, add a new `will_destroy` flag in `struct
object_database` to mark ephemeral object databases that do not require
fsync durability.

Add 'git prune' support for removing temporary object databases, and
make sure that they have a name starting with tmp_ and containing an
operation-specific name.

Based-on-patch-by: Elijah Newren <newren@gmail.com>

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/prune.c        | 20 ++++++++++++---
 builtin/receive-pack.c |  2 +-
 environment.c          |  5 ++++
 object-file.c          | 44 +++++++++++++++++++++++++++++++--
 object-store.h         | 19 +++++++++++++++
 object.c               |  2 +-
 tmp-objdir.c           | 55 +++++++++++++++++++++++++++++++++++++++---
 tmp-objdir.h           | 29 +++++++++++++++++++---
 8 files changed, 162 insertions(+), 14 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 485c9a3c56f..c2bcdc07db4 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -26,10 +26,22 @@ static int prune_tmp_file(const char *fullpath)
 		return error("Could not stat '%s'", fullpath);
 	if (st.st_mtime > expire)
 		return 0;
-	if (show_only || verbose)
-		printf("Removing stale temporary file %s\n", fullpath);
-	if (!show_only)
-		unlink_or_warn(fullpath);
+	if (S_ISDIR(st.st_mode)) {
+		if (show_only || verbose)
+			printf("Removing stale temporary directory %s\n", fullpath);
+		if (!show_only) {
+			struct strbuf remove_dir_buf = STRBUF_INIT;
+
+			strbuf_addstr(&remove_dir_buf, fullpath);
+			remove_dir_recursively(&remove_dir_buf, 0);
+			strbuf_release(&remove_dir_buf);
+		}
+	} else {
+		if (show_only || verbose)
+			printf("Removing stale temporary file %s\n", fullpath);
+		if (!show_only)
+			unlink_or_warn(fullpath);
+	}
 	return 0;
 }
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d9605..8815e24cde5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2213,7 +2213,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		strvec_push(&child.args, alt_shallow_file);
 	}
 
-	tmp_objdir = tmp_objdir_create();
+	tmp_objdir = tmp_objdir_create("incoming");
 	if (!tmp_objdir) {
 		if (err_fd > 0)
 			close(err_fd);
diff --git a/environment.c b/environment.c
index 9da7f3c1a19..fe51dfe24d4 100644
--- a/environment.c
+++ b/environment.c
@@ -17,6 +17,7 @@
 #include "commit.h"
 #include "strvec.h"
 #include "object-store.h"
+#include "tmp-objdir.h"
 #include "chdir-notify.h"
 #include "shallow.h"
 
@@ -331,10 +332,14 @@ static void update_relative_gitdir(const char *name,
 				   void *data)
 {
 	char *path = reparent_relative_path(old_cwd, new_cwd, get_git_dir());
+	struct tmp_objdir *tmp_objdir = tmp_objdir_unapply_primary_odb();
+
 	trace_printf_key(&trace_setup_key,
 			 "setup: move $GIT_DIR to '%s'",
 			 path);
 	set_git_dir_1(path);
+	if (tmp_objdir)
+		tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
 	free(path);
 }
 
diff --git a/object-file.c b/object-file.c
index c3d866a287e..0b6a61aeaff 100644
--- a/object-file.c
+++ b/object-file.c
@@ -683,6 +683,43 @@ void add_to_alternates_memory(const char *reference)
 			     '\n', NULL, 0);
 }
 
+struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy)
+{
+	struct object_directory *new_odb;
+
+	/*
+	 * Make sure alternates are initialized, or else our entry may be
+	 * overwritten when they are.
+	 */
+	prepare_alt_odb(the_repository);
+
+	/*
+	 * Make a new primary odb and link the old primary ODB in as an
+	 * alternate
+	 */
+	new_odb = xcalloc(1, sizeof(*new_odb));
+	new_odb->path = xstrdup(dir);
+	new_odb->will_destroy = will_destroy;
+	new_odb->next = the_repository->objects->odb;
+	the_repository->objects->odb = new_odb;
+	return new_odb->next;
+}
+
+void restore_primary_odb(struct object_directory *restore_odb, const char *old_path)
+{
+	struct object_directory *cur_odb = the_repository->objects->odb;
+
+	if (strcmp(old_path, cur_odb->path))
+		BUG("expected %s as primary object store; found %s",
+		    old_path, cur_odb->path);
+
+	if (cur_odb->next != restore_odb)
+		BUG("we expect the old primary object store to be the first alternate");
+
+	the_repository->objects->odb = restore_odb;
+	free_object_directory(cur_odb);
+}
+
 /*
  * Compute the exact path an alternate is at and returns it. In case of
  * error NULL is returned and the human readable error is added to `err`
@@ -1809,8 +1846,11 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 /* Finalize a file on disk, and close it. */
 static void close_loose_object(int fd)
 {
-	if (fsync_object_files)
-		fsync_or_die(fd, "loose object file");
+	if (!the_repository->objects->odb->will_destroy) {
+		if (fsync_object_files)
+			fsync_or_die(fd, "loose object file");
+	}
+
 	if (close(fd) != 0)
 		die_errno(_("error when closing loose object file"));
 }
diff --git a/object-store.h b/object-store.h
index 952efb6a4be..cb173e69392 100644
--- a/object-store.h
+++ b/object-store.h
@@ -27,6 +27,11 @@ struct object_directory {
 	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
 	struct oidtree *loose_objects_cache;
 
+	/*
+	 * This object store is ephemeral, so there is no need to fsync.
+	 */
+	int will_destroy;
+
 	/*
 	 * Path to the alternative object store. If this is a relative path,
 	 * it is relative to the current working directory.
@@ -58,6 +63,17 @@ void add_to_alternates_file(const char *dir);
  */
 void add_to_alternates_memory(const char *dir);
 
+/*
+ * Replace the current writable object directory with the specified temporary
+ * object directory; returns the former primary object directory.
+ */
+struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy);
+
+/*
+ * Restore a previous ODB replaced by set_temporary_main_odb.
+ */
+void restore_primary_odb(struct object_directory *restore_odb, const char *old_path);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -68,6 +84,9 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
 /* Empty the loose object cache for the specified object directory. */
 void odb_clear_loose_cache(struct object_directory *odb);
 
+/* Clear and free the specified object directory */
+void free_object_directory(struct object_directory *odb);
+
 struct packed_git {
 	struct hashmap_entry packmap_ent;
 	struct packed_git *next;
diff --git a/object.c b/object.c
index 23a24e678a8..048f96a260e 100644
--- a/object.c
+++ b/object.c
@@ -513,7 +513,7 @@ struct raw_object_store *raw_object_store_new(void)
 	return o;
 }
 
-static void free_object_directory(struct object_directory *odb)
+void free_object_directory(struct object_directory *odb)
 {
 	free(odb->path);
 	odb_clear_loose_cache(odb);
diff --git a/tmp-objdir.c b/tmp-objdir.c
index b8d880e3626..3d38eeab66b 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "tmp-objdir.h"
+#include "chdir-notify.h"
 #include "dir.h"
 #include "sigchain.h"
 #include "string-list.h"
@@ -11,6 +12,8 @@
 struct tmp_objdir {
 	struct strbuf path;
 	struct strvec env;
+	struct object_directory *prev_odb;
+	int will_destroy;
 };
 
 /*
@@ -38,6 +41,9 @@ static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
 	if (t == the_tmp_objdir)
 		the_tmp_objdir = NULL;
 
+	if (!on_signal && t->prev_odb)
+		restore_primary_odb(t->prev_odb, t->path.buf);
+
 	/*
 	 * This may use malloc via strbuf_grow(), but we should
 	 * have pre-grown t->path sufficiently so that this
@@ -52,6 +58,7 @@ static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
 	 */
 	if (!on_signal)
 		tmp_objdir_free(t);
+
 	return err;
 }
 
@@ -121,7 +128,7 @@ static int setup_tmp_objdir(const char *root)
 	return ret;
 }
 
-struct tmp_objdir *tmp_objdir_create(void)
+struct tmp_objdir *tmp_objdir_create(const char *prefix)
 {
 	static int installed_handlers;
 	struct tmp_objdir *t;
@@ -129,11 +136,16 @@ struct tmp_objdir *tmp_objdir_create(void)
 	if (the_tmp_objdir)
 		BUG("only one tmp_objdir can be used at a time");
 
-	t = xmalloc(sizeof(*t));
+	t = xcalloc(1, sizeof(*t));
 	strbuf_init(&t->path, 0);
 	strvec_init(&t->env);
 
-	strbuf_addf(&t->path, "%s/incoming-XXXXXX", get_object_directory());
+	/*
+	 * Use a string starting with tmp_ so that the builtin/prune.c code
+	 * can recognize any stale objdirs left behind by a crash and delete
+	 * them.
+	 */
+	strbuf_addf(&t->path, "%s/tmp_objdir-%s-XXXXXX", get_object_directory(), prefix);
 
 	/*
 	 * Grow the strbuf beyond any filename we expect to be placed in it.
@@ -269,6 +281,13 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	if (!t)
 		return 0;
 
+	if (t->prev_odb) {
+		if (the_repository->objects->odb->will_destroy)
+			BUG("migrating an ODB that was marked for destruction");
+		restore_primary_odb(t->prev_odb, t->path.buf);
+		t->prev_odb = NULL;
+	}
+
 	strbuf_addbuf(&src, &t->path);
 	strbuf_addstr(&dst, get_object_directory());
 
@@ -292,3 +311,33 @@ void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
 {
 	add_to_alternates_memory(t->path.buf);
 }
+
+void tmp_objdir_replace_primary_odb(struct tmp_objdir *t, int will_destroy)
+{
+	if (t->prev_odb)
+		BUG("the primary object database is already replaced");
+	t->prev_odb = set_temporary_primary_odb(t->path.buf, will_destroy);
+	t->will_destroy = will_destroy;
+}
+
+struct tmp_objdir *tmp_objdir_unapply_primary_odb(void)
+{
+	if (!the_tmp_objdir || !the_tmp_objdir->prev_odb)
+		return NULL;
+
+	restore_primary_odb(the_tmp_objdir->prev_odb, the_tmp_objdir->path.buf);
+	the_tmp_objdir->prev_odb = NULL;
+	return the_tmp_objdir;
+}
+
+void tmp_objdir_reapply_primary_odb(struct tmp_objdir *t, const char *old_cwd,
+		const char *new_cwd)
+{
+	char *path;
+
+	path = reparent_relative_path(old_cwd, new_cwd, t->path.buf);
+	strbuf_reset(&t->path);
+	strbuf_addstr(&t->path, path);
+	free(path);
+	tmp_objdir_replace_primary_odb(t, t->will_destroy);
+}
diff --git a/tmp-objdir.h b/tmp-objdir.h
index b1e45b4c75d..cda5ec76778 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -10,7 +10,7 @@
  *
  * Example:
  *
- *	struct tmp_objdir *t = tmp_objdir_create();
+ *	struct tmp_objdir *t = tmp_objdir_create("incoming");
  *	if (!run_command_v_opt_cd_env(cmd, 0, NULL, tmp_objdir_env(t)) &&
  *	    !tmp_objdir_migrate(t))
  *		printf("success!\n");
@@ -22,9 +22,10 @@
 struct tmp_objdir;
 
 /*
- * Create a new temporary object directory; returns NULL on failure.
+ * Create a new temporary object directory with the specified prefix;
+ * returns NULL on failure.
  */
-struct tmp_objdir *tmp_objdir_create(void);
+struct tmp_objdir *tmp_objdir_create(const char *prefix);
 
 /*
  * Return a list of environment strings, suitable for use with
@@ -51,4 +52,26 @@ int tmp_objdir_destroy(struct tmp_objdir *);
  */
 void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
 
+/*
+ * Replaces the writable object store in the current process with the temporary
+ * object directory and makes the former main object store an alternate.
+ * If will_destroy is nonzero, the object directory may not be migrated.
+ */
+void tmp_objdir_replace_primary_odb(struct tmp_objdir *, int will_destroy);
+
+/*
+ * If the primary object database was replaced by a temporary object directory,
+ * restore it to its original value while keeping the directory contents around.
+ * Returns NULL if the primary object database was not replaced.
+ */
+struct tmp_objdir *tmp_objdir_unapply_primary_odb(void);
+
+/*
+ * Reapplies the former primary temporary object database, after potentially
+ * changing its relative path.
+ */
+void tmp_objdir_reapply_primary_odb(struct tmp_objdir *, const char *old_cwd,
+		const char *new_cwd);
+
+
 #endif /* TMP_OBJDIR_H */
-- 
gitgitgadget

