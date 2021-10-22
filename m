Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1267AC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 06:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC76B604D2
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 06:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhJVG7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 02:59:37 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:41491 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhJVG7g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 02:59:36 -0400
Received: by mail-ed1-f44.google.com with SMTP id a25so3357972edx.8
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 23:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tab3UhV3V+ntwJx6jm+KOnbwgQdkTue7q1xUH/SrNGc=;
        b=Fmo2ORHIKiatdB74iX7EpGRvJUxMvvuxGJtSoO3sFMnfjMc/jg/IzfxS3Z0SkD8srH
         FYuDlYfBdJ5NDxVqrq+vkVJtYyzyXfdDvMy4Mc97oUjeCLpHNj+vl/iJaT/hieN/tZHB
         cWIg8lQ5D/X/jINWeUK/2KgB/BX9FfD/QUnBVHFhWB+nHENSwv0vk6ei/WGoZPsdcAUT
         umJdl429Axiz69qglIipaCn1b3I9kxa7CwgFoOllU49STqbkpJOv07JKRW2FJCFD0AAC
         zCsT0W8/3LnqYL8tphnhgXkzZmY+iZ+flM0R/2phXVMiWfz7JSgmY6jBU8JyK6sgukXR
         EKRg==
X-Gm-Message-State: AOAM531TwSJqq7+0aTrhUHwaA1GhfVlVdqlJY7sRLkTauojXDDgxKXLZ
        eyDxky8KZK2InFBOy7Vmhptq8xaaprz8OSTQu4c=
X-Google-Smtp-Source: ABdhPJzcCMtanKilCIEyG7VrBpHIP94+2KCocpt/iqhi70MhBZR1zIyzjZPDWDdcSdm4Sb2spBmD4u9rYHsDdCY9dcQ=
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr14997817edd.231.1634885838461;
 Thu, 21 Oct 2021 23:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211022064543.28950-1-bagasdotme@gmail.com>
In-Reply-To: <20211022064543.28950-1-bagasdotme@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 22 Oct 2021 02:57:07 -0400
Message-ID: <CAPig+cRAi4ZR+_+Dh+DoUBkG=sgWTekxadob2YvThJQhr9tqfA@mail.gmail.com>
Subject: Re: [PATCH v4] archive: describe compression level option
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git List <git@vger.kernel.org>, vagabon.xyz@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 22, 2021 at 2:48 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> Describe the only extra option in `git archive`, that is the compression
> level option. Previously this option is only described for zip backend;
> add description also for tar backend.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
> @@ -93,12 +93,19 @@ BACKEND EXTRA OPTIONS
>  zip
>  ~~~
> +-<digit>::
> +       Regulate compression level using the specified <digit>. Higher
> +       values enables smaller size at the expense of slower time.

s/enables/enable/

A couple notes:

"slower time" is an unusual way to convey the concept; perhaps say it
takes "more time".

I think it was mentioned earlier in this thread that higher
compression level does not necessarily mean better compression, though
that is certainly the intent; it only means that the tool will "try
harder" to make the result smaller. Perhaps it's worth using more
exact phrasing (or perhaps it doesn't matter and that's getting too
much into the weeds).

> +       Supported values are from `-0` (store-only) to `-9` (best ratio).
> +       Default is `-6` if isn't specified.

s/if isn't/if it isn't/
...or...
s/if isn't/if not/

> +tar
> +~~~
> +-<number>::
> +       Specify compression level. The value will be passed to the
> +       compression command configured in `tar.<format>.command`. See
> +       manual page of the configured command for the list of supported
> +       levels and the default level if this option isn't specified.
