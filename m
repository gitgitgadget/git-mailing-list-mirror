Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1215C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 18:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbiAMSYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 13:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiAMSYc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 13:24:32 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15CDC061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 10:24:31 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id o1so12808075uap.4
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 10:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/TvLJE99MXqEEwm588FJU8lirHxQReEadRRTZLTt1p4=;
        b=n4lwh0sJrUcOAvaP1+7/AS+QI5ipXToCvQHWOfyiR5mXZMC/U2sa66DBXGcQGaWhuY
         odHwxw4g80mPNt3csx6qCcSDfJ3Kvm2JbWRZX5ZZUDFgTE/HpbdQa36s+wTjzhjk1dLb
         R1yhz0gQlXw4mB8Zvp3G+BNBC93gRwv9Ve/rqRRWDXUyJAEUyEZaNyvb8essepv+gCX7
         0z7XHwqNL4DyeVfnKV4W5eyW/04wJtnk5yItqHQHrz/QUru0SvLmG+Xk/3kcwK2WPRMI
         U1Cy2DAAwWvNe9HoaysUINU5ir8O9JDCjWFCLvf03E8XNuvMd/ULaCXsOv4wLNiwavwY
         kfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/TvLJE99MXqEEwm588FJU8lirHxQReEadRRTZLTt1p4=;
        b=uszz7aj9mYFT/dfKj8Aq2YKMOV+VtWe359IwGj2radrNgSJKNd3ID++N2V/KkOFO7n
         DyC08p/IeyxMqpmBieMOA+iLu3yS54kPt0fDJ1cfR/+s/xtxiUXAqvi41TYT4jyxHgzL
         fo+wypU3dpFr+MfxHhvybpsuYIlNxff6Z07UJ+UYlrFQHsIErpIjUMyyP8bYGY2Q2DYN
         QdypJNe2qpG1o0TbVOAGL80ul3Nlj6zF9A4Uua46TNXcwDWrdnBjzRmq+HzpIdJ99zrU
         bRi9WpokqXkdGYkjMhQjRDmt1Qa18zgvlZQ5cYB6Xo/H1Hm7JM/G5JpvwCfdS3aXzKlO
         4iew==
X-Gm-Message-State: AOAM5324Hzu8gCLZdhh4EGH9Nv32O+AhwDIunepYV3ZgblAgKo9PUGQO
        S/jHtKFWGsTIKCewQoJpENerSm7dQPW+Udy1KTalYw==
X-Google-Smtp-Source: ABdhPJyIcvB6NPohZiBKH5M5Z8T/kZmAUT9RSzYZQdnr+oeDa8HCswiuVAsjbm/JG+UajMq1fBGTb0yhhOJaSzXUHB4=
X-Received: by 2002:a05:6130:30c:: with SMTP id ay12mr3229281uab.15.1642098270939;
 Thu, 13 Jan 2022 10:24:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638874287.git.ps@pks.im> <cover.1641556319.git.ps@pks.im> <xmqqiluv6vim.fsf@gitster.g>
In-Reply-To: <xmqqiluv6vim.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 13 Jan 2022 19:24:19 +0100
Message-ID: <CAFQ2z_P_SiaDbSQdAt5mSp79BnC0-k5B+X09oCVh+w--BO4_6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] refs: excessive hook execution with packed refs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 7, 2022 at 11:17 PM Junio C Hamano <gitster@pobox.com> wrote:
> > this is a resend of version 1 of this patch series to hopefully entice
> > some reviews. The only change is that v2 is rebased onto the current
> > main branch at commit e83ba647f7 (The seventh batch, 2022-01-05). The
> > following was from the orignial cover letter:
>
> I'll add =C3=86var, who has been making a lot of changes to the refs
> subsystem, and Han-Wen, whose work to add a new ref backend may need
> to interact with this change, as possible stake-holders to the CC list.

Thanks for the consideration, Jun. As the hook is called from refs.c,
it should not make a difference for reftable.

I looked over the patches. I didn't look at the bottom change to
packed/loose refs as I'm not an expert.

The individual transaction updates already support their own flags, so
this change generates some confusion. Consider:

int refs_delete_ref(struct ref_store *refs, const char *msg,
    const char *refname,
    const struct object_id *old_oid,
    unsigned int flags)

how would one delete a ref skipping the transaction hook? It will be
easy for someone to pass the SKIP_TRANSACTION_HOOK to
refs_delete_ref(), with surprising results.

It might make sense to not introduce a new flag namespace, but use
update->flags instead. You'd have to add your new flag after
REF_SKIP_REFNAME_VERIFICATION.
Bonus is that you can unittest the new flag using the existing
ref-store helper without extra work. (check that a transaction with &
without the flag works as expected.)

other than that, looks OK to me.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
