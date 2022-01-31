Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9751C433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 16:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380197AbiAaQR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 11:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380214AbiAaQRi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 11:17:38 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C467C06173D
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 08:17:37 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id m4so44677537ejb.9
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 08:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Jd9Ljvm2+SMokPsSN9ktQRet8snRb2tVm6MOSXSNqA=;
        b=jJVjDIuLYMPdcT7x7q60cKii31Eq1KEcZBZOX/gKGmZOArBiCMXwKA+YnB2SNis3wI
         w4vY7XptJtt0t3m48pk7ZrwBxpf0FdzxewepRLOrXogBXy0hTP9z7mHoVIui9MHEwIhc
         dpqjbqk9mh9ZWOxsiDItBq3jEOydAWPuFB+tIGJxKZ6MiPoAl4rj+flMe4ZlMayPxh35
         JWXoJl0C7RiA0DZ7sK1zAKCoChnMLNtFKEXUI0MHpVqeJaHpvpSBjtOMKGgH6YyAGTTT
         8Ik5AMSNxHYNXN42DCD2vgZyDyqRqkKNiR+xqd7IgsaDBvMkXRlyfc3SvT/W+3hF6tmc
         p/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Jd9Ljvm2+SMokPsSN9ktQRet8snRb2tVm6MOSXSNqA=;
        b=MetNGyVXKrz4GQtTi9D8B+cGoE9ar0ogb0WL6eGKMa0WW4/IQW7fjFqLigqczgKPoJ
         Hr1SC9mfELgRgajgHf8YXe8+y8PnHLDAb2qd4ByaxZq5rBjVsuD5lUXur/+iXHPts335
         5yZF2xPUIEa8I5QwsDz/CQP4JZdgUXlKV1BPCY6QIjKle53SLUHXpUNuHejP/5KW8mFX
         zUvzgapbRGdNShzQSLqew0TviVz6MMCjCno6iB75I0ujvSYo/9tkeLPd190nX2wWolnB
         g6g0hAbDs/Z2aZC8KKDMyOijBUqqARs2F7C5udRSH9Di1zpLOZz4IWlv1RPTvePlQAU/
         Ky2w==
X-Gm-Message-State: AOAM531Gzrjz9c5TAA4zh1CdBT0PwWsf2iy3r0bBB6FkaW2N+rXyTT7y
        RxMfz7laX3q5AIPuV1JDJjJKaHGB2wisGCvzBB8=
X-Google-Smtp-Source: ABdhPJxPBxq68L4oPWbPJfhdFCK7923GpRkcFcJJW2Lr0NcInYPgWl2N6IFEkUHNoz2VdpBPedaR9DBBZ9lvOIksn2Y=
X-Received: by 2002:a17:907:60d5:: with SMTP id hv21mr18024468ejc.476.1643645855504;
 Mon, 31 Jan 2022 08:17:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com> <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 31 Jan 2022 08:17:23 -0800
Message-ID: <CABPp-BGA_e4oaVzmssHgejYPmjWMCNFDJ2-hbUU3yFbONyaG8Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Sparse checkout: fix bug with worktree of bare repo
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 31, 2022 at 7:01 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series is now based on v2.35.0 since that contains all of the necessary
> topics.
>
> This patch series includes a fix to the bug reported by Sean Allred [1] and
> diagnosed by Eric Sunshine [2].
>
> The root cause is that 'git sparse-checkout init' writes to the worktree
> config without checking that core.bare or core.worktree are set in the
> common config file. This series fixes this, but also puts in place some
> helpers to prevent this from happening in the future.
>
> ATTENTION: I have significantly redesigned the series since previous
> versions, so most of this cover letter is new.
>
>  * Patch 1 updates documentation around extensions.worktreeConfig in a few
>    places to improve discoverability. Several cross links are added to make
>    it easy to find the related areas. (The documentation for the changes to
>    'git sparse-checkout' are delayed to patch 4.)
>
>  * Patch 2 introduces the init_worktree_config() helper which follows the
>    documented instructions to enable extensions.worktreeConfig as well as
>    move the core.bare and core.worktree config values. This update does not
>    modify core.repositoryFormatVersion, since this is not needed
>    specifically for extensions.worktreeConfig.
>
>  * Patch 3 adds a new repo_config_set_worktree_gently() helper method so we
>    can internally adjust a config value within a worktree, at least if
>    extensions.worktreeConfig is enabled. (It will write to the common config
>    file if the extension is not enabled.)
>
>  * Patch 4 modifies the sparse-checkout builtin to use
>    init_worktree_config() and repo_config_set_worktree_gently() in ways that
>    fix the reported bug. The behavior change here is that it will no longer
>    upgrade the repository format version, since that is not needed for
>    extensions.worktreeConfig.
>
>  * Patch 5 updates 'git worktree add' to copy the worktree config from the
>    current worktree to the new one (while unsetting core.bare=true and
>    core.worktree=*) along with copying the sparse-checkout patterns file.
>
> [1]
> https://lore.kernel.org/git/CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com/
> [2]
> https://lore.kernel.org/git/CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com/
>
>
> Updates in v5
> =============
>
>  * Cleaned up documentation as per Elijah's suggestions.
>  * Removed unnecessary conflicting change in git-sparse-checkout.txt
>  * Fixed an ambiguous comment about moving config values.

Thanks for patiently addressing all my feedback.  These last two
rounds look really good, and this one you've addressed all my feedback
and I can't find any issues:

Reviewed-by: Elijah Newren <newren@gmail.com>

> Updates in v4
> =============
>
>  * Rebased to v2.35.0
>  * Fixed memory leak (was leaking repo_git_path() result)
>  * Added additional documentation updates so curious users can discover the
>    intricacies of extensions.worktreeConfig from multiple entry points.
>  * Significantly reduced the amount of changes to config.c.
>  * 'git sparse-checkout' no longer upgrades the repository format.
>  * Dropped the update to upgrade_repository_format(), since it is not
>    needed.
>  * Dropped the 'git worktree init-worktree-config' subcommand in favor of a
>    helper method called by 'git sparse-checkout'
>  * Many others because of the significant changes required by the above
>    items.
>
> Thanks, -Stolee
>
> Derrick Stolee (5):
>   Documentation: add extensions.worktreeConfig details
>   worktree: create init_worktree_config()
>   config: add repo_config_set_worktree_gently()
>   sparse-checkout: set worktree-config correctly
>   worktree: copy sparse-checkout patterns and config on add
>
>  Documentation/config/extensions.txt   | 31 ++++++++++++
>  Documentation/git-config.txt          |  8 ++-
>  Documentation/git-sparse-checkout.txt | 16 ++++--
>  Documentation/git-worktree.txt        | 11 +++--
>  builtin/sparse-checkout.c             | 28 +++++------
>  builtin/worktree.c                    | 60 +++++++++++++++++++++++
>  config.c                              | 35 ++++++++++++--
>  config.h                              |  8 +++
>  sparse-index.c                        | 10 ++--
>  t/t1091-sparse-checkout-builtin.sh    | 35 ++++++++++----
>  t/t2400-worktree-add.sh               | 46 +++++++++++++++++-
>  worktree.c                            | 70 +++++++++++++++++++++++++++
>  worktree.h                            | 21 ++++++++
>  13 files changed, 333 insertions(+), 46 deletions(-)
>
>
> base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1101%2Fderrickstolee%2Fsparse-checkout%2Fbare-worktree-bug-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1101/derrickstolee/sparse-checkout/bare-worktree-bug-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/1101
>
> Range-diff vs v4:
>
>  1:  459e09dedd7 ! 1:  1bd5f26271c Documentation: add extensions.worktreeConfig details
>      @@ Commit message
>           within git-sparse-checkout.txt, but a behavior change is needed before
>           making those updates.
>
>      +    Helped-by: Elijah Newren <newren@gmail.com>
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
>        ## Documentation/config/extensions.txt ##
>      @@ Documentation/git-config.txt: from all available files.
>       - present. If not it's the same as `--local`.
>       + enabled. If not it's the same as `--local`. Note that `$GIT_DIR`
>       + is equal to `$GIT_COMMON_DIR` for the main worktree, but is of the
>      -+ form `.git/worktrees/<worktree-name>/` for other worktrees. See
>      ++ form `$GIT_DIR/worktrees/<worktree-name>/` for other worktrees. See
>       + linkgit:git-worktree[1] to learn how to enable
>       + `extensions.worktreeConfig`.
>
>      @@ Documentation/git-worktree.txt: CONFIGURATION FILE
>       -already present in the config file, they will be applied to the main
>       -working trees only.
>       +present in the common config file and `extensions.worktreeConfig` is
>      -+disabled, then they will be applied to the main working trees only.
>      ++disabled, then they will be applied to the main working tree only.
>
>        In order to have configuration specific to working trees, you can turn
>        on the `worktreeConfig` extension, e.g.:
>      @@ Documentation/git-worktree.txt: them to the `config.worktree` of the main workin
>       - - `core.worktree` and `core.bare` should never be shared
>       + - `core.worktree` should never be shared.
>       +
>      -+ - `core.bare` should not be shared unless the value is `core.bare=false`.
>      ++ - `core.bare` should not be shared if the value is `core.bare=true`.
>
>         - `core.sparseCheckout` is recommended per working tree, unless you
>           are sure you always use sparse checkout for all working trees.
>  2:  d262a76b448 ! 2:  2a2c350112e worktree: create init_worktree_config()
>      @@ worktree.h: void strbuf_worktree_ref(const struct worktree *wt,
>       + *
>       + * 1. Add extensions.worktreeConfig=true in the common config file.
>       + *
>      -+ * 2. If the common config file has a core.worktree value or core.bare is
>      -+ *    set to true, then those values are moved to the main worktree's
>      -+ *    config.worktree file.
>      ++ * 2. If the common config file has a core.worktree value, then that value
>      ++ *    is moved to the main worktree's config.worktree file.
>      ++ *
>      ++ * 3. If the common config file has a core.bare enabled, then that value
>      ++ *    is moved to the main worktree's config.worktree file.
>       + *
>       + * If extensions.worktreeConfig is already true, then this method
>       + * terminates early without any of the above steps. The existing config
>  3:  110d5e0546c = 3:  802b28a9510 config: add repo_config_set_worktree_gently()
>  4:  fbfaa17797c ! 4:  08b89d17ccf sparse-checkout: set worktree-config correctly
>      @@ Documentation/git-sparse-checkout.txt: COMMANDS
>       - (extensions.worktreeConfig, core.sparseCheckout,
>       - core.sparseCheckoutCone) if they are not already enabled, and
>       - write a set of patterns to the sparse-checkout file from the
>      -- list of arguments following the 'set' subcommand. Update the
>      -- working directory to match the new patterns.
>       + Enable the necessary sparse-checkout config settings
>      -+ (`core.sparseCheckout` and possibly `core.sparseCheckoutCone`) if
>      -+ they are not already enabled, and write a set of patterns to the
>      -+ sparse-checkout file from the list of arguments following the
>      -+ 'set' subcommand. Update the working directory to match the new
>      -+ patterns.
>      -++
>      ++ (`core.sparseCheckout`, `core.sparseCheckoutCone`, and
>      ++ `index.sparse`) if they are not already set to the desired values,
>      ++ and write a set of patterns to the sparse-checkout file from the
>      +  list of arguments following the 'set' subcommand. Update the
>      +  working directory to match the new patterns.
>      + +
>       +To ensure that adjusting the sparse-checkout settings within a worktree
>       +does not alter the sparse-checkout settings in other worktrees, the 'set'
>       +subcommand will upgrade your repository config to use worktree-specific
>      @@ Documentation/git-sparse-checkout.txt: COMMANDS
>       +the 'set' subcommand are stored in the worktree-specific sparse-checkout
>       +file. See linkgit:git-worktree[1] and the documentation of
>       +`extensions.worktreeConfig` in linkgit:git-config[1] for more details.
>      - +
>      +++
>        When the `--stdin` option is provided, the patterns are read from
>        standard in as a newline-delimited list instead of from the arguments.
>      -@@ Documentation/git-sparse-checkout.txt: interact with your repository until it is disabled.
>      -  By default, these patterns are read from the command-line arguments,
>      -  but they can be read from stdin using the `--stdin` option. When
>      -  `core.sparseCheckoutCone` is enabled, the given patterns are interpreted
>      -- as directory names as in the 'set' subcommand.
>      -+ as directory names as in the 'set' subcommand. The sparsity defined
>      -+ by the arguments to the 'add' subcommand are added to the patterns
>      -+ in the worktree-specific sparse-checkout file.
>      -
>      - 'reapply'::
>      -  Reapply the sparsity pattern rules to paths in the working tree.
>      + +
>
>        ## builtin/sparse-checkout.c ##
>       @@
>  5:  bb9e550ff3d ! 5:  85779dfaed3 worktree: copy sparse-checkout patterns and config on add
>      @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'add to sparse-checkout'
>       + cat repo/.git/info/sparse-checkout >old &&
>       + test_when_finished cp old repo/.git/info/sparse-checkout &&
>       + test_when_finished git -C repo worktree remove ../worktree &&
>      -+ git -C repo sparse-checkout set "/*" &&
>      ++ git -C repo sparse-checkout set --no-cone "/*" &&
>       + git -C repo worktree add --quiet ../worktree 2>err &&
>       + test_must_be_empty err &&
>       + new=repo/.git/worktrees/worktree/info/sparse-checkout &&
>
> --
> gitgitgadget
