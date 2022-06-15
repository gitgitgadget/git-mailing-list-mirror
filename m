Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98485C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 23:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244334AbiFOXTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355329AbiFOXTG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 19:19:06 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FCE3BA
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:19:02 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-30fdbe7467cso76453857b3.1
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGQv8tmj9P2XfZLwXX+BDEtSAm1A05vOzFcuwco1fN4=;
        b=6CRBhhrv0a/wymeL2X9zULu/ah+Oa7V4pO/elB3DnErbbrURnN3cVBzqa3JEQtElTx
         rtVbcNk3cGjXo7KyCYMiRZkEAuNSAIh1LfXx84Ybju45+VSPfIXM7+WNtP6ujDrX4KDM
         98lnzJs6BBPPfRNuY2gUCMZPwYRnIYwp9x8QOkgMlyvIqCDIwrfcCSdwvGaYi1zIldAa
         UWFZKWLflyoifEm2KJc1nkocMM7mFNE+3iG4zWVLxn/9C6+FcSHZ6X2VDsc2OVjzrukj
         +1v7XjZwPCi8qvW1rCAU7CMMFVe2qEaKwBWlKY8w5F+Ax2C5qUtQSfhiYa/ua+mTZe1S
         wjcw==
X-Gm-Message-State: AJIora9WZvF0JU1+3w9IPx/72iGZbDJnviyUPTZYw2JjOgQcquXEPTQk
        B9/octsKgRci25oeM2AHbmVGHJ5xuvDd4Zpk100=
X-Google-Smtp-Source: AGRyM1sI9FXPS7PJlxz90qw+sGfbFx4Cdo0s3lEm6PdZOO8fU6K4td9maY6rtfSncWiGIPUTVXWout6weRwf51bAQl4=
X-Received: by 2002:a81:9256:0:b0:30c:7143:f218 with SMTP id
 j83-20020a819256000000b0030c7143f218mr2366146ywg.493.1655335142053; Wed, 15
 Jun 2022 16:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1261.git.1655242070.gitgitgadget@gmail.com> <c6803df1b6afead99a0a6a383ab9aa563920f464.1655242070.git.gitgitgadget@gmail.com>
In-Reply-To: <c6803df1b6afead99a0a6a383ab9aa563920f464.1655242070.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 15 Jun 2022 19:18:49 -0400
Message-ID: <CAPig+cTtZ3=r62XDTE4gpy0Fk_gkzOROm34gW6gkuGRjdQRBTA@mail.gmail.com>
Subject: Re: [PATCH 1/4] t2107: test 'git update-index --verbose'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 5:36 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The '--verbose' option reports what is being added and removed from the
> index, but has not been tested up to this point. Augment the tests in
> t2107 to check the '--verbose' option in some scenarios.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
> diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-index-assume-unchanged.sh
> @@ -20,7 +20,7 @@ test_expect_success 'do not switch branches with dirty file' '
>         echo dirt >file &&
> -       git update-index --assume-unchanged file &&
> +       git update-index --verbose --assume-unchanged file &&
>         test_must_fail git checkout - 2>err &&
>         test_i18ngrep overwritten err
>  '

If this test passes with or without the addition of `--verbose`, then
adding `--verbose` unnecessarily only pollutes what is (presumably)
the minimum code necessary to implement what the test is checking, and
may confuse future readers into thinking that something subtle is
going on.

> diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
> @@ -36,9 +36,14 @@ test_expect_success '--cacheinfo does not accept blob null sha1' '
>         echo content >file &&
>         git add file &&
>         git rev-parse :file >expect &&
> -       test_must_fail git update-index --cacheinfo 100644 $ZERO_OID file &&
> +       test_must_fail git update-index --verbose --cacheinfo 100644 $ZERO_OID file >out &&
>         git rev-parse :file >actual &&
> -       test_cmp expect actual
> +       test_cmp expect actual &&
> +
> +       cat >expect <<-\EOF &&
> +       add '\''file'\''
> +       EOF
> +       test_cmp expect out
>  '

While I understand your desire to address a gap in the test coverage,
I worry that this sort of change, which is orthogonal to the test's
stated purpose, has the same downsides as mentioned above (i.e.
polluting the minimum necessary code, and potentially confusing
readers). Rather than piggybacking on existing tests, adding one or
two new standalone tests dedicated to checking `--verbose` would be
more palatable, more understandable, and be less likely to confuse
future readers. The same comment applies to the remaining changes in
this patch.
