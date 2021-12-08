Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC866C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 10:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhLHKd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 05:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhLHKd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 05:33:56 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A62C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 02:30:24 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id w23so3837038uao.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 02:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iGoU8bZy2KDbwX+wIqnoWCiQwut544Ps/R37a0f0FTU=;
        b=apAe1OR7mT8u0YShatHy6UgJAjW4jQPfufHCtmJNnILrk0yuLGlncc/o7oa6F+KUe3
         XCFsQZVcopPH9x4SAoN0qS9VfBMN5SiD1uaZ42lvfKb5z+ULa93Jstb6u371XY1OHVjj
         DwuzSmVp3U6S0i6NPwg8iOrQxG/tmZG9M2qlLk7VPvKA0QfU0McezOO2IxJp6zCR3HKk
         I3qy3ngNMgM4TBeVMfoUaw7OA65NvtvMpD+UKpRQB6VttSX/hzsniekYT8LREW2WaD53
         ozuWMwZHLbyD4PrCcxn3xUKb3IUTb/x/oA/wZXS1sX4hX25/S8sU3PJB8qGl/DDdD1uQ
         lYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iGoU8bZy2KDbwX+wIqnoWCiQwut544Ps/R37a0f0FTU=;
        b=qFC8mJvsMDddN12SG7HdeAr/hybddqss76g+WNeDHAzAki+0wI6wjZMZaDWXx02QEv
         xwtCtcupYSw0XCBpU1x9S3S0N0nwr/ibF6zz+/JK4NRkWl2KTtMBiw/eLoz9vJsvmjrW
         nWt0yBc/83WFKYCqFM6EuzgApw4JGJeU4KGYuiNC9ICON9H+a6INvlQUjDaCwAh7PGrQ
         mEYvSgIAsVaKe/x66/bB0SApNRcmD0NrVf9/rcnx96+NOT7pkvDsAS9iLV6YgNzmpqNd
         i6m6SmpIQTCPpt5DAffA4eDAk7wRkNe3A0uhDgUKehDXNr4bATUr8SKVr5yJgDzsbyPd
         0NjA==
X-Gm-Message-State: AOAM533GHE3XELnSj5wttT1NNBebGBlYpXoJPhAYPztnQgyGaCD5lt4Q
        hlMXfvBqlZSAiYKwvljWE+ZSQfD6n+CrJ+mcfcK20g==
X-Google-Smtp-Source: ABdhPJzJl5EH+rbcco1INcImI9OryAe78frvkJcxVqLTJGEqI1XEwZ8//W9kHBhiZsCU4at50uKBecfufgk59SefI1U=
X-Received: by 2002:ab0:4465:: with SMTP id m92mr7398067uam.47.1638959423490;
 Wed, 08 Dec 2021 02:30:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
 <xmqqlf0w5bbc.fsf@gitster.g> <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net> <xmqq4k7j68eg.fsf@gitster.g>
In-Reply-To: <xmqq4k7j68eg.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 8 Dec 2021 11:30:11 +0100
Message-ID: <CAFQ2z_NuOy+-pfSoNAYjJhS9jZCYOfoFue10=k=iyPVsPYrB3g@mail.gmail.com>
Subject: Re: [PATCH 10/10] reftable: make reftable_record a tagged union
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 5:13 AM Junio C Hamano <gitster@pobox.com> wrote:
> >> error: ISO C99 doesn't support unnamed structs/unions [-Werror=3Dpedan=
tic]
> >
> > Hmm. It's interesting that the regular DEVELOPER=3D1 doesn't catch this=
.
> > It's because we don't specify -std there, and newer gcc defaults to
> > gnu17 (unnamed unions appeared in c11, I think). I wonder if it would b=
e
> > helpful to teach config.mak.dev to pass -std=3Dc99.
>
> FWIW, I use -std=3Dgnu99 as our Makefile suggests.

I understand that the default build should be lenient rather than
strict for portability reasons. However, it would be good if the CI
was strict with this.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
