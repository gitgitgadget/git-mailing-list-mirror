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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F8BC63797
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 11:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E1661222
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 11:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhGVKlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 06:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhGVKlo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 06:41:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74824C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 04:22:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x13-20020a17090a46cdb0290175cf22899cso5022773pjg.2
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 04:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xIRjgORZdeUc/CD+ZdLMSH/nL0C+tCKqjIOB3RPskRM=;
        b=XBEmrsjs4/nhrNEHAQhez3121iBvjrLjGGLCmrm5FwJrJYVPogF3+dAAvIQ9UjgXKd
         QjvQIVzcZrkERHISZC4TyaR1nUv9MeMlTpdgwLbFVXRj0naWTe2Ojt3ycH4T/goE/hM8
         CIbYUGzL+XnfIxF+IvgispcWE14qwvZRn7H76ZdpTOxvwYJkj2PoqxkG8n0a156Qz5bQ
         ajQ2tR+X03+fHzjGtzV3/8PSWpI1ePZTXEpnBtKIwcdYQYTagukWmKYwZj521RCbMmKk
         jIuoQBSX4onlZeBfxn4D8TWv8pWX0f37pm3Nru8EDy5WXvHu/qSZW59ryZjfbbujJ9dX
         RdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xIRjgORZdeUc/CD+ZdLMSH/nL0C+tCKqjIOB3RPskRM=;
        b=jzc6v3X1a+WbjD9Tn/iJnzl2EIwlEWLSVb0JZyf3jcTrv79iWN0G2pZVROY6JPq1xt
         fjg8o7lkhQz5hvXq+AgYIuf4bZtxkxYdNd44HsLF+A+amt5/ZkaFbRj8G80YnnsaRrLV
         FebkeJBexRji3B1yqQjF/73CbSkFulnQcQ/ezWgJMpzyVaRWcRvUHXSD/Pph2Q7bCoUu
         CCaK4F3UsHK39eFkCWDXRqEt+SK/R+FOdIdVUJw97RkUWOLX5a2bH8wlOOX4g/OhsejA
         BMis6WuaI4PNGqvCh5Opl81jnCtOftAyxs0evSQtZ0VMiHa0ZPiop8idfZMA2rKEpvKT
         FFFg==
X-Gm-Message-State: AOAM531TAnUsYbDY0RyBNsWMHjPQsnJTy9c7HRXnOVjWTD16oCX1xNCh
        9z11StDiDPPNdtzgHYvZwIvlXftXNXnkMJSJ
X-Google-Smtp-Source: ABdhPJyWdroiMDoGsZfo01Gqyh0nm4hg30ZKi8loxLudYBYGXuWetFMRNyCncInl40YJoHF1cc2Eew==
X-Received: by 2002:a17:90a:708c:: with SMTP id g12mr8630448pjk.13.1626952937627;
        Thu, 22 Jul 2021 04:22:17 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id g27sm33077347pgl.19.2021.07.22.04.22.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jul 2021 04:22:17 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        "Emily Shaffer" <emilyshaffer@google.com>,
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
Subject: [GSoC] [PATCH] submodule--helper: introduce add-config subcommand
Date:   Thu, 22 Jul 2021 16:51:43 +0530
Message-Id: <20210722112143.97944-1-raykar.ath@gmail.com>
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

This is meant to be a faithful conversion from shell to C, with only one
minor change: A warning is emitted if no value is specified in
'submodule.active', ie, the config looks like: "[submodule] active\n",
because it is an invalid configuration. It would be helpful to let the
user know that the pathspec is unset, and the value of
'submodule.<name>.active' might be set to 'true' so that they can
rectify their configuration and prevent future surprises (especially
given that the latter variable has a higher priority than the former).

The structure of the conditional to check if we need to set the 'active'
toggle looks different from the shell version -- but behaves the same.
The change was made to decrease code duplication. A comment has been
added to explain that only one value of 'submodule.active' is obtained
to check if we need to call is_submodule_active() at all.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Based-on-patch-by: Shourya Shukla <periperidip@gmail.com>
Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
---

This patch depends on changes introduced in 83913dd5b6 (t7400: test failure to
add submodule in tracked path, 2021-06-18), which belongs to the
ar/submodule-add (2021-07-12) series[1].

This changes in this patch are no different from the one in my first
submodule-add conversion series[2] which has already got some reviews before.

[1] https://lore.kernel.org/git/20210710074801.19917-1-raykar.ath@gmail.com/
[2] https://lore.kernel.org/git/20210615145745.33382-4-raykar.ath@gmail.com/

 builtin/submodule--helper.c | 125 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  28 +-------
 2 files changed, 126 insertions(+), 27 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 862053c9f2..9658804d24 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2936,6 +2936,130 @@ static int add_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static void config_submodule_in_gitmodules(const char *name, const char *var, const char *value)
+{
+	char *key;
+
+	if (!is_writing_gitmodules_ok())
+		die(_("please make sure that the .gitmodules file is in the working tree"));
+
+	key = xstrfmt("submodule.%s.%s", name, var);
+	config_set_in_gitmodules_file_gently(key, value);
+	free(key);
+}
+
+static void configure_added_submodule(struct add_data *add_data)
+{
+	char *key, *submod_pathspec = NULL;
+	struct child_process add_submod = CHILD_PROCESS_INIT;
+	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
+	int pathspec_key_exists, activate = 0;
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
+	config_submodule_in_gitmodules(add_data->sm_name, "path", add_data->sm_path);
+	config_submodule_in_gitmodules(add_data->sm_name, "url", add_data->repo);
+	if (add_data->branch)
+		config_submodule_in_gitmodules(add_data->sm_name,
+					       "branch", add_data->branch);
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
+	pathspec_key_exists = !git_config_get_string("submodule.active",
+						     &submod_pathspec);
+	if (pathspec_key_exists && !submod_pathspec) {
+		warning(_("The submodule.active configuration exists, but the "
+			  "pathspec was unset. If the submodule is not already "
+			  "active, the value of submodule.%s.active will be "
+			  "be set to 'true'."), add_data->sm_name);
+		activate = 1;
+	}
+
+	/*
+	 * If submodule.active does not exist, or if the pathspec was unset,
+	 * we will activate this module unconditionally.
+	 *
+	 * Otherwise, we ask is_submodule_active(), which iterates
+	 * through all the values of 'submodule.active' to determine
+	 * if this module is already active.
+	 */
+	if (!pathspec_key_exists || activate ||
+	    !is_submodule_active(the_repository, add_data->sm_path)) {
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
+	if (argc != 0)
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
@@ -2949,6 +3073,7 @@ static struct cmd_struct commands[] = {
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
-- 
2.32.0

