Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BD8C2BB41
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 10:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbiHPKEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 06:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiHPKD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 06:03:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B1B2DAB1
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 02:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660641322;
        bh=oJ1TQqillAteopFl6c5H0t2WvqNP4M6OqYqzG0CQzD8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ELfvDqBx70aaLy7dSz6x+V0GpYuq4y1RWO9GByoF3iaFRckWY96HvqaILm+Ps1gTg
         INDwveJ2BrWgYMknA2d8w+IyqfksTtdQA968UYr5M3VvgheO60TfeQZW/1E701pMVY
         OZaYtkwhzbMQdAWDs8lOGoe/QSkcot/o0ZZzW2no=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXyP-1nr5Wv0zAV-00YwjR; Tue, 16
 Aug 2022 11:15:22 +0200
Date:   Tue, 16 Aug 2022 11:15:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/5] rebase: factor out merge_base calculation
In-Reply-To: <xmqqczd12zhv.fsf@gitster.g>
Message-ID: <77899422-7o79-s730-p529-72022r6o7442@tzk.qr>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com> <019158db9d2dbb371705ba79a96a907e4a17cdb1.1660576283.git.gitgitgadget@gmail.com> <xmqqczd12zhv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:g6M+qcA0fuT5aE0I0DHwlKLCwZ2WYTRP7DRtJERKMep72u5Vdir
 BekWDaAWVtguK21S8jgQg1ZOJSHNIBcDLF1krH6QanAC1wAqY+N2DieMLTf/YZR8Shf8CmL
 hXKYcodu97vql/1KxKXjBy1lddu9+wSloj7OnMdYi7POOmjjr3elN5c04tmGuT1L06ZYOr6
 e5ZvX/5mpXX+Tua/1bM8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vzPU3vubqXE=:+Hp5eMb08VuYwkMLKl0Wmq
 OR02fdqhpFeEmIj3rIDEFmF7ELIESEGj0VpTGVYg32dkV7M3odAOM/j3JPBNUbqWfEcjHUV7J
 vLwQAq2qcv3zqFfzNG7gxqvD5ch0721umSEQwOUjUMOIEsnTEGYwELZ9rSEcmgqsc+2V4LyZI
 8uYhzDgkW69QRwFlyjJUbiWTNPvFFvShF/xBSGCwZppnf+F9ztJleXd+rKnSI6ofek8d45eL1
 JALZOh6zvCT64lizuY5AKHrfS3iRoML029VT/khvxKy+4BIclfV1T8gN16lsj609XkvUZ2qwM
 Em2hHRMA/1M8OQ80ftwPjYWN/kQ0wh69ayMiL6cyAY1sCdaAf33sdfbDBkuJ8HRXL883zqSd2
 gKcqkZiUuWp0pbEpSwaYUhTPhalIJmagzfGMVDpzJC/I+HZhGyZ/6Q2aEGmM+XUrknJqyC1ui
 Q3t5xEZBpj2V0Xbh+X18cpeKNID4fIwe3AECueZLpmQ1/fX2gCfleFZ3xGp4xs1Q+W6EPoicf
 Lvfvk+5ublg9kkEQEzXo1b1f39iAp01zKCHpetynxGlLqre4xFEjkb9eacDDvBQrl44ZhpRad
 gkxSQBxS2M1r3N/yR6n6fxoPXMDGpscceTq9F4yzloLL/GpK+mqnjwh3Y/8zg2nknx+SHq1+h
 EAOCFAwpfHw67OnBz8scMq5HXjQeHK20W1/VHo7lPUIBMnWM/Z11TFwJ+6AT77hW+GYYqENhA
 AbcBxd4S+NLClVMayxJ8QBI2asYQ+mrNaILNdCwkZZH1PD8QBgNL1I1RTr5HuEozCnc1IW0qo
 zyg2HewmwKyNUKGPdx1uhu7m7B+IoktODUzytfPlyNkbuGxu2MCGVjym0Zbc08bZL1lZg6sgN
 GJVjtTRGby9ZxAFdrtWr2ay5JkLZ5W96ttj/Qeur0dlRAk25mknlFA74z1AjWXTgAKW+REYT7
 iVF57qZpNC0o70zbqRwTyOxXIGiVnAnFQ2Xj596i9HfphuSF8LulDl6gMPAEiEIwUYDzbP+bB
 ltpag6Fxvt6ggdorymrq9PMmxDzhY0EYDfLcRfoTvklksbugff4sPJOZMPYuGXtj/mOQp56nT
 4X72zBLY4EOo0N0DeQSysIc57g3jBbGlRI9Mzp9JVjcQNMyoQGYWOW0fg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 15 Aug 2022, Junio C Hamano wrote:

> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > Separate out calculating the merge base between onto and head from the
> > check for whether we can fast-forward or not. This means we can skip
> > the fast-forward checks when the rebase is forced and avoid
> > calculating the merge-base twice when --keep-base is given.
> >
> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > ---
> > Note the unnecessary braces around "if (keep_base)" are added here
> > reduce the churn on the next commit.

This note...

> > @@ -1668,7 +1678,11 @@ int cmd_rebase(int argc, const char **argv, con=
st char *prefix)
> >  			die(_("Does not point to a valid commit '%s'"),
> >  				options.onto_name);
> >  	}
> > -
> > +	if (keep_base) {
> > +		oidcpy(&merge_base, &options.onto->object.oid);
> > +	} else {
> > +		fill_merge_base(&options, &merge_base);
> > +	}
>
> No need for braces around single-statement block on either side.

... already addresses this feedback.

Ciao,
Dscho
