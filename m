Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15CDC07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDCDF613AE
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhGEMhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhGEMhI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:37:08 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65BDC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:34:31 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id g21so6930545uaw.3
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2rXGlNCP8PkCPVIzjsJocFYGC1SuRlPyuTcTkwqRrYo=;
        b=wD/mNcE3l6sJi8hhiI8Cys+OhBwTKztXAZ2Iufr5jgk7CDVx2Ksph+i0w2AC8SVd35
         aZCWB6QsGZgsnwY3W0CDrt9yh62sM6OhIFYVwWCMGDGlhLlYTZA7yX8xxXBwxQR9Ykc0
         PvlXfcGE5mVAUjcgAsudHsvlLazBXeRxer5zC6RrOcIAxlDCVvJCyQyserULR/D8RoM9
         sNDuI6c6GxjtaXP/Mc4Zh8llrweG4n6QEK/TQIG2x23Ct2OXtarpilnhQVhD7/2VqCBI
         CKn9KwkA/EIyYvR3rjwf3GnoPED9igoNPg6ZCdPXljEBj5eGhZFpbfVyxz7zDI216ljl
         S8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2rXGlNCP8PkCPVIzjsJocFYGC1SuRlPyuTcTkwqRrYo=;
        b=S4VznPBYI6wRSuKZttXxZCZtRPkSTCeYdAflaf1+XWw0QMRSHoiM65K0HV52kqUV31
         3HVFzFZaxcbX3JrCd9izAyNT4FAAeuQhWLuaEcxdyWXmz13Erc+Nm5LqW3jHgJySOYUY
         e2J6skJl/xM8uGjYEX+2VkVhToWVB19L1DKqNz+Fg2X0CojlL9DPwhAekWpQMKyc/TfB
         T5URQmqFQu6Fbs22ayj0m4TKQIky5MaQFII/TizjKNS1sCUnuR5ue4oeK1zvhECM0P+i
         RRFOvx6rrgDS6RF3wbayJlof03guYhjPfHaOidKQDQrNSghCkXOdWZFFIHt88oSr4sme
         KJOg==
X-Gm-Message-State: AOAM5313gZB0HxVklClZnt943jW2unWj9exWODSMZXkJ2GEbc+u4pdNh
        OTpvQj3yKj7uGHnTcXKMmAIrJSjtJD+CIidi2s5SJA==
X-Google-Smtp-Source: ABdhPJzJWtFEuyOwmFtBKqFnveV+YeRYCkN3IqMBDCmNT2Wl8PzxM4IjPEgb7s5RrUd9fXTcZplfD80GDe/1yI4Yu+E=
X-Received: by 2002:ab0:67cf:: with SMTP id w15mr9891820uar.80.1625488470832;
 Mon, 05 Jul 2021 05:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
 <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <patch-7.8-0a4fb01ae38-20210628T191634Z-avarab@gmail.com>
In-Reply-To: <patch-7.8-0a4fb01ae38-20210628T191634Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 5 Jul 2021 14:34:19 +0200
Message-ID: <CAFQ2z_NyGb8rju5CKzmo6KhZXD0Dp21u-BbyCb2aNxLEoSPRJw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] serve: add support for a "startup" git_config() callback
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 9:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>  /* Main serve loop for protocol version 2 */
>  void serve(struct serve_options *options)

side note: this is a very short name for a globally visible symbol.
Would be nice if this were something like protocol_v2_serve_loop() .
Then one could drop the comment.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
