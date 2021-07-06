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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7C4C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03AA361C6A
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhGFSW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhGFSW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 14:22:58 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E428C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 11:20:19 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f5so12880568pgv.3
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JWBu3ZpeaIwE3duBY54ohAOm8hB66HFxVlFgYTXWpaE=;
        b=U1C6/PUusSe7ClPmrDM5Z2rYzqtcPV/5+kbxwo+9KEz830Wa+Sr5UQhNXUSMldg6dj
         BQkYY1T4T1P9yVZwBwOWvuP34Bkf2zmSNq15fz5eeNX9ztqre8eOT5BP+5YTQkLBgYHM
         x9zYayA3/k4Oz+X1vBvfy23ClisRFSidh9k75S6KvKjxCMXeX/CvQFjn1yvvHPMVGqS+
         AnRU/IMD0TsMb68mwB989pB8HWhK97ell+xkDGbwagvP2FePvPkoIXGEN/GETs9T2ZuF
         nViNkvVuUSrpbvXdwyIPQkfXd+MB9vIx1ewJY6HYc9jA/b/reBESGA2tbyYIIyfQ8Ps7
         nrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JWBu3ZpeaIwE3duBY54ohAOm8hB66HFxVlFgYTXWpaE=;
        b=tDR0bZZAKddUyYSKg79lbdSwlAFx+BlndK0vDb3jTXNMhbby8JfBMLY9t2i6Xkp1Mi
         r08vmR8udVzoTxBhCIqT4F7JAkM2QuVWfBhI/k1hegRIRCnIg+x/yCQ60Im4CzVAb/3/
         TXI4ARlh5vl4tt+Hg7eT8O4VH/yP4kn13jkEhhfVeHGiHV72iJATeVmCSqYP24iMS12d
         GZck1Lcr9ZP+uin5g2krk1DPA4uhJeGYjO2N6wtqCNxHzxkzbO7Zx9oJRhxJYbM0fWYA
         c1yMZSpW60hbKXNLfbsQH8UUvYyDGRdkamIP5CmLYC1sB1rr/jjMR6gWjo6Wto4nQApd
         coaw==
X-Gm-Message-State: AOAM533vhAP1qEx5uYRwI2FsaRLiV3FAwBiqvWhHA3U+nZw4TNTjxLl7
        1B03rQs0lBSrI/cgcNF4AsXE68OV3UHqqYu4
X-Google-Smtp-Source: ABdhPJygvMBc96AEWpK9m1Xft8K2CmsiL2T3KHGu5Xxmx+Tnzh/HxSyGrFbCpfi1Jy5Ew54XCqwcVQ==
X-Received: by 2002:a62:8288:0:b029:31a:52f3:27e5 with SMTP id w130-20020a6282880000b029031a52f327e5mr18958455pfd.61.1625595619017;
        Tue, 06 Jul 2021 11:20:19 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b22sm3779809pje.1.2021.07.06.11.20.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jul 2021 11:20:18 -0700 (PDT)
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
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC] [PATCH 3/3] submodule--helper: introduce add-clone subcommand
Date:   Tue,  6 Jul 2021 23:49:36 +0530
Message-Id: <20210706181936.34087-4-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706181936.34087-1-raykar.ath@gmail.com>
References: <20210706181936.34087-1-raykar.ath@gmail.com>
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
'submodule add' unchanged.

The 'die' that is used in git-submodule.sh is not the same as the
'die()' in C--the latter prefixes with 'fatal:' and exits with an error
code of 128, while the shell die exits with code 1.

Introduce a custom die routine, that can be used by converted
subcommands to emulate the shell 'die'.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <shouryashukla.oo@gmail.com>
Based-on-patch-by: Shourya Shukla <shouryashukla.oo@gmail.com>
Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/submodule--helper.c | 187 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  38 +-------
 2 files changed, 188 insertions(+), 37 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 320f4252fe..1f2673139f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -30,6 +30,14 @@
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
 
+static NORETURN void submodule_die(const char *err, va_list params)
+{
+	vfprintf(stderr, err, params);
+	fputc('\n', stderr);
+	fflush(stderr);
+	exit(1);
+}
+
 static char *get_default_remote(void)
 {
 	char *dest = NULL, *ret;
@@ -2760,6 +2768,184 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
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
+	set_die_routine(submodule_die);
+
+	if (add_submodule(&add_data))
+		return 1;
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2772,6 +2958,7 @@ static struct cmd_struct commands[] = {
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
2.32.0

