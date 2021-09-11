Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D9CC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A455A611B0
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhIKREe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 13:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhIKRE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 13:04:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6869BC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 10:03:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qq21so5124927ejb.10
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 10:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=MlaiNV5qA/D3bthUG0yAS0f0mknqOhBE1NrSdNknXME=;
        b=IEVDxeoJpdQAiNB8W54gIZfDgb9/CwlHsO5bBikXWD0W9UVRfc275IV1VXvlDTq2Ua
         W7fYW+hknT0VRoi3IcnJ0T2TmwMeYHDTZXtGyxdys54cebiwNlVYcVFI0W/dQdYA/6pG
         1IYvAcNXKYAyOpZCmZpxwvgRuUbn60bUt/95tZ7yfBst/9d/UEW9/NrwP0gxSsq3yQBd
         +AF0Br8WqMkBY67//IR+uxiHJV7qPx2TC8gMmLMKZCttnSRPQmLrE+Qx+f8VzcKX0vKB
         Xg3ZuEFuYP+NtUEWWslHPdYb0Kd8s5jaTFo+9nA3ouBxMLgLFQJeqsOjgNLHLhukzqJ/
         rXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=MlaiNV5qA/D3bthUG0yAS0f0mknqOhBE1NrSdNknXME=;
        b=a3PMrSkEY5sxWxzV7FCBSVu6e6KbxhtzReESAV+oHnpqoiNttsVHco2dTxeqCVi9wu
         9U1rtkVBFpE5YigjQ1dePfhZmDQn0+Q3GqkDDm7Vm9Fmom67/eq9KbpxwU2HQRhOB/9H
         zndhjshzsuA772dERmaQ/yecUJERL4py3YG+JG9kw9ElREn3FgpmK+X8O+Olk3nOLgNb
         AsqXyLNIFP3IQCJDt6kGXhgVJDeJmMA/taOnPqVA5+wL/sWivmmRpMNw7ShCWXuTjig7
         V6cNkC8o7auaBwLB/gU5pxf80mMj8iW9UPk8+OK4mj93lB1FD8t2HpQ+W0M2azvi/bBt
         2Cqw==
X-Gm-Message-State: AOAM530G4HadrRLsuCtwM3P6QXEN7dtZ9N19+sfsGQ8I6zxooIt42S6B
        RoNBe6UfKInHebV4byl2YJOAxnM3A2f36w==
X-Google-Smtp-Source: ABdhPJwxjmZdxO96UiOQBH698YVYkmWphiXErgVCSVapSxUVPmPOYexoULL3bVK7NKoMY7ZEWz9/tA==
X-Received: by 2002:a17:906:7097:: with SMTP id b23mr3704936ejk.270.1631379793491;
        Sat, 11 Sep 2021 10:03:13 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s26sm1183008edt.41.2021.09.11.10.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 10:03:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] strvec: use size_t to store nr and alloc
Date:   Sat, 11 Sep 2021 18:13:18 +0200
References: <YTzEvLHWcfuD20x4@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YTzEvLHWcfuD20x4@coredump.intra.peff.net>
Message-ID: <87o88z82pc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 11 2021, Jeff King wrote:

> We converted argv_array (which later became strvec) to use size_t in
> 819f0e76b1 (argv-array: use size_t for count and alloc, 2020-07-28) in
> order to avoid the possibility of integer overflow. But later, commit
> d70a9eb611 (strvec: rename struct fields, 2020-07-28) accidentally
> converted these back to ints!
>
> Those two commits were part of the same patch series. I'm pretty sure
> what happened is that they were originally written in the opposite order
> and then cleaned up and re-ordered during an interactive rebase. And
> when resolving the inevitable conflict, I mistakenly took the "rename"
> patch completely, accidentally dropping the type change.
>
> We can correct it now; better late than never.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This was posted previously in the midst of another thread, but I don't
> think was picked up. There was some positive reaction, but one "do we
> really need this?" to which I responded in detail:
>
>   https://lore.kernel.org/git/YTIBnT8Ue1HZXs82@coredump.intra.peff.net/
>
> I don't really think any of that needs to go into the commit message,
> but if that's a hold-up, I can try to summarize it (though I think
> referring to the commit which _already_ did this and was accidentally
> reverted would be sufficient).

Thanks, I have a WIP version of this outstanding starting with this
patch that I was planning to submit sometime, but I'm happy to have you
pursue it, especially with the ~100 outstanding patches I have in
master..seen.

It does feel somewhere between iffy and a landmine waiting to be stepped
on to only convert the member itself, and not any of the corresponding
"int" variables that track it to "size_t".

If you do the change I suggested in
https://lore.kernel.org/git/87v93i8svd.fsf@evledraar.gmail.com/ you'll
find that there's at least one first-order reference to this that now
uses "int" that if converted to "size_t" will result in a wrap-around
error, we're lucky that one has a test failure.

I can tell you what that bug is, but maybe it's better if you find it
yourself :) I.e. I found *that* one, but I'm not sure I found them
all. I just s/int nr/size_t *nr/ and eyeballed the wall off compiler
errors & the code context (note: pointer, obviously broken, but makes
the compiler yell).

That particular bug will be caught by the compiler as it involves a >= 0
comparison against unsigned, but we may not not have that everywhere...
