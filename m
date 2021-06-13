Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4949CC48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 03:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD486102A
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 03:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhFMDmO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 12 Jun 2021 23:42:14 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:34404 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhFMDmN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 23:42:13 -0400
Received: by mail-ej1-f52.google.com with SMTP id g8so10648290ejx.1
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 20:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yaRb51wum3jVRBO+qR8CA2ZKVzotzH8a8POm6KzD75w=;
        b=GRXwXRLgFkzQU88rg5XgxUXvoXdGubGHQQlCLLTclX6eX2cxTXgXtKwKiSycwwSbWG
         KXGrmuGgirDXeEWmM/kl34fPCldAjagAVwJlZgE10gAN4w2QFlEejkqMcly1auUJWdbr
         2GB0GlpJC+xRCpRDTXLVQtXnENdgTHrZfV7YNg8Z476pIG5qugRcxS4fh+SSxs+Mbsx0
         swVqaNNx1nMX1jdvVwvehncWfjYaciulZKT1dWmVhRc/e1Bn8V/g+Za5cyk/8dIcd5Gs
         ik9KP+cPr4UsUB+JEqgqCYNtyvuRRyRzdvbehHXztPjD+z26d1sHe0EK3NY/BJIVyuiX
         fFyA==
X-Gm-Message-State: AOAM533bJxE+KfvpVSRhMTt/NPmmA00w6gfXzUo5NtDFO6FgqyAfN5EF
        CJZxQvsX39mowT+gTnuO3tlZRh2mLjUWv9iRkOA=
X-Google-Smtp-Source: ABdhPJyu+48F/rBhAmcqQE/GK7TAZm5C8uw7DNwOiw8BR/eUOHIOsudDyzrD5twp4XozQQZgHfOMTEOTOeBCk3BGXiE=
X-Received: by 2002:a17:906:a293:: with SMTP id i19mr9511046ejz.311.1623555602462;
 Sat, 12 Jun 2021 20:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210612042755.28342-1-congdanhqx@gmail.com> <20210612042755.28342-4-congdanhqx@gmail.com>
In-Reply-To: <20210612042755.28342-4-congdanhqx@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 12 Jun 2021 23:39:51 -0400
Message-ID: <CAPig+cRNqX3F3GmYP3X4Z-cY2aRGFac9NZ3=KymW43etNaDjEw@mail.gmail.com>
Subject: Re: [PATCH 3/4] t6400: use test_line_count_cmd to count # of lines in stdout
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
>
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
> diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
> @@ -82,13 +82,13 @@ test_expect_success 'modify/delete + directory/file conflict' '
> -       test 5 -eq $(git ls-files -s | wc -l) &&
> -       test 4 -eq $(git ls-files -u | wc -l) &&
> +       test_line_count_cmd --out = 5 git ls-files -s &&
> +       test_line_count_cmd --out = 4 git ls-files -u  &&

Nit: too many spaces before the `&&` on the second line: s/\s+/ /

> @@ -103,13 +103,13 @@ test_expect_success 'modify/delete + directory/file conflict; other way' '
> -       test 5 -eq $(git ls-files -s | wc -l) &&
> -       test 4 -eq $(git ls-files -u | wc -l) &&
> +       test_line_count_cmd --out = 5 git ls-files -s  &&
> +       test_line_count_cmd --out = 4 git ls-files -u  &&

Nit: too many spaces before the `&&` on both lines.
