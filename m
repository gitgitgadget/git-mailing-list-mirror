Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AE8C433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 18:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E9B65114
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 18:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhBVSje (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 13:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhBVSjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 13:39:09 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9F4C06174A
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 10:38:29 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id l15so3185089vsq.4
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 10:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9rgtUbOtdlDuCYo/YqryLuhKl6ttSZFYNBBvKXs15p0=;
        b=rO3qnH1FsZzSHMoZM+GZoMdkJPTJkONIwsh275TnOb3VwTfl7uJkcl1UIn54ViGEYs
         PPKD+FAqolnKfqkDPIRp3VEEIKu7EwzzgrWclU/HvBHuD5IjbJchdLOL5uKvXt8XMJPE
         P3gX1jqwMr+yK/iBg/FyR2N6S8QL3PZ5ctUsHlFydkkkNOzQN3/t9qQEIZO5JIUysBxv
         Qo1n9DzCkLFHUgiRKEe82gP+b8NUxp6L0Ph16BVVw1FfcruPK+KW4+JQgQviyBoUAU/T
         N+sO7boPy4Fc/LKZNqkAsxcjigaXdZyK7YRKUiDCfUC3+C2yJdw6MAJTqJ6wSjlPNdBP
         8ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9rgtUbOtdlDuCYo/YqryLuhKl6ttSZFYNBBvKXs15p0=;
        b=DAoQ1YLERz4FtS7ZMNZIXnK/TB9giVca74DbZssFWwq+q6tnN9M8Wbe3rqI0261E4H
         niD9U9Yu/eDHVhesXCqITDkGuF451avAmJFqgfpP0q5QD+EabThewZtQITZ61T7UggcT
         Npa2H3jyRV7eyu2xuNFeKN4EamNhDyAa4JmZFFpu52gqoZoiLoaz5erKdzon4/bY/ktc
         yQ6YY8YhSRLUeF9toKG/FEbtMfOsXdrCMWRho8YO4jG5b/7PIrxZbJK1KI2BitKPDlRx
         AJbpfuwE8fFG3kWYDBVSjgesOpiW4J0h+0VKdJw/CAfaiyGfJwz4y/zARpTv88HFyrLn
         zuMg==
X-Gm-Message-State: AOAM531mwTqcM1YkaoysAmbnzQelIjPu8L76rk4zax43Cb9Y61CgdBcw
        VOE9QtPTZGV5YSQ/w0khkmQqDP6tW6gNHfbC+ZaxVg==
X-Google-Smtp-Source: ABdhPJz4mEYigysrXXdtyzeadXO4CVKLmCynGoFzmHn5lVFdL5SptOpnOaAMocUmHOJwFLmQr+28J+iQEjkCsESBRu8=
X-Received: by 2002:a67:b42:: with SMTP id 63mr14389068vsl.50.1614019108280;
 Mon, 22 Feb 2021 10:38:28 -0800 (PST)
MIME-Version: 1.0
References: <d57023d9f13d178dc95d7a74751923b80d1a5939.1607522429.git.gitgitgadget@gmail.com>
 <20210222004112.99268-1-stefanbeller@gmail.com>
In-Reply-To: <20210222004112.99268-1-stefanbeller@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 22 Feb 2021 19:38:17 +0100
Message-ID: <CAFQ2z_Ob1Ego0vZgW1g3h34LF9H5ZggrLJY4FQHPGaCwVPq8pQ@mail.gmail.com>
Subject: Re: [PATCH] refs: introduce API function to write invalid null ref
To:     Stefan Beller <stefanbeller@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 1:41 AM Stefan Beller <stefanbeller@gmail.com> wrot=
e:
>
> Different ref backends will have different ways to write out the invalid =
00..00
> ref when starting a new worktree. Encapsulate this into a function and ex=
pose
> the function in the refs API.
>
> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
> ---
>
> Hi Han-Wen,
>
> it's been a while since I looked at git source code, but today is the day=
!
> I was actually looking how the refs table work progresses and this patch
> caught my attention.  I think the changes in builtin/worktree.c (that
> if/else depending on the actual refs backend used)
> demonstrate that the refs API layer is leaking implementation details.
>
> What do you think about rolling this patch first, and then implementing
> the following part inside the reftable as a function?

The "invalid HEAD" hack is there to avoid confusing historical git
implementations. It's not a part of the "modern" refs API layer, so I
think we shouldn't add it as a method on the ref backend API.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
