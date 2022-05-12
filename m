Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7988BC433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 14:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355602AbiELOvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 10:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345370AbiELOvt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 10:51:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E875DA01
        for <git@vger.kernel.org>; Thu, 12 May 2022 07:51:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n10so10763888ejk.5
        for <git@vger.kernel.org>; Thu, 12 May 2022 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0nyQuROR62eBUNxyGJd3C+9X3x+utPVMrDIO3v1rJfg=;
        b=cb1xRySsajBMgK0tvA3T/XlBqCZRqXYE9TFIG1axks0bKtiGHZ6sRbkl2JQkF/doro
         vnH6exco7PHZXLyxIGJcuLL96KkRtl2ez59eIxP4C8/dVf1y5IlHTDCS39dULLGqhZSW
         UleuywDxmBNgiABmJgg3mGhP5gkgRO0dha4RiqZ2F3IJyYCKy5ZzqUlktbJhE7CfhugS
         ie55AbpxZKwiASnqRqZedaQWWwmdkkVRD2/pjNzItUVfkrRb4Og0zLL38xVDA46rfZli
         R4FLUb1++GOOjN8oK1/dNVda0qijidJV6C79VaXOPDiY5V/kHUBycA+WMOJV7wjf7wLM
         /4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0nyQuROR62eBUNxyGJd3C+9X3x+utPVMrDIO3v1rJfg=;
        b=r7KI6Bp0GLhlCWxHwlqxho8cHu8LoOrGW0k+d/pApmK+zzIvSlYn6PvXhYnHHfmPty
         FyAbeCYXsI/r3E4ofIWitMfFZFnTs4Vuo8gqh7JxNte/QiCi+Ge7BEBDCtlV+OTsu3yU
         idMOgD2WUuoFUQE85y4NjMRcDtAXAwTdw4V8/trFw8YKS4GpzwLso/jPb3eNFTwftTu8
         2H+ye9nqjvnfcYa6gykgjHolFQV5syFdK6fpe/GNojcaHeVc6ZMVP7hSb2K9Re+n1gYC
         PU00ZYsI/k5dhSPu6CsCWDOl3kV1W0ivjUdS70dovtJ3fbQr1T2F56vbYo6a+V3UXzxu
         LiLA==
X-Gm-Message-State: AOAM532ubWceUez/Snc8jWxe2SK+DjoF7+QfVcn5d/YUuUVlCuvQqc6d
        GDSNJkHO1Klwt+wI3N8y+t053CC3R3/KUJB+mzZzmTfq
X-Google-Smtp-Source: ABdhPJxXFiFBYaialzHTB7d4PfTFfloY1Lr67Xeuiq9+cP5D7MGofcmOVKHN5JGAdX9iebtmh4mGUhu4e0D7+gimvd0=
X-Received: by 2002:a17:906:a05a:b0:6ef:a44d:2f46 with SMTP id
 bg26-20020a170906a05a00b006efa44d2f46mr282781ejb.192.1652367106565; Thu, 12
 May 2022 07:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
 <pull.1171.v3.git.1652225552.gitgitgadget@gmail.com> <e733c2fd9f497a8d80555126ec2e166e182ab8db.1652225552.git.gitgitgadget@gmail.com>
In-Reply-To: <e733c2fd9f497a8d80555126ec2e166e182ab8db.1652225552.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 May 2022 07:51:35 -0700
Message-ID: <CABPp-BGf35aOYb-nua-i16MOL_14w9c=QETjsGnKzE6D2rr27A@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] stash: apply stash using 'merge_ort_nonrecursive()'
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 10, 2022 at 4:32 PM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> Update 'stash' to use 'merge_ort_nonrecursive()' to apply a stash to the
> current working tree. When 'git stash apply' was converted from its shell
> script implementation to a builtin in 8a0fc8d19d (stash: convert apply to
> builtin, 2019-02-25), 'merge_recursive_generic()' was used to merge a stash
> into the working tree as part of 'git stash (apply|pop)'. However, with the
> single merge base used in 'do_apply_stash()', the commit wrapping done by
> 'merge_recursive_generic()' is not only unnecessary, but misleading (the
> *real* merge base is labeled "constructed merge base"). Therefore, a
> non-recursive merge of the working tree, stashed tree, and stash base tree
> is more appropriate.
>
> There are two options for a non-recursive merge-then-update-worktree
> function: 'merge_trees()' and 'merge_ort_nonrecursive()'. Use
> 'merge_ort_nonrecursive()' to align with the default merge strategy used by
> 'git merge' (6a5fb96672 (Change default merge backend from recursive to ort,
> 2021-08-04)) and, because merge-ort does not operate in-place on the index,
> avoid unnecessary index expansion. Update tests in 't1092' verifying index
> expansion for 'git stash' accordingly.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/stash.c                          | 30 +++++++++++++++++++-----
>  t/t1092-sparse-checkout-compatibility.sh |  4 ++--
>  2 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 1bfba532044..3fe549f7d3c 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -7,6 +7,7 @@
>  #include "cache-tree.h"
>  #include "unpack-trees.h"
>  #include "merge-recursive.h"
> +#include "merge-ort-wrappers.h"
>  #include "strvec.h"
>  #include "run-command.h"
>  #include "dir.h"
> @@ -492,13 +493,13 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
>  static int do_apply_stash(const char *prefix, struct stash_info *info,
>                           int index, int quiet)
>  {
> -       int ret;
> +       int clean, ret;
>         int has_index = index;
>         struct merge_options o;
>         struct object_id c_tree;
>         struct object_id index_tree;
> -       struct commit *result;
> -       const struct object_id *bases[1];
> +       struct tree *head, *merge, *merge_base;
> +       struct lock_file lock = LOCK_INIT;
>
>         read_cache_preload(NULL);
>         if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
> @@ -541,6 +542,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>
>         o.branch1 = "Updated upstream";
>         o.branch2 = "Stashed changes";
> +       o.ancestor = "Stash base";
>
>         if (oideq(&info->b_tree, &c_tree))
>                 o.branch1 = "Version stash was based on";
> @@ -551,10 +553,26 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>         if (o.verbosity >= 3)
>                 printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
>
> -       bases[0] = &info->b_tree;
> +       head = lookup_tree(o.repo, &c_tree);
> +       merge = lookup_tree(o.repo, &info->w_tree);
> +       merge_base = lookup_tree(o.repo, &info->b_tree);
> +
> +       repo_hold_locked_index(o.repo, &lock, LOCK_DIE_ON_ERROR);
> +       clean = merge_ort_nonrecursive(&o, head, merge, merge_base);

A very minor nit: I actually have a minor dislike for the
merge-ort-wrappers, but I included them in case people objected to the
slightly more verbose real API.  I assumed it'd only be used to
convert existing calls to merge_trees() and merge_recursive(); in this
case you were converting a call to merge_recursive_generic(), so I
would have preferred using merge_incore_nonrecursive().  That might
have answered Jonathan's question better too when he saw the explicit
merge_switch_to_result() call.  However, it's a minor point; I'm not
sure it's worth a re-roll.


This series looks good to me:
Reviewed-by: Elijah Newren <newren@gmail.com>
