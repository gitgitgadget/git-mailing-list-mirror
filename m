Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471CEC43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 15:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiGJPK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 11:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJPKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 11:10:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9E3A197
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 08:10:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ez10so4965481ejc.13
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 08:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6WXMpLt8HIf4+NZ9AN5ydIe+fgCsyWJ7JtqW5iJEqz4=;
        b=g9feg+3jioBALMOYAVYw15Qxojan6om747sLJbVjAPebaySqTC4ZgjlF8RFkJJOntS
         5l34RFoCgpFGU4gd4KPCKxJ9GhlAbgC2R1Wy6QPeqMnSg7oohidrlU2PBDrWHcJN/l6p
         D8uPc8hRTF2cbN5qJbTCZOwGXYMG/MLW95cJxgAoUWm0PxXFEQFIbU5vbM2J4UH3xAx7
         ZwDEdAcpvTysch7vYX6Cw9AnODSsdFxb3o9QIHRvXoGrNApCNJHTA5llSsDhuxUQFyPw
         fKOguxVD3bU7jL8A7s3nUO+80uCoCSCC6YzwM3flIvIiIxcVhisnaouJBqY4q1ewxR57
         OFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6WXMpLt8HIf4+NZ9AN5ydIe+fgCsyWJ7JtqW5iJEqz4=;
        b=TObumYFU6Jsgi1fgUohwgtCDlw7fS/quQSIVEwBlSDwh+gplavxFcF69HFLVvX0d7l
         9SbefmDBo43cCJsx+SKCszuMJJvs1UwzQ7byDyS02SA30cY6TbpS7ixQjKdKjmYPsBw5
         WL++/Z0NVyEwWtxWwmGF+UTA18jI3+cUuxgNrtiPfeX5zRXrhnPBvbsm4sCZvKFfvxtF
         E9kd88Huat9/GuXcpw3DIysFhElbYct8l+a4g2hM700aPm2e3UuFkyKSFW/oE3fTgyPW
         93dyC5M2//dYBHchON+FBw6z3DVOcTC+H86vE77OX73HRZjKaVNM1RKxitNXhLsu1NrM
         0kuw==
X-Gm-Message-State: AJIora9ejn/7hxxqt3Ft+3eoXXs9mej3DNRZWCXGpEfoAtkc0hXM/jbs
        fBccMWB8h4SZEqy1nmvsK/6G9p2kZK0=
X-Google-Smtp-Source: AGRyM1sMTeeCJSx383qU6rPWumyYilkPuw5jxLLQfznSu9KbeM+UfbBy5yGvf29K2IdhVBQMQXEUPg==
X-Received: by 2002:a17:906:8448:b0:72b:5659:9873 with SMTP id e8-20020a170906844800b0072b56599873mr42486ejy.117.1657465822225;
        Sun, 10 Jul 2022 08:10:22 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a25-20020aa7cf19000000b0043a56c0ededsm2857152edy.74.2022.07.10.08.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 08:10:21 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAYZg-000BWH-Ns;
        Sun, 10 Jul 2022 17:10:20 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] cocci: avoid normalization rules for memcpy
Date:   Sun, 10 Jul 2022 16:45:35 +0200
References: <xmqq8rp54r4l.fsf@gitster.g>
 <220707.86y1x585wy.gmgdl@evledraar.gmail.com> <xmqq1quw23r8.fsf@gitster.g>
 <cb866b8c-dcc6-557f-da23-1c1972619a8a@web.de>
 <95432eb4-e66a-5c04-9267-f71391fbe277@web.de> <xmqqmtdhsf1z.fsf@gitster.g>
 <ded153d4-4aea-d4da-11cb-ec66d181e4c9@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <ded153d4-4aea-d4da-11cb-ec66d181e4c9@web.de>
Message-ID: <220710.86ilo580mb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 10 2022, Ren=C3=A9 Scharfe wrote:

> Some of the rules for using COPY_ARRAY instead of memcpy with sizeof are
> intended to reduce the number of sizeof variants to deal with.  They can
> have unintended side effects if only they match, but not the one for the
> COPY_ARRAY conversion at the end.

Since ab/cocci-unused is marked for "next" it would be really nice to
have this based on top so we can add tests for these transformations
(the topic adds a way to do that).

But if you don't feel like  doing that this is fine too.

> diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.co=
cci
> index 9a4f00cb1b..aa75937950 100644
> --- a/contrib/coccinelle/array.cocci
> +++ b/contrib/coccinelle/array.cocci
> @@ -1,60 +1,58 @@
> -@@
> -expression dst, src, n, E;
> -@@
> -  memcpy(dst, src, n * sizeof(
> -- E[...]
> -+ *(E)
> -  ))
> -
> -@@
> -type T;
> -T *ptr;
> -T[] arr;
> -expression E, n;
> -@@
> -(
> -  memcpy(ptr, E,
> -- n * sizeof(*(ptr))
> -+ n * sizeof(T)
> -  )
> -|
> -  memcpy(arr, E,
> -- n * sizeof(*(arr))
> -+ n * sizeof(T)
> -  )
> -|
> -  memcpy(E, ptr,
> -- n * sizeof(*(ptr))
> -+ n * sizeof(T)
> -  )
> -|
> -  memcpy(E, arr,
> -- n * sizeof(*(arr))
> -+ n * sizeof(T)
> -  )
> -)
> -
>  @@
>  type T;
>  T *dst_ptr;
>  T *src_ptr;
> -T[] dst_arr;
> -T[] src_arr;
>  expression n;
>  @@
> -(
> -- memcpy(dst_ptr, src_ptr, (n) * sizeof(T))
> +- memcpy(dst_ptr, src_ptr, (n) * \( sizeof(T)
> +-                                \| sizeof(*(dst_ptr))
> +-                                \| sizeof(*(src_ptr))
> +-                                \| sizeof(dst_ptr[...])
> +-                                \| sizeof(src_ptr[...])
> +-                                \) )
>  + COPY_ARRAY(dst_ptr, src_ptr, n)
> -|
> -- memcpy(dst_ptr, src_arr, (n) * sizeof(T))
> +
> +@@
> +type T;
> +T *dst_ptr;
> +T[] src_arr;
> +expression n;
> +@@
> +- memcpy(dst_ptr, src_arr, (n) * \( sizeof(T)
> +-                                \| sizeof(*(dst_ptr))
> +-                                \| sizeof(*(src_arr))
> +-                                \| sizeof(dst_ptr[...])
> +-                                \| sizeof(src_arr[...])
> +-                                \) )
>  + COPY_ARRAY(dst_ptr, src_arr, n)
> -|
> -- memcpy(dst_arr, src_ptr, (n) * sizeof(T))
> +
> +@@
> +type T;
> +T[] dst_arr;
> +T *src_ptr;
> +expression n;
> +@@
> +- memcpy(dst_arr, src_ptr, (n) * \( sizeof(T)
> +-                                \| sizeof(*(dst_arr))
> +-                                \| sizeof(*(src_ptr))
> +-                                \| sizeof(dst_arr[...])
> +-                                \| sizeof(src_ptr[...])
> +-                                \) )
>  + COPY_ARRAY(dst_arr, src_ptr, n)
> -|
> -- memcpy(dst_arr, src_arr, (n) * sizeof(T))
> +
> +@@
> +type T;
> +T[] dst_arr;
> +T[] src_arr;
> +expression n;
> +@@
> +- memcpy(dst_arr, src_arr, (n) * \( sizeof(T)
> +-                                \| sizeof(*(dst_arr))
> +-                                \| sizeof(*(src_arr))
> +-                                \| sizeof(dst_arr[...])
> +-                                \| sizeof(src_arr[...])
> +-                                \) )
>  + COPY_ARRAY(dst_arr, src_arr, n)
> -)
>
>  @@
>  type T;

Hrm, this seems like a lot of repetition, it's here in the rules you're
editing already, but these repeated "sizeof" make it a lot more verbose.

Isn't there a way to avoid this by simply wrapping this across lines, I
didn't test, but I think you can do this sort of thing in the cocci
grammar:

- memcpy(
- COPY_ARRAY(
  (
  dst_arr
  |
  dst_ptr
  )
  ,
  (
  src_arr
  |
  src_ptr
  )
  ,
  (n) *
-  [your big sizeof alternate here]
  )

I.e. you want to preserve whatever we match in the 1st and 2nd
arguments, but only want to munge part of the 3rd argument. The cocci
grammar can "reach into" lines like that, it doesn't need to be limited
to line-based diffs.

But I didn't try it in this caes, and maybe there's a good reason for
why it can't happen in this case...

I also wonder if that won't be a lot faster, i.e. if you can condense
this all into one rule it won't need to match this N times, but maybe
the overall complexity of the rules makes it come out to the same thing
in the end...
