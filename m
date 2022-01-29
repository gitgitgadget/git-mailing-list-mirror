Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6789C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 05:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiA2FGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 00:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiA2FGl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 00:06:41 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3302C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 21:06:40 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w14so14241687edd.10
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 21:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUAQtl1CYOXV0SfOSKa0MXxaWDh9/rnxIWDDpZOhoA8=;
        b=KL+RUgoafNgHdVsMQbGiU0fICGjDOtWUnQ5wiNXSTqbgEQWh3PAtgulBQuU+RwlqkC
         hDI0qL5cNX6M4O86iPxMvgcrF5LV33Hab5PyxT2tIbB2xXSiCU4/NsTUSUt7Utoi0KI2
         /qaQU0rOeBgSgUaktrzwzV6MfnKYyc+RRT836KZd1Gs2VaqTDJoHPSfnzu81Xq0jtGOX
         XM4UhgOTWvSB25Urwl9JErAE+AiAIHL/PKj7gYsucuK+/1VGkqVp3ry4Fn70Uhol4ZYU
         h+07PUNdhdko+aK58Vyzb/ueNBgA7vDZM3o48m4YllwI3UjYQdjnlByBXYj780/xHSjm
         LosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUAQtl1CYOXV0SfOSKa0MXxaWDh9/rnxIWDDpZOhoA8=;
        b=A+9k9M3GSe/IF3TN9oThzzni1UWHDFg7CFAsAj4f04NhvVBD5JXPT/qVEgmUR1mbJ6
         GvJoDpwzALembKNfgkhWlpyCkBOOlCNoMyvRl2Cgaih+RKoIC6C4DpGqW3qc0MdH/mcv
         DuvmRET+DdfjbCih2H0tLqGo122iawYske+IDwnBKI43eiuMIaSF/Oue9UyNVgsFTSUG
         fsIESHVGYZgqmOhc9GwWf6gSsfrilQ2fJfNSKMdgZAlLnYiOuvcJnUWTZeRNfzv+2Xqx
         A5ibnNYpjb5crDU5Q8zYbMMC0l09ltf4QQvyzmSt9nCGSooQia9FLZerisc9SIHMDJGx
         g41Q==
X-Gm-Message-State: AOAM533FSi6a4PtBZJh6vacHTjdT/1RA5a2mndze0cCqQR5QTy5f5XO7
        Yzbg+EPxoA+k8GGyi30sM+mjW8gjni7twjICGeY=
X-Google-Smtp-Source: ABdhPJxbwy7ObS7aGudj81EKFplPMv/7CU+DxxLeJJ2zAtSr1rBwOHDKcMTkezNvHm8Pl7fcC3rJljgR5LeRrotHdps=
X-Received: by 2002:aa7:d949:: with SMTP id l9mr11468753eds.153.1643432799267;
 Fri, 28 Jan 2022 21:06:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
 <CAP8UFD0iQg4nL6eSTDbEu8t6h+K0H+nGF8y_N0z3XyjH+KGORA@mail.gmail.com>
In-Reply-To: <CAP8UFD0iQg4nL6eSTDbEu8t6h+K0H+nGF8y_N0z3XyjH+KGORA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Jan 2022 21:06:28 -0800
Message-ID: <CABPp-BFR+VgAWUf+eNVUkBO8uv9ipHk2vzS_=m9QHmzH3pE0AQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 3:07 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Jan 22, 2022 at 10:56 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> > +void merge_get_conflicted_files(struct merge_result *result,
> > +                               struct string_list *conflicted_files)
> > +{
> > +       struct hashmap_iter iter;
> > +       struct strmap_entry *e;
> > +       struct merge_options_internal *opti = result->priv;
> > +
> > +       strmap_for_each_entry(&opti->conflicted, &iter, e) {
> > +               const char *path = e->key;
> > +               struct conflict_info *ci = e->value;
> > +               int i;
> > +
> > +               VERIFY_CI(ci);
> > +
> > +               for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
> > +                       struct stage_info *si;
> > +
> > +                       if (!(ci->filemask & (1ul << i)))
> > +                               continue;
> > +
> > +                       si = xmalloc(sizeof(*si));
>
> It's probably a premature optimization, so feel free to ignore, but as
> MERGE_BASE and MERGE_SIDE2 are constants, and ci->filemask is constant
> inside the 'for' loop, we could compute before the 'for' loop how many
> 'struct stage_info' we will need and allocate them all at once before
> the 'for' loop.

That's an interesting idea, but if we allocate all at once, then we'd
need to be able to deallocate all at once.  I'm not sure how to do
that, but basically the straightforward
    string_list_free(conflicted_files, 1);
that callers can use with the current function would no longer be
valid, and it might be somewhat difficult for callers to figure out
how to free the memory that was allocated.
