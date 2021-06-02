Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74E0C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 13:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91BF761246
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 13:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFBNQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 09:16:10 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:42883 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhFBNQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 09:16:09 -0400
Received: by mail-pf1-f180.google.com with SMTP id s14so1269527pfd.9
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYNeAbo1I+EKI9CMjW80HEwd3SnYraWRZusMnvXecPU=;
        b=SCxZ/ElJNjevXblfrblspuximNYmHmGsXSt3H8DUb1bBqonH5fldwk2+tRw327938Z
         KllHD/6Hlo+MaTvq3vVBdHPoixm8xVKnOpRaGOE2tVM6kLt8jydnflprl8NiznVFwHcs
         CsECxAv8I/Ny70yxriJ2RIiwoC7uukx5sTGSo7dqPaBKo+2Eksw/vszzMQskCcwyFxUW
         skrXW4geCl+8z5h5hpu35THtaaewWB9ZSy97iKiLv5mBt6FU9bH4/SsLoj5o1GS4hgm7
         u7Me7dHJ0nC/JMw1eEUNEt5uy7CnqL17wyTwj0O6o287OL25bx26zzLzUq2nSonfXmJj
         +O8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYNeAbo1I+EKI9CMjW80HEwd3SnYraWRZusMnvXecPU=;
        b=hpBMn501fSuHJHs0yDteXNhMHlwvJskppqfJTrjl0paBNdllRVvRG480mJKwEXqxe0
         hCp9JOLW+ObQjml9CfCTk5U7/lT6bYVA7qYYoRoAPbT6V9eVO5qQXpySTzmEg0Y16xBw
         t0p3qmMoE2xZYfl+IEWT9Owo8QMEK8UqCAFXpCIN1aHVwgHfqx9UcPPGb25oYu9kwUmo
         1xY4OzJIPGwCpjOFWK3m/+8ySYkXJWNYP45BZpCqWx4/rBrqtOEFrAr/7gjnNZihjJjv
         ri+MlRCsFK3AFGID3RBl2wPTkqZnw8Yj/z7f7iknfW+TG/kT+I9ZUMPFJ9rc/Nv7AF6a
         GfYw==
X-Gm-Message-State: AOAM531eCk6E+5VRcbCslTIA6tHhFpul5Pe+iV+7DbmCDkUpJbo29PKi
        txGBdQK/mom5Obb09tdep+O1r2Od0A1835t1e5o=
X-Google-Smtp-Source: ABdhPJwVe4AdNYa0fvQ5atAomYvEzDYSnKhfpCh07gDVasaOUPaCfGtF0QL84oJ6tllrq9emhQZ1Ag==
X-Received: by 2002:a63:f40d:: with SMTP id g13mr34640271pgi.290.1622639606116;
        Wed, 02 Jun 2021 06:13:26 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id t20sm13426716pjs.11.2021.06.02.06.13.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jun 2021 06:13:25 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v2] [GSoC] submodule--helper: introduce add-clone subcommand
Date:   Wed,  2 Jun 2021 18:42:59 +0530
Message-Id: <20210602131259.50350-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528081224.69163-1-raykar.ath@gmail.com>
References: <20210528081224.69163-1-raykar.ath@gmail.com>
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

This is part of a series of changes that will result in all of 'submodule add'
being converted to C, which is a more familiar language for Git developers, and
paves the way to improve performance and portability.

I have made this patch based on Shourya's patch[1]. I have decided to send the
changes in smaller, more reviewable parts. The add-clone subcommand of
submodule--helper is an intermediate change, while I work on translating all of
the code.

Another subcommand called 'add-config' will also be added in a separate patch
that handles the configuration on adding the module.

After those two changes look good enough, I will be converting whatever is left
of 'git submodule add' in the git-submodule.sh past the flag parsing into C code
by having one helper subcommand called 'git submodule--helper add' that will
incorporate the functionality of the other two helpers, as well. In that patch,
the 'add-clone' and 'add-config' subcommands will be removed from the commands
array, as they will be called from within the C code itself.

Changes since v1:
 * Fixed typos, and made commit message more explicit
 * Fixed incorrect usage string
 * Some style changes were made

 builtin/submodule--helper.c | 212 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  38 +------
 2 files changed, 213 insertions(+), 37 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d55f6262e9..bbbb42088b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2745,6 +2745,217 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
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
+		char *line;
+		char *begin = sb_remote_out.buf;
+		char *end = sb_remote_out.buf + sb_remote_out.len;
+		while (begin != end && (line = get_next_line(begin, end))) {
+			char *name, *url, *tail;
+			name = parse_token(&begin, line);
+			url = parse_token(&begin, line);
+			tail = parse_token(&begin, line);
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
+		strvec_pushl(&clone_args, "clone", "--path", info->sm_path, "--name",
+			     info->sm_name, "--url", info->realrepo, NULL);
+		if (info->quiet)
+			strvec_push(&clone_args, "--quiet");
+		if (info->progress)
+			strvec_push(&clone_args, "--progress");
+		if (info->prefix)
+			strvec_pushl(&clone_args, "--prefix", info->prefix, NULL);
+		if (info->reference_path)
+			strvec_pushl(&clone_args, "--reference",
+				     info->reference_path, NULL);
+		if (info->dissociate)
+			strvec_push(&clone_args, "--dissociate");
+		if (info->depth >= 0)
+			strvec_pushf(&clone_args, "--depth=%d", info->depth);
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
+		N_("git submodule--helper add-clone [--prefix=<path>] [--quiet] [--force] "
+		   "[--reference <repository>] [--depth <depth>] [-b|--branch <branch>]"
+		   "[--progress] [--dissociate] --url <url> --path <path> --name <name>"),
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
@@ -2757,6 +2968,7 @@ static struct cmd_struct commands[] = {
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

