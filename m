Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38001E95A8F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 01:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344728AbjJIBZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 21:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjJIBZm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 21:25:42 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50DD99
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 18:25:40 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d8168d08bebso4171424276.0
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 18:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696814740; x=1697419540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73z/ILpDLOhP5NAxox7DgknuoEFjkUbWkVsGs+EUrKE=;
        b=XxeYZeC0f63fc64SZfHMfNM2qY+DxmKszLsVNGkZ42Zgdh4SCWyHpPNEoawpF0gGac
         mj4czh3k4OU5RLGmEvHEt2UNxRvdAeIgJm2sdOQ6iIn+7Uvr/Hz8k0+tIEvWY8xX1Fgo
         y+ZzGLqHGnYJbb7270gj2yRRnp9OCK9wAdXNxMIdhnHqo9iu8gwtHRRImr66rn1K86GF
         Y2GlSjmcyCw3Yul2/F/j8T2LeXmnYkN28LLREyTFDFtcr4xLBil9vyXd1JpAgMVZXxkJ
         2a10KKJ6+8JkyDxjHn/tukZSLEIVgnJo6fbGVVYLRg4x/pdFyN+nifT7Sejqn+nw11Uy
         tgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696814740; x=1697419540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73z/ILpDLOhP5NAxox7DgknuoEFjkUbWkVsGs+EUrKE=;
        b=fSozCa+mi//88pqQJsVd7IQcCER8pMP3KSrF+CddvRotzDss7/AkxmX9KL3dICe8Hd
         JVfySl6xhpd1zmxqRWl4w1vUmnvJ942vzDCXkbpTIHsEJGmDlljAA+hmiXHPLLPdPFxI
         N5Vcs+TNjZgo4Mikfb7SDcHZnKJhVWK9qvLzopwYPcR88ou7QvBpET4goQJaHjCCOCJJ
         4oK2Tkg215fN88T5c4nqGL13NVNgfk8XoA53xWjpA4qyVxD4eNtkW/YZEQderdNGXhtF
         K7AEIiGpqvEE3jIGGAgWjZ42bbZ6GXqvQ1x966aAf56iPBCd1Sn/shwgUW0yIlFV/usX
         7Rbw==
X-Gm-Message-State: AOJu0Yy1y+hP/IYixOnd23pehonCAJU/W4p70k3MCcw4TfBrULfqr2bE
        nczfo+fOGH2Yy5vuRinIjRTnQjgLsUKjbevGkM2BcvxepaWoQY0=
X-Google-Smtp-Source: AGHT+IHonDzXXh9vFwxAkQ9jWXAVhtFAbZxJwJULq/QNpqz1v348yyN4EbwYg+6bviODHUcnym5eQaO6qahFIWlDP0M=
X-Received: by 2002:a25:a407:0:b0:d7b:985b:278f with SMTP id
 f7-20020a25a407000000b00d7b985b278fmr12429880ybi.16.1696814739826; Sun, 08
 Oct 2023 18:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <CACS=G2xBNMMTSCSsVFe3M3jFN0m0pZ-j_TAz3r6xmQrgdRujfQ@mail.gmail.com>
 <e22b6211-8534-417f-a647-e36cb00eee61@app.fastmail.com> <CACS=G2wnQEVqiUA8Jy=iaaAnRv7bMKmegR2rGR=Tbhf7UuLR4w@mail.gmail.com>
In-Reply-To: <CACS=G2wnQEVqiUA8Jy=iaaAnRv7bMKmegR2rGR=Tbhf7UuLR4w@mail.gmail.com>
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
Date:   Mon, 9 Oct 2023 02:25:27 +0100
Message-ID: <CACS=G2xdeYkqckmh70RXZQht8c3ohfrO0eiRPzN4_5kpC8memg@mail.gmail.com>
Subject: Re: [OUTREACHY] git send-email issues
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I finally got the hang of it!! Apparently I was supposed to set
encryption to "ssl" and serverport to 465, but for the past two days
I'd been using "tls" for encryption and serverport as 587, once I
exchanged them, all was done.
I wasn't able to get the hang of gitgitgadget tonight but I'd
definitely be looking into it in the coming days.

On Sun, Oct 8, 2023 at 11:37=E2=80=AFPM Naomi Ibe <naomi.ibeh69@gmail.com> =
wrote:
>
> Oh wow
> I read about gitgadget but didn't understand how it works, I'd
> definitely check it out with these links you sent and I really hope it
> works. Thank you very very much
>
> On Sun, Oct 8, 2023 at 11:17=E2=80=AFPM Kristoffer Haugsbakk
> <code@khaugsbakk.name> wrote:
> >
> > Hi Naomi
> >
> > On Sun, Oct 8, 2023, at 23:59, Naomi Ibe wrote:
> > > I've used the --smtp-debug tag, checked the official docs and other
> > > docs too, plus stackoverflow,google and even chatgpt, but nothing
> > > seems to be working. I've even had to change my gmail password tonigh=
t
> > > but it still doesn't work. Any tips at all would be greatly
> > > appreciated at this point. Thank you
> >
> > Here [1] is a good resource for setting up Gmail for git-send-email. It=
's
> > a bit of a chore to set up but that resource was enough for me to get i=
t
> > working. One of the things that you are going to need is an App passwor=
d.
> >
> > But have you considered using GitGitGadget instead?[2] You can make a p=
ull
> > request on that repository and then the program (gitgitgadget) can send
> > the emails to this mailing list for you.
> >
> > [1] https://stackoverflow.com/a/68238913/1725151
> >
> > [2] https://github.com/gitgitgadget/gitgitgadget/
> >
> > --
> > Kristoffer
