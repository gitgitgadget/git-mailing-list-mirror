Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5963C34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 08:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F94720658
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 08:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQUiPm0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgBRInv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:43:51 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:34502 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgBRInu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 03:43:50 -0500
Received: by mail-wr1-f53.google.com with SMTP id n10so20883118wrm.1
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 00:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vd6K2Nex6sGmfVOn71wD09zbdVFbu1eX7JBo5bYLbyM=;
        b=jQUiPm0TP9Xj2/2xdYZWeud46FLJcJ96/GHXDeKD6mp0F4NZ2VEVy26lpt7ZAajJYc
         CAYrB2wKbr6be2/lUKn3B1STNzuy5BWvAUufD/orpQQOLvkXQR6DPH2R314Z1a+9sjnn
         vWmk1joXmW48t/9uiYGAVrEoKyE8Eqw9ajIAsp3hF/cHd+z8M6+aXZ3u1WSo02f8Vg7a
         6IB7BBN8j9CZj+fCOMFdoUJnJAOX8cIDlG2dfq+4DJ8GInWTozN46SNFX02YwqBwdwOA
         5FYcP2Qg9uHfFaP8AFAvrrAaCzu3iSjFvJjIN0A3YdfHqiV+3aKN0jaJuWHP4Z80yiCG
         nHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vd6K2Nex6sGmfVOn71wD09zbdVFbu1eX7JBo5bYLbyM=;
        b=VPk67DkWJiN8H9n1DBxPQPzo6V7B8lqlJVXpybWmDEv/kfLBwp4FX7fOGAR3UP9iI5
         Wr0VUM/swJrE4h+KGA460FDQh3BSmBQi22pxJfh+V/nx0KoXI+8DHeOOca4UmtCQK35n
         szWfrsVuko1inZLDgqktSkzkQA/9qcuYRk6o280X5s9ZX3tEhpD0H9sCL3+yns+9EZk2
         YYnwGy/v/VbcU2Pu44S1jELphxrI7KTDeDmXsA8gStgxIttLXLDR0MdcIt8e+iu34t8l
         kIKojl+sO/6BHGM/4+4tiaMRNtOgVTm4OFXNp+xuIP8aJPDetQtGFtQLkLuDPpxvdI1p
         VntA==
X-Gm-Message-State: APjAAAUKYFQRR6ITOjGfyFn9sdrRqH1Fh/qot4XiPcc8rUTaETQI6u3U
        mFcWAVO4Jh/XsVHbrmKKjQHyJMDu
X-Google-Smtp-Source: APXvYqyPdL6ZjFsYasHAUuLp7lqr3DNbE230vYIa7qJkkJwaOZwQeKmESnMQp8p91/DSuDNcU62joQ==
X-Received: by 2002:adf:f406:: with SMTP id g6mr27942690wro.189.1582015426360;
        Tue, 18 Feb 2020 00:43:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s23sm5132774wra.15.2020.02.18.00.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 00:43:45 -0800 (PST)
Message-Id: <8d95ab52f75cad386e7bb22ca2dfae4606b276ef.1582015420.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
        <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Feb 2020 08:43:40 +0000
Subject: [PATCH v6 5/5] Reftable support for git-core
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

TODO:

 * Resolve spots marked with XXX
 * Test strategy?

Example use:

  $ ~/vc/git/git init --reftable
  warning: templates not found in /usr/local/google/home/hanwen/share/git-core/templates
  Initialized empty Git repository in /tmp/qz/.git/
  $ echo q > a
  $ ~/vc/git/git add a
  $ ~/vc/git/git commit -mx
  fatal: not a git repository (or any of the parent directories): .git
  [master (root-commit) 373d969] x
   1 file changed, 1 insertion(+)
   create mode 100644 a
  $ ~/vc/git/git show-ref
  373d96972fca9b63595740bba3898a762778ba20 HEAD
  373d96972fca9b63595740bba3898a762778ba20 refs/heads/master
  $ ls -l .git/reftable/
  total 12
  -rw------- 1 hanwen primarygroup  126 Jan 23 20:08 000000000001-000000000001.ref
  -rw------- 1 hanwen primarygroup 4277 Jan 23 20:08 000000000002-000000000002.ref
  $ go run ~/vc/reftable/cmd/dump.go  -table /tmp/qz/.git/reftable/000000000002-000000000002.ref
  ** DEBUG **
  name /tmp/qz/.git/reftable/000000000002-000000000002.ref, sz 4209: 'r' reftable.readerOffsets{Present:true, Offset:0x0, IndexOffset:0x0}, 'o' reftable.readerOffsets{Present:false, Offset:0x0, IndexOffset:0x0} 'g' reftable.readerOffsets{Present:true, Offset:0x1000, IndexOffset:0x0}
  ** REFS **
  reftable.RefRecord{RefName:"refs/heads/master", UpdateIndex:0x2, Value:[]uint8{0x37, 0x3d, 0x96, 0x97, 0x2f, 0xca, 0x9b, 0x63, 0x59, 0x57, 0x40, 0xbb, 0xa3, 0x89, 0x8a, 0x76, 0x27, 0x78, 0xba, 0x20}, TargetValue:[]uint8(nil), Target:""}
  ** LOGS **
  reftable.LogRecord{RefName:"HEAD", UpdateIndex:0x2, New:[]uint8{0x37, 0x3d, 0x96, 0x97, 0x2f, 0xca, 0x9b, 0x63, 0x59, 0x57, 0x40, 0xbb, 0xa3, 0x89, 0x8a, 0x76, 0x27, 0x78, 0xba, 0x20}, Old:[]uint8{0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, Name:"Han-Wen Nienhuys", Email:"hanwen@google.com", Time:0x5e29ef27, TZOffset:100, Message:"commit (initial): x\n"}

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Co-authored-by: Jeff King <peff@peff.net>
---
 .../technical/repository-version.txt          |   7 +
 Makefile                                      |  24 +-
 builtin/clone.c                               |   4 +-
 builtin/init-db.c                             |  55 +-
 cache.h                                       |   4 +-
 refs.c                                        |  20 +-
 refs.h                                        |   3 +
 refs/refs-internal.h                          |   1 +
 refs/reftable-backend.c                       | 971 ++++++++++++++++++
 repository.c                                  |   2 +
 repository.h                                  |   3 +
 setup.c                                       |  12 +-
 12 files changed, 1077 insertions(+), 29 deletions(-)
 create mode 100644 refs/reftable-backend.c

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
index 6134104ae65..706bb0a9814 100644
--- a/Makefile
+++ b/Makefile
@@ -814,6 +814,7 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
+REFTABLE_LIB = reftable/libreftable.a
 
 GENERATED_H += command-list.h
 
@@ -959,6 +960,7 @@ LIB_OBJS += rebase-interactive.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/files-backend.o
+LIB_OBJS += refs/reftable-backend.o
 LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
@@ -1163,7 +1165,7 @@ THIRD_PARTY_SOURCES += compat/regex/%
 THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB)
+GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -2347,11 +2349,28 @@ VCSSVN_OBJS += vcs-svn/fast_export.o
 VCSSVN_OBJS += vcs-svn/svndiff.o
 VCSSVN_OBJS += vcs-svn/svndump.o
 
+REFTABLE_OBJS += reftable/basics.o
+REFTABLE_OBJS += reftable/block.o
+REFTABLE_OBJS += reftable/bytes.o
+REFTABLE_OBJS += reftable/file.o
+REFTABLE_OBJS += reftable/iter.o
+REFTABLE_OBJS += reftable/merged.o
+REFTABLE_OBJS += reftable/pq.o
+REFTABLE_OBJS += reftable/reader.o
+REFTABLE_OBJS += reftable/record.o
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
@@ -2488,6 +2507,9 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 $(VCSSVN_LIB): $(VCSSVN_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+$(REFTABLE_LIB): $(REFTABLE_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+
 export DEFAULT_EDITOR DEFAULT_PAGER
 
 Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
diff --git a/builtin/clone.c b/builtin/clone.c
index 4f6150c55c3..4bcea0c18da 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1097,7 +1097,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	init_db(git_dir, real_git_dir, option_template, INIT_DB_QUIET);
+	init_db(git_dir, real_git_dir, option_template,
+		DEFAULT_REF_STORAGE, /* XXX */
+		INIT_DB_QUIET);
 
 	if (real_git_dir)
 		git_dir = real_git_dir;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 45bdea05890..d51a99ed77e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -177,7 +177,8 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 }
 
 static int create_default_files(const char *template_path,
-				const char *original_git_dir)
+				const char *original_git_dir,
+				const char *ref_storage_format, int flags)
 {
 	struct stat st1;
 	struct strbuf buf = STRBUF_INIT;
@@ -213,6 +214,7 @@ static int create_default_files(const char *template_path,
 	is_bare_repository_cfg = init_is_bare_repository;
 	if (init_shared_repository != -1)
 		set_shared_repository(init_shared_repository);
+	the_repository->ref_storage_format = xstrdup(ref_storage_format);
 
 	/*
 	 * We would have created the above under user's umask -- under
@@ -222,6 +224,15 @@ static int create_default_files(const char *template_path,
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
 	/*
 	 * We need to create a "refs" dir in any case so that older
 	 * versions of git can tell that this is a repository.
@@ -234,17 +245,21 @@ static int create_default_files(const char *template_path,
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
 	 */
-	path = git_path_buf(&buf, "HEAD");
-	reinit = (!access(path, R_OK)
-		  || readlink(path, junk, sizeof(junk)-1) != -1);
 	if (!reinit) {
 		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
 			exit(1);
+	} else {
+		/*
+		 * XXX should check whether our ref backend matches the
+		 * original one; if not, either die() or convert
+		 */
 	}
 
 	/* This forces creation of new config file */
-	xsnprintf(repo_version_string, sizeof(repo_version_string),
-		  "%d", GIT_REPO_VERSION);
+	xsnprintf(repo_version_string, sizeof(repo_version_string), "%d",
+		  !strcmp(ref_storage_format, "reftable") ?
+			  GIT_REPO_VERSION_READ :
+			  GIT_REPO_VERSION);
 	git_config_set("core.repositoryformatversion", repo_version_string);
 
 	/* Check filemode trustability */
@@ -339,7 +354,8 @@ static void separate_git_dir(const char *git_dir, const char *git_link)
 }
 
 int init_db(const char *git_dir, const char *real_git_dir,
-	    const char *template_dir, unsigned int flags)
+	    const char *template_dir, const char *ref_storage_format,
+	    unsigned int flags)
 {
 	int reinit;
 	int exist_ok = flags & INIT_DB_EXIST_OK;
@@ -378,7 +394,8 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 */
 	check_repository_format();
 
-	reinit = create_default_files(template_dir, original_git_dir);
+	reinit = create_default_files(template_dir, original_git_dir,
+				      ref_storage_format, flags);
 
 	create_object_directory();
 
@@ -403,6 +420,8 @@ int init_db(const char *git_dir, const char *real_git_dir,
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
 
+	git_config_set("extensions.refStorage", ref_storage_format);
+
 	if (!(flags & INIT_DB_QUIET)) {
 		int len = strlen(git_dir);
 
@@ -476,20 +495,24 @@ static const char *const init_db_usage[] = {
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
+	const char *ref_storage_format = DEFAULT_REF_STORAGE;
 	const char *real_git_dir = NULL;
 	const char *work_tree;
 	const char *template_dir = NULL;
 	unsigned int flags = 0;
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
 		OPT_END()
@@ -591,9 +614,11 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	}
 
 	UNLEAK(real_git_dir);
+	UNLEAK(ref_storage_format);
 	UNLEAK(git_dir);
 	UNLEAK(work_tree);
 
 	flags |= INIT_DB_EXIST_OK;
-	return init_db(git_dir, real_git_dir, template_dir, flags);
+	return init_db(git_dir, real_git_dir, template_dir, ref_storage_format,
+		       flags);
 }
diff --git a/cache.h b/cache.h
index 37c899b53f7..4d905e2d565 100644
--- a/cache.h
+++ b/cache.h
@@ -627,7 +627,8 @@ int path_inside_repo(const char *prefix, const char *path);
 #define INIT_DB_EXIST_OK 0x0002
 
 int init_db(const char *git_dir, const char *real_git_dir,
-	    const char *template_dir, unsigned int flags);
+	    const char *template_dir, const char *ref_storage_format,
+	    unsigned int flags);
 
 void sanitize_stdfds(void);
 int daemonize(void);
@@ -1041,6 +1042,7 @@ struct repository_format {
 	int is_bare;
 	int hash_algo;
 	char *work_tree;
+	char *ref_storage;
 	struct string_list unknown_extensions;
 };
 
diff --git a/refs.c b/refs.c
index 1ab0bb54d3d..6530219762f 100644
--- a/refs.c
+++ b/refs.c
@@ -20,7 +20,7 @@
 /*
  * List of all available backends
  */
-static struct ref_storage_be *refs_backends = &refs_be_files;
+static struct ref_storage_be *refs_backends = &refs_be_reftable;
 
 static struct ref_storage_be *find_ref_storage_backend(const char *name)
 {
@@ -1836,13 +1836,13 @@ static struct ref_store *lookup_ref_store_map(struct hashmap *map,
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
 
@@ -1858,7 +1858,10 @@ struct ref_store *get_main_ref_store(struct repository *r)
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
+	r->refs = ref_store_init(r->gitdir,
+				 r->ref_storage_format ? r->ref_storage_format :
+							 DEFAULT_REF_STORAGE,
+				 REF_STORE_ALL_CAPS);
 	return r->refs;
 }
 
@@ -1913,7 +1916,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		goto done;
 
 	/* assume that add_submodule_odb() has been called */
-	refs = ref_store_init(submodule_sb.buf,
+	refs = ref_store_init(submodule_sb.buf, DEFAULT_REF_STORAGE, /* XXX */
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&submodule_ref_stores, "submodule",
 			       refs, submodule);
@@ -1927,6 +1930,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 
 struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 {
+	const char *format = DEFAULT_REF_STORAGE; /* XXX */
 	struct ref_store *refs;
 	const char *id;
 
@@ -1940,9 +1944,9 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 
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
index 87c9ec921b9..2b5985ad593 100644
--- a/refs.h
+++ b/refs.h
@@ -9,6 +9,9 @@ struct string_list;
 struct string_list_item;
 struct worktree;
 
+/* XXX where should this be? */
+#define DEFAULT_REF_STORAGE "files"
+
 /*
  * Resolve a reference, recursively following symbolic refererences.
  *
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 1d7a4852209..d87e9cbdec7 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -661,6 +661,7 @@ struct ref_storage_be {
 };
 
 extern struct ref_storage_be refs_be_files;
+extern struct ref_storage_be refs_be_reftable;
 extern struct ref_storage_be refs_be_packed;
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
new file mode 100644
index 00000000000..02ba4fae964
--- /dev/null
+++ b/refs/reftable-backend.c
@@ -0,0 +1,971 @@
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
+struct reftable_ref_store {
+	struct ref_store base;
+	unsigned int store_flags;
+
+	int err;
+	char *reftable_dir;
+	char *table_list_file;
+	struct stack *stack;
+};
+
+static void clear_log_record(struct log_record *log)
+{
+	log->old_hash = NULL;
+	log->new_hash = NULL;
+	log->message = NULL;
+	log->ref_name = NULL;
+	log_record_clear(log);
+}
+
+static void fill_log_record(struct log_record *log)
+{
+	const char *info = git_committer_info(0);
+	struct ident_split split = {};
+	int result = split_ident_line(&split, info, strlen(info));
+	int sign = 1;
+	assert(0 == result);
+
+	log_record_clear(log);
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
+static struct ref_store *reftable_ref_store_create(const char *path,
+						   unsigned int store_flags)
+{
+	struct reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
+	struct ref_store *ref_store = (struct ref_store *)refs;
+	struct write_options cfg = {
+		.block_size = 4096,
+		.hash_size = the_hash_algo->rawsz,
+	};
+	struct strbuf sb = STRBUF_INIT;
+
+	base_ref_store_init(ref_store, &refs_be_reftable);
+	refs->store_flags = store_flags;
+
+	strbuf_addf(&sb, "%s/reftable", path);
+	refs->reftable_dir = xstrdup(sb.buf);
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/reftable/tables.list", path);
+	refs->table_list_file = xstrdup(sb.buf);
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/refs", path);
+	safe_create_dir(sb.buf, 1);
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/HEAD", path);
+	write_file(sb.buf, "ref: refs/.invalid");
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "%s/refs/heads", path);
+	write_file(sb.buf, "this repository uses the reftable format");
+
+	refs->err = new_stack(&refs->stack, refs->reftable_dir,
+			      refs->table_list_file, cfg);
+	strbuf_release(&sb);
+	return ref_store;
+}
+
+static int reftable_init_db(struct ref_store *ref_store, struct strbuf *err)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	FILE *file;
+	safe_create_dir(refs->reftable_dir, 1);
+
+	file = fopen(refs->table_list_file, "a");
+	if (file == NULL) {
+		return -1;
+	}
+	fclose(file);
+	return 0;
+}
+
+struct reftable_iterator {
+	struct ref_iterator base;
+	struct iterator iter;
+	struct ref_record ref;
+	struct object_id oid;
+	struct ref_store *ref_store;
+	unsigned int flags;
+	int err;
+	char *prefix;
+};
+
+static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct reftable_iterator *ri = (struct reftable_iterator *)ref_iterator;
+	while (ri->err == 0) {
+		ri->err = iterator_next_ref(ri->iter, &ri->ref);
+		if (ri->err) {
+			break;
+		}
+
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
+	struct reftable_iterator *ri = (struct reftable_iterator *)ref_iterator;
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
+	struct reftable_iterator *ri = (struct reftable_iterator *)ref_iterator;
+	ref_record_clear(&ri->ref);
+	iterator_destroy(&ri->iter);
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
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	struct reftable_iterator *ri = xcalloc(1, sizeof(*ri));
+	struct merged_table *mt = NULL;
+
+	mt = stack_merged_table(refs->stack);
+	ri->err = refs->err;
+	if (ri->err == 0) {
+		ri->err = merged_table_seek_ref(mt, &ri->iter, prefix);
+	}
+	base_ref_iterator_init(&ri->base, &reftable_ref_iterator_vtable, 1);
+	ri->base.oid = &ri->oid;
+	ri->flags = flags;
+	ri->ref_store = ref_store;
+	return &ri->base;
+}
+
+static int reftable_transaction_prepare(struct ref_store *ref_store,
+					struct ref_transaction *transaction,
+					struct strbuf *err)
+{
+	return 0;
+}
+
+static int reftable_transaction_abort(struct ref_store *ref_store,
+				      struct ref_transaction *transaction,
+				      struct strbuf *err)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	(void)refs;
+	return 0;
+}
+
+static int reftable_check_old_oid(struct ref_store *refs, const char *refname,
+				  struct object_id *want_oid)
+{
+	struct object_id out_oid = {};
+	int out_flags = 0;
+	const char *resolved = refs_resolve_ref_unsafe(
+		refs, refname, RESOLVE_REF_READING, &out_oid, &out_flags);
+	if (is_null_oid(want_oid) != (resolved == NULL)) {
+		return LOCK_ERROR;
+	}
+
+	if (resolved != NULL && !oideq(&out_oid, want_oid)) {
+		return LOCK_ERROR;
+	}
+
+	return 0;
+}
+
+static int ref_update_cmp(const void *a, const void *b)
+{
+	return strcmp(((struct ref_update *)a)->refname,
+		      ((struct ref_update *)b)->refname);
+}
+
+static int write_transaction_table(struct writer *writer, void *arg)
+{
+	struct ref_transaction *transaction = (struct ref_transaction *)arg;
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)transaction->ref_store;
+	uint64_t ts = stack_next_update_index(refs->stack);
+	int err = 0;
+	struct log_record *logs = calloc(transaction->nr, sizeof(*logs));
+	struct ref_update **sorted =
+		malloc(transaction->nr * sizeof(struct ref_update *));
+	COPY_ARRAY(sorted, transaction->updates, transaction->nr);
+	QSORT(sorted, transaction->nr, ref_update_cmp);
+	writer_set_limits(writer, ts, ts);
+
+	for (int i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = sorted[i];
+		if (u->flags & REF_HAVE_OLD) {
+			err = reftable_check_old_oid(transaction->ref_store,
+						     u->refname, &u->old_oid);
+			if (err < 0) {
+				goto exit;
+			}
+		}
+	}
+
+	for (int i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = sorted[i];
+		struct log_record *log = &logs[i];
+		fill_log_record(log);
+		log->ref_name = (char *)u->refname;
+		log->old_hash = u->old_oid.hash;
+		log->new_hash = u->new_oid.hash;
+		log->update_index = ts;
+		log->message = u->msg;
+
+		if (u->flags & REF_HAVE_NEW) {
+			struct object_id out_oid = {};
+			int out_flags = 0;
+			/* Memory owned by refs_resolve_ref_unsafe, no need to
+			 * free(). */
+			const char *resolved = refs_resolve_ref_unsafe(
+				transaction->ref_store, u->refname, 0, &out_oid,
+				&out_flags);
+			struct ref_record ref = {};
+			ref.ref_name =
+				(char *)(resolved ? resolved : u->refname);
+			log->ref_name = ref.ref_name;
+			ref.value = u->new_oid.hash;
+			ref.update_index = ts;
+			err = writer_add_ref(writer, &ref);
+			if (err < 0) {
+				goto exit;
+			}
+		}
+	}
+
+	for (int i = 0; i < transaction->nr; i++) {
+		err = writer_add_log(writer, &logs[i]);
+		clear_log_record(&logs[i]);
+		if (err < 0) {
+			goto exit;
+		}
+	}
+
+exit:
+	free(logs);
+	free(sorted);
+	return err;
+}
+
+static int reftable_transaction_commit(struct ref_store *ref_store,
+				       struct ref_transaction *transaction,
+				       struct strbuf *errmsg)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	int err = stack_add(refs->stack, &write_transaction_table, transaction);
+	if (err < 0) {
+		strbuf_addf(errmsg, "reftable: transaction failure %s",
+			    error_str(err));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int reftable_transaction_finish(struct ref_store *ref_store,
+				       struct ref_transaction *transaction,
+				       struct strbuf *err)
+{
+	return reftable_transaction_commit(ref_store, transaction, err);
+}
+
+struct write_delete_refs_arg {
+	struct stack *stack;
+	struct string_list *refnames;
+	const char *logmsg;
+	unsigned int flags;
+};
+
+static int write_delete_refs_table(struct writer *writer, void *argv)
+{
+	struct write_delete_refs_arg *arg =
+		(struct write_delete_refs_arg *)argv;
+	uint64_t ts = stack_next_update_index(arg->stack);
+	int err = 0;
+
+	writer_set_limits(writer, ts, ts);
+	for (int i = 0; i < arg->refnames->nr; i++) {
+		struct ref_record ref = {
+			.ref_name = (char *)arg->refnames->items[i].string,
+			.update_index = ts,
+		};
+		err = writer_add_ref(writer, &ref);
+		if (err < 0) {
+			return err;
+		}
+	}
+
+	for (int i = 0; i < arg->refnames->nr; i++) {
+		struct log_record log = {};
+		struct ref_record current = {};
+		fill_log_record(&log);
+		log.message = xstrdup(arg->logmsg);
+		log.new_hash = NULL;
+		log.old_hash = NULL;
+		log.update_index = ts;
+		log.ref_name = (char *)arg->refnames->items[i].string;
+
+		if (stack_read_ref(arg->stack, log.ref_name, &current) == 0) {
+			log.old_hash = current.value;
+		}
+		err = writer_add_log(writer, &log);
+		log.old_hash = NULL;
+		ref_record_clear(&current);
+
+		clear_log_record(&log);
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
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	struct write_delete_refs_arg arg = {
+		.stack = refs->stack,
+		.refnames = refnames,
+		.logmsg = msg,
+		.flags = flags,
+	};
+	return stack_add(refs->stack, &write_delete_refs_table, &arg);
+}
+
+static int reftable_pack_refs(struct ref_store *ref_store, unsigned int flags)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	return stack_compact_all(refs->stack, NULL);
+}
+
+struct write_create_symref_arg {
+	struct reftable_ref_store *refs;
+	const char *refname;
+	const char *target;
+	const char *logmsg;
+};
+
+static int write_create_symref_table(struct writer *writer, void *arg)
+{
+	struct write_create_symref_arg *create =
+		(struct write_create_symref_arg *)arg;
+	uint64_t ts = stack_next_update_index(create->refs->stack);
+	int err = 0;
+
+	struct ref_record ref = {
+		.ref_name = (char *)create->refname,
+		.target = (char *)create->target,
+		.update_index = ts,
+	};
+	writer_set_limits(writer, ts, ts);
+	err = writer_add_ref(writer, &ref);
+	if (err < 0) {
+		return err;
+	}
+
+	{
+		struct log_record log = {};
+		struct object_id new_oid = {};
+		struct object_id old_oid = {};
+		struct ref_record current = {};
+		stack_read_ref(create->refs->stack, create->refname, &current);
+
+		fill_log_record(&log);
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
+			writer_add_log(writer, &log);
+		}
+		log.ref_name = NULL;
+		log.old_hash = NULL;
+		log.new_hash = NULL;
+		clear_log_record(&log);
+	}
+	return 0;
+}
+
+static int reftable_create_symref(struct ref_store *ref_store,
+				  const char *refname, const char *target,
+				  const char *logmsg)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	struct write_create_symref_arg arg = { .refs = refs,
+					       .refname = refname,
+					       .target = target,
+					       .logmsg = logmsg };
+	return stack_add(refs->stack, &write_create_symref_table, &arg);
+}
+
+struct write_rename_arg {
+	struct stack *stack;
+	const char *oldname;
+	const char *newname;
+	const char *logmsg;
+};
+
+static int write_rename_table(struct writer *writer, void *argv)
+{
+	struct write_rename_arg *arg = (struct write_rename_arg *)argv;
+	uint64_t ts = stack_next_update_index(arg->stack);
+	struct ref_record ref = {};
+	int err = stack_read_ref(arg->stack, arg->oldname, &ref);
+	if (err) {
+		goto exit;
+	}
+
+	/* XXX do ref renames overwrite the target? */
+	if (stack_read_ref(arg->stack, arg->newname, &ref) == 0) {
+		goto exit;
+	}
+
+	free(ref.ref_name);
+	ref.ref_name = strdup(arg->newname);
+	writer_set_limits(writer, ts, ts);
+	ref.update_index = ts;
+
+	{
+		struct ref_record todo[2] = {};
+		todo[0].ref_name = (char *)arg->oldname;
+		todo[0].update_index = ts;
+		/* leave todo[0] empty */
+		todo[1] = ref;
+		todo[1].update_index = ts;
+
+		err = writer_add_refs(writer, todo, 2);
+		if (err < 0) {
+			goto exit;
+		}
+	}
+
+	if (ref.value != NULL) {
+		struct log_record todo[2] = {};
+		fill_log_record(&todo[0]);
+		fill_log_record(&todo[1]);
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
+		err = writer_add_logs(writer, todo, 2);
+
+		clear_log_record(&todo[0]);
+		clear_log_record(&todo[1]);
+
+		if (err < 0) {
+			goto exit;
+		}
+
+	} else {
+		/* XXX symrefs? */
+	}
+
+exit:
+	ref_record_clear(&ref);
+	return err;
+}
+
+static int reftable_rename_ref(struct ref_store *ref_store,
+			       const char *oldrefname, const char *newrefname,
+			       const char *logmsg)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	struct write_rename_arg arg = {
+		.stack = refs->stack,
+		.oldname = oldrefname,
+		.newname = newrefname,
+		.logmsg = logmsg,
+	};
+	return stack_add(refs->stack, &write_rename_table, &arg);
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
+	struct iterator iter;
+	struct log_record log;
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
+		int err = iterator_next_log(ri->iter, &ri->log);
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
+	log_record_clear(&ri->log);
+	iterator_destroy(&ri->iter);
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
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+
+	struct merged_table *mt = stack_merged_table(refs->stack);
+	int err = merged_table_seek_log(mt, &ri->iter, "");
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
+	struct iterator it = {};
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	struct merged_table *mt = stack_merged_table(refs->stack);
+	int err = merged_table_seek_log(mt, &it, refname);
+	struct log_record log = {};
+
+	while (err == 0) {
+		err = iterator_next_log(it, &log);
+		if (err != 0) {
+			break;
+		}
+
+		if (strcmp(log.ref_name, refname)) {
+			break;
+		}
+
+		{
+			struct object_id old_oid = {};
+			struct object_id new_oid = {};
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
+	log_record_clear(&log);
+	iterator_destroy(&it);
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
+	struct iterator it = {};
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	struct merged_table *mt = stack_merged_table(refs->stack);
+	int err = merged_table_seek_log(mt, &it, refname);
+
+	struct log_record *logs = NULL;
+	int cap = 0;
+	int len = 0;
+
+	while (err == 0) {
+		struct log_record log = {};
+		err = iterator_next_log(it, &log);
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
+	for (int i = len; i--;) {
+		struct log_record *log = &logs[i];
+		struct object_id old_oid = {};
+		struct object_id new_oid = {};
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
+	for (int i = 0; i < len; i++) {
+		log_record_clear(&logs[i]);
+	}
+	free(logs);
+
+	iterator_destroy(&it);
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
+	struct reftable_ref_store *refs;
+	struct log_record *tombstones;
+	int len;
+	int cap;
+};
+
+static void clear_log_tombstones(struct reflog_expiry_arg *arg)
+{
+	int i = 0;
+	for (; i < arg->len; i++) {
+		log_record_clear(&arg->tombstones[i]);
+	}
+
+	FREE_AND_NULL(arg->tombstones);
+}
+
+static void add_log_tombstone(struct reflog_expiry_arg *arg,
+			      const char *refname, uint64_t ts)
+{
+	struct log_record tombstone = {
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
+static int write_reflog_expiry_table(struct writer *writer, void *argv)
+{
+	struct reflog_expiry_arg *arg = (struct reflog_expiry_arg *)argv;
+	uint64_t ts = stack_next_update_index(arg->refs->stack);
+	int i = 0;
+	writer_set_limits(writer, ts, ts);
+	for (i = 0; i < arg->len; i++) {
+		int err = writer_add_log(writer, &arg->tombstones[i]);
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
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	struct merged_table *mt = stack_merged_table(refs->stack);
+	struct reflog_expiry_arg arg = {
+		.refs = refs,
+	};
+	struct log_record log = {};
+	struct iterator it = {};
+	int err = merged_table_seek_log(mt, &it, refname);
+	if (err < 0) {
+		return err;
+	}
+
+	while (1) {
+		struct object_id ooid = {};
+		struct object_id noid = {};
+
+		int err = iterator_next_log(it, &log);
+		if (err < 0) {
+			return err;
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
+	log_record_clear(&log);
+	iterator_destroy(&it);
+	err = stack_add(refs->stack, &write_reflog_expiry_table, &arg);
+	clear_log_tombstones(&arg);
+	return err;
+}
+
+static int reftable_read_raw_ref(struct ref_store *ref_store,
+				 const char *refname, struct object_id *oid,
+				 struct strbuf *referent, unsigned int *type)
+{
+	struct reftable_ref_store *refs =
+		(struct reftable_ref_store *)ref_store;
+	struct ref_record ref = {};
+	int err = stack_read_ref(refs->stack, refname, &ref);
+	if (err) {
+		goto exit;
+	}
+	if (ref.target != NULL) {
+		/* XXX recurse? */
+		strbuf_reset(referent);
+		strbuf_addstr(referent, ref.target);
+		*type |= REF_ISSYMREF;
+	} else {
+		hashcpy(oid->hash, ref.value);
+	}
+exit:
+	ref_record_clear(&ref);
+	return err;
+}
+
+struct ref_storage_be refs_be_reftable = {
+	&refs_be_files,
+	"reftable",
+	reftable_ref_store_create,
+	reftable_init_db,
+	reftable_transaction_prepare,
+	reftable_transaction_finish,
+	reftable_transaction_abort,
+	reftable_transaction_commit,
+
+	reftable_pack_refs,
+	reftable_create_symref,
+	reftable_delete_refs,
+	reftable_rename_ref,
+	reftable_copy_ref,
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
+	reftable_reflog_expire
+};
diff --git a/repository.c b/repository.c
index a4174ddb062..ff0988dac84 100644
--- a/repository.c
+++ b/repository.c
@@ -174,6 +174,8 @@ int repo_init(struct repository *repo,
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
+	repo->ref_storage_format = xstrdup_or_null(format.ref_storage);
+
 	clear_repository_format(&format);
 	return 0;
 
diff --git a/repository.h b/repository.h
index 040057dea6f..198d4aa0907 100644
--- a/repository.h
+++ b/repository.h
@@ -70,6 +70,9 @@ struct repository {
 	/* The store in which the refs are held. */
 	struct ref_store *refs;
 
+	/* The format to use for the ref database. */
+	char *ref_storage_format;
+
 	/*
 	 * Contains path to often used file names.
 	 */
diff --git a/setup.c b/setup.c
index 12228c0d9c1..01bf5580180 100644
--- a/setup.c
+++ b/setup.c
@@ -457,9 +457,11 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
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
 
@@ -548,6 +550,7 @@ void clear_repository_format(struct repository_format *format)
 	string_list_clear(&format->unknown_extensions, 0);
 	free(format->work_tree);
 	free(format->partial_clone);
+	free(format->ref_storage);
 	init_repository_format(format);
 }
 
@@ -1190,8 +1193,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
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
-- 
gitgitgadget
