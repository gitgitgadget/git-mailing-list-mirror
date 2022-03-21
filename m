Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FBBC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 21:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiCUVty (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 17:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiCUVtx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 17:49:53 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B3F3CD8D0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 14:46:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so580305pjb.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 14:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HaQ+Ww6S5zAAy2D6uspL9ibFUM+dMuPJXd2fHpZ8e9k=;
        b=J4atmg/OshROstPiNd0MohybSQCqvMEhzFqrCK/rfrE3HNSNfev9v87mQ53eOcbLCk
         L66ecwKc92PgliV6c5EZpe9oiK5lPpUAAbhfM7aLq9fkBEvtG7AE6cRUuayB6qEQGS/E
         /jii3uawufNW5gUn85AKXAFX4IQW2TtQMIYhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HaQ+Ww6S5zAAy2D6uspL9ibFUM+dMuPJXd2fHpZ8e9k=;
        b=aq96yPMLOa6lUPiPJY4HNoPWXzATR2B53vEHEGGDyICa88JhO3A3c6jgiR3bIAmY2t
         kch+80piKxV9tCHMK7IQClTcHoQUFvd+BGdpkamdnQg3IRfRqHsXada6uuizVO4YPTXK
         5kGWMgyX+pO0sNqVrfx84YdcKD3niy0xnBiSrV4ZmH0rNJ2gNh1R3zYOI4THCn1/3237
         i9pQFad1o4CTPoERrdbH0rnB368kGGmmC35+T+XSAwPaRD3KFVGKBTg/XyaEHWAw6/Qv
         QkMqSiT/ynX94bIs6YQegMx+KKUw/HwgHBfOB1+y39zrykX9CI7F7BevLsAXUmIlTkjt
         2K5A==
X-Gm-Message-State: AOAM531WW+JVc6jQ4xE2EvIU4lMlCLxKzTEgqR/Bf672mWdtG48K/g6D
        JuAnhh+86h53utJYSYVfV1JiKSAlhXjZx08In5/zHV25WRbF5g==
X-Google-Smtp-Source: ABdhPJyCzEXjkopCminIIWNETA+eQzruOd08hs2du2chmnkxaQNOixw3reJmcQ3XxuV3/zxRMgNq7n/czc/QYKP9O0I=
X-Received: by 2002:a17:902:d4cc:b0:154:3a3b:4172 with SMTP id
 o12-20020a170902d4cc00b001543a3b4172mr11463477plg.165.1647898485207; Mon, 21
 Mar 2022 14:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
 <20220309002729.3581315-1-calvinwan@google.com> <CACf-nVeEBDQse0coA7QpQmQ92y9kDwXoTmayD8_NY2OHNZ5v+g@mail.gmail.com>
 <xmqqzglylslh.fsf@gitster.g> <CACf-nVf-O5+_nMrdBiRJ5sHg7g+DjTkPy1VuErDnEXJ0-9OJ0A@mail.gmail.com>
 <CAFySSZAunjiEsSMETdYB3TFVppPD5RfjQjMmvTqwy6mEteninA@mail.gmail.com>
In-Reply-To: <CAFySSZAunjiEsSMETdYB3TFVppPD5RfjQjMmvTqwy6mEteninA@mail.gmail.com>
From:   Robert Coup <robert@coup.net.nz>
Date:   Mon, 21 Mar 2022 21:34:34 +0000
Message-ID: <CACf-nVf8=2wHSYXinU5M-wm9btyCg4hKjaaX2HxvsHb=YoqhdA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] fetch: add repair: full refetch without negotiation
To:     Calvin Wan <calvinwan@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On Mon, 21 Mar 2022 at 17:58, Calvin Wan <calvinwan@google.com> wrote:
> Documentation for the config setting is an acceptable solution!

Great :)

> Apologies for the late response -- wanted to wait and see if anyone
> else on the list had any last thoughts. Also I noticed you were hoping
> that Jonathan Tan could take a look at your patch on the What's
> Cooking thread. Before I sent my first review out, I discussed your
> patch with him so he's been briefed.
>
> Reviewed-by: Calvin Wan <calvinwan@google.com>

Thank you.

@Junio - I'm on leave for the remainder of this week, so expect the
re-roll sometime next week.

Rob :)
