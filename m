Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE93FC07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 07:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BEB613EE
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 07:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhGJHvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 03:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbhGJHvT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 03:51:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA68C0613E8
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 00:48:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso7364977pjp.5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 00:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MgKdXlihdba9Orpe7fA22uQNtfGbITNM3J5oi67u9Zg=;
        b=QWPKhDR+bRo6/eaClV4fLmO2r2Kdg9LWyYM8HuqRfBkSQ+CIS6Q82NnXuDFXQ4GtTh
         UzGCxHHWFe9Ux1GkCYT7Pj4jB+gKumTvK2fkxSPUqNV/oGBzp9npi2JG4gobN1+OtPOv
         7Ropchsm/d4CkciOFJj4iXfoSA8KEipI6547BzHF49mHeuTjJhMHhE1gSGVuafOPQcJc
         u6n9FDeSbO7nEXIXDxDVd6+jJGYQUbm76CKB6adUEXTjvTJaMfzJ9HfXzNGE+DGotSJd
         Mt3ZcmAlfH9tMfN5Q1nSyGGjpRImQvw4mYiJnOGaNm6aEFlOhRngrEjs6tr16EJCtfEj
         Q/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MgKdXlihdba9Orpe7fA22uQNtfGbITNM3J5oi67u9Zg=;
        b=WkobCheKWzWZA7vnG1/ytx5p/6olpJpVdYdNl8LjS8T98ImR5a8PaUSJuCBQRAzZto
         f2ftNg5Vxw1X9hXSK/9t/96wjLDH3VqUCl9+edLdtJx5fTZOA5W1j/YSxlsYHfS5qYGe
         5N4odSTDDIkvdO6XtOJAIYlo4C1meSXA7i5u34T2gNyT9hq5ZPmUF8gkxQxrO2WtoGyE
         cA/Tzirhd08O3ReazoChiRASee9189C1ZqdFXfqBzlfnyLSCAHYp994KR2obVpCYAPXI
         NeqO2vaMJlV+ZrcplUScZTcT4rOfw4nlpgHgTuN8VB0yzs4eg1VTag0G2LHzudSpQFND
         XVew==
X-Gm-Message-State: AOAM531elvu26bhLs8zWnIWwOPU3y3Ff0CObvGCphu+wCrMaj4lRozEb
        ZoABTmIMkzBVhDjD9tLaRGz9xcfo4OFhPx5r
X-Google-Smtp-Source: ABdhPJxexYc7hgQLIiRmL3cNbplI3CDxfj7Kl5HowovB+q/V4aXhSDDCmaOniNaSw2jNK+6SMj6tyQ==
X-Received: by 2002:a17:90a:d80f:: with SMTP id a15mr6210175pjv.174.1625903313248;
        Sat, 10 Jul 2021 00:48:33 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id 125sm8811327pfg.52.2021.07.10.00.48.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Jul 2021 00:48:32 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [GSoC] [PATCH v3 4/4] submodule--helper: introduce add-clone subcommand
Date:   Sat, 10 Jul 2021 13:18:01 +0530
Message-Id: <20210710074801.19917-5-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210710074801.19917-1-raykar.ath@gmail.com>
References: <20210708095533.26226-1-raykar.ath@gmail.com>
 <20210710074801.19917-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
'cmd_add()' script unchanged.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Based-on-patch-by: Shourya Shukla <periperidip@gmail.com>
Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/submodule--helper.c | 177 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  38 +-------
 2 files changed, 178 insertions(+), 37 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 320f4252fe..862053c9f2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2760,6 +2760,182 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
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
+		char *next_line;
+		char *line = sb_remote_out.buf;
+		while ((next_line = strchr(line, '\n')) != NULL) {
+			size_t len = next_line - line;
+			if (strip_suffix_mem(line, &len, " (fetch)"))
+				fprintf(output, "  %.*s\n", (int)len, line);
+			line = next_line + 1;
+		}
+	}
+
+	strbuf_release(&sb_remote_out);
+}
+
+static int add_submodule(const struct add_data *add_data)
+{
+	char *submod_gitdir_path;
+	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
+
+	/* perhaps the path already exists and is already a git repo, else clone it */
+	if (is_directory(add_data->sm_path)) {
+		struct strbuf sm_path = STRBUF_INIT;
+		strbuf_addstr(&sm_path, add_data->sm_path);
+		submod_gitdir_path = xstrfmt("%s/.git", add_data->sm_path);
+		if (is_nonbare_repository_dir(&sm_path))
+			printf(_("Adding existing repo at '%s' to the index\n"),
+			       add_data->sm_path);
+		else
+			die(_("'%s' already exists and is not a valid git repo"),
+			    add_data->sm_path);
+		strbuf_release(&sm_path);
+		free(submod_gitdir_path);
+	} else {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		submod_gitdir_path = xstrfmt(".git/modules/%s", add_data->sm_name);
+
+		if (is_directory(submod_gitdir_path)) {
+			if (!add_data->force) {
+				fprintf(stderr, _("A git directory for '%s' is found "
+						  "locally with remote(s):"),
+					add_data->sm_name);
+				show_fetch_remotes(stderr, add_data->sm_name,
+						   submod_gitdir_path);
+				free(submod_gitdir_path);
+				die(_("If you want to reuse this local git "
+				      "directory instead of cloning again from\n"
+				      "  %s\n"
+				      "use the '--force' option. If the local git "
+				      "directory is not the correct repo\n"
+				      "or if you are unsure what this means, choose "
+				      "another name with the '--name' option.\n"),
+				    add_data->realrepo);
+			} else {
+				printf(_("Reactivating local git directory for "
+					 "submodule '%s'\n"), add_data->sm_name);
+			}
+		}
+		free(submod_gitdir_path);
+
+		clone_data.prefix = add_data->prefix;
+		clone_data.path = add_data->sm_path;
+		clone_data.name = add_data->sm_name;
+		clone_data.url = add_data->realrepo;
+		clone_data.quiet = add_data->quiet;
+		clone_data.progress = add_data->progress;
+		if (add_data->reference_path)
+			string_list_append(&clone_data.reference,
+					   xstrdup(add_data->reference_path));
+		clone_data.dissociate = add_data->dissociate;
+		if (add_data->depth >= 0)
+			clone_data.depth = xstrfmt("%d", add_data->depth);
+
+		if (clone_submodule(&clone_data))
+			return -1;
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
+		OPT_STRING(0, "prefix", &prefix,
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
+		OPT__FORCE(&force, N_("allow adding an otherwise ignored submodule path"),
+			   PARSE_OPT_NOCOMPLETE),
+		OPT__QUIET(&quiet, "suppress output for cloning a submodule"),
+		OPT_END()
+	};
+
+	const char *const usage[] = {
+		N_("git submodule--helper add-clone [<options>...] "
+		   "--url <url> --path <path> --name <name>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	if (argc != 0)
+		usage_with_options(usage, options);
+
+	add_data.prefix = prefix;
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
@@ -2772,6 +2948,7 @@ static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
+	{"add-clone", add_clone, 0},
 	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 69bcb4fab2..053daf3724 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -241,43 +241,7 @@ cmd_add()
 		die "fatal: $(eval_gettext "'$sm_name' is not a valid submodule name")"
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
2.32.0

