Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300C5C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197616145D
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhFOPAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 11:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhFOPAW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 11:00:22 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D331CC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:58:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z26so13456039pfj.5
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OkgSEeH9ULVrrmSUGnpLpQj8nOgggoVDNaLNK/5lGBA=;
        b=pCXh6qSEsV4afVGKotP1Z3iNpn2AB158aBX15Ei+9ruOho8edNfrC8mgiI6ooARSGX
         qq0jNRsomNGFwHY/9VZrxall3ypgD8ajWAhB0BtCL4z+VG3GK1yv1eVQ37m2lqcnN2OP
         F3XaEVoXcEjQVv3KYkvavtjRGfse/CkCjTr3XXePO1dfktcNIj6p25Zi64YWl64YKooL
         ABufN84N68fKH+94PwebrZ3+uewpnsJNEdMusM6l1rHapnOtQC5ZAPyo8nn5aMxI/srO
         Q3Vg+o3nw3JCg5JKnAUUAdtF+BO7V92gKb0UCx4N81OnVKVOuT/xHp6K15g7eoxMjsDF
         OFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkgSEeH9ULVrrmSUGnpLpQj8nOgggoVDNaLNK/5lGBA=;
        b=nRUYKrCBsizS+typ+Qyiysaf2a1zv03HwNavqeZBqw3e2wn1K7wS88L+MSbq5THbUu
         GsB4ylfUzL2HjTiTLG+421KAWCaTVnKeFqMEej04xns5s+kuZeH9zDaMXGBrTnG5nGLl
         NLvlX9nQdox3INVokKG3WFSz3NI/RQ5d4KUcbg6h1KGDWrvaLusNhMzpa1kWUctIrrKh
         vuPyam19sftkRlBwxz9R2h0ikH037gt9yhqjE0DsjwHMEDjdYBOkQlo89SJ5PbciEk/+
         UV4J1/DntKee7DAxuw14MHbOFvdHNZxfTtny++YKoGGNa17gdOQDcbS2OVT5G2YS0veW
         DXiA==
X-Gm-Message-State: AOAM5332+e0+TV3+Seb7LBmfdN9D2ReHCqZSeU1cMa0Hvebzn80XPaa0
        Ybgkjf5mcRglfKd4Au55DWeYus6QY0Z/8801kcg=
X-Google-Smtp-Source: ABdhPJzOzMgCPhkD1fc5F/ccY+PmH4iR89IYdGfJr8yWh84+SGX8Q4zVsikHb1vadW1iIa0C9l840w==
X-Received: by 2002:a05:6a00:1794:b029:2ee:c59c:56bf with SMTP id s20-20020a056a001794b02902eec59c56bfmr4798887pfg.2.1623769096969;
        Tue, 15 Jun 2021 07:58:16 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id u1sm16340120pgh.80.2021.06.15.07.58.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 07:58:16 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v6 2/3] submodule--helper: introduce add-clone subcommand
Date:   Tue, 15 Jun 2021 20:27:44 +0530
Message-Id: <20210615145745.33382-3-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210615145745.33382-1-raykar.ath@gmail.com>
References: <20210615093810.27930-1-raykar.ath@gmail.com>
 <20210615145745.33382-1-raykar.ath@gmail.com>
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
Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/submodule--helper.c | 177 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  38 +-------
 2 files changed, 178 insertions(+), 37 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ae246a35f9..6d52a73a57 100644
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

