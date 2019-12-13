Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F97C3437D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDEA24747
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2hWRYXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLMN1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:27:39 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40519 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfLMN1j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 08:27:39 -0500
Received: by mail-ed1-f66.google.com with SMTP id c93so2024577edf.7
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 05:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOCo4FDlJLM3hQ/plTb9VLXkDbHJQmEpC+7s2HQAu9s=;
        b=u2hWRYXBhbe300+iUfMb1sMzCOvL97lcu+ByZUPyqu4d+w5fmVImqK4BtPY48Fhezc
         8HRyuh8FxRChP4M5F7d+Q9pAk0Yv5wby4T2LHOEsaIeMEZds3k4jaH2HYvi+Qr/iZtu6
         A8TnvhDxXksqe9pieoBbJGSFZhDGWpsIV7W90jyFIg1SBZs3C+I5M50f/+AkRHL3dEdy
         881gnF0Vbsr6pGLDpBDt+H1MnBbflvrsdi1xbdDBp7T+qG8QRQrjWxOp4kYyCLqTkRB7
         SmhDMP7viOCy0AWzYnfUC/PeleH4WaLfsJE7ll7QCFvw4thyknKYcd+etO15Yhgcwiu4
         qjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOCo4FDlJLM3hQ/plTb9VLXkDbHJQmEpC+7s2HQAu9s=;
        b=HubrSqPkl1pXQGBxSVjVXsZ3QxBpe6AD2DtQeA2MdNVogJYbDuUmKkowtOpMJWZxVs
         kyAxmfudfFTRH/MzWIKu7zpvVRI/D7VzqbS5fXO0X/wJEemmYC6lsYPHJq5v8rWhzByL
         hXH+eHYq0AuEOZYsG7oT376ifYw85HS6v5TvHq4lM5rZk4a9+ckiGSFQaC77gLdXRD3k
         tXlaL+zidh4AhjSu5ZKgA9lmkkyaQKlleP/N0RopEsNxB1CQkNGHg6FU1yC94TmW8PvA
         2sY6j4rqc7MM0P9CnebbKaE3+x+UN/AzpX0L9ocT62iPI7RPEkLijJILZRZbQElswD1p
         AtOA==
X-Gm-Message-State: APjAAAW3HpuQIeNuoLygkQHHem6kjiu7NoZyNmaz1WUgErCWBoZlWyxL
        W8Jwx6lme+Yk9ARTevbZHEEQMaB4GSPsi6enMMD/kg==
X-Google-Smtp-Source: APXvYqw1NMahtxJ8ldcgURQTvtGkacWV9CHRvyfwNm6nVKDpgHKWOQDwBLL3n72QCXyLxmyA3fNQi/fshW+OnMNeiI4=
X-Received: by 2002:aa7:df8f:: with SMTP id b15mr15847789edy.214.1576243657539;
 Fri, 13 Dec 2019 05:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115141541.11149-8-chriscool@tuxfamily.org> <20191209071412.GG40570@coredump.intra.peff.net>
In-Reply-To: <20191209071412.GG40570@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 13 Dec 2019 14:27:26 +0100
Message-ID: <CAP8UFD3H_6E9FWprV_bHUwwQK96JD1jFtvMBecM5ajnbSjjxPQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] pack-objects: introduce pack.allowPackReuse
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 8:14 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Nov 15, 2019 at 03:15:39PM +0100, Christian Couder wrote:
>
> > From: Jeff King <peff@peff.net>
> >
> > Let's make it possible to configure if we want pack reuse or not.
>
> ...because? :)
>
> I mostly used it for debugging and performance testing. I don't think
> there should be any big downside to using it that would cause people to
> want to turn it off. But it _might_ cause larger packs, because we
> wouldn't consider the reused objects as bases for finding new deltas.

Ok, I changed the commit message to:

    Let's make it possible to configure if we want pack reuse or not.

    The main reason it might not be wanted is probably debugging and
    performance testing, though pack reuse _might_ cause larger packs,
    because we wouldn't consider the reused objects as bases for
    finding new deltas.

> I think the documentation could mention this. And maybe make it a bit
> more clear what "reuse" means.
>
> So maybe:
>
> diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
> index 58323a351f..0dac580581 100644
> --- a/Documentation/config/pack.txt
> +++ b/Documentation/config/pack.txt
> @@ -28,8 +28,11 @@ all existing objects. You can force recompression by passing the -F option
>  to linkgit:git-repack[1].
>
>  pack.allowPackReuse::
> -       When true, which is the default, Git will try to reuse parts
> -       of existing packfiles when preparing new packfiles.
> +       When true, and when reachability bitmaps are enabled,
> +       pack-objects will try to send parts of the bitmapped packfile
> +       verbatim. This can reduce memory and CPU usage to serve fetches,
> +       but might result in sending a slightly larger pack. Defaults to
> +       true.

Yeah, great! I use the above in my current version. Thanks!
