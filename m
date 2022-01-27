Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F655C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 07:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbiA0HPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 02:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237197AbiA0HPg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 02:15:36 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B6DC061714
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 23:15:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id k25so3747662ejp.5
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 23:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUhiZfTBV/c6skfjjwiK17oMKpLVZiK8Q9xA1omAcFY=;
        b=G1oHrQmUquUYiZEBgXEoCAmceJdO3Imrl556DgYAJXLnoYS1i9EQ7/1sVyZpHl7aSM
         FfxM7VPf7VEJDR8q6UQ03yh8pPipF2JpWjV0zyWzXyC28HuVsuSyV6okU4no/0GfSrhX
         rGHb8bqX7sSTe5pOMEod5urjKXlqfRSUQ8syowU7DM6Tm9eJ8L7X+NGR+NOLJKDi+apo
         GH6beAZKodtzdGCbCGyPm8iKjSPJNX27RoMD3+BvfkUgIoKlwO69EsgsLVToU7rJZooy
         2CccnAPUkutSOgnI+AC2VOhdekYCErJNja77gCdka+6Ie453QFSA4gshMbv+whdtgZRv
         JZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUhiZfTBV/c6skfjjwiK17oMKpLVZiK8Q9xA1omAcFY=;
        b=dpw12bUl7bSdl6mMQpq+QayKfiUCK6nSZPo2Kav5w1CPIyzlhkkE/T44+IY74tXWKe
         TPb4+IRxeXjehcrPiEZaVlJV8lXqPTCtey87V5RwDfoxbs+2a82PGViOIjNRkfrfid8y
         /1PzyzBzKOhW/NR5PYR9PnUpL2FdNyC6dt6MlG6nDPyTgE4UIuQ+wrAz8gECTyXYxSGm
         9XpVTE2xl0TPXgodPSDlkJvnHNzDHbJ3H3XFIn8pKSrtJPBQSTuzKx5OxquJQl6avwNA
         6ZdMrSVhG1/7wewPZINoakZ9z8wA+h+O2jSHgsvvgzOkEttMuM3cemnb7xXDGYuqWp5j
         +D7A==
X-Gm-Message-State: AOAM530zYHGF7Lhy788JYPySrIfUETtILzHr5egk07kRtXSPfSSJYuhm
        R6+ak/5/XcvL8hy2niofJNFihWRazjjvWTngCI0=
X-Google-Smtp-Source: ABdhPJydtWs8APPyHcD2c6XvOosHFiBec/kflL9WTBVrNI3F17CpMurSxGxcek3DSdRbgilpXhcBMjfC8YXJZiK/OUM=
X-Received: by 2002:a17:907:2ce4:: with SMTP id hz4mr1019478ejc.613.1643267734295;
 Wed, 26 Jan 2022 23:15:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
 <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com> <fbfaa17797c023f4a86eeac200a83c2e1954daf5.1643136134.git.gitgitgadget@gmail.com>
In-Reply-To: <fbfaa17797c023f4a86eeac200a83c2e1954daf5.1643136134.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 26 Jan 2022 23:15:23 -0800
Message-ID: <CABPp-BHBMUar-ysiJsjmpqQ3NPjRUiBPKEdHty3ADBYaf0EMug@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] sparse-checkout: set worktree-config correctly
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 10:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The previous change added repo_config_set_worktree_gently() to assist
> writing config values into the config.worktree file, if enabled. An
> earlier change added init_worktree_config() as a helper to initialize
> extensions.worktreeConfig if not already enabled.
>
> Let the sparse-checkout builtin use these helpers instead of attempting to
> initialize the worktree config on its own. This changes behavior of 'git
> sparse-checkout set' in a few important ways:
>
>  1. Git will no longer upgrade the repository format, since this is not
>     a requirement for understanding extensions.worktreeConfig.
>
>  2. If the main worktree is bare, then this command will not put the
>     worktree in a broken state.
>
> The main reason to use worktree-specific config for the sparse-checkout
> builtin was to avoid enabling sparse-checkout patterns in one and
> causing a loss of files in another. If a worktree does not have a
> sparse-checkout patterns file, then the sparse-checkout logic will not
> kick in on that worktree.
>
> Reported-by: Sean Allred <allred.sean@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt | 24 ++++++++++++++++-------
>  builtin/sparse-checkout.c             | 28 +++++++++++++--------------
>  sparse-index.c                        | 10 +++-------
>  t/t1091-sparse-checkout-builtin.sh    |  4 ++--
>  4 files changed, 35 insertions(+), 31 deletions(-)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index b81dbe06543..c6eae3ec7fd 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -31,12 +31,20 @@ COMMANDS
>         Describe the patterns in the sparse-checkout file.
>
>  'set'::
> -       Enable the necessary config settings
> -       (extensions.worktreeConfig, core.sparseCheckout,
> -       core.sparseCheckoutCone) if they are not already enabled, and
> -       write a set of patterns to the sparse-checkout file from the
> -       list of arguments following the 'set' subcommand. Update the
> -       working directory to match the new patterns.
> +       Enable the necessary sparse-checkout config settings
> +       (`core.sparseCheckout` and possibly `core.sparseCheckoutCone`) if

and possibly index.sparse as well, right?

> +       they are not already enabled, and write a set of patterns to the
> +       sparse-checkout file from the list of arguments following the
> +       'set' subcommand. Update the working directory to match the new
> +       patterns.
> ++
> +To ensure that adjusting the sparse-checkout settings within a worktree
> +does not alter the sparse-checkout settings in other worktrees, the 'set'
> +subcommand will upgrade your repository config to use worktree-specific
> +config if not already present. The sparsity defined by the arguments to
> +the 'set' subcommand are stored in the worktree-specific sparse-checkout
> +file. See linkgit:git-worktree[1] and the documentation of
> +`extensions.worktreeConfig` in linkgit:git-config[1] for more details.
>  +
>  When the `--stdin` option is provided, the patterns are read from
>  standard in as a newline-delimited list instead of from the arguments.
> @@ -73,7 +81,9 @@ interact with your repository until it is disabled.
>         By default, these patterns are read from the command-line arguments,
>         but they can be read from stdin using the `--stdin` option. When
>         `core.sparseCheckoutCone` is enabled, the given patterns are interpreted
> -       as directory names as in the 'set' subcommand.
> +       as directory names as in the 'set' subcommand. The sparsity defined
> +       by the arguments to the 'add' subcommand are added to the patterns
> +       in the worktree-specific sparse-checkout file.

This sentence addition makes your series conflict with patch 4 of my
en/present-despite-skipped series.

The sentence also seems somewhat redundant with the first sentence of
the paragraph (not quoted here).  Perhaps consider just dropping it to
make it easier for Junio to integrate?

>  'reapply'::
>         Reapply the sparsity pattern rules to paths in the working tree.
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 679c1070368..314c8d61f80 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -15,6 +15,7 @@
>  #include "wt-status.h"
>  #include "quote.h"
>  #include "sparse-index.h"
> +#include "worktree.h"
>
>  static const char *empty_base = "";
>
> @@ -359,26 +360,23 @@ enum sparse_checkout_mode {
>
>  static int set_config(enum sparse_checkout_mode mode)
>  {
> -       const char *config_path;
> -
> -       if (upgrade_repository_format(1) < 0)
> -               die(_("unable to upgrade repository format to enable worktreeConfig"));

Wait, this got added in mid-2020, since v2.28.0 -- and I missed it but
it hasn't bit us yet??

I'm so sorry.  Earlier when I objected to setting this, I was worried
it was a new change and would introduce some new failures, but clearly
it was already introduced...and it turns out we've been fine.  So, I
was wrong to worry about this.

(Which is to say, if you want to add it back, I'm fine with it given
this info.  If you'd rather still take it out, I'm fine with that
too.)


> -       if (git_config_set_gently("extensions.worktreeConfig", "true")) {
> -               error(_("failed to set extensions.worktreeConfig setting"));
> +       /* Update to use worktree config, if not already. */
> +       if (init_worktree_config(the_repository)) {
> +               error(_("failed to initialize worktree config"));
>                 return 1;
>         }
>
> -       config_path = git_path("config.worktree");
> -       git_config_set_in_file_gently(config_path,
> -                                     "core.sparseCheckout",
> -                                     mode ? "true" : NULL);
> -
> -       git_config_set_in_file_gently(config_path,
> -                                     "core.sparseCheckoutCone",
> -                                     mode == MODE_CONE_PATTERNS ? "true" : NULL);
> +       if (repo_config_set_worktree_gently(the_repository,
> +                                           "core.sparseCheckout",
> +                                           mode ? "true" : "false") ||
> +           repo_config_set_worktree_gently(the_repository,
> +                                           "core.sparseCheckoutCone",
> +                                           mode == MODE_CONE_PATTERNS ?
> +                                               "true" : "false"))
> +               return 1;
>
>         if (mode == MODE_NO_PATTERNS)
> -               set_sparse_index_config(the_repository, 0);
> +               return set_sparse_index_config(the_repository, 0);
>
>         return 0;
>  }
> diff --git a/sparse-index.c b/sparse-index.c
> index a1d505d50e9..e93609999e0 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -99,13 +99,9 @@ static int convert_to_sparse_rec(struct index_state *istate,
>
>  int set_sparse_index_config(struct repository *repo, int enable)
>  {
> -       int res;
> -       char *config_path = repo_git_path(repo, "config.worktree");
> -       res = git_config_set_in_file_gently(config_path,
> -                                           "index.sparse",
> -                                           enable ? "true" : NULL);
> -       free(config_path);
> -
> +       int res = repo_config_set_worktree_gently(repo,
> +                                                 "index.sparse",
> +                                                 enable ? "true" : "false");
>         prepare_repo_settings(repo);
>         repo->settings.sparse_index = enable;
>         return res;
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 42776984fe7..be6ea4ffe33 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -117,7 +117,7 @@ test_expect_success 'switching to cone mode with non-cone mode patterns' '
>                 cd bad-patterns &&
>                 git sparse-checkout init &&
>                 git sparse-checkout add dir &&
> -               git config core.sparseCheckoutCone true &&
> +               git config --worktree core.sparseCheckoutCone true &&
>                 test_must_fail git sparse-checkout add dir 2>err &&
>                 grep "existing sparse-checkout patterns do not use cone mode" err
>         )
> @@ -256,7 +256,7 @@ test_expect_success 'sparse-index enabled and disabled' '
>                 test_cmp expect actual &&
>
>                 git -C repo config --list >config &&
> -               ! grep index.sparse config
> +               test_cmp_config -C repo false index.sparse
>         )
>  '
>
> --
> gitgitgadget

Patch looks good; I only had a few very minor comments.
