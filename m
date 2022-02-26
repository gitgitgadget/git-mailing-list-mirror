Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B7CC433F5
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 08:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiBZIFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 03:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiBZIFt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 03:05:49 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2F4263405
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 00:05:15 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s24so10384546edr.5
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 00:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0M6+n9Xw/VVz0NizA5uNXmhRG31zJX7z1PlePXcol4=;
        b=cLbV0Fj3flBpRbswzllImCwWSkrJEA0nT6UwtCUsuz+hLuiLAOrY/sYmAox4s8eu6Z
         HBT/zcFA+J55Qr5J8+UGKjkBXk0+x5l0YLDggw4u5ScY5twLM8COzi5DG/ekuGY6ySaI
         oRxuUZZDV9+R4ihpAwkYCzod+tq+2fTzqoGs1IQgE4UQjuF/UDTheBZ+uSQUEnWIRW89
         KsIFoj2S9B726wyUZx/Fu4ZoWfWcY6ohyDUdq1xecx8AI9jMV1GPRv6xWCvsDtK5uiwC
         zIJJ51hEUnc61vbjn8tHl4KctCcaVJDHDGI1ftgWJRdNsxY+4BjraMNyJWOHNJTgVEUM
         n6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0M6+n9Xw/VVz0NizA5uNXmhRG31zJX7z1PlePXcol4=;
        b=UE7bFJCrMSX95wrZ83EDQ2YVyf5JufGDqhGVGkKTw091URxxiXBDz5KnZwo+aOLYkK
         AvamdTwVmBKRzMNBIqkp1Gbyaf+6QzvyvQswNAwVpPlZmu5d1MAtaF6+JNXIdA/JeGAt
         FUOzqInvSXo8y2gO+37M7KdrF3wOTYoDJuo5DtoP3ibdBWWOb9R/clLW/0POod0Uhqqf
         lUkUSKQ4Qr0cf5KAJV+emLuACrtxZ5j5IaBghLkNAkoI0h0FR/e7h2a6gEFfHKR1TqYx
         VdW3+MphOi06yaOo0nDu7YDLL1VDMysBOcPInompvn82N0VAErnIKCwi6TqY3nWvdAUd
         Z67Q==
X-Gm-Message-State: AOAM530Gt4tYdfgmDqSAWhOLWqXBlOCfM/nrJIB9/gPvGYy9jHu8AW8w
        WAVQnAxJxCdyOXJojIyJPFdp3cWVg1DBtxcup3Y=
X-Google-Smtp-Source: ABdhPJzumO6iG9oZ9Vs6T/6JC8G0+Y2tnJ2N7U/Pw8DlBl3+2cs/rABRmQLaQBmjvh15rXQYRGl6jKxVuYOv2UnDL44=
X-Received: by 2002:a05:6402:3553:b0:412:d0aa:e7b0 with SMTP id
 f19-20020a056402355300b00412d0aae7b0mr10403510edd.309.1645862713430; Sat, 26
 Feb 2022 00:05:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com> <9fdcab038b2962b7f954363e32d04591476cf219.1645640717.git.gitgitgadget@gmail.com>
In-Reply-To: <9fdcab038b2962b7f954363e32d04591476cf219.1645640717.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 26 Feb 2022 00:05:01 -0800
Message-ID: <CABPp-BHihsVQZWTE4ppOcFyk8-eVa+zZ1MhkssiTByxjPO4kcg@mail.gmail.com>
Subject: Re: [PATCH 6/7] read-tree: make two-way merge sparse-aware
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 4:09 PM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> Enable two-way merge with 'git read-tree' without expanding the sparse
> index. When in a sparse index, a two-way merge will trivially succeed as
> long as there are not changes to the same sparse directory in multiple trees
> (i.e., sparse directory-level "edit-edit" conflicts). If there are such
> conflicts, the merge will fail despite the possibility that individual files
> could merge cleanly.
>
> In order to resolve these "edit-edit" conflicts, "conflicted" sparse
> directories are - rather than rejected - merged by traversing their
> associated trees by OID. For each child of the sparse directory:
>
> 1. Files are merged as normal (see Documentation/git-read-tree.txt for
>    details).
> 2. Subdirectories are treated as sparse directories and merged in
>    'twoway_merge'. If there are no conflicts, they are merged according to
>    the rules in Documentation/git-read-tree.txt; otherwise, the subdirectory
>    is recursively traversed and merged.
>
> This process allows sparse directories to be individually merged at the
> necessary depth *without* expanding a full index.

The idea of merging directory-level entries turns out to be
problematic _if_ rename detection is involved, but read-tree-style
merges are only trivial merges that ignore rename detection.  As such,
this idea is perfectly reasonable, and is a good way to go.  Nicely
done.

Mostly the patch looks good.  There's one thing I'm wondering about, though...

>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/read-tree.c                      |  5 --
>  t/t1092-sparse-checkout-compatibility.sh |  3 +-
>  unpack-trees.c                           | 75 ++++++++++++++++++++++++
>  3 files changed, 77 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index a7b7f822281..5a421de2629 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -225,11 +225,6 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
>                         opts.fn = opts.prefix ? bind_merge : oneway_merge;
>                         break;
>                 case 2:
> -                       /*
> -                        * TODO: update twoway_merge to handle edit/edit conflicts in
> -                        * sparse directories.
> -                        */
> -                       ensure_full_index(&the_index);
>                         opts.fn = twoway_merge;
>                         opts.initial_checkout = is_cache_unborn();
>                         break;
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index a404be0a10f..d6f19682d65 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1411,7 +1411,8 @@ test_expect_success 'sparse index is not expanded: read-tree' '
>         init_repos &&
>
>         ensure_not_expanded checkout -b test-branch update-folder1 &&
> -       for MERGE_TREES in "update-folder2"
> +       for MERGE_TREES in "update-folder2" \
> +                          "base update-folder2"
>         do
>                 ensure_not_expanded read-tree -mu $MERGE_TREES &&
>                 ensure_not_expanded reset --hard HEAD || return 1
> diff --git a/unpack-trees.c b/unpack-trees.c
> index dba122a02bb..a4ace53904e 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1360,6 +1360,42 @@ static int is_sparse_directory_entry(struct cache_entry *ce,
>         return sparse_dir_matches_path(ce, info, name);
>  }
>
> +static int unpack_sparse_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
> +{
> +       struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
> +       struct unpack_trees_options *o = info->data;
> +       int ret;
> +
> +       assert(o->merge);
> +
> +       /*
> +        * Unlike in 'unpack_callback', where src[0] is derived from the index when
> +        * merging, src[0] is a transient cache entry derived from the first tree
> +        * provided. Create the temporary entry as if it came from a non-sparse index.
> +        */
> +       if (!is_null_oid(&names[0].oid)) {
> +               src[0] = create_ce_entry(info, &names[0], 0,
> +                                       &o->result, 1,
> +                                       dirmask & (1ul << 0));
> +               src[0]->ce_flags |= (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
> +       }
> +
> +       /*
> +        * 'unpack_single_entry' assumes that src[0] is derived directly from
> +        * the index, rather than from an entry in 'names'. This is *not* true when
> +        * merging a sparse directory, in which case names[0] is the "index" source
> +        * entry. To match the expectations of 'unpack_single_entry', shift past the
> +        * "index" tree (i.e., names[0]) and adjust 'names', 'n', 'mask', and
> +        * 'dirmask' accordingly.
> +        */
> +       ret = unpack_single_entry(n - 1, mask >> 1, dirmask >> 1, src, names + 1, info);

So, you're passing one less entry to unpack_single_entry() when you've
traversed into a sparse directory...won't the traversal at the next
subdirectory deeper then also pass one less entry to
unpack_single_entry(), so after recursing a directory or two, you only
have one directory left and it won't conflict with anything so it just
uses that remaining tree?  (Or maybe it passes the wrong number of
arguments into twoway_merge()?)  Did I miss something in the logic
somewhere that avoids that issue?  It'd be nice to test it out, which
brings me to...

> +
> +       if (src[0])
> +               discard_cache_entry(src[0]);
> +
> +       return ret >= 0 ? mask : -1;
> +}
> +
>  /*
>   * Note that traverse_by_cache_tree() duplicates some logic in this function
>   * without actually calling it. If you change the logic here you may need to
> @@ -2464,6 +2500,37 @@ static int merged_entry(const struct cache_entry *ce,
>         return 1;
>  }
>
> +static int merged_sparse_dir(const struct cache_entry * const *src, int n,
> +                            struct unpack_trees_options *o)
> +{
> +       struct tree_desc t[MAX_UNPACK_TREES + 1];
> +       void * tree_bufs[MAX_UNPACK_TREES + 1];
> +       struct traverse_info info;
> +       int i, ret;
> +
> +       /*
> +        * Create the tree traversal information for traversing into *only* the
> +        * sparse directory.
> +        */
> +       setup_traverse_info(&info, src[0]->name);
> +       info.fn = unpack_sparse_callback;
> +       info.data = o;
> +       info.show_all_errors = o->show_all_errors;
> +       info.pathspec = o->pathspec;
> +
> +       /* Get the tree descriptors of the sparse directory in each of the merging trees */
> +       for (i = 0; i < n; i++)
> +               tree_bufs[i] = fill_tree_descriptor(o->src_index->repo, &t[i],
> +                                                   src[i] && !is_null_oid(&src[i]->oid) ? &src[i]->oid : NULL);
> +
> +       ret = traverse_trees(o->src_index, n, t, &info);
> +
> +       for (i = 0; i < n; i++)
> +               free(tree_bufs[i]);
> +
> +       return ret;
> +}
> +
>  static int deleted_entry(const struct cache_entry *ce,
>                          const struct cache_entry *old,
>                          struct unpack_trees_options *o)
> @@ -2734,6 +2801,14 @@ int twoway_merge(const struct cache_entry * const *src,
>                          * reject the merge instead.
>                          */
>                         return merged_entry(newtree, current, o);
> +               } else if (S_ISSPARSEDIR(current->ce_mode)) {
> +                       /*
> +                        * The sparse directories differ, but we don't know whether that's
> +                        * because of two different files in the directory being modified
> +                        * (can be trivially merged) or if there is a real file conflict.
> +                        * Merge the sparse directory by OID to compare file-by-file.
> +                        */
> +                       return merged_sparse_dir(src, 3, o);
>                 } else
>                         return reject_merge(current, o);
>         }
> --
> gitgitgadget

It would be nice to have a couple of tests.  In particular, one
designed to see what happens when we need to traverse into
subdirectories of sparse directory entries and paths different between
the two trees being merged.
