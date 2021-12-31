Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF812C433EF
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 03:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbhLaDUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 22:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhLaDUK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 22:20:10 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99392C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 19:20:09 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id h15so29985406ljh.12
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 19:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e7h3VUWMZnbAD05/BiaRrTSd2c5pcWnwwjXpQgfOJyc=;
        b=DNrIkBRnvZmlnqf/R8PI6XUIt5E09/ZrO+QiTRFb9VqrEm2x4iRKis5JXhIfQuxQGZ
         dyYWFXxeU20PCR6vL2E5y1/c7L7boc1hoOffrB1w7vgnGZrmLQ6nMHUXpJSKiZ4/fkbK
         vvfNUE2OO2E/Dx8IVOuREm/vPGY6W6KLAGfJDWHE/5GqnI8JcOubW0/C/yOvoI/d811h
         /GkCld0A0UEHD7PWsWpgj01QYqkFWvXrNt9B26CZWHUE4KptJ0XKD3VHPRtRiP+/wX8x
         tMuefF+lX4W+byZRzj/uCL8y/Ggi9y9pu3V2jtIE1dZrZuF/+P5h5SS2bIp6m18CtfyK
         Pnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e7h3VUWMZnbAD05/BiaRrTSd2c5pcWnwwjXpQgfOJyc=;
        b=Ky1a2G08w0L+BDL+IbneAWWNTKUNqi8Es731QquG3AQftE7U4A0hg7uzNwYn30CL7q
         rMyCnD3UUo2CPdSDoRbd8LEbv6e5iaXzE+MKo++8XV7MwtnbgwDItl1SRZUG7M8ZPyBU
         aForrHup+HB5KdysgdqrrVEvLxdCx3tFMOuf2ubZjKeVbgQvXVicdk4oTdLbw91OWp3c
         qxoetjGf+ymVdQF+PUG879KffdQ7PGqZclpJnC0TBYQV83t2l8QIdqxC0Ny22SnQ8hyk
         sjxNi6gH2RWt27fCdp4OXrIIToY2lrFqKthdWGSdbUrJW/CiSmaLFb00u3iSeHVKFRZ6
         U4Cg==
X-Gm-Message-State: AOAM531PFscUMfSgXdqCENlr1RglLRq7uwfjfQX+yDmsieTpCS0L27iX
        52nmioNT+eHua6unQ7jVb3zo+qtOljaj3NsEHAM=
X-Google-Smtp-Source: ABdhPJwahYnSUjwLifiZTTUxMV4vg1KXqjXlile16VtjIbyoNiYU8MfRumLXJCAd/QfzNaRY+NtseOltPiWiekJGkV8=
X-Received: by 2002:a05:651c:1204:: with SMTP id i4mr26013712lja.195.1640920807761;
 Thu, 30 Dec 2021 19:20:07 -0800 (PST)
MIME-Version: 1.0
References: <20211217112629.12334-1-chiyutianyi@gmail.com> <20211221115201.12120-6-chiyutianyi@gmail.com>
In-Reply-To: <20211221115201.12120-6-chiyutianyi@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 31 Dec 2021 11:19:56 +0800
Message-ID: <CANYiYbGKiSH6WA2HbTtxV6S3-aURAkKh2VCrV9wp-5us-uzoXA@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] unpack-objects: unpack_non_delta_entry() read data
 in a stream
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 2:56 AM Han Xin <chiyutianyi@gmail.com> wrote:
>
> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> We used to call "get_data()" in "unpack_non_delta_entry()" to read the
> entire contents of a blob object, no matter how big it is. This
> implementation may consume all the memory and cause OOM.
>
> By implementing a zstream version of input_stream interface, we can use
> a small fixed buffer for "unpack_non_delta_entry()".
>
> However, unpack non-delta objects from a stream instead of from an
> entrie buffer will have 10% performance penalty. Therefore, only unpack
> object larger than the "core.BigFileStreamingThreshold" in zstream. See
> the following benchmarks:
>
>     hyperfine \
>       --setup \
>       'if ! test -d scalar.git; then git clone --bare https://github.com/=
microsoft/scalar.git; cp scalar.git/objects/pack/*.pack small.pack; fi' \
>       --prepare 'rm -rf dest.git && git init --bare dest.git'
>
>     Summary
>       './git -C dest.git -c core.bigfilethreshold=3D512m unpack-objects <=
small.pack' in 'origin/master'
>         1.01 =C2=B1 0.04 times faster than './git -C dest.git -c core.big=
filethreshold=3D512m unpack-objects <small.pack' in 'HEAD~1'
>         1.01 =C2=B1 0.04 times faster than './git -C dest.git -c core.big=
filethreshold=3D512m unpack-objects <small.pack' in 'HEAD~0'
>         1.03 =C2=B1 0.10 times faster than './git -C dest.git -c core.big=
filethreshold=3D16k unpack-objects <small.pack' in 'origin/master'
>         1.02 =C2=B1 0.07 times faster than './git -C dest.git -c core.big=
filethreshold=3D16k unpack-objects <small.pack' in 'HEAD~0'
>         1.10 =C2=B1 0.04 times faster than './git -C dest.git -c core.big=
filethreshold=3D16k unpack-objects <small.pack' in 'HEAD~1'
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Helped-by: Derrick Stolee <stolee@gmail.com>
> Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  Documentation/config/core.txt       | 11 +++++
>  builtin/unpack-objects.c            | 73 ++++++++++++++++++++++++++++-
>  cache.h                             |  1 +
>  config.c                            |  5 ++
>  environment.c                       |  1 +
>  t/t5590-unpack-non-delta-objects.sh | 36 +++++++++++++-
>  6 files changed, 125 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.tx=
t
> index c04f62a54a..601b7a2418 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -424,6 +424,17 @@ be delta compressed, but larger binary media files w=
on't be.
>  +
>  Common unit suffixes of 'k', 'm', or 'g' are supported.
>
> +core.bigFileStreamingThreshold::
> +       Files larger than this will be streamed out to a temporary
> +       object file while being hashed, which will when be renamed
> +       in-place to a loose object, particularly if the
> +       `core.bigFileThreshold' setting dictates that they're always
> +       written out as loose objects.

Han Xin told me the reason to introduce another git config variable,
but I feel it not good to introduce an application specific config
variable as "core.XXX" and parsing it in "config.c".

So in patch v8, will still reuse the config variable
"core.bigFileThreshold", and will introduce an application specific
config variable, such as unpack.bigFileThreshold and parse the new
config in "builtin/unpack-objects.c".

--
Jiang Xin
