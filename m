Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D63BC433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 15:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244611AbhLWP6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 10:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhLWP6R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 10:58:17 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6A5C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 07:58:17 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id i6so10683953uae.6
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 07:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XAaR2TphAUjaXoalz8vShysblYyTXN9p/ztuuuL4G7A=;
        b=I4WB3hRRVWFE9Ew6LVfU6S9ODKeEW50veXpPIUP2/SQrKI53ZiEnwDL5lNpiWOUute
         pvZgJ9ewxp/aNRzQSZEWnaCLhBIk4SK9ArhL7KD9Uvx4k/TuD8n3Jy/MrkZpn8f8E1bS
         rxuTdAG/h5IHv8PK3O4sxdaRI6AUNJ9Ae7ZqhTT57vcpNedlK/72OwUj5MrXXfXwUMtI
         iLu59gBQ9QeDshs8Y3z9RUALmJ3i8rE+IfifA+AoLqifICexDjVv0pA+gk9CbmxI+DOq
         Rl8wd3leCu/mFQtQG4yBQpCeM/heWVMnGbIbti7aNOOVoBWdpa+a3qnC8RHthYI9wsCi
         5PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XAaR2TphAUjaXoalz8vShysblYyTXN9p/ztuuuL4G7A=;
        b=BB/ed4JbjzAaEf5W7kex0tscdwlIWqCQpDNDZk7C3yniNoRhZRS5UM1CGcY4CqZjec
         D+WCd7vJ1LVRsFJOpciyNi9N3JzQ2yGJIU+lEsd8V0hkV3ap96+gPFeU58W8nvQ3V5gt
         L4o+fMwmFzR6uwKbaLxfXy6J56JpQhpBDLQXpBydyntZbnRFGR2arQuvpM4iDBv8z/nU
         T92biq0UcXzIQnRtn01FtNTHLZdWbVggFB1kX/RaW9M6yBgYMx29xw05nL0T6dVtxF4V
         3nkGYLZRkP+VSoa5PGItQnqjs4TT++xgyYERxiz8GYv/x2bszZFtK6VPjezzjKhtpCBc
         JMlQ==
X-Gm-Message-State: AOAM532zpyJcSFr/AQ+tsuH0gsJDUPHmeZUlFt26pzxuJTURucL+sIUf
        ReVdR7feJaroEE8kuLq4fbG1Fx9ZM8hPI3F1lmUOAA==
X-Google-Smtp-Source: ABdhPJzRCDdxyF1o2JpQ1U0BA8YOLosNgo/LCD6DgXmi2wlywrOP/35bHUcFv/HWP1TbDvbW5/0Exa4IvDX/19Vnm/I=
X-Received: by 2002:a67:e15a:: with SMTP id o26mr959706vsl.83.1640275096729;
 Thu, 23 Dec 2021 07:58:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
 <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com> <e16bf0c5212ae85daa0d6aa2c78d551824b542bd.1640199396.git.gitgitgadget@gmail.com>
 <xmqq1r24gsph.fsf@gitster.g>
In-Reply-To: <xmqq1r24gsph.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 23 Dec 2021 16:58:04 +0100
Message-ID: <CAFQ2z_OXPw9-hLsaD+E1nGESS7eJH5o5sRrr_R_vW1Oa-vvZoA@mail.gmail.com>
Subject: Re: [PATCH v5 16/16] reftable: be more paranoid about 0-length memcpy calls
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 11:50 PM Junio C Hamano <gitster@pobox.com> wrote:

> > -     memcpy(r->hash_prefix, key.buf, key.len);
> > +     if (key.len)
> > +             memcpy(r->hash_prefix, key.buf, key.len);
> >       r->hash_prefix_len =3D key.len;
> >
> >       if (val_type =3D=3D 0) {
>
> I am not sure why any of these are needed.

I'm not sure they are needed, but IMO it's not worth spending brain
cycles on deciding either way. Checking the length is always a safe
alternative.

I would support having a safe_memcpy() that does this check centrally
(note how our array_copy() array function also does this check, even
if it's not always needed.)

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
