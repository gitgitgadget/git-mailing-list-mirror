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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413A6C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 14:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190D361176
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 14:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhHFOFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 10:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhHFOFE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 10:05:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE4EC0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 07:04:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a8so16769077pjk.4
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0BOwiBSDf581yt3uZfRAPQfpAuBDbg7zogr2Jf/uIc=;
        b=Kce0PI5gObUogFpV3umDHTGCCFozt4QxtGNyIFs58ItEZp5Y2AKvaR1VXfkCsh5Qi0
         T+trYjMc4qwa47C1aJSAvjRC/1OwyKKP71WaMpO7uXHEZd3wa2XH3G+Qf7xGgqEHawTu
         FpCz6dDa7a1MM2CWKp85ahh3jtrqAveIPDeMnG3IdtMIdcN9YIcS9wfIsrbjRYOQABDv
         nhqZsBPTT4f577nH89HO5VulSx7LRES07LMk8FmEHNDV93PUaSz3vhjmPNYi4CdVVdYC
         26fAmdidVdjlA0II30PhzSHJ4kaDc/muUMyYNhaYhDs+97xzUYBnd+FX2H9qX5xURHyK
         7Obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0BOwiBSDf581yt3uZfRAPQfpAuBDbg7zogr2Jf/uIc=;
        b=ovDJICOf7S9UtAc0BoO6Cm6Pgh9/seMfowV6lMp6eIEVuQaX51dKopnCTIYk5fWT21
         Rj9ekzdpOP597iuvO6bEIt+HtOOZwuRkZrfpz368D5GDnl0ch378WLYFTK2n2kmCGKGr
         6pyDlwdgvbauaZhOl1IKJr4T85mBXAbkjQ7+2O9i/2SSMOCTuEFAGyJUvLT69yuebXnG
         HHV2DuLvOWw8GL7aay0uKUM3IjDXgbvG0WbJi40S7HCm8D2su8c0r1HJv5uLxc2K+6tC
         XGn93T8HqjzhmX7hucMoZjnjP6onxIJHHnQHjFZM8abyQuG/Uzcs89jGECzcvFz0+xst
         8YYg==
X-Gm-Message-State: AOAM531zwp9qsFzbkzi9tiRKK2K5ZkAAE06VmvjRRZzJHsBCOy9RJLjt
        kG5acHNgCl4WPNI40FolgoFjtdB7mA0QjNNf
X-Google-Smtp-Source: ABdhPJxPKHfANzSgP1LFqgLYGjWQApzUPembeNsqfACLE5u3QAA9KlFIh5Y2PG2RY3Wa/DVtTTxgOw==
X-Received: by 2002:a17:90a:c706:: with SMTP id o6mr20521923pjt.113.1628258688170;
        Fri, 06 Aug 2021 07:04:48 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id q68sm12689300pgq.5.2021.08.06.07.04.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 07:04:47 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Emily Shaffer" <emilyshaffer@google.com>,
        "Jonathan Nieder" <jrnieder@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Christian Couder" <christian.couder@gmail.com>,
        "Shourya Shukla" <periperidip@gmail.com>,
        "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Prathamesh Chavan" <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "Rafael Silva" <rafaeloliveira.cs@gmail.com>
Subject: [GSoC] [PATCH v4] submodule--helper: introduce add-config subcommand
Date:   Fri,  6 Aug 2021 19:34:31 +0530
Message-Id: <20210806140431.92018-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new "add-config" subcommand to `git submodule--helper` with the
goal of converting part of the shell code in git-submodule.sh related to
`git submodule add` into C code. This new subcommand sets the
configuration variables of a newly added submodule, by registering the
url in local git config, as well as the submodule name and path in the
.gitmodules file. It also sets 'submodule.<name>.active' to "true" if
the submodule path has not already been covered by any pathspec
specified in 'submodule.active'.

This is meant to be a faithful conversion from shell to C, although we
add comments to areas that could be improved in future patches, after
the conversion has settled.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Based-on-patch-by: Shourya Shukla <periperidip@gmail.com>
Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
---

Changes since v3:
Address style nit.

Range-diff against v3:
1:  be520ad028 ! 1:  b3df2a5e6c submodule--helper: introduce add-config subcommand
    @@ builtin/submodule--helper.c: static int add_clone(int argc, const char **argv, c
     +	    config_submodule_in_gitmodules(add_data->sm_name, "url", add_data->repo))
     +		die(_("Failed to register submodule '%s'"), add_data->sm_path);
     +
    -+	if (add_data->branch)
    ++	if (add_data->branch) {
     +		if (config_submodule_in_gitmodules(add_data->sm_name,
     +						   "branch", add_data->branch))
     +			die(_("Failed to register submodule '%s'"), add_data->sm_path);
    ++	}
     +
     +	add_gitmodules.git_cmd = 1;
     +	strvec_pushl(&add_gitmodules.args,

 builtin/submodule--helper.c | 129 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  28 +-------
 submodule.c                 |   5 ++
 3 files changed, 135 insertions(+), 27 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 862053c9f2..abf1ec2000 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2936,6 +2936,134 @@ static int add_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int config_submodule_in_gitmodules(const char *name, const char *var, const char *value)
+{
+	char *key;
+	int ret;
+
+	if (!is_writing_gitmodules_ok())
+		die(_("please make sure that the .gitmodules file is in the working tree"));
+
+	key = xstrfmt("submodule.%s.%s", name, var);
+	ret = config_set_in_gitmodules_file_gently(key, value);
+	free(key);
+
+	return ret;
+}
+
+static void configure_added_submodule(struct add_data *add_data)
+{
+	char *key;
+	char *val = NULL;
+	struct child_process add_submod = CHILD_PROCESS_INIT;
+	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
+
+	key = xstrfmt("submodule.%s.url", add_data->sm_name);
+	git_config_set_gently(key, add_data->realrepo);
+	free(key);
+
+	add_submod.git_cmd = 1;
+	strvec_pushl(&add_submod.args, "add",
+		     "--no-warn-embedded-repo", NULL);
+	if (add_data->force)
+		strvec_push(&add_submod.args, "--force");
+	strvec_pushl(&add_submod.args, "--", add_data->sm_path, NULL);
+
+	if (run_command(&add_submod))
+		die(_("Failed to add submodule '%s'"), add_data->sm_path);
+
+	if (config_submodule_in_gitmodules(add_data->sm_name, "path", add_data->sm_path) ||
+	    config_submodule_in_gitmodules(add_data->sm_name, "url", add_data->repo))
+		die(_("Failed to register submodule '%s'"), add_data->sm_path);
+
+	if (add_data->branch) {
+		if (config_submodule_in_gitmodules(add_data->sm_name,
+						   "branch", add_data->branch))
+			die(_("Failed to register submodule '%s'"), add_data->sm_path);
+	}
+
+	add_gitmodules.git_cmd = 1;
+	strvec_pushl(&add_gitmodules.args,
+		     "add", "--force", "--", ".gitmodules", NULL);
+
+	if (run_command(&add_gitmodules))
+		die(_("Failed to register submodule '%s'"), add_data->sm_path);
+
+	/*
+	 * NEEDSWORK: In a multi-working-tree world this needs to be
+	 * set in the per-worktree config.
+	 */
+	/*
+	 * NEEDSWORK: In the longer run, we need to get rid of this
+	 * pattern of querying "submodule.active" before calling
+	 * is_submodule_active(), since that function needs to find
+	 * out the value of "submodule.active" again anyway.
+	 */
+	if (!git_config_get_string("submodule.active", &val) && val) {
+		/*
+		 * If the submodule being added isn't already covered by the
+		 * current configured pathspec, set the submodule's active flag
+		 */
+		if (!is_submodule_active(the_repository, add_data->sm_path)) {
+			key = xstrfmt("submodule.%s.active", add_data->sm_name);
+			git_config_set_gently(key, "true");
+			free(key);
+		}
+	} else {
+		key = xstrfmt("submodule.%s.active", add_data->sm_name);
+		git_config_set_gently(key, "true");
+		free(key);
+	}
+}
+
+static int add_config(int argc, const char **argv, const char *prefix)
+{
+	int force = 0;
+	struct add_data add_data = ADD_DATA_INIT;
+
+	struct option options[] = {
+		OPT_STRING('b', "branch", &add_data.branch,
+			   N_("branch"),
+			   N_("branch of repository to store in "
+			      "the submodule configuration")),
+		OPT_STRING(0, "url", &add_data.repo,
+			   N_("string"),
+			   N_("url to clone submodule from")),
+		OPT_STRING(0, "resolved-url", &add_data.realrepo,
+			   N_("string"),
+			   N_("url to clone the submodule from, after it has "
+			      "been dereferenced relative to parent's url, "
+			      "in the case where <url> is a relative url")),
+		OPT_STRING(0, "path", &add_data.sm_path,
+			   N_("path"),
+			   N_("where the new submodule will be cloned to")),
+		OPT_STRING(0, "name", &add_data.sm_name,
+			   N_("string"),
+			   N_("name of the new submodule")),
+		OPT__FORCE(&force, N_("allow adding an otherwise ignored submodule path"),
+			   PARSE_OPT_NOCOMPLETE),
+		OPT_END()
+	};
+
+	const char *const usage[] = {
+		N_("git submodule--helper add-config "
+		   "[--force|-f] [--branch|-b <branch>] "
+		   "--url <url> --resolved-url <resolved-url> "
+		   "--path <path> --name <name>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	if (argc)
+		usage_with_options(usage, options);
+
+	add_data.force = !!force;
+	configure_added_submodule(&add_data);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2949,6 +3077,7 @@ static struct cmd_struct commands[] = {
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
 	{"add-clone", add_clone, 0},
+	{"add-config", add_config, 0},
 	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 053daf3724..f713cb113c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -242,33 +242,7 @@ cmd_add()
 	fi
 
 	git submodule--helper add-clone ${GIT_QUIET:+--quiet} ${force:+"--force"} ${progress:+"--progress"} ${branch:+--branch "$branch"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
-	git config submodule."$sm_name".url "$realrepo"
-
-	git add --no-warn-embedded-repo $force "$sm_path" ||
-	die "fatal: $(eval_gettext "Failed to add submodule '\$sm_path'")"
-
-	git submodule--helper config submodule."$sm_name".path "$sm_path" &&
-	git submodule--helper config submodule."$sm_name".url "$repo" &&
-	if test -n "$branch"
-	then
-		git submodule--helper config submodule."$sm_name".branch "$branch"
-	fi &&
-	git add --force .gitmodules ||
-	die "fatal: $(eval_gettext "Failed to register submodule '\$sm_path'")"
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
+	git submodule--helper add-config ${force:+--force} ${branch:+--branch "$branch"} --url "$repo" --resolved-url "$realrepo" --path "$sm_path" --name "$sm_name"
 }
 
 #
diff --git a/submodule.c b/submodule.c
index 0b1d9c1dde..8577667773 100644
--- a/submodule.c
+++ b/submodule.c
@@ -237,6 +237,11 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 /*
  * Determine if a submodule has been initialized at a given 'path'
  */
+/*
+ * NEEDSWORK: Emit a warning if submodule.active exists, but is valueless,
+ * ie, the config looks like: "[submodule] active\n".
+ * Since that is an invalid pathspec, we should inform the user.
+ */
 int is_submodule_active(struct repository *repo, const char *path)
 {
 	int ret = 0;
-- 
2.32.0

