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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5B6C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0DC52311C
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391823AbhATSFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbhATSE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 13:04:29 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A32BC0613C1
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 10:03:32 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id v1so6150782ott.10
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 10:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDNJGxuYZ6y6bpBGg483nyYcTGFhiC9Am+FOY4MpUx0=;
        b=j35wIV3eQGjACilna3RoJx6VKZ2dLX5krh9h/LKFICqwWk4h9L7Q/RjHGiwiRWP9FU
         TMjETYYtVxhe5FsppD5F7ZjDy7Eot/HzH+av/kc4Ejyy95FweOAH8FFEnSrnPLUtLZ2M
         CX1AoeDzLOH46Va7zQSfVYoU6NWw0balcwrpIxONF4uoXE1VsL5lL4hk6mkY8xoYJITn
         ivA50h1I3XXaRWa/GwV38vEDZc2FLh4I2wfYcCeLRJznbwPllnqiDgN6CCCnfgZsY9Pv
         C8QBffe4A1e2F9Vnh1EuyOpvrJKSQ8UCX7fcGp/IgafGHQGuDzKFY0SZRCeJqNe1TBl3
         XEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDNJGxuYZ6y6bpBGg483nyYcTGFhiC9Am+FOY4MpUx0=;
        b=F915joKi/H/1h0DwYgpiJXtfxZ6hccVPdPljTans0huLg/VmqKdhojKtclOBhtx/6S
         PoTFX3tLOYnqf/7KaKz2XTEzV5ttJ5z4NhP0I6YLAFchciwWY+9xAHR3ObF8wzLZS1on
         W0aKzdmeq886X5oVWUUXsrSac/u2Ehp51p1z30Ug5uH8eWul97ia30a2NrGcHENhWvms
         dFIpYssgfPbftt3R2jXxUJA3ZIwZEJpcIKIe90W9RpAhLseayUqdUS5EiJhttXa9SJP4
         hie0gb7AL5W+8xkObA2H0MVbGGvsIFaQRyIcVk8w4Bm1ADR9XOFWTxVgSyMLlODbyRTM
         wHWg==
X-Gm-Message-State: AOAM532gRNNquyF+AVyOre6V71y6lUVTsJMn9NOGNs7w8sLtt7RZmwoe
        JOVIRcIBKWgrc9y4ctr9wAdzIKN8TdMDb8uPjIgYKmGNo101Xg==
X-Google-Smtp-Source: ABdhPJwJNdqeo1r/Z/7ght+p1LvDdka+YgLTVI86fouCChtxtNbMJZvICW1ApYKKz5SRon+RBkLGgUnYEoP0wPbDk6c=
X-Received: by 2002:a9d:506:: with SMTP id 6mr489012otw.162.1611165811644;
 Wed, 20 Jan 2021 10:03:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.839.git.1611161639.gitgitgadget@gmail.com> <91344f5108c835a48b2460b9de75c489045b9cce.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <91344f5108c835a48b2460b9de75c489045b9cce.1611161639.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jan 2021 10:03:20 -0800
Message-ID: <CABPp-BEeDj4v4t8w6giy-yo8ET0mnD3es95aGQJvw7g8_jkjzA@mail.gmail.com>
Subject: Re: [PATCH 7/9] sparse-checkout: hold pattern list in index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 8:54 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> As we modify the sparse-checkout definition, we perform index operations
> on a pattern_list that only exists in-memory. This allows easy backing
> out in case the index update fails.
>
> However, if the index write itself cares about the sparse-checkout
> pattern set, we need access to that in-memory copy. Place a pointer to
> a 'struct pattern_list' in the index so we can access this on-demand.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/sparse-checkout.c | 17 ++++++++++-------
>  cache.h                   |  2 ++
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 2306a9ad98e..e00b82af727 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -110,6 +110,8 @@ static int update_working_directory(struct pattern_list *pl)
>         if (is_index_unborn(r->index))
>                 return UPDATE_SPARSITY_SUCCESS;
>
> +       r->index->sparse_checkout_patterns = pl;
> +
>         memset(&o, 0, sizeof(o));
>         o.verbose_update = isatty(2);
>         o.update = 1;
> @@ -138,6 +140,7 @@ static int update_working_directory(struct pattern_list *pl)
>         else
>                 rollback_lock_file(&lock_file);
>
> +       r->index->sparse_checkout_patterns = NULL;
>         return result;

The setting back to NULL made me curious; we don't want this
information to remain available later?  Is it only going to be used
for the updating of the working directory?

I dug a bit into the callers, and didn't find the answer to my
question...but I did notice that modify_pattern_list() will correctly
free the patterns after write_patterns_and_update() via calling
clear_pattern_list(&pl), but sparse_checkout_init() appears to leak
the patterns it allocates.  That's a separate issue from this patch,
but do you want to fix that up while working in this area (so I avoid
stepping on your toes with all your other patches)?

>  }
>
> @@ -517,19 +520,18 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
>  {
>         int result;
>         int changed_config = 0;
> -       struct pattern_list pl;
> -       memset(&pl, 0, sizeof(pl));
> +       struct pattern_list *pl = xcalloc(1, sizeof(*pl));
>
>         switch (m) {
>         case ADD:
>                 if (core_sparse_checkout_cone)
> -                       add_patterns_cone_mode(argc, argv, &pl);
> +                       add_patterns_cone_mode(argc, argv, pl);
>                 else
> -                       add_patterns_literal(argc, argv, &pl);
> +                       add_patterns_literal(argc, argv, pl);
>                 break;
>
>         case REPLACE:
> -               add_patterns_from_input(&pl, argc, argv);
> +               add_patterns_from_input(pl, argc, argv);

Slightly annoying that the other functions are (argc, argv, pl) and
this one is (pl, argc, argv).  But again, that's outside the scope of
this patch and might not be worth the churn to fix.

>                 break;
>         }
>
> @@ -539,12 +541,13 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
>                 changed_config = 1;
>         }
>
> -       result = write_patterns_and_update(&pl);
> +       result = write_patterns_and_update(pl);
>
>         if (result && changed_config)
>                 set_config(MODE_NO_PATTERNS);
>
> -       clear_pattern_list(&pl);
> +       clear_pattern_list(pl);
> +       free(pl);
>         return result;
>  }
>
> diff --git a/cache.h b/cache.h
> index f9c7a603841..bf4ec3de4b0 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -305,6 +305,7 @@ static inline unsigned int canon_mode(unsigned int mode)
>  struct split_index;
>  struct untracked_cache;
>  struct progress;
> +struct pattern_list;
>
>  struct index_state {
>         struct cache_entry **cache;
> @@ -329,6 +330,7 @@ struct index_state {
>         struct mem_pool *ce_mem_pool;
>         struct progress *progress;
>         struct repository *repo;
> +       struct pattern_list *sparse_checkout_patterns;
>  };
>
>  /* Name hashing */
> --
> gitgitgadget

Otherwise, this patch looks good to me.
