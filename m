Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E97C433FE
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 18:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiAYSnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 13:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiAYSmU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 13:42:20 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50F9C06173D
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 10:42:18 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h21so4026402wrb.8
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 10:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rIZDlOABPoKeF9bHfrG3IOLTK879fJl/SIStBJZkcQ0=;
        b=SP3HGJxW3dweYtnyx6vBztXqE/LqZTTC1RSRhAOM6med6mJ4qm4yujzDWQDzYwyfV4
         ghRYt5AnkATYrkP8blLwSpbUcNJ9mImbpSp5MHJJx1MIPuJm9D14Zhsc7Avv6iwI4elW
         W3QL3LivK6DGJNBxg106i8byns/QragLbOP4kGk3zOsfd3/F8umK/RW0yCz930wvdU9s
         XsXclPUBZzk8hnPS5YTQE2XaWhUKaJF9bdwbnwqgJrnpCr4vm0foYxYkdklXe5oGeSds
         Gm6QBVrmjVp7MpraDWr7EfVpW/EPx4LXWWF0fv2SLHgkXlYHGx5j8d9t/hOvQsBqAZQs
         aI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rIZDlOABPoKeF9bHfrG3IOLTK879fJl/SIStBJZkcQ0=;
        b=Xt3HyUYTlKvMZcDdhpLGSdS7XkJzYOduqa3D732mMrbcUk5oItuVtghJOsRzMbe0Ou
         T8dAdA0rQgUQ2REvziyskxInKnFTxdb07t+lbGbpUoW4WWV4ERd1b18gSK7s+syWxQXG
         yzsV8gbNKxTLkykDT3mgngvkmaHwG9b1UIgFamnOb+mll3Af/DYRIvWVVZ05IbUxTmdX
         BEzVJ9KZHVZsYEOYEYF2Bn65f5ueI3iZrBDmPwEk2GEYslhZ4czBCxiCLLVYxwT66uvq
         Ot5TB7y/udgnQo8EQl9IStQWr/Jp5tZHQj2hrrzQm3MBEFIIpB87UkjQ25UVz9/pZ+py
         rt5A==
X-Gm-Message-State: AOAM5326u+Mb50FbtyGcZ4ED/V7p5BYNjw8yoNUP/RLBeBGRbtmAbYi2
        Z+vV3tmJ12BULrRVGlqTblRCjiQx/8wW2w==
X-Google-Smtp-Source: ABdhPJxeHRDHdyJkMICNIEg/akOj67VcFgTg0qxXl/ZEju8781mXasLXhLzhSz7NrhdsGBnLGjmBIg==
X-Received: by 2002:a5d:5104:: with SMTP id s4mr7621241wrt.336.1643136136330;
        Tue, 25 Jan 2022 10:42:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm414287wmq.21.2022.01.25.10.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 10:42:15 -0800 (PST)
Message-Id: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
References: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Jan 2022 18:42:09 +0000
Subject: [PATCH v4 0/5] Sparse checkout: fix bug with worktree of bare repo
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

This series is now based on v2.35.0 since that contains all of the necessary
topics.

This patch series includes a fix to the bug reported by Sean Allred [1] and
diagnosed by Eric Sunshine [2].

The root cause is that 'git sparse-checkout init' writes to the worktree
config without checking that core.bare or core.worktree are set in the
common config file. This series fixes this, but also puts in place some
helpers to prevent this from happening in the future.

ATTENTION: I have significantly redesigned the series since previous
versions, so most of this cover letter is new.

 * Patch 1 updates documentation around extensions.worktreeConfig in a few
   places to improve discoverability. Several cross links are added to make
   it easy to find the related areas. (The documentation for the changes to
   'git sparse-checkout' are delayed to patch 4.)

 * Patch 2 introduces the init_worktree_config() helper which follows the
   documented instructions to enable extensions.worktreeConfig as well as
   move the core.bare and core.worktree config values. This update does not
   modify core.repositoryFormatVersion, since this is not needed
   specifically for extensions.worktreeConfig.

 * Patch 3 adds a new repo_config_set_worktree_gently() helper method so we
   can internally adjust a config value within a worktree, at least if
   extensions.worktreeConfig is enabled. (It will write to the common config
   file if the extension is not enabled.)

 * Patch 4 modifies the sparse-checkout builtin to use
   init_worktree_config() and repo_config_set_worktree_gently() in ways that
   fix the reported bug. The behavior change here is that it will no longer
   upgrade the repository format version, since that is not needed for
   extensions.worktreeConfig.

 * Patch 5 updates 'git worktree add' to copy the worktree config from the
   current worktree to the new one (while unsetting core.bare=true and
   core.worktree=*) along with copying the sparse-checkout patterns file.

[1]
https://lore.kernel.org/git/CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com/
[2]
https://lore.kernel.org/git/CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com/


Updates in v4
=============

 * Rebased to v2.35.0
 * Fixed memory leak (was leaking repo_git_path() result)
 * Added additional documentation updates so curious users can discover the
   intricacies of extensions.worktreeConfig from multiple entry points.
 * Significantly reduced the amount of changes to config.c.
 * 'git sparse-checkout' no longer upgrades the repository format.
 * Dropped the update to upgrade_repository_format(), since it is not
   needed.
 * Dropped the 'git worktree init-worktree-config' subcommand in favor of a
   helper method called by 'git sparse-checkout'
 * Many others because of the significant changes required by the above
   items.

Thanks, -Stolee

Derrick Stolee (5):
  Documentation: add extensions.worktreeConfig details
  worktree: create init_worktree_config()
  config: add repo_config_set_worktree_gently()
  sparse-checkout: set worktree-config correctly
  worktree: copy sparse-checkout patterns and config on add

 Documentation/config/extensions.txt   | 31 ++++++++++++
 Documentation/git-config.txt          |  8 ++-
 Documentation/git-sparse-checkout.txt | 24 ++++++---
 Documentation/git-worktree.txt        | 11 +++--
 builtin/sparse-checkout.c             | 28 +++++------
 builtin/worktree.c                    | 60 +++++++++++++++++++++++
 config.c                              | 35 ++++++++++++--
 config.h                              |  8 +++
 sparse-index.c                        | 10 ++--
 t/t1091-sparse-checkout-builtin.sh    | 35 ++++++++++----
 t/t2400-worktree-add.sh               | 46 +++++++++++++++++-
 worktree.c                            | 70 +++++++++++++++++++++++++++
 worktree.h                            | 19 ++++++++
 13 files changed, 336 insertions(+), 49 deletions(-)


base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1101%2Fderrickstolee%2Fsparse-checkout%2Fbare-worktree-bug-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1101/derrickstolee/sparse-checkout/bare-worktree-bug-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1101

Range-diff vs v3:

 1:  749ba67d21e < -:  ----------- setup: use a repository when upgrading format
 2:  61b96937016 < -:  ----------- config: make some helpers repo-aware
 -:  ----------- > 1:  459e09dedd7 Documentation: add extensions.worktreeConfig details
 3:  e2a0a458115 ! 2:  d262a76b448 worktree: add 'init-worktree-config' subcommand
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    worktree: add 'init-worktree-config' subcommand
     +    worktree: create init_worktree_config()
      
     -    Some features, such as the sparse-checkout builtin, currently use the
     -    worktree config extension. It might seem simple to upgrade the
     -    repository format and add extensions.worktreeConfig, which is what
     -    happens in the sparse-checkout builtin. However, this is overly
     -    simplistic and can cause issues in some cases. We will transition away
     -    from making this upgrade automatically, but first we will make an easy
     -    way for users to upgrade their repositories correctly.
     +    Upgrading a repository to use extensions.worktreeConfig is non-trivial.
     +    There are several steps involved, including moving some config settings
     +    from the common config file to the main worktree's config.worktree file.
     +    The previous change updated the documentation with all of these details.
      
     -    Transitioning from one config file to multiple has some strange
     -    side-effects. In particular, if the base repository is bare and the
     -    worktree is not, Git knows to treat the worktree as non-bare as a
     -    special case when not using worktree config. Once worktree config is
     -    enabled, Git stops that special case since the core.bare setting could
     -    apply at the worktree config level.
     +    Commands such as 'git sparse-checkout set' upgrade the repository to use
     +    extensions.worktreeConfig without following these steps, causing some
     +    user pain in some special cases.
      
     -    Similarly, the core.worktree config setting is a precursor to the 'git
     -    worktree' feature, allowing config to point to a different worktree,
     -    presumably temporarily. This is special-cased to be ignored in a
     -    worktree, but that case is dropped when worktree config is enabled.
     +    Create a helper method, init_worktree_config(), that will be used in a
     +    later change to fix this behavior within 'git sparse-checkout set'. The
     +    method is carefully documented in worktree.h.
      
     -    To help resolve this transition, create the 'git worktree
     -    init-worktree-config' helper. This new subcommand does the following:
     +    Note that we do _not_ upgrade the repository format version to 1 during
     +    this process. The worktree config extension must be considered by Git
     +    and third-party tools even if core.repositoryFormatVersion is 0 for
     +    historical reasons documented in 11664196ac ("Revert
     +    "check_repository_format_gently(): refuse extensions for old
     +    repositories"", 2020-07-15). This is a special case for this extension,
     +    and newer extensions (such as extensions.objectFormat) still need to
     +    upgrade the repository format version.
      
     -     1. Set core.repositoryFormatVersion to 1 in the common config file.
     -     2. Set extensions.worktreeConfig to true in the common config file.
     -     3. If core.bare is true in the common config file, then move that
     -        setting to the main worktree's config file.
     -     4. Move the core.worktree config value to the main worktree's config
     -        file.
     -
     -    If the repository is already configured to use worktree config, then
     -    none of these steps happen. This preserves any state that the user might
     -    have created on purpose.
     -
     -    Update the documentation to mention this subcommand as the proper way to
     -    upgrade to worktree config files.
     -
     -    To gain access to the core repository's config and config.worktree file,
     -    we reference a repository struct's 'commondir' member. If the repository
     -    was a submodule instead of a worktree, then this still applies
     -    correctly.
     -
     -    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     - ## Documentation/git-worktree.txt ##
     -@@ Documentation/git-worktree.txt: SYNOPSIS
     - --------
     - [verse]
     - 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]] [-b <new-branch>] <path> [<commit-ish>]
     -+'git worktree init-worktree-config'
     - 'git worktree list' [-v | --porcelain]
     - 'git worktree lock' [--reason <string>] <worktree>
     - 'git worktree move' <worktree> <new-path>
     -@@ Documentation/git-worktree.txt: checked out in the new working tree, if it's not checked out anywhere
     - else, otherwise the command will refuse to create the working tree (unless
     - `--force` is used).
     - 
     -+init-worktree-config::
     -+
     -+Initialize config settings to enable worktree-specific config settings.
     -+This will set `core.repositoryFormatversion=1` and enable
     -+`extensions.worktreeConfig`, which might cause some third-party tools from
     -+being able to operate on your repository. See CONFIGURATION FILE for more
     -+details.
     -+
     - list::
     - 
     - List details of each working tree.  The main working tree is listed first,
     -@@ Documentation/git-worktree.txt: already present in the config file, they will be applied to the main
     - working trees only.
     - 
     - In order to have configuration specific to working trees, you can turn
     --on the `worktreeConfig` extension, e.g.:
     -+on the `worktreeConfig` extension, using this command:
     - 
     - ------------
     --$ git config extensions.worktreeConfig true
     -+$ git worktree init-worktree-config
     - ------------
     - 
     - In this mode, specific configuration stays in the path pointed by `git
     -@@ Documentation/git-worktree.txt: versions will refuse to access repositories with this extension.
     - 
     - Note that in this file, the exception for `core.bare` and `core.worktree`
     - is gone. If they exist in `$GIT_DIR/config`, you must move
     --them to the `config.worktree` of the main working tree. You may also
     --take this opportunity to review and move other configuration that you
     --do not want to share to all working trees:
     -+them to the `config.worktree` of the main working tree. These keys are
     -+moved automatically when you use the `git worktree init-worktree-config`
     -+command.
     -+
     -+You may also take this opportunity to review and move other configuration
     -+that you do not want to share to all working trees:
     - 
     -  - `core.worktree` and `core.bare` should never be shared
     - 
     -
     - ## builtin/worktree.c ##
     + ## worktree.c ##
      @@
     + #include "worktree.h"
     + #include "dir.h"
     + #include "wt-status.h"
     ++#include "config.h"
       
     - static const char * const worktree_usage[] = {
     - 	N_("git worktree add [<options>] <path> [<commit-ish>]"),
     -+	N_("git worktree init-worktree-config"),
     - 	N_("git worktree list [<options>]"),
     - 	N_("git worktree lock [<options>] <path>"),
     - 	N_("git worktree move <worktree> <new-path>"),
     -@@ builtin/worktree.c: static int repair(int ac, const char **av, const char *prefix)
     - 	return rc;
     + void free_worktrees(struct worktree **worktrees)
     + {
     +@@ worktree.c: int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
     + 	*wtpath = path;
     + 	return 0;
       }
     - 
     ++
      +static int move_config_setting(const char *key, const char *value,
      +			       const char *from_file, const char *to_file)
      +{
     @@ builtin/worktree.c: static int repair(int ac, const char **av, const char *prefi
      +	return 0;
      +}
      +
     -+static int init_worktree_config(int ac, const char **av, const char *prefix)
     ++int init_worktree_config(struct repository *r)
      +{
     -+	struct repository *r = the_repository;
     -+	struct option options[] = {
     -+		OPT_END()
     -+	};
      +	int res = 0;
      +	int bare = 0;
     -+	struct config_set cs = { 0 };
     ++	struct config_set cs = { { 0 } };
      +	const char *core_worktree;
      +	char *common_config_file = xstrfmt("%s/config", r->commondir);
      +	char *main_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
      +
     -+	/* Report error on any arguments */
     -+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
     -+	if (ac)
     -+		usage_with_options(worktree_usage, options);
     -+
     -+	git_configset_init(&cs);
     -+	git_configset_add_file(&cs, common_config_file);
     -+
      +	/*
     -+	 * If the format and extension are already enabled, then we can
     -+	 * skip the upgrade process.
     ++	 * If the extension is already enabled, then we can skip the
     ++	 * upgrade process.
      +	 */
      +	if (repository_format_worktree_config)
      +		return 0;
     ++	if ((res = git_config_set_gently("extensions.worktreeConfig", "true")))
     ++		return error(_("failed to set extensions.worktreeConfig setting"));
      +
     -+	if (upgrade_repository_format(r, 1) < 0) {
     -+		res = error(_("unable to upgrade repository format to enable worktreeConfig"));
     -+		goto cleanup;
     -+	}
     -+	if ((res = git_config_set_gently("extensions.worktreeConfig", "true"))) {
     -+		error(_("failed to set extensions.worktreeConfig setting"));
     -+		goto cleanup;
     -+	}
     ++	git_configset_init(&cs);
     ++	git_configset_add_file(&cs, common_config_file);
      +
      +	/*
      +	 * If core.bare is true in the common config file, then we need to
     @@ builtin/worktree.c: static int repair(int ac, const char **av, const char *prefi
      +			goto cleanup;
      +	}
      +
     ++	/*
     ++	 * Ensure that we use worktree config for the remaining lifetime
     ++	 * of the current process.
     ++	 */
     ++	repository_format_worktree_config = 1;
     ++
      +cleanup:
      +	git_configset_clear(&cs);
      +	free(common_config_file);
      +	free(main_worktree_file);
      +	return res;
      +}
     -+
     - int cmd_worktree(int ac, const char **av, const char *prefix)
     - {
     - 	struct option options[] = {
     -@@ builtin/worktree.c: int cmd_worktree(int ac, const char **av, const char *prefix)
     - 		prefix = "";
     - 	if (!strcmp(av[1], "add"))
     - 		return add(ac - 1, av + 1, prefix);
     -+	if (!strcmp(av[1], "init-worktree-config"))
     -+		return init_worktree_config(ac - 1, av + 1, prefix);
     - 	if (!strcmp(av[1], "prune"))
     - 		return prune(ac - 1, av + 1, prefix);
     - 	if (!strcmp(av[1], "list"))
      
     - ## t/t2407-worktree-init-worktree-config.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description='test git worktree init-worktree-config'
     -+
     -+. ./test-lib.sh
     -+
     -+test_expect_success setup '
     -+	git init base &&
     -+	test_commit -C base commit &&
     -+	git -C base worktree add --detach worktree
     -+'
     -+
     -+reset_config_when_finished () {
     -+	test_when_finished git -C base config --unset core.repositoryFormatVersion &&
     -+	test_when_finished git -C base config --unset extensions.worktreeConfig &&
     -+	rm -rf base/.git/config.worktree &&
     -+	rm -rf base/.git/worktrees/worktree/config.worktree
     -+}
     -+
     -+test_expect_success 'upgrades repo format and adds extension' '
     -+	reset_config_when_finished &&
     -+	git -C base worktree init-worktree-config >out 2>err &&
     -+	test_must_be_empty out &&
     -+	test_must_be_empty err &&
     -+	test_cmp_config -C base 1 core.repositoryFormatVersion &&
     -+	test_cmp_config -C base true extensions.worktreeConfig
     -+'
     -+
     -+test_expect_success 'relocates core.worktree' '
     -+	reset_config_when_finished &&
     -+	mkdir dir &&
     -+	git -C base config core.worktree ../../dir &&
     -+	git -C base worktree init-worktree-config >out 2>err &&
     -+	test_must_be_empty out &&
     -+	test_must_be_empty err &&
     -+	test_cmp_config -C base 1 core.repositoryFormatVersion &&
     -+	test_cmp_config -C base true extensions.worktreeConfig &&
     -+	test_cmp_config -C base ../../dir core.worktree &&
     -+	test_must_fail git -C worktree core.worktree
     -+'
     -+
     -+test_expect_success 'relocates core.bare' '
     -+	reset_config_when_finished &&
     -+	git -C base config core.bare true &&
     -+	git -C base worktree init-worktree-config >out 2>err &&
     -+	test_must_be_empty out &&
     -+	test_must_be_empty err &&
     -+	test_cmp_config -C base 1 core.repositoryFormatVersion &&
     -+	test_cmp_config -C base true extensions.worktreeConfig &&
     -+	test_cmp_config -C base true core.bare &&
     -+	test_must_fail git -C worktree core.bare
     -+'
     -+
     -+test_expect_success 'skips upgrade is already upgraded' '
     -+	reset_config_when_finished &&
     -+	git -C base worktree init-worktree-config &&
     -+	git -C base config core.bare true &&
     -+
     -+	# this should be a no-op, even though core.bare
     -+	# makes the worktree be broken.
     -+	git -C base worktree init-worktree-config >out 2>err &&
     -+	test_must_be_empty out &&
     -+	test_must_be_empty err &&
     -+	test_must_fail git -C base config --worktree core.bare &&
     -+	git -C base config core.bare
     -+'
     -+
     -+test_done
     + ## worktree.h ##
     +@@ worktree.h: void strbuf_worktree_ref(const struct worktree *wt,
     + 			 struct strbuf *sb,
     + 			 const char *refname);
     + 
     ++/**
     ++ * Enable worktree config for the first time. This will make the following
     ++ * adjustments:
     ++ *
     ++ * 1. Add extensions.worktreeConfig=true in the common config file.
     ++ *
     ++ * 2. If the common config file has a core.worktree value or core.bare is
     ++ *    set to true, then those values are moved to the main worktree's
     ++ *    config.worktree file.
     ++ *
     ++ * If extensions.worktreeConfig is already true, then this method
     ++ * terminates early without any of the above steps. The existing config
     ++ * arrangement is assumed to be intentional.
     ++ *
     ++ * Returns 0 on success. Reports an error message and returns non-zero
     ++ * if any of these steps fail.
     ++ */
     ++int init_worktree_config(struct repository *r);
     ++
     + #endif
 4:  45316cd01c9 ! 3:  110d5e0546c config: add repo_config_set_worktree_gently()
     @@ config.c: int git_config_set_gently(const char *key, const char *value)
      +		free(file);
      +		return ret;
      +	}
     -+	return repo_config_set_gently(r, key, value);
     ++	return repo_config_set_multivar_gently(r, key, value, NULL, 0);
      +}
      +
       void git_config_set(const char *key, const char *value)
       {
     - 	repo_config_set(the_repository, key, value);
     -@@ config.c: int repo_config_set_multivar_gently(struct repository *r, const char *key,
     - 						      flags);
     - }
     - 
     -+int repo_config_set_gently(struct repository *r,
     -+			   const char *key, const char *value)
     -+{
     -+	return repo_config_set_multivar_gently(r, key, value, NULL, 0);
     + 	git_config_set_multivar(key, value, NULL, 0);
     +@@ config.c: void git_config_set_multivar_in_file(const char *config_filename,
     + int git_config_set_multivar_gently(const char *key, const char *value,
     + 				   const char *value_pattern, unsigned flags)
     + {
     +-	return git_config_set_multivar_in_file_gently(NULL, key, value, value_pattern,
     +-						      flags);
     ++	return repo_config_set_multivar_gently(the_repository, key, value,
     ++					       value_pattern, flags);
      +}
      +
     ++int repo_config_set_multivar_gently(struct repository *r, const char *key,
     ++				    const char *value,
     ++				    const char *value_pattern, unsigned flags)
     ++{
     ++	char *file = repo_git_path(r, "config");
     ++	int res = git_config_set_multivar_in_file_gently(file,
     ++							 key, value,
     ++							 value_pattern,
     ++							 flags);
     ++	free(file);
     ++	return res;
     + }
     + 
       void git_config_set_multivar(const char *key, const char *value,
       			     const char *value_pattern, unsigned flags)
       {
     +-	git_config_set_multivar_in_file(NULL, key, value, value_pattern,
     ++	git_config_set_multivar_in_file(git_path("config"),
     ++					key, value, value_pattern,
     + 					flags);
     + }
     + 
      
       ## config.h ##
      @@ config.h: void git_config_set_in_file(const char *, const char *, const char *);
     @@ config.h: void git_config_set_in_file(const char *, const char *, const char *);
       /**
        * write config values to `.git/config`, takes a key/value pair as parameter.
        */
     -@@ config.h: int git_config_set_multivar_gently(const char *, const char *, const char *, uns
     +@@ config.h: int git_config_parse_key(const char *, char **, size_t *);
     + 
     + int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
       void git_config_set_multivar(const char *, const char *, const char *, unsigned);
     - int repo_config_set_multivar_gently(struct repository *, const char *, const char *, const char *, unsigned);
     - void repo_config_set_multivar(struct repository *, const char *, const char *, const char *, unsigned);
     -+int repo_config_set_gently(struct repository *, const char *, const char *);
     ++int repo_config_set_multivar_gently(struct repository *, const char *, const char *, const char *, unsigned);
       int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, unsigned);
       
       /**
 5:  b200819c1bb ! 4:  fbfaa17797c sparse-checkout: use repo_config_set_worktree_gently()
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    sparse-checkout: use repo_config_set_worktree_gently()
     +    sparse-checkout: set worktree-config correctly
      
          The previous change added repo_config_set_worktree_gently() to assist
     -    writing config values into the worktree.config file, if enabled.
     +    writing config values into the config.worktree file, if enabled. An
     +    earlier change added init_worktree_config() as a helper to initialize
     +    extensions.worktreeConfig if not already enabled.
      
     -    Let the sparse-checkout builtin use this helper instead of attempting to
     +    Let the sparse-checkout builtin use these helpers instead of attempting to
          initialize the worktree config on its own. This changes behavior of 'git
          sparse-checkout set' in a few important ways:
      
     -     1. Git will no longer upgrade the repository format and add the
     -        worktree config extension. The user should run 'git worktree
     -        init-worktree-config' to enable this feature.
     +     1. Git will no longer upgrade the repository format, since this is not
     +        a requirement for understanding extensions.worktreeConfig.
      
     -     2. If worktree config is disabled, then this command will set the
     -        core.sparseCheckout (and possibly core.sparseCheckoutCone and
     -        index.sparse) values in the common config file.
     -
     -     3. If the main worktree is bare, then this command will not put the
     +     2. If the main worktree is bare, then this command will not put the
              worktree in a broken state.
      
          The main reason to use worktree-specific config for the sparse-checkout
     @@ Commit message
          sparse-checkout patterns file, then the sparse-checkout logic will not
          kick in on that worktree.
      
     -    This new logic introduces a new user pattern that could lead to some
     -    confusion. Suppose a user has not upgraded to worktree config and
     -    follows these steps in order:
     -
     -     1. Enable sparse-checkout in a worktree.
     -
     -     2. Disable sparse-checkout in that worktree without deleting that
     -        worktree's sparse-checkout file.
     -
     -     3. Enable sparse-checkout in another worktree.
     -
     -    After these steps, the first worktree will have sparse-checkout enabled
     -    with whatever patterns exist. The worktree does not immediately have
     -    those patterns applied, but a variety of Git commands would apply the
     -    sparse-checkout patterns and update the worktree state to reflect those
     -    patterns. This situation is likely very rare and the workaround is to
     -    upgrade to worktree specific config on purpose. Users already in this
     -    state used the sparse-checkout builtin with a version that upgraded to
     -    worktree config, anyway.
     -
          Reported-by: Sean Allred <allred.sean@gmail.com>
          Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     + ## Documentation/git-sparse-checkout.txt ##
     +@@ Documentation/git-sparse-checkout.txt: COMMANDS
     + 	Describe the patterns in the sparse-checkout file.
     + 
     + 'set'::
     +-	Enable the necessary config settings
     +-	(extensions.worktreeConfig, core.sparseCheckout,
     +-	core.sparseCheckoutCone) if they are not already enabled, and
     +-	write a set of patterns to the sparse-checkout file from the
     +-	list of arguments following the 'set' subcommand. Update the
     +-	working directory to match the new patterns.
     ++	Enable the necessary sparse-checkout config settings
     ++	(`core.sparseCheckout` and possibly `core.sparseCheckoutCone`) if
     ++	they are not already enabled, and write a set of patterns to the
     ++	sparse-checkout file from the list of arguments following the
     ++	'set' subcommand. Update the working directory to match the new
     ++	patterns.
     +++
     ++To ensure that adjusting the sparse-checkout settings within a worktree
     ++does not alter the sparse-checkout settings in other worktrees, the 'set'
     ++subcommand will upgrade your repository config to use worktree-specific
     ++config if not already present. The sparsity defined by the arguments to
     ++the 'set' subcommand are stored in the worktree-specific sparse-checkout
     ++file. See linkgit:git-worktree[1] and the documentation of
     ++`extensions.worktreeConfig` in linkgit:git-config[1] for more details.
     + +
     + When the `--stdin` option is provided, the patterns are read from
     + standard in as a newline-delimited list instead of from the arguments.
     +@@ Documentation/git-sparse-checkout.txt: interact with your repository until it is disabled.
     + 	By default, these patterns are read from the command-line arguments,
     + 	but they can be read from stdin using the `--stdin` option. When
     + 	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
     +-	as directory names as in the 'set' subcommand.
     ++	as directory names as in the 'set' subcommand. The sparsity defined
     ++	by the arguments to the 'add' subcommand are added to the patterns
     ++	in the worktree-specific sparse-checkout file.
     + 
     + 'reapply'::
     + 	Reapply the sparsity pattern rules to paths in the working tree.
     +
       ## builtin/sparse-checkout.c ##
     +@@
     + #include "wt-status.h"
     + #include "quote.h"
     + #include "sparse-index.h"
     ++#include "worktree.h"
     + 
     + static const char *empty_base = "";
     + 
      @@ builtin/sparse-checkout.c: enum sparse_checkout_mode {
       
       static int set_config(enum sparse_checkout_mode mode)
       {
      -	const char *config_path;
      -
     --	if (upgrade_repository_format(the_repository, 1) < 0)
     +-	if (upgrade_repository_format(1) < 0)
      -		die(_("unable to upgrade repository format to enable worktreeConfig"));
      -	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
      -		error(_("failed to set extensions.worktreeConfig setting"));
     -+	if (repo_config_set_worktree_gently(the_repository,
     -+					    "core.sparseCheckout",
     -+					    mode ? "true" : "false") ||
     -+	    repo_config_set_worktree_gently(the_repository,
     -+					    "core.sparseCheckoutCone",
     -+					    mode == MODE_CONE_PATTERNS ?
     -+						"true" : "false"))
     ++	/* Update to use worktree config, if not already. */
     ++	if (init_worktree_config(the_repository)) {
     ++		error(_("failed to initialize worktree config"));
       		return 1;
     --	}
     --
     + 	}
     + 
      -	config_path = git_path("config.worktree");
      -	git_config_set_in_file_gently(config_path,
      -				      "core.sparseCheckout",
     @@ builtin/sparse-checkout.c: enum sparse_checkout_mode {
      -	git_config_set_in_file_gently(config_path,
      -				      "core.sparseCheckoutCone",
      -				      mode == MODE_CONE_PATTERNS ? "true" : NULL);
     ++	if (repo_config_set_worktree_gently(the_repository,
     ++					    "core.sparseCheckout",
     ++					    mode ? "true" : "false") ||
     ++	    repo_config_set_worktree_gently(the_repository,
     ++					    "core.sparseCheckoutCone",
     ++					    mode == MODE_CONE_PATTERNS ?
     ++						"true" : "false"))
     ++		return 1;
       
       	if (mode == MODE_NO_PATTERNS)
      -		set_sparse_index_config(the_repository, 0);
     @@ sparse-index.c: static int convert_to_sparse_rec(struct index_state *istate,
       	return res;
      
       ## t/t1091-sparse-checkout-builtin.sh ##
     -@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'interaction with clone --no-checkout (unborn index)' '
     - '
     - 
     - test_expect_success 'set enables config' '
     --	git init empty-config &&
     -+	git init initial-config &&
     - 	(
     --		cd empty-config &&
     -+		cd initial-config &&
     -+		test_commit file file &&
     -+		mkdir dir &&
     -+		test_commit dir dir/file &&
     -+		git worktree add --detach ../initial-worktree &&
     -+		git sparse-checkout set --cone
     -+	) &&
     -+	test_cmp_config -C initial-config true core.sparseCheckout &&
     -+	test_cmp_config -C initial-worktree true core.sparseCheckout &&
     -+	test_cmp_config -C initial-config true core.sparseCheckoutCone &&
     -+	test_cmp_config -C initial-worktree true core.sparseCheckoutCone &&
     -+
     -+	# initial-config has a sparse-checkout file
     -+	# that only contains files at root.
     -+	ls initial-config >only-file &&
     -+	cat >expect <<-EOF &&
     -+	file
     -+	EOF
     -+	test_cmp expect only-file &&
     -+
     -+	# initial-worktree does not have its own sparse-checkout
     -+	# file, so the repply does not modify the worktree at all.
     -+	git -C initial-worktree sparse-checkout reapply &&
     -+	ls initial-worktree >all &&
     -+	cat >expect <<-EOF &&
     -+	dir
     -+	file
     -+	EOF
     -+	test_cmp expect all
     -+'
     -+
     -+test_expect_success 'set enables worktree config, if enabled' '
     -+	git init worktree-config &&
     -+	(
     -+		cd worktree-config &&
     - 		test_commit test file &&
     --		test_path_is_missing .git/config.worktree &&
     --		git sparse-checkout set nothing &&
     --		test_path_is_file .git/config.worktree &&
     --		test_cmp_config true core.sparseCheckout
     --	)
     -+		git worktree add --detach ../worktree-config2 &&
     -+		git worktree init-worktree-config &&
     -+		git sparse-checkout set --cone &&
     -+		git config --worktree core.sparseCheckout &&
     -+		git config --worktree core.sparseCheckoutCone
     -+	) &&
     -+	test_cmp_config -C worktree-config true core.sparseCheckout &&
     -+	test_must_fail git -C worktree-config2 core.sparseCheckout &&
     -+	test_cmp_config -C worktree-config true core.sparseCheckoutCone &&
     -+	test_must_fail git -C worktree-config2 core.sparseCheckoutCone
     - '
     - 
     - test_expect_success 'set sparse-checkout using builtin' '
     -@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'add to sparse-checkout' '
     - '
     - 
     - test_expect_success 'cone mode: match patterns' '
     -+	git -C repo worktree init-worktree-config &&
     - 	git -C repo config --worktree core.sparseCheckoutCone true &&
     - 	rm -rf repo/a repo/folder1 repo/folder2 &&
     - 	git -C repo read-tree -mu HEAD 2>err &&
     +@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'switching to cone mode with non-cone mode patterns' '
     + 		cd bad-patterns &&
     + 		git sparse-checkout init &&
     + 		git sparse-checkout add dir &&
     +-		git config core.sparseCheckoutCone true &&
     ++		git config --worktree core.sparseCheckoutCone true &&
     + 		test_must_fail git sparse-checkout add dir 2>err &&
     + 		grep "existing sparse-checkout patterns do not use cone mode" err
     + 	)
      @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'sparse-index enabled and disabled' '
     - 		test-tool -C repo read-cache --table >cache &&
     - 		! grep " tree " cache &&
     + 		test_cmp expect actual &&
     + 
       		git -C repo config --list >config &&
      -		! grep index.sparse config
      +		test_cmp_config -C repo false index.sparse
       	)
       '
       
     -@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'fail when lock is taken' '
     - '
     - 
     - test_expect_success '.gitignore should not warn about cone mode' '
     -+	git -C repo worktree init-worktree-config &&
     - 	git -C repo config --worktree core.sparseCheckoutCone true &&
     - 	echo "**/bin/*" >repo/.gitignore &&
     - 	git -C repo reset --hard 2>err &&
 6:  fcece09546c ! 5:  bb9e550ff3d worktree: copy sparse-checkout patterns and config on add
     @@ Commit message
          In addition to the sparse-checkout file, copy the worktree config file
          if worktree config is enabled and the file exists. This will copy over
          any important settings to ensure the new worktree behaves the same as
     -    the current one.
     +    the current one. The only exception we must continue to make is that
     +    core.bare and core.worktree should become unset in the worktree's config
     +    file.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
      +	}
      +
      +	/*
     -+	 * If we are using worktree config, then copy all currenct config
     ++	 * If we are using worktree config, then copy all current config
      +	 * values from the current worktree into the new one, that way the
      +	 * new worktree behaves the same as this one.
      +	 */
     @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
      +					realpath.buf, name);
      +
      +		if (file_exists(from_file)) {
     ++			struct config_set cs = { { 0 }};
     ++			const char *str_value;
     ++			int bool_value;
     ++
      +			if (safe_create_leading_directories(to_file) ||
      +			    copy_file(to_file, from_file, 0666))
     -+				error(_("failed to copy worktree config from '%s' to '%s'"),
     -+				      from_file, to_file);
     ++				die(_("failed to copy worktree config from '%s' to '%s'"),
     ++				    from_file, to_file);
     ++
     ++			git_configset_init(&cs);
     ++			git_configset_add_file(&cs, from_file);
     ++
     ++			if (!git_configset_get_bool(&cs, "core.bare", &bool_value) &&
     ++			    bool_value &&
     ++			    git_config_set_multivar_in_file_gently(
     ++					to_file, "core.bare", NULL, "true", 0))
     ++				error(_("failed to unset 'core.bare' in '%s'"), to_file);
     ++			if (!git_configset_get_value(&cs, "core.worktree", &str_value) &&
     ++			    git_config_set_in_file_gently(to_file,
     ++							  "core.worktree", NULL))
     ++				error(_("failed to unset 'core.worktree' in '%s'"), to_file);
     ++
     ++			git_configset_clear(&cs);
      +		}
      +
      +		free(from_file);
     @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
       	cp.git_cmd = 1;
      
       ## t/t1091-sparse-checkout-builtin.sh ##
     -@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'set enables config' '
     +@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'interaction with clone --no-checkout (unborn index)' '
       '
       
     - test_expect_success 'set enables worktree config, if enabled' '
     -+	git init worktree-patterns &&
     -+	(
     -+		cd worktree-patterns &&
     -+		test_commit test file &&
     -+		mkdir dir dir2 &&
     -+		test_commit dir dir/file &&
     -+		test_commit dir2 dir2/file &&
     -+
     -+		# By initializing the worktree config here...
     -+		git worktree init-worktree-config &&
     -+
     -+		# This set command places config values in worktree-
     -+		# specific config...
     -+		git sparse-checkout set --cone dir &&
     -+
     -+		# Which must be copied, along with the sparse-checkout
     -+		# patterns, here.
     -+		git worktree add --detach ../worktree-patterns2
     -+	) &&
     -+	test_cmp_config -C worktree-patterns true core.sparseCheckout &&
     -+	test_cmp_config -C worktree-patterns2 true core.sparseCheckout &&
     -+	test_cmp_config -C worktree-patterns true core.sparseCheckoutCone &&
     -+	test_cmp_config -C worktree-patterns2 true core.sparseCheckoutCone &&
     -+	test_cmp worktree-patterns/.git/info/sparse-checkout \
     -+		 worktree-patterns/.git/worktrees/worktree-patterns2/info/sparse-checkout &&
     -+
     -+	ls worktree-patterns >expect &&
     -+	ls worktree-patterns2 >actual &&
     -+	test_cmp expect actual &&
     -+
     -+	# Double check that the copy works from a non-main worktree.
     -+	(
     -+		cd worktree-patterns2 &&
     -+		git sparse-checkout set dir2 &&
     -+		git worktree add --detach ../worktree-patterns3
     -+	) &&
     -+	test_cmp_config -C worktree-patterns3 true core.sparseCheckout &&
     -+	test_cmp_config -C worktree-patterns3 true core.sparseCheckoutCone &&
     -+	test_cmp worktree-patterns/.git/worktrees/worktree-patterns2/info/sparse-checkout \
     -+		 worktree-patterns/.git/worktrees/worktree-patterns3/info/sparse-checkout &&
     -+
     -+	ls worktree-patterns2 >expect &&
     -+	ls worktree-patterns3 >actual &&
     -+	test_cmp expect actual
     + test_expect_success 'set enables config' '
     +-	git init empty-config &&
     ++	git init worktree-config &&
     + 	(
     +-		cd empty-config &&
     ++		cd worktree-config &&
     + 		test_commit test file &&
     + 		test_path_is_missing .git/config.worktree &&
     + 		git sparse-checkout set nothing &&
     +@@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'add to sparse-checkout' '
     + 	check_files repo "a folder1 folder2"
     + '
     + 
     ++test_expect_success 'worktree: add copies sparse-checkout patterns' '
     ++	cat repo/.git/info/sparse-checkout >old &&
     ++	test_when_finished cp old repo/.git/info/sparse-checkout &&
     ++	test_when_finished git -C repo worktree remove ../worktree &&
     ++	git -C repo sparse-checkout set "/*" &&
     ++	git -C repo worktree add --quiet ../worktree 2>err &&
     ++	test_must_be_empty err &&
     ++	new=repo/.git/worktrees/worktree/info/sparse-checkout &&
     ++	test_path_is_file $new &&
     ++	test_cmp repo/.git/info/sparse-checkout $new &&
     ++	git -C worktree sparse-checkout set --cone &&
     ++	test_cmp_config -C worktree true core.sparseCheckoutCone &&
     ++	test_must_fail git -C repo core.sparseCheckoutCone
      +'
      +
     -+test_expect_success 'worktree add copies sparse-checkout patterns' '
     - 	git init worktree-config &&
     - 	(
     - 		cd worktree-config &&
     + test_expect_success 'cone mode: match patterns' '
     + 	git -C repo config --worktree core.sparseCheckoutCone true &&
     + 	rm -rf repo/a repo/folder1 repo/folder2 &&
      @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'interaction with submodules' '
     + '
       
       test_expect_success 'different sparse-checkouts with worktrees' '
     ++	git -C repo sparse-checkout set --cone deep folder1 &&
       	git -C repo worktree add --detach ../worktree &&
      -	check_files worktree "a deep folder1 folder2" &&
     -+	check_files worktree "a folder1" &&
     - 	git -C worktree sparse-checkout init --cone &&
     +-	git -C worktree sparse-checkout init --cone &&
      -	git -C repo sparse-checkout set folder1 &&
     -+	git -C repo sparse-checkout set folder1 folder2 &&
     - 	git -C worktree sparse-checkout set deep/deeper1 &&
     +-	git -C worktree sparse-checkout set deep/deeper1 &&
      -	check_files repo a folder1 &&
     -+	check_files repo a folder1 folder2 &&
     - 	check_files worktree a deep
     +-	check_files worktree a deep
     ++	check_files worktree "a deep folder1" &&
     ++	git -C repo sparse-checkout set --cone folder1 &&
     ++	git -C worktree sparse-checkout set --cone deep/deeper1 &&
     ++	check_files repo "a folder1" &&
     ++	check_files worktree "a deep"
     + '
     + 
     + test_expect_success 'set using filename keeps file on-disk' '
     +
     + ## t/t2400-worktree-add.sh ##
     +@@ t/t2400-worktree-add.sh: test_expect_success '"add" default branch of a bare repo' '
     + 	(
     + 		git clone --bare . bare2 &&
     + 		cd bare2 &&
     +-		git worktree add ../there3 main
     +-	)
     ++		git worktree add ../there3 main &&
     ++		cd ../there3 &&
     ++		git status
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	init.t
     ++	EOF
     ++	ls there3 >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success '"add" to bare repo with worktree config' '
     ++	(
     ++		git clone --bare . bare3 &&
     ++		cd bare3 &&
     ++		git config extensions.worktreeconfig true &&
     ++		git config --worktree core.bare true &&
     ++		git config --worktree core.worktree "$(pwd)" &&
     ++		git config --worktree bogus.key value &&
     ++		git config --unset core.bare &&
     ++		git worktree add ../there4 main &&
     ++		cd ../there4 &&
     ++		git status &&
     ++		git worktree add --detach ../there5 &&
     ++		cd ../there5 &&
     ++		git status
     ++	) &&
     ++
     ++	# the worktree has the arbitrary value copied.
     ++	test_cmp_config -C there4 value bogus.key &&
     ++	test_cmp_config -C there5 value bogus.key &&
     ++
     ++	# however, core.bare and core.worktree were removed.
     ++	test_must_fail git -C there4 config core.bare &&
     ++	test_must_fail git -C there4 config core.worktree &&
     ++
     ++	cat >expect <<-EOF &&
     ++	init.t
     ++	EOF
     ++
     ++	ls there4 >actual &&
     ++	test_cmp expect actual &&
     ++	ls there5 >actual &&
     ++	test_cmp expect actual
       '
       
     + test_expect_success 'checkout with grafts' '

-- 
gitgitgadget
