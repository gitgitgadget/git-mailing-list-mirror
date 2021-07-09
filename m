Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EA0C07E96
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 01:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C327861477
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 01:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhGIBGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 21:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhGIBGt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 21:06:49 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7701C061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 18:04:05 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so7749764otp.8
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 18:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uc12zShIMOxzXSsUDQTUF/+FFphYZw058UdU/7hHsbA=;
        b=qEoB21novw5RO5LwqJUM68pifUJWIDrrASFO3w1IzmvxbvSu8GOWjkaInTmHWA5QU7
         numEbnjiswIDdSJohLftGQy2E5ClHBrO+2rAZNQx+NL2mvfV+ceL6be3ryp23ehx4opK
         6xHDf66DQbvMYbw4KGp1hM/MaTy0BfDPSJ2O2vgaR2LklT122UARujgZXAOGJc/Ql4AN
         RzIQnE4R0Y/EZb7OnIOcmJn4Ym6Mmz7ZhTCd+IUGuz6ypYu4YOUKD6G29/+Jl3x73Ndm
         pIVJUSfShhDvo6HOTJSxwAd9R080u+SgCr1CFZn8QflvKNLVK5UbRxOKUMXH4YrNHGnv
         zFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uc12zShIMOxzXSsUDQTUF/+FFphYZw058UdU/7hHsbA=;
        b=nhmgHfw67K7WZiFXb7E+mQX5M3Ey6b9UFPHcVtB7gULVWOoTT7/p4lmg2I8sUIgulH
         Jr3HKkpZV3JYiWqtXybChCgEuSObQKvuO4SgA6Lv1Fj6QKzDELCDIcouDk+qbUBmPogY
         odpBC6k8go9UsQ0vR1M4qqHmhUfFlh5yGYHhTuANbXNh+btiIxNmMU7HaM/a4wIGjsnB
         ucXBH3+d0gPbszKsg9RVfDJsmD8EkG8+FR3TbN4srIrz4/t0LUbO/lEJ35MijyDoSvgy
         N4s78j4KVJoVNNoq2cLmboxaLRVG3aIohnyVcFIwVE5qpt8K89Y9C10ppHdy8crFTvpg
         q+gg==
X-Gm-Message-State: AOAM530Ifp3Cvq8DFhkf4KPPwd1DZGNBg8Dlr68IxofKm+bhr39aKCkh
        80HkCi8ccSQhDEkY9buXAMS+2At4mWHRIMsY9j0=
X-Google-Smtp-Source: ABdhPJwaMvzdF0EpBq2YJshKcSKL7pP/uos/YfJV8YzvR6Y7VM1dUyS3QvuCUMm22xnvq4Ce8r2U1BqT5NcIm94ASFo=
X-Received: by 2002:a9d:6d03:: with SMTP id o3mr23208243otp.316.1625792645100;
 Thu, 08 Jul 2021 18:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
 <pull.932.v7.git.1624932293.gitgitgadget@gmail.com> <717a3f49f97753149d5c435a83b3f1773dd4b1bb.1624932294.git.gitgitgadget@gmail.com>
In-Reply-To: <717a3f49f97753149d5c435a83b3f1773dd4b1bb.1624932294.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 8 Jul 2021 18:03:54 -0700
Message-ID: <CABPp-BE=qw9pO89hggUFbu=eovfL=7Os5BY8DZNd5Z=qU==wFg@mail.gmail.com>
Subject: Re: [PATCH v7 15/16] wt-status: expand added sparse directory entries
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 7:05 PM Derrick Stolee via GitGitGadget
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
>  t/t1092-sparse-checkout-compatibility.sh | 33 +++++++++++++++
>  wt-status.c                              | 51 ++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index fed0440bafe..df217a2d10b 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -545,4 +545,37 @@ test_expect_success 'sparse-index is not expanded' '
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

The same issue I highlighted last time is still present.  If you
insert an "exit 1" right here, then run
    ./t1092-sparse-checkout-compatibility.sh --ver --imm -x
until it stops, then
    cd t/trash directory.t1092-sparse-checkout-compatibility/sparse-checkout
    git ls-files -t | grep folder  # Note the files that are sparse
    git reset --mixed HEAD~1
    git ls-files -t | grep folder  # Note the files that are sparse --
there are some that aren't that should be
    git sparse-checkout reapply
    git ls-files -t | grep folder  # Note the files that are sparse

Granted, this is a bug with sparse-checkout without sparse-index, so
not something new to your series.  But since you are using comparisons
between regular sparse-checkouts and sparse-index to verify
correctness, this seems problematic to me.

> +       test_sparse_match git reset --mixed HEAD~1 &&
> +       test_sparse_match test-tool read-cache --table --expand &&
> +       test_sparse_match git status --porcelain=v2 &&
> +
> +       # At this point, sparse-checkouts behave differently
> +       # from the full-checkout.
> +       test_sparse_match git checkout --orphan new-branch &&
> +       test_sparse_match test-tool read-cache --table --expand &&
> +       test_sparse_match git status --porcelain=v2
> +'
> +
> +test_expect_success 'add everything with deep new file' '
> +       init_repos &&
> +
> +       run_on_sparse git sparse-checkout set deep/deeper1/deepest &&
> +
> +       run_on_all touch deep/deeper1/x &&
> +       test_all_match git add . &&
> +       test_all_match git status --porcelain=v2
> +'
> +
>  test_done
> diff --git a/wt-status.c b/wt-status.c
> index 96db3e74962..0317baef87e 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -657,6 +657,36 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>         clear_pathspec(&rev.prune_data);
>  }
>
> +static int add_file_to_list(const struct object_id *oid,
> +                           struct strbuf *base, const char *path,
> +                           unsigned int mode, void *context)
> +{
> +       struct string_list_item *it;
> +       struct wt_status_change_data *d;
> +       struct wt_status *s = context;
> +       struct strbuf full_name = STRBUF_INIT;
> +
> +       if (S_ISDIR(mode))
> +               return READ_TREE_RECURSIVE;
> +
> +       strbuf_add(&full_name, base->buf, base->len);
> +       strbuf_addstr(&full_name, path);
> +       it = string_list_insert(&s->change, full_name.buf);
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
> +       strbuf_release(&full_name);
> +       return 0;
> +}
> +
>  static void wt_status_collect_changes_initial(struct wt_status *s)
>  {
>         struct index_state *istate = s->repo->index;
> @@ -671,6 +701,27 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
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
> +                       struct pathspec ps = { 0 };
> +                       struct tree *tree = lookup_tree(istate->repo, &ce->oid);
> +
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
