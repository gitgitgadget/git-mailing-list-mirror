Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3ECC6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 03:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjDSDRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjDSDRL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 23:17:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6237ABA
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 20:16:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h8so16784303ljf.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 20:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681874215; x=1684466215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GgOsDNeKwfaeyH6KxF98NVxqeRkz6WaiaTbROeqxss=;
        b=Sw8o8dl+KzZPnA5deIiQit8Dpq4i/PcZ1z8flpSU1D0LsESyKrOd0VtjGmAQeTZyeH
         GiQn7+p0i29zSzyklmfL7zqqrdirKRb/GObZRCM5a7cNuzA7bq1U68ieBFMqfWCjQXRQ
         xdMrJ1YYfPFWT98CFKx7qGKQboEVh8ehjEg0hYFHNylnaYk/P5jokh1egKWOjXSuBOHv
         yBsruInp5reQE0wpDHBI1vLQuiyziv/H3gkcbXzUP8vqqCw7w77zzB2o/seHxtxcIDGi
         FKqqJo16qSKuTgitd65cdvEL8hEsvvFdpQHlASUEQ5sj3uO/52wCvHTiLBArogP/5Ez1
         dQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681874215; x=1684466215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GgOsDNeKwfaeyH6KxF98NVxqeRkz6WaiaTbROeqxss=;
        b=Cvq6OvBUJxzkKmAvoIjDmsCF5VTNMmaUFRBcBQSvCqU1/LW1ND2mS5Kfz271U9zJWn
         bV2KOfrFRGPFSMxYKzqnRHLploSE6mKuhKvm3KarIA3XY6d/6UDN0PkLAJdiakS/gBeS
         7WNwC8G0mlZSvDgLhe/Q8FAMMJoBQHesGgOpP5oFSxb5oFPztXmsrwvAVxL2BqwAMZB+
         M49mCc1gPulWhbTpSFBOGDmprVcCg16Pgg1IPLxkXK/dLFQgs6frnzN83ICk4PnVBTMn
         KS4zTKWFzOsGEgew09b1t12/+kVg+xU0LTl+H7jmXBQlkoqWiGvz4PKP6vMOwdItxgp3
         PqAA==
X-Gm-Message-State: AAQBX9dXzucZAJpYp8lW/3DfmYXH5pKm7tWiTjyaGvNnLa7wasBVCoxu
        fZH5rguXtsY+yYjw3tEeoPcUXVtbTUlWjah+F68=
X-Google-Smtp-Source: AKy350ZGOH1r2TR45VfWV2od2G/Ji8hgepC6X5ocMh0DqB5S0FwAv+NEeSeYhcnbc7sH0UQh5vkSDVVE0sFSsnlibJQ=
X-Received: by 2002:a2e:b61b:0:b0:2a6:16b5:2fba with SMTP id
 r27-20020a2eb61b000000b002a616b52fbamr1509466ljn.1.1681874215477; Tue, 18 Apr
 2023 20:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
 <20230416054735.3386065-1-newren@gmail.com> <xmqq5y9uo4kj.fsf@gitster.g>
 <CABPp-BEmzofRAmgoz7Wam-6btCYCTy4CiVnTOtr9aQdjS6TB7w@mail.gmail.com>
 <xmqqwn28c3dh.fsf@gitster.g> <CAPig+cTTTNO9e3X5u8irHjGHmY5t3GA1_zrvYmfhETn312XJcQ@mail.gmail.com>
In-Reply-To: <CAPig+cTTTNO9e3X5u8irHjGHmY5t3GA1_zrvYmfhETn312XJcQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 18 Apr 2023 20:16:00 -0700
Message-ID: <CABPp-BFnPUBBH=KJmtkxTsi_AuZkx0UmYuh4QvcrfYifhULNBg@mail.gmail.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 2:25=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Tue, Apr 18, 2023 at 5:06=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> > From: Elijah Newren <newren@gmail.com>
> > Subject: [PATCH] protocol.h: move definition of DEFAULT_GIT_PORT from c=
ache.h
> >
> > Michael J Gruber noticed that connection via the git:// protocol no
> > longer worked after a recent header clean-up.
>
> A link to Michael's email might be useful for future readers of this
> commit message.
>
>     Michale J Gruber noticed[1] that connection...
>
>     [1]: https://lore.kernel.org/git/5d4e0ce10f537b4bb795a70dd51db12ecaf0=
206d.1681556597.git.git@grubix.eu/
>
> > This was caused by
> > funny interaction of few gotchas.  First, a necessary definition
> >
> >         #define DEFAULT_GIT_PORT 9418
> >
> > was made invisible to a place where
> >
> >         const char *port =3D STR(DEFAULT_GIT_PORT);
> >
> > was expecting to turn the integer into "9418" with a clever STR()
> > macro, and ended up stringifying it to
> >
> >         const char *port =3D "DEFAULT_GIT_PORT";
> >
> > without giving any chance to compilers to notice such a mistake.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Perhaps an additional tailer would be appropriate?
>
>     Reported-by: Michael J Gruber <git@grubix.eu>

These both look like good additions too.
