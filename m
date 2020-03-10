Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C119C18E5B
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 13:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66D4208E4
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 13:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgpx3/gW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbgCJNRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:17:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35877 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731289AbgCJNLd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 09:11:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id s5so11892741wrg.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tun1HKuUJa2bnu1BVGAUAKzuer85yC1s1RNqvkCJO4Q=;
        b=pgpx3/gWv0u+ea45qd9ngshATCj1iZtfkkAGfCaACkXy/R+IEA5nAhLRZSb1qWeIXy
         ZzV10nj05v085HKnQg31QrRM1I1RS8ukHQctUUpIthG9u9E7Q06p0ZGayBZpJ7J1SD0G
         EEgDkwCmW2bAYNrdTKxpq+ttH7i3zfHHBV5qUWI/swdroh6xyMSb7nRzJgq7Qq8aDx5y
         //brKXB0Gz8OqwI2FKjkp9+MJJRzxB7JuqofBkAoNCj4LH61q4w9gcrGQ0BDeMsIvVoz
         DDW1AO+kcptdRwLlJjZFxi3PJVsyfxqWzbKcTfWAz+TYtxKgfFy2cLOb+Nr9Tr7VgQvX
         QoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tun1HKuUJa2bnu1BVGAUAKzuer85yC1s1RNqvkCJO4Q=;
        b=hNNBDw/R5e1pffujTX0IgvtUu1AmL4z5RYywDWkVLtFtz4YQhsbLR6S/lpmgBE0qbh
         qzZ2ewNK3vlPIUtkCVca7U5XEixpeENMKMr6EKRQB0papc49ZtLOlS9ByMbmnMF1b0iS
         Fj3ViYWUCZCcfTC6NnRu99WCogTtV20Ddl5hk5Y6WmgMfz28065eN3+OqhjqqUC4LjMm
         9OADFqHEJbJP1F+eTVRMzbxlLw8ie9DdJwQ1ommnBO5XnnPhkRNznIJZq67+xziUpyoi
         wGCU/MT0OTZarFvPefBVe0iSa0Vc33hp4QzLki1qFchfSdwJAmrnQl15NSAd7Yd1bnVx
         4kEw==
X-Gm-Message-State: ANhLgQ1QFdWIEzi+5ht+zBOH0OJ6rPfEpMTmjU2qKM8cCeZB/c80xso1
        wMDCUgFzyGTsiVMS/bOaVh2oR63d
X-Google-Smtp-Source: ADFU+vuMgYbOzXini/SaPZV4wGVZ06tYiVQb/EgvpzEja53bn5xkpxtvuTC2oE/baBwCDUDQwjlcDw==
X-Received: by 2002:a05:6000:10f:: with SMTP id o15mr12870187wrx.351.1583845889510;
        Tue, 10 Mar 2020 06:11:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3sm4045134wmg.19.2020.03.10.06.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:11:28 -0700 (PDT)
Message-Id: <29e7133dcd9321a68019fbaf066c18c11190adef.1583845884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.575.v2.git.1583845884.gitgitgadget@gmail.com>
References: <pull.575.git.1583521396.gitgitgadget@gmail.com>
        <pull.575.v2.git.1583845884.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Mar 2020 13:11:22 +0000
Subject: [PATCH v2 2/4] real_path: remove unsafe API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Returning a shared buffer invites very subtle bugs due to reentrancy or
multi-threading, as demonstrated by the previous patch.

There was an unfinished effort to abolish this [1].

Let's finally rid of `real_path()`, using `strbuf_realpath()` instead.

This patch uses a local `strbuf` for most places where `real_path()` was
previously called.

However, two places return the value of `real_path()` to the caller. For
them, a `static` local `strbuf` was added, effectively pushing the
problem one level higher:
    read_gitfile_gently()
    get_superproject_working_tree()

[1] https://lore.kernel.org/git/1480964316-99305-1-git-send-email-bmwill@google.com/

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 abspath.c                  |  8 +-------
 builtin/clone.c            |  6 +++++-
 builtin/commit-graph.c     |  5 ++++-
 builtin/rev-parse.c        |  5 ++++-
 builtin/worktree.c         |  9 ++++++---
 cache.h                    |  1 -
 editor.c                   | 11 +++++++++--
 environment.c              |  7 ++++++-
 path.c                     |  2 +-
 setup.c                    | 15 ++++++++++++---
 submodule.c                |  4 +++-
 t/helper/test-path-utils.c |  5 ++++-
 worktree.c                 |  5 ++++-
 13 files changed, 59 insertions(+), 24 deletions(-)

diff --git a/abspath.c b/abspath.c
index 98579853299..d34026bfeb8 100644
--- a/abspath.c
+++ b/abspath.c
@@ -206,12 +206,6 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
  * Resolve `path` into an absolute, cleaned-up path. The return value
  * comes from a shared buffer.
  */
-const char *real_path(const char *path)
-{
-	static struct strbuf realpath = STRBUF_INIT;
-	return strbuf_realpath(&realpath, path, 1);
-}
-
 const char *real_path_if_valid(const char *path)
 {
 	static struct strbuf realpath = STRBUF_INIT;
@@ -233,7 +227,7 @@ char *real_pathdup(const char *path, int die_on_error)
 
 /*
  * Use this to get an absolute path from a relative one. If you want
- * to resolve links, you should use real_path.
+ * to resolve links, you should use strbuf_realpath.
  */
 const char *absolute_path(const char *path)
 {
diff --git a/builtin/clone.c b/builtin/clone.c
index 1ad26f4d8c8..488bdb07417 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -420,6 +420,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 	struct dir_iterator *iter;
 	int iter_status;
 	unsigned int flags;
+	struct strbuf realpath = STRBUF_INIT;
 
 	mkdir_if_missing(dest->buf, 0777);
 
@@ -454,7 +455,8 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		if (unlink(dest->buf) && errno != ENOENT)
 			die_errno(_("failed to unlink '%s'"), dest->buf);
 		if (!option_no_hardlinks) {
-			if (!link(real_path(src->buf), dest->buf))
+			strbuf_realpath(&realpath, src->buf, 1);
+			if (!link(realpath.buf, dest->buf))
 				continue;
 			if (option_local > 0)
 				die_errno(_("failed to create link '%s'"), dest->buf);
@@ -468,6 +470,8 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		strbuf_setlen(src, src_len);
 		die(_("failed to iterate over '%s'"), src->buf);
 	}
+
+	strbuf_release(&realpath);
 }
 
 static void clone_local(const char *src_repo, const char *dest_repo)
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 4a70b33fb5f..d1ab6625f63 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -39,14 +39,17 @@ static struct object_directory *find_odb(struct repository *r,
 {
 	struct object_directory *odb;
 	char *obj_dir_real = real_pathdup(obj_dir, 1);
+	struct strbuf odb_path_real = STRBUF_INIT;
 
 	prepare_alt_odb(r);
 	for (odb = r->objects->odb; odb; odb = odb->next) {
-		if (!strcmp(obj_dir_real, real_path(odb->path)))
+		strbuf_realpath(&odb_path_real, odb->path, 1);
+		if (!strcmp(obj_dir_real, odb_path_real.buf))
 			break;
 	}
 
 	free(obj_dir_real);
+	strbuf_release(&odb_path_real);
 
 	if (!odb)
 		die(_("could not find object directory matching %s"), obj_dir);
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 7a00da82035..06ca7175ac7 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -857,7 +857,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					if (!gitdir && !prefix)
 						gitdir = ".git";
 					if (gitdir) {
-						puts(real_path(gitdir));
+						struct strbuf realpath = STRBUF_INIT;
+						strbuf_realpath(&realpath, gitdir, 1);
+						puts(realpath.buf);
+						strbuf_release(&realpath);
 						continue;
 					}
 				}
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 24f22800f38..d99db356684 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -258,7 +258,7 @@ static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
 	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
-	struct strbuf sb = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT, realpath = STRBUF_INIT;
 	const char *name;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct argv_array child_env = ARGV_ARRAY_INIT;
@@ -330,9 +330,11 @@ static int add_worktree(const char *path, const char *refname,
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
-	write_file(sb.buf, "%s", real_path(sb_git.buf));
+	strbuf_realpath(&realpath, sb_git.buf, 1);
+	write_file(sb.buf, "%s", realpath.buf);
+	strbuf_realpath(&realpath, get_git_common_dir(), 1);
 	write_file(sb_git.buf, "gitdir: %s/worktrees/%s",
-		   real_path(get_git_common_dir()), name);
+		   realpath.buf, name);
 	/*
 	 * This is to keep resolve_ref() happy. We need a valid HEAD
 	 * or is_git_directory() will reject the directory. Any value which
@@ -418,6 +420,7 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
 	strbuf_release(&sb_name);
+	strbuf_release(&realpath);
 	return ret;
 }
 
diff --git a/cache.h b/cache.h
index 8cee257d3d7..f6937793ec2 100644
--- a/cache.h
+++ b/cache.h
@@ -1314,7 +1314,6 @@ static inline int is_absolute_path(const char *path)
 int is_directory(const char *);
 char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
-const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
 char *real_pathdup(const char *path, int die_on_error);
 const char *absolute_path(const char *path);
diff --git a/editor.c b/editor.c
index f079abbf110..91989ee8a11 100644
--- a/editor.c
+++ b/editor.c
@@ -54,7 +54,8 @@ static int launch_specified_editor(const char *editor, const char *path,
 		return error("Terminal is dumb, but EDITOR unset");
 
 	if (strcmp(editor, ":")) {
-		const char *args[] = { editor, real_path(path), NULL };
+		struct strbuf realpath = STRBUF_INIT;
+		const char *args[] = { editor, NULL, NULL };
 		struct child_process p = CHILD_PROCESS_INIT;
 		int ret, sig;
 		int print_waiting_for_editor = advice_waiting_for_editor && isatty(2);
@@ -75,16 +76,22 @@ static int launch_specified_editor(const char *editor, const char *path,
 			fflush(stderr);
 		}
 
+		strbuf_realpath(&realpath, path, 1);
+		args[1] = realpath.buf;
+
 		p.argv = args;
 		p.env = env;
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
-		if (start_command(&p) < 0)
+		if (start_command(&p) < 0) {
+			strbuf_release(&realpath);
 			return error("unable to start editor '%s'", editor);
+		}
 
 		sigchain_push(SIGINT, SIG_IGN);
 		sigchain_push(SIGQUIT, SIG_IGN);
 		ret = finish_command(&p);
+		strbuf_release(&realpath);
 		sig = ret - 128;
 		sigchain_pop(SIGINT);
 		sigchain_pop(SIGQUIT);
diff --git a/environment.c b/environment.c
index c436de31eef..10c9061c432 100644
--- a/environment.c
+++ b/environment.c
@@ -254,8 +254,11 @@ static int git_work_tree_initialized;
  */
 void set_git_work_tree(const char *new_work_tree)
 {
+	struct strbuf realpath = STRBUF_INIT;
+
 	if (git_work_tree_initialized) {
-		new_work_tree = real_path(new_work_tree);
+		strbuf_realpath(&realpath, new_work_tree, 1);
+		new_work_tree = realpath.buf;
 		if (strcmp(new_work_tree, the_repository->worktree))
 			die("internal error: work tree has already been set\n"
 			    "Current worktree: %s\nNew worktree: %s",
@@ -264,6 +267,8 @@ void set_git_work_tree(const char *new_work_tree)
 	}
 	git_work_tree_initialized = 1;
 	repo_set_worktree(the_repository, new_work_tree);
+
+	strbuf_release(&realpath);
 }
 
 const char *get_git_work_tree(void)
diff --git a/path.c b/path.c
index c5a8fe4f0c3..0a42ceb3fb5 100644
--- a/path.c
+++ b/path.c
@@ -723,7 +723,7 @@ static struct passwd *getpw_str(const char *username, size_t len)
  * then it is a newly allocated string. Returns NULL on getpw failure or
  * if path is NULL.
  *
- * If real_home is true, real_path($HOME) is used in the expansion.
+ * If real_home is true, strbuf_realpath($HOME) is used in the expansion.
  */
 char *expand_user_path(const char *path, int real_home)
 {
diff --git a/setup.c b/setup.c
index fa4317e707a..1ae3f203016 100644
--- a/setup.c
+++ b/setup.c
@@ -32,6 +32,7 @@ static int abspath_part_inside_repo(char *path)
 	char *path0;
 	int off;
 	const char *work_tree = get_git_work_tree();
+	struct strbuf realpath = STRBUF_INIT;
 
 	if (!work_tree)
 		return -1;
@@ -60,8 +61,10 @@ static int abspath_part_inside_repo(char *path)
 		path++;
 		if (*path == '/') {
 			*path = '\0';
-			if (fspathcmp(real_path(path0), work_tree) == 0) {
+			strbuf_realpath(&realpath, path0, 1);
+			if (fspathcmp(realpath.buf, work_tree) == 0) {
 				memmove(path0, path + 1, len - (path - path0));
+				strbuf_release(&realpath);
 				return 0;
 			}
 			*path = '/';
@@ -69,11 +72,14 @@ static int abspath_part_inside_repo(char *path)
 	}
 
 	/* check whole path */
-	if (fspathcmp(real_path(path0), work_tree) == 0) {
+	strbuf_realpath(&realpath, path0, 1);
+	if (fspathcmp(realpath.buf, work_tree) == 0) {
 		*path0 = '\0';
+		strbuf_release(&realpath);
 		return 0;
 	}
 
+	strbuf_release(&realpath);
 	return -1;
 }
 
@@ -619,6 +625,7 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	struct stat st;
 	int fd;
 	ssize_t len;
+	static struct strbuf realpath = STRBUF_INIT;
 
 	if (stat(path, &st)) {
 		/* NEEDSWORK: discern between ENOENT vs other errors */
@@ -669,7 +676,9 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 		error_code = READ_GITFILE_ERR_NOT_A_REPO;
 		goto cleanup_return;
 	}
-	path = real_path(dir);
+
+	strbuf_realpath(&realpath, dir, 1);
+	path = realpath.buf;
 
 cleanup_return:
 	if (return_error_code)
diff --git a/submodule.c b/submodule.c
index 31f391d7d25..bad7a788c06 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2170,6 +2170,7 @@ void absorb_git_dir_into_superproject(const char *path,
 
 const char *get_superproject_working_tree(void)
 {
+	static struct strbuf realpath = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	const char *one_up = real_path_if_valid("../");
@@ -2231,7 +2232,8 @@ const char *get_superproject_working_tree(void)
 		super_wt = xstrdup(cwd);
 		super_wt[cwd_len - super_sub_len] = '\0';
 
-		ret = real_path(super_wt);
+		strbuf_realpath(&realpath, super_wt, 1);
+		ret = realpath.buf;
 		free(super_wt);
 	}
 	strbuf_release(&sb);
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 409034cf4ee..313a153209c 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -290,11 +290,14 @@ int cmd__path_utils(int argc, const char **argv)
 	}
 
 	if (argc >= 2 && !strcmp(argv[1], "real_path")) {
+		struct strbuf realpath = STRBUF_INIT;
 		while (argc > 2) {
-			puts(real_path(argv[2]));
+			strbuf_realpath(&realpath, argv[2], 1);
+			puts(realpath.buf);
 			argc--;
 			argv++;
 		}
+		strbuf_release(&realpath);
 		return 0;
 	}
 
diff --git a/worktree.c b/worktree.c
index eba4fd3a038..e7bbf716f6b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -285,6 +285,7 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
 		      unsigned flags)
 {
 	struct strbuf wt_path = STRBUF_INIT;
+	struct strbuf realpath = STRBUF_INIT;
 	char *path = NULL;
 	int err, ret = -1;
 
@@ -336,7 +337,8 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
 		goto done;
 	}
 
-	ret = fspathcmp(path, real_path(git_common_path("worktrees/%s", wt->id)));
+	strbuf_realpath(&realpath, git_common_path("worktrees/%s", wt->id), 1);
+	ret = fspathcmp(path, realpath.buf);
 
 	if (ret)
 		strbuf_addf_gently(errmsg, _("'%s' does not point back to '%s'"),
@@ -344,6 +346,7 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
 done:
 	free(path);
 	strbuf_release(&wt_path);
+	strbuf_release(&realpath);
 	return ret;
 }
 
-- 
gitgitgadget

