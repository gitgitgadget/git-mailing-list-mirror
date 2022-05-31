Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D0BC433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 16:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346122AbiEaQWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 12:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346132AbiEaQWb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 12:22:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8228995DC9
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:22:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o10so1869411edi.1
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sz+MPXRJ/BwzfyjtkRYay+8h1BVi2YSoI0R/+1t0/bI=;
        b=L6I5IXi9/Ji0jDxr2yliDniKM0ZU5GPdCrDIhgXBzzZ3DA3PPh6slgj7sPxYI2wFrT
         b/DT9gQ8IkjKzElR4GcxVQKVz9vNG3prrxxVtgjMt6CyjEiYjmeQmYZvopL8FExhkWgm
         ut0eXyqZHE3mFsUXfZSo8jKRWHvF5X7EVRxk62U6e7+Pe5NIiWlvTWEgfpEGV3LTAUGo
         l8sdzR6cBNU2jaZS6xGpT6MLtUBgUgMl5965DX4qfO3OCkMsD09DjhTgbK72CbiEmCne
         IJep11cTmk3JGKFZS8tc3WZDXsDHrTRLOlK4SSscEgbEhIyytbGgjtJof8EpIxk+CfSJ
         siqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sz+MPXRJ/BwzfyjtkRYay+8h1BVi2YSoI0R/+1t0/bI=;
        b=7P37K2C80InkAFH8J6XmC66TGF7Evhqdri8gAE0gS4Q6aQ+kR9B0c6ngjCSH4ewMLE
         LdiCIzGdpvZeIAX86czQjjqFv1NfrHidHCVZyhwfuHJUq8Q/fLcDts9i8eQjn4xfoi68
         d5DSs0TF9v2thHI7OH4FtMicQEWQVuGhg5mDfC545Uy4Qy7TMHZvTkBXIQyN8FcFkyGY
         VoQ/LydpMvP+b/9Pfhx3Kp0EoTnQOfFrp71mzhru6TC8d/LBKHk0S3/QyGZFuR5Pi9e2
         iLsaNmwSZBCKC3iUwIjqkkktG/GCM35NK/CmeGaOAWrmTC2AW7NtZIvRsaLadQHhTSOE
         V7xg==
X-Gm-Message-State: AOAM532PQYSfPfENYoFUS/w+I5sucOGN+93fnRYh0alXlMDCIXoA/IW6
        xmeakNZvtrE5lavdIVCxYsQzjTX9hUXQ+g9pGA==
X-Google-Smtp-Source: ABdhPJwEYDJ21mkFsO2MFbQ0umYI1l6k/yhLYF7ynwAIYyQ9+BqxbTnOPToL42+3iUQori7b8Nyt/ImlpZCx+AkZIWo=
X-Received: by 2002:a05:6402:1cc7:b0:42d:9ab5:a984 with SMTP id
 ds7-20020a0564021cc700b0042d9ab5a984mr19038816edb.307.1654014148004; Tue, 31
 May 2022 09:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <CALOmtcX7amyw3cAuthMPuagUVzJghybHFNy8ciB50yC5SCUwow@mail.gmail.com>
 <CA+CkUQ-YgmRa7ysP30GbkX07Cu_=EM5X66w3Vk=TpshP9xoi_w@mail.gmail.com>
 <CAP8UFD2uUFveiGDAbxObDOh_krmexuLe860Gu397e9KddH0UCg@mail.gmail.com>
 <CALOmtcVN8K59Zkv7XKM7w2zFCbdWKfKr=97-E3306nQHm4Zw=A@mail.gmail.com>
 <CAP8UFD1kinAwq7AL68QXqFR_dxkNFaTp2vP_DUU0KKqkbsXCDQ@mail.gmail.com>
 <CALOmtcWaQgrPTkRA6F8bL3Hp64cOxYrB4xHUa1WC+P34ZdFEbw@mail.gmail.com>
 <CAP8UFD1HGbbmJWB_TksGVLa-7nNBz5pdFi59Y7LP3EODF9Lztg@mail.gmail.com>
 <CALOmtcWFwfV11Vxf1xd_fC=HYGPNO1PtKT=E=-A104cGnAbv4g@mail.gmail.com>
 <CAP8UFD29NgffUBz0CMKyt901Z7Bj5osoBT-4Mfxfp0h_4Qo+Qw@mail.gmail.com>
 <CAP8UFD1f6KCO+=+ZoUFr06XUgEZYOZi8G0V+QKCK=bNbAE9VrQ@mail.gmail.com> <Ymc2Y+U4HQpgD7PE@nand.local>
In-Reply-To: <Ymc2Y+U4HQpgD7PE@nand.local>
From:   Tapasweni Pathak <tapaswenipathak@gmail.com>
Date:   Tue, 31 May 2022 21:51:51 +0530
Message-ID: <CALOmtcWhFp8th3-Kuwtcs7MoB95UjhttxC-JnN7PKBqR1zxv8g@mail.gmail.com>
Subject: Re: Unify ref-filter formats with other pretty formats: GSoC'22
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

.++git <git@vger.kernel.org>.

Hi Taylor,

On Tue, Apr 26, 2022 at 5:31 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Tapasweni, Christian,
>
> On Fri, Apr 22, 2022 at 11:21:37AM +0200, Christian Couder wrote:
> > Taylor and Junio,
> >
> > For some context, Tapasweni is willing to work outside the GSoC (as it
> > looks like she is not eligible for GSoC as she is not a beginner in
> > open source) on some Git related project as long as she gets some
> > mentorship.
> >
> > Tapasweni, please correct me if I am wrong.
>
> Terrific!
>
I just thought about what could be better with current GSoC
eligibility guidelines and open source in general. Says, I'm not a
beginner.

(something to deep think about)

> Tapasweni: a good summary of the current state of git-scm.com can be
> found in an email I sent here:
>
>     https://lore.kernel.org/git/YkcmtqcFaO7v1jW5@nand.local/
>
> , and I think the section that will be most relevant to you begins with
> "Convert the Rails application into a static site [...]".
>
> In that email, I suggested GitHub Pages as one such hosting provider
> that might suit our needs. But I am not the only decision-maker there,
> that should come from the community. It would be ideal if the service we
> chose was free, or near-free.
>
> It's possible that some providers may want to sponsor git-scm.com's
> hosting as an open-source project. But that's a discussion for another
> day :-).
>
> In the meantime, if you are interested in converting git-scm.com to a
> static site, let me know. As far as I can think, there are only a
> handful of components that aren't static and would need to be replaced.
> Those are: the search bar functionality, some light database work, and
> automatic rebuilding of Git's own documentation. The site's Rakefile is
> a good jumping off point to figure out what some of the non-static parts
> are.
>
> If you're interested, let me know. I'm not fully versed in every corner
> of the site's architecture, but I have a general idea of how things work
> and would be happy to fill in any gaps on your end, and/or explore
> together :-).
I have drafted this for the merger of:
https://paper.dropbox.com/doc/git-scm.com--Bihq4Cxzo3AzCrZqgScRkRo5AQ-LBbrQXZfwvrTMnhdEwhl8

1. Git SCM: https://git-scm.com/
2. Git Developer Pages: https://git.github.io/
3. Git Reference: http://git.github.io/git-reference/

If this looks good, i.e., Jekyll and GitHub Pages (with maybe a new
org? git-scm?), I will fill in the timeline. I have tried to add and
cover all suggestions while working on git-scm w/ Heroku.

Please let me know what everyone thinks.  Let me know if you prefer
Google Doc, paper.dropbox.com requires a signup/sign in.

(This email is to complete the draft document to have a concrete plan)


>
> Thanks,
> Taylor
