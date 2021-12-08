Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C76C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhLHOvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 09:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbhLHOvw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 09:51:52 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98E0C0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:48:20 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id 30so5044623uag.13
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PiDintoIF1H3h8ufbO9h+JajoRD9sAWwNW3GzgWd9I0=;
        b=hCG6WVSFiqWvnv6hip8AiQUuwKiu0SIccjTzh6bF3jNtLd28PPYoQc8JJekl0b6XDG
         Rlzqm/SQbnC9+ndUJRffjpwqakYb9IgzkZMz05jXilpglxOP4lNjAObd1Kqom8y5mV6i
         WwAj4XDX2mFuOIGq2xEhDphfHYv0ijJMPk7QwmUquulsG/A2DwVfU/cQDtD0BlKFulGi
         +NksttYxqg6H2J+Rd3WJ8NeZcCroJNd6eA1GjCSFPxepxID9MaQaxDX80TqTonxoItnM
         JyWpy2ntu0vS/7IsQ6Es+VkwV9Ik0qBqIG8USQSS36e/QIoOX3SAh+Dy7kfKUPmK5PIo
         ekmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PiDintoIF1H3h8ufbO9h+JajoRD9sAWwNW3GzgWd9I0=;
        b=zODAHIeoq6oEp3cCGupbW00ZwnA5h6IV1LPdsYhm1w9ZFhr7nBBCPbb1rC9YV6TiUk
         pOe9RGkhbo2+VhToCYy+k0rDTodnFeYcBRWeIYHxJ3FhkQGmVD0X05g0iNZKH1cNvn16
         TZDMnftLTEAb7ot8Nwwv54Ll0WNdqA0LPfje8OI40lAvlfQVfsqbiE1w+SvGx9sgh1pc
         0a2/n7kGK7khTGtojmeVdLgPVz419ys7Yd+3j/A4JxuEPLC6EvZ1Xh5//QUsZXJZjVCK
         4F5nSPlZqbtlUsU3Jjz8aWcnl8DT9GEciO1an3C5r1GfyiFgJXyz2faIfnwX3rk0liV7
         /dPw==
X-Gm-Message-State: AOAM5333meHht3eaydLy4ZhKNd7vJS5mi7wv01Ga2xp9FITKoqhGFE4h
        /dWa5cD2aLiMR9DsuMbFhKiwvIYjq561RJ1h/3VU3e3xXFo=
X-Google-Smtp-Source: ABdhPJx4kxTFmbCxC+Lc7yBkn3cIuHO4zUXSajgIT1mow4uryUCaEEkAUgWctXk8ICg97e71QlKDZXLX9dy3fsANcR0=
X-Received: by 2002:a67:c40c:: with SMTP id c12mr54938242vsk.16.1638974899960;
 Wed, 08 Dec 2021 06:48:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
 <072ff09c-9174-e769-7ebb-4bb248199337@gmail.com>
In-Reply-To: <072ff09c-9174-e769-7ebb-4bb248199337@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 8 Dec 2021 15:48:08 +0100
Message-ID: <CAFQ2z_PmwLKC2Y39yj2Cqk=FMGC4gJTgZUEFOmgC=wE2KmdTfQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] reftable: make reftable_record a tagged union
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 3:35 PM Derrick Stolee <stolee@gmail.com> wrote:
> This is a HUGE diff, especially compared to the previous changes
> in this series. I recommend splitting this out into its own series
> and finding a way to break it down into smaller changes.

Would you have a suggestion how? The reftable_record type is used
across the reftable library, so if we change its definition, that
impacts most callsites.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
