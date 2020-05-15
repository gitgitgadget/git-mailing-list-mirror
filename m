Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C20C433E1
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847D020756
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMsXRkmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgEORcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 13:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbgEORcT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 13:32:19 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E0BC061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 10:32:18 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d7so2306374eja.7
        for <git@vger.kernel.org>; Fri, 15 May 2020 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dcB3gQp2t/f/ncunTTVOuOfoIzqjnYsBe3AhID3VgWA=;
        b=CMsXRkmWSzImINeowVYIvbQzaKm/tKo908EbWh45rgC7ICfSOuFBwg/9H3iS5bIckB
         Yzxi9OaPBVxyAWkSGKW/mlRJRB2Wr7k9fksODjucJPJTNexJSPb/DhZRG6puG6m2ljSS
         9mCYSC9/6+Bpq8r3WRHczNxTs4G3n0iaDlW5S8cm1M7xRgdzmwOpfYfH5OM1RBsl/PZq
         crKzMUadTDsBu6uTnJdeRcLtCTCzNQuP/sgbLNAtopeF9xicSvpTQIaic1ZJGSdSpLsx
         w8Zkby0V8gCZzqeZDLPx8988aPI0RFIh10ppSSXYkN218+zbP6S+RGXuOY7FYpl7DMrk
         YEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dcB3gQp2t/f/ncunTTVOuOfoIzqjnYsBe3AhID3VgWA=;
        b=aVvnqkYiLGJkwL4hzOoMFwcBs1C24BcmnQs5STR7Vf2U278ZgbYnQVWXpHqRVUENdF
         7Igp6F8XhAOSZYFPmrFj9Wp1fh9HfZ87zzuQhXQRSIl9AWshbBkJioqI43TnH0RnCTas
         8xuss/ne2k/vmAmduOlWBMzphan5Ys3WDpCk86T8BjofqJ+l5eGAu00WgCjso1UVGOny
         jnMLvBAvqLlwHqLyvCp9+XsxWM0UgK7LYwDEJ9wmoVAHfnqb/6e/m12afdjg2uluRlc3
         Mb6hY8yd8QyPQTkeWLlSWjU+MC7WMsH5b8rMVgTvNmx6UWT8wESFTQJf6gnr6IVKei/e
         Wrhg==
X-Gm-Message-State: AOAM533ehTfeqwIsi1Hrw10GfMjkLQfRegse3+YdU2zzwVSzLMqrScjk
        C/otoDGb6E3+1JYqVrlcDjFV7ZN2dJyPehnnesQ=
X-Google-Smtp-Source: ABdhPJyBIoTAVAGN/GVgmp135V4opJQnDz3M1krQvhaih2wKT7dytenwvwuYRRFpzttb0prT8FGLSe0Nz4X99rkeXCs=
X-Received: by 2002:a17:907:948d:: with SMTP id dm13mr4060459ejc.138.1589563936791;
 Fri, 15 May 2020 10:32:16 -0700 (PDT)
MIME-Version: 1.0
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Fri, 15 May 2020 19:32:05 +0200
Message-ID: <CAL3xRKdwOASiGys+7Uu_OA5kBPrTdAURfEw3UQ+rguTXT+C6JQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] gitfaq: files in .gitignore are tracked
To:     shouryashukla.oo@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey folks,

> Add issue in 'Common Issues' section which addresses the problem of
> Git tracking files/paths mentioned in '.gitignore'.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  Documentation/gitfaq.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 1cf83df118..11d9bac859 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -223,6 +223,16 @@ a file checked into the repository which is a template or set of defaults which
>  can then be copied alongside and modified as appropriate.  This second, modified
>  file is usually ignored to prevent accidentally committing it.
>
> +[[files-in-.gitignore-are-tracked]]

This does not work for older xmlto(centos6) for whatever reason.
```
# make doc
...
# xmlto -m manpage-normal.xsl  -m manpage-bold-literal.xsl -m
manpage-base-url.xsl man gitfaq.xml
xmlto: /<git-dir>/Documentation/gitfaq.xml does not validate (status 3)
xmlto: Fix document syntax or use --skip-validation option
/<git-dir>/Documentation/gitfaq.xml:3: element refentry: validity
error : Element refentry content does not follow the DTD, expecting
(beginpage? , indexterm* , refentryinfo? , refmeta? , (remark | link |
olink | ulink)* , refnamediv+ , refsynopsisdiv? , (refsect1+ |
refsection+)), got (refmeta refnamediv refsynopsisdiv refsect1
refsect1 refsect1 refsect1 variablelist refsect1 refsect1 )
```

Build went fine on Centos7 and Centos8 though.

I ran a quick sed to temporarily fix the problem
```
sed -i 's/files-in-\.gitignore/files-in-gitignore/g' Documentation/gitfaq.txt
```

But I suggest to just remove the period from this heading.

> +I asked Git to ignore various files, yet they are still tracked::
> + A `gitignore` file ensures that certain file(s) which are not
> + tracked by Git remain untracked.  However, sometimes particular
> + file(s) may have been tracked before adding them into the
> + `.gitignore`, hence they still remain tracked.  To untrack and
> + ignore files/patterns, use `git rm --cached <file/pattern>`
> + and add a pattern to `.gitignore` that matches the <file>.
> + See linkgit:gitignore[5] for details.
> +
>  Hooks
>  -----
>
> --
> 2.26.2

Cheers,
Son Luong.
