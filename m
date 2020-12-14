Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456C1C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E436722510
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgLNXVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 18:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbgLNXU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 18:20:58 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8D8C06179C
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 15:20:17 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id w6so13272316pfu.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 15:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fd1fXi9m1l1mhZajB/LYRejAIfDw4F321k8Mw5gn+6c=;
        b=n/ABJunPOssNwglgR0WDbfhbGQTLx5e1Aj2HjD1ARHhUbvLxbzaYVmfS3zHNw+Gt1G
         CsnO6lX2BQ0d3gOjk8DGFveUu6946euuq1LMOfnIfmsWXKG8wdB5HgA2UwjlCnrwxVg+
         iVaCwh2JG39TmqwAQrOb8kNdEQHSNF6b8OP8OMbZKpCOWNU7o6+foWBdKQ0bk6p3myCw
         g6dxMDbKZdLRVy/TSI4bMARXUF4BxW2WUn1T18Lrk6rdjt340rEqmoR7sWy8Ooohu9am
         2ksqSCcgD7fQ1uPQQcSyTD2BPVjhMOhbEi5BFxeKiQba4Ve4IE+Uri1FSyCyW/zxi2Qr
         Jl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fd1fXi9m1l1mhZajB/LYRejAIfDw4F321k8Mw5gn+6c=;
        b=FGfaXil/fO2DyRLJJ/wTYc7WOR2Jlek/UMuW3tsizqwL4fcG5bQWJ2pcZKbzwPJz1R
         BtMDPGgKKivYWAQ/TpqXrk0KWZupg/0r/+J8lk01z75IKlxTz6ziNwKF2IlafLiEaumf
         +20DqesNBSR5Bhfi+xs+dfDnj2X2vpclVJniH7v5c6I8hL3DgUwEfE6YZr4yguP78nQq
         glazaqarMBodXUnPm3LlaCH6wmjwFvw3nqnOYiOun69bMUwPLvL7m9gjnl64GRQ+Heu8
         UDkXoEGpYkv9uZY63GuICztyIVgMFKR1iRIgO4XCcdzOGDuW75njs5p1elnCNeT3e5zn
         jTvw==
X-Gm-Message-State: AOAM532MupMuc3iH9zTdkFkiCSzxhBOwX4jAzwuv/4fj0ZDHCGcue9x7
        hjsdBe/GHy02oOsuigJ17X4U4te02DHaTQ==
X-Google-Smtp-Source: ABdhPJwf8of6PkZ2eX/pScui4Ru8GggXV3dZirg6TaVP6KbN5C3DUPfWtU+AJl2GwUkNVZ4Y9mKEsQ==
X-Received: by 2002:a63:531b:: with SMTP id h27mr26196093pgb.371.1607988016764;
        Mon, 14 Dec 2020 15:20:16 -0800 (PST)
Received: from localhost.localdomain ([27.56.186.8])
        by smtp.gmail.com with ESMTPSA id z10sm21282983pfr.204.2020.12.14.15.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 15:20:16 -0800 (PST)
From:   Shourya Shukla <periperidip@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: [PATCH v3 1/3] dir: change the scope of function 'directory_exists_in_index()'
Date:   Tue, 15 Dec 2020 04:49:37 +0530
Message-Id: <20201214231939.644175-2-periperidip@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201214231939.644175-1-periperidip@gmail.com>
References: <20201214231939.644175-1-periperidip@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the scope of the function 'directory_exists_in_index()' as well
as declare it in 'dir.h'.

Since the return type of the function is the enumerator 'exist_status',
change its scope as well and declare it in 'dir.h'. While at it, rename
the members of the aforementioned enum so as to avoid any naming clashes
or confusions later on.

Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 408 ++++++++++++++++++++++++++++++++++++
 dir.c                       |  30 ++-
 dir.h                       |   9 +
 3 files changed, 429 insertions(+), 18 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c30896c897..4dfad35d77 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2744,6 +2744,414 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 	return !!ret;
 }
 
+struct add_data {
+	const char *prefix;
+	const char *branch;
+	const char *reference_path;
+	const char *sm_path;
+	const char *sm_name;
+	const char *repo;
+	const char *realrepo;
+	int depth;
+	unsigned int force: 1;
+	unsigned int quiet: 1;
+	unsigned int progress: 1;
+	unsigned int dissociate: 1;
+};
+#define ADD_DATA_INIT { 0 }
+
+/*
+ * Guess the directory name from the repository URL by performing the
+ * operations below in the following order:
+ *
+ * - If the URL ends with '/', remove that.
+ *
+ * - If the result of the above ends with zero or more ':', followed
+ *  by zero or more '/', followed by ".git", drop the matching part.
+ *
+ * - If the result of the above has '/' or ':' in it, remove everything
+ *  before it and '/' or ':' itself.
+ */
+static char *guess_dir_name(const char *repo)
+{
+	const char *start, *end;
+
+	start = repo;
+	end = repo + strlen(repo);
+
+	/* remove the trailing '/' */
+	if (repo < end - 1 && end[-1] == '/')
+		end--;
+
+	/* remove the trailing ':', '/' and '.git' */
+	if (repo < end - 4 && !memcmp(".git", end - 4, 4)) {
+		end -= 4;
+		while (repo < end - 1 && end[-1] == '/')
+			end--;
+		while (repo < end - 1 && end[-1] == ':')
+			end--;
+	}
+
+	/* find the last ':' or '/' */
+	for (start = end - 1; repo <= start; start--) {
+		if (*start == '/' || *start == ':')
+			break;
+	}
+	/* exclude '/' or ':' itself */
+	start++;
+
+	return xmemdupz(start, end - start);
+}
+
+static int can_create_submodule(unsigned int force, const char *path)
+{
+	int cache_pos, dir_in_cache = 0;
+
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
+	cache_pos = cache_name_pos(path, strlen(path));
+	if(cache_pos < 0 &&
+	   directory_exists_in_index(&the_index, path, strlen(path)) == is_cache_directory)
+		dir_in_cache = 1;
+
+	if (!force) {
+		if (cache_pos >= 0 || dir_in_cache)
+			die(_("'%s' already exists in the index"), path);
+	} else {
+		struct cache_entry *ce = NULL;
+		if (cache_pos >= 0)
+			ce = the_index.cache[cache_pos];
+		if (dir_in_cache || (ce && !S_ISGITLINK(ce->ce_mode)))
+			die(_("'%s' already exists in the index and is not a "
+			      "submodule"), path);
+	}
+	return 0;
+}
+
+static const char *parse_token(const char *cp, int *len)
+{
+	const char *p = cp, *start, *end;
+	char *str;
+
+	start = p;
+	while (*p != ' ')
+		p++;
+	end = p;
+	str = xstrndup(start, end - start);
+
+	while(*p == ' ')
+		p++;
+
+	return str;
+}
+
+static void report_fetch_remotes(FILE *output, const char *sm_name, const char *git_dir)
+{
+	struct child_process cp_rem = CHILD_PROCESS_INIT;
+	struct strbuf sb_rem = STRBUF_INIT;
+
+	cp_rem.git_cmd = 1;
+	fprintf(stderr, _("A git directory for '%s' is "
+		"found locally with remote(s):\n"), sm_name);
+	strvec_pushf(&cp_rem.env_array,
+		     "GIT_DIR=%s", git_dir);
+	strvec_push(&cp_rem.env_array, "GIT_WORK_TREE=.");
+	strvec_pushl(&cp_rem.args, "remote", "-v", NULL);
+	if (!capture_command(&cp_rem, &sb_rem, 0)) {
+		int i;
+
+		for (i = 0; i < sb_rem.len; i++) {
+			char *start = sb_rem.buf + i, *end = start;
+			const char *name = start, *url, *tail;
+			int namelen, urllen;
+
+			while (sb_rem.buf[i++] != '\n')
+				end++;
+			url = parse_token(name, &namelen);
+			tail = parse_token(url, &urllen);
+			if (!memcmp(tail, "(fetch)", 7))
+				fprintf(stderr, "  %s\t%s\n", name, url);
+			start = *end ? end + 1 : end;
+		}
+	}
+}
+
+static int add_submodule(struct add_data *info)
+{
+	/* perhaps the path exists and is already a git repo, else clone it */
+	if (is_directory(info->sm_path)) {
+		char *sub_git_path = xstrfmt("%s/.git", info->sm_path);
+		if (is_directory(sub_git_path) || file_exists(sub_git_path))
+			printf(_("Adding existing repo at '%s' to the index\n"),
+				 info->sm_path);
+		else
+			die(_("'%s' already exists and is not a valid git repo"),
+			      info->sm_path);
+		free(sub_git_path);
+	} else {
+		struct strvec clone_args = STRVEC_INIT;
+		struct child_process cp = CHILD_PROCESS_INIT;
+		char *submodule_git_dir = xstrfmt(".git/modules/%s", info->sm_name);
+
+		if (is_directory(submodule_git_dir)) {
+			if (!info->force) {
+				report_fetch_remotes(stderr, info->sm_name,
+						     submodule_git_dir);
+				error(_("If you want to reuse this local git "
+				      "directory instead of cloning again from\n "
+				      "  %s\n"
+				      "use the '--force' option. If the local "
+				      "git directory is not the correct repo\n"
+				      "or you are unsure what this means choose "
+				      "another name with the '--name' option."),
+				      info->realrepo);
+				return 1;
+			} else {
+				printf(_("Reactivating local git directory for "
+					 "submodule '%s'."), info->sm_path);
+			}
+		}
+		free(submodule_git_dir);
+
+		strvec_push(&clone_args, "clone");
+
+		if (info->quiet)
+			strvec_push(&clone_args, "--quiet");
+
+		if (info->progress)
+			strvec_push(&clone_args, "--progress");
+
+		if (info->prefix)
+			strvec_pushl(&clone_args, "--prefix", info->prefix, NULL);
+		strvec_pushl(&clone_args, "--path", info->sm_path, "--name",
+			     info->sm_name, "--url", info->realrepo, NULL);
+		if (info->reference_path)
+			strvec_pushl(&clone_args, "--reference",
+				     info->reference_path, NULL);
+		if (info->dissociate)
+			strvec_push(&clone_args, "--dissociate");
+
+		if (info->depth >= 0)
+			strvec_pushf(&clone_args, "--depth=%d", info->depth);
+
+		if (module_clone(clone_args.nr, clone_args.v, info->prefix)) {
+			strvec_clear(&clone_args);
+			return -1;
+		}
+
+		prepare_submodule_repo_env(&cp.env_array);
+		cp.git_cmd = 1;
+		cp.dir = info->sm_path;
+		strvec_pushl(&cp.args, "checkout", "-f", "-q", NULL);
+
+		if (info->branch) {
+			strvec_pushl(&cp.args, "-B", info->branch, NULL);
+			strvec_pushf(&cp.args, "origin/%s", info->branch);
+		}
+
+		if (run_command(&cp))
+			die(_("unable to checkout submodule '%s'"), info->sm_path);
+	}
+	return 0;
+}
+
+static void config_added_submodule(struct add_data *info)
+{
+	char *key, *var = NULL;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct child_process cp2 = CHILD_PROCESS_INIT;
+
+	key = xstrfmt("submodule.%s.url", info->sm_name);
+	git_config_set_gently(key, info->realrepo);
+	free(key);
+
+	cp.git_cmd = 1;
+	strvec_pushl(&cp.args, "add", "--no-warn-embedded-repo", NULL);
+	if (info->force)
+		strvec_push(&cp.args, "--force");
+	strvec_pushl(&cp.args, "--", info->sm_path, NULL);
+
+	if (run_command(&cp))
+		die(_("failed to add submodule '%s'"), info->sm_path);
+
+	key = xstrfmt("submodule.%s.path", info->sm_name);
+	config_set_in_gitmodules_file_gently(key, info->sm_path);
+	free(key);
+	key = xstrfmt("submodule.%s.url", info->sm_name);
+	config_set_in_gitmodules_file_gently(key, info->repo);
+	free(key);
+	key = xstrfmt("submodule.%s.branch", info->sm_name);
+	if (info->branch)
+		config_set_in_gitmodules_file_gently(key, info->branch);
+	free(key);
+
+	cp2.git_cmd = 1;
+	strvec_pushl(&cp2.args, "add", "--force", NULL);
+	strvec_pushl(&cp2.args, "--", ".gitmodules", NULL);
+
+	if (run_command(&cp2))
+		die(_("Failed to register submodule '%s'"), info->sm_path);
+
+	/*
+	 * NEEDSWORK: In a multi-working-tree world, this needs to be
+	 * set in the per-worktree config.
+	 */
+	if (!git_config_get_string("submodule.active", &var) && var) {
+
+		/*
+		 * If the submodule being adding isn't already covered by the
+		 * current configured pathspec, set the submodule's active flag
+		 */
+		if (!is_submodule_active(the_repository, info->sm_path)) {
+			key = xstrfmt("submodule.%s.active", info->sm_name);
+			git_config_set_gently(key, "true");
+			free(key);
+		}
+	} else {
+		key = xstrfmt("submodule.%s.active", info->sm_name);
+		git_config_set_gently(key, "true");
+		free(key);
+	}
+}
+
+static int module_add(int argc, const char **argv, const char *prefix)
+{
+	const char *branch = NULL, *custom_name = NULL, *realrepo = NULL;
+	const char *reference_path = NULL, *repo = NULL, *name = NULL;
+	char *sm_path;
+	int force = 0, quiet = 0, depth = -1, progress = 0, dissociate = 0;
+	struct add_data info = ADD_DATA_INIT;
+	struct strbuf sb = STRBUF_INIT;
+
+	struct option options[] = {
+		OPT_STRING('b', "branch", &branch, N_("branch"),
+			   N_("branch of repository to add as submodule")),
+		OPT_BOOL('f', "force", &force, N_("allow adding an otherwise "
+						  "ignored submodule path")),
+		OPT__QUIET(&quiet, N_("print only error messages")),
+		OPT_BOOL(0, "progress", &progress, N_("force cloning progress")),
+		OPT_STRING(0, "reference", &reference_path, N_("repository"),
+			   N_("reference repository")),
+		OPT_BOOL(0, "dissociate", &dissociate, N_("borrow the objects from reference repositories")),
+		OPT_STRING(0, "name", &custom_name, N_("name"),
+			   N_("sets the submodule’s name to the given string "
+			      "instead of defaulting to its path")),
+		OPT_INTEGER(0, "depth", &depth, N_("depth for shallow clones")),
+		OPT_END()
+	};
+
+	const char *const usage[] = {
+		N_("git submodule--helper add [<options>] [--] [<path>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	if (!is_writing_gitmodules_ok())
+		die(_("please make sure that the .gitmodules file is in the working tree"));
+
+	if (prefix && *prefix && reference_path &&
+	    !is_absolute_path(reference_path))
+		reference_path = xstrfmt("%s%s", prefix, reference_path);
+
+	if (argc == 0 || argc > 2) {
+		usage_with_options(usage, options);
+	} else if (argc == 1) {
+		repo = argv[0];
+		sm_path = guess_dir_name(repo);
+	} else {
+		repo = argv[0];
+		sm_path = xstrdup(argv[1]);
+	}
+
+	if (prefix && *prefix && !is_absolute_path(sm_path))
+		sm_path = xstrfmt("%s%s", prefix, sm_path);
+
+	/* assure repo is absolute or relative to parent */
+	if (starts_with_dot_dot_slash(repo) || starts_with_dot_slash(repo)) {
+		char *remote = get_default_remote();
+		char *remoteurl;
+		struct strbuf sb = STRBUF_INIT;
+
+		if (prefix)
+			die(_("relative path can only be used from the toplevel "
+			      "of the working tree"));
+		/* dereference source url relative to parent's url */
+		strbuf_addf(&sb, "remote.%s.url", remote);
+		if (git_config_get_string(sb.buf, &remoteurl))
+			remoteurl = xgetcwd();
+		realrepo = relative_url(remoteurl, repo, NULL);
+
+		free(remoteurl);
+		free(remote);
+	} else if (is_dir_sep(repo[0]) || strchr(repo, ':')) {
+		realrepo = repo;
+	} else {
+		die(_("repo URL: '%s' must be absolute or begin with ./|../"),
+		      repo);
+	}
+
+	/*
+	 * normalize path:
+	 * multiple //; leading ./; /./; /../;
+	 */
+	normalize_path_copy(sm_path, sm_path);
+	/* strip trailing '/' */
+	if (is_dir_sep(sm_path[strlen(sm_path) -1]))
+		sm_path[strlen(sm_path) - 1] = '\0';
+
+	if (can_create_submodule(force, sm_path))
+		return 1;
+
+	strbuf_addstr(&sb, sm_path);
+	if (is_nonbare_repository_dir(&sb)) {
+		struct object_id oid;
+		if (resolve_gitlink_ref(sm_path, "HEAD", &oid) < 0)
+			die(_("'%s' does not have a commit checked out"), sm_path);
+	}
+
+	if (!force) {
+		int exit_code = -1;
+		struct strbuf sb = STRBUF_INIT;
+		struct child_process cp = CHILD_PROCESS_INIT;
+		cp.git_cmd = 1;
+		cp.no_stdout = 1;
+		strvec_pushl(&cp.args, "add", "--dry-run", "--ignore-missing",
+			     "--no-warn-embedded-repo", sm_path, NULL);
+		if ((exit_code = pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))) {
+			strbuf_complete_line(&sb);
+			fputs(sb.buf, stderr);
+			return exit_code;
+		}
+		strbuf_release(&sb);
+	}
+
+	name = custom_name ? custom_name : sm_path;
+	if (check_submodule_name(name))
+		die(_("'%s' is not a valid submodule name"), name);
+
+	info.prefix = prefix;
+	info.sm_name = name;
+	info.sm_path = sm_path;
+	info.repo = repo;
+	info.realrepo = realrepo;
+	info.reference_path = reference_path;
+	info.branch = branch;
+	info.depth = depth;
+	info.progress = !!progress;
+	info.dissociate = !!dissociate;
+	info.force = !!force;
+	info.quiet = !!quiet;
+
+	if (add_submodule(&info))
+		return 1;
+	config_added_submodule(&info);
+	free(sm_path);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
diff --git a/dir.c b/dir.c
index d637461da5..f37de276f2 100644
--- a/dir.c
+++ b/dir.c
@@ -1655,12 +1655,6 @@ struct dir_entry *dir_add_ignored(struct dir_struct *dir,
 	return dir->ignored[dir->ignored_nr++] = dir_entry_new(pathname, len);
 }
 
-enum exist_status {
-	index_nonexistent = 0,
-	index_directory,
-	index_gitdir
-};
-
 /*
  * Do not use the alphabetically sorted index to look up
  * the directory name; instead, use the case insensitive
@@ -1672,13 +1666,13 @@ static enum exist_status directory_exists_in_index_icase(struct index_state *ist
 	struct cache_entry *ce;
 
 	if (index_dir_exists(istate, dirname, len))
-		return index_directory;
+		return is_cache_directory;
 
 	ce = index_file_exists(istate, dirname, len, ignore_case);
 	if (ce && S_ISGITLINK(ce->ce_mode))
-		return index_gitdir;
+		return is_cache_gitdir;
 
-	return index_nonexistent;
+	return is_cache_absent;
 }
 
 /*
@@ -1688,8 +1682,8 @@ static enum exist_status directory_exists_in_index_icase(struct index_state *ist
  * the files it contains) will sort with the '/' at the
  * end.
  */
-static enum exist_status directory_exists_in_index(struct index_state *istate,
-						   const char *dirname, int len)
+enum exist_status directory_exists_in_index(struct index_state *istate,
+					    const char *dirname, int len)
 {
 	int pos;
 
@@ -1709,11 +1703,11 @@ static enum exist_status directory_exists_in_index(struct index_state *istate,
 		if (endchar > '/')
 			break;
 		if (endchar == '/')
-			return index_directory;
+			return is_cache_directory;
 		if (!endchar && S_ISGITLINK(ce->ce_mode))
-			return index_gitdir;
+			return is_cache_gitdir;
 	}
-	return index_nonexistent;
+	return is_cache_absent;
 }
 
 /*
@@ -1767,11 +1761,11 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	/* The "len-1" is to strip the final '/' */
 	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
 
-	if (status == index_directory)
+	if (status == is_cache_directory)
 		return path_recurse;
-	if (status == index_gitdir)
+	if (status == is_cache_gitdir)
 		return path_none;
-	if (status != index_nonexistent)
+	if (status != is_cache_absent)
 		BUG("Unhandled value for directory_exists_in_index: %d\n", status);
 
 	/*
@@ -2190,7 +2184,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 	if ((dir->flags & DIR_COLLECT_KILLED_ONLY) &&
 	    (dtype == DT_DIR) &&
 	    !has_path_in_index &&
-	    (directory_exists_in_index(istate, path->buf, path->len) == index_nonexistent))
+	    (directory_exists_in_index(istate, path->buf, path->len) == is_cache_absent))
 		return path_none;
 
 	excluded = is_excluded(dir, istate, path->buf, &dtype);
diff --git a/dir.h b/dir.h
index a3c40dec51..af817a21b2 100644
--- a/dir.h
+++ b/dir.h
@@ -370,6 +370,15 @@ int read_directory(struct dir_struct *, struct index_state *istate,
 		   const char *path, int len,
 		   const struct pathspec *pathspec);
 
+enum exist_status {
+	is_cache_absent = 0,
+	is_cache_directory,
+	is_cache_gitdir
+};
+
+enum exist_status directory_exists_in_index(struct index_state *istate,
+					    const char *dirname, int len);
+
 enum pattern_match_result {
 	UNDECIDED = -1,
 	NOT_MATCHED = 0,
-- 
2.25.1

