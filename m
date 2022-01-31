Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C14C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 15:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349275AbiAaPBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 10:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349242AbiAaPBC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 10:01:02 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E48C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 07:01:02 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n12-20020a05600c3b8c00b0034eb13edb8eso55278wms.0
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 07:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yyy7TOjsZDdzkZmfzFEf41RIXTFNpDu/6AJY1Cy4618=;
        b=Sjtt+TKjQgidTRABipXx6hU4sNb1uDkFbHeZFTqW+NRlbM4UYLr/P1y/CYyHiK165Q
         HjfNgsh3YE6pcw6ZV7w4toqLtRylYzkOnN2h4pJml4oxhkEDBQ8NxbBl3PHc3eoTnH8x
         ZXKAA8tZHjlhU+DOoIy+gLGf1B0nNfu/Dk/uQjSLnW9QY7hqt3Nf3a1ncK2qPjT9l3wx
         XWsuEcS20ihTIME8yjLh8HbC1ishPoPl+PJQid29OmKHn9ni7f2a4m5A3vUi9KbC5qYQ
         Yw7d1dloxokdRObzjFfulKhbgBYVmOZF1AcXmRVM0fQc/SiyTUqM1spbiFtErc4auHs2
         M9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yyy7TOjsZDdzkZmfzFEf41RIXTFNpDu/6AJY1Cy4618=;
        b=EoqHey+o50gvsGkok8Y5JL4yZuu93QTOI5t7QcmYpG7iWTIFEXolVDQ+gm3JlrZaPp
         66QbMl0eIo5ZH0EygHN15boJ2J0LvukRi+dubTMENr89xtissmmc5gGCWAXF6xT0EGy5
         FxyqEqrbww31v8VUZg4G0NvPT8tyTz1C8o8DxFRt6wBlJLvhdUWEXc3Lq4pGs3LxfnVK
         G8FrT4WyGNG3HIyni6vTjWR3/67nphgpBJIAZ7JJixboVq4sVa3VtRWiCO1RICVR9SGX
         usavcJeT9ROAlWLLgHSJ96U+UGX6IKJcE5mXYJ/doGF7W7LXxWEZXSWG5jqrsRwzFnmR
         y7lw==
X-Gm-Message-State: AOAM533yyG9bs4JQb1cUmB98QOYmbTIqdHlTpeHtywGUHFwr7GNRuzvr
        2FAXUuN4qeFH4S7ByhPTrzL8XPbusug=
X-Google-Smtp-Source: ABdhPJx6PHS+fXhLgDrNn6P56t9V6pt3AjaZRisAiQnbvOn1gKNB2ppq+cz7EzzhsJRIcHpzEUyM3A==
X-Received: by 2002:a05:600c:4ed3:: with SMTP id g19mr9160263wmq.186.1643641260683;
        Mon, 31 Jan 2022 07:01:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4sm13573433wrd.111.2022.01.31.07.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 07:01:00 -0800 (PST)
Message-Id: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 Jan 2022 15:00:54 +0000
Subject: [PATCH v5 0/5] Sparse checkout: fix bug with worktree of bare repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
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


Updates in v5
=============

 * Cleaned up documentation as per Elijah's suggestions.
 * Removed unnecessary conflicting change in git-sparse-checkout.txt
 * Fixed an ambiguous comment about moving config values.


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
 Documentation/git-sparse-checkout.txt | 16 ++++--
 Documentation/git-worktree.txt        | 11 +++--
 builtin/sparse-checkout.c             | 28 +++++------
 builtin/worktree.c                    | 60 +++++++++++++++++++++++
 config.c                              | 35 ++++++++++++--
 config.h                              |  8 +++
 sparse-index.c                        | 10 ++--
 t/t1091-sparse-checkout-builtin.sh    | 35 ++++++++++----
 t/t2400-worktree-add.sh               | 46 +++++++++++++++++-
 worktree.c                            | 70 +++++++++++++++++++++++++++
 worktree.h                            | 21 ++++++++
 13 files changed, 333 insertions(+), 46 deletions(-)


base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1101%2Fderrickstolee%2Fsparse-checkout%2Fbare-worktree-bug-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1101/derrickstolee/sparse-checkout/bare-worktree-bug-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1101

Range-diff vs v4:

 1:  459e09dedd7 ! 1:  1bd5f26271c Documentation: add extensions.worktreeConfig details
     @@ Commit message
          within git-sparse-checkout.txt, but a behavior change is needed before
          making those updates.
      
     +    Helped-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/config/extensions.txt ##
     @@ Documentation/git-config.txt: from all available files.
      -	present. If not it's the same as `--local`.
      +	enabled. If not it's the same as `--local`. Note that `$GIT_DIR`
      +	is equal to `$GIT_COMMON_DIR` for the main worktree, but is of the
     -+	form `.git/worktrees/<worktree-name>/` for other worktrees. See
     ++	form `$GIT_DIR/worktrees/<worktree-name>/` for other worktrees. See
      +	linkgit:git-worktree[1] to learn how to enable
      +	`extensions.worktreeConfig`.
       
     @@ Documentation/git-worktree.txt: CONFIGURATION FILE
      -already present in the config file, they will be applied to the main
      -working trees only.
      +present in the common config file and `extensions.worktreeConfig` is
     -+disabled, then they will be applied to the main working trees only.
     ++disabled, then they will be applied to the main working tree only.
       
       In order to have configuration specific to working trees, you can turn
       on the `worktreeConfig` extension, e.g.:
     @@ Documentation/git-worktree.txt: them to the `config.worktree` of the main workin
      - - `core.worktree` and `core.bare` should never be shared
      + - `core.worktree` should never be shared.
      +
     -+ - `core.bare` should not be shared unless the value is `core.bare=false`.
     ++ - `core.bare` should not be shared if the value is `core.bare=true`.
       
        - `core.sparseCheckout` is recommended per working tree, unless you
          are sure you always use sparse checkout for all working trees.
 2:  d262a76b448 ! 2:  2a2c350112e worktree: create init_worktree_config()
     @@ worktree.h: void strbuf_worktree_ref(const struct worktree *wt,
      + *
      + * 1. Add extensions.worktreeConfig=true in the common config file.
      + *
     -+ * 2. If the common config file has a core.worktree value or core.bare is
     -+ *    set to true, then those values are moved to the main worktree's
     -+ *    config.worktree file.
     ++ * 2. If the common config file has a core.worktree value, then that value
     ++ *    is moved to the main worktree's config.worktree file.
     ++ *
     ++ * 3. If the common config file has a core.bare enabled, then that value
     ++ *    is moved to the main worktree's config.worktree file.
      + *
      + * If extensions.worktreeConfig is already true, then this method
      + * terminates early without any of the above steps. The existing config
 3:  110d5e0546c = 3:  802b28a9510 config: add repo_config_set_worktree_gently()
 4:  fbfaa17797c ! 4:  08b89d17ccf sparse-checkout: set worktree-config correctly
     @@ Documentation/git-sparse-checkout.txt: COMMANDS
      -	(extensions.worktreeConfig, core.sparseCheckout,
      -	core.sparseCheckoutCone) if they are not already enabled, and
      -	write a set of patterns to the sparse-checkout file from the
     --	list of arguments following the 'set' subcommand. Update the
     --	working directory to match the new patterns.
      +	Enable the necessary sparse-checkout config settings
     -+	(`core.sparseCheckout` and possibly `core.sparseCheckoutCone`) if
     -+	they are not already enabled, and write a set of patterns to the
     -+	sparse-checkout file from the list of arguments following the
     -+	'set' subcommand. Update the working directory to match the new
     -+	patterns.
     -++
     ++	(`core.sparseCheckout`, `core.sparseCheckoutCone`, and
     ++	`index.sparse`) if they are not already set to the desired values,
     ++	and write a set of patterns to the sparse-checkout file from the
     + 	list of arguments following the 'set' subcommand. Update the
     + 	working directory to match the new patterns.
     + +
      +To ensure that adjusting the sparse-checkout settings within a worktree
      +does not alter the sparse-checkout settings in other worktrees, the 'set'
      +subcommand will upgrade your repository config to use worktree-specific
     @@ Documentation/git-sparse-checkout.txt: COMMANDS
      +the 'set' subcommand are stored in the worktree-specific sparse-checkout
      +file. See linkgit:git-worktree[1] and the documentation of
      +`extensions.worktreeConfig` in linkgit:git-config[1] for more details.
     - +
     +++
       When the `--stdin` option is provided, the patterns are read from
       standard in as a newline-delimited list instead of from the arguments.
     -@@ Documentation/git-sparse-checkout.txt: interact with your repository until it is disabled.
     - 	By default, these patterns are read from the command-line arguments,
     - 	but they can be read from stdin using the `--stdin` option. When
     - 	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
     --	as directory names as in the 'set' subcommand.
     -+	as directory names as in the 'set' subcommand. The sparsity defined
     -+	by the arguments to the 'add' subcommand are added to the patterns
     -+	in the worktree-specific sparse-checkout file.
     - 
     - 'reapply'::
     - 	Reapply the sparsity pattern rules to paths in the working tree.
     + +
      
       ## builtin/sparse-checkout.c ##
      @@
 5:  bb9e550ff3d ! 5:  85779dfaed3 worktree: copy sparse-checkout patterns and config on add
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'add to sparse-checkout'
      +	cat repo/.git/info/sparse-checkout >old &&
      +	test_when_finished cp old repo/.git/info/sparse-checkout &&
      +	test_when_finished git -C repo worktree remove ../worktree &&
     -+	git -C repo sparse-checkout set "/*" &&
     ++	git -C repo sparse-checkout set --no-cone "/*" &&
      +	git -C repo worktree add --quiet ../worktree 2>err &&
      +	test_must_be_empty err &&
      +	new=repo/.git/worktrees/worktree/info/sparse-checkout &&

-- 
gitgitgadget
