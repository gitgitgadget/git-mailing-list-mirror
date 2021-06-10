Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C975C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0883F61184
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhFJKI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 06:08:29 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:42756 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhFJKI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 06:08:28 -0400
Received: by mail-vs1-f51.google.com with SMTP id l25so1532694vsb.9
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 03:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QXT37WOe5vcecXFYqWiQ7mb2PHyWdIcKKS0prMl9eyw=;
        b=m9rCcgxXNh3+WFkwhoaK6agQsTdKTe33h3Ao/G01fGX1ep/4hf4lVDAmLF5uUgQ4WN
         Odu9BCgNIiHozh8uMBQeRc/VB4e5mgFE6pNsysp9bEKICFLQubRm0i30c8G/GrBskLab
         zzBJV3yx6GY57BolMxrotjIlEWDkZsOnoGnJv2KC3/Dy8ikeS3zCaXJyFeOMKObH14UT
         0K+8dJbOZX50mgLf16TMAGNwwiKfiyeycWh3rxgVqr6JDxDfM6vxUVJ4vSSQ6xFCStgQ
         NmmSUzJsLdRvTHxzzEA/NZ7APPvT0rAsW5h2b40+S71totZLOaxDDXcx7yoB/aI3Wha9
         ysJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QXT37WOe5vcecXFYqWiQ7mb2PHyWdIcKKS0prMl9eyw=;
        b=rAJldBXwO5CohnUkm6w0+PQ3G4O4L2ERP96G4FT8tQRcn/BN4r+7oH2yk7WyuBQ5dT
         HVrZe+SH0qCq9RgvzP9My9ZhaltxggKBAryaUzK3JLRPa4GWlCEw6aY44Rny27drCMgT
         EalFHsw3KHNBvoJAKkB+pUAlxI1DaKEqvR9iO3ryWoBoj1XbgLfwg4gZXdDjVE+LyqOi
         CMpcv9MCFqP9dAUpcGhsPbUn+EKiSmhepUNFl632wODYQUf9lo350GF66QnaAmWoXXi+
         mvd0OgixpdploLTJ3xSZsQM+4BMcL4ZRhYI7gQ1vpd0WSldgjWLSzN/1hH0GD8E/jGZ3
         ZN0w==
X-Gm-Message-State: AOAM531Qq69Oc5hBE3UZ0VmkVBkLK+iAOdEegd4IiIAfUQXJtcb2UW0V
        j0TUbfuzMVCAa/NZjrfqZjANMvFBdYTmb9jVe0ZfBQ==
X-Google-Smtp-Source: ABdhPJx1maD661oEGHiYkMypZOqttrdrdiZa4uIA6g9MnCxJ2UQS9+4WCerRE/CSPP8ifFk+ldABKOcmeUjLvbTcQrE=
X-Received: by 2002:a67:b24e:: with SMTP id s14mr3180118vsh.28.1623319532211;
 Thu, 10 Jun 2021 03:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <ebd7b8380bf7aed84d23973a4809d1441aa21692.1619710329.git.gitgitgadget@gmail.com>
 <20210603023709.345324-1-jonathantanmy@google.com>
In-Reply-To: <20210603023709.345324-1-jonathantanmy@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 10 Jun 2021 12:05:21 +0200
Message-ID: <CAFQ2z_N--3UeLFg7acPX6pmvvoRs0oKyBUE3zebb05G4m7_a5Q@mail.gmail.com>
Subject: Re: [PATCH 3/8] refs: make errno output explicit for read_raw_ref_fn
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 3, 2021 at 4:37 AM Jonathan Tan <jonathantanmy@google.com> wrot=
e:
> Should we initialize "failure" to 0 here? As a reader, I would assume
> that "failure" has the semantics of errno here, which upon success, may
> or may not be set.

Done.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
