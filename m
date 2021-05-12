Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83768C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A9A611F0
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhELAaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 20:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhELAaW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 20:30:22 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A157C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 17:29:15 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id i190so17242336pfc.12
        for <git@vger.kernel.org>; Tue, 11 May 2021 17:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=icCHT4LZLuDbFdy68TCn6hWCRdkBbF4VTqOdWjzaxaA=;
        b=JvoWaIB23bMq96Lw5mOuAf29Wk/Vqo12B0wAKZyc2e3/FLH2ipB+B8B3zrNUEikDD/
         8KYtZRsSHf8fhyQh4YoSslznkOBZKnHLM9IOYTBx9wp/TGk+KdgxDnseUvI8QolQWK3Y
         OIZj++/FNgH0tP1Y4t7jWAsJvlaIUs+CsamZN9ZFGxUchGwVv9rsDPZxq9PzpaGfoeap
         haAvA51019Uyu7Xjma3K3yLw5rPj+DoI1i+fnhH8/E61bgNq0YoI9yWwbOKILYTtYzPW
         U0Su3vjJ/TDN9C/0gd6M0D+qbap34O/IseEjXSlfejNE5nsKx+PD9dVW/0AU8T3wgijd
         znmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=icCHT4LZLuDbFdy68TCn6hWCRdkBbF4VTqOdWjzaxaA=;
        b=qbQrGnqQJS29VkIs1h8fyjiYvJKhAx3ZQ/sWDQRU/g4k3Y+EkcHboWzEG4M8QrM/Aa
         lfK3X9Cf6ak7WSmuqMp2knNXSGFSJ8C6yzfm5UEcqQeQsAF09felExNQJvCzGAVnf1aL
         SHV5he5BinQx/x4HqpbX41b/hj7Mkyo9ync60XpuaCN97U3e7Ane7CjO6fOAr91jvouY
         e6IR8Ug1UWVRjWV8T1B4Yf0W4DfX9Uuz+ZQkJ7EJHyrMK2sKkeXxXYw0eoT6tSPU3fQP
         UP0+xezgg5WSdL8G1083ExLPhtWjV3lsJZVx5c7995bBQuFp9HkCxAgpVvXLALOe9fxo
         2xrQ==
X-Gm-Message-State: AOAM533kw+AYo3s+npKErD8tcpG16S+k48iHUZC9sBajlPN6BcWiTKzb
        HkpFTCNORvT/vu2ndRrxLTYemZpnRJAtnbLRfJnrEIhex/OXDDc6
X-Google-Smtp-Source: ABdhPJz1eINRLjJsA+c3kPJ/S746FYiMX2Wf37xUSmvHbLwu845Q2lqbtR1qrbYXPm0XZxz6+CGTf3ZoeroTOv2zzg0=
X-Received: by 2002:a65:4485:: with SMTP id l5mr33044383pgq.209.1620779354680;
 Tue, 11 May 2021 17:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <MN2PR07MB59526F40B255183931649AD19C529@MN2PR07MB5952.namprd07.prod.outlook.com>
In-Reply-To: <MN2PR07MB59526F40B255183931649AD19C529@MN2PR07MB5952.namprd07.prod.outlook.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 11 May 2021 17:29:03 -0700
Message-ID: <CAGyf7-GEA0mtxUxqEjYsfqM4Te-5JO5_nW0S6Vitdmywz1J7mg@mail.gmail.com>
Subject: Re: Rebase Question
To:     Andrew Ottaviano <andrew_o1995@live.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 5:07 PM Andrew Ottaviano <andrew_o1995@live.com> wr=
ote:
>
> Hello all!
>
> I=E2=80=99ve used git for a few years now and I
> think it is an amazing tool! Thank you for your hard work in
> developing/maintaining it! I really appreciate it!
>
> I have a question. Let=E2=80=99s say that my
> colleague and I branch off of master and are working. Let=E2=80=99s say I=
=E2=80=99m 5 commits
> ahead of master and my colleague merges in ahead of me. The logical thing=
 in my
> mind is to rebase off of master. The difficulty with this is that if I ha=
ve
> merge conflicts that show up on my first commit, I have to resolve that s=
tupid
> thing for every subsequent commit. I could squash, but then I loose branc=
h
> history, so I don=E2=80=99t really want to do that. I could rebase in int=
eractive mode,
> but if I recall, I still need to resolve all the conflicts on every commi=
t
> before it squashes.

Have you investigated git rerere[1] at all? Documentation indicates it
works for rebase as well as merge, so it might be possible to train
that to resolve the conflicts.

[1] https://git-scm.com/docs/git-rerere

(Pardon the re-send; Gmail being trash.)
