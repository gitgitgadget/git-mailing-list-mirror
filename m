Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99144C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 10:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B4C60FA0
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 10:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbhIMKNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 06:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238155AbhIMKNa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 06:13:30 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE0DC061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 03:12:15 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id d7so3170029vko.6
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 03:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LM4aejHK6Vo7OrpckF/sLKR0c2HbnQP3JxByms7qpD0=;
        b=EB2SpaXOPPiNYdw/0my33DkMbdAXPbn9Tg9L0BtmiSdzkEBLLPBhqawW+dep8x8IKI
         AFTp3Q36gsQe5fJH6nNVulFgXTrVjw5ZfW7iVv3r471nRyGNO3lkICK4NCH3wtxE63wk
         55DVGgrMcuCSvhugQkTP9PXI1iS09ER1DqJsNywjg3fQf6WLxCZCnMvieC1ckcS1/hGX
         EGPuoAE+8ik2ett74FF8g4r84uktGB31dgQMF0lvcOek2Dt9DowlguU7uno/ciuXFvQN
         VnV+y4PFN63+y9g6/xQ94DayE1GB5pEYKatzvu34Xv2xDY9P7Qaoijs/Jefzb7XVpoNG
         jcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LM4aejHK6Vo7OrpckF/sLKR0c2HbnQP3JxByms7qpD0=;
        b=YSVfmTFsbPuCUPxbGLtoUFa7q2Cv9cJKNF+PnyFPXF3m05qXo0MdTk+QGqm42nEnko
         axWSoVz+KYdZ/m/JoMRXl5ddJ8INuFRil0D3iDVczrwJJGuNKAFrKryPOU902bWH9Vam
         7bq7yHDK7cUb3DussQqkOVQ7RVvDxuDS+I6PjYUIWqCFaYitCzsv1ipjqvK1KU6fDKey
         fEjU/1Tk5MSz/VVGBXhIR7ceGgXpwSb0G5tGFu2gWxLqeOlQymj4zX8LYXduzEsBGaex
         ChTy9ZhEalX09I4FmsJpZ00Ix1lSaUM4xcndYYqAoEAO03mXGULqepeHdy3wbUMIiMwT
         7sCw==
X-Gm-Message-State: AOAM530ZtA0aWzAS8tnaxARlnG7i7Dz6UGf/Ak+bF6KYBM1iFC1+Ugj9
        ovtYRh2JkQ5e7XYxx0YCWUlIfQQV7IrUrLCg3RG1Ag==
X-Google-Smtp-Source: ABdhPJyqC8DZWujQBcD1SmWfqLEyOWT+FVL5+S3u/a+tMdxxrVdN9gojvFZMzt+nColmqLBiXR3D1qoIMNqqdwfa48A=
X-Received: by 2002:a1f:7c87:: with SMTP id x129mr3786407vkc.21.1631527933994;
 Mon, 13 Sep 2021 03:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <ea424e3d-6269-f50d-1a4a-643bb95cfa12@web.de>
In-Reply-To: <ea424e3d-6269-f50d-1a4a-643bb95cfa12@web.de>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 13 Sep 2021 12:12:03 +0200
Message-ID: <CAFQ2z_NAXsOzbWujpm=jGxODJi+xsC9iFYd-W+dTqn9j5DybjQ@mail.gmail.com>
Subject: Re: [PATCH] refs/files-backend: remove unused open mode parameter
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 9, 2021 at 11:46 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> We only need to provide a mode if we are willing to let open(2) create
> the file, which is not the case here, so drop the unnecessary parameter.

I was #today years old when I learned that C supports (a limited form
of) function signature overloading.

LGTM

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
