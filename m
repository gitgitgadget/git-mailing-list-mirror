Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E7DC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 09:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092F822BEA
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 09:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BS5AufGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgHXJEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730729AbgHXJEK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 05:04:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A705BC0613ED
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 02:04:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh1so3900277plb.12
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 02:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvwMG9Nznb0GSnwScPkM93o6o7lq3vizdwsWo5cqx/w=;
        b=BS5AufGZTpn27hccEkICboqzR2dtB0V+fs2XwBDz6TiNCNaydsqLBkUDeZAogcg3eZ
         +p0LYegB4omblJ1MZo5a/r4vRjH0p1XqRF5kCBdJHlBzZx+8Bv+XnMMgA+625SmLlGg2
         j27hUlD99Z62vPDi1lwd1QUz2z4FW5t+iTexoUXpdE0Du/r/qC6Q1l651XOndbfY/nMw
         IQlUzMTNn1+x6uAvkdBuKZAOwPdzf5v5zLz3oSCsyVYVATeohvlqiBN5Z3Pozzaz0RDq
         9OEKtsozzAqHljoIMlS+4Px+DQmZ3Qo7S0n4KrEw6MqFt7OP0It5vkPkv7N4uhxYq4qK
         qUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvwMG9Nznb0GSnwScPkM93o6o7lq3vizdwsWo5cqx/w=;
        b=KValNruDOVMh17Yyb1BAqRJILHgSHknhiRcWj1JKOjxjpcWXnL6h+SiWoGR8ckcm1h
         zvPjhPCpPgSgV4qgXS5Iwt5dL2aWKZjgfV3+al7G539u7GzEp6A+mnE4SpdgxZoC9QkL
         WdYmZyRcGyejWjooBYGuRRHyivC71Osc/lom0Lkkfii6Tv96U0P8irSvZKybv2qN4TYr
         3MwxALYtddbp32nxGqIOuLXUPW31wlspTkISmL1esHDBVnYPJoje3KV0N48k/Fv2b7Ha
         Mj4XNIAj6Z0NY/oriG7F4LMfj7H2y+jYX7e6tsWCMJ1BNutmpLEb3vLN7oD1eirCbkCU
         yamw==
X-Gm-Message-State: AOAM531VNK961djKWyZ0hgkg4DoSRFCGkW0U+7XmSlEZPwziK+uii09E
        L7Wl+vcOeMb+bVoHnJl46fHzhgUa1lAtGA==
X-Google-Smtp-Source: ABdhPJwNXv3U8nGZ+P0JAxekmdHVYMvO2p6Itm9GQ4uSMpjt65Vnpekf5HosbSPJcwFlEJ4litWilQ==
X-Received: by 2002:a17:90a:c589:: with SMTP id l9mr3125292pjt.89.1598259847261;
        Mon, 24 Aug 2020 02:04:07 -0700 (PDT)
Received: from localhost.localdomain ([27.7.229.188])
        by smtp.gmail.com with ESMTPSA id v134sm5271406pfc.101.2020.08.24.02.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 02:04:06 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC][PATCH] submodule: port submodule subcommand 'add' from shell to C
Date:   Mon, 24 Aug 2020 14:33:59 +0530
Message-Id: <20200824090359.403944-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Prathamesh Chavan <pc44800@gmail.com>

Convert submodule subcommand 'add' to a builtin and call it via
'git-submodule.sh'.

Also, since the command die()s out in case of absence of commits in the
submodule and exits with exit status 1 when we try adding a submodule
which is mentioned in .gitignore, the keyword 'fatal' is prefixed in the
error messages. Therefore, prepend the keyword in the expected outputs
of tests t7400.6 and t7400.16.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Stefan Beller <stefanbeller@gmail.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
This is my port of 'git submodule add' from shell to C. I had some
confusion regarding this segment in the shell script:

	if test -z "$force"
	then
		git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
		die "$(eval_gettext "'\$sm_path' already exists in the index")"
	else
		git ls-files -s "$sm_path" | sane_grep -v "^160000" > /dev/null 2>&1 &&
		die "$(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
	fi

This is what I have done in C:

	if (!force) {
		if (is_directory(path) && submodule_from_path(the_repository, &null_oid, path))
			die(_("'%s' already exists in the index"), path);
	} else {
		int err;
		if (index_name_pos(&the_index, path, strlen(path)) >= 0 &&
		    !is_submodule_populated_gently(path, &err))
			die(_("'%s' already exists in the index and is not a "
			      "submodule"), path);
	}

Is this part correct? I am not very sure about this. This particular
part is not covered in any test or test script, so, I do not have a
solid method of knowing the correctness of this segment.
Feedback and reviews are appreciated.
---

 builtin/submodule--helper.c | 371 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 161 +---------------
 t/t7400-submodule-basic.sh  |   5 +-
 3 files changed, 375 insertions(+), 162 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index df135abbf1..b8189822a3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2320,6 +2320,376 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
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
+#define ADD_DATA_INIT { NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0 }
+
+/*
+ * Guess dir name from repository: strip leading '.*[/:]',
+ * strip trailing '[:/]*.git'.
+ */
+static char *guess_dir_name(const char *repo)
+{
+	const char *p, *start, *end, *limit;
+	int after_slash_or_colon;
+
+	after_slash_or_colon = 0;
+	limit = repo + strlen(repo);
+	start = repo;
+	end = limit;
+	for (p = repo; p < limit; p++) {
+		if (starts_with(p, ".git")) {
+			/* strip trailing '[:/]*.git' */
+			if (!after_slash_or_colon)
+				end = p;
+			p += 3;
+		} else if (*p == '/' || *p == ':') {
+			/* strip leading '.*[/:]' */
+			if (end == limit)
+				end = p;
+			after_slash_or_colon = 1;
+		} else if (after_slash_or_colon) {
+			start = p;
+			end = limit;
+			after_slash_or_colon = 0;
+		}
+	}
+	return xstrndup(start, end - start);
+}
+
+static void fprintf_submodule_remote(const char *str)
+{
+	const char *p = str;
+	const char *start;
+	const char *end;
+	char *name, *url;
+
+	start = p;
+	while (*p != ' ')
+		p++;
+	end = p;
+	name = xstrndup(start, end - start);
+
+	while(*p == ' ')
+		p++;
+	start = p;
+	while (*p != ' ')
+		p++;
+	end = p;
+	url = xstrndup(start, end - start);
+
+	fprintf(stderr, "  %s\t%s\n", name, url);
+	free(name);
+	free(url);
+}
+
+static void modify_remote_v(struct strbuf *sb)
+{
+	int i;
+	for (i = 0; i < sb->len; i++) {
+		const char *start = sb->buf + i;
+		const char *end = start;
+		while (sb->buf[i++] != '\n')
+			end++;
+		if (!strcmp("fetch", xstrndup(end - 6, 5)))
+			fprintf_submodule_remote(xstrndup(start, end - start - 7));
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
+				struct child_process cp_rem = CHILD_PROCESS_INIT;
+				struct strbuf sb_rem = STRBUF_INIT;
+				cp_rem.git_cmd = 1;
+				fprintf(stderr, _("A git directory for '%s' is "
+					"found locally with remote(s):\n"),
+					info->sm_name);
+				strvec_pushf(&cp_rem.env_array,
+					     "GIT_DIR=%s", submodule_git_dir);
+				strvec_push(&cp_rem.env_array, "GIT_WORK_TREE=.");
+				strvec_pushl(&cp_rem.args, "remote", "-v", NULL);
+				if (!capture_command(&cp_rem, &sb_rem, 0)) {
+					modify_remote_v(&sb_rem);
+				}
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
+
+	key = xstrfmt("submodule.%s.url", info->sm_name);
+	git_config_set_gently(key, info->realrepo);
+	free(key);
+
+	cp.git_cmd = 1;
+	strvec_pushl(&cp.args, "add", "--no-warn-embedded-repo", NULL);
+	if (info->force)
+		strvec_push(&cp.args, "--force");
+	strvec_pushl(&cp.args, "--", info->sm_path, ".gitmodules", NULL);
+
+	key = xstrfmt("submodule.%s.path", info->sm_name);
+	git_config_set_in_file_gently(".gitmodules", key, info->sm_path);
+	free(key);
+	key = xstrfmt("submodule.%s.url", info->sm_name);
+	git_config_set_in_file_gently(".gitmodules", key, info->repo);
+	free(key);
+	key = xstrfmt("submodule.%s.branch", info->sm_name);
+	if (info->branch)
+		git_config_set_in_file_gently(".gitmodules", key, info->branch);
+	free(key);
+
+	if (run_command(&cp))
+		die(_("failed to add submodule '%s'"), info->sm_path);
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
+	char *path;
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
+	if (reference_path && !is_absolute_path(reference_path) && prefix)
+		reference_path = xstrfmt("%s%s", prefix, reference_path);
+
+	if (argc == 0 || argc > 2) {
+		usage_with_options(usage, options);
+	} else if (argc == 1) {
+		repo = argv[0];
+		path = guess_dir_name(repo);
+	} else {
+		repo = argv[0];
+		path = xstrdup(argv[1]);
+	}
+
+	if (!is_absolute_path(path) && prefix)
+		path = xstrfmt("%s%s", prefix, path);
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
+	normalize_path_copy(path, path);
+	/* strip trailing '/' */
+	if (is_dir_sep(path[strlen(path) -1]))
+		path[strlen(path) - 1] = '\0';
+
+	if (!force) {
+		if (is_directory(path) && submodule_from_path(the_repository, &null_oid, path))
+			die(_("'%s' already exists in the index"), path);
+	} else {
+		int err;
+		if (index_name_pos(&the_index, path, strlen(path)) >= 0 &&
+		    !is_submodule_populated_gently(path, &err))
+			die(_("'%s' already exists in the index and is not a "
+			      "submodule"), path);
+	}
+
+	strbuf_addstr(&sb, path);
+	if (is_directory(path)) {
+		struct object_id oid;
+		if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
+			die(_("'%s' does not have a commit checked out"), path);
+	}
+
+	if (!force) {
+		struct strbuf sb = STRBUF_INIT;
+		struct child_process cp = CHILD_PROCESS_INIT;
+		cp.git_cmd = 1;
+		cp.no_stdout = 1;
+		strvec_pushl(&cp.args, "add", "--dry-run", "--ignore-missing",
+			     "--no-warn-embedded-repo", path, NULL);
+		if (pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))
+			die(_("%s"), sb.buf);
+		strbuf_release(&sb);
+	}
+
+	name = custom_name ? custom_name : path;
+	if (check_submodule_name(name))
+		die(_("'%s' is not a valid submodule name"), name);
+
+	info.prefix = prefix;
+	info.sm_name = name;
+	info.sm_path = path;
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
+
+	free(path);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2352,6 +2722,7 @@ static struct cmd_struct commands[] = {
 	{"config", module_config, 0},
 	{"set-url", module_set_url, 0},
 	{"set-branch", module_set_branch, 0},
+	{"add", module_add, SUPPORT_SUPER_PREFIX},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 43eb6051d2..434db338a4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -171,166 +171,7 @@ cmd_add()
 		shift
 	done
 
-	if ! git submodule--helper config --check-writeable >/dev/null 2>&1
-	then
-		 die "$(eval_gettext "please make sure that the .gitmodules file is in the working tree")"
-	fi
-
-	if test -n "$reference_path"
-	then
-		is_absolute_path "$reference_path" ||
-		reference_path="$wt_prefix$reference_path"
-
-		reference="--reference=$reference_path"
-	fi
-
-	repo=$1
-	sm_path=$2
-
-	if test -z "$sm_path"; then
-		sm_path=$(printf '%s\n' "$repo" |
-			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
-	fi
-
-	if test -z "$repo" || test -z "$sm_path"; then
-		usage
-	fi
-
-	is_absolute_path "$sm_path" || sm_path="$wt_prefix$sm_path"
-
-	# assure repo is absolute or relative to parent
-	case "$repo" in
-	./*|../*)
-		test -z "$wt_prefix" ||
-		die "$(gettext "Relative path can only be used from the toplevel of the working tree")"
-
-		# dereference source url relative to parent's url
-		realrepo=$(git submodule--helper resolve-relative-url "$repo") || exit
-		;;
-	*:*|/*)
-		# absolute url
-		realrepo=$repo
-		;;
-	*)
-		die "$(eval_gettext "repo URL: '\$repo' must be absolute or begin with ./|../")"
-	;;
-	esac
-
-	# normalize path:
-	# multiple //; leading ./; /./; /../; trailing /
-	sm_path=$(printf '%s/\n' "$sm_path" |
-		sed -e '
-			s|//*|/|g
-			s|^\(\./\)*||
-			s|/\(\./\)*|/|g
-			:start
-			s|\([^/]*\)/\.\./||
-			tstart
-			s|/*$||
-		')
-	if test -z "$force"
-	then
-		git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
-		die "$(eval_gettext "'\$sm_path' already exists in the index")"
-	else
-		git ls-files -s "$sm_path" | sane_grep -v "^160000" > /dev/null 2>&1 &&
-		die "$(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
-	fi
-
-	if test -d "$sm_path" &&
-		test -z $(git -C "$sm_path" rev-parse --show-cdup 2>/dev/null)
-	then
-	    git -C "$sm_path" rev-parse --verify -q HEAD >/dev/null ||
-	    die "$(eval_gettext "'\$sm_path' does not have a commit checked out")"
-	fi
-
-	if test -z "$force"
-	then
-	    dryerr=$(git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_path" 2>&1 >/dev/null)
-	    res=$?
-	    if test $res -ne 0
-	    then
-		 echo >&2 "$dryerr"
-		 exit $res
-	    fi
-	fi
-
-	if test -n "$custom_name"
-	then
-		sm_name="$custom_name"
-	else
-		sm_name="$sm_path"
-	fi
-
-	if ! git submodule--helper check-name "$sm_name"
-	then
-		die "$(eval_gettext "'$sm_name' is not a valid submodule name")"
-	fi
-
-	# perhaps the path exists and is already a git repo, else clone it
-	if test -e "$sm_path"
-	then
-		if test -d "$sm_path"/.git || test -f "$sm_path"/.git
-		then
-			eval_gettextln "Adding existing repo at '\$sm_path' to the index"
-		else
-			die "$(eval_gettext "'\$sm_path' already exists and is not a valid git repo")"
-		fi
-
-	else
-		if test -d ".git/modules/$sm_name"
-		then
-			if test -z "$force"
-			then
-				eval_gettextln >&2 "A git directory for '\$sm_name' is found locally with remote(s):"
-				GIT_DIR=".git/modules/$sm_name" GIT_WORK_TREE=. git remote -v | grep '(fetch)' | sed -e s,^,"  ", -e s,' (fetch)',, >&2
-				die "$(eval_gettextln "\
-If you want to reuse this local git directory instead of cloning again from
-  \$realrepo
-use the '--force' option. If the local git directory is not the correct repo
-or you are unsure what this means choose another name with the '--name' option.")"
-			else
-				eval_gettextln "Reactivating local git directory for submodule '\$sm_name'."
-			fi
-		fi
-		git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"--progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
-		(
-			sanitize_submodule_env
-			cd "$sm_path" &&
-			# ash fails to wordsplit ${branch:+-b "$branch"...}
-			case "$branch" in
-			'') git checkout -f -q ;;
-			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
-			esac
-		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
-	fi
-	git config submodule."$sm_name".url "$realrepo"
-
-	git add --no-warn-embedded-repo $force "$sm_path" ||
-	die "$(eval_gettext "Failed to add submodule '\$sm_path'")"
-
-	git submodule--helper config submodule."$sm_name".path "$sm_path" &&
-	git submodule--helper config submodule."$sm_name".url "$repo" &&
-	if test -n "$branch"
-	then
-		git submodule--helper config submodule."$sm_name".branch "$branch"
-	fi &&
-	git add --force .gitmodules ||
-	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
-
-	# NEEDSWORK: In a multi-working-tree world, this needs to be
-	# set in the per-worktree config.
-	if git config --get submodule.active >/dev/null
-	then
-		# If the submodule being adding isn't already covered by the
-		# current configured pathspec, set the submodule's active flag
-		if ! git submodule--helper is-active "$sm_path"
-		then
-			git config submodule."$sm_name".active "true"
-		fi
-	else
-		git config submodule."$sm_name".active "true"
-	fi
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper add ${force:+--force} ${GIT_QUIET:+--quiet} ${progress:+--progress} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
 }
 
 #
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index fec7e0299d..f26edddbb8 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -48,7 +48,7 @@ test_expect_success 'submodule update aborts on missing gitmodules url' '
 
 test_expect_success 'add aborts on repository with no commits' '
 	cat >expect <<-\EOF &&
-	'"'repo-no-commits'"' does not have a commit checked out
+	fatal: '"'repo-no-commits'"' does not have a commit checked out
 	EOF
 	git init repo-no-commits &&
 	test_must_fail git submodule add ../a ./repo-no-commits 2>actual &&
@@ -171,11 +171,12 @@ test_expect_success 'submodule add to .gitignored path fails' '
 	(
 		cd addtest-ignore &&
 		cat <<-\EOF >expect &&
-		The following paths are ignored by one of your .gitignore files:
+		fatal: The following paths are ignored by one of your .gitignore files:
 		submod
 		hint: Use -f if you really want to add them.
 		hint: Turn this message off by running
 		hint: "git config advice.addIgnoredFile false"
+
 		EOF
 		# Does not use test_commit due to the ignore
 		echo "*" > .gitignore &&
-- 
2.28.0

