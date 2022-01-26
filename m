Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B614BC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 11:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbiAZLHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 06:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240462AbiAZLHf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 06:07:35 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DBBC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 03:07:35 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id g81so70240121ybg.10
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 03:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTESW53tX4qDP3u7HwFMsYBwMp7/feOGnZCQhWRhhB8=;
        b=o+EC+JTN7APeyWutPVPNPLEOCHPwDs3+VwgqgNn9cvp+uJLeoY8U8BH43EDV7gQgbc
         VtvvLPojx6R/6fm2MvPdmmh/j8kvLnFJkOrlS3AoO3u8H1gxq4x7lVHOdXYP8L2j9FVD
         ufaAuxc7qOdBEbdh71P8fgejJT3zV+XKPnCnWB/eC23JFRQEs8DS3b5o21byg4Vd3x1v
         UX1DoKkxm5vL4X9cTkb4YcqzglzvnnFag2TPg7Oo0TnSN2BE1Zmxy6LkEKxRqQ8TPPQR
         WdAt2Ox/ydUc4LbYEyfunugL1y2w5VDVfXp5YSRC4EPfCSM817g7eSO9kDJUwN+HjT7w
         Wgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTESW53tX4qDP3u7HwFMsYBwMp7/feOGnZCQhWRhhB8=;
        b=AX0QwAokvSu1dbiXth3Qw6nWRzKFNZHhM04bCZUaqmb+7vxp7fpU1PHTJ4Ow84sj1x
         1zUbEbzcOrAcUhsf6qC6vOnYuMeVXBCtIddsxbpjf//itGhf/sjhiudW6JkHtSV7s8rG
         dcHsI3mtlL16c0FBH2sGFpZacvjlZbOToxPWf+ob2Tk6Ib664MXaTMXiPGMzXa12ypWx
         9/4wW5A0Jgyenvvw0qb9ByFzi8YwFXrXFFhuWJmfD8uPEx+PNrF3hP4D2PwEC/c/Ant6
         YCdb5uXOwTLc9L7OkAMtMNXoiDPIuArAkfoXvrE8bprIeVBfGxODKctFqvpPaO94B1rj
         Wy9w==
X-Gm-Message-State: AOAM532jmXpo6mDhaUBKob8HqheZcGJhmnCIe87zVAw0tmLnmQczzKP3
        O/bF/N93s6M6k9cT8inF6RWmq9ADdBju0sqv2ts=
X-Google-Smtp-Source: ABdhPJzdXFChgEK4UYZKL+KxXq6kow6GoBk7e5s6Y2X/gW4/di15als+kdBtKCD/vhk9fDPciwW4K9qlupmpnGhjABc=
X-Received: by 2002:a25:dac1:: with SMTP id n184mr34551584ybf.649.1643195254745;
 Wed, 26 Jan 2022 03:07:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 26 Jan 2022 12:07:23 +0100
Message-ID: <CAP8UFD0iQg4nL6eSTDbEu8t6h+K0H+nGF8y_N0z3XyjH+KGORA@mail.gmail.com>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 22, 2022 at 10:56 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> +void merge_get_conflicted_files(struct merge_result *result,
> +                               struct string_list *conflicted_files)
> +{
> +       struct hashmap_iter iter;
> +       struct strmap_entry *e;
> +       struct merge_options_internal *opti = result->priv;
> +
> +       strmap_for_each_entry(&opti->conflicted, &iter, e) {
> +               const char *path = e->key;
> +               struct conflict_info *ci = e->value;
> +               int i;
> +
> +               VERIFY_CI(ci);
> +
> +               for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
> +                       struct stage_info *si;
> +
> +                       if (!(ci->filemask & (1ul << i)))
> +                               continue;
> +
> +                       si = xmalloc(sizeof(*si));

It's probably a premature optimization, so feel free to ignore, but as
MERGE_BASE and MERGE_SIDE2 are constants, and ci->filemask is constant
inside the 'for' loop, we could compute before the 'for' loop how many
'struct stage_info' we will need and allocate them all at once before
the 'for' loop.

> +                       si->stage = i+1;
> +                       si->mode = ci->stages[i].mode;
> +                       oidcpy(&si->oid, &ci->stages[i].oid);
> +                       string_list_append(conflicted_files, path)->util = si;
> +               }
> +       }
> +       /* string_list_sort() uses a stable sort, so we're good */
> +       string_list_sort(conflicted_files);
> +}
