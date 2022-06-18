Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6F7C433EF
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 15:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiFRPfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 11:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiFRPfP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 11:35:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C0F5FC7
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 08:35:12 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n10so13727663ejk.5
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5EpqUbyKamva+MOoq/0AYSdeZCZCqQ6zKM3Xh7RMPjc=;
        b=TD3x8y2rad6J5PQX2HdRtuFtNNdix66h2m2jnWMvatJVrlNsvsqkr2a3PEy0mRcAz8
         ZxMaYjSPtBuOirDeKtoKxgxEyfAVUPrlVoEx4je2LCam8E08Y6JvrENyF7J1K4m014p0
         +5nHz3rb8Ak6asMBYyA3KmK0zvOWVVA+LoSq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EpqUbyKamva+MOoq/0AYSdeZCZCqQ6zKM3Xh7RMPjc=;
        b=1NPDkw/HpRPYEZl5dfbLkTjp8xNK41szjUydrYGtap1EBVJzjcV31PXKaOI8CrXQtv
         pc5loubF9LfKq4N5ZPMP25iGEEoOUU3RKArYRZ249sBKGvPV44xrYpojk21ymRdWEgIR
         X4S7BQ9CrOBoc+9mqbeuPbsaJRlzCqWcFqaJLN7PkKWYTgJXReWrxVLh2iaNkn5bzJ3h
         Ema24zbhBnLylZ6+iOja7Vk0bKBv8B856EPGkWda+g5QfV42KSfBGj1HkKmyJ5E3yM8D
         MQwbb4tqbB1c+fOXqKxfD19hu4j/DrBi26c2OR9tdEkNH99sLux82ARulyV3XmYPyMXn
         Ghgg==
X-Gm-Message-State: AJIora8bVyKUcvASDeKMX/0GwoKebodinANW9jtBqUK8JMZpQMlHVfUT
        KG+g3Vv8zJYrdeQzH4fGVZwzdrNOvkoYWU/AR4+WnL/LcyoqiGFU
X-Google-Smtp-Source: AGRyM1seG+vyNofRfEd7rwYMs7SP1b5qJyj5dPFLkt4JzEL203eephYHGdGTJQebm3e+L7ZLe2LUbTWMDak1XZ21/jk=
X-Received: by 2002:a17:906:2b5a:b0:707:ce7b:94eb with SMTP id
 b26-20020a1709062b5a00b00707ce7b94ebmr13526117ejg.335.1655566511229; Sat, 18
 Jun 2022 08:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1257.git.1654967038802.gitgitgadget@gmail.com>
 <xmqqleu3au2n.fsf@gitster.g> <CAPMMpojdnAMnczJAevqL8GSOb8gvddcSiYfbz0c51oPpn4U0wA@mail.gmail.com>
 <xmqqiloyn6j5.fsf@gitster.g>
In-Reply-To: <xmqqiloyn6j5.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sat, 18 Jun 2022 17:34:58 +0200
Message-ID: <CAPMMpohkEDwdDoDZ9nQkD71FbDZU6a9Ut0WLUSqBp-oqFLOr5g@mail.gmail.com>
Subject: Re: [PATCH] apply: support case-only renames in case-insensitive filesystems
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 18, 2022 at 2:45 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> >  I assumed that
> > both case-sensitive and case-insensitive code paths would be tested by
> > the complete CI suite.
>
>
> When the system I am primary owrking on is case sensitive, it is
> always nice to be able to discover that I broke something on case
> INsensitive system before I conclude my WIP into a commit and throw
> it at CI.  We may have to case-insensitively treat the paths in the
> index in order to match what the working tree would do to make "git
> checkout -- <path>" work case-insentively, and doing in-index-only
> mode of operation with core.ignorecase=yes on case-sensitive system
> may be a way to "emulate" some of the requirement case-insentive
> systems have with these "-c core.ignorecase" trick, but of course
> not all scenarios can be tested without being on case-insensitive
> systems.
>
> So we need both, I think.
>

Understood, makes sense, thank you.

I made some changes that seem to resolve the regression that I had
previously noted, but I'm not sure the approach makes sense, it feels
like there must be a better way. I will submit an RFC series at this
point I think.
