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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADCBC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A60864F76
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhCLBdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 20:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhCLBdP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 20:33:15 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83D6C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 17:33:14 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id b10so23754879ybn.3
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 17:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=of+o10UA5gJw7Ki/2OesuCyehsLvAtsHbpnad4QYkhc=;
        b=XTzm3lGC+g+ztpWIQ2PAtazW0WvlF9Jmjsn7unx+xgAVGaGsAAXZrlqsvf5eoqlLaI
         HFKhYdXxucB42LNS15eIRszpOtQcUReteJKy9PUpKzuqLfuL9Y7+ccGs+5nnJBmJ7WGP
         M4L+7rTXcYleVtyJD9suJyqkatnc4+DoRw6MMRxUjhRBzNlehra55QCC4bZyoBojYP2Z
         /ecbYMFhBMmpm/hX7RknGJfi6lzXEtBopBloqD0sny56L2SWBxC4JTD9OxR6MfwaZSyb
         smcA61gKGpkVlHH+Ly2b+lAO6mFV/Sn11ZnopqSrijrDrK+MxssxwUC1iqEGka+8WzaS
         o3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=of+o10UA5gJw7Ki/2OesuCyehsLvAtsHbpnad4QYkhc=;
        b=CpCQcc/SMRrr7MZo3GiPsIQqx3dLj62AkTEWVL2uE+Ssr00HFd2QB/pOj9KWlugkYk
         2LrIg2sk6cWaMs7EM6oSWurDoWYNqUgaAfjzFgboW1L7ny4SWDFFj4OgWWjn68XZW0+a
         utV6xn8QwUnJ1xGPtTWbJsKO6NALc44NuWWDabhzttzXAqO8X/m18p451RrPOUvsXcQ/
         2XL5EhVcjlfh+vr1d1PXmQDkLHmj7Pvpeg1mQE2GGrBNws/sm+K4f0kTqp0HQM2qWgki
         myWXd2qbWMiSe8q0K/AIiYhFuFnLQ8HLab1Pwy5/4ZGfTM7f51jC+DAhI3JVogZmR/Ge
         Zlgg==
X-Gm-Message-State: AOAM530epAqovq+lCP7m+zEA1LOEab4Xe4ZlnYuC+oXqw+fLIqPEyaeK
        tHTlAvYdGIEWKJ+ZWqBAOslxca5d+4oHimwwggs=
X-Google-Smtp-Source: ABdhPJyU5QM5eAtksRJqS1ePbs8N9QijtB6y1iet/AeVwNIB3h6WUKrZhv1qaTh9+wj+f3Wap21P9YC+ont9ow4CRfQ=
X-Received: by 2002:a25:d314:: with SMTP id e20mr14605056ybf.155.1615512793854;
 Thu, 11 Mar 2021 17:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20210311125511.51152-1-bagasdotme@gmail.com> <20210311125511.51152-4-bagasdotme@gmail.com>
In-Reply-To: <20210311125511.51152-4-bagasdotme@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 12 Mar 2021 09:33:02 +0800
Message-ID: <CANYiYbFDJ-CDsJs04=uPsUvcVqPA8wpY2g8ZP_6R5UsYQbQvAg@mail.gmail.com>
Subject: Re: [PATCH 3/3] po/README: document l10n conventions
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8811=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:56=E5=86=99=E9=81=93=EF=BC=9A
>
> Document things that l10n contributors must folow.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  po/README | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/po/README b/po/README
> index eda7edf4e6..e1a0494b17 100644
> --- a/po/README
> +++ b/po/README
> @@ -344,3 +344,24 @@ Below are the usage examples:
>          po-helper.sh check XX.po
>
>  Run po-helper.sh without arguments for usage help.
> +
> +
> +Conventions
> +-----------
> +
> +There are some conventions that l10n contributors must follow:
> +
> +   1. The subject of each commit should be prefixed with `l10n: `.
> +   2. The length of commit log title (subject) should be less than 50
> +      characters, and the length of other lines (commit log body)
> +      should be no more than 72 characters.
> +   3. Add "Signed-off-by" trailer to your commit log, like other
> +      commits in Git. You can automatically add the trailer by
> +      committing with `git commit -s`.
> +   4. Check syntax with `msgfmt` or `po-helper.sh check` before
> +      committing.
> +   5. Squash trivial commits to make history clear.
> +   6. Do NOT edit files outside po/ directory.
> +   7. Other subsystems ("git-gui", "gitk", and Git itself) have their
> +      own workflow. See Documentation/SubmittingPatches if you want
> +      to make contributions to these subsystems.

This patch 3/3 can be merged before we reimplement the utility `git-po-help=
er`.

--
Jiang Xin
