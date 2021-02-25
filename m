Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F45FC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA09A64E21
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhBYHqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 02:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbhBYHq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 02:46:26 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D21C061756
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 23:45:46 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id x23so1163100oop.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 23:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ba3+yHMRMXK/1FCeJIuIjZyrWbiDI9KcMEUz/gHx+wk=;
        b=b2lt4KZBUzYdln752mOukVkCXDiG9ZlXxlHW16Up/RdDP1autF9c8iNGmgu2Zt8kZy
         G+ynq+HJpXT7i+K5DIgm+tWPbgVll2y7g+EcdgSVVSNZlxUoY8UDBcpJ6cD9MUQ5bQZC
         tT2DWOWTVr3MvO9Ty7AtMxssQcPuCHuKgn/hnK552FXhDq23Vtw0xykq4SEANpkIF5Al
         8iLtPNx+bdEVCmZIlw5C5KAucOkFa7YzXs9oecGHp0DUhDRi+2fEzjQ8B9SCqPJYBzgA
         m13Nsa6nzpBmGJrNnHAhhaEJWi9rITBn2+tgTifke2gdwNFrZf6KwQtDrkfGarzoUlYP
         51GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ba3+yHMRMXK/1FCeJIuIjZyrWbiDI9KcMEUz/gHx+wk=;
        b=VyTcQ/E+lnXJU9UzXlm0vELxf2i4i7XSc/2yGde7GwG6bsScilEAN44NVqn/aO3SbU
         X/Qoq8yaDB/lBQdoHHeqJKHsH2OujAdVtFHiZI1PzcDQoQ4RYpz5GM7oRmaxVbaqkvJO
         DPSxk68D+JsV30h4/44wjeusopy22hKXgl1BOdPzJpzRnEW59bttsGqvomq1DmFpvRs7
         yiwfqxi89KiHI6v9n3LYGoUrDvxNqmz+3b9nFmfIsl8tSlrwaBqMJd4MGEDvj9Z2cXvm
         uN0pHnhwdj+35FwqCW9YIE+gQKaD+RHzqBN5CKD7GEuYvXUCIJACGXg2iKVn4lSB6EhT
         hTdA==
X-Gm-Message-State: AOAM531G4vipdhnIHvYxBFtgTvGVgQe/NT6Lm1RS537xIynCF6odWCmj
        t9HL32v+u2UffnkjGN9c7Kova+Gg8SEKJM0p41A=
X-Google-Smtp-Source: ABdhPJyT+Rh799yy5uhIP8RJdwRZCsdZDI3WjKEB7VcHF1QiVDCDhKUmlGpGZStcZ9ml+hRrjRDerg/2D+iyfN0/O7s=
X-Received: by 2002:a4a:eb8a:: with SMTP id d10mr1348896ooj.32.1614239145451;
 Wed, 24 Feb 2021 23:45:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com> <564503f7878475f220024def9e3bf20e4d518436.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <564503f7878475f220024def9e3bf20e4d518436.1614111270.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Feb 2021 23:45:34 -0800
Message-ID: <CABPp-BFnOgadewk+fSGy1ObHuZQb_-E0roz7HPE_cRHr3aW1UQ@mail.gmail.com>
Subject: Re: [PATCH 15/20] sparse-index: create extension for compatibility
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Previously, we enabled the sparse index format only using
> GIT_TEST_SPARSE_INDEX=1. This is not a feasible direction for users to
> actually select this mode. Further, sparse directory entries are not
> understood by the index formats as advertised.
>
> We _could_ add a new index version that explicitly adds these
> capabilities, but there are nuances to index formats 2, 3, and 4 that
> are still valuable to select as options. For now, create a repo
> extension, "extensions.sparseIndex", that specifies that the tool
> reading this repository must understand sparse directory entries.

This commit is unchanged from the RFC series, but given your comments
in the design document about how you do intend to create an index
format v5 now, do you want to reference that here?

>
> This change only encodes the extension and enables it when
> GIT_TEST_SPARSE_INDEX=1. Later, we will add a more user-friendly CLI
> mechanism.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config/extensions.txt |  7 ++++++
>  cache.h                             |  1 +
>  repo-settings.c                     |  7 ++++++
>  repository.h                        |  3 ++-
>  setup.c                             |  3 +++
>  sparse-index.c                      | 38 +++++++++++++++++++++++++----
>  6 files changed, 53 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
> index 4e23d73cdcad..5c86b3648732 100644
> --- a/Documentation/config/extensions.txt
> +++ b/Documentation/config/extensions.txt
> @@ -6,3 +6,10 @@ extensions.objectFormat::
>  Note that this setting should only be set by linkgit:git-init[1] or
>  linkgit:git-clone[1].  Trying to change it after initialization will not
>  work and will produce hard-to-diagnose issues.
> +
> +extensions.sparseIndex::
> +       When combined with `core.sparseCheckout=true` and
> +       `core.sparseCheckoutCone=true`, the index may contain entries
> +       corresponding to directories outside of the sparse-checkout
> +       definition. Versions of Git that do not understand this extension
> +       do not expect directory entries in the index.

I had a wording suggestion for this paragraph in the RFC series --
https://lore.kernel.org/git/CABPp-BFEJE82k4VgkR=Jf7V7sZxZzo2pHMfAGshhi9_vV6iK0w@mail.gmail.com/.
Let me know if you just decided to leave it out so I don't bug you
about stuff you already considered.

> diff --git a/cache.h b/cache.h
> index e8b7d3b4fb33..eea61fba7568 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1053,6 +1053,7 @@ struct repository_format {
>         int worktree_config;
>         int is_bare;
>         int hash_algo;
> +       int sparse_index;
>         char *work_tree;
>         struct string_list unknown_extensions;
>         struct string_list v1_only_extensions;
> diff --git a/repo-settings.c b/repo-settings.c
> index d63569e4041e..9677d50f9238 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -85,4 +85,11 @@ void prepare_repo_settings(struct repository *r)
>          * removed.
>          */
>         r->settings.command_requires_full_index = 1;
> +
> +       /*
> +        * Initialize this as off.
> +        */
> +       r->settings.sparse_index = 0;
> +       if (!repo_config_get_bool(r, "extensions.sparseindex", &value) && value)
> +               r->settings.sparse_index = 1;
>  }
> diff --git a/repository.h b/repository.h
> index e06a23015697..a45f7520fd9e 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -42,7 +42,8 @@ struct repo_settings {
>
>         int core_multi_pack_index;
>
> -       unsigned command_requires_full_index:1;
> +       unsigned command_requires_full_index:1,
> +                sparse_index:1;
>  };
>
>  struct repository {
> diff --git a/setup.c b/setup.c
> index c04cd25a30df..cd8394564613 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -500,6 +500,9 @@ static enum extension_result handle_extension(const char *var,
>                         return error("invalid value for 'extensions.objectformat'");
>                 data->hash_algo = format;
>                 return EXTENSION_OK;
> +       } else if (!strcmp(ext, "sparseindex")) {
> +               data->sparse_index = 1;
> +               return EXTENSION_OK;
>         }
>         return EXTENSION_UNKNOWN;
>  }
> diff --git a/sparse-index.c b/sparse-index.c
> index 14029fafc750..97b0d0c57857 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -102,19 +102,47 @@ static int convert_to_sparse_rec(struct index_state *istate,
>         return num_converted - start_converted;
>  }
>
> +static int enable_sparse_index(struct repository *repo)
> +{
> +       const char *config_path = repo_git_path(repo, "config.worktree");
> +
> +       if (upgrade_repository_format(1) < 0) {
> +               warning(_("unable to upgrade repository format to enable sparse-index"));
> +               return -1;
> +       }
> +       git_config_set_in_file_gently(config_path,
> +                                     "extensions.sparseIndex",
> +                                     "true");
> +
> +       prepare_repo_settings(repo);
> +       repo->settings.sparse_index = 1;
> +       return 0;
> +}
> +
>  int convert_to_sparse(struct index_state *istate)
>  {
>         if (istate->split_index || istate->sparse_index ||
>             !core_apply_sparse_checkout || !core_sparse_checkout_cone)
>                 return 0;
>
> +       if (!istate->repo)
> +               istate->repo = the_repository;
> +
> +       /*
> +        * The GIT_TEST_SPARSE_INDEX environment variable triggers the
> +        * extensions.sparseIndex config variable to be on.
> +        */
> +       if (git_env_bool("GIT_TEST_SPARSE_INDEX", 0)) {
> +               int err = enable_sparse_index(istate->repo);
> +               if (err < 0)
> +                       return err;
> +       }
> +
>         /*
> -        * For now, only create a sparse index with the
> -        * GIT_TEST_SPARSE_INDEX environment variable. We will relax
> -        * this once we have a proper way to opt-in (and later still,
> -        * opt-out).
> +        * Only convert to sparse if extensions.sparseIndex is set.
>          */
> -       if (!git_env_bool("GIT_TEST_SPARSE_INDEX", 0))
> +       prepare_repo_settings(istate->repo);
> +       if (!istate->repo->settings.sparse_index)
>                 return 0;
>
>         if (!istate->sparse_checkout_patterns) {
> --
> gitgitgadget
