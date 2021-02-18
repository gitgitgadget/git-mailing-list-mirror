Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26307C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 23:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC34B64DE9
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 23:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBRXxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 18:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhBRXxV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 18:53:21 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BF3C061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 15:52:41 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id p2so6434560edm.12
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 15:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wr4x77SqrBBFK0P1KvbV5vi1wjJ4HSmjEts49NHsINQ=;
        b=AEVmNh/1WCFkHwAOJoWfGG5fdWTCUFvPpbLaKnSDJmJkgEce4NPO/3117nKQJL92/b
         a9WtOLxoE0SYvrdOVlNueTNLYVBZa8rTvKU725Ht3DOXcHB0XfXcTuX1bbruwkFfGCr5
         rqpPALXHY0CFGdxq41C4OLtvQB3qUFKlNMGUcVFC6IUYCwDul4apB/aOrSr3p6qBU/nc
         E+mzGnlOc6UNHAeSOdt2hy3GYrQ1SyMDy+yAOnFOk6YfW8N+sV8hPlYoPyliYrPtnyYw
         KkHfP+ajFZcku3DqdeJ07dyP2OKYryGXG1TJy5h8TvHL2D8dEBdaXozaPDNrqFmU7MIY
         Ohwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wr4x77SqrBBFK0P1KvbV5vi1wjJ4HSmjEts49NHsINQ=;
        b=AHRgy6P4xJHsqmR2vRDqAwZS2S26AWd5qg0gh4nkcPAsuG2QatURP6r2FPLyDZq98R
         QZIZzLiLrCH7KU1Ifk05pqgp5NqPidrTAedx9ZSzZD0QKEQr097wfFakISH2V4W4ecO6
         iJqkvRf9FRZDRMmImKQU1c8eBVEUl96cL7a80DUflDkWZ3C6i0gtlrVDJOGyHSYjl9Cy
         ZMk6mx6Wn/2R+ckvS6K/HOLv6sDBpVv2iBbPfwnRxZOWAH1uSTDvtPW/Ez++a9vAcN2r
         J40GLgCpuodxpCw6fj3Z1ItVMBZqJIXfhqyq2VYAXyDsZ1nOi/UbklGrsvVnX5UU368c
         sI6Q==
X-Gm-Message-State: AOAM531Tlg8M5B3PtcHhW4iqnU+e3Xa4Ay5CQabh4rzJKQz6qZXfNZMc
        yd9F1t1WsG+0oagBdLa/Vb8v62S5W9nTtNhgnkF1LyfQnNncPA==
X-Google-Smtp-Source: ABdhPJxn+Tna4VlpTUOkxEuj67WV9RGfZU4beIDWKoaUytfCDDVnu3sbEoN5nEjjhGd0F1nqDUxTEhMpTWUweGEUZ2Y=
X-Received: by 2002:a05:6402:3121:: with SMTP id dd1mr6483201edb.387.1613692358788;
 Thu, 18 Feb 2021 15:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20352639-deaa-0e3f-c99e-9bde937d67f9@gmail.com>
In-Reply-To: <20352639-deaa-0e3f-c99e-9bde937d67f9@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 19 Feb 2021 00:52:27 +0100
Message-ID: <CAP8UFD1VaOBWcf3RQTc6OdmkUZCOOOO0mubRoWAvao6uNtNkgQ@mail.gmail.com>
Subject: Re: Git in GSoC 2021 ?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaartic and all,

On Tue, Feb 16, 2021 at 7:12 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Hi all,
>
> Excuse my curiosity. I'm not sure if there has been discussion about
> Git's participation in GSoC 2021 but my search in the archives
> didn't get me anything. The deadline for Org application seems
> to be around the corner (this Friday, Feb 19th at 1900 UTC).

Yeah, sorry for not discussing that before, and thanks for starting
the discussion.

> So, I was curious to know if we've already applied to participate
> in GSoC 2021 (or) if we're planning to participate?

I don't think we have applied yet, but I would be ok to apply. I think
I will do it soon unless people objects.

> In case we're participating we'll need ideas that fit the new
> structure of GSoC 2021. Concise entry about the new structure
> from Rev News 68 [1]:
>
>   Google Summer of Code 2021 has been announced with significant
>   changes compared to previous editions. Notably coding hours and
>   period will be reduced from 350 hours and 12 weeks to 175 hours
>   and 10 weeks; there would be 2 evaluations (instead of 3).
>   Additionally, eligibility requirements will be relaxed, among
>   others allowing people participating in a variety of different
>   licensed academic programs, not just students of accredited
>   university programs.
>
> See the related blog [2] for detailed information.

I have just created an Idea page with 2 project ideas:

https://git.github.io/SoC-2021-Ideas/

Other ideas are very welcome.

> Speaking of GSoC, unlike last year I'll not be able to actively
> co-mentor this year due to certain circumstances in my family.
> I'll be able to help passively, though.

Ok, thanks for helping passively!

> Also, one thing about project ideas. Shourya Shukla who worked
> last year on the builtin conversion of `git submodule`
> (currently stalled [3]) has told me privately that he isn't
> interested in continuing the port further. So, finishing the
> port of `git submodule` could be a nice project for GSoC 2021.
> I believe it would fit the new GSoC structure but I might be wrong.

Yeah, I agree. In the ideas list Shourya is mentioned as a possible
(co-)mentor to a project to finish the builtin conversion of `git
submodule`, as he told me that he could be ok with co-mentoring on
this.

Best,
Christian.
