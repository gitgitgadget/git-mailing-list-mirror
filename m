Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A193C1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfKHUqU (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:46:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40900 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKHUqU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:46:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id f3so7529213wmc.5
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 12:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0BvtsQVkTehw5MOeocW6Li2vOEZEkbBviMSpzRBYKk=;
        b=oHoP7LXkXh4AfR3juwyK20aaIV0gNp9TRL0/PIrCrxVsw0vVeBsVKIeuPB4c0ZWvA/
         r41c33kQbubS9XFQcpcKEAfLwBj0DwNJp/JzIphmCmoFAS9KYhLSFhOF1brAr4M3m1d7
         T4gWvpK23pWTUcqsp5OrSWE4L1qjLqkl3fllZGwNS2e4mzaCnWhRYxtf/4IZelsPBeyR
         YMn/jCWfK43mzMccC928PAaM+/hzCHvZMn+9+TdPgK1ThVwIQlQ1cYATdhGmhbWiWVZM
         +yUVQAS7LK3660RgCwiuBmB67LL3kOlo4nnfpiX12xAb2wNYyZCRtJcbVtUgvhjk/ndQ
         ogBQ==
X-Gm-Message-State: APjAAAVhe8MdVlBCxc7VHUtbEGX5hubME4Dk5FhlorYp8GJ2DBiBNym6
        c1G177QWLLK8gG8dtnH0f0dQG4YyMdDvunFKP9s=
X-Google-Smtp-Source: APXvYqwbaWvG/mCOSzvcQFoYde12Lun2uWcO3wNjXvQSC7TAA7bPSTZK02tQm2tN8m15TcXe8MmQ2Plj8tXrBhLLoak=
X-Received: by 2002:a1c:3cc4:: with SMTP id j187mr10183477wma.95.1573245978409;
 Fri, 08 Nov 2019 12:46:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572897736.git.liu.denton@gmail.com> <cover.1573241590.git.liu.denton@gmail.com>
 <e74eab6d21f655698ef8b6e1286b44ea070a7af7.1573241590.git.liu.denton@gmail.com>
In-Reply-To: <e74eab6d21f655698ef8b6e1286b44ea070a7af7.1573241590.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Nov 2019 15:46:07 -0500
Message-ID: <CAPig+cSQ5PYZYrbqZYoBWLzohw419iSTsEfysjRf_JyxNENRkw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] pretty: implement 'summary' format
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 8, 2019 at 3:08 PM Denton Liu <liu.denton@gmail.com> wrote:
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> @@ -154,20 +154,23 @@ do
> -test_expect_success 'NUL termination with --reflog --pretty=oneline' '
> -       >expect &&
> -       revs="$(git rev-list --reflog)" &&
> -       [...]
> -       test_cmp expect actual
> -'
> +for p in oneline summary
> +do
> +       test_expect_success "NUL termination with --reflog --pretty=$p" '
> +               >expect &&
> +               revs="$(git rev-list --reflog)" &&
> +               [...]
> +               test_cmp expect actual
> +       '
> +done

This patch would be less noisy (by eliminating the indentation change)
if you wrapped this test in a for-loop back in 7/10 where it was
introduced, with the intention of adding more items to the 'for' list.
So, in 7/10, you'd have this:

    for p in online
    do
        test_expect_success "NUL termination with --reflog --pretty=$p" '
            ...
        '
    done

and this patch, 9/10, would just make the minor change:

    -for p in oneline
    +for p in oneline summary

Having a for-loop with only a single item is a minor-ugly which pays
off with less noise in subsequent patch(es), thus easing review
burden.
