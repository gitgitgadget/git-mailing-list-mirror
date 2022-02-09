Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE98C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 18:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiBISCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 13:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiBISCD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 13:02:03 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8028DC0613C9
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 10:02:06 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id x136so6548849ybe.11
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 10:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sEZ/0PhNFwRTJXzu7e3UQw6A77rq/ysi3TzMq5h0ES8=;
        b=PippvO4W46lEFs8C/2UjjSOeF4/KcVJ1Cdnr4YTAOSYBoN91/rw4DDHRg6v4UwQExd
         +huErSJwnsgJgEpcMy2oCEYh46NAqcKUIGQbMSH25xzO95EhhJexX1TGknN5dM46WaXl
         HcHiisy1jusBBsgSpn7olYEoM1hw4w818dEdHcbXQjWihI7ZQ875maepD4YMKE+/qSLo
         86oKGniIDRAbhkBPvg1TcoaC4cbNkW29OP0gGBcxqd3ObMcC4EFwLpiyh0M/ddEN4ARe
         9/Zk2VHVOXs4lGCLMiEucDVjtmsX1gsyIG3BJzvmtSeCE6hr1koF/zPkSXjh9TmvE03F
         FOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sEZ/0PhNFwRTJXzu7e3UQw6A77rq/ysi3TzMq5h0ES8=;
        b=WcoEeA94xmu42OafH2Gls91cRaSUItU6sAAIiE9qB5hC25NAbRlZprko2lNO7ZFudH
         e1qHAgrWQSjU50rIbqgmEoWIF7DMZvnN8VaLOwoRBUNBfYA4GNsu30JKb4zGS7jJpl0A
         roYMVt/Qzp0gHdvBfyGcv76iv8s5Aat1FKO7ypBhIFhraPE6lV/bqCm1GHdYa5/AKC04
         MrIAfE6rPEfHIH0O9+xyFogJJyM1n3r1ybXF5QVG1y6NH8kMMQQJpker+gOQ9v72rrz9
         zey1Kp8y9rty+rdJFm9N+bjLWExDdOq2o6t03WFYOdRQbOLzzF8Fd8H0KYo5CT+vBC5V
         6NhA==
X-Gm-Message-State: AOAM530cY7WSZ9ks95G9n4o5aIf14/4+ulq//OGEjfuc0ZiE2bKlGG3y
        d+R8j5EeH2m3+Wg009jjyDdzEQsp1Lv8Ts83uCg=
X-Google-Smtp-Source: ABdhPJwy1OVQLcH4WTeHHUr/pvAMv/p5tXbyfNrz8JVVM+cNPlrkFprf/WIqvGseZoXqiVpTxe7eJvSrH/kw3i+Q2fA=
X-Received: by 2002:a81:e604:: with SMTP id u4mr3270035ywl.198.1644429725648;
 Wed, 09 Feb 2022 10:02:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643364888.git.ps@pks.im> <cover.1643806143.git.ps@pks.im> <6fac914f0fe77df4c3058340642bea2a45a850cd.1643806143.git.ps@pks.im>
In-Reply-To: <6fac914f0fe77df4c3058340642bea2a45a850cd.1643806143.git.ps@pks.im>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 9 Feb 2022 19:01:54 +0100
Message-ID: <CAP8UFD2H-WfKRpwY7jNf=Dc0g1_Kc1adY4-c2OfkoMg3wHJCrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fetch-pack: use commit-graph when computing cutoff
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 7, 2022 at 7:03 AM Patrick Steinhardt <ps@pks.im> wrote:

> Benchmarks in a repository with about 2,1 million refs and an up-to-date
> commit-graph show a 20% speedup when mirror-fetching:
>
>     Benchmark 1: git fetch --atomic +refs/*:refs/* (v2.35.0)
>       Time (mean =C2=B1 =CF=83):     75.264 s =C2=B1  1.115 s    [User: 6=
8.199 s, System: 10.094 s]
>       Range (min =E2=80=A6 max):   74.145 s =E2=80=A6 76.862 s    5 runs
>
>     Benchmark 2: git fetch --atomic +refs/*:refs/* (HEAD)
>       Time (mean =C2=B1 =CF=83):     62.350 s =C2=B1  0.854 s    [User: 5=
5.412 s, System: 9.976 s]
>       Range (min =E2=80=A6 max):   61.224 s =E2=80=A6 63.216 s    5 runs
>
>     Summary
>       'git fetch --atomic +refs/*:refs/* (HEAD)' ran
>         1.21 =C2=B1 0.02 times faster than 'git fetch --atomic +refs/*:re=
fs/* (v2.35.0)'

The commit message and code make sense to me, but I wonder if there is
a reason why --atomic is used when fetching.
