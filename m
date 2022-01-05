Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387B9C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 17:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbiAERIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242142AbiAERIe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 12:08:34 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9C2C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 09:08:34 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y22so164751831edq.2
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 09:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5EC5ZKS2eu8snLpeEF8BZqYriO7rDoDyJC/RDOHA+k=;
        b=mychYn4ihAU3oEaONy2uh/2smKVjc3HqQNjIV+fSxSpcFQeFMh2mD07krtXOPUH4Xv
         b2BNgQ1Zow4r37YCNsYAbLe60Slpc515x/UsLYqIWpVRVPMuC7gT8EBWPEQUPL+dpTND
         heiao/vzkOQESX+qJMgRIHIlN3YyZzYzQw2/Lvk9nEq0qwZ/B273QiISfyRSQMIUPZHQ
         /hYFxOpjEF2jkvSTjP5jDVwwUKGFyh2PDg/SrJIa0I3qr3ljDM7hTd6NWQJaPx+fwv1K
         hAWp1/SoUYnlqq++3EwzujEPHSQcYEW2E5Q+N8PRtp/GKTRo1Uj1ecT6dSq8RMsQTLua
         UBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5EC5ZKS2eu8snLpeEF8BZqYriO7rDoDyJC/RDOHA+k=;
        b=cPIpdaA1M9gBQ0NrfJ1rupLLxAO2ViPaEZHjux60hLIvh7/EpEjGWVilZoImDlIGx1
         tZeenmz02wqooMoGFoaf0HhagooFOwf8zYGFNWx+2oah7zemAV1uJPRZVYptaGK/hywR
         vr5b3NW6e7bOe3t6DDao6lFnTSMRmOKmlk+ZtG7z7NXZBNTnETvp5R+aWKDkiRzQpJka
         FX076BUCfEXn5eB2ZUldLQ3r7UcXkZTh0UJo0B0a2MOBqkCSVsCkV+fYWEC96blZwQtC
         wdOBSHl8twBLe4Xucd+yxUcind1TPShWM0XQjeNOu7FZD6dRPNZ0FTQXpzi7xegxJKw7
         +xDQ==
X-Gm-Message-State: AOAM533puT7ICDrF6g5oOpkBSTzrTSk5grByZeShIyygxLw90aGqxa3u
        6ayIxycwkqVJ+UD77bQCnLxKfqZ/rmcB61ckjU7K5b43dK0=
X-Google-Smtp-Source: ABdhPJxOAyGv5SAUxFgEe0I3e9dX8P8YFJYctiVgV0tEiu1SHUFB6S12BfitXkeBvRaOD9XmJNru5HgxaiEWS7AkcrI=
X-Received: by 2002:a17:907:968a:: with SMTP id hd10mr42570114ejc.269.1641402512563;
 Wed, 05 Jan 2022 09:08:32 -0800 (PST)
MIME-Version: 1.0
References: <20220105163324.73369-1-chriscool@tuxfamily.org> <20220105163324.73369-2-chriscool@tuxfamily.org>
In-Reply-To: <20220105163324.73369-2-chriscool@tuxfamily.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Jan 2022 09:08:21 -0800
Message-ID: <CABPp-BFQv+mrWj8iH0Vo5Pr5L922v=ZsVthFjofy5pm1Sx8x5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] merge-ort: add new merge-tree-ort command
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 8:33 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> This new command is similar as merge-tree, but uses
> merge-ort code and features, especially
> merge_incore_nonrecursive(), instead of those from
> resursive merge, to perform the merge.

s/resursive/recursive/

> The output from this new command is very different from
> merge-tree's custom output, as we are only using code and
> features from diff.{h,c}, especially diff_tree_oid(). This
> should make it easy to customize and standardize the output
> using regular diff options in the future.
>
> This command will be extended to support new features
> with the long-term goal of enabling merges and rebases
> without a worktree.

And cherry-picks?  And reverts?

I think the cherry-pick/rebase replacement actually deserves a
separate command from what merges should use.  Replaying a sequence of
commits just has a number of UI differences and abilities that I think
pull it in a different direction.  And I don't want replaying of a
sequence of commits via a script like the old days (even if one that
calls something that doesn't update the working tree and index would
be better than the old rebases built on top of `git merge-recursive`
and `git cherry-pick`).  I'm working on such a thing, though it's
still kind of early.

>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  .gitignore               |  1 +
>  Makefile                 |  1 +
>  builtin.h                |  1 +
>  builtin/merge-tree-ort.c | 93 ++++++++++++++++++++++++++++++++++++++++
>  git.c                    |  1 +
>  5 files changed, 97 insertions(+)
>  create mode 100644 builtin/merge-tree-ort.c
>
> diff --git a/.gitignore b/.gitignore
> index 054249b20a..2dfcb1a589 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -98,6 +98,7 @@
>  /git-merge-index
>  /git-merge-file
>  /git-merge-tree
> +/git-merge-tree-ort
>  /git-merge-octopus
>  /git-merge-one-file
>  /git-merge-ours
> diff --git a/Makefile b/Makefile
> index 75ed168adb..915e500b06 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1124,6 +1124,7 @@ BUILTIN_OBJS += builtin/merge-index.o
>  BUILTIN_OBJS += builtin/merge-ours.o
>  BUILTIN_OBJS += builtin/merge-recursive.o
>  BUILTIN_OBJS += builtin/merge-tree.o
> +BUILTIN_OBJS += builtin/merge-tree-ort.o
>  BUILTIN_OBJS += builtin/merge.o
>  BUILTIN_OBJS += builtin/mktag.o
>  BUILTIN_OBJS += builtin/mktree.o
> diff --git a/builtin.h b/builtin.h
> index 8a58743ed6..c68f46b118 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -182,6 +182,7 @@ int cmd_merge_ours(int argc, const char **argv, const char *prefix);
>  int cmd_merge_file(int argc, const char **argv, const char *prefix);
>  int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
>  int cmd_merge_tree(int argc, const char **argv, const char *prefix);
> +int cmd_merge_tree_ort(int argc, const char **argv, const char *prefix);
>  int cmd_mktag(int argc, const char **argv, const char *prefix);
>  int cmd_mktree(int argc, const char **argv, const char *prefix);
>  int cmd_multi_pack_index(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/merge-tree-ort.c b/builtin/merge-tree-ort.c
> new file mode 100644
> index 0000000000..1c8ecd16ec
> --- /dev/null
> +++ b/builtin/merge-tree-ort.c
> @@ -0,0 +1,93 @@
> +#include "builtin.h"
> +#include "merge-ort.h"
> +#include "diff.h"
> +
> +static const char merge_tree_ort_usage[] = "git merge-tree-ort <base-tree> <branch1> <branch2>";

I think this is somewhat limiting to use for merges in general; it'll
generate trees that do not match what users get from `git merge ...`
at the command line, because specifying a single base-tree is
different than having the algorithm determine the merge base,
particularly when it needs to construct a virtual merge base.

> +
> +static void show_result(struct tree *base_tree,
> +                       struct tree *head_tree,
> +                       struct tree *merge_tree,
> +                       struct merge_result *result)
> +{
> +       const struct object_id *base_oid = &(base_tree->object.oid);
> +       const struct object_id *head_oid = &(head_tree->object.oid);
> +       const struct object_id *merge_oid = &(merge_tree->object.oid);
> +       const struct object_id *result_oid = &(result->tree->object.oid);
> +       struct diff_options opts;
> +
> +       repo_diff_setup(the_repository, &opts);
> +       opts.stat_width = -1; /* use full terminal width */
> +       opts.output_format |= DIFF_FORMAT_RAW | DIFF_FORMAT_PATCH;
> +       opts.detect_rename = DIFF_DETECT_RENAME;
> +       diff_setup_done(&opts);
> +
> +       printf("result tree: %s\n", oid_to_hex(result_oid));
> +       printf("clean: %d\n", result->clean);
> +
> +       printf("diff with branch1:\n");
> +       diff_tree_oid(head_oid, result_oid, "", &opts);
> +       diffcore_std(&opts);
> +       diff_flush(&opts);
> +
> +       printf("diff with branch2:\n");
> +       diff_tree_oid(merge_oid, result_oid, "", &opts);
> +       diffcore_std(&opts);
> +       diff_flush(&opts);
> +
> +       printf("diff with base:\n");
> +       diff_tree_oid(base_oid, result_oid, "", &opts);
> +       diffcore_std(&opts);
> +       diff_flush(&opts);

I commented on the diffs in my response on the cover letter.

> +}
> +
> +static struct commit *get_commit_by_name_or_die(const char *name)
> +{
> +       struct commit *c = lookup_commit_reference_by_name(name);
> +       if (!c)
> +               die(_("not a valid commit name '%s'"), name);
> +       return c;
> +}
> +
> +static void merge_trees_ort(const char *base_name,
> +                           const char *branch1,
> +                           const char *branch2)
> +{
> +       struct merge_result result;
> +       struct merge_options merge_opt;
> +
> +       struct commit *base = get_commit_by_name_or_die(base_name);
> +       struct commit *head = get_commit_by_name_or_die(branch1);
> +       struct commit *merge = get_commit_by_name_or_die(branch2);
> +
> +       struct tree *base_tree = get_commit_tree(base);
> +       struct tree *head_tree = get_commit_tree(head);
> +       struct tree *merge_tree = get_commit_tree(merge);
> +
> +       memset(&result, 0, sizeof(result));
> +       init_merge_options(&merge_opt, the_repository);
> +
> +       merge_opt.show_rename_progress = 1;
> +       merge_opt.branch1 = branch1;
> +       merge_opt.branch2 = branch2;
> +       merge_opt.ancestor = base_name;
> +
> +       result.tree = head_tree;
> +
> +       merge_incore_nonrecursive(&merge_opt,
> +                                 base_tree,
> +                                 result.tree,
> +                                 merge_tree,
> +                                 &result);

I think for server side merges, merge_incore_recursive() should be
used, so that they match what a `git merge ...` would provide.  I
think merge_incore_nonrecursive() is better used for replaying a
sequence of commits.

So, I view this as more suitable for usage with the server side
rebase, except that it seems to be serving as a building block and
expecting the rebase to be some script on top.  I think server-side
rebase/cherry-pick should be a builtin of some form.

> +
> +       show_result(base_tree, head_tree, merge_tree, &result);

As noted in the cover letter, this current form doesn't provide 2
things that users can't get some other way: (1) a list of conflicted
paths, and (2) the various conflict and warning messages generated
during the merge.  I agree that many usecases might not want those,
but since they can't be obtained another way I think it'd be prudent
to provide them.

And this show_result provides 3 things that users could generate on
their own with the information already provided -- namely the three
diffs that you do.  I'm curious what the usecase is for those diffs.

> +}
> +
> +int cmd_merge_tree_ort(int argc, const char **argv, const char *prefix)
> +{
> +       if (argc != 4)
> +               usage(merge_tree_ort_usage);
> +
> +       merge_trees_ort(argv[1], argv[2], argv[3]);
> +
> +       return 0;
> +}
> diff --git a/git.c b/git.c
> index 7edafd8ecf..90b8a4984c 100644
> --- a/git.c
> +++ b/git.c
> @@ -562,6 +562,7 @@ static struct cmd_struct commands[] = {
>         { "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>         { "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>         { "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
> +       { "merge-tree-ort", cmd_merge_tree_ort, RUN_SETUP | NO_PARSEOPT },
>         { "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
>         { "mktree", cmd_mktree, RUN_SETUP },
>         { "multi-pack-index", cmd_multi_pack_index, RUN_SETUP },
> --
> 2.34.1.433.g7bc349372a.dirty
