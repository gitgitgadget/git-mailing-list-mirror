Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0FAC433FE
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 21:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhL1Vcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhL1Vc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 16:32:29 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6FAC06173E
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:32:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w20so31601699wra.9
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8Fqdt3bzApNIyi9ioy/h/ZUnaMcda3XAOsr7OAE4fPQ=;
        b=OWAN5rlpZa7zOKqy77q66Mne14nYMitBHIOT3fVP2b+12jMiZ5hs2BAkoniB9SDyoK
         tXix9ATTMNca5GXVNtSLX06a2t1oaAG9+y3WUlPVjf9aTO7x44jvp/s0iEtW3G2HYwR4
         sFBlid5hcY/cqJIxzLmptMjtQWl4lLqLQ22WqONpoTSBv9QNeDLGcdU7cGApR5EaRPjS
         tEK+lPsGbentFkEjQ8d8k11S+qj6NcQ3MUBdDZpMgLv57ogBZt0gYBzsF4yXPVn2nU9C
         Ssn+vCa3SLlWJDydSZUX9k4/syePf2PU6bO5mjnXoPRAriJAbWEgrVPM4r+eJLFoTmnY
         wYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8Fqdt3bzApNIyi9ioy/h/ZUnaMcda3XAOsr7OAE4fPQ=;
        b=0onzj2dGATLMiIAOF15XWeMnF8S8NNLlFkBlYVoQ963QP/kNlp8vbnGvpjOYUsxWe2
         p4+Imtyixyv4Oc5OUMg1BqeDofEcGt4dAEfpbhdUAixG6NMj7uGrE9HcRiv0xFC1+xJZ
         RQJvsDDzv2ls8mUo/22eYsonvJ8IBIU4bi7MD5Af8ygql5dAkFkFjjw2aDl/BJvbDk3b
         H639FmoSw7V4rPqxXkphRTnnW22EB2HBlQ+H3OxO5NqMewK93TU4/MS/G/4LVDcda8VZ
         PR8PhdlOcbwOI7WtKb0xEDmsXrb6nBeZ6wY6TOpd3RGtjsOppO5VO2z1d0TOV51Yf48B
         Ke8g==
X-Gm-Message-State: AOAM5324Kfu+VzeSH+4k1tWBZrkAlPXMTORPLkpQ7/M3SbqCgdHuYeoZ
        cMeomgfFjc/gz9u2PlHuvkVQ1FI9M2I=
X-Google-Smtp-Source: ABdhPJzbn0GpaJ5CRnN5zyAL584nGkLcTARv5dl2OQJYOqsa13bbwXik67RtKe6qg4it/4vx/9xz8g==
X-Received: by 2002:a5d:4489:: with SMTP id j9mr18291404wrq.544.1640727147155;
        Tue, 28 Dec 2021 13:32:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm11011732wrb.13.2021.12.28.13.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:32:26 -0800 (PST)
Message-Id: <e2a0a458115a26cfb855f7040f15e5198072b3a5.1640727143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
        <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 21:32:20 +0000
Subject: [PATCH v3 3/6] worktree: add 'init-worktree-config' subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Some features, such as the sparse-checkout builtin, currently use the
worktree config extension. It might seem simple to upgrade the
repository format and add extensions.worktreeConfig, which is what
happens in the sparse-checkout builtin. However, this is overly
simplistic and can cause issues in some cases. We will transition away
from making this upgrade automatically, but first we will make an easy
way for users to upgrade their repositories correctly.

Transitioning from one config file to multiple has some strange
side-effects. In particular, if the base repository is bare and the
worktree is not, Git knows to treat the worktree as non-bare as a
special case when not using worktree config. Once worktree config is
enabled, Git stops that special case since the core.bare setting could
apply at the worktree config level.

Similarly, the core.worktree config setting is a precursor to the 'git
worktree' feature, allowing config to point to a different worktree,
presumably temporarily. This is special-cased to be ignored in a
worktree, but that case is dropped when worktree config is enabled.

To help resolve this transition, create the 'git worktree
init-worktree-config' helper. This new subcommand does the following:

 1. Set core.repositoryFormatVersion to 1 in the common config file.
 2. Set extensions.worktreeConfig to true in the common config file.
 3. If core.bare is true in the common config file, then move that
    setting to the main worktree's config file.
 4. Move the core.worktree config value to the main worktree's config
    file.

If the repository is already configured to use worktree config, then
none of these steps happen. This preserves any state that the user might
have created on purpose.

Update the documentation to mention this subcommand as the proper way to
upgrade to worktree config files.

To gain access to the core repository's config and config.worktree file,
we reference a repository struct's 'commondir' member. If the repository
was a submodule instead of a worktree, then this still applies
correctly.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-worktree.txt           | 22 +++++--
 builtin/worktree.c                       | 82 ++++++++++++++++++++++++
 t/t2407-worktree-init-worktree-config.sh | 68 ++++++++++++++++++++
 3 files changed, 167 insertions(+), 5 deletions(-)
 create mode 100755 t/t2407-worktree-init-worktree-config.sh

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 9e862fbcf79..0f0642ac039 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]] [-b <new-branch>] <path> [<commit-ish>]
+'git worktree init-worktree-config'
 'git worktree list' [-v | --porcelain]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
@@ -92,6 +93,14 @@ checked out in the new working tree, if it's not checked out anywhere
 else, otherwise the command will refuse to create the working tree (unless
 `--force` is used).
 
+init-worktree-config::
+
+Initialize config settings to enable worktree-specific config settings.
+This will set `core.repositoryFormatversion=1` and enable
+`extensions.worktreeConfig`, which might cause some third-party tools from
+being able to operate on your repository. See CONFIGURATION FILE for more
+details.
+
 list::
 
 List details of each working tree.  The main working tree is listed first,
@@ -290,10 +299,10 @@ already present in the config file, they will be applied to the main
 working trees only.
 
 In order to have configuration specific to working trees, you can turn
-on the `worktreeConfig` extension, e.g.:
+on the `worktreeConfig` extension, using this command:
 
 ------------
-$ git config extensions.worktreeConfig true
+$ git worktree init-worktree-config
 ------------
 
 In this mode, specific configuration stays in the path pointed by `git
@@ -303,9 +312,12 @@ versions will refuse to access repositories with this extension.
 
 Note that in this file, the exception for `core.bare` and `core.worktree`
 is gone. If they exist in `$GIT_DIR/config`, you must move
-them to the `config.worktree` of the main working tree. You may also
-take this opportunity to review and move other configuration that you
-do not want to share to all working trees:
+them to the `config.worktree` of the main working tree. These keys are
+moved automatically when you use the `git worktree init-worktree-config`
+command.
+
+You may also take this opportunity to review and move other configuration
+that you do not want to share to all working trees:
 
  - `core.worktree` and `core.bare` should never be shared
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index a57fcd0f3c5..937ee6fc38b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -17,6 +17,7 @@
 
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> [<commit-ish>]"),
+	N_("git worktree init-worktree-config"),
 	N_("git worktree list [<options>]"),
 	N_("git worktree lock [<options>] <path>"),
 	N_("git worktree move <worktree> <new-path>"),
@@ -1031,6 +1032,85 @@ static int repair(int ac, const char **av, const char *prefix)
 	return rc;
 }
 
+static int move_config_setting(const char *key, const char *value,
+			       const char *from_file, const char *to_file)
+{
+	if (git_config_set_in_file_gently(to_file, key, value))
+		return error(_("unable to set %s in '%s'"), key, to_file);
+	if (git_config_set_in_file_gently(from_file, key, NULL))
+		return error(_("unable to unset %s in '%s'"), key, from_file);
+	return 0;
+}
+
+static int init_worktree_config(int ac, const char **av, const char *prefix)
+{
+	struct repository *r = the_repository;
+	struct option options[] = {
+		OPT_END()
+	};
+	int res = 0;
+	int bare = 0;
+	struct config_set cs = { 0 };
+	const char *core_worktree;
+	char *common_config_file = xstrfmt("%s/config", r->commondir);
+	char *main_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
+
+	/* Report error on any arguments */
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac)
+		usage_with_options(worktree_usage, options);
+
+	git_configset_init(&cs);
+	git_configset_add_file(&cs, common_config_file);
+
+	/*
+	 * If the format and extension are already enabled, then we can
+	 * skip the upgrade process.
+	 */
+	if (repository_format_worktree_config)
+		return 0;
+
+	if (upgrade_repository_format(r, 1) < 0) {
+		res = error(_("unable to upgrade repository format to enable worktreeConfig"));
+		goto cleanup;
+	}
+	if ((res = git_config_set_gently("extensions.worktreeConfig", "true"))) {
+		error(_("failed to set extensions.worktreeConfig setting"));
+		goto cleanup;
+	}
+
+	/*
+	 * If core.bare is true in the common config file, then we need to
+	 * move it to the base worktree's config file or it will break all
+	 * worktrees. If it is false, then leave it in place because it
+	 * _could_ be negating a global core.bare=true.
+	 */
+	if (!git_configset_get_bool(&cs, "core.bare", &bare) && bare) {
+		if ((res = move_config_setting("core.bare", "true",
+					       common_config_file,
+					       main_worktree_file)))
+			goto cleanup;
+	}
+	/*
+	 * If core.worktree is set, then the base worktree is located
+	 * somewhere different than the parent of the common Git dir.
+	 * Relocate that value to avoid breaking all worktrees with this
+	 * upgrade to worktree config.
+	 */
+	if (!git_configset_get_string_tmp(&cs, "core.worktree", &core_worktree)) {
+		if ((res = move_config_setting("core.worktree", core_worktree,
+					       common_config_file,
+					       main_worktree_file)))
+			goto cleanup;
+	}
+
+cleanup:
+	git_configset_clear(&cs);
+	free(common_config_file);
+	free(main_worktree_file);
+	return res;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -1045,6 +1125,8 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		prefix = "";
 	if (!strcmp(av[1], "add"))
 		return add(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "init-worktree-config"))
+		return init_worktree_config(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
 		return prune(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "list"))
diff --git a/t/t2407-worktree-init-worktree-config.sh b/t/t2407-worktree-init-worktree-config.sh
new file mode 100755
index 00000000000..b3bd0fa1322
--- /dev/null
+++ b/t/t2407-worktree-init-worktree-config.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+test_description='test git worktree init-worktree-config'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git init base &&
+	test_commit -C base commit &&
+	git -C base worktree add --detach worktree
+'
+
+reset_config_when_finished () {
+	test_when_finished git -C base config --unset core.repositoryFormatVersion &&
+	test_when_finished git -C base config --unset extensions.worktreeConfig &&
+	rm -rf base/.git/config.worktree &&
+	rm -rf base/.git/worktrees/worktree/config.worktree
+}
+
+test_expect_success 'upgrades repo format and adds extension' '
+	reset_config_when_finished &&
+	git -C base worktree init-worktree-config >out 2>err &&
+	test_must_be_empty out &&
+	test_must_be_empty err &&
+	test_cmp_config -C base 1 core.repositoryFormatVersion &&
+	test_cmp_config -C base true extensions.worktreeConfig
+'
+
+test_expect_success 'relocates core.worktree' '
+	reset_config_when_finished &&
+	mkdir dir &&
+	git -C base config core.worktree ../../dir &&
+	git -C base worktree init-worktree-config >out 2>err &&
+	test_must_be_empty out &&
+	test_must_be_empty err &&
+	test_cmp_config -C base 1 core.repositoryFormatVersion &&
+	test_cmp_config -C base true extensions.worktreeConfig &&
+	test_cmp_config -C base ../../dir core.worktree &&
+	test_must_fail git -C worktree core.worktree
+'
+
+test_expect_success 'relocates core.bare' '
+	reset_config_when_finished &&
+	git -C base config core.bare true &&
+	git -C base worktree init-worktree-config >out 2>err &&
+	test_must_be_empty out &&
+	test_must_be_empty err &&
+	test_cmp_config -C base 1 core.repositoryFormatVersion &&
+	test_cmp_config -C base true extensions.worktreeConfig &&
+	test_cmp_config -C base true core.bare &&
+	test_must_fail git -C worktree core.bare
+'
+
+test_expect_success 'skips upgrade is already upgraded' '
+	reset_config_when_finished &&
+	git -C base worktree init-worktree-config &&
+	git -C base config core.bare true &&
+
+	# this should be a no-op, even though core.bare
+	# makes the worktree be broken.
+	git -C base worktree init-worktree-config >out 2>err &&
+	test_must_be_empty out &&
+	test_must_be_empty err &&
+	test_must_fail git -C base config --worktree core.bare &&
+	git -C base config core.bare
+'
+
+test_done
-- 
gitgitgadget

