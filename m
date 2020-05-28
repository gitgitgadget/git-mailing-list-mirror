Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A87C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEDB22088E
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtvmQOIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406717AbgE1Tr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406698AbgE1TrK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:47:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF26FC008631
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:47:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d128so349659wmc.1
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SanMSOGgxTNkekp1AzIMldsFbOEqAPsb/aiybEExGjA=;
        b=NtvmQOIbqkludpV3QlWOFGKHZbZPU4QCGA7SQe5tj5CCUNd1i/BL4wvBaat5JjQi6l
         KPioj8p8Q+10KscIf+zRIqmamPqVbBJA+fgowOOQR9Sf0TviQdnXeeEy4cPx9AKNbV+4
         9SEVk3DCSLu8hwwbPVGDIkaRNHA0b8wlgmzMhYrTrt5zNezjyOTRBXUvsItE3tCVIURH
         NaK3KfzvZTVLNOAgY85MeqXjcSiZ9P5Djq5Yc8/T3O1+H+kLRvpFv+o3oKnUoSNN/DYB
         H3zyBKoxehqqFUcXoAXrYwpDoA774MUxF2ZSTqP6t3SZg46SD8YkWWgDIJM2i9iQ9sXT
         82CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SanMSOGgxTNkekp1AzIMldsFbOEqAPsb/aiybEExGjA=;
        b=sww29b2oGN98eRELMhzaTrW5+5na2S9tycRBC2Zo24dCfcX05VtEKmXh/2+6e8AWYR
         YrAXY3Zx5su4E5QGJ4eZGw0a/4WIr0OZ+ak7C1OhRIpyCoHcwRdUNTPLZx3vFmKWU+13
         KBzHBr6LN7BqR4/s9NLZJWkH+8WOO1kWIw4Y4fkxed9zwiBANb/mqvgWp7cjgOe8BdWw
         7U63Ulgf3kFPRhEnHwcGRTbhcNQpRxVxTuyl1nPvmgEPVR7nMtSE3X425g7/PI8xpT1r
         W7dFrgCjTnxLbj0RsGCoi/fXDmJxxx93KGzzodXwL1ENRjc49hSKdxaghAICCOrOWGwl
         UQ7Q==
X-Gm-Message-State: AOAM53316iEruMelAUW3h44sVOKPWBrmW6d5pI/vonU451Ou/cI7C7vA
        tH8y156ONZdr5w7CXGFJqievOSr4
X-Google-Smtp-Source: ABdhPJwqrsyitam/o+PbVbZLxKs6lxJwGk4LQO5aLaBT4CVdsNRj4as/SMAHkWMo388JUVA8mHtB5g==
X-Received: by 2002:a1c:65c2:: with SMTP id z185mr4685005wmb.125.1590695221420;
        Thu, 28 May 2020 12:47:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4sm6852637wrq.31.2020.05.28.12.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:47:00 -0700 (PDT)
Message-Id: <a86c3753717d5b74c4ec0b197a579cb20329363a.1590695210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
References: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
        <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 19:46:46 +0000
Subject: [PATCH v15 10/13] Reftable support for git-core
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

For background, see the previous commit introducing the library.

This introduces the refs/reftable-backend.c containing reftable powered ref
storage backend.

It can be activated by passing --ref-storage=reftable to "git init".

TODO:

* Fix worktree commands

* Spots marked XXX

Example use: see t/t0031-reftable.sh

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Co-authored-by: Jeff King <peff@peff.net>
---
 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   27 +-
 builtin/clone.c                               |    3 +-
 builtin/init-db.c                             |   56 +-
 cache.h                                       |    6 +-
 refs.c                                        |   27 +-
 refs.h                                        |    3 +
 refs/refs-internal.h                          |    1 +
 refs/reftable-backend.c                       | 1332 +++++++++++++++++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |   12 +-
 t/t0031-reftable.sh                           |  142 ++
 13 files changed, 1591 insertions(+), 30 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100755 t/t0031-reftable.sh

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
index 372139f1f24..6b21c247b12 100644
--- a/Makefile
+++ b/Makefile
@@ -807,6 +807,7 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
+REFTABLE_LIB = reftable/libreftable.a
 
 GENERATED_H += config-list.h
 GENERATED_H += command-list.h
@@ -959,6 +960,7 @@ LIB_OBJS += ref-filter.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/files-backend.o
+LIB_OBJS += refs/reftable-backend.o
 LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
@@ -1162,7 +1164,7 @@ THIRD_PARTY_SOURCES += compat/regex/%
 THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB)
+GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -2352,11 +2354,29 @@ VCSSVN_OBJS += vcs-svn/sliding_window.o
 VCSSVN_OBJS += vcs-svn/svndiff.o
 VCSSVN_OBJS += vcs-svn/svndump.o
 
+REFTABLE_OBJS += reftable/basics.o
+REFTABLE_OBJS += reftable/block.o
+REFTABLE_OBJS += reftable/file.o
+REFTABLE_OBJS += reftable/iter.o
+REFTABLE_OBJS += reftable/merged.o
+REFTABLE_OBJS += reftable/pq.o
+REFTABLE_OBJS += reftable/reader.o
+REFTABLE_OBJS += reftable/record.o
+REFTABLE_OBJS += reftable/refname.o
+REFTABLE_OBJS += reftable/reftable.o
+REFTABLE_OBJS += reftable/slice.o
+REFTABLE_OBJS += reftable/stack.o
+REFTABLE_OBJS += reftable/tree.o
+REFTABLE_OBJS += reftable/writer.o
+REFTABLE_OBJS += reftable/zlib-compat.o
+
+
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
 	$(XDIFF_OBJS) \
 	$(VCSSVN_OBJS) \
 	$(FUZZ_OBJS) \
+	$(REFTABLE_OBJS) \
 	common-main.o \
 	git.o
 ifndef NO_CURL
@@ -2497,6 +2517,9 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 $(VCSSVN_LIB): $(VCSSVN_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+$(REFTABLE_LIB): $(REFTABLE_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+
 export DEFAULT_EDITOR DEFAULT_PAGER
 
 Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
@@ -3112,7 +3135,7 @@ cocciclean:
 clean: profile-clean coverage-clean cocciclean
 	$(RM) *.res
 	$(RM) $(OBJECTS)
-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
+	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB) $(REFTABLE_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
diff --git a/builtin/clone.c b/builtin/clone.c
index cb48a291caf..4d0cf065e4a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1108,7 +1108,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, INIT_DB_QUIET);
+	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
+		DEFAULT_REF_STORAGE, INIT_DB_QUIET);
 
 	if (real_git_dir)
 		git_dir = real_git_dir;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0b7222e7188..b7053b9e370 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -178,7 +178,8 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 	return 1;
 }
 
-void initialize_repository_version(int hash_algo)
+void initialize_repository_version(int hash_algo,
+				   const char *ref_storage_format)
 {
 	char repo_version_string[10];
 	int repo_version = GIT_REPO_VERSION;
@@ -188,7 +189,8 @@ void initialize_repository_version(int hash_algo)
 		die(_("The hash algorithm %s is not supported in this build."), hash_algos[hash_algo].name);
 #endif
 
-	if (hash_algo != GIT_HASH_SHA1)
+	if (hash_algo != GIT_HASH_SHA1 ||
+	    !strcmp(ref_storage_format, "reftable"))
 		repo_version = GIT_REPO_VERSION_READ;
 
 	/* This forces creation of new config file */
@@ -238,6 +240,7 @@ static int create_default_files(const char *template_path,
 	is_bare_repository_cfg = init_is_bare_repository;
 	if (init_shared_repository != -1)
 		set_shared_repository(init_shared_repository);
+	the_repository->ref_storage_format = xstrdup(fmt->ref_storage);
 
 	/*
 	 * We would have created the above under user's umask -- under
@@ -247,6 +250,24 @@ static int create_default_files(const char *template_path,
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
@@ -261,15 +282,12 @@ static int create_default_files(const char *template_path,
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
 	 */
-	path = git_path_buf(&buf, "HEAD");
-	reinit = (!access(path, R_OK)
-		  || readlink(path, junk, sizeof(junk)-1) != -1);
 	if (!reinit) {
 		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
 			exit(1);
 	}
 
-	initialize_repository_version(fmt->hash_algo);
+	initialize_repository_version(fmt->hash_algo, fmt->ref_storage);
 
 	/* Check filemode trustability */
 	path = git_path_buf(&buf, "config");
@@ -383,7 +401,8 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
 }
 
 int init_db(const char *git_dir, const char *real_git_dir,
-	    const char *template_dir, int hash, unsigned int flags)
+	    const char *template_dir, int hash, const char *ref_storage_format,
+	    unsigned int flags)
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
@@ -422,6 +441,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
 	check_repository_format(&repo_fmt);
+	repo_fmt.ref_storage = xstrdup(ref_storage_format);
 
 	validate_hash_algorithm(&repo_fmt, hash);
 
@@ -450,6 +470,8 @@ int init_db(const char *git_dir, const char *real_git_dir,
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
 
+	git_config_set("extensions.refStorage", ref_storage_format);
+
 	if (!(flags & INIT_DB_QUIET)) {
 		int len = strlen(git_dir);
 
@@ -523,6 +545,7 @@ static const char *const init_db_usage[] = {
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
+	const char *ref_storage_format = DEFAULT_REF_STORAGE;
 	const char *real_git_dir = NULL;
 	const char *work_tree;
 	const char *template_dir = NULL;
@@ -530,15 +553,18 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *object_format = NULL;
 	int hash_algo = GIT_HASH_UNKNOWN;
 	const struct option init_db_options[] = {
-		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
-				N_("directory from which templates will be used")),
+		OPT_STRING(0, "template", &template_dir,
+			   N_("template-directory"),
+			   N_("directory from which templates will be used")),
 		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
-				N_("create a bare repository"), 1),
+			    N_("create a bare repository"), 1),
 		{ OPTION_CALLBACK, 0, "shared", &init_shared_repository,
-			N_("permissions"),
-			N_("specify that the git repository is to be shared amongst several users"),
-			PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0},
+		  N_("permissions"),
+		  N_("specify that the git repository is to be shared amongst several users"),
+		  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0 },
 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
+		OPT_STRING(0, "ref-storage", &ref_storage_format, N_("backend"),
+			   N_("the ref storage format to use")),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
 		OPT_STRING(0, "object-format", &object_format, N_("hash"),
@@ -648,9 +674,11 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	}
 
 	UNLEAK(real_git_dir);
+	UNLEAK(ref_storage_format);
 	UNLEAK(git_dir);
 	UNLEAK(work_tree);
 
 	flags |= INIT_DB_EXIST_OK;
-	return init_db(git_dir, real_git_dir, template_dir, hash_algo, flags);
+	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
+		       ref_storage_format, flags);
 }
diff --git a/cache.h b/cache.h
index 0f0485ecfe2..8cb884773c3 100644
--- a/cache.h
+++ b/cache.h
@@ -628,8 +628,9 @@ int path_inside_repo(const char *prefix, const char *path);
 
 int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash_algo,
-	    unsigned int flags);
-void initialize_repository_version(int hash_algo);
+	    const char *ref_storage_format, unsigned int flags);
+void initialize_repository_version(int hash_algo,
+				   const char *ref_storage_format);
 
 void sanitize_stdfds(void);
 int daemonize(void);
@@ -1043,6 +1044,7 @@ struct repository_format {
 	int is_bare;
 	int hash_algo;
 	char *work_tree;
+	char *ref_storage;
 	struct string_list unknown_extensions;
 };
 
diff --git a/refs.c b/refs.c
index 29e710a29e9..4409080dfd8 100644
--- a/refs.c
+++ b/refs.c
@@ -17,10 +17,16 @@
 #include "argv-array.h"
 #include "repository.h"
 
+const char *default_ref_storage(void)
+{
+	const char *test = getenv("GIT_TEST_REFTABLE");
+	return test ? "reftable" : "files";
+}
+
 /*
  * List of all available backends
  */
-static struct ref_storage_be *refs_backends = &refs_be_files;
+static struct ref_storage_be *refs_backends = &refs_be_reftable;
 
 static struct ref_storage_be *find_ref_storage_backend(const char *name)
 {
@@ -1717,13 +1723,13 @@ static struct ref_store *lookup_ref_store_map(struct hashmap *map,
  * Create, record, and return a ref_store instance for the specified
  * gitdir.
  */
-static struct ref_store *ref_store_init(const char *gitdir,
+static struct ref_store *ref_store_init(const char *gitdir, const char *be_name,
 					unsigned int flags)
 {
-	const char *be_name = "files";
-	struct ref_storage_be *be = find_ref_storage_backend(be_name);
+	struct ref_storage_be *be;
 	struct ref_store *refs;
 
+	be = find_ref_storage_backend(be_name);
 	if (!be)
 		BUG("reference backend %s is unknown", be_name);
 
@@ -1739,7 +1745,11 @@ struct ref_store *get_main_ref_store(struct repository *r)
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs_private = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
+	r->refs_private = ref_store_init(r->gitdir,
+					 r->ref_storage_format ?
+						 r->ref_storage_format :
+						 DEFAULT_REF_STORAGE,
+					 REF_STORE_ALL_CAPS);
 	return r->refs_private;
 }
 
@@ -1794,7 +1804,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		goto done;
 
 	/* assume that add_submodule_odb() has been called */
-	refs = ref_store_init(submodule_sb.buf,
+	refs = ref_store_init(submodule_sb.buf, DEFAULT_REF_STORAGE, /* XXX */
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&submodule_ref_stores, "submodule",
 			       refs, submodule);
@@ -1808,6 +1818,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 
 struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 {
+	const char *format = DEFAULT_REF_STORAGE; /* XXX */
 	struct ref_store *refs;
 	const char *id;
 
@@ -1821,9 +1832,9 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 
 	if (wt->id)
 		refs = ref_store_init(git_common_path("worktrees/%s", wt->id),
-				      REF_STORE_ALL_CAPS);
+				      format, REF_STORE_ALL_CAPS);
 	else
-		refs = ref_store_init(get_git_common_dir(),
+		refs = ref_store_init(get_git_common_dir(), format,
 				      REF_STORE_ALL_CAPS);
 
 	if (refs)
diff --git a/refs.h b/refs.h
index 7aaa1226551..ddcc940d5c7 100644
--- a/refs.h
+++ b/refs.h
@@ -9,6 +9,9 @@ struct string_list;
 struct string_list_item;
 struct worktree;
 
+/* Returns the ref storage backend to use by default. */
+const char *default_ref_storage(void);
+
 /*
  * Resolve a reference, recursively following symbolic refererences.
  *
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d1d00947990..1d58fe17033 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -687,6 +687,7 @@ struct ref_storage_be {
 };
 
 extern struct ref_storage_be refs_be_files;
+extern struct ref_storage_be refs_be_reftable;
 extern struct ref_storage_be refs_be_packed;
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
new file mode 100644
index 00000000000..5f927d08e1d
--- /dev/null
+++ b/refs/reftable-backend.c
@@ -0,0 +1,1332 @@
+#include "../cache.h"
+#include "../config.h"
+#include "../refs.h"
+#include "refs-internal.h"
+#include "../iterator.h"
+#include "../lockfile.h"
+#include "../chdir-notify.h"
+
+#include "../reftable/reftable.h"
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
+	struct reftable_stack *stack;
+};
+
+static int reftable_read_raw_ref(struct ref_store *ref_store,
+				 const char *refname, struct object_id *oid,
+				 struct strbuf *referent, unsigned int *type);
+
+static void clear_reftable_log_record(struct reftable_log_record *log)
+{
+	log->old_hash = NULL;
+	log->new_hash = NULL;
+	log->message = NULL;
+	log->ref_name = NULL;
+	reftable_log_record_clear(log);
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
+	reftable_log_record_clear(log);
+	log->name =
+		xstrndup(split.name_begin, split.name_end - split.name_begin);
+	log->email =
+		xstrndup(split.mail_begin, split.mail_end - split.mail_begin);
+	log->time = atol(split.date_begin);
+	if (*split.tz_begin == '-') {
+		sign = -1;
+		split.tz_begin++;
+	}
+	if (*split.tz_begin == '+') {
+		sign = 1;
+		split.tz_begin++;
+	}
+
+	log->tz_offset = sign * atoi(split.tz_begin);
+}
+
+static struct ref_store *git_reftable_ref_store_create(const char *path,
+						       unsigned int store_flags)
+{
+	struct git_reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
+	struct ref_store *ref_store = (struct ref_store *)refs;
+	struct reftable_write_options cfg = {
+		.block_size = 4096,
+		.hash_id = the_hash_algo->format_id,
+	};
+	struct strbuf sb = STRBUF_INIT;
+
+	base_ref_store_init(ref_store, &refs_be_reftable);
+	refs->store_flags = store_flags;
+	refs->repo_dir = xstrdup(path);
+	strbuf_addf(&sb, "%s/reftable", path);
+	refs->reftable_dir = xstrdup(sb.buf);
+	strbuf_reset(&sb);
+
+	refs->err = reftable_new_stack(&refs->stack, refs->reftable_dir, cfg);
+	assert(refs->err != REFTABLE_API_ERROR);
+	strbuf_release(&sb);
+	return ref_store;
+}
+
+static int reftable_init_db(struct ref_store *ref_store, struct strbuf *err)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct strbuf sb = STRBUF_INIT;
+
+	safe_create_dir(refs->reftable_dir, 1);
+
+	strbuf_addf(&sb, "%s/HEAD", refs->repo_dir);
+	write_file(sb.buf, "ref: refs/.invalid");
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/refs", refs->repo_dir);
+	safe_create_dir(sb.buf, 1);
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/refs/heads", refs->repo_dir);
+	write_file(sb.buf, "this repository uses the reftable format");
+
+	return 0;
+}
+
+struct git_reftable_iterator {
+	struct ref_iterator base;
+	struct reftable_iterator iter;
+	struct reftable_ref_record ref;
+	struct object_id oid;
+	struct ref_store *ref_store;
+	unsigned int flags;
+	int err;
+	const char *prefix;
+};
+
+static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct git_reftable_iterator *ri =
+		(struct git_reftable_iterator *)ref_iterator;
+	while (ri->err == 0) {
+		ri->err = reftable_iterator_next_ref(&ri->iter, &ri->ref);
+		if (ri->err) {
+			break;
+		}
+
+		/*
+		   We could filter pseudo refs here explicitly, but HEAD is not
+		   a PSEUDOREF, but a PER_WORKTREE, b/c each worktree can have
+		   its own HEAD.
+		 */
+		ri->base.refname = ri->ref.ref_name;
+		if (ri->prefix != NULL &&
+		    strncmp(ri->prefix, ri->ref.ref_name, strlen(ri->prefix))) {
+			ri->err = 1;
+			break;
+		}
+		if (ri->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+		    ref_type(ri->base.refname) != REF_TYPE_PER_WORKTREE)
+			continue;
+
+		ri->base.flags = 0;
+		if (ri->ref.value != NULL) {
+			hashcpy(ri->oid.hash, ri->ref.value);
+		} else if (ri->ref.target != NULL) {
+			int out_flags = 0;
+			const char *resolved = refs_resolve_ref_unsafe(
+				ri->ref_store, ri->ref.ref_name,
+				RESOLVE_REF_READING, &ri->oid, &out_flags);
+			ri->base.flags = out_flags;
+			if (resolved == NULL &&
+			    !(ri->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+			    (ri->base.flags & REF_ISBROKEN)) {
+				continue;
+			}
+		}
+
+		ri->base.oid = &ri->oid;
+		if (!(ri->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+		    !ref_resolves_to_object(ri->base.refname, ri->base.oid,
+					    ri->base.flags)) {
+			continue;
+		}
+
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
+	if (ri->ref.target_value != NULL) {
+		hashcpy(peeled->hash, ri->ref.target_value);
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
+	reftable_ref_record_clear(&ri->ref);
+	reftable_iterator_destroy(&ri->iter);
+	return 0;
+}
+
+static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
+	reftable_ref_iterator_advance, reftable_ref_iterator_peel,
+	reftable_ref_iterator_abort
+};
+
+static struct ref_iterator *
+reftable_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
+			    unsigned int flags)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct git_reftable_iterator *ri = xcalloc(1, sizeof(*ri));
+	struct reftable_merged_table *mt = NULL;
+
+	if (refs->err < 0) {
+		ri->err = refs->err;
+	} else {
+		mt = reftable_stack_merged_table(refs->stack);
+		ri->err = reftable_merged_table_seek_ref(mt, &ri->iter, prefix);
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
+
+		err = reftable_read_raw_ref(ref_store, update->refname,
+					    &old_oid, &referent,
+					    /* mutate input, like
+					       files-backend.c */
+					    &update->type);
+		if (err < 0 && errno == ENOENT &&
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
+static int reftable_transaction_prepare(struct ref_store *ref_store,
+					struct ref_transaction *transaction,
+					struct strbuf *errbuf)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_addition *add = NULL;
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+
+	err = reftable_stack_reload(refs->stack);
+	if (err) {
+		goto done;
+	}
+
+	err = reftable_stack_new_addition(&add, refs->stack);
+	if (err) {
+		goto done;
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
+		transaction->state = REF_TRANSACTION_CLOSED;
+		strbuf_addf(errbuf, "reftable: transaction prepare: %s",
+			    reftable_error_str(err));
+	}
+
+	return err;
+}
+
+static int reftable_transaction_abort(struct ref_store *ref_store,
+				      struct ref_transaction *transaction,
+				      struct strbuf *err)
+{
+	struct reftable_addition *add =
+		(struct reftable_addition *)transaction->backend_data;
+	reftable_addition_destroy(add);
+	transaction->backend_data = NULL;
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
+	uint64_t ts = reftable_stack_next_update_index(refs->stack);
+	int err = 0;
+	int i = 0;
+	struct reftable_log_record *logs =
+		calloc(transaction->nr, sizeof(*logs));
+	struct ref_update **sorted =
+		malloc(transaction->nr * sizeof(struct ref_update *));
+	COPY_ARRAY(sorted, transaction->updates, transaction->nr);
+	QSORT(sorted, transaction->nr, ref_update_cmp);
+	reftable_writer_set_limits(writer, ts, ts);
+
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = sorted[i];
+		struct reftable_log_record *log = &logs[i];
+		fill_reftable_log_record(log);
+		log->ref_name = (char *)u->refname;
+		log->old_hash = u->old_oid.hash;
+		log->new_hash = u->new_oid.hash;
+		log->update_index = ts;
+		log->message = u->msg;
+
+		if (u->flags & REF_LOG_ONLY) {
+			continue;
+		}
+
+		if (u->flags & REF_HAVE_NEW) {
+			struct reftable_ref_record ref = { NULL };
+			struct object_id peeled;
+
+			int peel_error = peel_object(&u->new_oid, &peeled);
+			ref.ref_name = (char *)u->refname;
+
+			if (!is_null_oid(&u->new_oid)) {
+				ref.value = u->new_oid.hash;
+			}
+			ref.update_index = ts;
+			if (!peel_error) {
+				ref.target_value = peeled.hash;
+			}
+
+			err = reftable_writer_add_ref(writer, &ref);
+			if (err < 0) {
+				goto done;
+			}
+		}
+	}
+
+	for (i = 0; i < transaction->nr; i++) {
+		err = reftable_writer_add_log(writer, &logs[i]);
+		clear_reftable_log_record(&logs[i]);
+		if (err < 0) {
+			goto done;
+		}
+	}
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	free(logs);
+	free(sorted);
+	return err;
+}
+
+static int reftable_transaction_finish(struct ref_store *ref_store,
+				       struct ref_transaction *transaction,
+				       struct strbuf *errmsg)
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
+
+	err = reftable_addition_add(add, &write_transaction_table, transaction);
+	if (err < 0) {
+		goto done;
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
+reftable_transaction_initial_commit(struct ref_store *ref_store,
+				    struct ref_transaction *transaction,
+				    struct strbuf *errmsg)
+{
+	int err = reftable_transaction_prepare(ref_store, transaction, errmsg);
+	if (err)
+		return err;
+
+	return reftable_transaction_finish(ref_store, transaction, errmsg);
+}
+
+struct write_pseudoref_arg {
+	struct reftable_stack *stack;
+	const char *pseudoref;
+	const struct object_id *new_oid;
+	const struct object_id *old_oid;
+};
+
+static int write_pseudoref_table(struct reftable_writer *writer, void *argv)
+{
+	struct write_pseudoref_arg *arg = (struct write_pseudoref_arg *)argv;
+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	int err = 0;
+	struct reftable_ref_record read_ref = { NULL };
+	struct reftable_ref_record write_ref = { NULL };
+
+	reftable_writer_set_limits(writer, ts, ts);
+	if (arg->old_oid) {
+		struct object_id read_oid;
+		err = reftable_stack_read_ref(arg->stack, arg->pseudoref,
+					      &read_ref);
+		if (err < 0)
+			goto done;
+
+		if ((err > 0) != is_null_oid(arg->old_oid)) {
+			err = REFTABLE_LOCK_ERROR;
+			goto done;
+		}
+
+		/* XXX If old_oid is set, and we have a symref? */
+
+		if (err == 0 && read_ref.value == NULL) {
+			err = REFTABLE_LOCK_ERROR;
+			goto done;
+		}
+
+		hashcpy(read_oid.hash, read_ref.value);
+		if (!oideq(arg->old_oid, &read_oid)) {
+			err = REFTABLE_LOCK_ERROR;
+			goto done;
+		}
+	}
+
+	write_ref.ref_name = (char *)arg->pseudoref;
+	write_ref.update_index = ts;
+	if (!is_null_oid(arg->new_oid))
+		write_ref.value = (uint8_t *)arg->new_oid->hash;
+
+	err = reftable_writer_add_ref(writer, &write_ref);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_ref_record_clear(&read_ref);
+	return err;
+}
+
+static int reftable_write_pseudoref(struct ref_store *ref_store,
+				    const char *pseudoref,
+				    const struct object_id *oid,
+				    const struct object_id *old_oid,
+				    struct strbuf *errbuf)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct write_pseudoref_arg arg = {
+		.stack = refs->stack,
+		.pseudoref = pseudoref,
+		.new_oid = oid,
+	};
+	struct reftable_addition *add = NULL;
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+
+	err = reftable_stack_reload(refs->stack);
+	if (err) {
+		goto done;
+	}
+	err = reftable_stack_new_addition(&add, refs->stack);
+	if (err) {
+		goto done;
+	}
+	if (old_oid) {
+		struct object_id actual_old_oid;
+
+		/* XXX this is cut & paste from files-backend - should factor
+		 * out? */
+		if (read_ref(pseudoref, &actual_old_oid)) {
+			if (!is_null_oid(old_oid)) {
+				strbuf_addf(errbuf,
+					    _("could not read ref '%s'"),
+					    pseudoref);
+				goto done;
+			}
+		} else if (is_null_oid(old_oid)) {
+			strbuf_addf(errbuf, _("ref '%s' already exists"),
+				    pseudoref);
+			goto done;
+		} else if (!oideq(&actual_old_oid, old_oid)) {
+			strbuf_addf(errbuf,
+				    _("unexpected object ID when writing '%s'"),
+				    pseudoref);
+			goto done;
+		}
+	}
+
+	err = reftable_addition_add(add, &write_pseudoref_table, &arg);
+	if (err < 0) {
+		strbuf_addf(errbuf, "reftable: pseudoref update failure: %s",
+			    reftable_error_str(err));
+	}
+
+	err = reftable_addition_commit(add);
+	if (err < 0) {
+		strbuf_addf(errbuf, "reftable: pseudoref commit failure: %s",
+			    reftable_error_str(err));
+	}
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_addition_destroy(add);
+	return err;
+}
+
+static int reftable_delete_pseudoref(struct ref_store *ref_store,
+				     const char *pseudoref,
+				     const struct object_id *old_oid)
+{
+	struct strbuf errbuf = STRBUF_INIT;
+	int ret = reftable_write_pseudoref(ref_store, pseudoref, &null_oid,
+					   old_oid, &errbuf);
+	/* XXX what to do with the error message? */
+	strbuf_release(&errbuf);
+	return ret;
+}
+
+struct write_delete_refs_arg {
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
+			.ref_name = (char *)arg->refnames->items[i].string,
+			.update_index = ts,
+		};
+		err = reftable_writer_add_ref(writer, &ref);
+		if (err < 0) {
+			return err;
+		}
+	}
+
+	for (i = 0; i < arg->refnames->nr; i++) {
+		struct reftable_log_record log = { NULL };
+		struct reftable_ref_record current = { NULL };
+		fill_reftable_log_record(&log);
+		log.message = xstrdup(arg->logmsg);
+		log.new_hash = NULL;
+		log.old_hash = NULL;
+		log.update_index = ts;
+		log.ref_name = (char *)arg->refnames->items[i].string;
+
+		if (reftable_stack_read_ref(arg->stack, log.ref_name,
+					    &current) == 0) {
+			log.old_hash = current.value;
+		}
+		err = reftable_writer_add_log(writer, &log);
+		log.old_hash = NULL;
+		reftable_ref_record_clear(&current);
+
+		clear_reftable_log_record(&log);
+		if (err < 0) {
+			return err;
+		}
+	}
+	return 0;
+}
+
+static int reftable_delete_refs(struct ref_store *ref_store, const char *msg,
+				struct string_list *refnames,
+				unsigned int flags)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct write_delete_refs_arg arg = {
+		.stack = refs->stack,
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
+	err = reftable_stack_reload(refs->stack);
+	if (err) {
+		goto done;
+	}
+	err = reftable_stack_add(refs->stack, &write_delete_refs_table, &arg);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+static int reftable_pack_refs(struct ref_store *ref_store, unsigned int flags)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	if (refs->err < 0) {
+		return refs->err;
+	}
+	return reftable_stack_compact_all(refs->stack, NULL);
+}
+
+struct write_create_symref_arg {
+	struct git_reftable_ref_store *refs;
+	const char *refname;
+	const char *target;
+	const char *logmsg;
+};
+
+static int write_create_symref_table(struct reftable_writer *writer, void *arg)
+{
+	struct write_create_symref_arg *create =
+		(struct write_create_symref_arg *)arg;
+	uint64_t ts = reftable_stack_next_update_index(create->refs->stack);
+	int err = 0;
+
+	struct reftable_ref_record ref = {
+		.ref_name = (char *)create->refname,
+		.target = (char *)create->target,
+		.update_index = ts,
+	};
+	reftable_writer_set_limits(writer, ts, ts);
+	err = reftable_writer_add_ref(writer, &ref);
+	if (err < 0) {
+		return err;
+	}
+
+	{
+		struct reftable_log_record log = { NULL };
+		struct object_id new_oid;
+		struct object_id old_oid;
+		struct reftable_ref_record current = { NULL };
+		reftable_stack_read_ref(create->refs->stack, create->refname,
+					&current);
+
+		fill_reftable_log_record(&log);
+		log.ref_name = current.ref_name;
+		if (refs_resolve_ref_unsafe(
+			    (struct ref_store *)create->refs, create->refname,
+			    RESOLVE_REF_READING, &old_oid, NULL) != NULL) {
+			log.old_hash = old_oid.hash;
+		}
+
+		if (refs_resolve_ref_unsafe((struct ref_store *)create->refs,
+					    create->target, RESOLVE_REF_READING,
+					    &new_oid, NULL) != NULL) {
+			log.new_hash = new_oid.hash;
+		}
+
+		if (log.old_hash != NULL || log.new_hash != NULL) {
+			reftable_writer_add_log(writer, &log);
+		}
+		log.ref_name = NULL;
+		log.old_hash = NULL;
+		log.new_hash = NULL;
+		clear_reftable_log_record(&log);
+	}
+	return 0;
+}
+
+static int reftable_create_symref(struct ref_store *ref_store,
+				  const char *refname, const char *target,
+				  const char *logmsg)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct write_create_symref_arg arg = { .refs = refs,
+					       .refname = refname,
+					       .target = target,
+					       .logmsg = logmsg };
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+	err = reftable_stack_reload(refs->stack);
+	if (err) {
+		goto done;
+	}
+	err = reftable_stack_add(refs->stack, &write_create_symref_table, &arg);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+struct write_rename_arg {
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
+	struct reftable_ref_record ref = { NULL };
+	int err = reftable_stack_read_ref(arg->stack, arg->oldname, &ref);
+
+	if (err) {
+		goto done;
+	}
+
+	/* XXX do ref renames overwrite the target? */
+	if (reftable_stack_read_ref(arg->stack, arg->newname, &ref) == 0) {
+		goto done;
+	}
+
+	free(ref.ref_name);
+	ref.ref_name = strdup(arg->newname);
+	reftable_writer_set_limits(writer, ts, ts);
+	ref.update_index = ts;
+
+	{
+		struct reftable_ref_record todo[2] = { { NULL } };
+		todo[0].ref_name = (char *)arg->oldname;
+		todo[0].update_index = ts;
+		/* leave todo[0] empty */
+		todo[1] = ref;
+		todo[1].update_index = ts;
+
+		err = reftable_writer_add_refs(writer, todo, 2);
+		if (err < 0) {
+			goto done;
+		}
+	}
+
+	if (ref.value != NULL) {
+		struct reftable_log_record todo[2] = { { NULL } };
+		fill_reftable_log_record(&todo[0]);
+		fill_reftable_log_record(&todo[1]);
+
+		todo[0].ref_name = (char *)arg->oldname;
+		todo[0].update_index = ts;
+		todo[0].message = (char *)arg->logmsg;
+		todo[0].old_hash = ref.value;
+		todo[0].new_hash = NULL;
+
+		todo[1].ref_name = (char *)arg->newname;
+		todo[1].update_index = ts;
+		todo[1].old_hash = NULL;
+		todo[1].new_hash = ref.value;
+		todo[1].message = (char *)arg->logmsg;
+
+		err = reftable_writer_add_logs(writer, todo, 2);
+
+		clear_reftable_log_record(&todo[0]);
+		clear_reftable_log_record(&todo[1]);
+
+		if (err < 0) {
+			goto done;
+		}
+
+	} else {
+		/* XXX symrefs? */
+	}
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_ref_record_clear(&ref);
+	return err;
+}
+
+static int reftable_rename_ref(struct ref_store *ref_store,
+			       const char *oldrefname, const char *newrefname,
+			       const char *logmsg)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct write_rename_arg arg = {
+		.stack = refs->stack,
+		.oldname = oldrefname,
+		.newname = newrefname,
+		.logmsg = logmsg,
+	};
+	int err = refs->err;
+	if (err < 0) {
+		goto done;
+	}
+	err = reftable_stack_reload(refs->stack);
+	if (err) {
+		goto done;
+	}
+
+	err = reftable_stack_add(refs->stack, &write_rename_table, &arg);
+done:
+	assert(err != REFTABLE_API_ERROR);
+	return err;
+}
+
+static int reftable_copy_ref(struct ref_store *ref_store,
+			     const char *oldrefname, const char *newrefname,
+			     const char *logmsg)
+{
+	BUG("reftable reference store does not support copying references");
+}
+
+struct reftable_reflog_ref_iterator {
+	struct ref_iterator base;
+	struct reftable_iterator iter;
+	struct reftable_log_record log;
+	struct object_id oid;
+	char *last_name;
+};
+
+static int
+reftable_reflog_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct reftable_reflog_ref_iterator *ri =
+		(struct reftable_reflog_ref_iterator *)ref_iterator;
+
+	while (1) {
+		int err = reftable_iterator_next_log(&ri->iter, &ri->log);
+		if (err > 0) {
+			return ITER_DONE;
+		}
+		if (err < 0) {
+			return ITER_ERROR;
+		}
+
+		ri->base.refname = ri->log.ref_name;
+		if (ri->last_name != NULL &&
+		    !strcmp(ri->log.ref_name, ri->last_name)) {
+			/* we want the refnames that we have reflogs for, so we
+			 * skip if we've already produced this name. This could
+			 * be faster by seeking directly to
+			 * reflog@update_index==0.
+			 */
+			continue;
+		}
+
+		free(ri->last_name);
+		ri->last_name = xstrdup(ri->log.ref_name);
+		hashcpy(ri->oid.hash, ri->log.new_hash);
+		return ITER_OK;
+	}
+}
+
+static int reftable_reflog_ref_iterator_peel(struct ref_iterator *ref_iterator,
+					     struct object_id *peeled)
+{
+	BUG("not supported.");
+	return -1;
+}
+
+static int reftable_reflog_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct reftable_reflog_ref_iterator *ri =
+		(struct reftable_reflog_ref_iterator *)ref_iterator;
+	reftable_log_record_clear(&ri->log);
+	reftable_iterator_destroy(&ri->iter);
+	return 0;
+}
+
+static struct ref_iterator_vtable reftable_reflog_ref_iterator_vtable = {
+	reftable_reflog_ref_iterator_advance, reftable_reflog_ref_iterator_peel,
+	reftable_reflog_ref_iterator_abort
+};
+
+static struct ref_iterator *
+reftable_reflog_iterator_begin(struct ref_store *ref_store)
+{
+	struct reftable_reflog_ref_iterator *ri = xcalloc(sizeof(*ri), 1);
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+
+	struct reftable_merged_table *mt =
+		reftable_stack_merged_table(refs->stack);
+	int err = reftable_merged_table_seek_log(mt, &ri->iter, "");
+	if (err < 0) {
+		free(ri);
+		return NULL;
+	}
+
+	base_ref_iterator_init(&ri->base, &reftable_reflog_ref_iterator_vtable,
+			       1);
+	ri->base.oid = &ri->oid;
+
+	return (struct ref_iterator *)ri;
+}
+
+static int
+reftable_for_each_reflog_ent_newest_first(struct ref_store *ref_store,
+					  const char *refname,
+					  each_reflog_ent_fn fn, void *cb_data)
+{
+	struct reftable_iterator it = { NULL };
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_merged_table *mt = NULL;
+	int err = 0;
+	struct reftable_log_record log = { NULL };
+
+	if (refs->err < 0) {
+		return refs->err;
+	}
+
+	mt = reftable_stack_merged_table(refs->stack);
+	err = reftable_merged_table_seek_log(mt, &it, refname);
+	while (err == 0) {
+		err = reftable_iterator_next_log(&it, &log);
+		if (err != 0) {
+			break;
+		}
+
+		if (strcmp(log.ref_name, refname)) {
+			break;
+		}
+
+		{
+			struct object_id old_oid;
+			struct object_id new_oid;
+			const char *full_committer = "";
+
+			hashcpy(old_oid.hash, log.old_hash);
+			hashcpy(new_oid.hash, log.new_hash);
+
+			full_committer = fmt_ident(log.name, log.email,
+						   WANT_COMMITTER_IDENT,
+						   /*date*/ NULL,
+						   IDENT_NO_DATE);
+			if (fn(&old_oid, &new_oid, full_committer, log.time,
+			       log.tz_offset, log.message, cb_data)) {
+				err = -1;
+				break;
+			}
+		}
+	}
+
+	reftable_log_record_clear(&log);
+	reftable_iterator_destroy(&it);
+	if (err > 0) {
+		err = 0;
+	}
+	return err;
+}
+
+static int
+reftable_for_each_reflog_ent_oldest_first(struct ref_store *ref_store,
+					  const char *refname,
+					  each_reflog_ent_fn fn, void *cb_data)
+{
+	struct reftable_iterator it = { NULL };
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
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
+	mt = reftable_stack_merged_table(refs->stack);
+	err = reftable_merged_table_seek_log(mt, &it, refname);
+
+	while (err == 0) {
+		struct reftable_log_record log = { NULL };
+		err = reftable_iterator_next_log(&it, &log);
+		if (err != 0) {
+			break;
+		}
+
+		if (strcmp(log.ref_name, refname)) {
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
+		hashcpy(old_oid.hash, log->old_hash);
+		hashcpy(new_oid.hash, log->new_hash);
+
+		full_committer = fmt_ident(log->name, log->email,
+					   WANT_COMMITTER_IDENT, NULL,
+					   IDENT_NO_DATE);
+		if (!fn(&old_oid, &new_oid, full_committer, log->time,
+			log->tz_offset, log->message, cb_data)) {
+			err = -1;
+			break;
+		}
+	}
+
+	for (i = 0; i < len; i++) {
+		reftable_log_record_clear(&logs[i]);
+	}
+	free(logs);
+
+	reftable_iterator_destroy(&it);
+	if (err > 0) {
+		err = 0;
+	}
+	return err;
+}
+
+static int reftable_reflog_exists(struct ref_store *ref_store,
+				  const char *refname)
+{
+	/* always exists. */
+	return 1;
+}
+
+static int reftable_create_reflog(struct ref_store *ref_store,
+				  const char *refname, int force_create,
+				  struct strbuf *err)
+{
+	return 0;
+}
+
+static int reftable_delete_reflog(struct ref_store *ref_store,
+				  const char *refname)
+{
+	return 0;
+}
+
+struct reflog_expiry_arg {
+	struct git_reftable_ref_store *refs;
+	struct reftable_log_record *tombstones;
+	int len;
+	int cap;
+};
+
+static void clear_log_tombstones(struct reflog_expiry_arg *arg)
+{
+	int i = 0;
+	for (; i < arg->len; i++) {
+		reftable_log_record_clear(&arg->tombstones[i]);
+	}
+
+	FREE_AND_NULL(arg->tombstones);
+}
+
+static void add_log_tombstone(struct reflog_expiry_arg *arg,
+			      const char *refname, uint64_t ts)
+{
+	struct reftable_log_record tombstone = {
+		.ref_name = xstrdup(refname),
+		.update_index = ts,
+	};
+	if (arg->len == arg->cap) {
+		arg->cap = 2 * arg->cap + 1;
+		arg->tombstones =
+			realloc(arg->tombstones, arg->cap * sizeof(tombstone));
+	}
+	arg->tombstones[arg->len++] = tombstone;
+}
+
+static int write_reflog_expiry_table(struct reftable_writer *writer, void *argv)
+{
+	struct reflog_expiry_arg *arg = (struct reflog_expiry_arg *)argv;
+	uint64_t ts = reftable_stack_next_update_index(arg->refs->stack);
+	int i = 0;
+	reftable_writer_set_limits(writer, ts, ts);
+	for (i = 0; i < arg->len; i++) {
+		int err = reftable_writer_add_log(writer, &arg->tombstones[i]);
+		if (err) {
+			return err;
+		}
+	}
+	return 0;
+}
+
+static int reftable_reflog_expire(struct ref_store *ref_store,
+				  const char *refname,
+				  const struct object_id *oid,
+				  unsigned int flags,
+				  reflog_expiry_prepare_fn prepare_fn,
+				  reflog_expiry_should_prune_fn should_prune_fn,
+				  reflog_expiry_cleanup_fn cleanup_fn,
+				  void *policy_cb_data)
+{
+	/*
+	  For log expiry, we write tombstones in place of the expired entries,
+	  This means that the entries are still retrievable by delving into the
+	  stack, and expiring entries paradoxically takes extra memory.
+
+	  This memory is only reclaimed when some operation issues a
+	  reftable_pack_refs(), which will compact the entire stack and get rid
+	  of deletion entries.
+
+	  It would be better if the refs backend supported an API that sets a
+	  criterion for all refs, passing the criterion to pack_refs().
+	*/
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_merged_table *mt = NULL;
+	struct reflog_expiry_arg arg = {
+		.refs = refs,
+	};
+	struct reftable_log_record log = { NULL };
+	struct reftable_iterator it = { NULL };
+	int err = 0;
+	if (refs->err < 0) {
+		return refs->err;
+	}
+	err = reftable_stack_reload(refs->stack);
+	if (err) {
+		goto done;
+	}
+
+	mt = reftable_stack_merged_table(refs->stack);
+	err = reftable_merged_table_seek_log(mt, &it, refname);
+	if (err < 0) {
+		goto done;
+	}
+
+	while (1) {
+		struct object_id ooid;
+		struct object_id noid;
+
+		int err = reftable_iterator_next_log(&it, &log);
+		if (err < 0) {
+			goto done;
+		}
+
+		if (err > 0 || strcmp(log.ref_name, refname)) {
+			break;
+		}
+		hashcpy(ooid.hash, log.old_hash);
+		hashcpy(noid.hash, log.new_hash);
+
+		if (should_prune_fn(&ooid, &noid, log.email,
+				    (timestamp_t)log.time, log.tz_offset,
+				    log.message, policy_cb_data)) {
+			add_log_tombstone(&arg, refname, log.update_index);
+		}
+	}
+	err = reftable_stack_add(refs->stack, &write_reflog_expiry_table, &arg);
+
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_log_record_clear(&log);
+	reftable_iterator_destroy(&it);
+	clear_log_tombstones(&arg);
+	return err;
+}
+
+static int reftable_read_raw_ref(struct ref_store *ref_store,
+				 const char *refname, struct object_id *oid,
+				 struct strbuf *referent, unsigned int *type)
+{
+	struct git_reftable_ref_store *refs =
+		(struct git_reftable_ref_store *)ref_store;
+	struct reftable_ref_record ref = { NULL };
+	int err = 0;
+	if (refs->err < 0) {
+		return refs->err;
+	}
+
+	err = reftable_stack_read_ref(refs->stack, refname, &ref);
+	if (err > 0) {
+		errno = ENOENT;
+		err = -1;
+		goto done;
+	}
+	if (err < 0) {
+		errno = reftable_error_to_errno(err);
+		err = -1;
+		goto done;
+	}
+	if (ref.target != NULL) {
+		strbuf_reset(referent);
+		strbuf_addstr(referent, ref.target);
+		*type |= REF_ISSYMREF;
+	} else if (ref.value != NULL) {
+		hashcpy(oid->hash, ref.value);
+	} else {
+		*type |= REF_ISBROKEN;
+		errno = EINVAL;
+		err = -1;
+	}
+done:
+	assert(err != REFTABLE_API_ERROR);
+	reftable_ref_record_clear(&ref);
+	return err;
+}
+
+struct ref_storage_be refs_be_reftable = {
+	&refs_be_files,
+	"reftable",
+	git_reftable_ref_store_create,
+	reftable_init_db,
+	reftable_transaction_prepare,
+	reftable_transaction_finish,
+	reftable_transaction_abort,
+	reftable_transaction_initial_commit,
+
+	reftable_pack_refs,
+	reftable_create_symref,
+	reftable_delete_refs,
+	reftable_rename_ref,
+	reftable_copy_ref,
+
+	reftable_write_pseudoref,
+	reftable_delete_pseudoref,
+
+	reftable_ref_iterator_begin,
+	reftable_read_raw_ref,
+
+	reftable_reflog_iterator_begin,
+	reftable_for_each_reflog_ent_newest_first,
+	reftable_for_each_reflog_ent_oldest_first,
+	reftable_reflog_exists,
+	reftable_create_reflog,
+	reftable_delete_reflog,
+	reftable_reflog_expire,
+};
diff --git a/repository.c b/repository.c
index 6f7f6f002b1..087760bc184 100644
--- a/repository.c
+++ b/repository.c
@@ -178,6 +178,8 @@ int repo_init(struct repository *repo,
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
+	repo->ref_storage_format = xstrdup_or_null(format.ref_storage);
+
 	clear_repository_format(&format);
 	return 0;
 
diff --git a/repository.h b/repository.h
index 6534fbb7b31..f57b73f4a27 100644
--- a/repository.h
+++ b/repository.h
@@ -74,6 +74,9 @@ struct repository {
 	 */
 	struct ref_store *refs_private;
 
+	/* The format to use for the ref database. */
+	char *ref_storage_format;
+
 	/*
 	 * Contains path to often used file names.
 	 */
diff --git a/setup.c b/setup.c
index 65fe5ecefbe..2ef970f9f88 100644
--- a/setup.c
+++ b/setup.c
@@ -468,9 +468,11 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			if (!value)
 				return config_error_nonbool(var);
 			data->partial_clone = xstrdup(value);
-		} else if (!strcmp(ext, "worktreeconfig"))
+		} else if (!strcmp(ext, "worktreeconfig")) {
 			data->worktree_config = git_config_bool(var, value);
-		else
+		} else if (!strcmp(ext, "refstorage")) {
+			data->ref_storage = xstrdup(value);
+		} else
 			string_list_append(&data->unknown_extensions, ext);
 	}
 
@@ -559,6 +561,7 @@ void clear_repository_format(struct repository_format *format)
 	string_list_clear(&format->unknown_extensions, 0);
 	free(format->work_tree);
 	free(format->partial_clone);
+	free(format->ref_storage);
 	init_repository_format(format);
 }
 
@@ -1204,8 +1207,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
 			setup_git_env(gitdir);
 		}
-		if (startup_info->have_repository)
+		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+			the_repository->ref_storage_format =
+				xstrdup_or_null(repo_fmt.ref_storage);
+		}
 	}
 
 	strbuf_release(&dir);
diff --git a/t/t0031-reftable.sh b/t/t0031-reftable.sh
new file mode 100755
index 00000000000..52deba272f2
--- /dev/null
+++ b/t/t0031-reftable.sh
@@ -0,0 +1,142 @@
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
+initialize ()  {
+	rm -rf .git &&
+	git init --ref-storage=reftable &&
+	mv .git/hooks .git/hooks-disabled
+}
+
+test_expect_success 'delete ref' '
+	initialize &&
+	test_commit file &&
+	SHA=$(git show-ref -s --verify HEAD) &&
+	test_write_lines "$SHA refs/heads/master" "$SHA refs/tags/file" >expect &&
+	git show-ref > actual &&
+	! git update-ref -d refs/tags/file $INVALID_SHA1 &&
+	test_cmp expect actual &&
+	git update-ref -d refs/tags/file $SHA  &&
+	test_write_lines "$SHA refs/heads/master" >expect &&
+	git show-ref > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone calls transaction_initial_commit' '
+	test_commit message1 file1 &&
+	git clone . cloned &&
+	(test  -f cloned/file1 || echo "Fixme.")
+'
+
+test_expect_success 'basic operation of reftable storage: commit, show-ref' '
+	initialize &&
+	test_commit file &&
+	test_write_lines refs/heads/master refs/tags/file >expect &&
+	git show-ref &&
+	git show-ref | cut -f2 -d" " > actual &&
+	test_cmp actual expect
+'
+
+test_expect_success 'reflog, repack' '
+	initialize &&
+	for count in $(test_seq 1 10)
+	do
+		test_commit "number $count" file.t $count number-$count ||
+	        return 1
+	done &&
+	git pack-refs &&
+	ls -1 .git/reftable >table-files &&
+	test_line_count = 2 table-files &&
+	git reflog refs/heads/master >output &&
+	test_line_count = 10 output &&
+	grep "commit (initial): number 1" output &&
+	grep "commit: number 10" output &&
+	git gc &&
+	git reflog refs/heads/master >output &&
+	test_line_count = 0 output 
+'
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
+		print_ref "refs/heads/master" &&
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
+	git init --ref-storage=reftable &&
+	>expect &&
+	! git show-ref > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout unborn branch' '
+	initialize &&
+	git checkout -b master
+'
+
+
+test_expect_success 'dir/file conflict' '
+	initialize &&
+	test_commit file &&
+	! git branch master/forbidden
+'
+
+
+test_expect_success 'do not clobber existing repo' '
+	rm -rf .git &&
+	git init --ref-storage=files &&
+	cat .git/HEAD > expect &&
+	test_commit file &&
+	(git init --ref-storage=reftable || true) &&
+	cat .git/HEAD > actual &&
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
+ 	git rebase source &&
+	test -f file2
+'
+
+test_done
+
-- 
gitgitgadget

