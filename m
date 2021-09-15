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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1986C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 05:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A901C61214
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 05:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbhIOFY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 01:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhIOFY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 01:24:27 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB12C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 22:23:09 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso2026914otv.3
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 22:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZ+h228MO4hrll+kaHMHWp8trM1pVVdgUe1umcAVesY=;
        b=XFhTEGlL4uHGuHfeD2952Dlw0Aam+S1kQ327cdjwS2+NrCCz2cSNg2aGG9jwstimsj
         OiZaO3lK9DM80IVgYAYeT3J1ZvOcJWXDsETpFM+6DRGWeVUg5JFmcwxAVGKpkaICbkZ2
         ev54Q39iBDnHeA9i3+Qe37SLF3fgr4qb0mobVVpJe8ysNbIDhdHLWNeGNVTOulb/axRQ
         VTAsD1Ad5hHiybG8ql9ZUd29De+KOGMEiWFkkaGRFC+RQVHtfuwku91RN/k+/IYD+kOF
         cNAUiqLgtlDCSCEC5C1sC2XKvr3SRosuDz8lH5V/cWBTrsEhc9bwWR3pgpf8k8br13RM
         2zPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZ+h228MO4hrll+kaHMHWp8trM1pVVdgUe1umcAVesY=;
        b=KI/NLH4L66dW6BFoTobuB6hqlRFgAlVtZJyPOTcaKHfmZsYbYww/FYBKrnG0/qexUp
         /uTNv7/CLOf0NZGze32LaJTCCAs/osAZULdc97fpZA5QpMD6II6rdDvHm+gpB0EYIQHs
         au8G9OOjcuFNdndl7Z54HAs1mM1utVy/IP9MtSeacojN5XzfNpGT8tOi3okDZv6GwjEk
         zI+0LVxm6rLKzuD88W5sJfR6BnqBx96Jr6l9NeFbJfJA5lwAFQ/8iBGhSVagVNF16TRS
         Q7EjTAqdfJbZ8fWYOJUsuA00i6FlLpsxZq0yQj5EkYCemRN7/weRTbKuvFBgWVclmJXT
         adgA==
X-Gm-Message-State: AOAM532G85LVdfjHoOCLlGQx3olx+4cZ1/ND4vcONAWEdYuEtRja0G5v
        Pi5m2RZKhdLQQ749K3wiSKF68v41Gglant9nKWs=
X-Google-Smtp-Source: ABdhPJwiaYe5UEmQ2whZtw2/dby6LUFED6xD0bTq7h3m2loeGAYurkmFez/bxU0I7iimfChea413e02rj/KXSf69xAg=
X-Received: by 2002:a9d:7204:: with SMTP id u4mr17942690otj.276.1631683388427;
 Tue, 14 Sep 2021 22:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com> <8aefce6254c0bcbbbca909a62d033c74c90f980b.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <8aefce6254c0bcbbbca909a62d033c74c90f980b.1631453010.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Sep 2021 22:22:56 -0700
Message-ID: <CABPp-BF9rhAK47KQUJtZ9yDTkJ-qoeZ0Q7T4ycLcLSgLoxkzTw@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] t3705: test that 'sparse_entry' is unstaged
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 12, 2021 at 6:23 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The tests in t3705-add-sparse-checkout.sh check to see how 'git add'
> behaves with paths outside the sparse-checkout definition. These
> currently check to see if a given warning is present but not that the
> index is not updated with the sparse entries. Add a new
> 'test_sparse_entry_unstaged' helper to be sure 'git add' is behaving
> correctly.
>
> We need to modify setup_sparse_entry to actually commit the sparse_entry
> file so it exists at HEAD but is not already staged in the index.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t3705-add-sparse-checkout.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
> index 2b1fd0d0eef..af81b4b6846 100755
> --- a/t/t3705-add-sparse-checkout.sh
> +++ b/t/t3705-add-sparse-checkout.sh
> @@ -19,6 +19,7 @@ setup_sparse_entry () {
>         fi &&
>         git add sparse_entry &&
>         git update-index --skip-worktree sparse_entry &&
> +       git commit --allow-empty -m "ensure sparse_entry exists at HEAD" &&
>         SPARSE_ENTRY_BLOB=$(git rev-parse :sparse_entry)
>  }
>
> @@ -36,6 +37,11 @@ setup_gitignore () {
>         EOF
>  }
>
> +test_sparse_entry_unstaged () {
> +       git status --porcelain >actual &&
> +       ! grep "^M  sparse_entry\$" actual

Is there a reason this is ^M rather than ^D?  Granted, both would be
bugs so I wouldn't expect either to appear, but the point of the check
is looking for likely errors.  Wouldn't the more likely error case for
a file not present in the working tree be that we stage the deletion
of the file?

> +}
> +
>  test_expect_success 'setup' "
>         cat >sparse_error_header <<-EOF &&
>         The following pathspecs didn't match any eligible path, but they do match index
> @@ -55,6 +61,7 @@ test_expect_success 'git add does not remove sparse entries' '
>         setup_sparse_entry &&
>         rm sparse_entry &&
>         test_must_fail git add sparse_entry 2>stderr &&
> +       test_sparse_entry_unstaged &&
>         test_cmp error_and_hint stderr &&
>         test_sparse_entry_unchanged
>  '
> @@ -73,6 +80,7 @@ test_expect_success 'git add . does not remove sparse entries' '
>         rm sparse_entry &&
>         setup_gitignore &&
>         test_must_fail git add . 2>stderr &&
> +       test_sparse_entry_unstaged &&
>
>         cat sparse_error_header >expect &&
>         echo . >>expect &&
> @@ -88,6 +96,7 @@ do
>                 setup_sparse_entry &&
>                 echo modified >sparse_entry &&
>                 test_must_fail git add $opt sparse_entry 2>stderr &&
> +               test_sparse_entry_unstaged &&
>                 test_cmp error_and_hint stderr &&
>                 test_sparse_entry_unchanged
>         '
> @@ -98,6 +107,7 @@ test_expect_success 'git add --refresh does not update sparse entries' '
>         git ls-files --debug sparse_entry | grep mtime >before &&
>         test-tool chmtime -60 sparse_entry &&
>         test_must_fail git add --refresh sparse_entry 2>stderr &&
> +       test_sparse_entry_unstaged &&
>         test_cmp error_and_hint stderr &&
>         git ls-files --debug sparse_entry | grep mtime >after &&
>         test_cmp before after
> @@ -106,6 +116,7 @@ test_expect_success 'git add --refresh does not update sparse entries' '
>  test_expect_success 'git add --chmod does not update sparse entries' '
>         setup_sparse_entry &&
>         test_must_fail git add --chmod=+x sparse_entry 2>stderr &&
> +       test_sparse_entry_unstaged &&
>         test_cmp error_and_hint stderr &&
>         test_sparse_entry_unchanged &&
>         ! test -x sparse_entry
> @@ -116,6 +127,7 @@ test_expect_success 'git add --renormalize does not update sparse entries' '
>         setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
>         echo "sparse_entry text=auto" >.gitattributes &&
>         test_must_fail git add --renormalize sparse_entry 2>stderr &&
> +       test_sparse_entry_unstaged &&
>         test_cmp error_and_hint stderr &&
>         test_sparse_entry_unchanged
>  '
> @@ -124,6 +136,7 @@ test_expect_success 'git add --dry-run --ignore-missing warn on sparse path' '
>         setup_sparse_entry &&
>         rm sparse_entry &&
>         test_must_fail git add --dry-run --ignore-missing sparse_entry 2>stderr &&
> +       test_sparse_entry_unstaged &&
>         test_cmp error_and_hint stderr &&
>         test_sparse_entry_unchanged
>  '
> @@ -148,6 +161,7 @@ test_expect_success 'do not warn when pathspec matches dense entries' '
>  test_expect_success 'add obeys advice.updateSparsePath' '
>         setup_sparse_entry &&
>         test_must_fail git -c advice.updateSparsePath=false add sparse_entry 2>stderr &&
> +       test_sparse_entry_unstaged &&
>         test_cmp sparse_entry_error stderr
>
>  '
> --
> gitgitgadget

Looks fine otherwise.
