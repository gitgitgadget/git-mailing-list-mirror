Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72875C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 03:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiBODSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 22:18:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiBODSk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 22:18:40 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2B0201BB
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 19:18:31 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p14so17116435ejf.11
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 19:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=52jiA3Gh4zAPr+8NbS1d8Y/k6xxPhpyPSbbjw0zHiK0=;
        b=CfyFJ9xptZEPjhEV5jX8PjPlpgVS7NKXaBToa9jWlwceheW5ngoV7t4JDZihdDc39g
         QbHzAWabFi4FTg3LcexjXfIgfoHB2/ZLRK/pMcgG1/HrSS+E7CnzpqQrTjs2VVbhndjZ
         gAl49TmayxFsbYsuZvUiYG6Cb0kE6UJJrMUEnBpChEL/f3jgOGwQ5vp2vopg5/466Gyc
         EiC480x8nXq2b56bwzS5T5wpaznPcAIzjpYCW0XU0vOY1C3+/bcWNt1hVfTzIcoe5X8m
         697O/nKA5s+oveelx+ML0f70NPs2TD0ALf60M6xshvYE1H3oYOjjwZiCBiJs/pivtVjA
         Jw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52jiA3Gh4zAPr+8NbS1d8Y/k6xxPhpyPSbbjw0zHiK0=;
        b=sUrFRDr1As8fK2wWzhhCHfbjfFqUYeb9q5Pq0ibmOEaPBTJ57c8AFXPhUV0zoyoasy
         GofmVBCaNS5g38Hwn9qOOd732x6RGV3VAYXaeiMrkpNG2wsiGiqRueXBNgk/rM88goUS
         BY3AGR9F5INYY2TryJCYUATacToGY8Ps4g6InYL6G/6Tux4v6nw2eKSwTgGtKCa6nVjt
         hNUTEZCiIaXx+Nxk29nsswAYTQ580xfVgChplFgChghxuF1y8Ughcj3NXCZN9bSaim4t
         +oaP4/+pdItE4iS+OStoX6dUesAdlakbYaudUF2DdDXyvQqGrwB0+bPdbzQ2W1cVy/zb
         MbHA==
X-Gm-Message-State: AOAM532jRLErdfHgEULgvhdBDHQtvKsOCjNRtlSOHHsNUz5zg34nUE+W
        fWnhgudDVlh73AaULQ/ZCxkeGbkTk3Yvr7ugF/E=
X-Google-Smtp-Source: ABdhPJxM5bSUSN+1LiGf+7uRB8U27B8Nrm6P2AvMiocDBW/BE4ARVdH9E4OONvmZtBCJU47nKM9ryeUZlfePzYAcyLc=
X-Received: by 2002:a17:907:94d5:: with SMTP id dn21mr1273984ejc.476.1644895110040;
 Mon, 14 Feb 2022 19:18:30 -0800 (PST)
MIME-Version: 1.0
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <3bab59604046facb1e31ff1496e5bdb1afc7bf22.1644712798.git.gitgitgadget@gmail.com>
 <40a88efa-a07f-417b-a5c5-0a6e651cfa8c@github.com>
In-Reply-To: <40a88efa-a07f-417b-a5c5-0a6e651cfa8c@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Feb 2022 19:18:18 -0800
Message-ID: <CABPp-BHJ52Eqm3Zwf2Hy2pgbf1mvVEPPdmqGDvzoQbS9SeTsMA@mail.gmail.com>
Subject: Re: [PATCH 2/7] sparse-checkout: correctly set non-cone mode when expected
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 14, 2022 at 7:44 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 2/12/2022 7:39 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > commit f2e3a218e8 ("sparse-checkout: enable `set` to initialize
> > sparse-checkout mode", 2021-12-14) made the `set` command able to
> > intialize sparse-checkout mode, but it also had to function when
>
> s/intialize/initialize/

Thanks.

> > sparse-checkout mode was already setup and the user just wanted to
> > change the sparsity paths.  So, if the user passed --cone or --no-cone,
> > then we should override the current setting, but if they didn't pass
> > either, we should use whatever the current cone mode setting is.
> >
> > Unfortunately, there was a small error in the logic in that it would not
> > set the in-memory cone mode value (core_sparse_checkout_one) when
> > --no-cone was specified, but since it did set the config setting on
> > disk, any subsequent git invocation would correctly get non-cone mode.
> > As such, the error did not previously matter.  However, a sbusequent
>
> s/sbusequent/subsequent/

Likewise.

> > commit will add some logic that depends on core_sparse_checkout_cone
> > being set to the correct mode, so make sure it is set consistently with
> > the config values we will be writing to disk.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  builtin/sparse-checkout.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> > index 510cb89b544..8d595189ea3 100644
> > --- a/builtin/sparse-checkout.c
> > +++ b/builtin/sparse-checkout.c
> > @@ -399,6 +399,8 @@ static int update_modes(int *cone_mode, int *sparse_index)
> >               core_sparse_checkout_cone = 1;
> >       } else {
> >               mode = MODE_ALL_PATTERNS;
> > +             if (record_mode)
> > +                     core_sparse_checkout_cone = 0;
>
> Is there a special reason why this is guarded by "if (record_mode)"?

It turns out it's not needed.

I was worried about changing core_sparse_checkout_cone when we got to
this function without either --cone or --no-cone mode being specified,
but re-checking the code, in such a case *cone_mode would have been
set to core_sparse_checkout_cone a few lines above, so setting
core_sparse_checkout_cone unconditionally here is safe.  I will remove
the check.
