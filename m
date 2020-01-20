Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D215C32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 23:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307662253D
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 23:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ion50C/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgATXYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 18:24:17 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45197 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgATXYR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 18:24:17 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so1101224edw.12
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 15:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ktpyQ1hsfAbMUwtJUAGDFyOfQVigGqxV+a9/1kYsMQ=;
        b=ion50C/8p4Bw6OftOqaE2M7M+Ivi8MFsvx+Dg6mlSHn99OgQJDaD4n6t60Dxp9sK6h
         QcylxPsjxsZYAO8bWjUwe22T85unikB2FFCdV22xP+zC9ZcnNPq0w9Yv/ju8SGuvm9r6
         hy5uK4GNcEV8PUKeBZiC+NbvK4k0hhcK5EvGNnPe38XkPoxRv3imv6Y1luuXaM8Agx91
         uxVhdiOZzCeHVBTuS4KZO3b9cKsJs5lIaHXeurnVYef13O+oQESQ6xwdeCqTDpxcw5uM
         4Zcc4n7Fx3alQdpwZb2k7uOsqxD+mG0nzJNWEGhLUdBSdReq93MZLM5+imJ3He+GCWir
         6MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ktpyQ1hsfAbMUwtJUAGDFyOfQVigGqxV+a9/1kYsMQ=;
        b=RbndOpQ96Wh1B2+1DCcyv7jhxFXjhaYoWvod+BlGZwHhsZCs/65RvKkMiVCeSulFr7
         sQ0hoNcKAaNOfKUpVeZnplPcGFWs9qgF6wENOC0SWo5vtwYv8BqJkLyttq+bcmVabpHz
         mOz9/f/YyMUZvxrU7+4Zd3Tc9DWyttxQp4BdpL71naAC5VFggfglae/O/Ibun5ToycRr
         sW1g37+RaKjCgd0bODsMJx/+Ihp7w3N84K4/mmFoBRx927kzhXcfnVOONVj6/wNgb1aB
         6+OeTg/i9tF4e6oY1sHswltGe0F9FQJY/hMKv3qOy9v7+CamFKvcVM02gJhYaI0smv78
         hnAQ==
X-Gm-Message-State: APjAAAX1ckvLTTXf45jPSi43xujEsPwKxSyTKspO9YY9iiI+a66ok9u8
        hTjbDRifur8eq8A9Z18Y2r74dk0F6NU59+GAhpw=
X-Google-Smtp-Source: APXvYqwREBLo/I34qqi7l+DP0s8z9mr/2+MJLNIF3dEJQ93fPnCsJql3z99x+joKw90zXIWnRaadlxas0APw1/eNySU=
X-Received: by 2002:a17:906:3647:: with SMTP id r7mr1758274ejb.320.1579562655746;
 Mon, 20 Jan 2020 15:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20200120143800.900-1-mirucam@gmail.com> <nycvar.QRO.7.76.6.2001202237140.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001202237140.46@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 21 Jan 2020 00:24:03 +0100
Message-ID: <CAP8UFD0W=kBs1zne56OjPbFzeX7BtEazPh2MW1My3qAsByS=nA@mail.gmail.com>
Subject: Re: [Outreachy][PATCH 00/29] Finish converting git bisect to C part 1
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Mon, Jan 20, 2020 at 10:43 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Mon, 20 Jan 2020, Miriam Rubio wrote:

> > [1/29] bisect--helper: convert `vocab_*` char pointers to char arrays
> >
> > * New patch to convert `vocab_bad` and `vocab_good` char pointers
> > to char arrays
>
> 29 patches is _a lot_ to review. I would have preferred a series of
> smaller patch series.

Yeah, it's possible to split it into smaller patch series. There are a
many similar patches in the series so it was easier to work on
everything together to make similar and consistent changes to all the
patches at once.

> For example, the first three patches would have made for a fine "some
> cleanups" patch series, from my point of view.

Yeah, but this might then be rejected by Junio as it would be only "code churn".

> Also, as the mail's subject says "part 1", it would be good to have an
> overview how this part fits into the overall story of converting `git
> bisect` into a built-in.

We don't know how the rest will be split yet. Hopefully there will be
only one other smaller patch series after this one.

> Finally, it would be nice to have a link to a public repository with the
> branch from which these mails were generated.

Yeah, I agree that would be nice.

> I will try to review this patch series in its entirety, but it will take
> me a while.

Great, thanks!

Christian.
