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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009ADC47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 05:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F9D611BD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 05:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbhFIF3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 01:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhFIF3r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 01:29:47 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB81C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 22:27:40 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t140so18761676oih.0
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 22:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z09JN1s4+sxDqupY7bTFhRnNTo3ya7y4rrrM7OwXtAg=;
        b=FktrbjNvQ1ShLTBl2hU4RU61fMjGd8uu8lST8lCpR74b9FxTmjU60q+eGd2otRK3ab
         VSJ5wO1mIOkh3e+zR2xKsDlIidH9tkfTjjX13WJ6VZLWA+7Cc5Yadj4aIPAFhI8FMOBn
         MtD3tK9pVGSpLKt5Zt0MMZT2TnyHBTR23sGwGY3wxnbO5coJZ+W9pj7lxeC3ABDAaXx5
         ZkkOmkyzNckdbyCKZsCEIwwrbFAtT3uXiJtl+OC9Q4sMqum/fF7ELchxW16o8Fn4wSsi
         b0QhF/+LwU6DwPyuJLHwoXaV1Lj4A4VAym4lRvRINzm5IifmdFginvMnVu1XlCR44tVJ
         V7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z09JN1s4+sxDqupY7bTFhRnNTo3ya7y4rrrM7OwXtAg=;
        b=YBksXJi6RwycFV9x9BipN5y/rO1hlfpydKxfE3YSEcN4nLSKR7SaPtEi+S6fgSrxBp
         fl65rb5uPMCVVYooOJNr8jw0AZCWZkPZNrfW7SA/6FQYU6UYpuqtWYPWh2VA6XYiFfV/
         WVVsov9vjNtPxqKm3bxDB8oi1qLkcjhpCWOZpzMQ/LK4lrY83XrXNAAbf3y/vPCehvom
         R0BwQ7ye109MvSXf1fnuE1LQXfKK4WLxzzRjic2qKqKOJ2GDljQRpSFc6tx3o9AV1/Ft
         9mxJN94BsHEZHqT6TGI6Ox5QzqszQ1iikJqpUUvJ2D+o1DOmxNEPmuoJTvfBAT5JNTjj
         BkJQ==
X-Gm-Message-State: AOAM533ucuLWiDfL8b9LTWg8E2girlTgxlQpAz7XQYERrmp0OA8gVKeZ
        QuFZx4VmAU2T6Y2uOzZO+66kIWI1DgRoYRVehR4=
X-Google-Smtp-Source: ABdhPJyjpKKNZRaF29ppdpPmDIQ+avyWKN+KFPq47ZG6aN/K56r7thkV/7s+GML+aj2mjkboQWEtWUN1WfqSY/3aSEY=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr5390677oiw.31.1623216459504;
 Tue, 08 Jun 2021 22:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <pull.932.v5.git.1623069252.gitgitgadget@gmail.com> <02f2c7b63982cfbafc300e1cd901473d5b9b7297.1623069253.git.gitgitgadget@gmail.com>
In-Reply-To: <02f2c7b63982cfbafc300e1cd901473d5b9b7297.1623069253.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Jun 2021 22:27:28 -0700
Message-ID: <CABPp-BHOcDUJbA0ZRvxhOKryp3wdXj1yOrTovQBJi3PEoAMY_Q@mail.gmail.com>
Subject: Re: [PATCH v5 13/14] wt-status: expand added sparse directory entries
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 7, 2021 at 5:34 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> It is difficult, but possible, to get into a state where we intend to
> add a directory that is outside of the sparse-checkout definition. Add a
> test to t1092-sparse-checkout-compatibility.sh that demonstrates this
> using a combination of 'git reset --mixed' and 'git checkout --orphan'.
>
> This test failed before because the output of 'git status
> --porcelain=v2' would not match on the lines for folder1/:
>
> * The sparse-checkout repo (with a full index) would output each path
>   name that is intended to be added.
>
> * The sparse-index repo would only output that "folder1/" is staged for
>   addition.
>
> The status should report the full list of files to be added, and so this
> sparse-directory entry should be expanded to a full list when reaching
> it inside the wt_status_collect_changes_initial() method. Use
> read_tree_at() to assist.
>
> Somehow, this loop over the cache entries was not guarded by
> ensure_full_index() as intended.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 36 +++++++++++++++++
>  wt-status.c                              | 50 ++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 099dc2bf440f..39b86fbe2be6 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -521,4 +521,40 @@ test_expect_success 'sparse-index is not expanded' '
>         test_region ! index ensure_full_index trace2.txt
>  '
>
> +test_expect_success 'reset mixed and checkout orphan' '
> +       init_repos &&
> +
> +       test_all_match git checkout rename-out-to-in &&
> +
> +       # Sparse checkouts do not agree with full checkouts about
> +       # how to report a directory/file conflict during a reset.
> +       # This command would fail with test_all_match because the
> +       # full checkout reports "T folder1/0/1" while a sparse
> +       # checkout reports "D folder1/0/1". This matches because
> +       # the sparse checkouts skip "adding" the other side of
> +       # the conflict.
> +       test_sparse_match git reset --mixed HEAD~1 &&

Ooh!  I think you found a sparse-checkout bug here.  I agree that
sparse-checkouts and full-checkouts should give different output in
this case, but I don't think the current difference is the correct
one.  Digging in a little closer, before running `git reset --mixed
HEAD~1` I see:

$ git ls-files -t | grep folder
S folder1/0/0/0
S folder1/0/1
S folder2/0/0/0
S folder2/0/1/1
S folder2/a
S folder2/larger-content

and after running git reset --mixed HEAD~1, I see:
S folder1/0/0/0
S folder1/0/1
H folder1/a
H folder1/larger-content
S folder2/0/0/0
H folder2/0/1
S folder2/a
S folder2/larger-content

meaning that the reset of the index failed.  It thinks some entries
are present in the working copy, though it didn't actually check any
of them out, leaving them to be marked as deleted.  This leaves the
sparse-checkout in a messed up state.  To correct it, I need to run
either of the following:

    git diff --diff-filter=D --name-only | xargs git update-index
--skip-worktree

or

    git sparse-checkout reapply

(Though one could ask whether sparse-checkout reapply should take a
missing file that isn't SKIP_WORKTREE and determine it's okay to just
mark it as SKIP_WORKTREE rather than treating it as dirty.  I'm not
sure the answer to that...)

I really think that `git reset --mixed ...` should have been getting
the sparsity right on its own without the manual fixup afterwards that
I needed to add.

> +       test_sparse_match test-tool read-cache --table --expand &&

If both the full and the sparse checkouts do a reset --mixed, I would
think that this step should be able to use a test_all_match...at least
if reset --mixed weren't broken.

> +       test_sparse_match git status --porcelain=v2 &&
> +       test_sparse_match git status --porcelain=v2 &&

Why is this test run twice?

> +
> +       # At this point, sparse-checkouts behave differently
> +       # from the full-checkout.
> +       test_sparse_match git checkout --orphan new-branch &&
> +       test_sparse_match test-tool read-cache --table --expand &&
> +       test_sparse_match git status --porcelain=v2 &&
> +       test_sparse_match git status --porcelain=v2

And again, you run the status twice...why?

> +'
> +
> +test_expect_success 'add everything with deep new file' '
> +       init_repos &&
> +
> +       run_on_sparse git sparse-checkout set deep/deeper1/deepest &&
> +
> +       run_on_all touch deep/deeper1/x &&
> +       test_all_match git add . &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git status --porcelain=v2

same question.

> +'
> +
>  test_done
> diff --git a/wt-status.c b/wt-status.c
> index 0425169c1895..90db8bd659fa 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -654,6 +654,34 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>         run_diff_index(&rev, 1);
>  }
>
> +static int add_file_to_list(const struct object_id *oid,
> +                           struct strbuf *base, const char *path,
> +                           unsigned int mode, void *context)
> +{
> +       struct string_list_item *it;
> +       struct wt_status_change_data *d;
> +       struct wt_status *s = context;
> +       char *full_name;
> +
> +       if (S_ISDIR(mode))
> +               return READ_TREE_RECURSIVE;
> +
> +       full_name = xstrfmt("%s%s", base->buf, path);
> +       it = string_list_insert(&s->change, full_name);
> +       d = it->util;
> +       if (!d) {
> +               CALLOC_ARRAY(d, 1);
> +               it->util = d;
> +       }
> +
> +       d->index_status = DIFF_STATUS_ADDED;
> +       /* Leave {mode,oid}_head zero for adds. */
> +       d->mode_index = mode;
> +       oidcpy(&d->oid_index, oid);
> +       s->committable = 1;
> +       return 0;
> +}
> +
>  static void wt_status_collect_changes_initial(struct wt_status *s)
>  {
>         struct index_state *istate = s->repo->index;
> @@ -668,6 +696,28 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
>                         continue;
>                 if (ce_intent_to_add(ce))
>                         continue;
> +               if (S_ISSPARSEDIR(ce->ce_mode)) {
> +                       /*
> +                        * This is a sparse directory entry, so we want to collect all
> +                        * of the added files within the tree. This requires recursively
> +                        * expanding the trees to find the elements that are new in this
> +                        * tree and marking them with DIFF_STATUS_ADDED.
> +                        */
> +                       struct strbuf base = STRBUF_INIT;
> +                       struct pathspec ps;
> +                       struct tree *tree = lookup_tree(istate->repo, &ce->oid);
> +
> +                       memset(&ps, 0, sizeof(ps));
> +                       ps.recursive = 1;
> +                       ps.has_wildcard = 1;
> +                       ps.max_depth = -1;
> +
> +                       strbuf_add(&base, ce->name, ce->ce_namelen);
> +                       read_tree_at(istate->repo, tree, &base, &ps,
> +                                    add_file_to_list, s);
> +                       continue;
> +               }
> +
>                 it = string_list_insert(&s->change, ce->name);
>                 d = it->util;
>                 if (!d) {
> --
> gitgitgadget
>
