Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAB8C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B5260FDA
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhFHKBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 06:01:04 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:35823 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFHKBD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 06:01:03 -0400
Received: by mail-pj1-f48.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso7216671pjb.0
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 02:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N2xb+WTbp3X76kvajtMsoV3+ZavLpQ8319vLqN5KPXg=;
        b=ZNq8Crl/TNoCG/7zShY0uunF6w4C4334FiGwLiwA0XgmN3sdl1yHJbrUQYH1dKhkaJ
         9GGYT0ZMZRBMuhddiMlpvif+VCes9IdKadCP2LWzz9QBWz3hLhWFSZg0vYjxVLIj4orM
         sN7UQREAM6WBQE+FRvFkQOy90cOS0ebry6YCcjAvFwwCA2QnlD9nt7iPA56YhC6mUbI0
         gKDErIk/5RF7LRW1AIBd7Fq0bw8dJfHVNSWnYvVWD3kRjOumMWR4B1gMrqgWf9iE5gy3
         RBMn2CMsbRY1YjYi2TsGXKIGL0hVH8I9RKwj5NrRzPTFlv8yzwfTt1IuHQZB0KXMGyeH
         /s0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N2xb+WTbp3X76kvajtMsoV3+ZavLpQ8319vLqN5KPXg=;
        b=awqi2sefsuQNcppTSbaeKD4xr9oDZc/N8madWx1s1ed2N1RVo6byvAEkAwUtjPXbcl
         4uNULnlqBvsmaUSwU+SKETfup6qq6jRB9BaR1DrWvCLhcCjNRjtDbLA0BSlQCEKy+nFH
         Xhpq2uEvgqHEImpF99xecnZKGvoFuw6EUry3XTMA3w6fr7cR1bU7UNvUBbLWun4J+yMA
         dK0O+vFykD8mt9jDAT2Lzm5R5etOUDPUjWNyFY2uWbl9O9YihoBzPWhAhOHLnSGp7y3q
         nzuZqIIU/mgwAuhL1y1RCPJXRp6Lhs+e8BM3EPM1JKXRtuBxVBvYy0FOxO309PV2H0Ue
         FtQA==
X-Gm-Message-State: AOAM532Gz+JZiKVclpj8GTjfV8QZOBQq4usX7V9p2ycEWnKniGJ+Oypu
        Htr8WoDuGVXQoR8dkDFnHcBLv/WhbGlJ8K3TWr4=
X-Google-Smtp-Source: ABdhPJyRdNMEWsa3/Rtu8x0ozPvYQwK2rOgYW+isF2A+l1HOORSZTVOQnedC5DBplcX6cSiwN3+Wcw==
X-Received: by 2002:a17:90a:19c6:: with SMTP id 6mr25395470pjj.125.1623146290869;
        Tue, 08 Jun 2021 02:58:10 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id p20sm10323979pff.204.2021.06.08.02.58.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 02:58:10 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC] [PATCH v2 1/2] submodule--helper: introduce add-clone subcommand
Date:   Tue,  8 Jun 2021 15:26:54 +0530
Message-Id: <20210608095655.47324-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608095655.47324-1-raykar.ath@gmail.com>
References: <20210605113913.29005-1-raykar.ath@gmail.com>
 <20210608095655.47324-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's add a new "add-clone" subcommand to `git submodule--helper` with
the goal of converting part of the shell code in git-submodule.sh
related to `git submodule add` into C code. This new subcommand clones
the repository that is to be added, and checks out to the appropriate
branch.

This is meant to be a faithful conversion that leaves the behaviour of
'submodule add' unchanged. The only minor change is that if a submodule name has
been supplied with a name that clashes with a local submodule, the message shown
to the user ("A git directory for 'foo' is found locally...") is prepended with
"error" for clarity.

This is part of a series of changes that will result in all of 'submodule add'
being converted to C.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <shouryashukla.oo@gmail.com>
Based-on-patch-by: Shourya Shukla <shouryashukla.oo@gmail.com>
Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 199 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  38 +------
 2 files changed, 200 insertions(+), 37 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d55f6262e9..c9cb535312 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2745,6 +2745,204 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
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
+#define ADD_DATA_INIT { .depth = -1 }
+
+static char *parse_token(char **begin, const char *end, int *tok_len)
+{
+	char *tok_start, *pos = *begin;
+	while (pos != end && (*pos != ' ' && *pos != '\t' && *pos != '\n'))
+		pos++;
+	tok_start = *begin;
+	*tok_len = pos - *begin;
+	*begin = pos + 1;
+	return tok_start;
+}
+
+static char *get_next_line(char *const begin, const char *const end)
+{
+	char *pos = begin;
+	while (pos != end && *pos++ != '\n');
+	return pos;
+}
+
+static void show_fetch_remotes(FILE *output, const char *sm_name, const char *git_dir_path)
+{
+	struct child_process cp_remote = CHILD_PROCESS_INIT;
+	struct strbuf sb_remote_out = STRBUF_INIT;
+
+	cp_remote.git_cmd = 1;
+	strvec_pushf(&cp_remote.env_array,
+		     "GIT_DIR=%s", git_dir_path);
+	strvec_push(&cp_remote.env_array, "GIT_WORK_TREE=.");
+	strvec_pushl(&cp_remote.args, "remote", "-v", NULL);
+	if (!capture_command(&cp_remote, &sb_remote_out, 0)) {
+		char *line;
+		char *begin = sb_remote_out.buf;
+		char *end = sb_remote_out.buf + sb_remote_out.len;
+		while (begin != end && (line = get_next_line(begin, end))) {
+			int namelen = 0, urllen = 0, taillen = 0;
+			char *name = parse_token(&begin, line, &namelen);
+			char *url = parse_token(&begin, line, &urllen);
+			char *tail = parse_token(&begin, line, &taillen);
+			if (!memcmp(tail, "(fetch)", 7))
+				fprintf(output, "  %.*s\t%.*s\n",
+					namelen, name, urllen, url);
+		}
+	}
+
+	strbuf_release(&sb_remote_out);
+}
+
+static int add_submodule(const struct add_data *add_data)
+{
+	char *submod_gitdir_path;
+	/* perhaps the path already exists and is already a git repo, else clone it */
+	if (is_directory(add_data->sm_path)) {
+		submod_gitdir_path = xstrfmt("%s/.git", add_data->sm_path);
+		if (is_directory(submod_gitdir_path) || file_exists(submod_gitdir_path))
+			printf(_("Adding existing path at '%s' to index\n"),
+			       add_data->sm_path);
+		else
+			die(_("'%s' already exists and is not a valid git repo"),
+			    add_data->sm_path);
+		free(submod_gitdir_path);
+	} else {
+		struct strvec clone_args = STRVEC_INIT;
+		struct child_process cp = CHILD_PROCESS_INIT;
+		submod_gitdir_path = xstrfmt(".git/modules/%s", add_data->sm_name);
+
+		if (is_directory(submod_gitdir_path)) {
+			if (!add_data->force) {
+				error(_("A git directory for '%s' is found "
+					"locally with remote(s):"), add_data->sm_name);
+				show_fetch_remotes(stderr, add_data->sm_name,
+						   submod_gitdir_path);
+				fprintf(stderr,
+					_("If you want to reuse this local git "
+					  "directory instead of cloning again from\n"
+					  "  %s\n"
+					  "use the '--force' option. If the local git "
+					  "directory is not the correct repo\n"
+					  "or if you are unsure what this means, choose "
+					  "another name with the '--name' option.\n"),
+					add_data->realrepo);
+				free(submod_gitdir_path);
+				return 1;
+			} else {
+				printf(_("Reactivating local git directory for "
+					 "submodule '%s'\n"), add_data->sm_name);
+			}
+		}
+		free(submod_gitdir_path);
+
+		strvec_pushl(&clone_args, "clone", "--path", add_data->sm_path, "--name",
+			     add_data->sm_name, "--url", add_data->realrepo, NULL);
+		if (add_data->quiet)
+			strvec_push(&clone_args, "--quiet");
+		if (add_data->progress)
+			strvec_push(&clone_args, "--progress");
+		if (add_data->prefix)
+			strvec_pushl(&clone_args, "--prefix", add_data->prefix, NULL);
+		if (add_data->reference_path)
+			strvec_pushl(&clone_args, "--reference",
+				     add_data->reference_path, NULL);
+		if (add_data->dissociate)
+			strvec_push(&clone_args, "--dissociate");
+		if (add_data->depth >= 0)
+			strvec_pushf(&clone_args, "--depth=%d", add_data->depth);
+
+		if (module_clone(clone_args.nr, clone_args.v, add_data->prefix)) {
+			strvec_clear(&clone_args);
+			return -1;
+		}
+		strvec_clear(&clone_args);
+
+		prepare_submodule_repo_env(&cp.env_array);
+		cp.git_cmd = 1;
+		cp.dir = add_data->sm_path;
+		strvec_pushl(&cp.args, "checkout", "-f", "-q", NULL);
+
+		if (add_data->branch) {
+			strvec_pushl(&cp.args, "-B", add_data->branch, NULL);
+			strvec_pushf(&cp.args, "origin/%s", add_data->branch);
+		}
+
+		if (run_command(&cp))
+			die(_("unable to checkout submodule '%s'"), add_data->sm_path);
+	}
+	return 0;
+}
+
+static int add_clone(int argc, const char **argv, const char *prefix)
+{
+	int force = 0, quiet = 0, dissociate = 0, progress = 0;
+	struct add_data add_data = ADD_DATA_INIT;
+
+	struct option options[] = {
+		OPT_STRING('b', "branch", &add_data.branch,
+			   N_("branch"),
+			   N_("branch of repository to checkout on cloning")),
+		OPT_STRING(0, "prefix", &add_data.prefix,
+			   N_("path"),
+			   N_("alternative anchor for relative paths")),
+		OPT_STRING(0, "path", &add_data.sm_path,
+			   N_("path"),
+			   N_("where the new submodule will be cloned to")),
+		OPT_STRING(0, "name", &add_data.sm_name,
+			   N_("string"),
+			   N_("name of the new submodule")),
+		OPT_STRING(0, "url", &add_data.realrepo,
+			   N_("string"),
+			   N_("url where to clone the submodule from")),
+		OPT_STRING(0, "reference", &add_data.reference_path,
+			   N_("repo"),
+			   N_("reference repository")),
+		OPT_BOOL(0, "dissociate", &dissociate,
+			 N_("use --reference only while cloning")),
+		OPT_INTEGER(0, "depth", &add_data.depth,
+			    N_("depth for shallow clones")),
+		OPT_BOOL(0, "progress", &progress,
+			 N_("force cloning progress")),
+		OPT_BOOL('f', "force", &force,
+			 N_("allow adding an otherwise ignored submodule path")),
+		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
+		OPT_END()
+	};
+
+	const char *const usage[] = {
+		N_("git submodule--helper add-clone [--prefix=<path>] [--quiet] [--force] "
+		   "[--reference <repository>] [--depth <depth>] [-b|--branch <branch>]"
+		   "[--progress] [--dissociate] --url <url> --path <path> --name <name>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	add_data.progress = !!progress;
+	add_data.dissociate = !!dissociate;
+	add_data.force = !!force;
+	add_data.quiet = !!quiet;
+
+	if (add_submodule(&add_data))
+		return 1;
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2757,6 +2955,7 @@ static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
+	{"add-clone", add_clone, 0},
 	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 4678378424..f71e1e5495 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -241,43 +241,7 @@ cmd_add()
 		die "$(eval_gettext "'$sm_name' is not a valid submodule name")"
 	fi
 
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
+	git submodule--helper add-clone ${GIT_QUIET:+--quiet} ${force:+"--force"} ${progress:+"--progress"} ${branch:+--branch "$branch"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
 	git config submodule."$sm_name".url "$realrepo"
 
 	git add --no-warn-embedded-repo $force "$sm_path" ||
-- 
2.31.1

