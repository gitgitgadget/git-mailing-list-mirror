Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B4BC433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 22:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhKTWJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 17:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhKTWJM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 17:09:12 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE84C061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 14:06:08 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y12so58609308eda.12
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 14:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8qdCo0oFJ+tG2hBtO8WBSO+V2CC+HJSys6gaaEZ8jA=;
        b=gs3iobZEM/ibODgmkxHt8zUEgeyGmdUP62y7Y5HFrqWXT7sRi5tD/aT9YysDN4LNUz
         j0VBSF7xTCJowNOFv+HOuFZZALGZW8bpYwVkFfe1GW72TjfuN5kvxt6Jyql2AinuiHrP
         HTy9/X3OVc950Lw4EiuYWZcUT8bGWEIjgSPRiPntUltLWrvcjTt23UWQk0ZUR8uWm/3Q
         BvSKQn/XsHBnY+tXcdBAiodAtYU8mAzRWVpfZvbmVydvqvEGmlev2YGt7cfbuv1agp8p
         /hpJoP7IAQFTQ0cGQTk2gtM+XaU8PFODYPIbLpK5aFPDX4jayUCcaXkFZRmZ219DPDPc
         rGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8qdCo0oFJ+tG2hBtO8WBSO+V2CC+HJSys6gaaEZ8jA=;
        b=vao2zOaP6L13VG00JUAlu86R+qyX6coIIjCmHVzk78jboPwcF9kwCE0uHhInlMeR5E
         PdlDasJdF4c87vQO+zzEvdOHk2BlXXerI1ZejRvxo2/p4VAhmbTzw9VpcrKgQkzJXFkp
         e1OlKTF1ka1qug/GaMSlmC7NiiDD+CTZcENZHzKrgCkbKEVbEjbFYqxHffV3/H5X9hjo
         CF/0O2kDXGKwuG6UQr5QLCrV62lPx/9xbPSlxvdwQccFQALDHQE9NlZDhy2BM7G9JZGY
         bcUo0TftUmfBDNVS6uo2tSkq/toHkMKk8OS+9uj/RqjxMDqKp9rMzZSaeVdMsvKF5RIv
         d7VA==
X-Gm-Message-State: AOAM533r7xEyyF5DZPxMGyKB8eov3XNQlYWT4LNWHRy/vSItTtpSXvm+
        lkBRf9lOR3Rfcc5NiSSfpceI4hhITTcFK+Q4VU8=
X-Google-Smtp-Source: ABdhPJyjppmamwN5fMXZBL1IOIK75yLT84UsKv3GySkQVJKrFiOKwBdUIBnuDJaS6ww3+IOlA561YJMU/eX3mKlSu5E=
X-Received: by 2002:a50:d6d9:: with SMTP id l25mr44470453edj.41.1637445967120;
 Sat, 20 Nov 2021 14:06:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
 <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com> <a9135a5ed64f031fa2b46baabf179611dde60e71.1635345563.git.gitgitgadget@gmail.com>
In-Reply-To: <a9135a5ed64f031fa2b46baabf179611dde60e71.1635345563.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 20 Nov 2021 14:05:55 -0800
Message-ID: <CABPp-BH9qXZObVkEyuLOzoOvw_uPfC_n9QSR=by2+-GVgAGgSw@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] reset: make --mixed sparse-aware
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, one more thing...

On Wed, Oct 27, 2021 at 7:39 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> Remove the `ensure_full_index` guard on `read_from_tree` and update `git
> reset --mixed` to ensure it can use sparse directory index entries wherever
> possible. Sparse directory entries are reset use `diff_tree_oid`, which
> requires `change` and `add_remove` functions to process the internal
> contents of the sparse directory. The `recursive` diff option handles cases
> in which `reset --mixed` must diff/merge files that are nested multiple
> levels deep in a sparse directory.
>
> The use of pathspecs with `git reset --mixed` introduces scenarios in which
> internal contents of sparse directories may be matched by the pathspec. In
> order to reset *all* files in the repo that may match the pathspec, the
> following conditions on the pathspec require index expansion before
> performing the reset:
>
> * "magic" pathspecs
> * wildcard pathspecs that do not match only in-cone files or entire sparse
>   directories
> * literal pathspecs matching something outside the sparse checkout
>   definition
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/reset.c                          | 78 +++++++++++++++++++++++-
>  t/t1092-sparse-checkout-compatibility.sh | 17 ++++++
>  2 files changed, 93 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 0ac0de7dc97..60517e7e1d6 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -148,7 +148,9 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>                  * If the file 1) corresponds to an existing index entry with
>                  * skip-worktree set, or 2) does not exist in the index but is
>                  * outside the sparse checkout definition, add a skip-worktree bit
> -                * to the new index entry.
> +                * to the new index entry. Note that a sparse index will be expanded
> +                * if this entry is outside the sparse cone - this is necessary
> +                * to properly construct the reset sparse directory.
>                  */
>                 pos = cache_name_pos(one->path, strlen(one->path));
>                 if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) ||
> @@ -166,6 +168,73 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>         }
>  }
>
> +static int pathspec_needs_expanded_index(const struct pathspec *pathspec)
> +{
> +       unsigned int i, pos;
> +       int res = 0;
> +       char *skip_worktree_seen = NULL;
> +
> +       /*
> +        * When using a magic pathspec, assume for the sake of simplicity that
> +        * the index needs to be expanded to match all matchable files.
> +        */
> +       if (pathspec->magic)
> +               return 1;
> +
> +       for (i = 0; i < pathspec->nr; i++) {
> +               struct pathspec_item item = pathspec->items[i];
> +
> +               /*
> +                * If the pathspec item has a wildcard, the index should be expanded
> +                * if the pathspec has the possibility of matching a subset of entries inside
> +                * of a sparse directory (but not the entire directory).
> +                *
> +                * If the pathspec item is a literal path, the index only needs to be expanded
> +                * if a) the pathspec isn't in the sparse checkout cone (to make sure we don't
> +                * expand for in-cone files) and b) it doesn't match any sparse directories
> +                * (since we can reset whole sparse directories without expanding them).
> +                */
> +               if (item.nowildcard_len < item.len) {
> +                       for (pos = 0; pos < active_nr; pos++) {
> +                               struct cache_entry *ce = active_cache[pos];
> +
> +                               if (!S_ISSPARSEDIR(ce->ce_mode))
> +                                       continue;
> +
> +                               /*
> +                                * If the pre-wildcard length is longer than the sparse
> +                                * directory name and the sparse directory is the first
> +                                * component of the pathspec, need to expand the index.
> +                                */
> +                               if (item.nowildcard_len > ce_namelen(ce) &&
> +                                   !strncmp(item.original, ce->name, ce_namelen(ce))) {
> +                                       res = 1;
> +                                       break;
> +                               }
> +
> +                               /*
> +                                * If the pre-wildcard length is shorter than the sparse
> +                                * directory and the pathspec does not match the whole
> +                                * directory, need to expand the index.
> +                                */
> +                               if (!strncmp(item.original, ce->name, item.nowildcard_len) &&
> +                                   wildmatch(item.original, ce->name, 0)) {
> +                                       res = 1;
> +                                       break;
> +                               }
> +                       }
> +               } else if (!path_in_cone_mode_sparse_checkout(item.original, &the_index) &&
> +                          !matches_skip_worktree(pathspec, i, &skip_worktree_seen))
> +                       res = 1;
> +
> +               if (res > 0)
> +                       break;
> +       }
> +
> +       free(skip_worktree_seen);
> +       return res;
> +}
> +
>  static int read_from_tree(const struct pathspec *pathspec,
>                           struct object_id *tree_oid,
>                           int intent_to_add)
> @@ -178,9 +247,14 @@ static int read_from_tree(const struct pathspec *pathspec,
>         opt.format_callback = update_index_from_diff;
>         opt.format_callback_data = &intent_to_add;
>         opt.flags.override_submodule_config = 1;
> +       opt.flags.recursive = 1;
>         opt.repo = the_repository;
> +       opt.change = diff_change;
> +       opt.add_remove = diff_addremove;
> +
> +       if (pathspec->nr && the_index.sparse_index && pathspec_needs_expanded_index(pathspec))
> +               ensure_full_index(&the_index);
>
> -       ensure_full_index(&the_index);
>         if (do_diff_cache(tree_oid, &opt))
>                 return 1;
>         diffcore_std(&opt);
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 5664ff8f039..44d5e11c762 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -781,11 +781,28 @@ test_expect_success 'sparse-index is not expanded' '
>                 ensure_not_expanded reset --hard $ref || return 1
>         done &&
>
> +       ensure_not_expanded reset --mixed base &&
>         ensure_not_expanded reset --hard update-deep &&
>         ensure_not_expanded reset --keep base &&
>         ensure_not_expanded reset --merge update-deep &&
>         ensure_not_expanded reset --hard &&
>
> +       ensure_not_expanded reset base -- deep/a &&
> +       ensure_not_expanded reset base -- nonexistent-file &&
> +       ensure_not_expanded reset deepest -- deep &&
> +
> +       # Although folder1 is outside the sparse definition, it exists as a
> +       # directory entry in the index, so the pathspec will not force the
> +       # index to be expanded.
> +       ensure_not_expanded reset deepest -- folder1 &&
> +       ensure_not_expanded reset deepest -- folder1/ &&
> +
> +       # Wildcard identifies only in-cone files, no index expansion
> +       ensure_not_expanded reset deepest -- deep/\* &&
> +
> +       # Wildcard identifies only full sparse directories, no index expansion
> +       ensure_not_expanded reset deepest -- folder\* &&
> +

You've added two testcases where a wildcard results in no index
expansion; should there also be a test where a wildcard results in
index expansion for completeness?
