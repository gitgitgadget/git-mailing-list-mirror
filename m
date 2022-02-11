Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991E1C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 19:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbiBKTFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 14:05:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiBKTFb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 14:05:31 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC42DCC8
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 11:05:29 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id o17so13823615ljp.1
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 11:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZtSyiP7Xrmz/rXhx9k/C+/9rXr2HJDP4gXG7uSpZ+k=;
        b=CxQSfSb8tRke8gz15fx+IRlxp0BzoqWfVdsQDbZ/q6xsXbxVhr2QWB9dQPkT9+6Y7S
         KKl27aiYxJZjmam7dssNu1Iuv9LgEtpFE5Y1iI79a9Gk9f7eR15ICxYn5s4dNcINm+xf
         8GwWPd5tgB0vSMYXT9in3IEUp1aDhbLCq9z5tiezGU2syAbwv6IJBIX7gcqzocHcKVgP
         K8rOZql1cKqMzmOElUUTsK93trJF7cJgksCONnpoEyqRjgTjIrhg20x6yzAJdMXgQzMB
         g+/TOMDbQC6iP3Mv2jXE+892THRab0gy9b6KtHnmDRrdnmHcG3ohadSsnr5jxMKhir1c
         qamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZtSyiP7Xrmz/rXhx9k/C+/9rXr2HJDP4gXG7uSpZ+k=;
        b=RzMsvAY+koChFakZCcE8XDJsNiPQne5lFj4zyN2XiFXgAONAhLiEyRrXM4kFoH3j5S
         Xp+e7jrSxPs0YL19Z3qZnBePCq+RZGDtI5TU3S4M/WZrE4lhEtyQq2RxhjJbmfvonShu
         4Lqss9RImYb/mDLb81LodIyGBbloiAXH4FqwD//ObXnr3nrCUCfcbdXZR0KgNIBz1Lmq
         ya8uQmD02zLpMOLHod/yHLra3m8JJEIOx1pPHs9RDVxw7r9FIGQfPWxCgq9wC6J+ggfF
         iyDR59FMJ+aHnTzQOH1FWwBYG7ttS6vFR9aJV5mRclDF17Rf976JVHR84E4J+y0nxq+o
         gtTg==
X-Gm-Message-State: AOAM532rp8GjqFB0Oos6/bzV5i7A05cwIagCyUlDlwQ0cJe/CH7yOuxU
        i1NJ2/kZ5Gg9JbEyJMryaoBj5W6klZTI7tFgPNI=
X-Google-Smtp-Source: ABdhPJxo/psua9UnrgHGh0yOeKFDbJbKYlHMyCOLdQ8K2BB4bSA6PNXea7SHlF5Yxfum2MFZotLpvEGC9t9MPzFSbao=
X-Received: by 2002:a05:651c:2122:: with SMTP id a34mr1789868ljq.50.1644606328067;
 Fri, 11 Feb 2022 11:05:28 -0800 (PST)
MIME-Version: 1.0
References: <20220211163627.598166-1-alexhenrie24@gmail.com>
 <20220211163627.598166-4-alexhenrie24@gmail.com> <xmqq1r09clxl.fsf@gitster.g>
In-Reply-To: <xmqq1r09clxl.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 11 Feb 2022 12:05:17 -0700
Message-ID: <CAMMLpeTBstt8qo2q6r=YCEi-h-G-EkjY=d7kHKeepzTvz1gmJg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] gitk: pass --no-graph to `git log`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, paulus@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 11, 2022 at 11:12 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> >  gitk-git/gitk | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
>
> Please base a patch on gitk part to base on Paul's tree, not mine,
> meaning that the first few lines of diff should begin like so:
>
>         diff --git a/gitk b/gitk
>         index ...
>         --- a/gitk
>         +++ b/gitk
>
> and not as part of the series.

Okay. I'll hang onto this patch until the previous one in the series
is accepted.

> What the first two patches want to do is a good thing regardless, so
> I'll take a deeper look at them and queue them.  I am very skeptical
> to log.graph=yes/no configuration for obvious reasons that setting
> such a variable *will* break existing tools and users.  It is not
> even "it might break but we don't know until we try", as this patch
> loudly demonstrates.

What if we make log.graph=true also require feature.experimental=true?
The log.graph option would really be a useful feature for people who
use Git exclusively from the CLI without any external tools. It seems
that the main challenge is how to give others time to adjust.

Thanks for all the feedback,

-Alex
