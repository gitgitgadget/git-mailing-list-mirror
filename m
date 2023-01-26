Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60215C27C76
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 01:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjAZByQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 20:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjAZByP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 20:54:15 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94245D10C
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 17:54:08 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b3so949181lfv.2
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 17:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzNBTo3anKtCb3v4Krah5FSkelDOX6ZiV07nJGVMs70=;
        b=LlnIeRs9L06rCUbi2nZY2qID8tL0uiHGSSuNxGn70paBnLgbezSUN3dspKX1eE2UOg
         42v13tJ2kk8kVIVQosGkJ2FsGgUQ7/DULU0Jvj5HPW+ZqLPoskitnJ2xuV+FRMD1crsR
         8vA8CY2l3vdcP+2qs5RxydFXripQSWIMkbGM4Oryyb4Z8ehLr4d62e5SGqjM3/LP6ujA
         JcAlCNA+PkjQ0xT4BQY8Go6xZWFW/3/E/FYqNXsCswRSEZMhvwiboDcr88sdwPC75XQ6
         KbiBshN4tCnLxZe3iCQMpEwhC0HU4/+oRu1quRCX7Tpn7UR4kAtEpLD8ylW1fkCJ12l7
         UbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzNBTo3anKtCb3v4Krah5FSkelDOX6ZiV07nJGVMs70=;
        b=pD9dv993risIXb4phhBDi/1ofjZoeFWzudA8Gny1zaUYb10Arh7lWA4ipGqfJ3wh+2
         LcndUcOce6t8Haz04b05yIrp1zodk5eocqF+G83faX5JDY3HSUoO1nAmaFTKSLbXizTL
         AG4UFIAt0y+/rTGPkCRaJbZB9QoE2hQ+EXh6mXZEnpLrzoES1zWmZH7Dz3/3wtUorPhJ
         2gt6KEA6SSBzYJBrSFKwazCuqYni2K9e1ZBQNzkvi1ZYkOKlYA/NCxkhajJQLkLk4qo+
         kv22+VnT2+MX2YU1SPTNM7gjxlWn1Sb4lcxaXL57QHZYfL52UNf1t7priu7PtKmDOaPV
         NdFA==
X-Gm-Message-State: AFqh2koxf06cFQxIdcH1HAFw81ZNvLDabP1zBorbVOs2r4jw24Etj7pw
        c4BYPIzwco8vnV2jf2UPwEF8VRH6ujUWvPNScEQ=
X-Google-Smtp-Source: AMrXdXt+RTWAmWCcaN1A1x0Zk7ZG26vVWEglyFw8yOItHU1I88lNhe7tODTsrDVHeVCFG3bz9NovgwRk5B6OoT5UUdc=
X-Received: by 2002:a05:6512:a82:b0:4d4:73e9:89a3 with SMTP id
 m2-20020a0565120a8200b004d473e989a3mr2237862lfu.183.1674698046876; Wed, 25
 Jan 2023 17:54:06 -0800 (PST)
MIME-Version: 1.0
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
 <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <patch-v5-14.19-15e4b8db805-20230118T120334Z-avarab@gmail.com>
In-Reply-To: <patch-v5-14.19-15e4b8db805-20230118T120334Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Jan 2023 17:54:00 -0800
Message-ID: <CABPp-BHtOirqYbHdmHi8H1nWaRdKx5pN7g-5x_jbgiUnKoh5BQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/19] builtin/merge.c: free "&buf" on "Your local
 changes..." error
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 5:14 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Plug a memory leak introduced in [1], since that change didn't follow
> the "goto done" pattern introduced in [2] we'd leak the "&buf" memory.
>
> 1. e4cdfe84a0d (merge: abort if index does not match HEAD for trivial
>    merges, 2022-07-23)
> 2. d5a35c114ab (Copy resolve_ref() return value for longer use,
>    2011-11-13)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/merge.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 91dd5435c59..2b13124c497 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1618,7 +1618,8 @@ int cmd_merge(int argc, const char **argv, const ch=
ar *prefix)
>                                 error(_("Your local changes to the follow=
ing files would be overwritten by merge:\n  %s"),
>                                       sb.buf);
>                                 strbuf_release(&sb);
> -                               return 2;
> +                               ret =3D 2;
> +                               goto done;
>                         }
>
>                         /* See if it is really trivial. */
> --
> 2.39.0.1225.g30a3d88132d

Thanks for fixing my bug!
