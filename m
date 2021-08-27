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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E015BC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 20:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAB460F58
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 20:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhH0U7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 16:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhH0U7S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 16:59:18 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB02C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 13:58:29 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id n27so11631924oij.0
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 13:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUHaeNJAb2pVpAAAgzpSr4q3a1PRDPJM8+rTjIk2jN0=;
        b=sGS60t0CWJ0g6Inx2+w4Z/5OMzYRL5iLtGfJIo29801DokOYXm/yFUt79/RJ1krW3r
         2Bp1/zhjXLTrt+3/4n8DSE2fGhizHMYWRJeNkmB/HVWBTRxPnZ2rXnPvBESxCcKOQc+L
         XWZbtEgVRQpCLyZ8njpBkoEzv0lzkjpZkhzZO0RPt1YCfnfUJudjZemX+ANNVzGBkY4l
         Jhh62BGBoxaN7GbWFURR6qPfH18zGTXJoucrfnRfRWMh9+6DBDv/HdZPW0yMxRP5ijnu
         xvjiifKo46zWF9pFnXFVnFjNAMfhmTs3Sd8qoqyKhWt67li3q64KiplS6rFRgS+NjWR4
         zKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUHaeNJAb2pVpAAAgzpSr4q3a1PRDPJM8+rTjIk2jN0=;
        b=o/LYC3fy9al36iPos9tVrjiOjv1rmOA7gQ6Ie1fcVuuKd3peONc33TBjoRQ5A1IHfl
         tXnm61i/UszMeOXrhLB/u/XbaMsmKdxQp3L6qNHQgqd0bqMmFMyyJHNrr8JW2Xl9nHK/
         2gvJ7V1i8wvyuIXEvd+7085ZPnLIb7AyqXd2trXcnHJq9CAF/63z74LS7BZEQw4qurj/
         d83IwPGAWXycxS8f/nIVzLqctFEyIymyHuuk7R09J2w6Gd6fotFzOHZJMo8hIIIDWPc9
         GXu/dsJZzkXjniBs3TZx4dM2aS/y+mSSArDa9HZJVS5AG7IRLhNSPwIEHg/dpw2Hq2cx
         nSzQ==
X-Gm-Message-State: AOAM533Sw7GYV2aMbuQlIbSrqa+2A+i9yRDsP3DpWtYiTI7SycjnJrhA
        rOYyIzhdIjSZArcqU3Xn7l4NGROT8H+uJT+cAzk=
X-Google-Smtp-Source: ABdhPJy72aPKhnzGYMLB5U0BsCVZaWZbqX2qf4nglTzhLrsgNtMVOIRZa8Pt4GvaC5C8sp4/28xUFKmx6nwk5BdatCs=
X-Received: by 2002:a05:6808:2084:: with SMTP id s4mr8090188oiw.31.1630097908776;
 Fri, 27 Aug 2021 13:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com> <8d55a6ba2fdf64cee4eb51f3cb6f9808bd0b7505.1629841904.git.gitgitgadget@gmail.com>
In-Reply-To: <8d55a6ba2fdf64cee4eb51f3cb6f9808bd0b7505.1629841904.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Aug 2021 13:58:17 -0700
Message-ID: <CABPp-BGeJJBF0ZmS7ZHcqFmXwXmgVH1Uox_6gNHzcacG2vRjVw@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] sparse-checkout: add config to disable deleting dirs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 2:51 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The clean_tracked_sparse_directories() method deletes the tracked
> directories that go out of scope when the sparse-checkout cone changes,
> at least in cone mode. This is new behavior, but is recommended based on
> our understanding of how users are interacting with the feature in most
> cases.
>
> It is possible that some users will object to the new behavior, so
> create a new configuration option 'index.deleteSparseDirectories' that
> can be set to 'false' to make clean_tracked_sparse_directories() do
> nothing. This will keep all untracked files in the working tree and
> cause performance problems with the sparse index, but those trade-offs
> are for the user to decide.

I'm not sold that we need anything here, and it sounds like this is
all being added based on a theoretical concern.  I might not object
too much normally to trying to address theoretical conerns with new
features, but:

* I'm a little concerned that we're adding a configuration option
(which live forever and are harder to work with
backward-compatibility-wise) rather than a command line flag.

* It's not clear to me that the option name is what we want.  For
example, git checkout has a --[no-]overwrite-ignored for overwriting
ignored files (or not) when switching to a different branch.  git
merge has the same flags (though only the fast-forwarding backend
heeds it currently).  This behavior is quite similar to that flag, and
has the same default of treating ignored files as expendable.  Should
the naming be more similar?

* It's not clear to me that the option has the right level of
implementation granularity.  If someone wants ignored files to be
treated as important, should they need to set a
merge.no_overwrite_ignored AND a checkout.no_overwrite_ignored AND a
index.deleteSparseDirectories AND other names, or have one high-level
option that sets all of these behaviors?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config/index.txt     | 6 ++++++
>  builtin/sparse-checkout.c          | 9 ++++++++-
>  t/t1091-sparse-checkout-builtin.sh | 4 ++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
> index 75f3a2d1054..c65da20a931 100644
> --- a/Documentation/config/index.txt
> +++ b/Documentation/config/index.txt
> @@ -1,3 +1,9 @@
> +index.deleteSparseDirectories::
> +       When enabled, the cone mode sparse-checkout feature will delete
> +       directories that are outside of the sparse-checkout cone, unless
> +       such a directory contains an untracked, non-ignored file. Defaults
> +       to true.
> +
>  index.recordEndOfIndexEntries::
>         Specifies whether the index file should include an "End Of Index
>         Entry" section. This reduces index load time on multiprocessor
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index d0f5c4702be..33ec729d9de 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -102,7 +102,7 @@ static int sparse_checkout_list(int argc, const char **argv)
>
>  static void clean_tracked_sparse_directories(struct repository *r)
>  {
> -       int i, was_full = 0;
> +       int i, value, was_full = 0;
>         struct strbuf path = STRBUF_INIT;
>         size_t pathlen;
>         struct string_list_item *item;
> @@ -118,6 +118,13 @@ static void clean_tracked_sparse_directories(struct repository *r)
>             !r->index->sparse_checkout_patterns->use_cone_patterns)
>                 return;
>
> +       /*
> +        * Users can disable this behavior.
> +        */
> +       if (!repo_config_get_bool(r, "index.deletesparsedirectories", &value) &&
> +           !value)
> +               return;
> +
>         /*
>          * Use the sparse index as a data structure to assist finding
>          * directories that are safe to delete. This conversion to a
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 71236981e64..e0f31186d89 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -666,6 +666,10 @@ test_expect_success 'cone mode clears ignored subdirectories' '
>         git -C repo status --porcelain=v2 >out &&
>         test_must_be_empty out &&
>
> +       git -C repo -c index.deleteSparseDirectories=false sparse-checkout reapply &&
> +       test_path_is_dir repo/folder1 &&
> +       test_path_is_dir repo/deep/deeper2 &&
> +
>         git -C repo sparse-checkout reapply &&
>         test_path_is_missing repo/folder1 &&
>         test_path_is_missing repo/deep/deeper2 &&
> --
> gitgitgadget
