Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFE9C433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 12:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BE660FF3
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 12:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhDOM6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOM6u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 08:58:50 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B368EC061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 05:58:27 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id k124so12135785vsk.3
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PV322PegHPHaheWKXAk30M7/ng45fUsPoc3GWJWH7Gw=;
        b=CRbqIl4WLNXzwbH0230kzBM1tj78F49f0ZEWCCN88CR5/Wa8+RwnJtQFas4tIBGWfH
         ExWLOLvmIJ8EqnZBwx7EGaC0tMjDh7chWjtsDgL2W21xhdWFCBfPa5JxuO0Kyou70QKN
         IZY9WaECFngXaEocSXfLRciv3GFJx5fdMzKrELlixLHYES1kY1xH5M0UZxJSPIHfh3gy
         1mmsedRXqlsrN2QNlg1xHPmjZaz1PJfr8ihlkrRLHVDYxpUBkfeHrT0W6dcWOQ9Z2W5L
         ATzLttwSBhCgkdhgHr3SWbQkZdfaIYkNHy6OKzCDjyIe+P1vZ4vm6HDdzjfhBfF0ygqA
         npOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PV322PegHPHaheWKXAk30M7/ng45fUsPoc3GWJWH7Gw=;
        b=cKo4vGJGo2CunLHldoKu3c7mwI7GsMrV04auL+onO6t3rrPo85hNcTSOptnX9zGj/M
         /sF6K4TXaX77/ZXh22c/a0F031ZAUWouQ821KP+TX8MgCegAcJMnHiIv9Oqtcn7FTX4B
         lJKSbF39WZTgCoTYmhAUCjBWGuXLuv4hpQ+N5YGeDyTkpjXnoUkKdqzeP3Z/r8+Mut96
         Ilh9itt12fEcF5B1ey5sC/tn4XEqNQisKdIz7E/C3PCNLNXINFlv2Pl5Lm31DfV/aOag
         DWeUTCRted3fnsVDjQXeeQ5VPEHPqgKMNUkVyKWODnlvbJ4Vim+YgIAtZQtg7FbI271G
         rKBA==
X-Gm-Message-State: AOAM533A6vExBBQZgTE2VqA06ruYYFbkJxqGiEzWG235pW2BjOxQoeoZ
        rYAJ72qdZ5tKaakFp9QcYNCsc5wyJGK/2/Jbq6FIMbP8hwM=
X-Google-Smtp-Source: ABdhPJw656WHuTHZkJPcAijYsLeB5SBFNKmarAQ1/OSUST/dsq1tOIAWw/GJKpVDetF0dt6rixubn7DSJSA9g9Yg+K4=
X-Received: by 2002:a67:71c6:: with SMTP id m189mr1736856vsc.12.1618491506477;
 Thu, 15 Apr 2021 05:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmtu1zn3o.fsf@gitster.g> <xmqqim4owixg.fsf@gitster.g>
In-Reply-To: <xmqqim4owixg.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 15 Apr 2021 14:58:14 +0200
Message-ID: <CAFQ2z_OGmvywrxrMQ46avOY9vTK3dHh88Dsfw0Sd9uX5vvSm3w@mail.gmail.com>
Subject: Re: What's cooking (draft for #4's issue this month)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 15, 2021 at 1:22 AM Junio C Hamano <gitster@pobox.com> wrote:
>  * hn/reftable has a preparatory change to use oidread() instead of
>    hashcpy() in places queued at its tip.  This is essentially a
>    no-op in the codebase without bc/hash-transition-interop-part-1
>    and would be a bugfix with that topic.  Please squash it into an
>    appropriate step in the series when updating the topic in the
>    future.

Done. Thanks for the fix.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
