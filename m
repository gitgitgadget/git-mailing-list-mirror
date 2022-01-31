Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB30EC433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 17:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381002AbiAaRd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 12:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380421AbiAaRd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 12:33:28 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AD6C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:33:28 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id jx6so45629859ejb.0
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4GEsTIKNHNUYYXFe32uaOTIdfB4NWMjaDFeZrqPhA4=;
        b=dGBRVqnzaVnXMAZb3mq7igXYp218jtKDL8aFcAtWeaiRBUwgYUDLkmXdcUGgL7M218
         1V5uIy77GJsAPRwULb+4bDidlxjKzRVscL4jGoY8nL1UYiKXadXVI3UAkxFAaEgwxw1n
         lCWMwhw9p5JjMg7yxl9l6tMUxev84hNfDiCZQ6JkrE/Lqtbb5ipL3XjTDM3elP8arZZ4
         DMfN+ipaDyhvAEojBPjAfZSwlR4G7C2218suKWMGSJChc++tsCmUqHuYhOiYWNuGifbc
         /TrxSNZZl016UNMKMZPdBUbbAlGXb5IRzFdeArE/QNm1Czhx5wLC/Kq9KYhVxURq2ENd
         bx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4GEsTIKNHNUYYXFe32uaOTIdfB4NWMjaDFeZrqPhA4=;
        b=xfNJnUcPq1yCVBN9UEwvxHSQCsla3OBReKcbDX2++v+BaVTv3bsq7bVa8udm4gj+vU
         srqLAOpAdegJbw9JyWH6BzKmk7tY9+qs0q9nexAh1g4KeispwYbCWRLrmc+UNc/TOkpj
         YwBhAxbGh1iLGwJD4Qwwuxbgeo1gajXfP2qweqTcAGedsSJuxceTWbJ/hV+glWBH0DUy
         uJNMlqtRPUI4atMseTHwkQY4VxkG2eBtGPWsNB7/EFjtyGZ/t921+whEZlYLRjKCutLY
         P+RzCE3Et+kdOgbEw29n1Omti3WRBDwc0ykhBsB8rg/7KR8q1lKXIAN0RmEubb8vB/U7
         3kGA==
X-Gm-Message-State: AOAM530SQK7Z/BsuRMu19A1z5HdBCS+oXfCMIpvrBemiD29i8gFXR63p
        NNIeeGEfGhgw0jIL49SkbCgWmoc0BkSLRHUWsm0=
X-Google-Smtp-Source: ABdhPJyKzmFrkcrW2O4Em3/w+PcEE6krlV6VRmHYl9YMxHm18soJCOmoI9EF3IIRz5314flYEpk/5HQRs3+6jFgIVCc=
X-Received: by 2002:a17:907:2ce4:: with SMTP id hz4mr17008791ejc.613.1643650406560;
 Mon, 31 Jan 2022 09:33:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.1131.git.1643334969216.gitgitgadget@gmail.com>
 <220128.86ee4scn2s.gmgdl@evledraar.gmail.com> <CABPp-BEehHHbDi_muWHCaT1GvRmPbPiMmvB-2O9+0w2A+yEM0Q@mail.gmail.com>
 <xmqqfsp3kfm0.fsf@gitster.g>
In-Reply-To: <xmqqfsp3kfm0.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 31 Jan 2022 09:33:14 -0800
Message-ID: <CABPp-BHcS3nwupJSORUuVeVhGzrL3VqPm4YQSr7G-JuyLaqBpQ@mail.gmail.com>
Subject: Re: [PATCH] repo-settings: fix checking for fetch.negotiationAlgorithm=default
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 31, 2022 at 8:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> I.e. =default should always be equivalent to not declaring that config
> >> at all anywhere, and not drift to being a reference to some name that
> >> happens to be "default", as in the GNOME case.
> >
> > No, we have the same problem as the Gnome case.  See this part of the
> > documentation for fetch.negotiationAlgorithm:
> >
> > """
> >     The default is "default" which instructs Git to use the
> >     default algorithm that never skips commits (unless the server has
> >     acknowledged it or one of its descendants).
> > """
>
> That looks more like one of the bugs introduced when skipping was
> turned on for the "experimental" folks.  To fix this, without
> turning skipping into the default too hastily, there needs two and
> half things to happen:
>
>  * Give a new name for the non-skipping algorithm, and describe the
>    algorithm like the above.
>
>  * Describe "default" is "non-skipping" but "feature.experimental"
>    makes "skipping" the default.
>
>  * Support "non-skipping" in the configuration parser, so that even
>    when something else becomes the default, people can choose it.
>
> I would think.

Sounds good to me.  I'm not very creative, so I think I'd just use
"non-skipping" as the new name.
