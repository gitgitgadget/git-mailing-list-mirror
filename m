Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCC8C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 17:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbhLHRzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 12:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbhLHRzm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 12:55:42 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EF2C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 09:52:10 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t18so5405178wrg.11
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 09:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Irsw8zuBfhQEpJ/UQ0cN8wfoydSiNovwmehPhxa5Ylc=;
        b=k8XsdFyRJhQPK8m4QxAHu3Y0pKG6tmCHtEC/TkdMaXKAlokUHSXhNojXs78No/nkT7
         9h2KK/W4ZfZllizDuchJ404DQIxK0UzgCKtrzxfTqJrrNByTam8yxejgmTCbs33JLOOw
         E1wUpSFA980z/GAXQVGAQswvGQaPzgt+yymlmf9mi6wnWExckEqX0xUKJNS56/9Ytfv+
         Fsdx4WnWKL25jRUE04GmMV9bhZG+v8U+HOQO46KdnqdS+vzo3lkdt9tDSNhSwFVlcO3R
         zXInWriDgA8sy8zUpvXK2Nu3ZoeVw9753oHjwhewo1rIR5QRQjt4aEsY3L0woqgUjTw6
         vVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Irsw8zuBfhQEpJ/UQ0cN8wfoydSiNovwmehPhxa5Ylc=;
        b=P9mk3fawIzihkmViWZGovy1sMOTfqiq5XOT4DV+BeacWuSvdljYUpAmEmDW5LY5w5X
         b/AOg3qHd8whE9DGRocD3QN8zoUyqzh9Oot46xPdvF8e+doGIrgw+vOhoSRbk1/rDqm+
         oAsTpmBDt5BE+QaINOkGO+keKqVLooUuh6jNG3wOVzNIriIC7+e6mkiYfLtuVmsXSiBh
         Pc3BFsVXgEt8GXFbx4jYKp/ImSvGJ76nUzMNujsac97ZEqtGDVo2w5edD3YpSfJoVmxS
         WK4tMYQsrBjn8bYEG+JD2QoJmbuwN36q96vYkD40kI8/Gm4+VJs0Q48ge/0+ysF3L/7R
         WliQ==
X-Gm-Message-State: AOAM530qWSQaLtSkBSQsWNdcksAhZ8w/Druno6vfeNUAB++/bsg8eVu9
        Tpz+PI+xMhhwL3QcBtgfWviu9/ZT7NZxhc8XTV4EXg==
X-Google-Smtp-Source: ABdhPJzsrUrsIWs9HxxWk9X7MZd/n3CHsBrYR+tY7lA4Ud7WbKgChEK12TOxeiWYnCboinm9xq/ff5t+7X6rExaimTo=
X-Received: by 2002:a5d:4582:: with SMTP id p2mr221294wrq.364.1638985928702;
 Wed, 08 Dec 2021 09:52:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
 <072ff09c-9174-e769-7ebb-4bb248199337@gmail.com> <xmqqv8zz2ge1.fsf@gitster.g>
In-Reply-To: <xmqqv8zz2ge1.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 8 Dec 2021 18:51:55 +0100
Message-ID: <CAFQ2z_OMK=w8j9a3BzQJxGQdc0RXY-zUoaBC08C-mjWiD+Vp1g@mail.gmail.com>
Subject: Re: [PATCH 10/10] reftable: make reftable_record a tagged union
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 5:47 PM Junio C Hamano <gitster@pobox.com> wrote:
> Perhaps reftable_record_for() can be implemented without changing
> the shape of the underlying reftable_record structure in an earlier
> step, then all the users of reftable_record instances can be
> migrated to call it, and then finally the shape of the structure and
> the implementation of reftable_record_for() can be updated?

We are going from

 reftable_ref_record ref =3D { 0 };
 reftable_record rec =3D  { 0 };
 record_from_ref_record(&rec, &ref);

to

 reftable_record rec =3D  { .type =3D BLOCK_TYPE_REF };

which is why this change is so nice.  reftable_record_for() is used in
just a few places, so it wouldn't make the change much smaller.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
