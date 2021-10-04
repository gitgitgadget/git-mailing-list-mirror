Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B9DC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 15:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B934261391
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 15:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhJDPLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 11:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhJDPLW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 11:11:22 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6B3C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 08:09:33 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id a16so827968qvm.2
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZNPA9veoD2eHIaefKPKITWlb59MEgQE5z6AOiA3Xfc=;
        b=Wirynt3Kpb71kuxy59aaI+7GAMjm8Agz3yM/tgufzB1ZCnYPrG4MqMS0DIsBNYGlCJ
         KNC/6I4EapfwD92FUqC1pKn932ztc/TmAdx49Tot/M5YR3UiDjuJsqb/ClE/y82o6FqO
         piI1Hp8rxFZOMVHOZQK1e65uTSFbZbS4vIce67E0FDPcCdezT54w1M/FVE4mpb3jM+ZP
         PIY3ahc7v/cmzRuLp5vqpCjkzVdkKN1RvacHfXqwOVWldWzeEFR2y0jIwIGsq+GXeQko
         PTL6GcmO9oRcx2oDbJCCjJ+Ic5zCi9Q7e2nl3jiSIMaWT0O5QSWP67BkEMSz1IimAJUP
         m8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZNPA9veoD2eHIaefKPKITWlb59MEgQE5z6AOiA3Xfc=;
        b=jVyZvbElYHP8S3SaArDS3zYfQyFAbXmuyF8iNrkiI5KPblZ9JkxQ9uu6bOljcKihot
         PRvbFbuVH01g0WDE8Ocmwfh+6ybY7S1uHOgUkV1ehVwUAziN9d8vJzFNF2AegexIKIgs
         EKXqSMAKXkh3VjeyQPwKCtVqznmTMqFXhJH8u7wJKlTJoE2Y/lILfLGwmu1V/uQJI+0A
         aR2p3qfWwzife6T+hf1sIxN/p2TXUjVv/bfkLlPAPjTPNAdd1idFlgwd+rqp2h46U+L0
         smomDgBKE/5puNP850PE7QIIEHEg/ekMquJTvBUgjzu2YRwbeeEmV7lEZaHmDh9aPvU2
         oupQ==
X-Gm-Message-State: AOAM533if+xzg8MsfyPlBgApqAuVlfRxYLVx+vDHKvTXZojPjBTehGim
        houWx7YgbGNVRBzuBUzMj28VSLvtJICaR3jywOSvPQk0HWsBjw==
X-Google-Smtp-Source: ABdhPJx1U9rsH61OrI39rp0WzhI9I3C9H0bx7wM1Ep1BGcdA1YbRQLhzW0zysqvoLhB60ZIf/lVvXDB9u2MANHZyqzY=
X-Received: by 2002:a0c:912b:: with SMTP id q40mr16020060qvq.9.1633360172539;
 Mon, 04 Oct 2021 08:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <CABkJDHFOMkf-Pouaw3rtjtM+KFhPxnYtCiMbqKYCraXFb_9qQw@mail.gmail.com>
 <7b4b59a4-7e58-3db2-d934-d570cdebbf31@gmail.com> <CABkJDHHDjwviVmCR=tu3JBx+7BMmbmesOrkymq0fH4PXE5=i1g@mail.gmail.com>
 <135f854b-7975-a6a0-69ea-8697583a87b2@gmail.com> <CAJDDKr7itDvy1WPoC=kBPpT4_qm6MKWWfxwt96wQJKnGBGW5ng@mail.gmail.com>
 <CABkJDHFMy6yS40jn-NJ8mwrv6jxdjgNWQ6mJmEK1FYV0gvpLEQ@mail.gmail.com>
 <CABkJDHEZuZSun0spZ8SAcgQQvu-zamnJiqGk7VnS6agU-_KqqA@mail.gmail.com> <20211004075600.5lbqed4mnwfsy4al@yadavpratyush.com>
In-Reply-To: <20211004075600.5lbqed4mnwfsy4al@yadavpratyush.com>
From:   Sashank Bandi <bandi.rao999@gmail.com>
Date:   Mon, 4 Oct 2021 20:39:22 +0530
Message-ID: <CABkJDHGdzOFW5yP43LZtuUrV7WsDTvAi+kxka84-5P7ShbV9FQ@mail.gmail.com>
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 4, 2021 at 1:26 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> Sorry, I couldn't find time to catch up on this because its been busy at
> $DAYJOB.
Well, I hope you got a little time for this thread.

> Anyway, git-gui does have some basic dark mode support, though I have
> seen reports that it does not work very well. You can change the Tk
> theme and it should enable dark mode on git-gui as well. See [0] for
> some more info. I am not very familiar with how Tk theming would work on
> Windows.
I am not even familiar with Tcl/Tk language itself. But from what I
have found, the Tk uses "vista" theme which is Windows-only default
theme.

> I think it would be nice if we can have a theme picker in the options
> menu though, so that is something you might want to look into.
Yes, I thought of adding a menu between "Tools" and "Help". It will
contain 3 options(system, light, dark) as I said before.

> [0] https://lore.kernel.org/all/20201008082004.5643-1-serg.partizan@gmail.com/
Well, this works only for Linux as Windows doesn't use X Server. But
we can use `ttk::style theme use` for it all over the application.

My plan is to use a new theme, that is based on default, but can
imitate the look of [0].

[0]: https://github.com/TkinterEP/ttkthemes/blob/master/ttkthemes/png/equilux/equilux.tcl
