Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747C0C433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 21:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbiBGVdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbiBGVdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 16:33:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5674BC061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 13:33:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s18so27161075wrv.7
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 13:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qAYUoFhWp7qQooCwtTGQEDemYmY19ONz/eY+dPwSggI=;
        b=A7dLa9PLmknc4gijrXTecKF0ByPzCF4IA0JzHcGPp5jocU1LcqD226pap+6rOHvffN
         K8XnPl036DV+5F5rxZZc2VFjwf2EWUELnxT8xt5zGN2yeTaXKNjppOqnaoGN5VxFPBet
         amAQIwcmz4JaDwX4pLFOiD+zqUhkGe/2Fy9/8tjz9ESBRXERJQpwg1hK+R2dDqEXA6MY
         GOXjYqgQRsi/OYDbTAMdPHHKhEWDoPMqhx4nTF+IzE7VOUwTtrdAiIXKQsf4aGEy6+nt
         KKWsjzPj8KNS865sCKN73pGg8HBe0n+QLail/DqraCSnhWjnw7aMHHObGCq0n8mhEGN1
         ts3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qAYUoFhWp7qQooCwtTGQEDemYmY19ONz/eY+dPwSggI=;
        b=u5MKpXYoxKbOEM3+fdK9tt7bHx1ty0CHELXpUtO4FbEm73ZhCpOq6fxqL2LTjfyY/a
         He4pLOK2178ppvKjv3bUa292jkHdMkS5OdXko2ghjBh6zd+vYJ4wxg1hcGPax6Gt3snf
         jhtUGimhzjhq8J8e97hs8OsfH1Y7wIp6oL7RAEVRnJoL1/MY8r2eLQAXhWxUqaeJuAG8
         c6+++T3WCOQubWeDjg7+jRAVGTy+bNqu7SVf/hVX5DYniEEDJqiWIDAzKETtfi7WwaB1
         HGejHVXfd0BLm5T885iZ8j++k2SkZsGwhzX3SPufUcb5sbyXmkxUs+/S2rNOHbnFPIBF
         yUgA==
X-Gm-Message-State: AOAM5310oeqrZ2CtgpLexbPCqkWQQ58zlV9rNUU/I0gk3qrqJVq3li8h
        aRq4rBeg0wBpLXy/qgy8FBUZdzLNFKA=
X-Google-Smtp-Source: ABdhPJw79ax0W/zYQm6KZ0kZ20BEimIAenCGdLQ6A357yvUvBzlcCUXi1b5DmFkpuekWeVkphxuc8w==
X-Received: by 2002:adf:a343:: with SMTP id d3mr1039365wrb.356.1644269585372;
        Mon, 07 Feb 2022 13:33:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm12978494wry.79.2022.02.07.13.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:33:04 -0800 (PST)
Message-Id: <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 21:32:57 +0000
Subject: [PATCH v6 0/6] Sparse checkout: fix bug with worktree of bare repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        derrickstolee@github.com, Derrick Stolee <derrickstolee@github.com>
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


Updates in v6
=============

 * Updated documentation to use "working tree" over "worktree" and "" over
   ""
 * Delay some allocations to avoid leaking memory in error conditions.
 * Use "main worktree" over "base worktree" in comments.
 * 


Updates in v5
=============

Responded to most of Eric's suggestions. I pushed back on one about a
comment including information from the commit message, but everything else
should be as Eric suggested.

 * Cleaned up documentation as per Elijah's suggestions.
 * Removed unnecessary conflicting change in git-sparse-checkout.txt
 * Fixed an ambiguous comment about moving config values.
 * Removed use of git_configset_get_string_tmp() and added a patch that
   removes its public declaration.
 * Fragile variables are replaced with better ones.
 * Variable names and code style improved.
 * Several test cleanups in patch 5.


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

Derrick Stolee (6):
  Documentation: add extensions.worktreeConfig details
  worktree: create init_worktree_config()
  config: add repo_config_set_worktree_gently()
  sparse-checkout: set worktree-config correctly
  worktree: copy sparse-checkout patterns and config on add
  config: make git_configset_get_string_tmp() private

 Documentation/config/extensions.txt   | 31 ++++++++++++
 Documentation/git-config.txt          |  8 ++-
 Documentation/git-sparse-checkout.txt | 16 ++++--
 Documentation/git-worktree.txt        | 11 ++--
 builtin/sparse-checkout.c             | 28 +++++-----
 builtin/worktree.c                    | 63 +++++++++++++++++++++++
 config.c                              | 39 ++++++++++++--
 config.h                              |  9 +++-
 sparse-index.c                        | 10 ++--
 t/t1091-sparse-checkout-builtin.sh    | 35 +++++++++----
 t/t2400-worktree-add.sh               | 58 ++++++++++++++++++++-
 worktree.c                            | 73 +++++++++++++++++++++++++++
 worktree.h                            | 21 ++++++++
 13 files changed, 353 insertions(+), 49 deletions(-)


base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1101%2Fderrickstolee%2Fsparse-checkout%2Fbare-worktree-bug-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1101/derrickstolee/sparse-checkout/bare-worktree-bug-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1101

Range-diff vs v5:

 1:  1bd5f26271c ! 1:  0260ff6cac0 Documentation: add extensions.worktreeConfig details
     @@ Documentation/config/extensions.txt: extensions.objectFormat::
      +	If enabled, then worktrees will load config settings from the
      +	`$GIT_DIR/config.worktree` file in addition to the
      +	`$GIT_COMMON_DIR/config` file. Note that `$GIT_COMMON_DIR` and
     -+	`$GIT_DIR` are the same for the main worktree, while other
     -+	worktrees have `$GIT_DIR` equal to
     -+	`$GIT_COMMON_DIR/worktrees/<worktree-name>/`. The settings in the
     ++	`$GIT_DIR` are the same for the main working tree, while other
     ++	working trees have `$GIT_DIR` equal to
     ++	`$GIT_COMMON_DIR/worktrees/<id>/`. The settings in the
      +	`config.worktree` file will override settings from any other
      +	config files.
      ++
      +When enabling `extensions.worktreeConfig`, you must be careful to move
     -+certain values from the common config file to the main worktree's
     ++certain values from the common config file to the main working tree's
      +`config.worktree` file, if present:
      ++
      +* `core.worktree` must be moved from `$GIT_COMMON_DIR/config` to
     @@ Documentation/git-config.txt: from all available files.
       	read from or written to if `extensions.worktreeConfig` is
      -	present. If not it's the same as `--local`.
      +	enabled. If not it's the same as `--local`. Note that `$GIT_DIR`
     -+	is equal to `$GIT_COMMON_DIR` for the main worktree, but is of the
     -+	form `$GIT_DIR/worktrees/<worktree-name>/` for other worktrees. See
     ++	is equal to `$GIT_COMMON_DIR` for the main working tree, but is of
     ++	the form `$GIT_DIR/worktrees/<id>/` for other working trees. See
      +	linkgit:git-worktree[1] to learn how to enable
      +	`extensions.worktreeConfig`.
       
 2:  2a2c350112e ! 2:  5d0cc242d92 worktree: create init_worktree_config()
     @@ worktree.c: int should_prune_worktree(const char *id, struct strbuf *reason, cha
      +	int bare = 0;
      +	struct config_set cs = { { 0 } };
      +	const char *core_worktree;
     -+	char *common_config_file = xstrfmt("%s/config", r->commondir);
     -+	char *main_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
     ++	char *common_config_file;
     ++	char *main_worktree_file;
      +
      +	/*
      +	 * If the extension is already enabled, then we can skip the
     @@ worktree.c: int should_prune_worktree(const char *id, struct strbuf *reason, cha
      +	if ((res = git_config_set_gently("extensions.worktreeConfig", "true")))
      +		return error(_("failed to set extensions.worktreeConfig setting"));
      +
     ++	common_config_file = xstrfmt("%s/config", r->commondir);
     ++	main_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
     ++
      +	git_configset_init(&cs);
      +	git_configset_add_file(&cs, common_config_file);
      +
      +	/*
      +	 * If core.bare is true in the common config file, then we need to
     -+	 * move it to the base worktree's config file or it will break all
     ++	 * move it to the main worktree's config file or it will break all
      +	 * worktrees. If it is false, then leave it in place because it
      +	 * _could_ be negating a global core.bare=true.
      +	 */
     @@ worktree.c: int should_prune_worktree(const char *id, struct strbuf *reason, cha
      +			goto cleanup;
      +	}
      +	/*
     -+	 * If core.worktree is set, then the base worktree is located
     ++	 * If core.worktree is set, then the main worktree is located
      +	 * somewhere different than the parent of the common Git dir.
      +	 * Relocate that value to avoid breaking all worktrees with this
      +	 * upgrade to worktree config.
      +	 */
     -+	if (!git_configset_get_string_tmp(&cs, "core.worktree", &core_worktree)) {
     ++	if (!git_configset_get_value(&cs, "core.worktree", &core_worktree)) {
      +		if ((res = move_config_setting("core.worktree", core_worktree,
      +					       common_config_file,
      +					       main_worktree_file)))
 3:  802b28a9510 = 3:  cf9e86fe3a4 config: add repo_config_set_worktree_gently()
 4:  08b89d17ccf ! 4:  5b5924eab49 sparse-checkout: set worktree-config correctly
     @@ Metadata
       ## Commit message ##
          sparse-checkout: set worktree-config correctly
      
     -    The previous change added repo_config_set_worktree_gently() to assist
     -    writing config values into the config.worktree file, if enabled. An
     -    earlier change added init_worktree_config() as a helper to initialize
     -    extensions.worktreeConfig if not already enabled.
     +    `git sparse-checkout set/init` enables worktree-specific
     +    configuration[*] by setting extensions.worktreeConfig=true, but neglects
     +    to perform the additional necessary bookkeeping of relocating
     +    `core.bare=true` and `core.worktree` from $GIT_COMMON_DIR/config to
     +    $GIT_COMMON_DIR/config.worktree, as documented in git-worktree.txt. As a
     +    result of this oversight, these settings, which are nonsensical for
     +    secondary worktrees, can cause Git commands to incorrectly consider a
     +    worktree bare (in the case of `core.bare`) or operate on the wrong
     +    worktree (in the case of `core.worktree`). Fix this problem by taking
     +    advantage of the recently-added init_worktree_config() which enables
     +    `extensions.worktreeConfig` and takes care of necessary bookkeeping.
      
     -    Let the sparse-checkout builtin use these helpers instead of attempting to
     -    initialize the worktree config on its own. This changes behavior of 'git
     -    sparse-checkout set' in a few important ways:
     +    While at it, for backward-compatibility reasons, also stop upgrading the
     +    repository format to "1" since doing so is (unintentionally) not
     +    required to take advantage of `extensions.worktreeConfig`, as explained
     +    by 11664196ac ("Revert "check_repository_format_gently(): refuse
     +    extensions for old repositories"", 2020-07-15).
      
     -     1. Git will no longer upgrade the repository format, since this is not
     -        a requirement for understanding extensions.worktreeConfig.
     -
     -     2. If the main worktree is bare, then this command will not put the
     -        worktree in a broken state.
     -
     -    The main reason to use worktree-specific config for the sparse-checkout
     -    builtin was to avoid enabling sparse-checkout patterns in one and
     -    causing a loss of files in another. If a worktree does not have a
     -    sparse-checkout patterns file, then the sparse-checkout logic will not
     -    kick in on that worktree.
     +    [*] The main reason to use worktree-specific config for the
     +    sparse-checkout builtin was to avoid enabling sparse-checkout patterns
     +    in one and causing a loss of files in another. If a worktree does not
     +    have a sparse-checkout patterns file, then the sparse-checkout logic
     +    will not kick in on that worktree.
      
          Reported-by: Sean Allred <allred.sean@gmail.com>
          Helped-by: Eric Sunshine <sunshine@sunshineco.com>
 5:  85779dfaed3 ! 5:  c51cb3714e7 worktree: copy sparse-checkout patterns and config on add
     @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
      +	 */
      +	if (core_apply_sparse_checkout) {
      +		char *from_file = git_pathdup("info/sparse-checkout");
     -+		char *to_file = xstrfmt("%s/worktrees/%s/info/sparse-checkout",
     -+					realpath.buf, name);
     ++		char *to_file = xstrfmt("%s/info/sparse-checkout",
     ++					sb_repo.buf);
      +
      +		if (file_exists(from_file)) {
      +			if (safe_create_leading_directories(to_file) ||
     @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
      +	 */
      +	if (repository_format_worktree_config) {
      +		char *from_file = git_pathdup("config.worktree");
     -+		char *to_file = xstrfmt("%s/worktrees/%s/config.worktree",
     -+					realpath.buf, name);
     ++		char *to_file = xstrfmt("%s/config.worktree",
     ++					sb_repo.buf);
      +
      +		if (file_exists(from_file)) {
     -+			struct config_set cs = { { 0 }};
     -+			const char *str_value;
     -+			int bool_value;
     ++			struct config_set cs = { { 0 } };
     ++			const char *core_worktree;
     ++			int bare;
      +
      +			if (safe_create_leading_directories(to_file) ||
     -+			    copy_file(to_file, from_file, 0666))
     -+				die(_("failed to copy worktree config from '%s' to '%s'"),
     -+				    from_file, to_file);
     ++			    copy_file(to_file, from_file, 0666)) {
     ++				error(_("failed to copy worktree config from '%s' to '%s'"),
     ++				      from_file, to_file);
     ++				goto worktree_copy_cleanup;
     ++			}
      +
      +			git_configset_init(&cs);
      +			git_configset_add_file(&cs, from_file);
      +
     -+			if (!git_configset_get_bool(&cs, "core.bare", &bool_value) &&
     -+			    bool_value &&
     ++			if (!git_configset_get_bool(&cs, "core.bare", &bare) &&
     ++			    bare &&
      +			    git_config_set_multivar_in_file_gently(
      +					to_file, "core.bare", NULL, "true", 0))
      +				error(_("failed to unset 'core.bare' in '%s'"), to_file);
     -+			if (!git_configset_get_value(&cs, "core.worktree", &str_value) &&
     ++			if (!git_configset_get_value(&cs, "core.worktree", &core_worktree) &&
      +			    git_config_set_in_file_gently(to_file,
      +							  "core.worktree", NULL))
      +				error(_("failed to unset 'core.worktree' in '%s'"), to_file);
     @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
      +			git_configset_clear(&cs);
      +		}
      +
     ++worktree_copy_cleanup:
      +		free(from_file);
      +		free(to_file);
      +	}
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'add to sparse-checkout'
      +	git -C repo sparse-checkout set --no-cone "/*" &&
      +	git -C repo worktree add --quiet ../worktree 2>err &&
      +	test_must_be_empty err &&
     -+	new=repo/.git/worktrees/worktree/info/sparse-checkout &&
     -+	test_path_is_file $new &&
     -+	test_cmp repo/.git/info/sparse-checkout $new &&
     ++	new="$(git -C worktree rev-parse --git-path info/sparse-checkout)" &&
     ++	test_path_is_file "$new" &&
     ++	test_cmp repo/.git/info/sparse-checkout "$new" &&
      +	git -C worktree sparse-checkout set --cone &&
      +	test_cmp_config -C worktree true core.sparseCheckoutCone &&
      +	test_must_fail git -C repo core.sparseCheckoutCone
     @@ t/t2400-worktree-add.sh: test_expect_success '"add" default branch of a bare rep
      -	)
      +		git worktree add ../there3 main &&
      +		cd ../there3 &&
     ++		# Simple check that a Git command does not
     ++		# immediately fail with the current setup
      +		git status
      +	) &&
      +	cat >expect <<-EOF &&
     @@ t/t2400-worktree-add.sh: test_expect_success '"add" default branch of a bare rep
      +		git clone --bare . bare3 &&
      +		cd bare3 &&
      +		git config extensions.worktreeconfig true &&
     ++
     ++		# Add config values that are erroneous to have in
     ++		# a config.worktree file outside of the main
     ++		# working tree, to check that Git filters them out
     ++		# when copying config during "git worktree add".
      +		git config --worktree core.bare true &&
      +		git config --worktree core.worktree "$(pwd)" &&
     ++
     ++		# We want to check that bogus.key is copied
      +		git config --worktree bogus.key value &&
      +		git config --unset core.bare &&
      +		git worktree add ../there4 main &&
      +		cd ../there4 &&
     ++
     ++		# Simple check that a Git command does not
     ++		# immediately fail with the current setup
      +		git status &&
      +		git worktree add --detach ../there5 &&
      +		cd ../there5 &&
 -:  ----------- > 6:  f687a0bfa16 config: make git_configset_get_string_tmp() private

-- 
gitgitgadget
