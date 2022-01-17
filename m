Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A8CC433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 11:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbiAQLhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 06:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbiAQLhw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 06:37:52 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B41C061574
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 03:37:52 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id h11so29850104uar.5
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 03:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rg/ktIQabsAX5oX2O5mXkppSQ/ORC5OdApWokG1/giU=;
        b=LXBOiOSifZkR5b9zCUBpt9OlHL+EIPamPI5EXge/+gnpMGuqYYx2Ig4MfIyKMo0AeH
         2M8991fCizqA6LZeVksEeRmOMh+/hKoQIVePqGGxpBVzpyY6iciNRkmJcAq4+5RbXRJo
         uqdPWJrHqYe5HUSXiFoJPenuatrYr6fTXjveMqVN+S3NM9Awg/cVmk1Czrf/DfqdRs+a
         xF4S43f7LLUuiFTC/Um/Iko/py0WsoXksTmBAjbqwHttLH1ze/+ZSxKXteBkOojz/+j+
         nkydY39niEDbVdH7ckbREiUF/CvYxY0I29uHNiq6oNZvA/3SbRNSK0bnlxzTwIcQ4u0n
         j6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rg/ktIQabsAX5oX2O5mXkppSQ/ORC5OdApWokG1/giU=;
        b=3c3l+z3/V1TNz88OtFWU8RTm5i5JOPnv0J+pnSGf/g7kKCWlllMNudW8tVoS0/iGAu
         DqG7rvbuYs01t0fvYswjUOi3Az4rVWkULWZdTCb4b3IF5dY+R8BBEyLg0fMMaASsUwos
         0/RGBRaV59g+mjbfZFIwpjEgoqMYxUhu+YFb30QkUWYasyCbKD2GLh6n/4X527QJymCF
         zGhY+SCL0AU5RjoYb1rWMfvnUvcnvRghSqdmNXLj9WsnisnLono/R1nNqDHhjBwJRCEW
         LbMpojkCwa2wAmwKp/RlbKfvbqLaPiptfPA2cgeDFH7cMuZPp2iAg0AVYyEITjvKDuN5
         gsVQ==
X-Gm-Message-State: AOAM532FURGDMaSGWk7n2nuaLB9TOfatzAyOSZ5E8052IDmpwRZKE3jC
        xY2Su3yVWGl49VlRbDlsWs5uvagg/Pf9dEHUukT/vA==
X-Google-Smtp-Source: ABdhPJwxBIHKfQEqFIZNu9JQXISGoaYCP+u/vdKVuL+wUG9JCuhGkRfY1WaGa4IVb0jNqa31dkW6bCVo+8rwvngvNxk=
X-Received: by 2002:a05:6102:2451:: with SMTP id g17mr7464009vss.8.1642419471011;
 Mon, 17 Jan 2022 03:37:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638874287.git.ps@pks.im> <cover.1641556319.git.ps@pks.im>
 <xmqqiluv6vim.fsf@gitster.g> <CAFQ2z_P_SiaDbSQdAt5mSp79BnC0-k5B+X09oCVh+w--BO4_6w@mail.gmail.com>
 <YeUYNhJemN/hRG+6@ncase>
In-Reply-To: <YeUYNhJemN/hRG+6@ncase>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 17 Jan 2022 12:37:39 +0100
Message-ID: <CAFQ2z_M+2D-5qPXN=0FEveZ36Yq0rps3HxRkgCmiupq1DD7Kig@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] refs: excessive hook execution with packed refs
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 17, 2022 at 8:18 AM Patrick Steinhardt <ps@pks.im> wrote:
> > It might make sense to not introduce a new flag namespace, but use
> > update->flags instead. You'd have to add your new flag after
> > REF_SKIP_REFNAME_VERIFICATION.
> > Bonus is that you can unittest the new flag using the existing
> > ref-store helper without extra work. (check that a transaction with &
> > without the flag works as expected.)
> >
> > other than that, looks OK to me.
>
> Thanks for your feedback!
>
> In fact the first version I had locally did exactly that. But I found
> the end version result harder to reason about, most importantly because
> it's not a 100% clear to the reader whether all callsites which delete
> refs in the packed-backend via the files-backend are adapted or whether
> any of the callsites was missing. By having the flag in a central place
> it's immediately clear that the hook won't be run at all, which is
> exactly what we want here.

If you do it like this, can you find the callsites that take update
flags (but not transaction flags), and update the signature to say
"update_flags" rather than "flags", and document appropriately?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
