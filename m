Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8191C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 23:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7A764FA9
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 23:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhBDX5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 18:57:30 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46]:33612 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhBDX52 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 18:57:28 -0500
Received: by mail-ej1-f46.google.com with SMTP id sa23so8790472ejb.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 15:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njKZ55ukH2I1G2Voe8oKoqvX/U8n1TzFhAkdj3upViI=;
        b=so+mWshZ2aDZ1DV/CkR+xRu65Y2IUwE0j68xpreXRAauWF236mL3pU/NYf34kphsv2
         iMw+NT+XOvnV5eBDODDhhEu/tXi/k7z7mGDqe/UHtaiVXdXlpxLlpiBpgV+6/iRVI8UI
         uECJ3HJJjO6esupxgxwP2CvmkRIetcwHNq5HHH4V/deCvA861DXNXpIXNRupSo3PUxQv
         Thcov2swlpZ8VnlyIsJf0+enUbqi3DuzdNBMxRTOHjva7r0xLSMa+0KoF7rlcgwDtV+x
         2GHG9fhELckDvsn5B6m91/35+mSefNiav2nHNlNnM0FLKu6WIBh642tUZ/p1vqTviDT/
         szjg==
X-Gm-Message-State: AOAM5321NL8hvcI4KH/LQ5dYakbO5YqD+oTNdGsbD854UFnuTDpcKVVW
        pQ7DvNKJ77YGfFJ29nytHLbWse3DJqirItXVdW4=
X-Google-Smtp-Source: ABdhPJx+ADGAbdHy/5UQKZ4abfMA3QFcWVl9wFrBs0HWZwCyznkjevFiver60T/zviS9kGaUyyKCS8dHxfg8mJIWNRM=
X-Received: by 2002:a17:906:3105:: with SMTP id 5mr1527076ejx.168.1612483006993;
 Thu, 04 Feb 2021 15:56:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.869.git.1612469275.gitgitgadget@gmail.com> <b620be042eb31c0e771230434951d983f4173ecf.1612469275.git.gitgitgadget@gmail.com>
In-Reply-To: <b620be042eb31c0e771230434951d983f4173ecf.1612469275.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 4 Feb 2021 18:56:36 -0500
Message-ID: <CAPig+cSNCVT8h-wFBGvDWB4u0OUQM-Q-1DwuLepnjTdwEpk_4A@mail.gmail.com>
Subject: Re: [PATCH 4/6] range-diff: combine all options in a single data structure
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 4, 2021 at 3:24 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This will make it easier to implement the `--left-only` and
> `--right-only` options.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/range-diff.h b/range-diff.h
> @@ -6,15 +6,20 @@
> +struct range_diff_options {
> +       int creation_factor;
> +       unsigned dual_color:1;
> +       const struct diff_options *diffopt;
> +       const struct strvec *other_arg;
> +};
> +
>  /*
>   * Compare series of commits in RANGE1 and RANGE2, and emit to the
>   * standard output.  NULL can be passed to DIFFOPT to use the built-in
>   * default.
>   */
>  int show_range_diff(const char *range1, const char *range2,
> -                   int creation_factor, int dual_color,
> -                   const struct diff_options *diffopt,
> -                   const struct strvec *other_arg);
> +                   struct range_diff_options *opts);

The function comment's mention of DIFFOPT becomes outdated with this
change. Perhaps update it to say `opts.diffopt` or something.
