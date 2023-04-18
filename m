Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62215C77B72
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 01:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjDRBz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 21:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjDRBz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 21:55:57 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4A97286
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 18:55:22 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2a8b1b51dbdso16020201fa.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 18:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681782919; x=1684374919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEeKZ9FwiluO9YoZGFC6UH/1jwkqpfmTuuU69VZvQ+k=;
        b=TdtIFqlhWnBWElFOsT+i4g5oqBktdW7L4DjSHV41vgU4JkGKRYqV3h4glcpTS95XxO
         q+7J8RGWgDzDfSItuk2z5Y6em2SxrIEI2jevHuuUj/XmZZEixkNBD6x8+g1CIphW/KzM
         adz+KAAaedxJdWml2P22Vo8yt4oj7rhv9qsPrwhe0cg498lKWwA9CJNgmk1VvEgfLjlo
         tboOpFYGPi+Kd41Vkq/0kOPIPt0rrZ9giOEFwbhbRpwdyKV4EDFXOv6TK9neY5PiIMvK
         vkFH3WrC6LmOHm+SST8KoHkMBq7ihG4ISQGpynTH0oFFxUy2DZTo+rPyif+VKa9mjGYT
         Ga9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782919; x=1684374919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEeKZ9FwiluO9YoZGFC6UH/1jwkqpfmTuuU69VZvQ+k=;
        b=BCEIk9rJwGTzQ7sUX1PM9+Jhb7D1S0kDgU7yrzUjMWiFPmvzC6J0H5/jKF/clQml9f
         aZGsehbDFzVQprsLihWauqRayDVblETLKm02CoFHsLP9ERzDv81Q6lNOeF5nEDkjCzte
         lWW1A6IPk/BfsM7IghwF9en7ZJ0ybhuTpvQ5KYiQCJkX8y0QkHh71Jsg3F/GqciTcZe0
         QP4bAPBOe14FIK1S7PO8+CXjR/gPWwfbOTWWHSmfeXEOGxHNYkppDFZJbL9gSuYPmsir
         R1tXYJNh6kbXJescnHJl5GmbvixpwWH/vug6a27e87dcP0PrAPmZyDYhpmYpza4MYHcD
         8wLw==
X-Gm-Message-State: AAQBX9fzhOiCNTZvSbwdXc1eFjXqM/OTyJ5ZQTnrMzySNOzlrUk+czcu
        hnhjrlA0AKxTpzTeRgtyQpHP2Rbj4AmXMMogF+LkAVqO
X-Google-Smtp-Source: AKy350aNZVWZBiiu9ai7XJjagJx88xQAWS9wHT/kFmK87hf5hnuZRtVbdQ12AP7k7E9vDHjhQwohbCQWwkYXl86Urcg=
X-Received: by 2002:a19:f50b:0:b0:4e9:22ff:948d with SMTP id
 j11-20020a19f50b000000b004e922ff948dmr2749998lfb.7.1681782919226; Mon, 17 Apr
 2023 18:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
 <20230416054735.3386065-1-newren@gmail.com> <xmqq5y9uo4kj.fsf@gitster.g>
In-Reply-To: <xmqq5y9uo4kj.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Apr 2023 18:55:07 -0700
Message-ID: <CABPp-BEmzofRAmgoz7Wam-6btCYCTy4CiVnTOtr9aQdjS6TB7w@mail.gmail.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 9:29=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> 5579f44d2f ("treewide: remove unnecessary cache.h inclusion", 2023-04-=
11)
> >> broke connections via git protocol because it removed the inclusion of
> >> the default port macro. While some may consider this transport to be
> >> deprecated, it still serves some purpose.
> >
> > In particular the problem is that
> >
> >       const char *port =3D STR(DEFAULT_GIT_PORT);
> >
> > translates now to
> >
> >       const char *port =3D "DEFAULT_GIT_PORT";
> >
> > instead of
> >
> >       const char *port =3D "9418";
>
> Wow, that is a bad one.  If people do want "DEFAULT_GIT_PORT", they
> would never write STR(DEFAULT_GIT_PORT).  I wonder if we can have a
> bit more clever STR() macro that catches this kind of mistake at the
> compile time.
>
> If this is worth fixing, the fix would probably be worth protecting
> with a test or two, but the networking test with fixed port is not
> something we can easily do without a sealed environment, so...
>
> Thanks Michael for catching this.

Yup.

> > I've got a patch that does precisely this that I just submitted as
> > part of my follow-on to the en/header-split-cache-h series.  I've inclu=
ded
> > that patch below in case Junio wants to advance it faster than the rest=
 of
> > that series.
>
> Yeah, burying it in a 24-patch series is a bit unfortunate.

I didn't know it was a fix for anything when I wrote it; it was in the
24-patch series just as a further refactoring.  Then I found out after
this report and doing a little digging I found it might be considered
a good fix for the issue so I included it here too.

If you apply this patch directly on this series, I'm happy to drop it
from the other series or do whatever makes things easiest.
