Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB1CC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 01:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiADBsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 20:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiADBsU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 20:48:20 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656B4C061761
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 17:48:20 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id bm14so142329863edb.5
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 17:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUh4CagwhncSOG868D2GGLSn4gXaWwGtJtF8wGCx2v4=;
        b=gbSsAKGpV3DivBn0Q3Y0u5nP2SGMrrvP6DTJa6KfICnqcE9DULBcCs/TaKxli4VO76
         iGCPM3mIkg+UUttjYp4M9Egd7TmNxUH2x9sONhiQbLFE0UmfdGWiELM33rTuYGbvVhCI
         lgKPIVk2V+bsUriFvNCZqelobosAYbA2pNHz5CNFhL+4lrpH1JSUHx8/vWgzuH3K3Lg3
         Alws1Yv6sCDXrLL5FaU3nZxXyrGnkgGpdw29bfzExYz3XL9s4uqsjmK9NryzfQHVtUQg
         kAAYDLuRqES75Ed3UwT6J+zXSdpuaF5J6y+QDItIqLiLAe+XXPqBam4psaNnRec67cHX
         We+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUh4CagwhncSOG868D2GGLSn4gXaWwGtJtF8wGCx2v4=;
        b=RE//jay66mMFUI+FKd/X2cPDym2cpFWMUll2LZg3qVXBtjaOGH9rLsdWOSCfdKY5+z
         8rkLPAoaJ991vp9Q8mzH2tQyxyxFkbsrzDH6iSgbIApFUjiAGf0U7oIj7bzGY0mpBhCs
         rXSF9bUAl+ZMlIN1An2SRaQSNVHiaoij+aMuWOwoVXfSwYViOO1CUqSAw2y9mGG871lB
         brblOePg8GV8bEIhFMHvhNsZHRdf2ZHo8657ksf4tijTl2gUo8OWMLQn4dKDvSkYC5ht
         /A4/t+EXZ7mnh3yQNmxDNzTT/Iq3vq8k+xNJG8jjttniaAJbFXL0MwyU+2PAsN5zuYuH
         apCQ==
X-Gm-Message-State: AOAM532sNVFudR2WTbfOyeAp+zxGOJWSXjjW/yFeqX/M4aYytTseLDM1
        Wn9/QJX8T8/DACaKHcbjn09H3qOzCaq8NmzRIjE=
X-Google-Smtp-Source: ABdhPJztjbQQ4atNh0DeUDP6+tB3boF9TOJLvyE8xC9KPtsMZaQCL90sp7faFxnQQDJ2sNL/S03aNO0U/XNiCznkMmk=
X-Received: by 2002:a05:6402:2891:: with SMTP id eg17mr46911998edb.33.1641260899006;
 Mon, 03 Jan 2022 17:48:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1177.git.git.1640927702745.gitgitgadget@gmail.com> <xmqqtuenkk4k.fsf@gitster.g>
In-Reply-To: <xmqqtuenkk4k.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 3 Jan 2022 17:48:07 -0800
Message-ID: <CABPp-BF9XpxE2wLgAzZe0CR3NAAw0R9im4HBBm=BgirpNZOpAA@mail.gmail.com>
Subject: Re: [PATCH] t4126: this test does not pass SANITIZE_LEAK; quit
 claiming it does
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 1, 2022 at 5:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >     t4126: this test does not pass SANITIZE_LEAK; quit claiming it does
>
> Is this continuation of [*1*]?

Ah, yes it is.

> I think it will go away when dee839a2 (format-patch: mark
> rev_info with UNLEAK, 2021-12-16) is merged.

Can we fast track that patch?  The patch looks good to me.  In
general, though, I would think the simpler fix of just removing the
TEST_PASSES_SANITIZE_LEAK=true would be safer and could be fast
tracked.

I'm sorry I missed these potential problems cropping up when I
reviewed the earlier series (which added these flags to a bunch of
scripts).  I just didn't foresee these consequences.
