Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A30C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387587AbiBHWZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386370AbiBHUQt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 15:16:49 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51737C0613CB
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 12:16:45 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s18so375413wrv.7
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 12:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=v34kjlEjDCpXKAV0lzZsj3VRl+g5GApd7/EOGGSGd88=;
        b=gP8DAF/nGmrfqAgsd/ZLur/uC1zlXA7gtoUQ3ujl1dvJQPa9DD7WpLOjyJmQDczRdt
         Ag7ZGbEGcjNnc+Ry8OQmASpMldLZkOCqWdYECugsnhhOKLP2+fTbay4BdVIo3bUA0jBb
         4LO+8ANnCa0/f906mBs8nfzbJ8UX6kczRXvAK8WJCjkRYEdATcVrLP9E8k8IfwUUz4HU
         LspzUdBGepU/Nz8r6Jwu6NyNbO+mFXeZLlHaN0gB/CvotkmVlmFplnK9wwWLVIO5+qzI
         Hy8nlPULtqwieJqn/TXQdX3O8UKY9pa4t6gD5Vsxl/duHFfuMg5r/HPTqzuZyOGVQOej
         M1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v34kjlEjDCpXKAV0lzZsj3VRl+g5GApd7/EOGGSGd88=;
        b=IriNcw49V9hKk4FkiiY4W1lqF8rD3nFDAEtFupqj4EYKA6k8e204t1kBXrUWl0MA9k
         OcUbdxQpBC5OiywdTvcMrF8Ptma3srTux/fI3e6fgcGn/RgRhtaT5wr37hVhjDyXFQDr
         pW4f+hoXjtOZYiNg2Ez10bpXe/f4ko95PVRvo9QRFodYIclFQnU0H04glTKMBEzfRUor
         6TgcIQh6LypPj38DQKcksFjrnbkZV9V47A+Ho+vq47OrJOVomB9y6n4j5s8H7ngPnKw9
         2+6G7fm/33fsiRc123fZv/EkrMc+w1JG0m2yFjWE0V66J5p6NQpDwbpmqjRZIWIiiIjs
         X5EQ==
X-Gm-Message-State: AOAM5337lJY70Zjbb4k4xG0RkMa8NL4371E6JLrq9SnPIPQqyHtBznvc
        lJqh5lte1wRQNIEOSHis6gRrlEH468w=
X-Google-Smtp-Source: ABdhPJxM8H0Tw1ur0RGnfqcI2uacmoqfLi1SzAqHW1w+k+0LrHNlF5xj18jvUMDnRGX+DJVGtxoYfw==
X-Received: by 2002:a5d:4ec1:: with SMTP id s1mr4685161wrv.413.1644351402388;
        Tue, 08 Feb 2022 12:16:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t187sm3002690wma.22.2022.02.08.12.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:16:41 -0800 (PST)
Message-Id: <pull.1215.git.git.1644351400761.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 20:16:40 +0000
Subject: [PATCH] refs: RFC: Reftable support for git-core
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

For background, see Documentation/technical/reftable.txt.

This introduces the file refs/reftable-backend.c containing a
reftable-powered ref storage backend.

It can be activated by setting GIT_TEST_REFTABLE in the environment.
When GIT_TEST_REFTABLE is set, the test prerequisite !REFFILES is set.

There is no option to git-init for now, as the test suite still shows
failures with GIT_TEST_REFTABLE=1.

Example use: see t/t0031-reftable.sh

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Junio Hamano <gitster@pobox.com>
Helped-by: Patrick Steinhardt <patrick.steinhardt@elego.de>
Co-authored-by: Jeff King <peff@peff.net>
---
    RFC: Reftable backend current version
    
    In
    https://lore.kernel.org/git/220203.867dab6dmp.gmgdl@evledraar.gmail.com/
    Ævar considered the option of merging the reftable without 100% of tests
    passing. In my development branch, I am down to 26 test failures.
    
    As input to this discussion, I'm proffering the latest version of the
    reftable support.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1215%2Fhanwen%2Freftable-rfc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1215/hanwen/reftable-rfc-v1
Pull-Request: https://github.com/git/git/pull/1215

 Documentation/config/extensions.txt           |    9 +
 .../technical/repository-version.txt          |    7 +
 Makefile                                      |    1 +
 builtin/clone.c                               |    5 +-
 builtin/init-db.c                             |   41 +-
 builtin/stash.c                               |    8 +-
 builtin/worktree.c                            |   27 +-
 cache.h                                       |    8 +-
 config.mak.uname                              |    2 +-
 contrib/workdir/git-new-workdir               |    2 +-
 refs.c                                        |   29 +-
 refs.h                                        |    3 +
 refs/refs-internal.h                          |    1 +
 refs/reftable-backend.c                       | 1898 +++++++++++++++++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |    8 +
 t/t0031-reftable.sh                           |  380 ++++
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t3210-pack-refs.sh                          |    6 +
 t/test-lib.sh                                 |    7 +-
 22 files changed, 2429 insertions(+), 30 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100755 t/t0031-reftable.sh

diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
index 5999dcb2a1f..9ea3e99f2d0 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -37,3 +37,12 @@ details.
 +
 For historical reasons, `extensions.worktreeConfig` is respected
 regardless of the `core.repositoryFormatVersion` setting.
++
+extensions.refStorage::
+	Specify the ref storage mechanism to use.  The acceptable values are `files` and
+	`reftable`.  If not specified, `files` is assumed.  It is an error to specify
+	this key unless `core.repositoryFormatVersion` is 1.
++
+Note that this setting should only be set by linkgit:git-init[1] or
+linkgit:git-clone[1].  Trying to change it after initialization will not
+work and will produce hard-to-diagnose issues.
diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index 7844ef30ffd..72576235833 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -100,3 +100,10 @@ If set, by default "git config" reads from both "config" and
 multiple working directory mode, "config" file is shared while
 "config.worktree" is per-working directory (i.e., it's in
 GIT_COMMON_DIR/worktrees/<id>/config.worktree)
+
+==== `refStorage`
+
+Specifies the file format for the ref database. Values are `files`
+(for the traditional packed + loose ref format) and `reftable` for the
+binary reftable format. See https://github.com/google/reftable for
+more information.
diff --git a/Makefile b/Makefile
index daa21bed6c3..550e08782a5 100644
--- a/Makefile
+++ b/Makefile
@@ -1000,6 +1000,7 @@ LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/debug.o
 LIB_OBJS += refs/files-backend.o
+LIB_OBJS += refs/reftable-backend.o
 LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
diff --git a/builtin/clone.c b/builtin/clone.c
index f81f085ee87..d48580a7367 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1043,7 +1043,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
-		INIT_DB_QUIET);
+		default_ref_storage(), INIT_DB_QUIET);
 
 	if (real_git_dir) {
 		free((char *)git_dir);
@@ -1199,7 +1199,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		 * Now that we know what algorithm the remote side is using,
 		 * let's set ours to the same thing.
 		 */
-		initialize_repository_version(hash_algo, 1);
+		initialize_repository_version(hash_algo, 1,
+					      default_ref_storage());
 		repo_set_hash_algo(the_repository, hash_algo);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 546f9c595e7..37dd3dcca75 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -167,12 +167,14 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 	return 1;
 }
 
-void initialize_repository_version(int hash_algo, int reinit)
+void initialize_repository_version(int hash_algo, int reinit,
+				   const char *ref_storage_format)
 {
 	char repo_version_string[10];
 	int repo_version = GIT_REPO_VERSION;
 
-	if (hash_algo != GIT_HASH_SHA1)
+	if (hash_algo != GIT_HASH_SHA1 ||
+	    !strcmp(ref_storage_format, "reftable"))
 		repo_version = GIT_REPO_VERSION_READ;
 
 	/* This forces creation of new config file */
@@ -226,6 +228,7 @@ static int create_default_files(const char *template_path,
 	is_bare_repository_cfg = init_is_bare_repository || !work_tree;
 	if (init_shared_repository != -1)
 		set_shared_repository(init_shared_repository);
+	the_repository->ref_storage_format = xstrdup(fmt->ref_storage);
 
 	/*
 	 * We would have created the above under user's umask -- under
@@ -235,6 +238,24 @@ static int create_default_files(const char *template_path,
 		adjust_shared_perm(get_git_dir());
 	}
 
+	/*
+	 * Check to see if .git/HEAD exists; this must happen before
+	 * initializing the ref db, because we want to see if there is an
+	 * existing HEAD.
+	 */
+	path = git_path_buf(&buf, "HEAD");
+	reinit = (!access(path, R_OK) ||
+		  readlink(path, junk, sizeof(junk) - 1) != -1);
+
+	/*
+	 * refs/heads is a file when using reftable. We can't reinitialize with
+	 * a reftable because it will overwrite HEAD
+	 */
+	if (reinit && (!strcmp(fmt->ref_storage, "reftable")) ==
+			      is_directory(git_path_buf(&buf, "refs/heads"))) {
+		die("cannot switch ref storage format.");
+	}
+
 	/*
 	 * We need to create a "refs" dir in any case so that older
 	 * versions of git can tell that this is a repository.
@@ -242,6 +263,8 @@ static int create_default_files(const char *template_path,
 	safe_create_dir(git_path("refs"), 1);
 	adjust_shared_perm(git_path("refs"));
 
+	/* XXX hack.  What is the right place to initialize this? */
+	the_repository->hash_algo = &hash_algos[fmt->hash_algo];
 	if (refs_init_db(&err))
 		die("failed to set up refs db: %s", err.buf);
 
@@ -249,9 +272,6 @@ static int create_default_files(const char *template_path,
 	 * Point the HEAD symref to the initial branch with if HEAD does
 	 * not yet exist.
 	 */
-	path = git_path_buf(&buf, "HEAD");
-	reinit = (!access(path, R_OK)
-		  || readlink(path, junk, sizeof(junk)-1) != -1);
 	if (!reinit) {
 		char *ref;
 
@@ -268,7 +288,7 @@ static int create_default_files(const char *template_path,
 		free(ref);
 	}
 
-	initialize_repository_version(fmt->hash_algo, 0);
+	initialize_repository_version(fmt->hash_algo, 0, fmt->ref_storage);
 
 	/* Check filemode trustability */
 	path = git_path_buf(&buf, "config");
@@ -383,7 +403,7 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
 
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash, const char *initial_branch,
-	    unsigned int flags)
+	    const char *ref_storage_format, unsigned int flags)
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
@@ -422,6 +442,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
 	check_repository_format(&repo_fmt);
+	repo_fmt.ref_storage = xstrdup(ref_storage_format);
 
 	validate_hash_algorithm(&repo_fmt, hash);
 
@@ -455,6 +476,9 @@ int init_db(const char *git_dir, const char *real_git_dir,
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
 
+	if (!strcmp(ref_storage_format, "reftable"))
+		git_config_set("extensions.refStorage", ref_storage_format);
+
 	if (!(flags & INIT_DB_QUIET)) {
 		int len = strlen(git_dir);
 
@@ -528,6 +552,7 @@ static const char *const init_db_usage[] = {
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
+	const char *ref_storage_format = default_ref_storage();
 	const char *real_git_dir = NULL;
 	const char *work_tree;
 	const char *template_dir = NULL;
@@ -692,5 +717,5 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 
 	flags |= INIT_DB_EXIST_OK;
 	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
-		       initial_branch, flags);
+		       initial_branch, ref_storage_format, flags);
 }
diff --git a/builtin/stash.c b/builtin/stash.c
index 5897febfbec..e60b063d133 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -207,10 +207,16 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 static int do_clear_stash(void)
 {
 	struct object_id obj;
+	int result;
 	if (get_oid(ref_stash, &obj))
 		return 0;
 
-	return delete_ref(NULL, ref_stash, &obj, 0);
+	result = delete_ref(NULL, ref_stash, &obj, 0);
+
+	/* Ignore error; this is necessary for reftable, which keeps reflogs
+	 * even when refs are deleted. */
+	delete_reflog(ref_stash);
+	return result;
 }
 
 static int clear_stash(int argc, const char **argv, const char *prefix)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 31a8a2a4e8a..75db3a2cb77 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -14,6 +14,7 @@
 #include "utf8.h"
 #include "worktree.h"
 #include "quote.h"
+#include "../refs/refs-internal.h"
 
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> [<commit-ish>]"),
@@ -329,9 +330,29 @@ static int add_worktree(const char *path, const char *refname,
 	 * worktree.
 	 */
 	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, "%s", oid_to_hex(null_oid()));
-	strbuf_reset(&sb);
+	if (get_main_ref_store(the_repository)->be == &refs_be_reftable) {
+		/* XXX this is cut & paste from reftable_init_db. */
+		strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
+		write_file(sb.buf, "%s", "ref: refs/heads/.invalid\n");
+		strbuf_reset(&sb);
+
+		strbuf_addf(&sb, "%s/refs", sb_repo.buf);
+		safe_create_dir(sb.buf, 1);
+		strbuf_reset(&sb);
+
+		strbuf_addf(&sb, "%s/refs/heads", sb_repo.buf);
+		write_file(sb.buf, "this repository uses the reftable format");
+		strbuf_reset(&sb);
+
+		strbuf_addf(&sb, "%s/reftable", sb_repo.buf);
+		safe_create_dir(sb.buf, 1);
+		strbuf_reset(&sb);
+	} else {
+		strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
+		write_file(sb.buf, "%s", oid_to_hex(null_oid()));
+		strbuf_reset(&sb);
+	}
+
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
 
diff --git a/cache.h b/cache.h
index 7cc7b29e6ec..c63d2152232 100644
--- a/cache.h
+++ b/cache.h
@@ -653,9 +653,10 @@ int path_inside_repo(const char *prefix, const char *path);
 #define INIT_DB_EXIST_OK 0x0002
 
 int init_db(const char *git_dir, const char *real_git_dir,
-	    const char *template_dir, int hash_algo,
-	    const char *initial_branch, unsigned int flags);
-void initialize_repository_version(int hash_algo, int reinit);
+	    const char *template_dir, int hash_algo, const char *initial_branch,
+	    const char *ref_storage_format, unsigned int flags);
+void initialize_repository_version(int hash_algo, int reinit,
+				   const char *ref_storage_format);
 
 void sanitize_stdfds(void);
 int daemonize(void);
@@ -1076,6 +1077,7 @@ struct repository_format {
 	int hash_algo;
 	int sparse_index;
 	char *work_tree;
+	char *ref_storage;
 	struct string_list unknown_extensions;
 	struct string_list v1_only_extensions;
 };
diff --git a/config.mak.uname b/config.mak.uname
index 501970902da..dae90ae515f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -749,7 +749,7 @@ vcxproj:
 	# Make .vcxproj files and add them
 	unset QUIET_GEN QUIET_BUILT_IN; \
 	perl contrib/buildsystems/generate -g Vcxproj
-	git add -f git.sln {*,*/lib,t/helper/*}/*.vcxproj
+	git add -f git.sln {*,*/lib,*/libreftable,t/helper/*}/*.vcxproj
 
 	# Generate the LinkOrCopyBuiltins.targets and LinkOrCopyRemoteHttp.targets file
 	(echo '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">' && \
diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 888c34a5215..989197aace0 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -79,7 +79,7 @@ trap cleanup $siglist
 # create the links to the original repo.  explicitly exclude index, HEAD and
 # logs/HEAD from the list since they are purely related to the current working
 # directory, and should not be shared.
-for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn
+for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn reftable
 do
 	# create a containing directory if needed
 	case $x in
diff --git a/refs.c b/refs.c
index d680de3bc04..ed900148d1c 100644
--- a/refs.c
+++ b/refs.c
@@ -20,10 +20,15 @@
 #include "repository.h"
 #include "sigchain.h"
 
+const char *default_ref_storage(void)
+{
+	return git_env_bool("GIT_TEST_REFTABLE", 0) ? "reftable" : "files";
+}
+
 /*
  * List of all available backends
  */
-static struct ref_storage_be *refs_backends = &refs_be_files;
+static struct ref_storage_be *refs_backends = &refs_be_reftable;
 
 static struct ref_storage_be *find_ref_storage_backend(const char *name)
 {
@@ -1860,13 +1865,13 @@ static struct ref_store *lookup_ref_store_map(struct hashmap *map,
  * gitdir.
  */
 static struct ref_store *ref_store_init(struct repository *repo,
-					const char *gitdir,
+					const char *gitdir, const char *be_name,
 					unsigned int flags)
 {
-	const char *be_name = "files";
-	struct ref_storage_be *be = find_ref_storage_backend(be_name);
+	struct ref_storage_be *be;
 	struct ref_store *refs;
 
+	be = find_ref_storage_backend(be_name);
 	if (!be)
 		BUG("reference backend %s is unknown", be_name);
 
@@ -1882,7 +1887,11 @@ struct ref_store *get_main_ref_store(struct repository *r)
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs_private = ref_store_init(r, r->gitdir, REF_STORE_ALL_CAPS);
+	r->refs_private = ref_store_init(r, r->gitdir,
+					 r->ref_storage_format ?
+						 r->ref_storage_format :
+						 default_ref_storage(),
+					 REF_STORE_ALL_CAPS);
 	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
 	return r->refs_private;
 }
@@ -1950,7 +1959,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		free(subrepo);
 		goto done;
 	}
-	refs = ref_store_init(subrepo, submodule_sb.buf,
+	refs = ref_store_init(subrepo, submodule_sb.buf, default_ref_storage(),
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&submodule_ref_stores, "submodule",
 			       refs, submodule);
@@ -1964,6 +1973,7 @@ done:
 
 struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 {
+	const char *format = default_ref_storage();
 	struct ref_store *refs;
 	const char *id;
 
@@ -1978,11 +1988,10 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 	if (wt->id)
 		refs = ref_store_init(the_repository,
 				      git_common_path("worktrees/%s", wt->id),
-				      REF_STORE_ALL_CAPS);
+				      format, REF_STORE_ALL_CAPS);
 	else
-		refs = ref_store_init(the_repository,
-				      get_git_common_dir(),
-				      REF_STORE_ALL_CAPS);
+		refs = ref_store_init(the_repository, get_git_common_dir(),
+				      format, REF_STORE_ALL_CAPS);
 
 	if (refs)
 		register_ref_store_map(&worktree_ref_stores, "worktree",
diff --git a/refs.h b/refs.h
index ff859d59513..42a35621fa6 100644
--- a/refs.h
+++ b/refs.h
@@ -11,6 +11,9 @@ struct string_list;
 struct string_list_item;
 struct worktree;
 
+/* Returns the ref storage backend to use by default. */
+const char *default_ref_storage(void);
+
 /*
  * Resolve a reference, recursively following symbolic refererences.
  *
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 6e15db3ca4e..012820f7b41 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -679,6 +679,7 @@ struct ref_storage_be {
 };
 
 extern struct ref_storage_be refs_be_files;
+extern struct ref_storage_be refs_be_reftable;
 extern struct ref_storage_be refs_be_packed;
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
new file mode 100644
index 00000000000..81bfc522338
--- /dev/null
+++ b/refs/reftable-backend.c
@@ -0,0 +1,1898 @@
+#include "../cache.h"
+#include "../chdir-notify.h"
+#include "../config.h"
+#include "../iterator.h"
+#include "../lockfile.h"
+#include "../object.h"
+#include "../refs.h"
+#include "../reftable/reftable-stack.h"
+#include "../reftable/reftable-record.h"
+#include "../reftable/reftable-error.h"
+#include "../reftable/reftable-blocksource.h"
+#include "../reftable/reftable-reader.h"
+#include "../reftable/reftable-iterator.h"
+#include "../reftable/reftable-merged.h"
+#include "../reftable/reftable-generic.h"
+#include "../worktree.h"
+#include "refs-internal.h"
+
+extern struct ref_storage_be refs_be_reftable;
+
+struct git_reftable_ref_store {
+	struct ref_store base;
+	unsigned int store_flags;
+
+	int err;
+	char *repo_dir;
+	char *reftable_dir;
+
+	struct reftable_stack *main_stack;
+	struct reftable_stack *worktree_stack;
+
+	struct reftable_write_options write_options;
+};
+
+/*
+ * Some refs are global to the repository (refs/heads/{*}), while others are
+ * local to the worktree (eg. HEAD, refs/bisect/{*}). We solve this by having
+ * two separate databases (ie. two reftable/ directories), one for the
+ * repository, and one for the worktree. For reading, we merge the view (see
+ * git_reftable_iterator) of both, when necessary.
+ *
+ * Unfortunately, the worktrees can also be selected by specifying a magic
+ * refname (eg. worktree/BLA/refname, even if BLA isn't the current worktree.)
+ */
+static struct reftable_stack *stack_for(struct git_reftable_ref_store *store,
+					const char *refname)
+{
+	const char *wtname = refname;
+	int wtname_len = 0;
+	const char *wtref = refname;
+
+	if (refname == NULL)
+		return store->main_stack;
+
+	if (!parse_worktree_ref(refname, &wtname, &wtname_len, &wtref) &&
+	    wtname_len) {
+		/* Woe you if you try to access worktree/BLA/REF and the current
+		 * worktree from the same process.
+		 */
+		struct strbuf wt_dir = STRBUF_INIT;
+
+		strbuf_addstr(&wt_dir, store->base.gitdir);
+		strbuf_addstr(&wt_dir, "/worktrees/");
+		strbuf_add(&wt_dir, wtname, wtname_len);
+		strbuf_addstr(&wt_dir, "/reftable");
+
+		if (store->worktree_stack)
+			reftable_stack_destroy(store->worktree_stack);
+		store->err = reftable_new_stack(&store->worktree_stack,
+						wt_dir.buf,
+						store->write_options);
+		assert(store->err != REFTABLE_API_ERROR);
+
+		return store->worktree_stack;
+	}
+
+	if (store->worktree_stack == NULL)
+		return store->main_stack;
+
+	switch (ref_type(refname)) {
+	case REF_TYPE_PER_WORKTREE:
+	case REF_TYPE_PSEUDOREF:
+	case REF_TYPE_OTHER_PSEUDOREF:
+		return store->worktree_stack;
+	default:
+	case REF_TYPE_MAIN_PSEUDOREF:
+	case REF_TYPE_NORMAL:
+		return store->main_stack;
+	}
+}
+
+static int should_log(const char *refname)
+{
+	return log_all_ref_updates != LOG_REFS_NONE &&
+	       (log_all_ref_updates == LOG_REFS_ALWAYS ||
+		log_all_ref_updates == LOG_REFS_UNSET ||
+		should_autocreate_reflog(refname));
+}
+
+static const char *bare_ref_name(const char *ref)
+{
+	const char *out = ref;
+	int name_len = 0;
+	if (skip_prefix(ref, "main-worktree/", &out))
+		return out;
+
+	if (!parse_worktree_ref(ref, NULL, &name_len, &out) && name_len) {
+		return out;
+	}
+
+	return ref;
+}
+
+static int git_reftable_read_raw_ref(struct ref_store *ref_store,
+				     const char *refname, struct object_id *oid,
+				     struct strbuf *referent,
+				     unsigned int *type, int *failure_errno);
+
+static void clear_reftable_log_record(struct reftable_log_record *log)
+{
+	switch (log->value_type) {
+	case REFTABLE_LOG_UPDATE:
+		/* when we write log records, the hashes are owned by a struct
+		 * oid */
+		log->value.update.old_hash = NULL;
+		log->value.update.new_hash = NULL;
+		break;
+	case REFTABLE_LOG_DELETION:
+		break;
+	}
+	reftable_log_record_release(log);
+}
+
+static void fill_reftable_log_record(struct reftable_log_record *log)
+{
+	const char *info = git_committer_info(0);
+	struct ident_split split = { NULL };
+	int result = split_ident_line(&split, info, strlen(info));
+	int sign = 1;
+	assert(0 == result);
+
+	reftable_log_record_release(log);
+	log->value_type = REFTABLE_LOG_UPDATE;
+	log->value.update.name =
+		xstrndup(split.name_begin, split.name_end - split.name_begin);
+	log->value.update.email =
+		xstrndup(split.mail_begin, split.mail_end - split.mail_begin);
+	log->value.update.time = atol(split.date_begin);
+	if (*split.tz_begin == '-') {
+		sign = -1;
+		split.tz_begin++;
+	}
+	if (*split.tz_begin == '+') {
+		sign = 1;
+		split.tz_begin++;
+	}
+
+	log->value.update.tz_offset = sign * atoi(split.tz_begin);
+}
+
+static int has_suffix(struct strbuf *b, const char *suffix)
+{
+	size_t len = strlen(suffix);
+
+	if (len > b->len) {
+		return 0;
+	}
+
+	return 0 == strncmp(b->buf + b->len - len, suffix, len);
+}
+
+/* trims the last path component of b. Returns -1 if it is not
+ * present, or 0 on success
+ */
+static int trim_component(struct strbuf *b)
+{
+	char *last;
+	last = strrchr(b->buf, '/');
+	if (!last)
+		return -1;
+	strbuf_setlen(b, last - b->buf);
+	return 0;
+}
+
+/* Returns whether `b` is a worktree path. Mutates its arg, trimming it to the
+ * gitdir
+ */
+static int is_worktree(struct strbuf *b)
+{
+	if (trim_component(b) < 0) {
+		return 0;
+	}
+	if (!has_suffix(b, "/worktrees")) {
+		return 0;
+	}
+	trim_component(b);
+	return 1;
+}
+
+static struct ref_store *git_reftable_ref_store_create(struct repository *repo,
+						       const char *path,
+						       unsigned int store_flags)
+{
+	struct git_reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
+	struct ref_store *ref_store = (struct ref_store *)refs;
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf gitdir = STRBUF_INIT;
+	struct strbuf wt_buf = STRBUF_INIT;
+	int wt = 0;
+	int shared = get_shared_repository();
+	if (shared < 0)
+		shared = -shared;
+
+	refs->write_options.block_size = 4096;
+	refs->write_options.hash_id = the_hash_algo->format_id;
+	if (shared && (shared & 0600))
+		refs->write_options.default_permissions = shared;
+
+	strbuf_realpath(&wt_buf, path, /*die_on_error=*/0);
+
+	/* this is clumsy, but the official worktree functions (eg.
+	 * get_worktrees()) function will try to initialize a ref storage
+	 * backend, leading to infinite recursion.  */
+	wt = is_worktree(&wt_buf);
+	if (wt) {
+		strbuf_addbuf(&gitdir, &wt_buf);
+	} else {
+		strbuf_realpath(&gitdir, path, /*die_on_error=*/0);
+	}
+
+	/* XXX should this use `path` or `gitdir.buf` ? */
+	base_ref_store_init(ref_store, repo, path, &refs_be_reftable);
+	refs->store_flags = store_flags;
+	strbuf_addf(&sb, "%s/reftable", gitdir.buf);
+	refs->reftable_dir = xstrdup(sb.buf);
+	refs->base.repo = repo;
+	strbuf_reset(&sb);
+
+	refs->err = reftable_new_stack(&refs->main_stack, refs->reftable_dir,
+				       refs->write_options);
+	assert(refs->err != REFTABLE_API_ERROR);
+
+	if (refs->err == 0 && wt) {
+		strbuf_addf(&sb, "%s/reftable", path);
+
+		refs->err = reftable_new_stack(&refs->worktree_stack, sb.buf,
+					       refs->write_options);
+		assert(refs->err != REFTABLE_API_ERROR);
+	}
+
+	strbuf_release(&sb);
+	strbuf_release(&wt_buf);
+	strbuf_release(&gitdir);
+	return ref_store;
+}
+
+static int git_reftable_init_db(struct ref_store *ref_store, struct strbuf *err)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct strbuf sb = STRBUF_INIT;
+
+	safe_create_dir(refs->reftable_dir, 1);
+
+	strbuf_addf(&sb, "%s/HEAD", refs->base.gitdir);
+	write_file(sb.buf, "ref: refs/heads/.invalid");
+	adjust_shared_perm(sb.buf);
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
+	safe_create_dir(sb.buf, 1);
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/refs/heads", refs->base.gitdir);
+	write_file(sb.buf, "this repository uses the reftable format");
+	adjust_shared_perm(sb.buf);
+
+	strbuf_release(&sb);
+	return 0;
+}
+
+struct git_reftable_iterator {
+	struct ref_iterator base;
+	struct reftable_iterator iter;
+	struct reftable_ref_record ref;
+	struct object_id oid;
+	struct ref_store *ref_store;
+
+	/* In case we must iterate over 2 stacks, this is non-null. */
+	struct reftable_merged_table *merged;
+	unsigned int flags;
+	int err;
+	const char *prefix;
+};
+
+static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct git_reftable_iterator *ri =
+		(struct git_reftable_iterator *)ref_iterator;
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ri->ref_store;
+
+	while (ri->err == 0) {
+		int signed_flags = 0;
+		ri->err = reftable_iterator_next_ref(&ri->iter, &ri->ref);
+		if (ri->err) {
+			break;
+		}
+
+		ri->base.flags = 0;
+
+		if (ref_type(ri->ref.refname) == REF_TYPE_PSEUDOREF) {
+			/*
+			  pseudorefs, eg. HEAD, FETCH_HEAD should not be
+			  produced, by default.
+			 */
+			continue;
+		}
+		ri->base.refname = ri->ref.refname;
+		if (ri->prefix != NULL &&
+		    strncmp(ri->prefix, ri->ref.refname, strlen(ri->prefix))) {
+			ri->err = 1;
+			break;
+		}
+		if (ri->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+		    ref_type(ri->base.refname) != REF_TYPE_PER_WORKTREE)
+			continue;
+
+		if (ri->flags & DO_FOR_EACH_INCLUDE_BROKEN &&
+		    check_refname_format(ri->base.refname,
+					 REFNAME_ALLOW_ONELEVEL)) {
+			/* This is odd, as REF_BAD_NAME and REF_ISBROKEN are
+			   orthogonal, but it's what the spec says and the
+			   files-backend does. */
+			ri->base.flags |= REF_BAD_NAME | REF_ISBROKEN;
+			break;
+		}
+
+		switch (ri->ref.value_type) {
+		case REFTABLE_REF_VAL1:
+			oidread(&ri->oid, ri->ref.value.val1);
+			break;
+		case REFTABLE_REF_VAL2:
+			oidread(&ri->oid, ri->ref.value.val2.value);
+			break;
+		case REFTABLE_REF_SYMREF:
+			ri->base.flags = REF_ISSYMREF;
+			break;
+		default:
+			abort();
+		}
+
+		ri->base.oid = &ri->oid;
+		if (!(ri->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+		    !ref_resolves_to_object(ri->base.refname, refs->base.repo,
+					    ri->base.oid, ri->base.flags)) {
+			continue;
+		}
+
+		/* Arguably, resolving recursively following symlinks should be
+		 * lifted to refs.c because it is shared between reftable and
+		 * the files backend, but it's here now.
+		 */
+		if (!refs_resolve_ref_unsafe(ri->ref_store, ri->ref.refname,
+					     RESOLVE_REF_READING, &ri->oid,
+					     &signed_flags)) {
+			ri->base.flags = signed_flags;
+			if (ri->ref.value_type == REFTABLE_REF_SYMREF &&
+			    ri->flags & DO_FOR_EACH_OMIT_DANGLING_SYMREFS)
+				continue;
+
+			if (ri->ref.value_type == REFTABLE_REF_SYMREF &&
+			    !(ri->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+			    (ri->base.flags & REF_ISBROKEN)) {
+				continue;
+			}
+
+			if (is_null_oid(&ri->oid)) {
+				oidclr(&ri->oid);
+				ri->base.flags |= REF_ISBROKEN;
+			}
+		}
+		break;
+	}
+
+	if (ri->err > 0) {
+		return ITER_DONE;
+	}
+	if (ri->err < 0) {
+		return ITER_ERROR;
+	}
+
+	return ITER_OK;
+}
+
+static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				      struct object_id *peeled)
+{
+	struct git_reftable_iterator *ri =
+		(struct git_reftable_iterator *)ref_iterator;
+	if (ri->ref.value_type == REFTABLE_REF_VAL2) {
+		oidread(peeled, ri->ref.value.val2.target_value);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int reftable_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct git_reftable_iterator *ri =
+		(struct git_reftable_iterator *)ref_iterator;
+	reftable_ref_record_release(&ri->ref);
+	reftable_iterator_destroy(&ri->iter);
+	if (ri->merged) {
+		reftable_merged_table_free(ri->merged);
+	}
+	return 0;
+}
+
+static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
+	reftable_ref_iterator_advance, reftable_ref_iterator_peel,
+	reftable_ref_iterator_abort
+};
+
+static struct ref_iterator *
+git_reftable_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
+				unsigned int flags)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct git_reftable_iterator *ri = xcalloc(1, sizeof(*ri));
+
+	if (refs->err < 0) {
+		ri->err = refs->err;
+	} else if (refs->worktree_stack == NULL) {
+		struct reftable_merged_table *mt =
+			reftable_stack_merged_table(refs->main_stack);
+		ri->err = reftable_merged_table_seek_ref(mt, &ri->iter, prefix);
+	} else {
+		struct reftable_merged_table *mt1 =
+			reftable_stack_merged_table(refs->main_stack);
+		struct reftable_merged_table *mt2 =
+			reftable_stack_merged_table(refs->worktree_stack);
+		struct reftable_table *tabs =
+			xcalloc(2, sizeof(struct reftable_table));
+		reftable_table_from_merged_table(&tabs[0], mt1);
+		reftable_table_from_merged_table(&tabs[1], mt2);
+
+		/* XXX this isn't correct. This will merge reftables, which
+		 * gives precedence to the most recently updated refs. We should
+		 * give precedence to refs from the worktree / main stack
+		 * depending on where we are
+		 */
+		ri->err = reftable_new_merged_table(&ri->merged, tabs, 2,
+						    the_hash_algo->format_id);
+		if (ri->err == 0)
+			ri->err = reftable_merged_table_seek_ref(
+				ri->merged, &ri->iter, prefix);
+	}
+
+	base_ref_iterator_init(&ri->base, &reftable_ref_iterator_vtable, 1);
+	ri->prefix = prefix;
+	ri->base.oid = &ri->oid;
+	ri->flags = flags;
+	ri->ref_store = ref_store;
+	return &ri->base;
+}
+
+static int fixup_symrefs(struct ref_store *ref_store,
+			 struct ref_transaction *transaction)
+{
+	struct strbuf referent = STRBUF_INIT;
+	int i = 0;
+	int err = 0;
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		struct object_id old_oid;
+		int failure_errno;
+
+		err = git_reftable_read_raw_ref(ref_store, update->refname,
+						&old_oid, &referent,
+						/* mutate input, like
+						   files-backend.c */
+						&update->type, &failure_errno);
+		if (err < 0 && failure_errno == ENOENT &&
+		    is_null_oid(&update->old_oid)) {
+			err = 0;
+		}
+		if (err < 0)
+			goto done;
+
+		if (!(update->type & REF_ISSYMREF))
+			continue;
+
+		if (update->flags & REF_NO_DEREF) {
+			/* what should happen here? See files-backend.c
+			 * lock_ref_for_update. */
+		} else {
+			/*
+			  If we are updating a symref (eg. HEAD), we should also
+			  update the branch that the symref points to.
+
+			  This is generic functionality, and would be better
+			  done in refs.c, but the current implementation is
+			  intertwined with the locking in files-backend.c.
+			*/
+			int new_flags = update->flags;
+			struct ref_update *new_update = NULL;
+
+			/* if this is an update for HEAD, should also record a
+			   log entry for HEAD? See files-backend.c,
+			   split_head_update()
+			*/
+			new_update = ref_transaction_add_update(
+				transaction, referent.buf, new_flags,
+				&update->new_oid, &update->old_oid,
+				update->msg);
+			new_update->parent_update = update;
+
+			/* files-backend sets REF_LOG_ONLY here. */
+			update->flags |= REF_NO_DEREF | REF_LOG_ONLY;
+			update->flags &= ~REF_HAVE_OLD;
+		}
+	}
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	strbuf_release(&referent);
+	return err;
+}
+
+static int git_reftable_transaction_prepare(struct ref_store *ref_store,
+					    struct ref_transaction *transaction,
+					    struct strbuf *errbuf)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_addition *add = NULL;
+	struct reftable_stack *stack = stack_for(
+		refs,
+		transaction->nr ? transaction->updates[0]->refname : NULL);
+	int i;
+
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	err = reftable_stack_new_addition(&add, stack);
+	if (err) {
+		goto done;
+	}
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = transaction->updates[i];
+		if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
+		    !(u->flags & REF_SKIP_OID_VERIFICATION) &&
+		    !(u->flags & REF_LOG_ONLY)) {
+			struct object *o =
+				parse_object(refs->base.repo, &u->new_oid);
+			if (!o) {
+				strbuf_addf(
+					errbuf,
+					"trying to write ref '%s' with nonexistent object %s",
+					u->refname, oid_to_hex(&u->new_oid));
+				err = -1;
+				goto done;
+			}
+		}
+	}
+
+	err = fixup_symrefs(ref_store, transaction);
+	if (err) {
+		goto done;
+	}
+
+	transaction->backend_data = add;
+	transaction->state = REF_TRANSACTION_PREPARED;
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	if (err < 0) {
+		if (add) {
+			reftable_addition_destroy(add);
+			add = NULL;
+		}
+		transaction->state = REF_TRANSACTION_CLOSED;
+		if (!errbuf->len)
+			strbuf_addf(errbuf, "reftable: transaction prepare: %s",
+				    reftable_error_str(err));
+	}
+
+	return err;
+}
+
+static int git_reftable_transaction_abort(struct ref_store *ref_store,
+					  struct ref_transaction *transaction,
+					  struct strbuf *err)
+{
+	struct reftable_addition *add =
+		(struct reftable_addition *)transaction->backend_data;
+	reftable_addition_destroy(add);
+	transaction->backend_data = NULL;
+
+	/* XXX. Shouldn't this be handled generically in refs.c? */
+	transaction->state = REF_TRANSACTION_CLOSED;
+	return 0;
+}
+
+static int reftable_check_old_oid(struct ref_store *refs, const char *refname,
+				  struct object_id *want_oid)
+{
+	struct object_id out_oid;
+	int out_flags = 0;
+	const char *resolved = refs_resolve_ref_unsafe(
+		refs, refname, RESOLVE_REF_READING, &out_oid, &out_flags);
+	if (is_null_oid(want_oid) != (resolved == NULL)) {
+		return REFTABLE_LOCK_ERROR;
+	}
+
+	if (resolved != NULL && !oideq(&out_oid, want_oid)) {
+		return REFTABLE_LOCK_ERROR;
+	}
+
+	return 0;
+}
+
+static int ref_update_cmp(const void *a, const void *b)
+{
+	return strcmp((*(struct ref_update **)a)->refname,
+		      (*(struct ref_update **)b)->refname);
+}
+
+static int write_transaction_table(struct reftable_writer *writer, void *arg)
+{
+	struct ref_transaction *transaction = (struct ref_transaction *)arg;
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)transaction->ref_store;
+	struct reftable_stack *stack =
+		stack_for(refs, transaction->updates[0]->refname);
+	uint64_t ts = reftable_stack_next_update_index(stack);
+	int err = 0;
+	int i = 0;
+	int log_count = 0;
+	struct reftable_log_record *logs =
+		calloc(transaction->nr, sizeof(*logs));
+	struct ref_update **sorted =
+		malloc(transaction->nr * sizeof(struct ref_update *));
+	struct reftable_merged_table *mt = reftable_stack_merged_table(stack);
+	struct reftable_table tab = { NULL };
+	struct reftable_ref_record ref = { NULL };
+	reftable_table_from_merged_table(&tab, mt);
+	COPY_ARRAY(sorted, transaction->updates, transaction->nr);
+	QSORT(sorted, transaction->nr, ref_update_cmp);
+	reftable_writer_set_limits(writer, ts, ts);
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = sorted[i];
+		struct reftable_log_record *log = &logs[log_count];
+		struct object_id old_id = *null_oid();
+
+		log->value.update.new_hash = NULL;
+		log->value.update.old_hash = NULL;
+		if ((u->flags & REF_FORCE_CREATE_REFLOG) ||
+		    should_log(u->refname))
+			log_count++;
+		fill_reftable_log_record(log);
+
+		log->update_index = ts;
+		log->value_type = REFTABLE_LOG_UPDATE;
+		log->refname = xstrdup(u->refname);
+		log->value.update.new_hash = u->new_oid.hash;
+		log->value.update.message =
+			xstrndup(u->msg, refs->write_options.block_size / 2);
+
+		err = reftable_table_read_ref(&tab, u->refname, &ref);
+		if (err < 0)
+			goto done;
+		else if (err > 0) {
+			err = 0;
+		}
+
+		/* XXX if this is a symref (say, HEAD), should we deref the
+		 * symref and check the update.old_hash against the referent? */
+		if (ref.value_type == REFTABLE_REF_VAL2 ||
+		    ref.value_type == REFTABLE_REF_VAL1)
+			oidread(&old_id, ref.value.val1);
+
+		/* XXX fold together with the old_id check below? */
+		log->value.update.old_hash = old_id.hash;
+		if (u->flags & REF_LOG_ONLY) {
+			continue;
+		}
+
+		if (u->flags & REF_HAVE_NEW) {
+			struct reftable_ref_record ref = { NULL };
+			struct object_id peeled;
+
+			int peel_error = peel_object(&u->new_oid, &peeled);
+			ref.refname = (char *)u->refname;
+			ref.update_index = ts;
+
+			if (!peel_error) {
+				ref.value_type = REFTABLE_REF_VAL2;
+				ref.value.val2.target_value = peeled.hash;
+				ref.value.val2.value = u->new_oid.hash;
+			} else if (!is_null_oid(&u->new_oid)) {
+				ref.value_type = REFTABLE_REF_VAL1;
+				ref.value.val1 = u->new_oid.hash;
+			}
+
+			err = reftable_writer_add_ref(writer, &ref);
+			if (err < 0) {
+				goto done;
+			}
+		}
+	}
+
+	for (i = 0; i < log_count; i++) {
+		err = reftable_writer_add_log(writer, &logs[i]);
+		logs[i].value.update.new_hash = NULL;
+		logs[i].value.update.old_hash = NULL;
+		clear_reftable_log_record(&logs[i]);
+		if (err < 0) {
+			goto done;
+		}
+	}
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_ref_record_release(&ref);
+	free(logs);
+	free(sorted);
+	return err;
+}
+
+static int git_reftable_transaction_finish(struct ref_store *ref_store,
+					   struct ref_transaction *transaction,
+					   struct strbuf *errmsg)
+{
+	struct reftable_addition *add =
+		(struct reftable_addition *)transaction->backend_data;
+	int err = 0;
+	int i;
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = transaction->updates[i];
+		if (u->flags & REF_HAVE_OLD) {
+			err = reftable_check_old_oid(transaction->ref_store,
+						     u->refname, &u->old_oid);
+			if (err < 0) {
+				goto done;
+			}
+		}
+	}
+	if (transaction->nr) {
+		err = reftable_addition_add(add, &write_transaction_table,
+					    transaction);
+		if (err < 0) {
+			goto done;
+		}
+	}
+
+	err = reftable_addition_commit(add);
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_addition_destroy(add);
+	transaction->state = REF_TRANSACTION_CLOSED;
+	transaction->backend_data = NULL;
+	if (err) {
+		strbuf_addf(errmsg, "reftable: transaction failure: %s",
+			    reftable_error_str(err));
+		return -1;
+	}
+	return err;
+}
+
+static int
+git_reftable_transaction_initial_commit(struct ref_store *ref_store,
+					struct ref_transaction *transaction,
+					struct strbuf *errmsg)
+{
+	int err = git_reftable_transaction_prepare(ref_store, transaction,
+						   errmsg);
+	if (err)
+		return err;
+
+	return git_reftable_transaction_finish(ref_store, transaction, errmsg);
+}
+
+struct write_delete_refs_arg {
+	struct git_reftable_ref_store *refs;
+	struct reftable_stack *stack;
+	struct string_list *refnames;
+	const char *logmsg;
+	unsigned int flags;
+};
+
+static int write_delete_refs_table(struct reftable_writer *writer, void *argv)
+{
+	struct write_delete_refs_arg *arg =
+		(struct write_delete_refs_arg *)argv;
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	int err = 0;
+	int i = 0;
+
+	reftable_writer_set_limits(writer, ts, ts);
+	for (i = 0; i < arg->refnames->nr; i++) {
+		struct reftable_ref_record ref = {
+			.refname = (char *)arg->refnames->items[i].string,
+			.value_type = REFTABLE_REF_DELETION,
+			.update_index = ts,
+		};
+		err = reftable_writer_add_ref(writer, &ref);
+		if (err < 0) {
+			return err;
+		}
+	}
+
+	for (i = 0; i < arg->refnames->nr; i++) {
+		struct reftable_log_record log = {
+			.update_index = ts,
+		};
+		struct reftable_ref_record current = { NULL };
+		fill_reftable_log_record(&log);
+		log.update_index = ts;
+		log.refname = xstrdup(arg->refnames->items[i].string);
+		if (!should_log(log.refname)) {
+			continue;
+		}
+		log.value.update.message = xstrndup(
+			arg->logmsg, arg->refs->write_options.block_size / 2);
+		log.value.update.new_hash = NULL;
+		log.value.update.old_hash = NULL;
+		if (reftable_stack_read_ref(arg->stack, log.refname,
+					    &current) == 0) {
+			log.value.update.old_hash =
+				reftable_ref_record_val1(&current);
+		}
+		err = reftable_writer_add_log(writer, &log);
+		log.value.update.old_hash = NULL;
+		reftable_ref_record_release(&current);
+
+		clear_reftable_log_record(&log);
+		if (err < 0) {
+			return err;
+		}
+	}
+	return 0;
+}
+
+static int git_reftable_delete_refs(struct ref_store *ref_store,
+				    const char *msg,
+				    struct string_list *refnames,
+				    unsigned int flags)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(
+		refs, refnames->nr ? refnames->items[0].string : NULL);
+	struct write_delete_refs_arg arg = {
+		.refs = refs,
+		.stack = stack,
+		.refnames = refnames,
+		.logmsg = msg,
+		.flags = flags,
+	};
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+
+	string_list_sort(refnames);
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+	err = reftable_stack_add(stack, &write_delete_refs_table, &arg);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+static int git_reftable_pack_refs(struct ref_store *ref_store,
+				  unsigned int flags)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	int err = refs->err;
+	if (err < 0) {
+		return err;
+	}
+	err = reftable_stack_compact_all(refs->main_stack, NULL);
+	if (err == 0 && refs->worktree_stack != NULL)
+		err = reftable_stack_compact_all(refs->worktree_stack, NULL);
+	if (err == 0)
+		err = reftable_stack_clean(refs->main_stack);
+	if (err == 0 && refs->worktree_stack != NULL)
+		err = reftable_stack_clean(refs->worktree_stack);
+
+	return err;
+}
+
+struct write_create_symref_arg {
+	struct git_reftable_ref_store *refs;
+	struct reftable_stack *stack;
+	const char *refname;
+	const char *target;
+	const char *logmsg;
+};
+
+static int write_create_symref_table(struct reftable_writer *writer, void *arg)
+{
+	struct write_create_symref_arg *create =
+		(struct write_create_symref_arg *)arg;
+	uint64_t ts = reftable_stack_next_update_index(create->stack);
+	int err = 0;
+
+	struct reftable_ref_record ref = {
+		.refname = (char *)create->refname,
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = (char *)create->target,
+		.update_index = ts,
+	};
+	reftable_writer_set_limits(writer, ts, ts);
+	err = reftable_writer_add_ref(writer, &ref);
+	if (err == 0) {
+		struct reftable_log_record log = { NULL };
+		struct object_id new_oid;
+		struct object_id old_oid;
+
+		fill_reftable_log_record(&log);
+		log.refname = xstrdup(create->refname);
+		if (!should_log(log.refname)) {
+			return err;
+		}
+		log.update_index = ts;
+		log.value.update.message =
+			xstrndup(create->logmsg,
+				 create->refs->write_options.block_size / 2);
+		if (refs_resolve_ref_unsafe(
+			    (struct ref_store *)create->refs, create->refname,
+			    RESOLVE_REF_READING, &old_oid, NULL) != NULL) {
+			log.value.update.old_hash = old_oid.hash;
+		}
+
+		if (refs_resolve_ref_unsafe((struct ref_store *)create->refs,
+					    create->target, RESOLVE_REF_READING,
+					    &new_oid, NULL) != NULL) {
+			log.value.update.new_hash = new_oid.hash;
+		}
+
+		if (log.value.update.old_hash != NULL ||
+		    log.value.update.new_hash != NULL) {
+			err = reftable_writer_add_log(writer, &log);
+		}
+		log.refname = NULL;
+		log.value.update.message = NULL;
+		log.value.update.old_hash = NULL;
+		log.value.update.new_hash = NULL;
+		clear_reftable_log_record(&log);
+	}
+	return err;
+}
+
+static int git_reftable_create_symref(struct ref_store *ref_store,
+				      const char *refname, const char *target,
+				      const char *logmsg)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct write_create_symref_arg arg = { .refs = refs,
+					       .stack = stack,
+					       .refname = refname,
+					       .target = target,
+					       .logmsg = logmsg };
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+	err = reftable_stack_add(stack, &write_create_symref_table, &arg);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+struct write_rename_arg {
+	struct git_reftable_ref_store *refs;
+	struct reftable_stack *stack;
+	const char *oldname;
+	const char *newname;
+	const char *logmsg;
+};
+
+static int write_rename_table(struct reftable_writer *writer, void *argv)
+{
+	struct write_rename_arg *arg = (struct write_rename_arg *)argv;
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	struct reftable_ref_record old_ref = { NULL };
+	struct reftable_ref_record new_ref = { NULL };
+	int err = reftable_stack_read_ref(arg->stack, arg->oldname, &old_ref);
+	struct reftable_ref_record todo[2] = {
+		{
+			.refname = (char *)arg->oldname,
+			.update_index = ts,
+			.value_type = REFTABLE_REF_DELETION,
+		},
+		old_ref,
+	};
+
+	if (err) {
+		goto done;
+	}
+
+	/* git-branch supports a --force, but the check is not atomic. */
+	if (!reftable_stack_read_ref(arg->stack, arg->newname, &new_ref)) {
+		goto done;
+	}
+
+	reftable_writer_set_limits(writer, ts, ts);
+
+	todo[1].update_index = ts;
+	todo[1].refname = (char *)arg->newname;
+
+	err = reftable_writer_add_refs(writer, todo, 2);
+	if (err < 0) {
+		goto done;
+	}
+
+	if (reftable_ref_record_val1(&old_ref)) {
+		uint8_t *val1 = reftable_ref_record_val1(&old_ref);
+		struct reftable_log_record todo[2] = { { NULL } };
+		int firstlog = 0;
+		int lastlog = 2;
+		char *msg = xstrndup(arg->logmsg,
+				     arg->refs->write_options.block_size / 2);
+		fill_reftable_log_record(&todo[0]);
+		fill_reftable_log_record(&todo[1]);
+
+		todo[0].refname = xstrdup(arg->oldname);
+		todo[0].update_index = ts;
+		todo[0].value.update.message = msg;
+		todo[0].value.update.old_hash = val1;
+		todo[0].value.update.new_hash = NULL;
+
+		todo[1].refname = xstrdup(arg->newname);
+		todo[1].update_index = ts;
+		todo[1].value.update.old_hash = NULL;
+		todo[1].value.update.new_hash = val1;
+		todo[1].value.update.message = xstrdup(msg);
+
+		if (!should_log(todo[1].refname)) {
+			lastlog--;
+		}
+		if (!should_log(todo[0].refname)) {
+			firstlog++;
+		}
+		err = reftable_writer_add_logs(writer, &todo[firstlog],
+					       lastlog - firstlog);
+
+		clear_reftable_log_record(&todo[0]);
+		clear_reftable_log_record(&todo[1]);
+		if (err < 0) {
+			goto done;
+		}
+
+	} else {
+		/* XXX what should we write into the reflog if we rename a
+		 * symref? */
+	}
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_ref_record_release(&new_ref);
+	reftable_ref_record_release(&old_ref);
+	return err;
+}
+
+static int write_copy_table(struct reftable_writer *writer, void *argv)
+{
+	struct write_rename_arg *arg = (struct write_rename_arg *)argv;
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	struct reftable_ref_record old_ref = { NULL };
+	struct reftable_ref_record new_ref = { NULL };
+	struct reftable_log_record log = { NULL };
+	struct reftable_iterator it = { NULL };
+	int err = reftable_stack_read_ref(arg->stack, arg->oldname, &old_ref);
+	if (err) {
+		goto done;
+	}
+
+	/* git-branch supports a --force, but the check is not atomic. */
+	if (reftable_stack_read_ref(arg->stack, arg->newname, &new_ref) == 0) {
+		goto done;
+	}
+
+	reftable_writer_set_limits(writer, ts, ts);
+
+	FREE_AND_NULL(old_ref.refname);
+	old_ref.refname = xstrdup(arg->newname);
+	old_ref.update_index = ts;
+	err = reftable_writer_add_ref(writer, &old_ref);
+	if (err < 0) {
+		goto done;
+	}
+
+	/* XXX this copies the entire reflog history. Is this the right
+	 * semantics? should clear out existing reflog entries for oldname? */
+	if (!should_log(arg->newname))
+		goto done;
+
+	err = reftable_merged_table_seek_log(
+		reftable_stack_merged_table(arg->stack), &it, arg->oldname);
+	if (err < 0) {
+		goto done;
+	}
+	while (1) {
+		int err = reftable_iterator_next_log(&it, &log);
+		if (err < 0) {
+			goto done;
+		}
+
+		if (err > 0 || strcmp(log.refname, arg->oldname)) {
+			break;
+		}
+		FREE_AND_NULL(log.refname);
+		log.refname = xstrdup(arg->newname);
+		reftable_writer_add_log(writer, &log);
+		reftable_log_record_release(&log);
+	}
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_ref_record_release(&new_ref);
+	reftable_ref_record_release(&old_ref);
+	reftable_log_record_release(&log);
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+static int git_reftable_rename_ref(struct ref_store *ref_store,
+				   const char *oldrefname,
+				   const char *newrefname, const char *logmsg)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, newrefname);
+	struct write_rename_arg arg = {
+		.refs = refs,
+		.stack = stack,
+		.oldname = oldrefname,
+		.newname = newrefname,
+		.logmsg = logmsg,
+	};
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	err = reftable_stack_add(stack, &write_rename_table, &arg);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+static int git_reftable_copy_ref(struct ref_store *ref_store,
+				 const char *oldrefname, const char *newrefname,
+				 const char *logmsg)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, newrefname);
+	struct write_rename_arg arg = {
+		.refs = refs,
+		.stack = stack,
+		.oldname = oldrefname,
+		.newname = newrefname,
+		.logmsg = logmsg,
+	};
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	err = reftable_stack_add(stack, &write_copy_table, &arg);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+struct git_reftable_reflog_ref_iterator {
+	struct ref_iterator base;
+	struct reftable_iterator iter;
+	struct reftable_log_record log;
+	struct object_id oid;
+	struct git_reftable_ref_store *refs;
+
+	/* Used when iterating over worktree & main */
+	struct reftable_merged_table *merged;
+	char *last_name;
+};
+
+static int
+git_reftable_reflog_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct git_reftable_reflog_ref_iterator *ri =
+		(struct git_reftable_reflog_ref_iterator *)ref_iterator;
+
+	while (1) {
+		int flags = 0;
+		int err = reftable_iterator_next_log(&ri->iter, &ri->log);
+
+		if (err > 0) {
+			return ITER_DONE;
+		}
+		if (err < 0) {
+			return ITER_ERROR;
+		}
+
+		ri->base.refname = ri->log.refname;
+		if (ri->last_name != NULL &&
+		    !strcmp(ri->log.refname, ri->last_name)) {
+			/* we want the refnames that we have reflogs for, so we
+			 * skip if we've already produced this name. This could
+			 * be faster by seeking directly to
+			 * reflog@update_index==0.
+			 */
+			continue;
+		}
+
+		if (!refs_resolve_ref_unsafe(&ri->refs->base, ri->log.refname,
+					     0, &ri->oid, &flags)) {
+			error("bad ref for %s", ri->log.refname);
+			continue;
+		}
+
+		free(ri->last_name);
+		ri->last_name = xstrdup(ri->log.refname);
+		ri->base.oid = &ri->oid;
+		ri->base.flags = flags;
+		return ITER_OK;
+	}
+}
+
+static int
+git_reftable_reflog_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				      struct object_id *peeled)
+{
+	BUG("not supported.");
+	return -1;
+}
+
+static int
+git_reftable_reflog_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct git_reftable_reflog_ref_iterator *ri =
+		(struct git_reftable_reflog_ref_iterator *)ref_iterator;
+	reftable_log_record_release(&ri->log);
+	reftable_iterator_destroy(&ri->iter);
+	if (ri->merged)
+		reftable_merged_table_free(ri->merged);
+	return 0;
+}
+
+static struct ref_iterator_vtable git_reftable_reflog_ref_iterator_vtable = {
+	git_reftable_reflog_ref_iterator_advance,
+	git_reftable_reflog_ref_iterator_peel,
+	git_reftable_reflog_ref_iterator_abort
+};
+
+static struct ref_iterator *
+git_reftable_reflog_iterator_begin(struct ref_store *ref_store)
+{
+	struct git_reftable_reflog_ref_iterator *ri = xcalloc(1, sizeof(*ri));
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+
+	ri->refs = refs;
+	if (refs->worktree_stack == NULL) {
+		struct reftable_stack *stack = refs->main_stack;
+		struct reftable_merged_table *mt =
+			reftable_stack_merged_table(stack);
+		int err = reftable_merged_table_seek_log(mt, &ri->iter, "");
+		if (err < 0) {
+			free(ri);
+			/* XXX how to handle errors in iterator_begin()? */
+			return NULL;
+		}
+	} else {
+		struct reftable_merged_table *mt1 =
+			reftable_stack_merged_table(refs->main_stack);
+		struct reftable_merged_table *mt2 =
+			reftable_stack_merged_table(refs->worktree_stack);
+		struct reftable_table *tabs =
+			xcalloc(2, sizeof(struct reftable_table));
+		int err = 0;
+		reftable_table_from_merged_table(&tabs[0], mt1);
+		reftable_table_from_merged_table(&tabs[1], mt2);
+		err = reftable_new_merged_table(&ri->merged, tabs, 2,
+						the_hash_algo->format_id);
+		if (err < 0) {
+			free(tabs);
+			/* XXX idem. */
+			return NULL;
+		}
+		err = reftable_merged_table_seek_log(ri->merged, &ri->iter, "");
+		if (err < 0) {
+			return NULL;
+		}
+	}
+	base_ref_iterator_init(&ri->base,
+			       &git_reftable_reflog_ref_iterator_vtable, 1);
+	ri->base.oid = &ri->oid;
+
+	return (struct ref_iterator *)ri;
+}
+
+static int git_reftable_for_each_reflog_ent_newest_first(
+	struct ref_store *ref_store, const char *refname, each_reflog_ent_fn fn,
+	void *cb_data)
+{
+	struct reftable_iterator it = { NULL };
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct reftable_merged_table *mt = NULL;
+	int err = 0;
+	struct reftable_log_record log = { NULL };
+
+	if (refs->err < 0) {
+		return refs->err;
+	}
+	refname = bare_ref_name(refname);
+
+	mt = reftable_stack_merged_table(stack);
+	err = reftable_merged_table_seek_log(mt, &it, refname);
+	while (err == 0) {
+		struct object_id old_oid;
+		struct object_id new_oid;
+		const char *full_committer = "";
+
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			err = 0;
+			break;
+		}
+		if (err < 0) {
+			break;
+		}
+
+		if (strcmp(log.refname, refname)) {
+			break;
+		}
+
+		oidread(&old_oid, log.value.update.old_hash);
+		oidread(&new_oid, log.value.update.new_hash);
+
+		if (is_null_oid(&old_oid) && is_null_oid(&new_oid)) {
+			/* placeholder for existence. */
+			continue;
+		}
+
+		full_committer = fmt_ident(log.value.update.name,
+					   log.value.update.email,
+					   WANT_COMMITTER_IDENT,
+					   /*date*/ NULL, IDENT_NO_DATE);
+		err = fn(&old_oid, &new_oid, full_committer,
+			 log.value.update.time, log.value.update.tz_offset,
+			 log.value.update.message, cb_data);
+		if (err)
+			break;
+	}
+
+	reftable_log_record_release(&log);
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+static int git_reftable_for_each_reflog_ent_oldest_first(
+	struct ref_store *ref_store, const char *refname, each_reflog_ent_fn fn,
+	void *cb_data)
+{
+	struct reftable_iterator it = { NULL };
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct reftable_merged_table *mt = NULL;
+	struct reftable_log_record *logs = NULL;
+	int cap = 0;
+	int len = 0;
+	int err = 0;
+	int i = 0;
+
+	if (refs->err < 0) {
+		return refs->err;
+	}
+	refname = bare_ref_name(refname);
+	mt = reftable_stack_merged_table(stack);
+	err = reftable_merged_table_seek_log(mt, &it, refname);
+
+	while (err == 0) {
+		struct reftable_log_record log = { NULL };
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			err = 0;
+			break;
+		}
+		if (err < 0) {
+			break;
+		}
+
+		if (strcmp(log.refname, refname)) {
+			break;
+		}
+
+		if (len == cap) {
+			cap = 2 * cap + 1;
+			logs = realloc(logs, cap * sizeof(*logs));
+		}
+
+		logs[len++] = log;
+	}
+
+	for (i = len; i--;) {
+		struct reftable_log_record *log = &logs[i];
+		struct object_id old_oid;
+		struct object_id new_oid;
+		const char *full_committer = "";
+
+		oidread(&old_oid, log->value.update.old_hash);
+		oidread(&new_oid, log->value.update.new_hash);
+
+		if (is_null_oid(&old_oid) && is_null_oid(&new_oid)) {
+			/* placeholder for existence. */
+			continue;
+		}
+
+		full_committer = fmt_ident(log->value.update.name,
+					   log->value.update.email,
+					   WANT_COMMITTER_IDENT, NULL,
+					   IDENT_NO_DATE);
+		err = fn(&old_oid, &new_oid, full_committer,
+			 log->value.update.time, log->value.update.tz_offset,
+			 log->value.update.message, cb_data);
+		if (err) {
+			break;
+		}
+	}
+
+	for (i = 0; i < len; i++) {
+		reftable_log_record_release(&logs[i]);
+	}
+	free(logs);
+
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+static int git_reftable_reflog_exists(struct ref_store *ref_store,
+				      const char *refname)
+{
+	struct reftable_iterator it = { NULL };
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct reftable_merged_table *mt = reftable_stack_merged_table(stack);
+	struct reftable_log_record log = { NULL };
+	int err = refs->err;
+
+	if (err < 0) {
+		goto done;
+	}
+
+	refname = bare_ref_name(refname);
+	err = reftable_merged_table_seek_log(mt, &it, refname);
+	if (err) {
+		goto done;
+	}
+	err = reftable_iterator_next_log(&it, &log);
+	if (err) {
+		goto done;
+	}
+
+	if (strcmp(log.refname, refname)) {
+		err = 1;
+	}
+
+done:
+	reftable_iterator_destroy(&it);
+	reftable_log_record_release(&log);
+	return !err;
+}
+
+struct write_reflog_existence_arg {
+	struct git_reftable_ref_store *refs;
+	const char *refname;
+	struct reftable_stack *stack;
+};
+
+static int write_reflog_existence_table(struct reftable_writer *writer,
+					void *argv)
+{
+	struct write_reflog_existence_arg *arg =
+		(struct write_reflog_existence_arg *)argv;
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	struct reftable_log_record log = { NULL };
+
+	int err = reftable_stack_read_log(arg->stack, arg->refname, &log);
+	if (err <= 0) {
+		goto done;
+	}
+
+	reftable_writer_set_limits(writer, ts, ts);
+
+	log.refname = (char *)arg->refname;
+	log.update_index = ts;
+	log.value_type = REFTABLE_LOG_UPDATE;
+	err = reftable_writer_add_log(writer, &log);
+
+	/* field is not malloced */
+	log.refname = NULL;
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_log_record_release(&log);
+	return err;
+}
+
+static int git_reftable_create_reflog(struct ref_store *ref_store,
+				      const char *refname,
+				      struct strbuf *errmsg)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct write_reflog_existence_arg arg = {
+		.refs = refs,
+		.stack = stack,
+		.refname = refname,
+	};
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	err = reftable_stack_add(stack, &write_reflog_existence_table, &arg);
+
+done:
+	return err;
+}
+
+struct write_reflog_delete_arg {
+	struct reftable_stack *stack;
+	const char *refname;
+};
+
+static int write_reflog_delete_table(struct reftable_writer *writer, void *argv)
+{
+	struct write_reflog_delete_arg *arg = argv;
+	struct reftable_merged_table *mt =
+		reftable_stack_merged_table(arg->stack);
+	struct reftable_log_record log = { NULL };
+	struct reftable_iterator it = { NULL };
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	int err = reftable_merged_table_seek_log(mt, &it, arg->refname);
+
+	reftable_writer_set_limits(writer, ts, ts);
+	while (err == 0) {
+		struct reftable_log_record tombstone = {
+			.refname = (char *)arg->refname,
+			.update_index = REFTABLE_LOG_DELETION,
+		};
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			err = 0;
+			break;
+		}
+
+		if (err < 0 || strcmp(log.refname, arg->refname)) {
+			break;
+		}
+		if (log.value_type == REFTABLE_LOG_DELETION)
+			continue;
+
+		tombstone.update_index = log.update_index;
+		err = reftable_writer_add_log(writer, &tombstone);
+	}
+
+	reftable_log_record_release(&log);
+	return err;
+}
+
+static int git_reftable_delete_reflog(struct ref_store *ref_store,
+				      const char *refname)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct write_reflog_delete_arg arg = {
+		.stack = stack,
+		.refname = refname,
+	};
+	int err = reftable_stack_add(stack, &write_reflog_delete_table, &arg);
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+struct reflog_expiry_arg {
+	struct reftable_stack *stack;
+	struct reftable_log_record *records;
+	int len;
+	const char *refname;
+};
+
+static int write_reflog_expiry_table(struct reftable_writer *writer, void *argv)
+{
+	struct reflog_expiry_arg *arg = (struct reflog_expiry_arg *)argv;
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	int i = 0;
+	int live_records = 0;
+	uint64_t max_ts = 0;
+	for (i = 0; i < arg->len; i++) {
+		if (arg->records[i].value_type == REFTABLE_LOG_UPDATE)
+			live_records++;
+
+		if (max_ts < arg->records[i].update_index)
+			max_ts = arg->records[i].update_index;
+	}
+
+	reftable_writer_set_limits(writer, ts, ts);
+	if (live_records == 0) {
+		struct reftable_log_record log = {
+			.refname = (char *)arg->refname,
+			.update_index = max_ts + 1,
+			.value_type = REFTABLE_LOG_UPDATE,
+			/* existence dummy has null new/old oid */
+		};
+		int err;
+		if (log.update_index < ts)
+			log.update_index = ts;
+
+		err = reftable_writer_add_log(writer, &log);
+		if (err) {
+			return err;
+		}
+	}
+
+	for (i = 0; i < arg->len; i++) {
+		int err = reftable_writer_add_log(writer, &arg->records[i]);
+		if (err) {
+			return err;
+		}
+	}
+	return 0;
+}
+
+static int git_reftable_reflog_expire(
+	struct ref_store *ref_store, const char *refname, unsigned int flags,
+	reflog_expiry_prepare_fn prepare_fn,
+	reflog_expiry_should_prune_fn should_prune_fn,
+	reflog_expiry_cleanup_fn cleanup_fn, void *policy_cb_data)
+{
+	/*
+	  For log expiry, we write tombstones in place of the expired entries,
+	  This means that the entries are still retrievable by delving into the
+	  stack, and expiring entries paradoxically takes extra memory.
+
+	  This memory is only reclaimed when some operation issues a
+	  git_reftable_pack_refs(), which will compact the entire stack and get
+	  rid of deletion entries.
+
+	  It would be better if the refs backend supported an API that sets a
+	  criterion for all refs, passing the criterion to pack_refs().
+
+	  On the plus side, because we do the expiration per ref, we can easily
+	  insert the reflog existence dummies.
+	*/
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct reftable_merged_table *mt = NULL;
+	struct reflog_expiry_arg arg = {
+		.stack = stack,
+		.refname = refname,
+	};
+	struct reftable_log_record *logs = NULL;
+	struct reftable_log_record *rewritten = NULL;
+	struct reftable_ref_record ref_record = { NULL };
+	int logs_len = 0;
+	int logs_cap = 0;
+	int i = 0;
+	uint8_t *last_hash = NULL;
+	struct reftable_iterator it = { NULL };
+	struct reftable_addition *add = NULL;
+	int err = 0;
+	struct object_id oid = { 0 };
+	if (refs->err < 0) {
+		return refs->err;
+	}
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	mt = reftable_stack_merged_table(stack);
+	err = reftable_merged_table_seek_log(mt, &it, refname);
+	if (err < 0) {
+		goto done;
+	}
+
+	err = reftable_stack_new_addition(&add, stack);
+	if (err) {
+		goto done;
+	}
+	if (!reftable_stack_read_ref(stack, refname, &ref_record)) {
+		uint8_t *hash = reftable_ref_record_val1(&ref_record);
+		if (hash)
+			oidread(&oid, hash);
+	}
+
+	prepare_fn(refname, &oid, policy_cb_data);
+	while (1) {
+		struct reftable_log_record log = { NULL };
+		int err = reftable_iterator_next_log(&it, &log);
+		if (err < 0) {
+			goto done;
+		}
+
+		if (err > 0 || strcmp(log.refname, refname)) {
+			break;
+		}
+
+		if (logs_len >= logs_cap) {
+			int new_cap = logs_cap * 2 + 1;
+			logs = realloc(logs, new_cap * sizeof(*logs));
+			logs_cap = new_cap;
+		}
+		logs[logs_len++] = log;
+	}
+
+	rewritten = calloc(logs_len, sizeof(*rewritten));
+	for (i = logs_len - 1; i >= 0; i--) {
+		struct object_id ooid;
+		struct object_id noid;
+		struct reftable_log_record *dest = &rewritten[i];
+
+		*dest = logs[i];
+		oidread(&ooid, logs[i].value.update.old_hash);
+		oidread(&noid, logs[i].value.update.new_hash);
+
+		if (should_prune_fn(&ooid, &noid, logs[i].value.update.email,
+				    (timestamp_t)logs[i].value.update.time,
+				    logs[i].value.update.tz_offset,
+				    logs[i].value.update.message,
+				    policy_cb_data)) {
+			dest->value_type = REFTABLE_LOG_DELETION;
+		} else {
+			if ((flags & EXPIRE_REFLOGS_REWRITE) &&
+			    last_hash != NULL) {
+				dest->value.update.old_hash = last_hash;
+			}
+			last_hash = logs[i].value.update.new_hash;
+		}
+	}
+
+	arg.records = rewritten;
+	arg.len = logs_len;
+	err = reftable_addition_add(add, &write_reflog_expiry_table, &arg);
+	if (err < 0) {
+		goto done;
+	}
+
+	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
+		/* future improvement: we could skip writing records that were
+		 * not changed. */
+		err = reftable_addition_commit(add);
+	}
+
+done:
+	if (add) {
+		cleanup_fn(policy_cb_data);
+	}
+	assert(err != REFTABLE_API_ERROR);
+	reftable_addition_destroy(add);
+	for (i = 0; i < logs_len; i++)
+		reftable_log_record_release(&logs[i]);
+	free(logs);
+	free(rewritten);
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+static int git_reftable_read_raw_ref(struct ref_store *ref_store,
+				     const char *refname, struct object_id *oid,
+				     struct strbuf *referent,
+				     unsigned int *type, int *failure_errno)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_stack *stack = stack_for(refs, refname);
+	struct reftable_ref_record ref = { NULL };
+	int err = 0;
+
+	refname = bare_ref_name(refname); /* XXX - in which other cases should
+					     we do this? */
+	if (refs->err < 0) {
+		return refs->err;
+	}
+
+	/* This is usually not needed, but Git doesn't signal to ref backend if
+	   a subprocess updated the ref DB.  So we always check.
+	*/
+	err = reftable_stack_reload(stack);
+	if (err) {
+		goto done;
+	}
+
+	err = reftable_stack_read_ref(stack, refname, &ref);
+	if (err > 0) {
+		*failure_errno = ENOENT;
+		err = -1;
+		goto done;
+	}
+	if (err < 0) {
+		goto done;
+	}
+
+	if (ref.value_type == REFTABLE_REF_SYMREF) {
+		strbuf_reset(referent);
+		strbuf_addstr(referent, ref.value.symref);
+		*type |= REF_ISSYMREF;
+	} else if (reftable_ref_record_val1(&ref) != NULL) {
+		oidread(oid, reftable_ref_record_val1(&ref));
+	} else {
+		/* We got a tombstone, which should not happen. */
+		BUG("Got reftable_ref_record with value type %d",
+		    ref.value_type);
+	}
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_ref_record_release(&ref);
+	return err;
+}
+
+struct ref_storage_be refs_be_reftable = {
+	&refs_be_files,
+	"reftable",
+	git_reftable_ref_store_create,
+	git_reftable_init_db,
+	git_reftable_transaction_prepare,
+	git_reftable_transaction_finish,
+	git_reftable_transaction_abort,
+	git_reftable_transaction_initial_commit,
+
+	git_reftable_pack_refs,
+	git_reftable_create_symref,
+	git_reftable_delete_refs,
+	git_reftable_rename_ref,
+	git_reftable_copy_ref,
+
+	git_reftable_ref_iterator_begin,
+	git_reftable_read_raw_ref,
+
+	git_reftable_reflog_iterator_begin,
+	git_reftable_for_each_reflog_ent_oldest_first,
+	git_reftable_for_each_reflog_ent_newest_first,
+	git_reftable_reflog_exists,
+	git_reftable_create_reflog,
+	git_reftable_delete_reflog,
+	git_reftable_reflog_expire,
+};
diff --git a/repository.c b/repository.c
index dddee32258f..3aaae1f43cd 100644
--- a/repository.c
+++ b/repository.c
@@ -185,6 +185,8 @@ int repo_init(struct repository *repo,
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
+	repo->ref_storage_format = xstrdup_or_null(format.ref_storage);
+
 	clear_repository_format(&format);
 	return 0;
 
diff --git a/repository.h b/repository.h
index 4e46ecdca56..ceb7f55a2c7 100644
--- a/repository.h
+++ b/repository.h
@@ -82,6 +82,9 @@ struct repository {
 	 */
 	struct ref_store *refs_private;
 
+	/* The format to use for the ref database. */
+	char *ref_storage_format;
+
 	/*
 	 * Contains path to often used file names.
 	 */
diff --git a/setup.c b/setup.c
index 04ce33cdcd4..79f725eae8b 100644
--- a/setup.c
+++ b/setup.c
@@ -563,6 +563,9 @@ static enum extension_result handle_extension(const char *var,
 				     "extensions.objectformat", value);
 		data->hash_algo = format;
 		return EXTENSION_OK;
+	} else if (!strcmp(ext, "refstorage")) {
+		data->ref_storage = xstrdup(value);
+		return EXTENSION_OK;
 	}
 	return EXTENSION_UNKNOWN;
 }
@@ -713,6 +716,7 @@ void clear_repository_format(struct repository_format *format)
 	string_list_clear(&format->v1_only_extensions, 0);
 	free(format->work_tree);
 	free(format->partial_clone);
+	free(format->ref_storage);
 	init_repository_format(format);
 }
 
@@ -1377,6 +1381,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			the_repository->repository_format_partial_clone =
 				repo_fmt.partial_clone;
 			repo_fmt.partial_clone = NULL;
+			the_repository->ref_storage_format =
+				xstrdup_or_null(repo_fmt.ref_storage);
 		}
 	}
 	/*
@@ -1465,6 +1471,8 @@ void check_repository_format(struct repository_format *fmt)
 	repo_set_hash_algo(the_repository, fmt->hash_algo);
 	the_repository->repository_format_partial_clone =
 		xstrdup_or_null(fmt->partial_clone);
+	/* XXX why is repo->ref_storage_format set in multiple places?! */
+	the_repository->ref_storage_format = xstrdup_or_null(fmt->ref_storage);
 	clear_repository_format(&repo_fmt);
 }
 
diff --git a/t/t0031-reftable.sh b/t/t0031-reftable.sh
new file mode 100755
index 00000000000..12cd46eec85
--- /dev/null
+++ b/t/t0031-reftable.sh
@@ -0,0 +1,380 @@
+#!/bin/sh
+#
+# Copyright (c) 2020 Google LLC
+#
+
+test_description='reftable basics'
+
+. ./test-lib.sh
+
+INVALID_SHA1=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
+
+git_init () {
+	git init -b primary "$@"
+}
+
+initialize () {
+	rm -rf .git &&
+	(GIT_TEST_REFTABLE=1; export GIT_TEST_REFTABLE; git_init) &&
+	mv .git/hooks .git/hooks-disabled
+}
+
+write_script fake_editor <<\EOF
+echo "$MSG" >"$1"
+echo "$MSG" >&2
+EOF
+GIT_EDITOR=./fake_editor
+export GIT_EDITOR
+
+
+test_expect_success 'using reftable' '
+	initialize &&
+	test -d .git/reftable &&
+	test -f .git/reftable/tables.list
+'
+
+test_expect_success 'read existing old OID if REF_HAVE_OLD is not set' '
+	initialize &&
+	test_commit 1st &&
+	test_commit 2nd &&
+	MSG=b4 git notes add &&
+	MSG=b3 git notes edit &&
+	echo b4 >expect &&
+	git notes --ref commits@{1} show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git reflog delete' '
+	initialize &&
+	test_commit file &&
+	test_commit file2 &&
+	test_commit file3 &&
+	test_commit file4 &&
+	git reflog delete HEAD@{1} &&
+	git reflog > output &&
+	! grep file3 output
+'
+
+test_expect_success 'branch -D delete nonexistent branch' '
+	initialize &&
+	test_commit file &&
+	test_must_fail git branch -D ../../my-private-file
+'
+
+test_expect_success 'branch copy' '
+	initialize &&
+	test_commit file1 &&
+	test_commit file2 &&
+	git branch src &&
+	git reflog src > expect &&
+	git branch -c src dst &&
+	git reflog dst | sed "s/dst/src/g" > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'update-ref on corrupted data' '
+	initialize &&
+	test_commit file1 &&
+	OLD_SHA1=$(git rev-parse HEAD) &&
+	test_commit file2 &&
+	ls -l .git/reftable &&
+	for f in .git/reftable/*.ref
+	do
+		>$f
+	done &&
+	test_must_fail git update-ref refs/heads/main $OLD_SHA1
+'
+
+test_expect_success 'git stash' '
+	initialize &&
+	test_commit file &&
+	touch actual expected &&
+	git -c status.showStash=true status >expected &&
+	echo hoi >> file.t &&
+	git stash push -m stashed &&
+	git stash clear &&
+	git -c status.showStash=true status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'rename branch' '
+	initialize &&
+	git symbolic-ref HEAD refs/heads/before &&
+	test_commit file &&
+	git show-ref | sed s/before/after/g > expected &&
+	git branch -M after &&
+	git show-ref > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'SHA256 support, env' '
+	rm -rf .git &&
+	(GIT_DEFAULT_HASH=sha256 && export GIT_DEFAULT_HASH &&
+				 GIT_TEST_REFTABLE=1 git_init) &&
+	mv .git/hooks .git/hooks-disabled &&
+	test_commit file
+'
+
+test_expect_success 'SHA256 support, option' '
+	rm -rf .git &&
+	(GIT_TEST_REFTABLE=1 git_init --object-format=sha256) &&
+	mv .git/hooks .git/hooks-disabled &&
+	test_commit file
+'
+
+test_expect_success 'delete ref' '
+	initialize &&
+	test_commit file &&
+	SHA=$(git show-ref -s --verify HEAD) &&
+	test_write_lines "$SHA refs/heads/primary" "$SHA refs/tags/file" >expect &&
+	git show-ref >actual &&
+	! git update-ref -d refs/tags/file $INVALID_SHA1 &&
+	test_cmp expect actual &&
+	git update-ref -d refs/tags/file $SHA &&
+	test_write_lines "$SHA refs/heads/primary" >expect &&
+	git show-ref >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone calls transaction_initial_commit' '
+	test_commit message1 file1 &&
+	git clone . cloned &&
+	(test -f cloned/file1 || echo "Fixme.")
+'
+
+test_expect_success 'basic operation of reftable storage: commit, show-ref' '
+	initialize &&
+	test_commit file &&
+	test_write_lines refs/heads/primary refs/tags/file >expect &&
+	git show-ref &&
+	git show-ref | cut -f2 -d" " >actual &&
+	test_cmp actual expect
+'
+
+test_expect_success 'reflog, repack' '
+	initialize &&
+	for count in $(test_seq 1 10)
+	do
+		test_commit "number $count" file.t $count number-$count ||
+		return 1
+	done &&
+	git pack-refs &&
+	ls -1 .git/reftable >table-files &&
+	test_line_count = 2 table-files &&
+	git reflog refs/heads/primary >output &&
+	test_line_count = 10 output &&
+	grep "commit (initial): number 1" output &&
+	grep "commit: number 10" output &&
+	git gc &&
+	git reflog refs/heads/primary >output &&
+	test_line_count = 0 output
+'
+
+test_expect_success 'branch switch in reflog output' '
+	initialize &&
+	test_commit file1 &&
+	git checkout -b branch1 &&
+	test_commit file2 &&
+	git checkout -b branch2 &&
+	git switch - &&
+	git rev-parse --symbolic-full-name HEAD >actual &&
+	echo refs/heads/branch1 >expect &&
+	test_cmp actual expect
+'
+
+
+# This matches show-ref's output
+print_ref() {
+	echo "$(git rev-parse "$1") $1"
+}
+
+test_expect_success 'peeled tags are stored' '
+	initialize &&
+	test_commit file &&
+	git tag -m "annotated tag" test_tag HEAD &&
+	{
+		print_ref "refs/heads/primary" &&
+		print_ref "refs/tags/file" &&
+		print_ref "refs/tags/test_tag" &&
+		print_ref "refs/tags/test_tag^{}"
+	} >expect &&
+	git show-ref -d >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'show-ref works on fresh repo' '
+	initialize &&
+	rm -rf .git &&
+	(GIT_TEST_REFTABLE=1 git_init) &&
+	>expect &&
+	! git show-ref >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout unborn branch' '
+	initialize &&
+	git checkout -b primary
+'
+
+
+test_expect_success 'dir/file conflict' '
+	initialize &&
+	test_commit file &&
+	! git branch primary/forbidden
+'
+
+
+test_expect_success 'do not clobber existing repo' '
+	rm -rf .git &&
+	git_init &&
+	cat .git/HEAD >expect &&
+	test_commit file &&
+	(GIT_TEST_REFTABLE=1 git_init || true) &&
+	cat .git/HEAD >actual &&
+	test_cmp expect actual
+'
+
+# cherry-pick uses a pseudo ref.
+test_expect_success 'pseudo refs' '
+	initialize &&
+	test_commit message1 file1 &&
+	test_commit message2 file2 &&
+	git branch source &&
+	git checkout HEAD^ &&
+	test_commit message3 file3 &&
+	git cherry-pick source &&
+	test -f file2
+'
+
+# cherry-pick uses a pseudo ref.
+test_expect_success 'rebase' '
+	initialize &&
+	test_commit message1 file1 &&
+	test_commit message2 file2 &&
+	git branch source &&
+	git checkout HEAD^ &&
+	test_commit message3 file3 &&
+	git rebase source &&
+	test -f file2
+'
+
+test_expect_success 'worktrees' '
+	(GIT_TEST_REFTABLE=1 git_init start) &&
+	(cd start && test_commit file1 && git checkout -b branch1 &&
+	git checkout -b branch2 &&
+	git worktree add ../wt
+	) &&
+	cd wt &&
+	git checkout branch1 &&
+	git branch
+'
+
+test_expect_success 'worktrees 2' '
+	initialize &&
+	test_commit file1 &&
+	mkdir existing_empty &&
+	git worktree add --detach existing_empty primary
+'
+
+test_expect_success 'FETCH_HEAD' '
+	initialize &&
+	test_commit one &&
+	(git_init sub && cd sub && test_commit two) &&
+	git --git-dir sub/.git rev-parse HEAD >expect &&
+	git fetch sub &&
+	git checkout FETCH_HEAD &&
+	git rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+REPO="$HTTPD_DOCUMENT_ROOT_PATH/repo"
+
+test_expect_success 'serving ls-remote' '
+	GIT_TEST_REFTABLE=1 git init -b main "$REPO" &&
+	cd "$REPO" &&
+	test_commit m1 &&
+	>.git/git-daemon-export-ok &&
+	git ls-remote "http://127.0.0.1:$LIB_HTTPD_PORT/smart/repo" | cut -f 2-2 -d "	" >actual &&
+	cat << EOF >expect &&
+HEAD
+refs/heads/main
+refs/tags/m1
+EOF
+	test_cmp actual expect
+'
+
+test_expect_success 'large reflog message' '
+	initialize &&
+	perl -e "
+		print \"this is a long commit message\" x 50000
+	" >commit-msg &&
+	git commit --allow-empty -F commit-msg
+'
+
+test_expect_success 'update-ref OID verification' '
+	initialize &&
+	test_must_fail test-tool ref-store main update-ref msg refs/heads/bla $INVALID_SHA1 $ZERO_OID 0 &&
+	test-tool ref-store main update-ref msg refs/heads/bla $INVALID_SHA1 $ZERO_OID REF_SKIP_OID_VERIFICATION
+'
+
+test_expect_success 'bogus names are detected in iteration flags' '
+	initialize &&
+	test_commit file &&
+	test-tool ref-store main update-ref msg "refs/heads/bogus..name" $(git rev-parse HEAD) $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+	test-tool ref-store main for-each-ref "" > actual &&
+	grep "0000000000000000000000000000000000000000 refs/heads/bogus..name 0xc" actual
+'
+
+test_expect_success 'bogus OIDs are not detected in iteration flags' '
+	initialize &&
+	test_commit file &&
+	test-tool ref-store main update-ref msg "refs/heads/broken-hash" $INVALID_SHA1 $ZERO_OID REF_SKIP_OID_VERIFICATION &&
+	test-tool ref-store main for-each-ref "" > actual &&
+cat actual &&
+	grep "$INVALID_SHA1 refs/heads/broken-hash 0x0" actual
+'
+
+test_expect_success 'reftable supports reflog existence' '
+	initialize &&
+	test_must_fail test-tool ref-store main reflog-exists refs/heads/reflogtest &&
+	test-tool ref-store main create-reflog refs/heads/reflogtest &&
+	test-tool ref-store main reflog-exists refs/heads/reflogtest &&
+	>expect &&
+	test-tool ref-store main for-each-reflog-ent-reverse refs/heads/reflogtest >actual &&
+	test_cmp expect actual &&
+	test_commit file0 &&
+	git checkout -b reflogtest &&
+	test_commit fileA &&
+	test_commit fileB &&
+cat << EOF > expect &&
+branch: Created from HEAD
+commit: fileA
+commit: fileB
+EOF
+	test-tool ref-store main for-each-reflog-ent refs/heads/reflogtest | sed "s/.*	//" >actual &&
+	test_cmp expect actual &&
+	git reflog expire reflogtest --expire=all &&
+	>expect &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/reflogtest >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main reflog-exists refs/heads/reflogtest &&
+	test-tool ref-store main delete-reflog refs/heads/reflogtest &&
+	test_must_fail test-tool ref-store main reflog-exists refs/heads/reflogtest
+'
+
+test_expect_success 'for-each-reflog-ent symref' '
+	initialize &&
+	test_commit file &&
+	git branch &&
+	git symbolic-ref refs/heads/sym refs/heads/primary &&
+cat >expected <<EOF &&
+refs/heads/primary
+EOF
+	git for-each-ref --format="%(symref)" refs/heads/sym >actual &&
+	test_cmp expected actual
+'
+
+test_done
diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index be12fb63506..cdc21bf2dcb 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -4,6 +4,12 @@ test_description='avoid rewriting packed-refs unnecessarily'
 
 . ./test-lib.sh
 
+if test_have_prereq !REFFILES
+then
+  skip_all='skipping pack-refs tests; need files backend'
+  test_done
+fi
+
 # Add an identifying mark to the packed-refs file header line. This
 # shouldn't upset readers, and it should be omitted if the file is
 # ever rewritten.
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index de50c0ea018..397f1edac9a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -8,6 +8,12 @@ test_description='git fsck random collection of tests
 
 . ./test-lib.sh
 
+if test_have_prereq !REFFILES
+then
+  skip_all='skipping tests; incompatible with reftable'
+  test_done
+fi
+
 test_expect_success setup '
 	git config gc.auto 0 &&
 	git config i18n.commitencoding ISO-8859-1 &&
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 577f32dc71f..e523c3dd624 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -14,6 +14,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+if test_have_prereq !REFFILES
+then
+  skip_all='skipping pack-refs tests; requires files ref backend'
+  test_done
+fi
+
 test_expect_success 'enable reflogs' '
 	git config core.logallrefupdates true
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 46cd596e7f5..0fd021f3177 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1604,7 +1604,12 @@ parisc* | hppa*)
 	;;
 esac
 
-test_set_prereq REFFILES
+if test -n "$GIT_TEST_REFTABLE"
+then
+  test_set_prereq !REFFILES
+else
+  test_set_prereq REFFILES
+fi
 
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL

base-commit: a9cd6a0c5981a7d3c9865cf1966243c82f93e58e
-- 
gitgitgadget
