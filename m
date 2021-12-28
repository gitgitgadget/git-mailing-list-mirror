Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91052C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 21:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhL1Vc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhL1Vc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 16:32:27 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F88BC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:32:27 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so13415371wmj.5
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5m31uMIWlwefWp98blI3qmErPNDLg1lIzSxl/PDeFEs=;
        b=OOHoLqkhrW3aE61VP7kvjy7GbVTNOaVAQddG5nR66CoTP+zAsJK7dkDj34hCTc7MWA
         kaP/TdhsbM0vfHx8v3KJezdj5fJLx3QrPq9WTdhiWBP31rftuG2ieyBJ5w0hChduBm8Q
         CQhLxzw6n0ZbAIX6SsVjESFqY22V5Ju1Dk0ZL0vXT8B2qeW4flpnyDLocI4/baWIy63y
         TQkgHQ1sjH4z+IS+XyTPnHUXTRJuo8hxM0XumD+HRiFZUq84Wl0DVOT5QeMFzbzGaI42
         07T50QdfpxYOzidxN6BVVfY/NfD/hTZ0gsVG/H0GkWTPhnSyQvTVTaxL8XFNvGzN6Qgf
         9BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5m31uMIWlwefWp98blI3qmErPNDLg1lIzSxl/PDeFEs=;
        b=ZNfHC9AlsPV41UNCaJ0PLhehkp4foMZ0Gf0c1EcQIWLmVH7Q+yEJXqtXGdF86rMNF9
         J2FTOfTswMNq6gcRgoumdFb9hBySWVe4fnKJaU2MtQBTjP52ax7tV0Ie3IE3YXlxTaXg
         4d0RYYxNtZmhVo2RGkpETzZ+u/WxVo9E7PmNQj23ho5qALE30vHe/heFNaxPE04n/OVH
         Sg/0jeaWP+qX0ByqPPueq8z3XKnqv1bupvvEWoGamkk4yTctcgAUdvpyDfhtQNE7M2kc
         W1GhVM7V93A2P0Bky+iHQOCarPFv/4D47JdBcqEBthnsJd8fKde9gSiZH0DK38Rr/xfu
         VLlQ==
X-Gm-Message-State: AOAM532OIwYnETNuLhtR6MS+7V2eUuTJJermgR0GAYHKn1ajJcHty/3H
        nc0RQ3F/7NxSuNPwC3DlHg7wL9Bvv5M=
X-Google-Smtp-Source: ABdhPJwOhUwYfNS87x7YBDay89jkYYWg5FGp4FQctuxKqxdSx8SdwwIRl8cgUBl2yh7GYJKxb5QO0g==
X-Received: by 2002:a1c:9856:: with SMTP id a83mr18944088wme.157.1640727145098;
        Tue, 28 Dec 2021 13:32:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5sm19020915wml.48.2021.12.28.13.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:32:24 -0800 (PST)
Message-Id: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 21:32:17 +0000
Subject: [PATCH v3 0/6] Sparse checkout: fix bug with worktree of bare repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on a merge of en/sparse-checkout-set,
en/worktree-chatty-to-stderr, and ds/sparse-checkout-malformed-pattern-fix.

This patch series includes a fix to the bug reported by Sean Allred [1] and
diagnosed by Eric Sunshine [2].

The root cause is that 'git sparse-checkout init' writes to the worktree
config without checking that core.bare might need to be set. This only
matters when the base repository is bare, since creating the config.worktree
file and enabling extensions.worktreeConfig will cause Git to treat the base
repo's core.bare=false as important for this worktree.

This series fixes this, but also puts in place some helpers to prevent this
from happening in the future. While here, some of the config paths are
modified to take a repository struct.

 * 'git sparse-checkout' will now modify the worktree config, if enabled. It
   will no longer auto-upgrade users into using worktree config.

 * The new 'git worktree init-worktree-config' will upgrade users to using
   worktree config. It will relocate core.bare and core.worktree if
   necessary.

 * 'git worktree add' will copy the sparse-checkout patterns from the
   current worktree to the new one. If worktree config is enabled, then the
   config settings from the current worktree are copied to the new
   worktree's config file.


Updates in v3
=============

 * This is now rebased onto a merge of:
   
   * en/sparse-checkout-set (for dependence on 'git sparse-checkout set
     --cone'),
   * en/worktree-chatty-to-stderr (for an adjacent change in
     Documentation/git-worktree.txt), and
   * ds/sparse-checkout-malformed-pattern-fix (since it needed a fixup! with
     the --worktree option in a test)

 * The strategy is changed significantly: we simultaneously stop
   auto-upgrading to worktree config in 'git sparse-checkout set' while also
   providing a clear way for users to self-upgrade in 'git worktree
   init-worktree-config'. This upgrade moves core.bare and core.worktree, if
   they exist, and does not do anything if worktree config is already
   enabled.

 * The sparse-checkout builtin will write to the worktree config, if it is
   enabled. The helper it uses now will fallback to the common config file
   if worktree config is not enabled.

 * The 'git worktree add' command is updated to copy the sparse-checkout
   patterns and config from the current worktree into the new one.

[1]
https://lore.kernel.org/git/CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com/
[2]
https://lore.kernel.org/git/CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com/


Update in v2
============

 * Eric correctly pointed out that I was writing core.bare incorrectly. It
   should move out of the core config and into the core repository's
   worktree config.
 * Patch 3 is new, separating the "upgrade" logic out of config.c, but it is
   still called by the config helper to make it painless to write worktree
   config.

Thanks, -Stolee

Derrick Stolee (6):
  setup: use a repository when upgrading format
  config: make some helpers repo-aware
  worktree: add 'init-worktree-config' subcommand
  config: add repo_config_set_worktree_gently()
  sparse-checkout: use repo_config_set_worktree_gently()
  worktree: copy sparse-checkout patterns and config on add

 Documentation/git-worktree.txt           |  22 +++-
 builtin/sparse-checkout.c                |  25 ++---
 builtin/worktree.c                       | 123 +++++++++++++++++++++++
 config.c                                 |  50 ++++++++-
 config.h                                 |  15 +++
 list-objects-filter-options.c            |   2 +-
 repository.h                             |   2 +-
 setup.c                                  |   6 +-
 sparse-index.c                           |  10 +-
 t/t1091-sparse-checkout-builtin.sh       | 110 ++++++++++++++++++--
 t/t2407-worktree-init-worktree-config.sh |  68 +++++++++++++
 11 files changed, 385 insertions(+), 48 deletions(-)
 create mode 100755 t/t2407-worktree-init-worktree-config.sh


base-commit: 998dc12e841b4b17dd5a4700bb443fa215505e3d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1101%2Fderrickstolee%2Fsparse-checkout%2Fbare-worktree-bug-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1101/derrickstolee/sparse-checkout/bare-worktree-bug-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1101

Range-diff vs v2:

 1:  889e69dc45d = 1:  749ba67d21e setup: use a repository when upgrading format
 2:  3e01356815a = 2:  61b96937016 config: make some helpers repo-aware
 3:  ed8e2a7b19d ! 3:  e2a0a458115 worktree: add upgrade_to_worktree_config()
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    worktree: add upgrade_to_worktree_config()
     +    worktree: add 'init-worktree-config' subcommand
      
     -    Some features, such as the sparse-checkout builtin, require using the
     +    Some features, such as the sparse-checkout builtin, currently use the
          worktree config extension. It might seem simple to upgrade the
     -    repository format and add extensions.worktreeConfig, and that is what
     -    happens in the sparse-checkout builtin.
     +    repository format and add extensions.worktreeConfig, which is what
     +    happens in the sparse-checkout builtin. However, this is overly
     +    simplistic and can cause issues in some cases. We will transition away
     +    from making this upgrade automatically, but first we will make an easy
     +    way for users to upgrade their repositories correctly.
      
          Transitioning from one config file to multiple has some strange
          side-effects. In particular, if the base repository is bare and the
          worktree is not, Git knows to treat the worktree as non-bare as a
          special case when not using worktree config. Once worktree config is
          enabled, Git stops that special case since the core.bare setting could
     -    apply at the worktree config level. This opens the door for bare
     -    worktrees.
     +    apply at the worktree config level.
      
     -    To help resolve this transition, create upgrade_to_worktree_config() to
     -    navigate the intricacies of this operation. In particular, we need to
     -    look for core.bare=true within the base config file and move that
     -    setting into the core repository's config.worktree file.
     +    Similarly, the core.worktree config setting is a precursor to the 'git
     +    worktree' feature, allowing config to point to a different worktree,
     +    presumably temporarily. This is special-cased to be ignored in a
     +    worktree, but that case is dropped when worktree config is enabled.
     +
     +    To help resolve this transition, create the 'git worktree
     +    init-worktree-config' helper. This new subcommand does the following:
     +
     +     1. Set core.repositoryFormatVersion to 1 in the common config file.
     +     2. Set extensions.worktreeConfig to true in the common config file.
     +     3. If core.bare is true in the common config file, then move that
     +        setting to the main worktree's config file.
     +     4. Move the core.worktree config value to the main worktree's config
     +        file.
     +
     +    If the repository is already configured to use worktree config, then
     +    none of these steps happen. This preserves any state that the user might
     +    have created on purpose.
     +
     +    Update the documentation to mention this subcommand as the proper way to
     +    upgrade to worktree config files.
      
          To gain access to the core repository's config and config.worktree file,
          we reference a repository struct's 'commondir' member. If the repository
     @@ Commit message
          Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     - ## worktree.c ##
     + ## Documentation/git-worktree.txt ##
     +@@ Documentation/git-worktree.txt: SYNOPSIS
     + --------
     + [verse]
     + 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]] [-b <new-branch>] <path> [<commit-ish>]
     ++'git worktree init-worktree-config'
     + 'git worktree list' [-v | --porcelain]
     + 'git worktree lock' [--reason <string>] <worktree>
     + 'git worktree move' <worktree> <new-path>
     +@@ Documentation/git-worktree.txt: checked out in the new working tree, if it's not checked out anywhere
     + else, otherwise the command will refuse to create the working tree (unless
     + `--force` is used).
     + 
     ++init-worktree-config::
     ++
     ++Initialize config settings to enable worktree-specific config settings.
     ++This will set `core.repositoryFormatversion=1` and enable
     ++`extensions.worktreeConfig`, which might cause some third-party tools from
     ++being able to operate on your repository. See CONFIGURATION FILE for more
     ++details.
     ++
     + list::
     + 
     + List details of each working tree.  The main working tree is listed first,
     +@@ Documentation/git-worktree.txt: already present in the config file, they will be applied to the main
     + working trees only.
     + 
     + In order to have configuration specific to working trees, you can turn
     +-on the `worktreeConfig` extension, e.g.:
     ++on the `worktreeConfig` extension, using this command:
     + 
     + ------------
     +-$ git config extensions.worktreeConfig true
     ++$ git worktree init-worktree-config
     + ------------
     + 
     + In this mode, specific configuration stays in the path pointed by `git
     +@@ Documentation/git-worktree.txt: versions will refuse to access repositories with this extension.
     + 
     + Note that in this file, the exception for `core.bare` and `core.worktree`
     + is gone. If they exist in `$GIT_DIR/config`, you must move
     +-them to the `config.worktree` of the main working tree. You may also
     +-take this opportunity to review and move other configuration that you
     +-do not want to share to all working trees:
     ++them to the `config.worktree` of the main working tree. These keys are
     ++moved automatically when you use the `git worktree init-worktree-config`
     ++command.
     ++
     ++You may also take this opportunity to review and move other configuration
     ++that you do not want to share to all working trees:
     + 
     +  - `core.worktree` and `core.bare` should never be shared
     + 
     +
     + ## builtin/worktree.c ##
      @@
     - #include "worktree.h"
     - #include "dir.h"
     - #include "wt-status.h"
     -+#include "config.h"
       
     - void free_worktrees(struct worktree **worktrees)
     - {
     -@@ worktree.c: int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
     - 	*wtpath = path;
     - 	return 0;
     + static const char * const worktree_usage[] = {
     + 	N_("git worktree add [<options>] <path> [<commit-ish>]"),
     ++	N_("git worktree init-worktree-config"),
     + 	N_("git worktree list [<options>]"),
     + 	N_("git worktree lock [<options>] <path>"),
     + 	N_("git worktree move <worktree> <new-path>"),
     +@@ builtin/worktree.c: static int repair(int ac, const char **av, const char *prefix)
     + 	return rc;
       }
     + 
     ++static int move_config_setting(const char *key, const char *value,
     ++			       const char *from_file, const char *to_file)
     ++{
     ++	if (git_config_set_in_file_gently(to_file, key, value))
     ++		return error(_("unable to set %s in '%s'"), key, to_file);
     ++	if (git_config_set_in_file_gently(from_file, key, NULL))
     ++		return error(_("unable to unset %s in '%s'"), key, from_file);
     ++	return 0;
     ++}
      +
     -+int upgrade_to_worktree_config(struct repository *r)
     ++static int init_worktree_config(int ac, const char **av, const char *prefix)
      +{
     -+	int res;
     ++	struct repository *r = the_repository;
     ++	struct option options[] = {
     ++		OPT_END()
     ++	};
     ++	int res = 0;
      +	int bare = 0;
      +	struct config_set cs = { 0 };
     -+	char *base_config_file = xstrfmt("%s/config", r->commondir);
     -+	char *base_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
     ++	const char *core_worktree;
     ++	char *common_config_file = xstrfmt("%s/config", r->commondir);
     ++	char *main_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
     ++
     ++	/* Report error on any arguments */
     ++	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
     ++	if (ac)
     ++		usage_with_options(worktree_usage, options);
      +
      +	git_configset_init(&cs);
     -+	git_configset_add_file(&cs, base_config_file);
     ++	git_configset_add_file(&cs, common_config_file);
      +
      +	/*
     -+	 * If the base repository is bare, then we need to move core.bare=true
     -+	 * out of the base config file and into the base repository's
     -+	 * config.worktree file.
     ++	 * If the format and extension are already enabled, then we can
     ++	 * skip the upgrade process.
      +	 */
     -+	if (!git_configset_get_bool(&cs, "core.bare", &bare) && bare) {
     -+		if ((res = git_config_set_in_file_gently(base_worktree_file,
     -+							"core.bare", "true"))) {
     -+			error(_("unable to set core.bare=true in '%s'"), base_worktree_file);
     -+			goto cleanup;
     -+		}
     ++	if (repository_format_worktree_config)
     ++		return 0;
      +
     -+		if ((res = git_config_set_in_file_gently(base_config_file,
     -+							"core.bare", NULL))) {
     -+			error(_("unable to unset core.bare=true in '%s'"), base_config_file);
     -+			goto cleanup;
     -+		}
     -+	}
      +	if (upgrade_repository_format(r, 1) < 0) {
      +		res = error(_("unable to upgrade repository format to enable worktreeConfig"));
      +		goto cleanup;
     @@ worktree.c: int should_prune_worktree(const char *id, struct strbuf *reason, cha
      +		goto cleanup;
      +	}
      +
     ++	/*
     ++	 * If core.bare is true in the common config file, then we need to
     ++	 * move it to the base worktree's config file or it will break all
     ++	 * worktrees. If it is false, then leave it in place because it
     ++	 * _could_ be negating a global core.bare=true.
     ++	 */
     ++	if (!git_configset_get_bool(&cs, "core.bare", &bare) && bare) {
     ++		if ((res = move_config_setting("core.bare", "true",
     ++					       common_config_file,
     ++					       main_worktree_file)))
     ++			goto cleanup;
     ++	}
     ++	/*
     ++	 * If core.worktree is set, then the base worktree is located
     ++	 * somewhere different than the parent of the common Git dir.
     ++	 * Relocate that value to avoid breaking all worktrees with this
     ++	 * upgrade to worktree config.
     ++	 */
     ++	if (!git_configset_get_string_tmp(&cs, "core.worktree", &core_worktree)) {
     ++		if ((res = move_config_setting("core.worktree", core_worktree,
     ++					       common_config_file,
     ++					       main_worktree_file)))
     ++			goto cleanup;
     ++	}
     ++
      +cleanup:
      +	git_configset_clear(&cs);
     -+	free(base_config_file);
     -+	free(base_worktree_file);
     -+	trace2_printf("returning %d", res);
     ++	free(common_config_file);
     ++	free(main_worktree_file);
      +	return res;
      +}
     ++
     + int cmd_worktree(int ac, const char **av, const char *prefix)
     + {
     + 	struct option options[] = {
     +@@ builtin/worktree.c: int cmd_worktree(int ac, const char **av, const char *prefix)
     + 		prefix = "";
     + 	if (!strcmp(av[1], "add"))
     + 		return add(ac - 1, av + 1, prefix);
     ++	if (!strcmp(av[1], "init-worktree-config"))
     ++		return init_worktree_config(ac - 1, av + 1, prefix);
     + 	if (!strcmp(av[1], "prune"))
     + 		return prune(ac - 1, av + 1, prefix);
     + 	if (!strcmp(av[1], "list"))
      
     - ## worktree.h ##
     -@@ worktree.h: void strbuf_worktree_ref(const struct worktree *wt,
     - 			 struct strbuf *sb,
     - 			 const char *refname);
     - 
     -+/**
     -+ * Upgrade the config of the current repository and its base (if different
     -+ * from this repository) to use worktree-config. This might adjust config
     -+ * in both repositories, including:
     -+ *
     -+ * 1. Upgrading the repository format version to 1.
     -+ * 2. Adding extensions.worktreeConfig to the base config file.
     -+ * 3. Moving core.bare=true from the base config file to the base
     -+ *    repository's config.worktree file.
     -+ */
     -+int upgrade_to_worktree_config(struct repository *r);
     -+
     - #endif
     + ## t/t2407-worktree-init-worktree-config.sh (new) ##
     +@@
     ++#!/bin/sh
     ++
     ++test_description='test git worktree init-worktree-config'
     ++
     ++. ./test-lib.sh
     ++
     ++test_expect_success setup '
     ++	git init base &&
     ++	test_commit -C base commit &&
     ++	git -C base worktree add --detach worktree
     ++'
     ++
     ++reset_config_when_finished () {
     ++	test_when_finished git -C base config --unset core.repositoryFormatVersion &&
     ++	test_when_finished git -C base config --unset extensions.worktreeConfig &&
     ++	rm -rf base/.git/config.worktree &&
     ++	rm -rf base/.git/worktrees/worktree/config.worktree
     ++}
     ++
     ++test_expect_success 'upgrades repo format and adds extension' '
     ++	reset_config_when_finished &&
     ++	git -C base worktree init-worktree-config >out 2>err &&
     ++	test_must_be_empty out &&
     ++	test_must_be_empty err &&
     ++	test_cmp_config -C base 1 core.repositoryFormatVersion &&
     ++	test_cmp_config -C base true extensions.worktreeConfig
     ++'
     ++
     ++test_expect_success 'relocates core.worktree' '
     ++	reset_config_when_finished &&
     ++	mkdir dir &&
     ++	git -C base config core.worktree ../../dir &&
     ++	git -C base worktree init-worktree-config >out 2>err &&
     ++	test_must_be_empty out &&
     ++	test_must_be_empty err &&
     ++	test_cmp_config -C base 1 core.repositoryFormatVersion &&
     ++	test_cmp_config -C base true extensions.worktreeConfig &&
     ++	test_cmp_config -C base ../../dir core.worktree &&
     ++	test_must_fail git -C worktree core.worktree
     ++'
     ++
     ++test_expect_success 'relocates core.bare' '
     ++	reset_config_when_finished &&
     ++	git -C base config core.bare true &&
     ++	git -C base worktree init-worktree-config >out 2>err &&
     ++	test_must_be_empty out &&
     ++	test_must_be_empty err &&
     ++	test_cmp_config -C base 1 core.repositoryFormatVersion &&
     ++	test_cmp_config -C base true extensions.worktreeConfig &&
     ++	test_cmp_config -C base true core.bare &&
     ++	test_must_fail git -C worktree core.bare
     ++'
     ++
     ++test_expect_success 'skips upgrade is already upgraded' '
     ++	reset_config_when_finished &&
     ++	git -C base worktree init-worktree-config &&
     ++	git -C base config core.bare true &&
     ++
     ++	# this should be a no-op, even though core.bare
     ++	# makes the worktree be broken.
     ++	git -C base worktree init-worktree-config >out 2>err &&
     ++	test_must_be_empty out &&
     ++	test_must_be_empty err &&
     ++	test_must_fail git -C base config --worktree core.bare &&
     ++	git -C base config core.bare
     ++'
     ++
     ++test_done
 4:  22896e9bb04 ! 4:  45316cd01c9 config: add repo_config_set_worktree_gently()
     @@ Metadata
       ## Commit message ##
          config: add repo_config_set_worktree_gently()
      
     -    The previous change added upgrade_to_worktree_config() to assist
     -    creating a worktree-specific config for the first time. However, this
     -    requires every config writer to care about that upgrade before writing
     -    to the worktree-specific config. In addition, callers need to know how
     -    to generate the name of the config.worktree file and pass it to the
     -    config API.
     +    Some config settings, such as those for sparse-checkout, are likely
     +    intended to only apply to one worktree at a time. To make this write
     +    easier, add a new config API method, repo_config_set_worktree_gently().
      
     -    To assist, create a new repo_config_set_worktree_gently() method in the
     -    config API that handles the upgrade_to_worktree_config() method in
     -    addition to assigning the value in the worktree-specific config. This
     -    will be consumed by an upcoming change.
     +    This method will attempt to write to the worktree-specific config, but
     +    will instead write to the common config file if worktree config is not
     +    enabled.  The next change will introduce a consumer of this method.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ config.c: int git_config_set_gently(const char *key, const char *value)
      +int repo_config_set_worktree_gently(struct repository *r,
      +				    const char *key, const char *value)
      +{
     -+	return upgrade_to_worktree_config(r) ||
     -+	       git_config_set_multivar_in_file_gently(
     -+			 repo_git_path(r, "config.worktree"),
     -+			 key, value, NULL, 0);
     ++	/* Only use worktree-specific config if it is is already enabled. */
     ++	if (repository_format_worktree_config) {
     ++		char *file = repo_git_path(r, "config.worktree");
     ++		int ret = git_config_set_multivar_in_file_gently(
     ++					file, key, value, NULL, 0);
     ++		free(file);
     ++		return ret;
     ++	}
     ++	return repo_config_set_gently(r, key, value);
      +}
      +
       void git_config_set(const char *key, const char *value)
       {
       	repo_config_set(the_repository, key, value);
     +@@ config.c: int repo_config_set_multivar_gently(struct repository *r, const char *key,
     + 						      flags);
     + }
     + 
     ++int repo_config_set_gently(struct repository *r,
     ++			   const char *key, const char *value)
     ++{
     ++	return repo_config_set_multivar_gently(r, key, value, NULL, 0);
     ++}
     ++
     + void git_config_set_multivar(const char *key, const char *value,
     + 			     const char *value_pattern, unsigned flags)
     + {
      
       ## config.h ##
      @@ config.h: void git_config_set_in_file(const char *, const char *, const char *);
     @@ config.h: void git_config_set_in_file(const char *, const char *, const char *);
       int git_config_set_gently(const char *, const char *);
       
      +/**
     -+ * Write a config value into the config.worktree file for the current
     -+ * worktree. This will initialize extensions.worktreeConfig if necessary,
     -+ * which might trigger some changes to the root repository's config file.
     ++ * Write a config value that should apply to the current worktree. If
     ++ * extensions.worktreeConfig is enabled, then the write will happen in the
     ++ * current worktree's config. Otherwise, write to the common config file.
      + */
      +int repo_config_set_worktree_gently(struct repository *, const char *, const char *);
      +
       /**
        * write config values to `.git/config`, takes a key/value pair as parameter.
        */
     +@@ config.h: int git_config_set_multivar_gently(const char *, const char *, const char *, uns
     + void git_config_set_multivar(const char *, const char *, const char *, unsigned);
     + int repo_config_set_multivar_gently(struct repository *, const char *, const char *, const char *, unsigned);
     + void repo_config_set_multivar(struct repository *, const char *, const char *, const char *, unsigned);
     ++int repo_config_set_gently(struct repository *, const char *, const char *);
     + int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, unsigned);
     + 
     + /**
 5:  06457fafa78 ! 5:  b200819c1bb sparse-checkout: use repo_config_set_worktree_gently()
     @@ Commit message
          sparse-checkout: use repo_config_set_worktree_gently()
      
          The previous change added repo_config_set_worktree_gently() to assist
     -    writing config values into the worktree.config file, especially when
     -    that may not have been initialized.
     +    writing config values into the worktree.config file, if enabled.
      
     -    When the base repo is bare, running 'git sparse-checkout init' in a
     -    worktree will create the config.worktree file for the worktree, but that
     -    will start causing the worktree to parse the bare repo's core.bare=true
     -    value and start treating the worktree as bare. This causes more problems
     -    as other commands are run in that worktree.
     +    Let the sparse-checkout builtin use this helper instead of attempting to
     +    initialize the worktree config on its own. This changes behavior of 'git
     +    sparse-checkout set' in a few important ways:
      
     -    The fix is to have this assignment into config.worktree be handled by
     -    the repo_config_set_worktree_gently() helper.
     +     1. Git will no longer upgrade the repository format and add the
     +        worktree config extension. The user should run 'git worktree
     +        init-worktree-config' to enable this feature.
     +
     +     2. If worktree config is disabled, then this command will set the
     +        core.sparseCheckout (and possibly core.sparseCheckoutCone and
     +        index.sparse) values in the common config file.
     +
     +     3. If the main worktree is bare, then this command will not put the
     +        worktree in a broken state.
     +
     +    The main reason to use worktree-specific config for the sparse-checkout
     +    builtin was to avoid enabling sparse-checkout patterns in one and
     +    causing a loss of files in another. If a worktree does not have a
     +    sparse-checkout patterns file, then the sparse-checkout logic will not
     +    kick in on that worktree.
     +
     +    This new logic introduces a new user pattern that could lead to some
     +    confusion. Suppose a user has not upgraded to worktree config and
     +    follows these steps in order:
     +
     +     1. Enable sparse-checkout in a worktree.
     +
     +     2. Disable sparse-checkout in that worktree without deleting that
     +        worktree's sparse-checkout file.
     +
     +     3. Enable sparse-checkout in another worktree.
     +
     +    After these steps, the first worktree will have sparse-checkout enabled
     +    with whatever patterns exist. The worktree does not immediately have
     +    those patterns applied, but a variety of Git commands would apply the
     +    sparse-checkout patterns and update the worktree state to reflect those
     +    patterns. This situation is likely very rare and the workaround is to
     +    upgrade to worktree specific config on purpose. Users already in this
     +    state used the sparse-checkout builtin with a version that upgraded to
     +    worktree config, anyway.
      
          Reported-by: Sean Allred <allred.sean@gmail.com>
          Helped-by: Eric Sunshine <sunshine@sunshineco.com>
     @@ sparse-index.c: static int convert_to_sparse_rec(struct index_state *istate,
       	return res;
      
       ## t/t1091-sparse-checkout-builtin.sh ##
     -@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'git sparse-checkout init' '
     - 	check_files repo a
     +@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'interaction with clone --no-checkout (unborn index)' '
       '
       
     -+test_expect_success 'init in a worktree of a bare repo' '
     -+	test_when_finished rm -rf bare worktree &&
     -+	git clone --bare repo bare &&
     -+	git -C bare worktree add ../worktree &&
     -+	(
     -+		cd worktree &&
     -+		git sparse-checkout init &&
     -+		test_must_fail git config core.bare &&
     -+		git sparse-checkout set /*
     + test_expect_success 'set enables config' '
     +-	git init empty-config &&
     ++	git init initial-config &&
     + 	(
     +-		cd empty-config &&
     ++		cd initial-config &&
     ++		test_commit file file &&
     ++		mkdir dir &&
     ++		test_commit dir dir/file &&
     ++		git worktree add --detach ../initial-worktree &&
     ++		git sparse-checkout set --cone
      +	) &&
     -+	git -C bare config --list --show-origin >actual &&
     -+	grep "file:config.worktree	core.bare=true" actual
     ++	test_cmp_config -C initial-config true core.sparseCheckout &&
     ++	test_cmp_config -C initial-worktree true core.sparseCheckout &&
     ++	test_cmp_config -C initial-config true core.sparseCheckoutCone &&
     ++	test_cmp_config -C initial-worktree true core.sparseCheckoutCone &&
     ++
     ++	# initial-config has a sparse-checkout file
     ++	# that only contains files at root.
     ++	ls initial-config >only-file &&
     ++	cat >expect <<-EOF &&
     ++	file
     ++	EOF
     ++	test_cmp expect only-file &&
     ++
     ++	# initial-worktree does not have its own sparse-checkout
     ++	# file, so the repply does not modify the worktree at all.
     ++	git -C initial-worktree sparse-checkout reapply &&
     ++	ls initial-worktree >all &&
     ++	cat >expect <<-EOF &&
     ++	dir
     ++	file
     ++	EOF
     ++	test_cmp expect all
      +'
      +
     - test_expect_success 'git sparse-checkout list after init' '
     - 	git -C repo sparse-checkout list >actual &&
     - 	cat >expect <<-\EOF &&
     ++test_expect_success 'set enables worktree config, if enabled' '
     ++	git init worktree-config &&
     ++	(
     ++		cd worktree-config &&
     + 		test_commit test file &&
     +-		test_path_is_missing .git/config.worktree &&
     +-		git sparse-checkout set nothing &&
     +-		test_path_is_file .git/config.worktree &&
     +-		test_cmp_config true core.sparseCheckout
     +-	)
     ++		git worktree add --detach ../worktree-config2 &&
     ++		git worktree init-worktree-config &&
     ++		git sparse-checkout set --cone &&
     ++		git config --worktree core.sparseCheckout &&
     ++		git config --worktree core.sparseCheckoutCone
     ++	) &&
     ++	test_cmp_config -C worktree-config true core.sparseCheckout &&
     ++	test_must_fail git -C worktree-config2 core.sparseCheckout &&
     ++	test_cmp_config -C worktree-config true core.sparseCheckoutCone &&
     ++	test_must_fail git -C worktree-config2 core.sparseCheckoutCone
     + '
     + 
     + test_expect_success 'set sparse-checkout using builtin' '
     +@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'add to sparse-checkout' '
     + '
     + 
     + test_expect_success 'cone mode: match patterns' '
     ++	git -C repo worktree init-worktree-config &&
     + 	git -C repo config --worktree core.sparseCheckoutCone true &&
     + 	rm -rf repo/a repo/folder1 repo/folder2 &&
     + 	git -C repo read-tree -mu HEAD 2>err &&
      @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'sparse-index enabled and disabled' '
       		test-tool -C repo read-cache --table >cache &&
       		! grep " tree " cache &&
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'sparse-index enabled an
       	)
       '
       
     +@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'fail when lock is taken' '
     + '
     + 
     + test_expect_success '.gitignore should not warn about cone mode' '
     ++	git -C repo worktree init-worktree-config &&
     + 	git -C repo config --worktree core.sparseCheckoutCone true &&
     + 	echo "**/bin/*" >repo/.gitignore &&
     + 	git -C repo reset --hard 2>err &&
 -:  ----------- > 6:  fcece09546c worktree: copy sparse-checkout patterns and config on add

-- 
gitgitgadget
