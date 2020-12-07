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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADB4C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 09:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A45233E2
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 09:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgLGJKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 04:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgLGJKN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 04:10:13 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA78C0613D0
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 01:09:35 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id d17so18390106ejy.9
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 01:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BlxRzC7RCvJOOQVO7iORa+kF+417FN9YN6YMz2H/+jk=;
        b=qMEFqSYlMukb4Kcdg3vxxbjwKIjiuRNP3I4mnnNySZ8cmqfuXU1lnLiLQDGa84tY+o
         D3xvBqyQNuuarIWwY3BMb5hpUzGdNdvIUQJ+x3GIWvTNgd4YYpmwqMUSSqDveKeQz6vw
         YurYp0IyerVYAvjIgAVThqs6nGJL6ISaRZGAy0f89SHG5eJ+iksg6Kn9XKCAEU18jeJ0
         yAUjE6wlJAQhnx1jTk2N7cyBNBxZz+z7oIv408o9qDH5tFlUow1wjKV/FFTyREdCI+EI
         M3qzlQrMBo2bA1xHGY6Hm50tPUuvXmb7DS9mhzDDtaxqIsnMoDxdnV9Tg0JlaGs6q6aj
         CcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BlxRzC7RCvJOOQVO7iORa+kF+417FN9YN6YMz2H/+jk=;
        b=Wv2txVAnpkBiiOaLFEeKNCfkoiJxxeWrK8A7ccInthVgZJG+lL5ECFtqCw0BAUwKJd
         Afd1wekhJUVZK3mHuUAumjD5hOw1DJhnSRzfwRDLKtAyht/zHMHB25/VQ2OX2ezPbBs9
         O+FXEHn9i5NbKe9QLZIL8NsIIk/Uictn4UhiyZnV3FaZk/i7APW1kYcG3q92TYB2/z8O
         kgvQr5gOJpaMuBOetaX7WpvfaY5WBuNb095wv5hcSP/TzQUJI8Op7QBvqo5pOUqTmtzL
         zbOrh2JAFbqKX1l4cqsiMPX0tX70tapmfOGFtQ8/ToD6k9th2WsVfhRXkX16t3xSKWwU
         /+IA==
X-Gm-Message-State: AOAM532AXpfW9VscR8HN2n61qzJyagixNi22O9alJaq/2kSzNhw3kl3c
        nHSn8HfIRXjSY5HiBT+yTm4xvaJm07xsUY2lSHM=
X-Google-Smtp-Source: ABdhPJzFs4qhC6rlA17+o8QaYXICYx9AxrYjCRq+rIjll47n8+sSTosfLQxqjCrgXMfAOxOgIkJWhah1lvPP2E8UKFI=
X-Received: by 2002:a17:906:27c2:: with SMTP id k2mr17637855ejc.211.1607332174467;
 Mon, 07 Dec 2020 01:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20201205013918.18981-1-avarab@gmail.com> <20201206002449.31452-3-avarab@gmail.com>
In-Reply-To: <20201206002449.31452-3-avarab@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 7 Dec 2020 10:09:23 +0100
Message-ID: <CAP8UFD3CY1TuKh5TYzEqL1w87cfGHbgoavRoSgcx=uwgpBkfaA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] pretty format %(trailers) doc: avoid repetition
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 6, 2020 at 1:25 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Change the documentation for the various %(trailers) options so it
> isn't repeating part of the documentation for "only" about how boolean
> values are handled. Instead, let's split the description of that into
> general documentation at the top.
>
> It then suffices to refer to it by listing the options as
> "opt[=3D<BOOL>]". I'm also changing it to upper-case "[=3D<BOOL>]" from
> "[=3Dval]" for consistency with "<SEP>"

Good...

> It took me a couple of readings to realize that these options were
> referring back to the "only" option's treatment of boolean
> values. Let's try to make this more explicit, and upper-case "BOOL"
> for consistency with the existing "<SEP>" and "<K>".

... but not sure it's worth repeating that we upper-case "BOOL".

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Documentation/pretty-formats.txt | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-form=
ats.txt
> index 84bbc7439a6..66dfa122361 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -252,7 +252,15 @@ endif::git-rev-list[]
>                           interpreted by
>                           linkgit:git-interpret-trailers[1]. The
>                           `trailers` string may be followed by a colon
> -                         and zero or more comma-separated options:
> +                         and zero or more comma-separated options.
> +                         If any option is provided multiple times the
> +                         last occurance wins.
> ++
> +The boolean options accept an optional value `[=3D<BOOL>]`. The values
> +`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
> +sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
> +option is given with no value, it's enabled.

> +** 'only[=3DBOOL]': select whether non-trailer lines from the trailer

Here it's "[=3DBOOL]" while above it's "[=3D<BOOL>]"

> +** 'unfold[=3DBOOL]': make it behave as if interpret-trailer's `--unfold=
`

Here also.

> +** 'valueonly[=3DBOOL]': skip over the key part of the trailer line and =
only

And here too.

> +   show the value part.
