Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00055C63777
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 05:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B31220B80
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 05:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgLCFxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 00:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgLCFxA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 00:53:00 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325F5C061A4E
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 21:52:14 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id k26so1074011oiw.0
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 21:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sonT2EQdfS7GkTpeyYxQDn+q0kvg92pxr+/nSN7++V4=;
        b=cpd1ucw7D0pKMMJUgrgOOqJHOTZQWoxAec6kkacGxMrU84+w20lWmYv+RdaTPYxTUl
         dIE4qXEUv6G/G5c0ipNtcV47ASH/t5ChLvxjbWNyE3dQ5/4ogHQvVE/baR9+Smy/aKIJ
         PXeEhlHR+++owejKYNRv8bDe4oHfmcILcu7jtaVJ+PMa7jIxFvjMFDKaRE3cmewtsLbj
         MC7nnmdeCmAnQ18F4U0CaPT9EorVOpKJJUiUkbFuDm9ekEAps4XPfavNwQCeHY8w/jN6
         bFss6SpVvizHCwTZk0OLK4tnAzIxS5saM437LsR9c2evv0FHp9b5S37u5bN7AShj19MT
         pEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sonT2EQdfS7GkTpeyYxQDn+q0kvg92pxr+/nSN7++V4=;
        b=gedxPgriJ+riGaWylkfV2wOrCprfJ88XlXS768LqEMJfkF2+ENTFGqyPkTS4IeuSeN
         drxuz/AE6m12DSM8A/xvWwN4Q5IWvdzsiLIWsbxkz9TAp8GR++y19DXuHgtCghLgMWg6
         FDtZ6tuQT7XXQHnpfEDEEYFJYwDn948kBFNgk+2Q2BuqajQ/SViMZ40tiIAbsRXxlh/8
         A11L/4VsPEMM03Yaw1ZEiP3rfmNpLEphOha8pZC38n1VmJnS/ONlLTME40cYifLq2SiK
         JwzyGng5A+j0uwLl54ZGSInCp0haBks2FPtL4BALyy3kQ7NT0OgSeWpDHxTuzccGt9tQ
         Im+A==
X-Gm-Message-State: AOAM532DUOE+lFUNFgFhVQVE70KMTI6cPJNly5aeI9ssLJag9Gu4f1WC
        4HrtEMzR+RFaNmHyxcbeuzqVK4McNPYCJMe8zSw=
X-Google-Smtp-Source: ABdhPJy8svWDUBdtn4l8QS0K13JmpPWD+o9qQW0OrrawQNpxV3iBU2R9zR+v+/dCN1iWe4UL48VTi522jB6E3AbjXtE=
X-Received: by 2002:aca:49d5:: with SMTP id w204mr852917oia.167.1606974733598;
 Wed, 02 Dec 2020 21:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201108213838.4880-1-sorganov@gmail.com>
 <20201108213838.4880-10-sorganov@gmail.com>
In-Reply-To: <20201108213838.4880-10-sorganov@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Dec 2020 21:52:02 -0800
Message-ID: <CABPp-BESWpqska++EsfxfbncyV0kNo1RGLjF+1BiV=D6zLx2LQ@mail.gmail.com>
Subject: Re: [PATCH v1 09/27] diff-merges: re-arrange functions to match the
 order they are called in
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 8, 2020 at 1:43 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> For clarity, define public functions in the order they are called, to
> make logic inter-dependencies easier to grok.

You added diff-merges.[ch] earlier in this series.  Why not just add
them in the correct order initially instead of adding another patch
later in the series?

>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  diff-merges.c | 24 ++++++++++++++----------
>  diff-merges.h |  7 +++----
>  2 files changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/diff-merges.c b/diff-merges.c
> index bb08a92e3b36..8536941e0b56 100644
> --- a/diff-merges.c
> +++ b/diff-merges.c
> @@ -2,6 +2,10 @@
>
>  #include "revision.h"
>
> +/*
> + * Public functions. They are in the order they are called.
> + */
> +
>  void diff_merges_init_revs(struct rev_info *revs) {
>         revs->ignore_merges = -1;
>  }
> @@ -44,16 +48,6 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
>         return 1;
>  }
>
> -void diff_merges_setup_revs(struct rev_info *revs)
> -{
> -       if (revs->combine_merges && revs->ignore_merges < 0)
> -               revs->ignore_merges = 0;
> -       if (revs->ignore_merges < 0)
> -               revs->ignore_merges = 1;
> -       if (revs->combined_all_paths && !revs->combine_merges)
> -               die("--combined-all-paths makes no sense without -c or --cc");
> -}
> -
>  void diff_merges_default_to_first_parent(struct rev_info *revs) {
>         if (revs->ignore_merges < 0)            /* No -m */
>                 revs->ignore_merges = 0;
> @@ -68,3 +62,13 @@ void diff_merges_default_to_dense_combined(struct rev_info *revs) {
>                 }
>         }
>  }
> +
> +void diff_merges_setup_revs(struct rev_info *revs)
> +{
> +       if (revs->combine_merges && revs->ignore_merges < 0)
> +               revs->ignore_merges = 0;
> +       if (revs->ignore_merges < 0)
> +               revs->ignore_merges = 1;
> +       if (revs->combined_all_paths && !revs->combine_merges)
> +               die("--combined-all-paths makes no sense without -c or --cc");
> +}
> diff --git a/diff-merges.h b/diff-merges.h
> index 20b727bd734f..4b023c385d00 100644
> --- a/diff-merges.h
> +++ b/diff-merges.h
> @@ -7,11 +7,10 @@ void diff_merges_init_revs(struct rev_info *revs);
>
>  int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
>
> -void diff_merges_setup_revs(struct rev_info *revs);
> -
> -void diff_merges_default_to_dense_combined(struct rev_info *revs);
> -
>  void diff_merges_default_to_first_parent(struct rev_info *revs);
>
> +void diff_merges_default_to_dense_combined(struct rev_info *revs);
> +
> +void diff_merges_setup_revs(struct rev_info *revs);
>
>  #endif
> --
> 2.25.1
>
