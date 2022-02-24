Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846F4C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 18:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiBXSXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 13:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiBXSXC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 13:23:02 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5FC4D9F6
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 10:22:31 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i11so4048420eda.9
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 10:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4BSwXnbau2OZeWQIFcdRhmaueI5MoKKiDhKEe9+L1k=;
        b=mfRd1FMCwJ8XSAxsrdFeI4z8Lg7Y5IqG50b76D6Nq4FZNvpuuqmiYQgRpJwOpAy/9Y
         8rRjx61uSox/5A1A52XwmzWMEXVo22dlhKmqRifasNFkZobml3sHyq8AqyV3tSkbffAk
         VMWKYunTC8zlF2BOWxD++twa6oMbUQxOIcGCQBEfD1uAc1xuf4CAJV1sJxS5cXhELuw2
         7ZLsdgToMn2zbWVzd9wKgfW2fis2UmhFLRVl/FmdrLbdPR7bdVG53MZUBqXowkZX/irr
         PU2sCo/s/i+KLSWKWD+TCnwftzFMSVLyHMWTExLYdej/qneIKk0fa078L70lXOtC3YXp
         j+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4BSwXnbau2OZeWQIFcdRhmaueI5MoKKiDhKEe9+L1k=;
        b=TZt78eK18VMGsi4cCgAGzTtmL2SMXMI5ucXhLL73isLJZf9UZvF3vby5c0L3/CsVx6
         b8Y/Gz00r9EWxFShImILxLR8io85ZWGfcG9RXbWSuzeieh+Q1/z4ubmnTuSAUvNRVTUk
         dVXJLOaXzqEjBm4/rD3+TGvIxBRQubOAmnPzF39iIM1KgrqFdT1erzKb7tHOfMC9p4ns
         79DpoknaAvTSN5N8WCIXqB7UCJb6BdfRwCcrNQ/oUAw6QTD+SLB0K+IY/V8zBlvdVOrI
         aQUWkgoOxQybhNQCZTNDoMCRqNP3nDIUxZmDzsSIGVkp4RBAiAnIvaGdC9T2MzyGu3vO
         VTuw==
X-Gm-Message-State: AOAM533Z+5zbHkmaeOIsV1GvDoR/A26mUGwHd1S7AlSwSG4YKrk09VrS
        aTTctG8oQ3lKLMmXJJ1AjRbR6cb4y8oW83zJTS8=
X-Google-Smtp-Source: ABdhPJz36JDWlJ2BKhJBw5HJnLqOrdCEToEb26yCosaCctj/uMfFL228RvzmdovG6B5UPMbn0uLg+Ruy6J/+hUBt9UA=
X-Received: by 2002:a50:ee14:0:b0:403:c81d:c3dd with SMTP id
 g20-20020a50ee14000000b00403c81dc3ddmr3546790eds.195.1645726950052; Thu, 24
 Feb 2022 10:22:30 -0800 (PST)
MIME-Version: 1.0
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <CAP8UFD2wNSJmiohfAGrihm5sO_q4a6UpLMsVNAF5uWyuWt7R9Q@mail.gmail.com>
 <CAC316V5x54Ah566haa5wZ8zE=gkhYtziC+FVjXoBXn7xY_-WsQ@mail.gmail.com>
 <CAP8UFD1dfXHYudpT=0e_2DZdmZMKyqKO13EbPozwpZkEYewxNw@mail.gmail.com> <CAC316V42eP2GEuT+=yvi+Rbdni4KTJzhzUGHgCtcdWkGE9O-Ug@mail.gmail.com>
In-Reply-To: <CAC316V42eP2GEuT+=yvi+Rbdni4KTJzhzUGHgCtcdWkGE9O-Ug@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 24 Feb 2022 19:22:17 +0100
Message-ID: <CAP8UFD0cCDhfeO8xZCrhdodym2sMAGQfH0O0U-rPo-NqyBvu9g@mail.gmail.com>
Subject: Re: [PATCH 0/2] microproject: avoid using pipes in test
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 24, 2022 at 11:13 AM Shubham Mishra <shivam828787@gmail.com> wrote:
>
> > So, no, we really prefer you to focus on 1 file (or 2 files when they
> > are strongly related) and then move on to your application or regular
> > patches, reviews, discussions, etc.
>
> I misunderstood this :(. I will not submit any further patches related
> to microprojects but I already sentone patch at Morning -
> https://lore.kernel.org/git/20220224054720.23996-1-shivam828787@gmail.com.
> Can I finish this?.

Yeah, you can finish it. As I said to another applicant, we are even
likely to help you finish it.

Best,
Christian.
