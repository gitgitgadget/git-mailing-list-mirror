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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECE2C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 08:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 756366142D
	for <git@archiver.kernel.org>; Fri, 28 May 2021 08:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbhE1IOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 04:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbhE1IOp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 04:14:45 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2543C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 01:13:10 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 6so1958204pgk.5
        for <git@vger.kernel.org>; Fri, 28 May 2021 01:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDQ0F9ZRRDdeI1FeHD1gdpAhKIBt/uKUdmUNuWGZJo0=;
        b=N6+F92ZQBaLbL04qeqlxHdBTQ1N7EYNsGFWgpivHVgNvnWPJiT9nr/XCuXI67n+OOO
         VFZP6Wr6Edh3JLoK83Nm/Cexgrb71/HRik0g88v5cPZ8Pq1uUbhHLPl/vCbBlbQpqRew
         ejmPQJ5PQ8blOx7Ky+qgNNy9yu3VHS6Lhub+Ch4q0ES7WUXdEG+ToEtJr+092jYcfwb0
         mSKtck5v4EiWSjDr8iWmSKUuFTnh4sTNFVydvTm6+QFk5l/4K4idJ6F0e1HphsYdalAG
         qkUqdz5PZwKCHKV6tzLz3JVpT44Ip+ugKOCDcoxdimcP/rPFFkVzWlN1IvQH+tWxbjZ3
         4i/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fDQ0F9ZRRDdeI1FeHD1gdpAhKIBt/uKUdmUNuWGZJo0=;
        b=KjwZqYnmLXicm6OnGZ56ZqugwDM08UxhGoiiVZ+7BYjOxR5RVxWwqEeRemWktLS1jR
         O9TXCesaRXcRXRUSR85NNuAuRvgfEm1RojYBsx5B7V3swspc9EHgKZvk0ea1wXGJZMZ5
         sPKY+7ZTO5L+/E+PjhphcMJVnu4/MMXbNMghtAlgWhy90Aa8nYDP390B+8UsVn1xMAsr
         2/k0cjoF4Rq3t5IpRxbWfERf5eLx/at7H8M+K69HgT6ZlL2IUKyfkzaM/9XEU2kvnFL+
         rsPXCnz0BzrLtgYawFtDdfiXMYpGnPbz8DqF0+wU4KXpyABHIkdv1u+DTe/ogdTN7DAZ
         sExg==
X-Gm-Message-State: AOAM5330dQdEqSaVhJ/SqqttSCIoT7nzWuWJ9Ak82LT14VImbGWJAWQZ
        jiDnJJuKVhhAXKqWWhmRQVfa48Qy7iFZmil3
X-Google-Smtp-Source: ABdhPJxk3e0NKKRNwzaIOYwnfuAVpYJeeY8rZhZFBZf4CHUaDb9unHHan60V+oxMaklteHuh1Yrs6w==
X-Received: by 2002:a63:4e12:: with SMTP id c18mr7663467pgb.451.1622189589208;
        Fri, 28 May 2021 01:13:09 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id o186sm3756727pfg.170.2021.05.28.01.13.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 May 2021 01:13:08 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH][GSoC] submodule: introduce add-clone helper for submodule add
Date:   Fri, 28 May 2021 13:42:24 +0530
Message-Id: <20210528081224.69163-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the the shell code that performs the cloning of the repository that is
to be added, and checks out to the appropriate branch.

This is meant to be a faithful conversion that leaves the behaviour of
'submodule add' unchanged. The only minor change is that if a submodule name has
been supplied with a name that clashes with a local submodule, the message shown
to the user ("A git directory for 'foo' is found locally...") is prepended with
"error" for clarity.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <shouryashukla.oo@gmail.com>
Based-on-patch-by: Shourya Shukla <shouryashukla.oo@gmail.com>
Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
---

This is part of a series of changes that will result in all of 'submodule add'
being converted to C, which is a more familiar language for Git developers, and
paves the way to improve performance and portability.

I have made this patch based on Shourya's patch[1]. I have decided to send the
changes in smaller, more reviewable parts. The add-clone subcommand of
submodule--helper is an intermediate change, while I work on translating all of
the code. So in the next few patches, this helper subcommand is likely to be
removed as its functionality would be invoked from the C code itself.

[1] https://lore.kernel.org/git/20201214231939.644175-1-periperidip@gmail.com/

 builtin/submodule--helper.c | 221 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  38 +------
 2 files changed, 222 insertions(+), 37 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d55f6262e9..39a844b0b1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2745,6 +2745,226 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
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
+static char *parse_token(char **begin, const char *end)
+{
+	int size;
+	char *token, *pos = *begin;
+	while (pos != end && (*pos != ' ' && *pos != '\t' && *pos != '\n'))
+		pos++;
+	size = pos - *begin;
+	token = xstrndup(*begin, size);
+	*begin = pos + 1;
+	return token;
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
+		char *next_line, *name, *url, *tail;
+		char *begin = sb_remote_out.buf;
+		char *end = sb_remote_out.buf + sb_remote_out.len;
+		while (begin != end &&
+		       (next_line = get_next_line(begin, end))) {
+			name = parse_token(&begin, next_line);
+			url = parse_token(&begin, next_line);
+			tail = parse_token(&begin, next_line);
+			if (!memcmp(tail, "(fetch)", 7))
+				fprintf(output, "  %s\t%s\n", name, url);
+			free(url);
+			free(name);
+			free(tail);
+		}
+	}
+
+	strbuf_release(&sb_remote_out);
+}
+
+static int add_submodule(const struct add_data *info)
+{
+	char *submod_gitdir_path;
+	/* perhaps the path already exists and is already a git repo, else clone it */
+	if (is_directory(info->sm_path)) {
+		printf("sm_path=%s\n", info->sm_path);
+		submod_gitdir_path = xstrfmt("%s/.git", info->sm_path);
+		if (is_directory(submod_gitdir_path) || file_exists(submod_gitdir_path))
+			printf(_("Adding existing path at '%s' to index\n"),
+			       info->sm_path);
+		else
+			die(_("'%s' already exists and is not a valid git repo"),
+			    info->sm_path);
+		free(submod_gitdir_path);
+	} else {
+		struct strvec clone_args = STRVEC_INIT;
+		struct child_process cp = CHILD_PROCESS_INIT;
+		submod_gitdir_path = xstrfmt(".git/modules/%s", info->sm_name);
+
+		if (is_directory(submod_gitdir_path)) {
+			if (!info->force) {
+				error(_("A git directory for '%s' is found "
+					"locally with remote(s):"), info->sm_name);
+				show_fetch_remotes(stderr, info->sm_name,
+						   submod_gitdir_path);
+				fprintf(stderr,
+					_("If you want to reuse this local git "
+					  "directory instead of cloning again from\n"
+					  "  %s\n"
+					  "use the '--force' option. If the local git "
+					  "directory is not the correct repo\n"
+					  "or if you are unsure what this means, choose "
+					  "another name with the '--name' option.\n"),
+					info->realrepo);
+				free(submod_gitdir_path);
+				return 1;
+			} else {
+				printf(_("Reactivating local git directory for "
+					 "submodule '%s'\n"), info->sm_name);
+			}
+		}
+		free(submod_gitdir_path);
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
+
+		strvec_pushl(&clone_args, "--path", info->sm_path, "--name",
+			     info->sm_name, "--url", info->realrepo, NULL);
+
+		if (info->reference_path)
+			strvec_pushl(&clone_args, "--reference",
+				     info->reference_path, NULL);
+
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
+		strvec_clear(&clone_args);
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
+static int add_clone(int argc, const char **argv, const char *prefix)
+{
+	const char *branch = NULL, *sm_path = NULL;
+	const char *wt_prefix = NULL, *realrepo = NULL;
+	const char *reference = NULL, *sm_name = NULL;
+	int force = 0, quiet = 0, dissociate = 0, depth = -1, progress = 0;
+	struct add_data info = ADD_DATA_INIT;
+
+	struct option options[] = {
+		OPT_STRING('b', "branch", &branch,
+			   N_("branch"),
+			   N_("branch of repository to checkout on cloning")),
+		OPT_STRING(0, "prefix", &wt_prefix,
+			   N_("path"),
+			   N_("alternative anchor for relative paths")),
+		OPT_STRING(0, "path", &sm_path,
+			   N_("path"),
+			   N_("where the new submodule will be cloned to")),
+		OPT_STRING(0, "name", &sm_name,
+			   N_("string"),
+			   N_("name of the new submodule")),
+		OPT_STRING(0, "url", &realrepo,
+			   N_("string"),
+			   N_("url where to clone the submodule from")),
+		OPT_STRING(0, "reference", &reference,
+			   N_("repo"),
+			   N_("reference repository")),
+		OPT_BOOL(0, "dissociate", &dissociate,
+			   N_("use --reference only while cloning")),
+		OPT_INTEGER(0, "depth", &depth,
+			    N_("depth for shallow clones")),
+		OPT_BOOL(0, "progress", &progress,
+			   N_("force cloning progress")),
+		OPT_BOOL('f', "force", &force,
+			 N_("allow adding an otherwise ignored submodule path")),
+		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
+		OPT_END()
+	};
+
+	const char *const usage[] = {
+		N_("git submodule--helper clone [--prefix=<path>] [--quiet] [--force] "
+		   "[--reference <repository>] [--depth <depth>] [-b|--branch <branch>]"
+		   "--url <url> --path <path> --name <name>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	info.prefix = prefix;
+	info.sm_name = sm_name;
+	info.sm_path = sm_path;
+	info.realrepo = realrepo;
+	info.reference_path = reference;
+	info.branch = branch;
+	info.depth = depth;
+	info.progress = !!progress;
+	info.dissociate = !!dissociate;
+	info.force = !!force;
+	info.quiet = !!quiet;
+
+	if (add_submodule(&info))
+		return 1;
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2757,6 +2977,7 @@ static struct cmd_struct commands[] = {
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

