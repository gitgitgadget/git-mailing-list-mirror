Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4C3C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 02:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344504AbiAFCAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 21:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344487AbiAFB76 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 20:59:58 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F7BC061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 17:59:58 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m21so3901262edc.0
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 17:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IA1sj0GJxD0qBD9ajldgUrb8tXXoVsQSO9P3grRQT7w=;
        b=Qlgkk+ee83t8OcL7qxq+6xYNWbD90INBgr7PI3ZxaSzuoJFrwnG+4JHwioAUAGBz+I
         Q9YFl/Z3VK8tEB3h0hbbRT7ja083MhN7QUZnaYPB5++A+VgrenuKzQ2nhbFjcrgKCRsp
         zT29d5JzjmRWAQw3aN/0DcXB9cYeuelZZNjErt4hBNiZkaHtYxaTtDjnNdKMYCl4MshV
         wGiFlCLe1ZOGX7/gjSVpc5533mDaC/B1yBe2DP8GGs8zSbYBUbn1K0lsZunlEK/M+oWX
         jq6zuSphEhDlh3Ijvdga1ro6DU7uGZXwBAZtrIOvT1tR7bt3TC16IT5/+b9SUj0e6gW/
         s4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IA1sj0GJxD0qBD9ajldgUrb8tXXoVsQSO9P3grRQT7w=;
        b=EyP0gT9LcpwKS0YYlC71dXIHSBiJRzVIcZcTBC8SNXWc36v4aBmR2wG30ir++JNveB
         yCPmlEZ7iQ1xdixAa+Zn42U2hiwDPeJ+u35bKHVB7XvkYMDyAuRvAF7hWFcKdML+7pCt
         34XHKNMY90ODLQQq1zKqSbLZ5G9SkF0Z5dm5ENGrtQ4QQm5UZXUHm4GCw3h4DzlMp6ON
         IJ/MCukeoLuQZmVuiSsSo5yF70gMg5wdNQ6z3kD3qV/Dy/YsP8ZI3zvnZqJs6056CK6a
         QDg60CMYWBCkHWpNY1konldBDq4nNcAVa96ACctbLMCiKCVJsXC9FOUtOuAJH8xLxXnr
         SdaA==
X-Gm-Message-State: AOAM533sQ7Q0KAX+RdC/YnCozWHBCkU1ZRerF8NrpWhQFpm9L3G0tYZE
        3hsAwpxJ+Txpol01HeBmpe6V1ssGm0fCH8Zx1F8=
X-Google-Smtp-Source: ABdhPJz6Ve4yyPVInubzDdMYUGxzupddM8ubruAI+Di0wHw5scgjtuvU1pGW/G51kzkV8iDjRbP3CBw9W5yyRKFPwd0=
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr56127801edd.228.1641434396618;
 Wed, 05 Jan 2022 17:59:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com> <18c00fc9dd373bd5cfb527cb7d672a5a1b3b0588.1641317820.git.gitgitgadget@gmail.com>
In-Reply-To: <18c00fc9dd373bd5cfb527cb7d672a5a1b3b0588.1641317820.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Jan 2022 17:59:45 -0800
Message-ID: <CABPp-BFT5Rd9pHGAfK7ymNWXs5AGRu5N+dmdrytSoRdkdKvpRQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] checkout-index: integrate with sparse index
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 4, 2022 at 9:37 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> Add repository settings to allow usage of the sparse index.
>
> When using the `--all` option, sparse directories are ignored by default due
> to the `skip-worktree` flag, so there is no need to expand the index. If
> `--ignore-skip-worktree-bits` is specified, the index is expanded in order
> to check out all files.
>
> When checking out individual files, existing behavior in a full index is to
> exit with an error if a directory is specified (as the directory name will
> not match an index entry). However, it is possible in a sparse index to
> match a directory name to a sparse directory index entry, but checking out
> that sparse directory still results in an error on checkout. To reduce some
> potential confusion for users, `checkout_file(...)` explicitly exits with an
> informative error if provided with a sparse directory name. The test
> corresponding to this scenario verifies the error message, which now differs
> between sparse index and non-sparse index checkouts.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/checkout-index.c                 | 28 ++++++++++++++++++++++--
>  t/t1092-sparse-checkout-compatibility.sh | 11 +++++++++-
>  2 files changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index 2053a80103a..9c5657ccf22 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -66,6 +66,7 @@ static int checkout_file(const char *name, const char *prefix)
>         int namelen = strlen(name);
>         int pos = cache_name_pos(name, namelen);
>         int has_same_name = 0;
> +       int is_file = 0;
>         int did_checkout = 0;
>         int errs = 0;
>
> @@ -79,6 +80,9 @@ static int checkout_file(const char *name, const char *prefix)
>                         break;
>                 has_same_name = 1;
>                 pos++;
> +               if (S_ISSPARSEDIR(ce->ce_mode))
> +                       break;
> +               is_file = 1;
>                 if (ce_stage(ce) != checkout_stage
>                     && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
>                         continue;
> @@ -107,6 +111,8 @@ static int checkout_file(const char *name, const char *prefix)
>                 fprintf(stderr, "git checkout-index: %s ", name);
>                 if (!has_same_name)
>                         fprintf(stderr, "is not in the cache");
> +               else if (!is_file)
> +                       fprintf(stderr, "is a sparse directory");
>                 else if (checkout_stage)
>                         fprintf(stderr, "does not exist at stage %d",
>                                 checkout_stage);
> @@ -122,10 +128,25 @@ static int checkout_all(const char *prefix, int prefix_length, int ignore_skip_w
>         int i, errs = 0;
>         struct cache_entry *last_ce = NULL;
>
> -       /* TODO: audit for interaction with sparse-index. */
> -       ensure_full_index(&the_index);
>         for (i = 0; i < active_nr ; i++) {
>                 struct cache_entry *ce = active_cache[i];
> +
> +               if (S_ISSPARSEDIR(ce->ce_mode)) {
> +                       if (!ce_skip_worktree(ce))
> +                               BUG("sparse directory '%s' does not have skip-worktree set", ce->name);
> +
> +                       /*
> +                        * If the current entry is a sparse directory and skip-worktree
> +                        * entries are being checked out, expand the index and continue
> +                        * the loop on the current index position (now pointing to the
> +                        * first entry inside the expanded sparse directory).
> +                        */
> +                       if (ignore_skip_worktree) {
> +                               ensure_full_index(&the_index);
> +                               ce = active_cache[i];
> +                       }

So while iterating through the index, we reach an entry and decide to
expand the index.  This would be unsafe if our iterator became
invalid, but the only way that would happen is if there was a sparse
directory entry earlier in the index, and by construction of this loop
we expand upon the first sparse directory entry we see.  Since you
reassign  ce = active_cache[i] immediately after expanding the index
and the sparse directory's sub-entries have to go to that same spot,
you're actually at the next valid item to iterate over.  Slightly
tricky, but makes sense.

> +               }
> +
>                 if (!ignore_skip_worktree && ce_skip_worktree(ce))
>                         continue;
>                 if (ce_stage(ce) != checkout_stage
> @@ -218,6 +239,9 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>         git_config(git_default_config, NULL);
>         prefix_length = prefix ? strlen(prefix) : 0;
>
> +       prepare_repo_settings(the_repository);
> +       the_repository->settings.command_requires_full_index = 0;
> +
>         if (read_cache() < 0) {
>                 die("invalid cache");
>         }
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index fad61d96107..6ecf1f2bf8e 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -796,7 +796,14 @@ test_expect_success 'checkout-index with folders' '
>         test_all_match test_must_fail git checkout-index -f -- deep/ &&
>
>         # Outside checkout definition
> -       test_all_match test_must_fail git checkout-index -f -- folder1/
> +       # Note: although all tests fail (as expected), the messaging differs. For
> +       # non-sparse index checkouts, the error is that the "file" does not appear
> +       # in the index; for sparse checkouts, the error is explicitly that the
> +       # entry is a sparse directory.
> +       run_on_all test_must_fail git checkout-index -f -- folder1/ &&
> +       test_cmp full-checkout-err sparse-checkout-err &&
> +       ! test_cmp full-checkout-err sparse-index-err &&
> +       grep "is a sparse directory" sparse-index-err
>  '
>
>  test_expect_success 'checkout-index --all' '
> @@ -965,6 +972,8 @@ test_expect_success 'sparse-index is not expanded' '
>         echo >>sparse-index/untracked.txt &&
>         ensure_not_expanded add . &&
>
> +       ensure_not_expanded checkout-index -f a &&
> +       ensure_not_expanded checkout-index -f --all &&
>         for ref in update-deep update-folder1 update-folder2 update-deep
>         do
>                 echo >>sparse-index/README.md &&
> --
> gitgitgadget

Patch looks good to me.
