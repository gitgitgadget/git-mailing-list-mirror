Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F693C41513
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 17:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjGaRwL convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 31 Jul 2023 13:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjGaRwK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 13:52:10 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7247ADC
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 10:52:09 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1bbaa549c82so3639936fac.0
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 10:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690825928; x=1691430728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmiGoIk0MBng2Ov12VqsXJbn3LGyPVR+fCihaRsRK9k=;
        b=BxFpq6q9/r1+i/a9TCemqnqRcLHHrqyuatAeUnjH75gcP8AwYnsXvZNh3QXA9uLpP6
         EHTy6FCEONkoUKCQLZ9l/VNLRgd6UGMqK+NJw1IGDxkezgtdEn/CuG1Jm1auts+8Nr2k
         qh45kNrcjlfksEmz7SC1p5f6BLNWvpD/xeIRNFV8HUyv8n3o9bZepCU9LyJEO5lc51fh
         Xkrn2cb7oqWrzJaS38rgt2OTmIPFBYx9tK4uMF+UdvtFwYrjjVfhBJ7YwDfstMBx5i+X
         qn74PziTclc/RvCXVKb3BTw44XwRidUIPSbkpq/FaKkp7w6aY9L0KEfELKgQ5SIujiUv
         NTaQ==
X-Gm-Message-State: ABy/qLbseNtbbblQ0fFMSJuo7T6EXFXYUhE4LQe62+Dya0foggXYWKOd
        EunVS8xRWzNumY41NyhkPpUqJF/z050nAlXwfT0=
X-Google-Smtp-Source: APBJJlGT8gF0qBfThJYn937m2cvm/sua+1KWu2c51Pt1ANfAUhNKDBiu3q2pC7p6cN6MBDxiZC7esuNvNph7iW8MMZM=
X-Received: by 2002:a05:6870:d1c6:b0:1be:ccce:7993 with SMTP id
 b6-20020a056870d1c600b001beccce7993mr5427730oac.40.1690825927189; Mon, 31 Jul
 2023 10:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD1M3sRPEJ42v2=pQ_CQYY+PN64Swx70O7D_=VfbhSwKLg@mail.gmail.com>
 <a5c359d6-6c21-489c-a4a3-a21219ab727a@app.fastmail.com> <CAP8UFD0VJJ1b29W6VOmy+XR4Bi+gJeL1k7cb0a=cHkyp7O4Nsg@mail.gmail.com>
In-Reply-To: <CAP8UFD0VJJ1b29W6VOmy+XR4Bi+gJeL1k7cb0a=cHkyp7O4Nsg@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Mon, 31 Jul 2023 10:51:55 -0700
Message-ID: <CAPc5daXep8yDGERqEZFPxvh_rQipLk47YPwMV0BV+8SBBwU=Ug@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 101
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bruno Brito <bruno@git-tower.com>,
        Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Canpolat <eren.canpolat@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Linus Arver <linusa@google.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The particular article may offer little new things, but I suspect
other articles in the same list are also rehashes of what has already
been covered elsewhere, so it does not look particularly bad from that
point of view. I have nothing against its inclusion or removal from
the list, but I hope the author of the article does not take offence
(this is the risk of working on drafts in the public).

On Mon, Jul 31, 2023 at 10:14 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Jul 31, 2023 at 12:11 PM Kristoffer Haugsbakk
> <code@khaugsbakk.name> wrote:
> >
> > > The Magic of Empty Git Commit by Pradumna Saraf on DEV.to - a simple
> > > description on how to create an empty commit, and why one would might
> > > want one.
> >
> > The article does a poor job of motivating empty commits in my opinion.
>
> ...
>
> > My opinion from the peanut gallery is that the article isn’t worth the
> > inclusion.
>
> Thanks for your opinion!
>
> Jakub what do you think about it?
