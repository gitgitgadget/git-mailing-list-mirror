Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5B6C433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 07:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhKTH5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 02:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhKTH52 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 02:57:28 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75631C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 23:54:25 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m27so53949740lfj.12
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 23:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIOdDye/8AA8pK10NCme9OVIU3IcBXrEjXWHJgOGTTY=;
        b=JJiG3FY6Bn17kTLFAVtq5ROUrzj5iYzX63sjdWjFaTNuG1T82Hkhhns2dJxDpQuz3A
         ngNq9zP9BzJE5+eJemmhABjeOryBabYaEXaK2RBKj5Tzy52s2iltsGGXLV0n1Nl7Y4wz
         wBcoRh+9MnP+XerkNll6fF1H54LpQRQ4zwig6Akxzo+wFYa8CXfax0NphRTARegUTDgL
         Ql1W912M0OieoArUkqyRHwgswZCDnazPsnGmBto2FVGHU5zj8SGrh5qBqMi3zC8xcafx
         tPGGIrn7+CkSmKmZMALunQ6+27pQww1nZ2A16GrUl/Oamz8nMXALv9+PcxOs9Mky39LD
         yX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIOdDye/8AA8pK10NCme9OVIU3IcBXrEjXWHJgOGTTY=;
        b=OvMtbvaxBvPYU05OLV//rw3s8T0GVZb8k8gG+mBmVYtYWgwK8D3EjadUZC+k0m4eqf
         vQ5gxkWTnV+1ZDBo1HBGIJIRO6IycS2dnPZmdgss5rOi2aRGR9uIxKtwZ6KWMpMff4lN
         fdLkEKCVB8lPLa5CCEgbBOKHyvOEqbYlxpBQNNRV3CPNI59V8IGM/75fDBCnkDqz1ywa
         ctMiOUc0mI4k9gtsLWaBk0aSlPDVhkw68/SXOtlFNR0cN8iE+exJwFMUrTDxm1qB4b3a
         2gija3kez+J6suBINCMXifWqiWsHNjtw2DPLiFghQiaoLI+cmI+IlQF9pbYJp/5miS0p
         00pA==
X-Gm-Message-State: AOAM531pe699WZuNhTCVVWlvURCxRyabZuPmc77rzM7+rExRO7okZTUh
        YGH4izgwu9+2DAKOoC7T5sgxBkvrmYjzGmj6T/4Ccusv4vg=
X-Google-Smtp-Source: ABdhPJwcDsXuBWEotIPSGvBdZ5Jjw+N8JPRgo518XYEVrouriJawmnBrlMESgeBtGEJEjCMVsBy3yH5wyWJR19MmiCA=
X-Received: by 2002:ac2:4e83:: with SMTP id o3mr39430975lfr.451.1637394863890;
 Fri, 19 Nov 2021 23:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20211118164940.8818-1-jack@suse.cz> <nycvar.QRO.7.76.6.2111191731400.63@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2111191731400.63@tvgsbejvaqbjf.bet>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Fri, 19 Nov 2021 23:54:12 -0800
Message-ID: <CAPx1GvfT36SvJ6Lwf1-2KUebVXkCkNvYTUw=FU+dHBy76VN5RQ@mail.gmail.com>
Subject: Re: Stochastic bisection support
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jan Kara <jack@suse.cz>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 8:51 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> An interesting problem, for sure!
>
> It is slightly related to a scenario that has been described to me
> recently: in a gigantic project whose full test suite is too large to run
> with every Pull Request, where tests are more likely to become flaky
> rather than simply break, a stochastic CI regime was introduced where a
> semi-random subset of the test suite is run with every CI build. That team
> also came up with the concept of attaching confidences as you describe.
>
> I only had time to look at the first patch closely so far. I hope to find
> more time next week to review further.

I only scanned for obvious items myself, but the idea of a
probabilistic test is indeed interesting.

I do wonder why you (Jan Kara, not Dscho :-) ) used fixed-point
arithmetic here though.

Chris
