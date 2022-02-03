Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0DBC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 18:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353313AbiBCSQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 13:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243349AbiBCSQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 13:16:16 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCF4C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 10:16:16 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id a24so6655468uat.10
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 10:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4iICLMnitFpX+vv6vrIhJ4MgS9YkQsJ7p8XwDyoDQgc=;
        b=UZCnmnZDwyzisVKegalhRIfwtKGPHlwTYztB1AUsGA/kt5807znkqq21AcSn+KvOXE
         NUhHYPuEA073lAkM68pyn6TC80WItd0bghiX4o5Q70g5nRX39o923syaAklr+3ILx853
         Gsn6AZ7voa6d3pRZl/OZmbGftlcmP1oT2WScW3kg14KA81cVbekt8SV3IphjFVdM/7Nm
         gDdFhl8Msietaw3eTE1TTY+Z73w66/EJG3E5rl/V9dUoNmrG/TJhEIRqaV+Fi4Jk4e5N
         NpaTMXJzuz1tj+7hvFbNlWmx/hUwNkoj+XH5ChpfkVApTSgh/7mCo7ChFaKCMxVEA7lw
         fYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4iICLMnitFpX+vv6vrIhJ4MgS9YkQsJ7p8XwDyoDQgc=;
        b=nYfgnT3LyOTQ8e9IThZ2dgR8Dc/TuDqWwP51TJ0meI6Lj2TJgu88ZYhz96txu5QrST
         sdLQ0DY4Px3Aq4rdv9wBpuGPobjxB3mdNxhQinB9NCb+znxwmDq02MkOxXHn3lMVW5fb
         eIps+2HGp5Pc3pkE2395f1LiEnCaNNAmbFJJ60blb2wcOVc4I+uppiquIG9wje/aW9Vd
         9InwmmjqxWNGYNv6DYdYULFCDrFtVIPAdlx818fh/dkFIuxHg9DKkLOgxMJLOMignSBJ
         DK8iCdeUqd35YJg5oCHIykeCWJgBjDt8DSEfETbFpI5i6BwJdDb8DTGJUtjy0788PRmj
         UCTw==
X-Gm-Message-State: AOAM531jWGUD0dor2T283YhRLVap7pcRZ7TiPwoMpyYrGsEkXZQdEzw3
        VOvssk93AaLZ0vRSqnemD8kdmANxAttRjA9PNhdURg==
X-Google-Smtp-Source: ABdhPJwADRLco7Zp8T30GWroi80D+Uzrm8eaMQYq6PkhJVKVEtv/Q9Yr9ZzBugMH0QziYit4tU/9HZgyKFnIE9puUac=
X-Received: by 2002:a67:e09e:: with SMTP id f30mr14546022vsl.16.1643912175627;
 Thu, 03 Feb 2022 10:16:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1210.git.git.1643660136530.gitgitgadget@gmail.com>
 <pull.1210.v2.git.git.1643719616840.gitgitgadget@gmail.com>
 <220201.86ilty9vq2.gmgdl@evledraar.gmail.com> <xmqq8ruub35i.fsf@gitster.g>
 <CAFQ2z_Oxq67XO20oG7Tokk48wm5ZzHRR3GDi4PG5wg7FMJ89aA@mail.gmail.com> <220203.8635kz6d2o.gmgdl@evledraar.gmail.com>
In-Reply-To: <220203.8635kz6d2o.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 3 Feb 2022 19:16:04 +0100
Message-ID: <CAFQ2z_NWM0F1uY==rCrc2pvJYjgPyOHz5aLFLSng-DvgiQVxqw@mail.gmail.com>
Subject: Re: [PATCH v2] refs.h: make all flags arguments unsigned
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 3, 2022 at 7:05 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> > I proposed both options because a distinct typename lets me jump to
> > the definition of the flags easily through ctags.
>
> I'm not sure I understand you here. I use ctags (via Emacs) and it's

"I proposed both options" (ie. enum or typedef) , so we are in
resounding agreement.

> > Another idea is to mark the type of the flags by its name, eg.
> > transaction_flags, resolve_flags, reftype_flags etc. This wouldn't
> > help with ctags, but it does help with readability.
>
> Yes, enums or not, what I was also pointing out in
> https://lore.kernel.org/git/220201.86ilty9vq2.gmgdl@evledraar.gmail.com/
> is that changing just one logical set of flags at a time would make this
> much easier to review.
>
> It doesn't matter for the end result as long as we end up with "unsigned
> int" everywhere, but would with enums.

Not sure if you need to review it in that detail. If you change a
definition in the .h file,  the compiler will complain about all
mismatches. So it doesn't need human verification once you know it
compiles.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
