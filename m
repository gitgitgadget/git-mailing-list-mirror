Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABB5CD37B0
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 03:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbjIPDEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 23:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbjIPDEL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 23:04:11 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F9F1BDA
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 20:04:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5009d4a4897so4611347e87.0
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 20:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694833444; x=1695438244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpY2xQfF+oZ5DrZSxrF8pCrDnAfU4terpjMiBTETVkM=;
        b=Tu7t1UO3EleX8hfGnEolzm2m3iDqiIpXyF82e9OM+Z4mMlMmXaman8Kf2QvuQLeFxZ
         riftrDMZadZtPyLLPemkqJ1rYToXOJHpvgmrm5/ScfvVbJ/tQSYzQa9erODTt5V9UZ0p
         Ic3xFj4e0sRNLiTO+l6iLe1dIM6AkLoXlDTYsEvvEY5U5zwdxlDxHHPuk4MVVIrdkbfy
         +mPjXDTfqYocmci5klnI/CCLKQ9+TRtKdqEvaoOMi/hxwWaoU+4OEQclICdVZkQWQsNL
         GJOdlu0ctE6lo+ShLx1d8g/NSWyWzNBxJMAdi/5NIwiECXFcrNoHObrv5ptNCOhJeL0p
         /eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694833444; x=1695438244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpY2xQfF+oZ5DrZSxrF8pCrDnAfU4terpjMiBTETVkM=;
        b=iHTRH9A5d3lthdeYPXVC1V39FQZihTL5Qve+TwS1gSHGVGhJ+Vjs6s67HhMRmX95s1
         JEvcZPrL9MA22XhR0MfIAltDb1RAIXqpAp/O7kS2CDAgksyuu/EFVeynD7gJ1F52mqh6
         D36KJRQzUzGOcq5hFWBcev5acRp/YjfKzRfgt/u6YGYvOIP5CjXJuaqcKhlWDta3+sEe
         8X5DuGxmFKyXaxgpvcnlibfSW0bu8QOne5/qf0ewSulRFAr8Tss5Z3H8Xr1SaNMWgUii
         lDE3aun8kdV+XlbcNMW6Rzqxbr6LVSvNhz2WG7+gMtFFo11Wf4J0Q+rNIVCcpcmC6V5/
         a98g==
X-Gm-Message-State: AOJu0YwV3TTrCvldAwqzdvgE5GOIxkwQem/XccTshyUHmv5XJiUNhtBI
        i72/eErTIguxJyPcT/xKXocdPnK9KfHk4a7r96o=
X-Google-Smtp-Source: AGHT+IFxyAccyxfXSwEk3+qUUZ8NJNzXMi/Jlegr83ZL37BPty7l2+0Zzba3curMZzO67O7h2n838uWhyXcaX9uMHU4=
X-Received: by 2002:a05:6512:340d:b0:500:7c51:4684 with SMTP id
 i13-20020a056512340d00b005007c514684mr3409382lfr.56.1694833444187; Fri, 15
 Sep 2023 20:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230914093409.GA2254811@coredump.intra.peff.net> <20230914093958.GC2254894@coredump.intra.peff.net>
In-Reply-To: <20230914093958.GC2254894@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 15 Sep 2023 20:04:00 -0700
Message-ID: <CABPp-BFpCGCW1SiiTjje=_STEg68=DesA11pS5cEkCxa+C0Ttw@mail.gmail.com>
Subject: Re: [PATCH 3/4] merge-ort: drop unused parameters from detect_and_process_renames()
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2023 at 2:39=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> This function takes three trees representing the merge base and both
> sides of the merge, but never looks at any of them. This is due to
> f78cf97617 (merge-ort: call diffcore_rename() directly, 2021-02-14).
> Prior to that commit, we passed pairs of trees to diff_tree_oid(). But
> after that commit, we collect a custom diff_queue for each pair in the
> merge_options struct, and just run diffcore_rename() on the result. So
> the function does not need to know about the original trees at all
> anymore.

Thanks for including the history.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  merge-ort.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 31c663b297..20eefd9b5e 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3324,10 +3324,7 @@ static int collect_renames(struct merge_options *o=
pt,
>         return clean;
>  }
>
> -static int detect_and_process_renames(struct merge_options *opt,
> -                                     struct tree *merge_base,
> -                                     struct tree *side1,
> -                                     struct tree *side2)
> +static int detect_and_process_renames(struct merge_options *opt)
>  {
>         struct diff_queue_struct combined =3D { 0 };
>         struct rename_info *renames =3D &opt->priv->renames;
> @@ -4964,8 +4961,7 @@ static void merge_ort_nonrecursive_internal(struct =
merge_options *opt,
>         trace2_region_leave("merge", "collect_merge_info", opt->repo);
>
>         trace2_region_enter("merge", "renames", opt->repo);
> -       result->clean =3D detect_and_process_renames(opt, merge_base,
> -                                                  side1, side2);
> +       result->clean =3D detect_and_process_renames(opt);
>         trace2_region_leave("merge", "renames", opt->repo);
>         if (opt->priv->renames.redo_after_renames =3D=3D 2) {
>                 trace2_region_enter("merge", "reset_maps", opt->repo);
> --
> 2.42.0.628.g8a27295885

Looks good.
