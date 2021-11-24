Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54164C433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 18:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbhKXS3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhKXS3D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 13:29:03 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83B8C061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 10:25:53 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id b192so2189197vkf.3
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 10:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E2WnGcUadyAT6Cge4OlEfLAknpcIwPH8oFinU9zk0jo=;
        b=iIfazY9F6W9RJ2sc1nPn41qucb/gE0SC5O2A1h4V3p6xAYU62HuMWxqr1//SDggtmG
         XZxWS1zqcNNvGJWKrvKcfhlySgTDhs7whsGjz/7Y3I+adIG16kfK4WTvHdczQh3v8RjU
         tjb/CVeAWwPE/HBdBEZhWB7xhc6WWQzioDtAan6NCG20XEikGmBZR3hYgXXl+umxdYLb
         OomeYRehKGT+ZlxZ2ghyqSY0s6yqWZuJ4lvdhJmZSjD6A2/LZnEP0lmX118vJWQU01Jm
         HasHvsU6KDcySFWp5OzcnVTa/qO3D3a44j5a+im/IQm86s/I88pe9isAvFA7Mv1hI9n8
         cGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E2WnGcUadyAT6Cge4OlEfLAknpcIwPH8oFinU9zk0jo=;
        b=EuInyOMnGiVR/Bi0PldGNFuWE/W+YtVee+4oFTek193AQw1F0yMCG+7+La+J0OJhu3
         iGjlnLiu2e9CoYiydeMXlvRwq22JqkyMGvD9YlODAV3rdkKMRpSyqqdYC5aiEePOvm8P
         QEu1O997gM/dDVJTUlsGb3M5lV+hlZODNCQ0X9s3lOVFrikktnfHojkwlldKVFWDVWU/
         t4+3jcoddz+UJbcEH6BX60JOxlgGDtAuHqz+2MpIQI392h7cylW7281piaV4dvy2R/cY
         qcGxKB+qxvTYnhV4CdKfjQW7QOBdhBGP7ut+MkGlbGR4Dr5p2YezydljoLmPEFb/7eLv
         sgPg==
X-Gm-Message-State: AOAM532X4t45kglvdT4v2H2KSRg7cT1BnH67Fd7Lww6S1WbXP/1wb9uz
        2q6xAj6cqNAji/NYA1whtznx8WZQv0TJ2qNhoUmCC09xZ08=
X-Google-Smtp-Source: ABdhPJwXCLAYLupnO0MF2/ppJdV5MaHefZ32aoIxPkcnnoUzUB5NZt0w8Yf7AXspAS+AZtxvhYdZymYxCVkDOFE0hsc=
X-Received: by 2002:a1f:18cb:: with SMTP id 194mr31089552vky.16.1637778353023;
 Wed, 24 Nov 2021 10:25:53 -0800 (PST)
MIME-Version: 1.0
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
 <20211122222850.674-1-carenas@gmail.com> <xmqqa6hvbxob.fsf@gitster.g>
 <CAPUEspgDafXHHPvzNijTsPsna76yE8W=JH-78LX3jyaieSmp0A@mail.gmail.com>
 <xmqqtug293ml.fsf@gitster.g> <nycvar.QRO.7.76.6.2111241428190.63@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2111241428190.63@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 24 Nov 2021 10:25:41 -0800
Message-ID: <CAPUEspi2PRs+yMUiAmvJK+z=F=kcguHpOL2inAV208yaq2n2Ww@mail.gmail.com>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a tty
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com, thomas.wolf@paranor.ch,
        Alexander Veit <alexander.veit@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 24, 2021 at 5:29 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Maybe a better approach would be to hide the `save_term()` dance behind a
> new config option, and then have it turned on automatically if the
> `editor` _happens_ to be `vi` or `vim`.

that but without turning it on automatically was what I was
preparing[1] (2 commits apply on top of master after the revert) as an
alternative to present for the 2.35 dev cycle.

I agree though that "turning it on automatically" might be worth
adding for the git for windows fork to minimize impact, but even
without it, I would hope the people affected wouldn't mind setting the
config themselves or could even be done for them at install time by
the installer.

Carlo

[1] https://github.com/carenas/git/commits/seen
