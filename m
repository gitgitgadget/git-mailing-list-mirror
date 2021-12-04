Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C9DC433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 05:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhLDFq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 00:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhLDFq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 00:46:29 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3E1C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 21:43:04 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g14so19626401edb.8
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 21:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RkMN+uNVOhq9bp2cZ1BGmxi9GhVcaYqpHgrHFwyE3iY=;
        b=OTGweJgZi2zR2d0tXPA8TyiiecRU6jMkXO4ywcf0nMALfAQoumGKWPaVUrFITRWSyM
         2j2gQUgrvuesX39UAiTDEJTEgDfnKDsIm32ilJsM3YN+3J6DFh0ZbhR2yqWETdydgZov
         Od8HzUjUmd22l48+Hks2wfYYhdRNupIq3/+hLQcYwaOp4u9/rFe5W1Ww5gSo1G6Ru1uL
         3KBYICxNdDEEx3Y0AAn1GpOrCRA62EDNd8EjMejsFQwVcwAvq8dKMXSzY8Px5dKcqJQ6
         z+8BerzBXyvOoUkngnMFgTmUDrwhObKrIOPRJQyHD9O6X+fc8dB1XntCipSItmuIqAZd
         gZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RkMN+uNVOhq9bp2cZ1BGmxi9GhVcaYqpHgrHFwyE3iY=;
        b=5Cb5Y5uv44xCLXaXGnQjzewJanjowJHh3vbIppvmpRmTe+kPp8hAYkuLRqJagbmztm
         wb9IYSbLerrZDXSJ0uG1FbnLuMkD+EQe/KUCL0xKN7genZ/xKpuvRRjpjbvYc4plL8yP
         qEe/n1DBdIeyl34vPI6onDxZWBrBvew0vYqzCn31zkmhyZ1QscjBaV7geg5fjTBdMK5A
         NzXxYzVmePocIdHxGCuKYGhLqvS8oaKBa5+u0mLJHXq9sNy5MHBqxw48dLEUF2pNF94o
         iOkPsnNp/BfvcTIGFFEVkWWbNbFscYeEFJLcl2HnOL+sF7CdgCXZ7pDJJnnxwtxVCbMo
         9Lng==
X-Gm-Message-State: AOAM531bxJOZfpZDLGrhrhDu48GDGqn7zPXQ7v1W4eHPHq/MIIicbWWF
        d6OjWHkYIjWGb7Lh7V/nyCmCAfA9xVbEF75A7eE=
X-Google-Smtp-Source: ABdhPJzktEd+jtlfieidnjXov8SK0e0IpH9nytVKaPJj/RliI1aIyapIC4ub9dgJAAtzwj9nW/astqSa7iuvvhxCgkw=
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr33116918edu.186.1638596582490;
 Fri, 03 Dec 2021 21:43:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.1092.git.1638586534.gitgitgadget@gmail.com> <c91421996562ecedab18f8af4ed8a02896584540.1638586534.git.gitgitgadget@gmail.com>
In-Reply-To: <c91421996562ecedab18f8af4ed8a02896584540.1638586534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 3 Dec 2021 21:42:50 -0800
Message-ID: <CABPp-BEs8_F7SKsxDMd8p03oMn9M3H47=hrPP=AzxsacUkGg_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] unpack-trees: use traverse_path instead of name
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 3, 2021 at 6:55 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The sparse_dir_matches_path() method compares a cache entry that is a
> sparse directory entry against a 'struct traverse_info *info' and a
> 'struct name_entry *p' to see if the cache entry has exactly the right
> name for those other inputs.
>
> This method was introduced in 523506d (unpack-trees: unpack sparse
> directory entries, 2021-07-14), but included a significant mistake. The
> path comparisons used 'info->name' instead of 'info->traverse_path'.
> Since 'info->name' only stores a single tree entry name while
> 'info->traverse_path' stores the full path from root, this method does
> not work when 'info' is in a subdirectory of a directory. Replacing the
> right strings and their corresponding lengths make the method work
> properly.
>
> The previous change included a failing test that exposes this issue.
> That test now passes. The critical detail is that as we go deep into
> unpack_trees(), the logic for merging a sparse directory entry with a
> tree entry during 'git checkout' relies on this
> sparse_dir_matches_path() in order to avoid calling
> traverse_trees_recursive() during unpack_callback() in this hunk:
>
>         if (!is_sparse_directory_entry(src[0], names, info) &&
>             traverse_trees_recursive(n, dirmask, mask & ~dirmask,
>                                             names, info) < 0) {
>                 return -1;
>         }
>
> For deep paths, the short-circuit never occurred and
> traverse_trees_recursive() was being called incorrectly and that was
> causing other strange issues. Specifically, the error message from the
> now-passing test previously included this:
>
>       error: Your local changes to the following files would be overwritten by checkout:
>               deep/deeper1/deepest2/a
>               deep/deeper1/deepest3/a
>       Please commit your changes or stash them before you switch branches.
>       Aborting
>
> These messages occurred because the 'current' cache entry in
> twoway_merge() was showing as NULL because the index did not contain
> entries for the paths contained within the sparse directory entries. We
> instead had 'oldtree' given as the entry at HEAD and 'newtree' as the
> entry in the target tree. This led to reject_merge() listing these
> paths.
>
> Now that sparse_dir_matches_path() works the same for deep paths as it
> does for shallow depths, the rest of the logic kicks in to properly
> handle modifying the sparse directory entries as designed.

Eek, sorry for not catching this in my earlier review.  Thanks for the
detailed explanation; well analyzed.

>
> Reported-by: Gustave Granroth <gus.gran@gmail.com>
> Reported-by: Mike Marcelais <michmarc@exchange.microsoft.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh |  2 +-
>  unpack-trees.c                           | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index e6aef40e9b3..f04a02c6b20 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -307,7 +307,7 @@ test_expect_success 'add, commit, checkout' '
>         test_all_match git checkout -
>  '
>
> -test_expect_failure 'deep changes during checkout' '
> +test_expect_success 'deep changes during checkout' '
>         init_repos &&
>
>         test_sparse_match git sparse-checkout set deep/deeper1/deepest &&
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 89ca95ce90b..7381c275768 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1243,11 +1243,11 @@ static int sparse_dir_matches_path(const struct cache_entry *ce,
>         assert(S_ISSPARSEDIR(ce->ce_mode));
>         assert(ce->name[ce->ce_namelen - 1] == '/');
>
> -       if (info->namelen)
> -               return ce->ce_namelen == info->namelen + p->pathlen + 2 &&
> -                      ce->name[info->namelen] == '/' &&
> -                      !strncmp(ce->name, info->name, info->namelen) &&
> -                      !strncmp(ce->name + info->namelen + 1, p->path, p->pathlen);
> +       if (info->pathlen)
> +               return ce->ce_namelen == info->pathlen + p->pathlen + 1 &&
> +                      ce->name[info->pathlen - 1] == '/' &&
> +                      !strncmp(ce->name, info->traverse_path, info->pathlen) &&
> +                      !strncmp(ce->name + info->pathlen, p->path, p->pathlen);
>         return ce->ce_namelen == p->pathlen + 1 &&
>                !strncmp(ce->name, p->path, p->pathlen);
>  }
> --

The comment at the beginning of this function (not shown in this
patch) is now stale and misleading; it should be corrected too.
