Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27DDC433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995E023AAC
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbhAVWfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbhAVTut (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 14:50:49 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4083C061786
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 11:50:08 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id h14so6256276otr.4
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 11:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VLEhTKh9QW7FjjdIwnnqef7tS1+6YyQd4kWZKSlKChg=;
        b=VPxZRcrWdsjuS6SgWdCOClzuuArDXKILNKhWxsqTCoHoC9L6kciif+UpaFr/j0bT04
         O4KLPuKcYfmzoo9cPgs8f3CTFdh5iAP2KDWIel9HaxMZjfqE2aAD1owIjxhHyuLCt++k
         nfCM9vW7eqT2t1g3sYZuaFmKXnIv+7EseiyB25dOOHJU7Y7tfCHkNbVyR7PFTmkFVxpy
         nISl3K6ei8Tb0VOLjvjPQLzHcC9Z/IEoldj6H0D3ciXKj4BnmbywSHzO1mv1f1Uc3+8o
         A4lJ5GA2utAQ55q2+FLs28vIqUgl5uhp6lyRtrPrUCWUEbGsSklKhA4tTlJDJs74T4lv
         T0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VLEhTKh9QW7FjjdIwnnqef7tS1+6YyQd4kWZKSlKChg=;
        b=I5PcTiAtQ+X6ssj61h9HYmV3cXTEeVOMvwGziyj3uZFqv5TSRbf2z7FCxH61IRRehl
         3zmgr4G2+s9nRRXhMxkbNT3ObCTR8LmA3Vw2S07W0ftSGct+X7MF0KA1n+1/Wte7o9iZ
         HYi2T5wBZhFXH+8Oj4FxeZLtCA2t7MdUUH//V88uEO5Qa8rN/UQGtllHs7KiVquH9Yi9
         2KIE7QEErU1mZJR3IOFddVNzRVxAYUMQr82IPXid5Zsb4WYR04AP22lDvh8Tg+V1z+jX
         Mvcxrku1Rk8SVA8SsZwf+oSHrthmVb/AOq3BcGhiNo8oQOEU/ci4hcSyRblFau+MGon1
         rt3w==
X-Gm-Message-State: AOAM533l/cnVocS2Ju16qXk3OQ4CX5i09C8+qhHli2c6m5pvzeXNe9UJ
        Dk4SMUatJIfcs5zfkh+RcAE4J5aMFaL5opckjaGMiUEmq7NhvA==
X-Google-Smtp-Source: ABdhPJxyjtqBKaP5iPHb7WpskYTVYMICEMMCe5kWI4d3T2HweAT50gx+13TIQTt/3bKghR72d7nOQtLTIuPDL0PgGHU=
X-Received: by 2002:a05:6830:402f:: with SMTP id i15mr4491099ots.345.1611345008347;
 Fri, 22 Jan 2021 11:50:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.839.git.1611161639.gitgitgadget@gmail.com> <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 22 Jan 2021 11:49:57 -0800
Message-ID: <CABPp-BHfVs3Yb-QqeTPcdaa_hSVbqyds6ZQ2kX_wMQmWwAEdvQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] More index cleanups
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 5:04 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is based on ds/cache-tree-basics.
>
> Here are a few more cleanups that are vaguely related to the index. I
> discovered these while preparing my sparse-index RFC that I intend to send
> early next week.
>
> The biggest patch is the final one, which creates a test script for
> comparing sparse-checkouts to full checkouts. There are some commands that
> do not behave similarly. This script will be the backbone of my testing
> strategy for the sparse-index by adding a new mode to compare
> sparse-checkouts with the two index types (full and sparse).
>
>
> UPDATES IN V2
> =============
>
>  * Fixed duplicated test in t1092.
>
>  * Changed the implementation of 'test_region' after I discovered the
>    negation doesn't work correctly. (I updated the test to use what was in
>    t0500-progress-display.sh at the last minute before v1, but that
>    implementation was wrong.) The use of it in t0500-progress-display.sh was
>    incorrect, as well.
>
>  * Updated commit messages to be more informative and have fewer typos.
>
>  * I dropped the patch that placed the sparse-checkout patterns in struct
>    index_state. I'll re-introduce that in time for the actual use of the
>    member.

You've addressed all my feedback from v1, but it looks like you missed
the pos + 1 changes highlighted by Chris in his review of patch 3.
Oversight?
