Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EF5C07E9D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 04:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71B161283
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 04:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhGVDio (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhGVDin (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 23:38:43 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20154C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 21:19:17 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id a132so5256954oib.6
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 21:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9KegCQcgfKAsOAKYkGKgCLyzW4bSTh3UkCcSqNjtsw=;
        b=TIwh5ruCbl0u2MQ2We/+GP3Ecv9UwZ2MK5Qu5nssNZ7ykmAoPEv3wTUlJ8jxHRT1bQ
         pC+A2ZmLVcvp7SMD7k5yExS4QbRa5zCFbe3d7BI8MxBch/ioVTW23QZ0t9KNihaMIx6F
         WEhF52yvTdhbys7bab2z7bA57XYY5OZ4EUG9+9jv0y+XlbISSy4pdasdnrjKhi8/ROW7
         ZWl2h3qhV6E7j34LlF6Fgr3PXTcQFoVej0NNVJDxDKenEOvvyfMGe8Kfv6IKTrleQ3o/
         j28eGjgjh9Cn33m9+XF8yYuoy2yffI64rJ9jRXVfk+pQCt5rubxC/XI4Nr2eHMe8+BFa
         hcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9KegCQcgfKAsOAKYkGKgCLyzW4bSTh3UkCcSqNjtsw=;
        b=U5jB7A6gsn+I7b9lxfTBROZGeFa7CwkiVpShRut0/cs6ki4Qcue45SGeofeWD76ejw
         UDiCbIB9yYVlnunL2yzqT6KzQpUUi0KGPoj1ftL2186zMj45gRDkIAch1yHcRRqgbuNq
         wbENCX1x1NU5ukvPAk0rFi4u9UeljzFTNueB6PlaHAoRaIDd2wQyKgv5EqAfaefZbnoW
         4d55SKhAkc/I11cxAROkkfXh5jRasYA5HKdboQVN3fPzFn8ut5J+kLkBAW1LBEmAS6Gl
         9V9Vld+yydrFNyAB/T1Ali16Ml5kGXc07o7F88FJAL1nYBU2rVGPYjRCyS2qG3KC/Enn
         b/dA==
X-Gm-Message-State: AOAM533WgiHSiJ9Fl1C4HE+1XkO/sEGwqx8lVAAA6Wr1MhgPGi1H3LK7
        8FmX+aN7PMd2qqrFJ5gYfMRxUkbaUA4x3fA1UXw=
X-Google-Smtp-Source: ABdhPJwtYnUCgZeukP6sR55xbzawsi1bUmm78suyuUwSi9mZIV6ZTr5hW41P/bcF8SEMUd3LVv8L+WI7T+TMgX6qQ3Q=
X-Received: by 2002:aca:38c3:: with SMTP id f186mr4536559oia.39.1626927556440;
 Wed, 21 Jul 2021 21:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
 <pull.973.v2.git.1626812081.gitgitgadget@gmail.com> <71e301501c88399711a1bf8515d1747e92cfbb9b.1626812081.git.gitgitgadget@gmail.com>
In-Reply-To: <71e301501c88399711a1bf8515d1747e92cfbb9b.1626812081.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Jul 2021 21:19:05 -0700
Message-ID: <CABPp-BE3T_uLKZMwX7UJPK4vbGZ81OuEKU5H9WBqeUtcd5kgKg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] unpack-trees: resolve sparse-directory/file conflicts
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

On Tue, Jul 20, 2021 at 1:14 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When running unpack_trees() with a sparse index, we attempt to operate
> on the index without expanding the sparse directory entries. Thus, we
> operate by manipulating entire directories and passing them to the
> unpack function. In the case of the 'git checkout' command, this is the
> twoway_merge() function.
>
> There are several cases in twoway_merge() that handle different
> situations. One new one to add is the case of a directory/file conflict
> where the directory is sparse. Before the sparse index, such a conflict
> would appear as a list of file additions and deletions. Now,
> twoway_merge() initializes 'current', 'oldtree', and 'newtree' from
> src[0], src[1], and src[2], then sets 'oldtree' to NULL because it is
> equal to the df_conflict_entry. The way to determine that we have a
> directory/file conflict is to test that 'current' and 'newtree' disagree
> on being sparse directory entries.
>
> When we are in this case, we want to resolve the situation by calling
> merged_entry(). This allows replacing the 'current' entry with the
> 'newtree' entry. This is important for cases where we want to run 'git
> checkout' across the conflict and have the new HEAD represent the new
> file type at that path. The first NEEDSWORK comment dropped in t1092
> demonstrates this necessary behavior.
>
> However, we still are in a confusing state when 'current' corresponds to
> a staged change within a sparse directory that is not present at HEAD.
> This should be atypical, because it requires adding a change outside of
> the sparse-checkout cone, but it is possible. Since we are unable to
> determine that this is a staged change within twoway_merge(), we cannot
> add a case to reject the merge at this point. I believe this is due to
> the use of df_conflict_entry in the place of 'oldtree' instead of using
> the valud at HEAD, which would provide some perspective to this
> decision. Any change that would allow this differentiation for staged
> entries would need to involve information further up in unpack_trees().
>
> That work should be done, sometime, because we are further confusing the
> behavior of a directory/file conflict when staging a change in the
> directory. The two cases 'checkout behaves oddly with df-conflict-?' in
> t1092 demonstrate that even without a sparse-checkout, Git is not
> consistent in its behavior. Neither of the two options seems correct,
> either. This change makes the sparse-index behave differently than the
> typcial sparse-checkout case, but it does match the full checkout
> behavior in the df-conflict-2 case.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 24 ++++++++++++------------
>  unpack-trees.c                           | 11 +++++++++++
>  2 files changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 79b4a8ce199..91e30d6ec22 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -396,14 +396,14 @@ test_expect_success 'diff with renames and conflicts' '
>         done
>  '
>
> -# NEEDSWORK: the sparse-index fails to move HEAD across a directory/file
> -# conflict such as when checking out df-conflict-1 and df-conflict2.
>  test_expect_success 'diff with directory/file conflicts' '
>         init_repos &&
>
>         for branch in rename-out-to-out \
>                       rename-out-to-in \
>                       rename-in-to-out \
> +                     df-conflict-1 \
> +                     df-conflict-2 \
>                       fd-conflict
>         do
>                 git -C full-checkout reset --hard &&
> @@ -667,10 +667,7 @@ test_expect_success 'checkout behaves oddly with df-conflict-1' '
>         git -C sparse-checkout checkout df-conflict-1 \
>                 1>sparse-checkout-out \
>                 2>sparse-checkout-err &&
> -
> -       # NEEDSWORK: the sparse-index case refuses to change HEAD here,
> -       # but for the wrong reason.
> -       test_must_fail git -C sparse-index checkout df-conflict-1 \
> +       git -C sparse-index checkout df-conflict-1 \
>                 1>sparse-index-out \
>                 2>sparse-index-err &&
>
> @@ -684,7 +681,11 @@ test_expect_success 'checkout behaves oddly with df-conflict-1' '
>         test_cmp expect full-checkout-out &&
>         test_cmp expect sparse-checkout-out &&
>
> +       # The sparse-index reports no output
> +       test_must_be_empty sparse-index-out &&
> +
>         # stderr: Switched to branch df-conflict-1
> +       test_cmp full-checkout-err sparse-checkout-err &&
>         test_cmp full-checkout-err sparse-checkout-err
>  '
>
> @@ -719,17 +720,15 @@ test_expect_success 'checkout behaves oddly with df-conflict-2' '
>         git -C sparse-checkout checkout df-conflict-2 \
>                 1>sparse-checkout-out \
>                 2>sparse-checkout-err &&
> -
> -       # NEEDSWORK: the sparse-index case refuses to change HEAD
> -       # here, but for the wrong reason.
> -       test_must_fail git -C sparse-index checkout df-conflict-2 \
> +       git -C sparse-index checkout df-conflict-2 \
>                 1>sparse-index-out \
>                 2>sparse-index-err &&
>
>         # The full checkout deviates from the df-conflict-1 case here!
>         # It drops the change to folder1/larger-content and leaves the
> -       # folder1 path as-is on disk.
> +       # folder1 path as-is on disk. The sparse-index behaves the same.
>         test_must_be_empty full-checkout-out &&
> +       test_must_be_empty sparse-index-out &&
>
>         # In the sparse-checkout case, the checkout deletes the folder1
>         # file and adds the folder1/larger-content file, leaving all other
> @@ -741,7 +740,8 @@ test_expect_success 'checkout behaves oddly with df-conflict-2' '
>         test_cmp expect sparse-checkout-out &&
>
>         # Switched to branch df-conflict-1
> -       test_cmp full-checkout-err sparse-checkout-err
> +       test_cmp full-checkout-err sparse-checkout-err &&
> +       test_cmp full-checkout-err sparse-index-err
>  '
>
>  test_done
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 0a5135ab397..309c1352f5d 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2619,6 +2619,17 @@ int twoway_merge(const struct cache_entry * const *src,
>                          same(current, oldtree) && !same(current, newtree)) {
>                         /* 20 or 21 */
>                         return merged_entry(newtree, current, o);
> +               } else if (current && !oldtree && newtree &&
> +                          S_ISSPARSEDIR(current->ce_mode) != S_ISSPARSEDIR(newtree->ce_mode) &&
> +                          ce_stage(current) == 0) {
> +                       /*
> +                        * This case is a directory/file conflict across the sparse-index
> +                        * boundary. When we are changing from one path to another via
> +                        * 'git checkout', then we want to replace one entry with another
> +                        * via merged_entry(). If there are staged changes, then we should
> +                        * reject the merge instead.
> +                        */
> +                       return merged_entry(newtree, current, o);
>                 } else
>                         return reject_merge(current, o);
>         }
> --

I'm still a bit unhappy with the unpack-trees.c change (I wonder if
having "path/" vs "path" is going to make D/F conflicts hard to handle
and whether we need to make unpack_trees do something special to make
both paths be considered at the same time with one call to
twoway_merge() instead of two in order to fix this), BUT I think
you've done a really good job of documenting it and pointing out that
unpack_trees() messes up even without sparse checkouts on D/F
conflicts (though in a different way).  I think you've documented it
well enough, and argued about the likelihood of issues well enough,
that it makes sense to proceed and circle back and fix this up later.
