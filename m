Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3347C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 19:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhLUTOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 14:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbhLUTOL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 14:14:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBA3C06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:14:10 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so2396802wmj.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TuG11DmpSE7aioKZmq7jrFFt/YBKu+hLPG6DGFDGwv0=;
        b=jITtPF48buxdcf5crK8CrFNc+nSEUL/yspSpFz0jEqVhiK402Mij4oN0NF7yFvKu+w
         5K1NE5oHwLqFVU/bq0SqLCQl9c0Cd05fwabPX+g8pN584ZmnnQcidb9cE1huOXQmZa/4
         BNCoQhGEShMDpHPNy6wvj5VqWgXe1O3sWdd7fbaFzmIlYljb2ZWO9n2ti6buv6d3sFgT
         oF0A7UvvJ7EiHwyCvT+Kk5J03HmLyCPp8q0TwunEKf4/pF7mIXYgJgI754CfQUSTFQDc
         4UoG9oBh9bV5nrSxCNDqh1CQMyEmLJYBGpL4vL6TCTRPeL2YSjCkcsXa3wkOJ4FBiJk+
         9lgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TuG11DmpSE7aioKZmq7jrFFt/YBKu+hLPG6DGFDGwv0=;
        b=TwpEb34hLx/Ga/aU9cWRBSWv6nJ+Pu/UAX5aC84GmE/RXyLGDGtoutDhQV7hrsCnzz
         6LqSPYy/hgVGfAqh/1BUKhgs3tjfZSezXNT84X53hVsXj0rOlqcVeMNDfI5R5sVWItkd
         8p7VolVM7PE754A81HMhFKdHvXAQk/f2PzUg/5r44hItMdwpkPnXUBvR7UTVh8OoKN1/
         tjhfGl9n6dym/TdQU1nKAJB+Sw3POkWHd3vDqLTNUAPKD5lnMe0On9CSQsY7EugSkCM8
         VrBfOo2T5A3qMWdPdH4RDUn6s93SjnT/oyqW7kZs+M8+UCgQEf7uvZztmyC96nVldn3s
         bGOQ==
X-Gm-Message-State: AOAM5301mQWGw31POzAQRHKYFtoodT/xkyNBHqzbLhNl7bHomVNnoTrG
        qFf3rrPW/ed062eTIXZrdLOwpPiVQOE=
X-Google-Smtp-Source: ABdhPJxTWsuJI6ARr/q2QmtIbQFnhrUU47FXtsRFVK5Dt54aTrOthpTDcdpPtffo4yq3owF3OMSOnw==
X-Received: by 2002:a05:600c:4e8f:: with SMTP id f15mr3880569wmq.151.1640114049291;
        Tue, 21 Dec 2021 11:14:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm496112wrz.78.2021.12.21.11.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 11:14:08 -0800 (PST)
Message-Id: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 19:14:03 +0000
Subject: [PATCH v2 0/5] Sparse checkout: fix bug with worktree of bare repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

The critical bits are in Patches 3, 4, and 5 which introduce a helper for
upgrading to worktree config, a helper to write to worktree config, and then
consume that config helper in builtin/sparse-checkout.c and sparse-index.c.

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

Derrick Stolee (5):
  setup: use a repository when upgrading format
  config: make some helpers repo-aware
  worktree: add upgrade_to_worktree_config()
  config: add repo_config_set_worktree_gently()
  sparse-checkout: use repo_config_set_worktree_gently()

 builtin/sparse-checkout.c          | 25 +++++-----------
 config.c                           | 39 +++++++++++++++++++++++--
 config.h                           | 14 +++++++++
 list-objects-filter-options.c      |  2 +-
 repository.h                       |  2 +-
 setup.c                            |  6 ++--
 sparse-index.c                     | 10 ++-----
 t/t1091-sparse-checkout-builtin.sh | 16 +++++++++-
 worktree.c                         | 47 ++++++++++++++++++++++++++++++
 worktree.h                         | 12 ++++++++
 10 files changed, 140 insertions(+), 33 deletions(-)


base-commit: 69a9c10c95e28df457e33b3c7400b16caf2e2962
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1101%2Fderrickstolee%2Fsparse-checkout%2Fbare-worktree-bug-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1101/derrickstolee/sparse-checkout/bare-worktree-bug-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1101

Range-diff vs v1:

 1:  28813703ff6 = 1:  889e69dc45d setup: use a repository when upgrading format
 2:  3b549770eb9 = 2:  3e01356815a config: make some helpers repo-aware
 -:  ----------- > 3:  ed8e2a7b19d worktree: add upgrade_to_worktree_config()
 3:  67993f6cff2 ! 4:  22896e9bb04 config: add repo_config_set_worktree_gently()
     @@ Metadata
       ## Commit message ##
          config: add repo_config_set_worktree_gently()
      
     -    When adding config values to the worktree config, we might enable the
     -    extensions.worktreeConfig setting and create the config.worktree file
     -    for the first time. When the base repository is bare, this creates a
     -    change of behavior for determining if the worktree is bare or not. A
     -    worktree off of a bare repository is assumed to be non-bare when
     -    extensions.worktreeConfig is disabled. When extensions.worktreeConfig is
     -    enabled but config.worktree is empty, the worktree is considered bare
     -    because the base repo's core.bare=true setting is used.
     +    The previous change added upgrade_to_worktree_config() to assist
     +    creating a worktree-specific config for the first time. However, this
     +    requires every config writer to care about that upgrade before writing
     +    to the worktree-specific config. In addition, callers need to know how
     +    to generate the name of the config.worktree file and pass it to the
     +    config API.
      
     -    To avoid issues like this, create a helper that initializes all the
     -    right settings in the correct order. A caller will be added in the next
     -    change.
     +    To assist, create a new repo_config_set_worktree_gently() method in the
     +    config API that handles the upgrade_to_worktree_config() method in
     +    addition to assigning the value in the worktree-specific config. This
     +    will be consumed by an upcoming change.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## config.c ##
     +@@
     + #include "dir.h"
     + #include "color.h"
     + #include "refs.h"
     ++#include "worktree.h"
     + 
     + struct config_source {
     + 	struct config_source *prev;
      @@ config.c: int git_config_set_gently(const char *key, const char *value)
       	return git_config_set_multivar_gently(key, value, NULL, 0);
       }
     @@ config.c: int git_config_set_gently(const char *key, const char *value)
      +int repo_config_set_worktree_gently(struct repository *r,
      +				    const char *key, const char *value)
      +{
     -+	int res;
     -+	const char *config_filename = repo_git_path(r, "config.worktree");
     -+
     -+	/*
     -+	 * Ensure that core.bare reflects the current worktree, since the
     -+	 * logic for is_bare_repository() changes if extensions.worktreeConfig
     -+	 * is disabled.
     -+	 */
     -+	if ((res = git_config_set_multivar_in_file_gently(config_filename, "core.bare",
     -+							  r->worktree ? "false" : "true",
     -+							  NULL, 0))) {
     -+		error(_("unable to set core.bare setting in worktree config"));
     -+		return res;
     -+	}
     -+	if (upgrade_repository_format(r, 1) < 0)
     -+		return error(_("unable to upgrade repository format to enable worktreeConfig"));
     -+	if ((res = git_config_set_gently("extensions.worktreeConfig", "true"))) {
     -+		error(_("failed to set extensions.worktreeConfig setting"));
     -+		return res;
     -+	}
     -+
     -+	return git_config_set_multivar_in_file_gently(config_filename, key, value, NULL, 0);
     ++	return upgrade_to_worktree_config(r) ||
     ++	       git_config_set_multivar_in_file_gently(
     ++			 repo_git_path(r, "config.worktree"),
     ++			 key, value, NULL, 0);
      +}
      +
       void git_config_set(const char *key, const char *value)
     @@ config.h: void git_config_set_in_file(const char *, const char *, const char *);
       
      +/**
      + * Write a config value into the config.worktree file for the current
     -+ * worktree. This will initialize extensions.worktreeConfig if necessary.
     ++ * worktree. This will initialize extensions.worktreeConfig if necessary,
     ++ * which might trigger some changes to the root repository's config file.
      + */
      +int repo_config_set_worktree_gently(struct repository *, const char *, const char *);
      +
 4:  6202f767f4a ! 5:  06457fafa78 sparse-checkout: use repo_config_set_worktree_gently()
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'git sparse-checkout ini
      +	(
      +		cd worktree &&
      +		git sparse-checkout init &&
     -+		test_cmp_config false core.bare &&
     ++		test_must_fail git config core.bare &&
      +		git sparse-checkout set /*
     -+	)
     ++	) &&
     ++	git -C bare config --list --show-origin >actual &&
     ++	grep "file:config.worktree	core.bare=true" actual
      +'
      +
       test_expect_success 'git sparse-checkout list after init' '

-- 
gitgitgadget
