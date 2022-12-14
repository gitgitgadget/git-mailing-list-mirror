Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720C8C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 14:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbiLNOFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 09:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238627AbiLNOEl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 09:04:41 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BCA27FF0
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 06:04:31 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id y135so21470787yby.12
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 06:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xWP3SyU+nZzvc5GGLtnpYLBTaSPeIIi7UEqHPBIlL74=;
        b=O+yIwMeBl7m+ZuEOZQsv9FkLkTTFMiNdXM450j/pY2Z9KLd/kHNLEspHgLkU2J8o/g
         N+JsEK4eUfVwcvyxM2B+nfAlrXzYruUSiKwlwRSZ4+JXuGTm93g3jThJegbzFlXg3cnF
         cBx7yAxG4El5EIQUPddRvrtgvqs2Li8cdeYP5kLUEP7Jg5WV+mQKCYWuUUpp90PxGmGt
         9RUT6med+fgJLdTNtLdmEJh9MgnV1gEGTiEDFKxTnLS8ImmgerLVPSoVV56RGXq2QRVu
         tqd1RZvhXv3sFVcBitDEd8b2V20i16BTw1QvGdwBt/xb/27xnB7f54DY+SkhhB6WWb80
         F3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWP3SyU+nZzvc5GGLtnpYLBTaSPeIIi7UEqHPBIlL74=;
        b=WEE/aAnizZoNhA7cjbWII+jebBvWceMI4gy3+aLkEExNN/CacBfcLs7cT7UNw9GADo
         qgURLyxmknfo39eldGN2tLDHGkd3XWd0zYsTyFxO7nbl54z32vvDrVKHIU+GDHFF1f/9
         lj1C8vcsLaT+4wrjzBMEG50O73z8eM+5dH9r9AGchwJAhZ8Y0g5ydJpqAF68JvJWauut
         l8Pu8BuhQwsjLklOVc0wXKMHYAGiWSBxv9sIweRhwsBAZ3i97vNF+bMvYLnk8+u8/cbj
         obRrQOqm5P8+Gv7wd1uhNUoX3uHWRWNYdJpWVTxfo6nDytrW82gi3rkHi0Woor/xXflr
         m/qg==
X-Gm-Message-State: ANoB5pk7RPEQZ6SVmMiuv6EpxmOB9qRWnGnrE/Z0inI8ASoeTs09c6rv
        COTRj3roycjJtri+zPQmzoXwY5xYtuZ2AKDPhVA/CD0jbJs=
X-Google-Smtp-Source: AA0mqf7Fl9Pst3R16J/XtoDRuPYNZLqxuYzXZRxOluDZNquqluZQ9k0Hk3Ki+g9rs/5fBWVFKIIWUZJxDyoLKsVHAwE=
X-Received: by 2002:a5b:8cf:0:b0:6f8:92de:92e3 with SMTP id
 w15-20020a5b08cf000000b006f892de92e3mr42347947ybq.105.1671026670195; Wed, 14
 Dec 2022 06:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221201155504.320461-1-siddharthasthana31@gmail.com> <20221201155504.320461-3-siddharthasthana31@gmail.com>
In-Reply-To: <20221201155504.320461-3-siddharthasthana31@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 14 Dec 2022 15:04:17 +0100
Message-ID: <CAP8UFD0_86GiwNXmCZzVfDJTE5C6KWz=8F9S4hVEA5Xi8XhgDw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] cat-file: add mailmap support to --batch-check option
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 1, 2022 at 4:55 PM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:

> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index f82d702d6b..81235c60a3 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -91,26 +91,49 @@ OPTIONS
>  --batch::
>  --batch=<format>::
>         Print object information and contents for each object provided
> -       on stdin.  May not be combined with any other options or arguments
> -       except `--textconv` or `--filters`, in which case the input lines

Nit: here there were backticks around --textconv and --filters ...

> -       also need to specify the path, separated by whitespace.  See the
> -       section `BATCH OUTPUT` below for details.
> +       on stdin. May not be combined with any other options or arguments
> +       except --textconv, --filters, or --use-mailmap.

... but here there are no backticks anymore.

It would be better if backticks were used.

> +       +
> +       * When used with `--textconv` or `--filters`, the input lines

Here and below backticks are used which is good.

> +         must specify the path, separated by whitespace. See the section
> +         `BATCH OUTPUT` below for details.
> +       +
> +       * When used with `--use-mailmap`, for commit and tag objects, the
> +         contents part of the output shows the identities replaced using the
> +         mailmap mechanism, while the information part of the output shows
> +         the size of the object as if it actually recorded the replacement
> +         identities.
>
>  --batch-check::
>  --batch-check=<format>::
> -       Print object information for each object provided on stdin.  May
> -       not be combined with any other options or arguments except
> -       `--textconv` or `--filters`, in which case the input lines also
> -       need to specify the path, separated by whitespace.  See the
> -       section `BATCH OUTPUT` below for details.
> +       Print object information for each object provided on stdin. May not be
> +       combined with any other options or arguments except --textconv, --filters
> +       or --use-mailmap.

Here backticks are also missing.

> +       +
> +       * When used with `--textconv` or `--filters`, the input lines must
> +        specify the path, separated by whitespace. See the section
> +        `BATCH OUTPUT` below for details.
> +       +
> +       * When used with `--use-mailmap`, for commit and tag objects, the
> +         printed object information shows the size of the object as if the
> +         identities recorded in it were replaced by the mailmap mechanism.
>
>  --batch-command::
>  --batch-command=<format>::
>         Enter a command mode that reads commands and arguments from stdin. May
> -       only be combined with `--buffer`, `--textconv` or `--filters`. In the
> -       case of `--textconv` or `--filters`, the input lines also need to specify
> -       the path, separated by whitespace. See the section `BATCH OUTPUT` below
> -       for details.
> +       only be combined with `--buffer`, `--textconv`, `--use-mailmap` or
> +       `--filters`.

Here they are used which is good.

> +       +
> +       * When used with `--textconv` or `--filters`, the input lines must
> +         specify the path, separated by whitespace. See the section
> +         `BATCH OUTPUT` below for details.
> +       +
> +       * When used with `--use-mailmap`, for commit and tag objects, the
> +         `contents` command shows the identities replaced using the
> +         mailmap mechanism, while the `info` command shows the size
> +         of the object as if it actually recorded the replacement
> +         identities.

Thanks!
