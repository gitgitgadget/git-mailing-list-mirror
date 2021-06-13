Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A20C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 03:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5720611C0
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 03:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhFMDpe convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 12 Jun 2021 23:45:34 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:34381 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhFMDpd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 23:45:33 -0400
Received: by mail-ej1-f48.google.com with SMTP id g8so10655526ejx.1
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 20:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ho1JNaViI2C/QjdU0ZEURKAazgY3ae+zcIljX+pt0S0=;
        b=PLs/qZgfVv7oXzKlB9Ssc58MhlR0Delq6j7WOttLeMMJUfofsQ5h7cf/3mce+76rux
         XH97t9tiNdkm2KRLb9ghqfgW2rDuZ1JkhaMPdYgpVnX5MN+rISMZb2WZ0BuurjyP1dox
         F+jklpN8TogF9J7+Kud3Bh97VJkhmYxw06+3WXtutWn4u6qen0lo6N4w+6cFMpTy9mJQ
         QRAgBLXub8gxStESVH8pGm10mZSuxhqjAo7baYjlfZPqQN0nLvo93AQW4IWf6dSpziZY
         s2yDMm+IBjd55y0Zzn/sts6urMXkv/LMvUJnN/XIbRepK/y23U2EAD+ELoCH/YI19D0z
         OpGQ==
X-Gm-Message-State: AOAM5337r6AT93mj8mQ+ZOMN5CmKbI2z2p2BLrfNtIb23EcKO+wLGJ6Y
        O2nt5VkuYSqwP91wM0Jf2NMpmHfMwdZKovDoa4k=
X-Google-Smtp-Source: ABdhPJx4dkw/sF6RPxdU77MRF4vgx/SNYLgHYsi+coOMz02TLhGX5+aAIU7T11wJ5uJc2v7yXBlLkgoyh8qJd/tRhLY=
X-Received: by 2002:a17:906:dff2:: with SMTP id lc18mr10019303ejc.371.1623555799414;
 Sat, 12 Jun 2021 20:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210612042755.28342-1-congdanhqx@gmail.com> <20210612042755.28342-5-congdanhqx@gmail.com>
In-Reply-To: <20210612042755.28342-5-congdanhqx@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 12 Jun 2021 23:43:08 -0400
Message-ID: <CAPig+cS7Xh4L3YzStoU44=217jEBtFKWja7k=mTDhuHK3HBPVw@mail.gmail.com>
Subject: Re: [PATCH 4/4] t6402: use test_line_count_cmd to count # of lines in stdout
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 12, 2021 at 12:28 AM Đoàn Trần Công Danh
<congdanhqx@gmail.com> wrote:
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
> diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
> @@ -330,8 +320,8 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
> -       test 3 -eq "$(git ls-files -u | wc -l)" &&
> -       test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
> +       test_line_count_cmd --out = 3 git ls-files -u  &&
> +       test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way  &&

Nit: too many spaces before `&&`: s/\s+/ /

> @@ -357,8 +347,8 @@ test_expect_success 'Same as previous, but merged other way' '
> -       test 3 -eq "$(git ls-files -u | wc -l)" &&
> -       test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
> +       test_line_count_cmd --out = 3 git ls-files -u  &&
> +       test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way  &&

Ditto.

> @@ -374,8 +364,8 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge, dir not in
> -       test 3 -eq "$(git ls-files -u | wc -l)" &&
> -       test 3 -eq "$(git ls-files -u dir | wc -l)" &&
> +       test_line_count_cmd --out = 3 git ls-files -u  &&
> +       test_line_count_cmd --out = 3 git ls-files -u dir  &&

Ditto.

> @@ -409,14 +399,15 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge and dir in t
> -       test 5 -eq "$(git ls-files -u | wc -l)" &&
> +       test_line_count_cmd --out = 5 git ls-files -u  &&
>         if test "$GIT_TEST_MERGE_ALGORITHM" = ort
>         then
> -               test 3 -eq "$(git ls-files -u dir~HEAD | wc -l)"
> +               test_line_count_cmd --out = 3 git ls-files -u dir~HEAD
>         else
> -               test 3 -eq "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)"
> +               git ls-files -u dir >out &&
> +               test_line_count_cmd --out = 3 grep -v file-in-the-way out
>         fi &&
> -       test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
> +       test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way  &&

And again.

> @@ -432,14 +423,15 @@ test_expect_success 'Same as previous, but merged other way' '
> -       test 5 -eq "$(git ls-files -u | wc -l)" &&
> +       test_line_count_cmd --out = 5 git ls-files -u  &&

Here too.

> -       test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
> +       test_line_count_cmd --out = 2 git ls-files -u dir/file-in-the-way  &&

Blorp.

And the rest of the changes suffer the same problem, so I won't
continue commenting...
