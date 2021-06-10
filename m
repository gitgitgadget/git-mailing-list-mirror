Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E8FC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11F960FDA
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhFJKF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 06:05:27 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:43537 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFJKF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 06:05:26 -0400
Received: by mail-ua1-f41.google.com with SMTP id f1so1060755uaj.10
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T/MXoo71C1nB5kWH4xh0bd2JC/2ECQ/NC4zfcsHwEVY=;
        b=XmTnGFvwTmgB6M/JyC0+kB6UzBFL9HeiZXXcRjXUhjzxiftj9Tyt0xr6zxEmwyri21
         An4wB2Y8eu88ko7JerQoFMDjgUkamTXRrEdI+p+9uMkn2hTw0764VtBKoM0K7ClPU47X
         GrYKQsxKRTcta1fAHJMbiSVBXH6vGWHbCm6JnzwqS0NVm42QSubwXHFRrcfok+9AeYnL
         elky7t9QLJkEQA/A75rxoPpnP0gbm863Q+dloNKDsqNV5/9XrSQ5Oi0vLFfn2Qc03Vu+
         pdJabxGgPkJd5mbWuR6ekJrJN2iUx7M/5BacOWu83anCUuNid2GLuh6/W8Z4F/aaEMPq
         7bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T/MXoo71C1nB5kWH4xh0bd2JC/2ECQ/NC4zfcsHwEVY=;
        b=J9oWbjfF4PwIm3jMds3J2X2AgmiWOqUMbAuCm0ZVL+683WMAwzN71lsoldRY+v52I1
         3ibiETpT9gTe/O7ewd0Hcv29cmAlkQE3mvLw3PnK0wQaNl5sOPKp6Cc2aPykOFop6A1i
         sZDVXlyUdE5iwOa1qBjpJZFqOF8d0gxMLvElCDeehA4RfKB7FcIA7HxP951jkyNHv1zQ
         O3zBR1L1GNP7C3LdNswxSUa7LhZbkaP0RuH4axs+eMFJIuJ37lFsLIAht/xSdRpDOhhE
         jmD9x6Xtkwzx/p5EcbkLFuXQUixk5tTzouZBbZZ3o3pfFJhS+YEmBhrWqfM0kLMDuKDc
         zuow==
X-Gm-Message-State: AOAM531vOOZn/T+tmsA8GAhxvo/jgtBV4+2gela99F+Oa0zMdrQWGS8M
        982QbYiew76CVPqgU4bcqH5r/SohOmaT0Pc6DuWMfA==
X-Google-Smtp-Source: ABdhPJwMfHmpDmvuzY2aUVtlzm+KQUU4kA8++i4qjkeQkREkeUxuQdU5F/CEDucL36y7B4tFldARssBKJdTPPTgafdo=
X-Received: by 2002:ab0:30a8:: with SMTP id b8mr3288461uam.85.1623319338848;
 Thu, 10 Jun 2021 03:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <b2c72097e5e8985e7fdd8e3eee66cdf43d1b65c0.1619710329.git.gitgitgadget@gmail.com>
 <20210603023304.344682-1-jonathantanmy@google.com>
In-Reply-To: <20210603023304.344682-1-jonathantanmy@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 10 Jun 2021 12:02:07 +0200
Message-ID: <CAFQ2z_N5B4FC0z8_EHH9msBewQEZ1iyzgWbi7GJB0h9ztD-kQw@mail.gmail.com>
Subject: Re: [PATCH 2/8] refs/files-backend: stop setting errno from lock_ref_oid_basic
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 3, 2021 at 4:33 AM Jonathan Tan <jonathantanmy@google.com> wrot=
e:
> > Errno is a global variable written by almost all system calls, and ther=
efore it
> > is hard to reason about its state. It's also useless for user-visible e=
rrors, as
> > it leaves no place to report the offending file and/or syscall.
>
> I don't think this paragraph is useful.

Dropped.

> This is probably written more clearly as follows:
>
>  No call to the static function lock_ref_oid_basic() is immediately
>  followed by an errno check, so stopping setting errno is safe. But as a
>  sanity check, lock_ref_oid_basic() is used in these functions:
>  - files_copy_or_rename_ref() - here, calls are followed by error() (whic=
h
>    performs I/O) or write_ref_to_lockfile() (which calls parse_object() w=
hich
>    may perform I/O)
>  - files_create_symref() - here, calls are followed by error() or
>    create_symref_locked() (which performs I/O and does not inspect
>    errno)
>  - files_reflog_expire() - here, calls are followed by error() or
>    refs_reflog_exists() (which calls a function in a vtable that is not
>    documented to use and/or preserve errno)
>
>  So it is safe to stop setting errno in lock_ref_oid_basic().

I used some of the above text.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
