Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E25C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3F660EB2
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhGWRgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhGWRgp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 13:36:45 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6621C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:17:18 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 48-20020a9d0bb30000b02904cd671b911bso2951623oth.1
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wTSAyEnyKiLycPuBreBnch5gqaZ/0SQSyBS8h2UvzO8=;
        b=oN3v5tLjTMtmC5l+kkpolB2j5XBBGsn3YZAogsxSsb8L4Kamu20frsglxb6IPyOnQ3
         sBfoMgDbZzpCcDdw6xZ8epFUfPhRaFNISRPb5Xghz3ixRFzQaiRMdu7tJv8mqpnB2c0Q
         79lwkIaj/upMxL2JU5o48ZVSim2pzq60DXYSpv/RzmIyddnFhrRz64ikuodOAx9oT401
         jITR+xzGUY+3+SxqQxbHTj45q5CsRcMkLt0dCBDFQQwN5oXHjsz3WkSXg6cFBu/YbcgH
         ffkuR8ETPgOgEAw3pdO9cPWuqubZB8vZvmokmvzCxJYD+bDB43xFWzVlW6SD0bfqU/UV
         ZGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wTSAyEnyKiLycPuBreBnch5gqaZ/0SQSyBS8h2UvzO8=;
        b=YQyzvdGDwoZv92WHT5I8FfoOrU2yCkRrEwLhYjmphKImdVB9WnFllNioFGmBNR/Nh1
         8ea/zzPkQkRN0P9320tcpSIWHhgH2cthsAO12Yo6AmT8kG5Ls/s3hCTvoEmCigwBIZL3
         2qskZzVWorUIsMIrqlVnyxoLtzJUgN7qRS9YExF+DI8J6eZ45E4Hm/BisIIQV12ncPkM
         kheF4sTkpFshPCFM2U5PTmbzhjE3jfqFlWm/l2qsh8DArirhIKZfnU89ggAsSnidUmbm
         DzOo+2/48jVcBN797sAAkYyrpMOUtKAJl5UWfLBqehIuXa3zSuzA7ovpHiD+pStbEaIV
         P4dQ==
X-Gm-Message-State: AOAM530OjbTlCZd74udBK3tzY5IuDZSi44ayBR+E9iwQsYu6B/eXLt+P
        ZYJ53vpve4tLurSTW/d7PCNsInMytFqR7wT1TuE=
X-Google-Smtp-Source: ABdhPJyHOGPyH7PT1Ld8Tj3BTyk88fLgaCiWOIuIkPpuig/EqameyFcIyr6Yqi93i8zEOHXQYRuXJH/+H2oIDTyPXFk=
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr3883349ots.162.1627064238095;
 Fri, 23 Jul 2021 11:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.999.git.1626901619.gitgitgadget@gmail.com> <a577ea4c74d86e57defcc4f45011871b634bcf56.1626901619.git.gitgitgadget@gmail.com>
In-Reply-To: <a577ea4c74d86e57defcc4f45011871b634bcf56.1626901619.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Jul 2021 11:17:07 -0700
Message-ID: <CABPp-BFPDoqfJs1YoeEBhJnEtz=5Owr61=nBwHyV8Gho7uTn3Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] pathspec: stop calling ensure_full_index
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

On Wed, Jul 21, 2021 at 2:07 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The add_pathspec_matches_against_index() focuses on matching a pathspec
> to file entries in the index. This already works correctly for its only
> use: checking if untracked files exist in the index.
>
> The compatibility checks in t1092 already test that 'git add <dir>'
> works for a directory outside of the sparse cone. That provides coverage
> for removing this guard.
>
> This finalizes our ability to run 'git add .' without expanding a sparse
> index to a full one. This is evidenced by an update to t1092 and by
> these performance numbers for p2000-sparse-operations.sh:
>
> Test                                    HEAD~1            HEAD
> --------------------------------------------------------------------------------
> 2000.10: git add . (full-index-v3)      0.37(0.28+0.07)   0.36(0.27+0.06) -2.7%
> 2000.11: git add . (full-index-v4)      0.33(0.26+0.06)   0.32(0.28+0.05) -3.0%
> 2000.12: git add . (sparse-index-v3)    0.57(0.53+0.07)   0.06(0.06+0.07) -89.5%
> 2000.13: git add . (sparse-index-v4)    0.57(0.53+0.07)   0.05(0.03+0.09) -91.2%
>
> While the ~90% improvement is shown by the test results, it is worth
> noting that expanding the sparse index was adding overhead in previous
> commits. Comparing to the full index case, we see the performance go
> from 0.33s to 0.05s, an 85% improvement.

These perf improvements are pretty sweet.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  pathspec.c                               | 2 --
>  t/t1092-sparse-checkout-compatibility.sh | 7 +++----
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/pathspec.c b/pathspec.c
> index 08f8d3eedc3..44306fdaca2 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -37,8 +37,6 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>                         num_unmatched++;
>         if (!num_unmatched)
>                 return;
> -       /* TODO: audit for interaction with sparse-index. */
> -       ensure_full_index(istate);
>         for (i = 0; i < istate->cache_nr; i++) {
>                 const struct cache_entry *ce = istate->cache[i];
>                 if (sw_action == PS_IGNORE_SKIP_WORKTREE && ce_skip_worktree(ce))
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index a11d9d7f35d..f9e2f5f4aa1 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -322,9 +322,6 @@ test_expect_success 'commit including unstaged changes' '
>  test_expect_success 'status/add: outside sparse cone' '
>         init_repos &&
>
> -       # adding a "missing" file outside the cone should fail
> -       test_sparse_match test_must_fail git add folder1/a &&
> -

So this is removed because of non-matching errors.  In particular,
sparse-checkout shows
"""
The following pathspecs didn't match any eligible path, but they do match index
entries outside the current sparse checkout:
folder1/a
hint: Disable or modify the sparsity rules if you intend to update such entries.
hint: Disable this message with "git config advice.updateSparsePath false"
"""
while sparse-index now shows:
"""
fatal: pathspec 'folder1/a' did not match any files
"""

The new error seems entirely reasonable to me.  No objection here.


But allow me to go on a bit of a diversion...

If we modify this setup slightly by running:

$ mkdir folder1
$ echo garbage >folder1/a
$ git add folder1/a

Then you'll get the first of those errors in both the sparse-index and
the sparse-checkout.  I also like this behavior.

If you unset the SKIP_WORKTREE bit manually, and then add:

$ git update-index --no-skip-worktree folder1/a
$ git add folder1/a

Then the file is added with no error or warning.  I like this behavior too.

If you further change the setup with:

$ echo more garbage >folder1/z
$ git add folder1/z

Then you get no error, despite folder1/z being an untracked file
outside of sparsity paths.  No bueno.  :-(

>         # folder1 is at HEAD, but outside the sparse cone
>         run_on_sparse mkdir folder1 &&
>         cp initial-repo/folder1/a sparse-checkout/folder1/a &&
> @@ -633,7 +630,9 @@ test_expect_success 'sparse-index is not expanded' '
>         echo >>sparse-index/README.md &&
>         ensure_not_expanded add -A &&
>         echo >>sparse-index/extra.txt &&
> -       ensure_not_expanded add extra.txt
> +       ensure_not_expanded add extra.txt &&
> +       echo >>sparse-index/untracked.txt &&
> +       ensure_not_expanded add .

:-)

>  '
>
>  # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
> --

So I added a lot of comments here, in part because I thought I'd test
a bit more of what I said in response to your cover letter and see how
close to it we were.  The patch in question looks fine.

I just added an aside as a convenient place to check whether the
behavior at the end of the series matches what you proposed in the
cover letter, or what I proposed in response.  It appears it matches
neither (though that's not due to this specific patch).
