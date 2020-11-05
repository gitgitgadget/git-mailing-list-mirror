Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FB6C2D0A3
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 01:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452B020867
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 01:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv9NEx2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgKEBJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 20:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgKEBJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 20:09:27 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37C3C0613CF
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 17:09:25 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h2so101685wmm.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 17:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGbySbkptEPyIZsVHrq5WqCRzhWG/RGc2kyArM/8Qo4=;
        b=Nv9NEx2Uxey7PZ2YNDITLBWQqUnHPLwf08ReM+VangPD4Ou3zfGllgp1DXGCT0IE4+
         MC1TPfSeEM+fnNdi2XdPfgvx0cU58drmPSYadcebgE5Z0I2R17Qy9cx5blPZpUUZQopN
         tfUL/yiNTsrZ9xQ+mhOp6egRi1Ru/SaDnCr7LNhJCqMtGsABG/MsTmjq9O9pWmIA2Hc0
         YAM3pVqNCZisLE1c47Ke50m2EeY8hScM0TskqMRa1OIEDoEjm/UfGyhO2NvU5LrtAh8L
         jOZhoOoVym0PzPm98J9/SZ6AHtrm/qAphGAyvsIpOsDYw7TK4L/lV4AVnprdFKu9bXyJ
         L5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGbySbkptEPyIZsVHrq5WqCRzhWG/RGc2kyArM/8Qo4=;
        b=nHTphtFohkumbOJ3Hzn/DbD2LcLtDQJnrEIJ0vR9x+9yJVhi3uz2Z6or30ZM7ShYwX
         gFRwX38ofxGETQbdAibEODbPFsElxj4rOSFsUuvrlyeQBrmLh0CuiohsQtPmnTmjac5W
         rUSvo+xPfxLNGe3jmre6PGQQGE2upYmwZkHzZTirGg+su7vLpgNWliwkF3FN72D/9tkI
         8Geify42Z+ha4mdrge1ZtbsWuMgO7+FC+PC5UaE93RIyZb1cSQr2Hvz1e4cikwkjbOgr
         Z5mfZ8+8rAK6ojwjgodnIDM6FRwp+VhdniIncOMx1G/7ThPAtJxcX/IvwULKQayVAWe9
         UxkQ==
X-Gm-Message-State: AOAM5311SMo1sbPfyjLy/mAu1F9zK+C9qdi8FqNwI0pSBPh+aV9IGRup
        EvnJyLHUtARXpR0Jqbvo4KQk9zxghoGEhOglbco=
X-Google-Smtp-Source: ABdhPJzFzKHuuziGNryUC+lEYy/f8tdrh3+likpEoRyavBsSVnmTVT4mr+3z5dW0J9rq/gDJuYixOMZTBjUXmo/gJqQ=
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr201967wmj.37.1604538564401;
 Wed, 04 Nov 2020 17:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com> <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
 <xmqqk0vbbep5.fsf@gitster.c.googlers.com> <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
 <xmqqr1pj9rf0.fsf@gitster.c.googlers.com> <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
 <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de> <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
 <xmqqeelh7y23.fsf@gitster.c.googlers.com> <xmqq361x7xj5.fsf@gitster.c.googlers.com>
 <CAMP44s2bgZbKde-UFL7+sR-7QgEv5Oiho2LTi3RG7S4BD0iuaw@mail.gmail.com>
 <xmqq7dr3nr9h.fsf@gitster.c.googlers.com> <CAMP44s1RS2-8rOvZLidRjkB=dkBGRpPzhpwpQByDRObP7UMLFw@mail.gmail.com>
 <xmqqsg9pm1v4.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsg9pm1v4.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 4 Nov 2020 19:09:13 -0600
Message-ID: <CAMP44s3occuUi2no8JfxPreLouvMsKKBcivKbv8XMTToZowz5w@mail.gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 12:08 PM Junio C Hamano <gitster@pobox.com> wrote:

> But the take-away I got from your short quote was that I see no
> evidence that Zsh folks do not care about usability.

This exchange happened 9 years ago, so I wouldn't place too much of a
burden on what they actually meant by what they said.

Even if my interpretation of what they said at that point of time is
100% incorrect; it's not a *derogatory* statement; it would simply be
an unfactual statement.

I will contact them again with some fixes to their code, but not just yet.

Cheers.

-- 
Felipe Contreras
