Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8D3C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 10:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378038AbiDVKnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 06:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447076AbiDVKnT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 06:43:19 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A043B94
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 03:40:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g19so13575060lfv.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 03:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bn00FLRXWM0Lst975FAJzuk4a/aYyDbzR2Jju3oMcN8=;
        b=mDKZn1ro2CsvKORUhTIJL38+S5Jf9GbOwEcB0Rxi7la6xmXTiXI13rO9S/whEr27oC
         SPNAEZIb7CoNGx8aIP+AM7moa8cQ4UVH7elxxBWlQapGhgmR9R1G2nuHGZkFUmnBKahP
         r1z8q7hXkvCLYh7odW2/nQDmCfoPxJU1w1UNLVBdAdTOtQIW8OPBHWzO/BDkHF+7b6IQ
         kvBQi0gCT3t+/K0W40dXuGTTvpmLsPm7B+ZEsfaZjCbFxU/UuTY4MLC+PceH/Yv0LE8N
         tgSWcAu/gN2aJrat3ww7xJzMJC1ohFS/gS03nJmgesViPONTeKQk2M/6nVYEOH3vDcMH
         4yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bn00FLRXWM0Lst975FAJzuk4a/aYyDbzR2Jju3oMcN8=;
        b=4CEL0ELl0Ph8xGRLINsezieL3EA3DHwMZjZkm3B1r1rRZIa9s6T+CA36hh22AJjToP
         QXGp+ZWRUgiaLMrqHQd9Nm6m9/CUqweFCSYvgKl80EMo4qNJY2YCGQ0FIjVqjwYoaw77
         f3cMmcQ6HgQCApBA75PGAbN2NY5AVdacAIVFdsrIZdH6fQwRQbhVh8X0HKYHvidSo1WD
         6VbWQRm6O/wZ9D+qDg9cptqfVwkcUn5Rj70O6uJ4R/PUvrb9NXalSPZ+tWN6QBqkaN6/
         vDc8lap5AyCLoX1guUbvpBt77Xx3QLcV+gFmj6SUIf+lVvacOj+pV5jBzIdK9e0J+0LS
         H50g==
X-Gm-Message-State: AOAM531XJ/pxQ2ZQs0ewFGWX7jAKTJvou0vlBaxv0k2uiGJpPwrBV1jh
        MMf/OYlXhNwRt4uRtSd+9j57mbdm/dGhP1oR4g==
X-Google-Smtp-Source: ABdhPJxYFodebLs1hX6mLKy4i9y4WUOzs11rmgyX1M960pw/MGLdVKb+FA/3iRGFFPTJ9TN3NMlqYl7ddfs7V/IMNQU=
X-Received: by 2002:a19:674c:0:b0:448:3f49:e6d5 with SMTP id
 e12-20020a19674c000000b004483f49e6d5mr2658481lfj.518.1650624023680; Fri, 22
 Apr 2022 03:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <CALOmtcX4+ON7+J7K9X4rSYfWYnkciJdFE=v=Oeb7rUqwRt8_JA@mail.gmail.com>
 <CA+CkUQ8hf5m0GZEwcyqLgxMw1vavYey_R4P7oq8=OXc7iAj6MA@mail.gmail.com>
 <CALOmtcW=2skmUPXpnano=21i38b7sq2MEWQjH5yF2jLacZ8sQw@mail.gmail.com>
 <CA+CkUQ9ZnBXU8E=XKTk95hwM4qtZ1M_nX3LTCr5q5njPG3Es5Q@mail.gmail.com>
 <CALOmtcX7amyw3cAuthMPuagUVzJghybHFNy8ciB50yC5SCUwow@mail.gmail.com>
 <CA+CkUQ-YgmRa7ysP30GbkX07Cu_=EM5X66w3Vk=TpshP9xoi_w@mail.gmail.com>
 <CAP8UFD2uUFveiGDAbxObDOh_krmexuLe860Gu397e9KddH0UCg@mail.gmail.com>
 <CALOmtcVN8K59Zkv7XKM7w2zFCbdWKfKr=97-E3306nQHm4Zw=A@mail.gmail.com>
 <CAP8UFD1kinAwq7AL68QXqFR_dxkNFaTp2vP_DUU0KKqkbsXCDQ@mail.gmail.com>
 <CALOmtcWaQgrPTkRA6F8bL3Hp64cOxYrB4xHUa1WC+P34ZdFEbw@mail.gmail.com>
 <CAP8UFD1HGbbmJWB_TksGVLa-7nNBz5pdFi59Y7LP3EODF9Lztg@mail.gmail.com>
 <CALOmtcWFwfV11Vxf1xd_fC=HYGPNO1PtKT=E=-A104cGnAbv4g@mail.gmail.com>
 <CAP8UFD29NgffUBz0CMKyt901Z7Bj5osoBT-4Mfxfp0h_4Qo+Qw@mail.gmail.com> <CAP8UFD1f6KCO+=+ZoUFr06XUgEZYOZi8G0V+QKCK=bNbAE9VrQ@mail.gmail.com>
In-Reply-To: <CAP8UFD1f6KCO+=+ZoUFr06XUgEZYOZi8G0V+QKCK=bNbAE9VrQ@mail.gmail.com>
From:   Tapasweni Pathak <tapaswenipathak@gmail.com>
Date:   Fri, 22 Apr 2022 16:09:47 +0530
Message-ID: <CALOmtcU-a0YUe2M5LwoRVU9PR4NOb8Ux-zEx144upo0oFz8PMA@mail.gmail.com>
Subject: Re: Unify ref-filter formats with other pretty formats: GSoC'22
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor, Hi Junio,

I have added the mailing list (++git@vger.kernel.org) in this email,
hope now it lands better in your mailbox.

I would be happy to take these tasks, not that I require any
mentorship but to work with folks who are involved. I have had times
where my work has not been seen for quarters and then closed after
reviews cycles, never let it re-happen.

It is a nice and respectful way to say, already deeply involved folks
as mentors, for someone who is entering the org or community. Not that
I require any tech or engineering help or otherwise, I mostly work
independently, just don't want to go my work stale and be clear on
what exactly is required (before or after a discussion, rather w/ or
w/o any discussions)

On Fri, Apr 22, 2022 at 2:51 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Taylor and Junio,
>
> For some context, Tapasweni is willing to work outside the GSoC (as it
> looks like she is not eligible for GSoC as she is not a beginner in
> open source) on some Git related project as long as she gets some
> mentorship.
>
> Tapasweni, please correct me if I am wrong.
>
> Best,
> Christian.
