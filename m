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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70904C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 08:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB75613C0
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 08:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhFJIoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 04:44:08 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:33617 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhFJIoF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 04:44:05 -0400
Received: by mail-pl1-f174.google.com with SMTP id c13so635943plz.0
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xjx01ttK1NDy+9icxqCpHVR/6FFBUzUptRuMOYwwl/w=;
        b=som3cM90tS9RUGAXdpiY+o8HOZgAGXVDOlgT3ag5LlJ3LNzdFPM+HJ8KiQ76tNs7Oj
         PotwsQpQcubWTOVkcxBywWcr0MeVut1dAxofb2nYQ7n/im27ul4IMQEUAtEGwwF3Yrcm
         YEttTdYtBrD4aKlL9tpyOBPRkayjFfi6HhmBHBZJc7bPHzzdm4QyTXZnHert4kmRl5G7
         QzZiTiu8V90k7OO2TivxQKhFSWkdE00VXZZgo1RHEjN3j0sAmYmaSoBalvYsGLptYM03
         jVEN+2j7JwbZkcob9Rq12KBig2Z6obLSAw63jaPsvt3kqVohDj6BYS74m3b2CMVq7mLv
         u5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xjx01ttK1NDy+9icxqCpHVR/6FFBUzUptRuMOYwwl/w=;
        b=oQcItfRLLpDfyPevJ2XZvvIBogDEGzktSaTJcpe35d2CeF4bJX+W3Ag2fr35gOPMop
         TPRR52AcgDAAC7Q8ZRE4/wjGe2MmQRwVYoiq4yTjgjMRn5y3KzYdGiLM3asC1NRy63T2
         2aOPvdVKBpYHqHXuMY/r++yQRTJYbLtN4Ux/TlxsVwzfH2o9GnB0wV83wFpVw39Fjmhy
         EY1lPeTNgtu1rWs+JHJxAMlPQPgnorDl0Zy2VzdAAtz97z+a/X2/mrEakHw9NvmFkNaH
         9dJETvFO36XrtMNBmEP0d6dDO0jl8yKAPn4VtyB/WLyBXxnyWM3V3//CupZ0OaMWam/m
         SGvA==
X-Gm-Message-State: AOAM531GCoNyxBBXFp5iGjdWPToedCZ9ViIfYxZqQv6ufIiWYsr+GIBX
        YheQnoyhQFtpBcIPHSnh5LpiZcFAFFYSCUkKNIg=
X-Google-Smtp-Source: ABdhPJwDk6tDtLMwOfRnaaEPgkb7iqHfD8zQkk2lDwOvdiQER/dYa/WqosGB7GhmvbZiz/K5zQxDMQ==
X-Received: by 2002:a17:90a:560b:: with SMTP id r11mr2253926pjf.224.1623314468499;
        Thu, 10 Jun 2021 01:41:08 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id u68sm1802423pfb.64.2021.06.10.01.41.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 01:41:08 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v3 2/2] submodule--helper: introduce add-config subcommand
Date:   Thu, 10 Jun 2021 14:09:16 +0530
Message-Id: <20210610083916.96243-3-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610083916.96243-1-raykar.ath@gmail.com>
References: <20210608095655.47324-1-raykar.ath@gmail.com>
 <20210610083916.96243-1-raykar.ath@gmail.com>
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

This is part of a series of changes that will result in all of
'submodule add' being converted to C.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <shouryashukla.oo@gmail.com>
Based-on-patch-by: Shourya Shukla <shouryashukla.oo@gmail.com>
Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 119 ++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  28 +--------
 2 files changed, 120 insertions(+), 27 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 21b2e9fb14..a50276138b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2924,6 +2924,124 @@ static int add_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
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
+	key = xstrfmt("submodule.%s.path", add_data->sm_name);
+	config_set_in_gitmodules_file_gently(key, add_data->sm_path);
+	free(key);
+	key = xstrfmt("submodule.%s.url", add_data->sm_name);
+	config_set_in_gitmodules_file_gently(key, add_data->repo);
+	free(key);
+	if (add_data->branch) {
+		key = xstrfmt("submodule.%s.branch", add_data->sm_path);
+		config_set_in_gitmodules_file_gently(key, add_data->branch);
+		free(key);
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
@@ -2937,6 +3055,7 @@ static struct cmd_struct commands[] = {
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
 	{"add-clone", add_clone, 0},
+	{"add-config", add_config, 0},
 	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index f71e1e5495..9826378fa6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -242,33 +242,7 @@ cmd_add()
 	fi
 
 	git submodule--helper add-clone ${GIT_QUIET:+--quiet} ${force:+"--force"} ${progress:+"--progress"} ${branch:+--branch "$branch"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
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
+	git submodule--helper add-config ${force:+--force} ${branch:+--branch "$branch"} --url "$repo" --resolved-url "$realrepo" --path "$sm_path" --name "$sm_name"
 }
 
 #
-- 
2.31.1

