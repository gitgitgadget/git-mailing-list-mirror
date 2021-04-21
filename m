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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A7FC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 07:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D9F6140A
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 07:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhDUHBG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 03:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbhDUHA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 03:00:59 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EB3C06138D
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 00:00:26 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so33005367otf.12
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSBAvtEREhU/jbkyq2/yYalpTVSL9Y8kcEKX2yYfqGo=;
        b=UTuDItEyxqHWLYjqs1/XUyD7fIyAE72ZTkpEBRFHyiDpxDeaQIY/FyyFgxrCOEm2GN
         NO8UsNqydQSiTY0SixKm51qfBBxLRB37PzqCfiOXy5eTAdHHcUNb/OpggWOoqEu6cenC
         IvTtLFioYhhI2VDA4S093A6Q+OntGlcvuZVgVxjvx6kBDx9UKXs0rzm1iaCOJtYROM1O
         AhK5rYCPsPC1/jAD1Y2d2RBeCv1VEAJ3YbrI66hcm5Ts5tHK9KP7hb8yBnIxqVts+Djw
         +LTDjDAIeLRm9H0lr7ikZVoNm6+rSqKx3sGSZ6bspBM7zNU6vPNErWgkabOhygmjocCt
         EFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSBAvtEREhU/jbkyq2/yYalpTVSL9Y8kcEKX2yYfqGo=;
        b=bv3PPbi4hhrDDJqW+IIToy7gq3gzGsYKHzGT3+6j5dwdDGaRuUOxCqLQzATaWAPBH0
         sDxuwgzBG4UrHcF3b9PpxzGMEHk/F50anDdM700BLC84fRl50qt6VowJ/bmqexzPOM8S
         kI+7A0UclJSmClKn36RkQrtgJAWAsfI9KvAlkAZSzaJTlqeC9Haz+AHKPkM+QL721t64
         GgfJYH72EvmByJpc1SJ0T+EbGscppBXqVIh+jdPcWK4+ZeLh0Pkv9xphhfu/FByvhZDC
         GbeyxNagHzxMhX41ZGhqLSEL/svHZMuS93gVnIcdOQ62rCceFR1zt1pisV2BPBy1Cyvc
         nKxA==
X-Gm-Message-State: AOAM531elVRAk0CCTfKILfzV+KqmUH1jriXiEax8lXNXxzfAcVH8dPiJ
        fSvgCynLbl2WtygqlOts5PzS7R9KjHBaXyxRJAA=
X-Google-Smtp-Source: ABdhPJzbGLYSdG6MoT6WFDL1uJZqKVrqCEtD4nd8V7kfN3LLLaV3QgnblKElL1r+Fiekws+/5JwK2/lsD018HGfNO5E=
X-Received: by 2002:a05:6830:108d:: with SMTP id y13mr16574236oto.162.1618988426001;
 Wed, 21 Apr 2021 00:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com> <9d1183ddd280b1e9a580dcbfe9761ceec8d0bc80.1618322498.git.gitgitgadget@gmail.com>
In-Reply-To: <9d1183ddd280b1e9a580dcbfe9761ceec8d0bc80.1618322498.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Apr 2021 00:00:15 -0700
Message-ID: <CABPp-BGLsmNPjtdhb+SMPcXkHCPNaKcknO7ghUYdBoyrTiymTQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] fsmonitor: test with sparse index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> During the effort to protect uses of the index to operate on a full
> index, we did not modify fsmonitor.c. This is because it already works
> effectively with only the change to index_name_stage_pos(). The only
> thing left to do is to test that it works correctly.
>
> These tests are added to demonstrate that the behavior is the same
> across a full index and a sparse index, but also that file modifications
> to a tracked directory outside of the sparse cone will trigger
> ensure_full_index().
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t7519-status-fsmonitor.sh | 48 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> index 23879d967297..306157d48abf 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -78,6 +78,7 @@ test_expect_success 'setup' '
>         expect*
>         actual*
>         marker*
> +       trace2*
>         EOF
>  '
>
> @@ -400,4 +401,51 @@ test_expect_success 'status succeeds after staging/unstaging' '
>         )
>  '
>
> +test_expect_success 'status succeeds with sparse index' '
> +       test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
> +       git status --porcelain=v2 >expect &&
> +       git sparse-checkout init --cone --sparse-index &&
> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +               git status --porcelain=v2 >actual &&
> +       test_region ! index ensure_full_index trace2.txt &&
> +       test_cmp expect actual &&
> +       rm trace2.txt &&
> +
> +       write_script .git/hooks/fsmonitor-test<<-\EOF &&
> +               printf "last_update_token\0"
> +       EOF
> +       git config core.fsmonitor .git/hooks/fsmonitor-test &&
> +       git status --porcelain=v2 >expect &&
> +       git sparse-checkout init --cone --sparse-index &&
> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +               git status --porcelain=v2 >actual &&
> +       test_region ! index ensure_full_index trace2.txt &&
> +       test_cmp expect actual &&
> +       rm trace2.txt &&
> +
> +       write_script .git/hooks/fsmonitor-test<<-\EOF &&
> +               printf "last_update_token\0"
> +               printf "dir1/modified\0"
> +       EOF
> +       git config core.fsmonitor .git/hooks/fsmonitor-test &&
> +       git status --porcelain=v2 >expect &&
> +       git sparse-checkout init --cone --sparse-index &&
> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +               git status --porcelain=v2 >actual &&
> +       test_region ! index ensure_full_index trace2.txt &&
> +       test_cmp expect actual &&
> +
> +       write_script .git/hooks/fsmonitor-test<<-\EOF &&
> +               printf "last_update_token\0"
> +               printf "dir1a/modified\0"
> +       EOF
> +       git config core.fsmonitor .git/hooks/fsmonitor-test &&
> +       git status --porcelain=v2 >expect &&
> +       git sparse-checkout init --cone --sparse-index &&
> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +               git status --porcelain=v2 >actual &&
> +       test_region index ensure_full_index trace2.txt &&
> +       test_cmp expect actual

There's a lot of duplicated lines here; would it make sense to have a
helper function you call, making it easier to see the differences
between the four subsections of this test?  Also, do you want to use
test_config instead of git config, so that it automatically gets unset
at the end of the test?
