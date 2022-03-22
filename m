Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782E1C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 20:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiCVUPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 16:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiCVUPA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 16:15:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6101BCAB
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 13:13:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so4012621wmb.4
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTA5So5OVrlshTK1yVgNmLv4psZbkcRq8YtK30Ycd34=;
        b=KxR6ccUzh3orykrygl/aNoozMUBW4H2QyZ5gsKe/t6EzmIemTTG/fLjBty5mTaSoP2
         AaIj7GiKDBG3yVg9p9R4ot6oU4Vjd1Kd2P/R54ErTmSQIyC2chLY0K4BfLyqnjpCiz/z
         Cl+jNVGYvuvfwK974AWy6fv1sKULR4NJPHWrlDUjH0dwg16lTAWDFqxlZwMC6BZNrudV
         DVLD6DBVon3ZqnQqQrEJ9XkOPT4V33EDA+hchiK3SQY3Cy5UA9xC56G2sETuWqapmjx/
         h6FZjqfJswZnVl+R9mYjbeekqFE+G32vUVujnIaFNvq+Ls8dJiJBAONAnDwjI8yVBT+2
         XtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTA5So5OVrlshTK1yVgNmLv4psZbkcRq8YtK30Ycd34=;
        b=7SXkpAxUfG0bKJi+oD7OE1hL2hBX4VTuEFmbR6YHzCyG3fWETor388Rb2aP3VHTrmB
         X8FEsx6UcE6PogBStEr19BDfOtSLDrgzTHJhmij1J7XMMLw52MDmfQDCMZNK0YUY3d+l
         +mlC5k3fQQ6FmTUbPhBkxJhIMw0vvy6vsvjbzc1nRNTLqfjPe9gOnEP+fQfnwehE1ueb
         OvmGTk/+tg4yT3cma+6dHh4fpm3DwxrFOzDyxenDcXXbGRu6fIg68g7kxJwobDF8m1sH
         BXZS7RfPr5R5QfMc8t+UI4YzdiIOo2OwRI/3ZdZbAaqRRQhkHIgrzVwTLOD96ExsMyeM
         0O1g==
X-Gm-Message-State: AOAM533xp+iHkY8L57ZKiD6eYbSNoKXV5UT3Aqt4Xst42SppzbP2DxWK
        sKWWhbMq3tarq6IkKb9eGk1/E2+e6Lkcj8YyoIRm817C
X-Google-Smtp-Source: ABdhPJxM80/0olKuT65/zRLqT7Zw+MYIKyvOCCRaQ5dirFpNRH9NT0+8fBY45Ks788/Ho749XrrKu0owAsqciGex4A0=
X-Received: by 2002:a05:600c:3482:b0:38c:40:9b30 with SMTP id
 a2-20020a05600c348200b0038c00409b30mr5641872wmq.68.1647980007079; Tue, 22 Mar
 2022 13:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAK1xKQpUFCkv6fopEykKLxAEoG_Hf_Zz+oRR70mR3pWsN5YDDw@mail.gmail.com>
 <ac3a5871-b009-f84e-d1fe-af4bde1bbabe@gmail.com> <CAK1xKQr1_52n5rAhQh2awsb6SkgUYOMWoLichtBRLvtDXRQarQ@mail.gmail.com>
 <fc38a32f-91e2-fe49-a7b0-e2e6851271c4@gmail.com> <CAK1xKQppM3oseB=vdXbDbPjDeFxd9kd0jULcaC=ASkMsKiDCmQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2008101645410.50@tvgsbejvaqbjf.bet> <CAK1xKQpTUqLLZkYuFEOx7zy8wOib_ohwmiqt89qoj-rK8tnZ4A@mail.gmail.com>
In-Reply-To: <CAK1xKQpTUqLLZkYuFEOx7zy8wOib_ohwmiqt89qoj-rK8tnZ4A@mail.gmail.com>
From:   Joel Marshall <joelmdev@gmail.com>
Date:   Tue, 22 Mar 2022 16:13:10 -0400
Message-ID: <CAK1xKQqGTmgGBH4TY2mpHZLit_49FDoEq2EewDE-v_fc2=ikYA@mail.gmail.com>
Subject: Re: Possible issue with rebase's --rebase-merges option
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have confirmed that this is still an issue under certain
circumstances. --rebase-merges works as expected if it is being used
with simple feature branches, ie one commit after the other, no
merges. Where things go off of the rails is when there are branches
and merges coming off of and going into a feature branch. At that
point using the --rebase-merges flag with rebase will create a similar
mess to the images of the logs I attached back in July of 2022.

On Wed, Dec 8, 2021 at 3:46 PM Joel Marshall <joelmdev@gmail.com> wrote:
>
> Hi all,
>
> Sorry to drop off on this for so long. I think this is still a
> possible outstanding issue, yes? If so I will work on getting you a
> copy of the repo as I did archive a copy at the state originally
> mentioned in this issue.
>
> On Mon, Aug 10, 2020 at 10:46 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Joel,
> >
> > On Thu, 23 Jul 2020, Joel Marshall wrote:
> >
> > > I saved the state of the repo in a copy so I could come back to it if
> > > additional examples were needed but I had to clean up my live copy so
> > > I could get back to work. I'll get you some additional screenshots in
> > > the next few days. In the meantime, I'll try to give you some context
> > > around what I'm doing here. The parent branch is my main dev branch
> > > which consists of a series of clean branches and merges- the dev
> > > branch basically looks like what you're seeing in the
> > > --preserve-merges screenshot. I've also got a long running feature
> > > branch that branches off of dev, and it also consists of many branches
> > > and merges, each a subtask of the story related to the feature branch
> > > as a whole. Occasionally to get the feature branch up to date with the
> > > newest features I'll rebase the whole thing on top of dev, which
> > > should result in an unbroken chain of branches and merges as seen in
> > > the --preserve-merges screenshot. While you can't see it in the
> > > --rebase-merges screenshot, those merges show no ancestors when viewed
> > > in reverse chronological order- they just trail off into oblivion.
> >
> > I could imagine that you might want to try this rebase with
> > `--rebase-merges=rebase-cousins`.
> >
> > Otherwise, you might want to export your use case with `git fast-export
> > --anonymize` so that others (such as myself) have a chance of helping you.
> >
> > Ciao,
> > Johannes
