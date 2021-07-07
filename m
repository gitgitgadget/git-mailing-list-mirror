Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6FEC07E9B
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 11:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D76661A2B
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 11:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhGGLty (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 07:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhGGLtx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 07:49:53 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9248DC061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 04:47:13 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id s13so689312uao.1
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3TS0xfc4JvIWe8bqFaDLRUwZsTDQ+4CqCoQ6FGfnG14=;
        b=D2KD2s0X2x8v76XAwB51RC6m7chC5fp0iwqXz34VjQSdbiXvpPGcAvi/PIg/YZBLvF
         VZZDwVi2vwYYIrSQsFnYsYcQnOa4C4cm7buI4+5bdyeqLJ3UmX8bA5wp4dr65NBQ6Fda
         spzGkSEGiLEhKmzhAVIZUDwuszvYBEOhMoM+h/NSsD5e37a6OQMGSS+iDLl0I3zpT1fT
         mwKaNFNDC8bhjPJxuVqRiBkbNGO2+uWuiovJYfbxD++/JmpgTzzKw+LeNoTEJC1WI1HB
         5CKEMTDcKEqyQNvNENDOrVM3pW/6pTOi3/wD/d/S3GRbDee/8eZ5eoKyVhZWrPF+uyOV
         Oi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3TS0xfc4JvIWe8bqFaDLRUwZsTDQ+4CqCoQ6FGfnG14=;
        b=b06awo32tHKpvwql3Jtid6ylBqsuqOGzYVoWew1e7VPIZPQd58uPu6JqHB70Kupa/e
         i1ZmjHtfvyRmG67ug6e4zttUF/eCoVyH55d6C8vLNYxDDOhq48PzNzwxYQ7sDlBxviln
         nwxHvE8yXDum1yQjilN6kc4KokcqGHVFCsd4MQtobwtIX4QHGW+8OX9YMc7qWm82QIQO
         z7KjWu4QwRXGZ22ZvXyzSfiqZG5ZZ5oAJ3P4ZtoAQ2QHLQSmDvYmo7jWgHQU4YaTnHTb
         JfSSzC1/L4unCWzFfNoacS/BmGtYZ+DtCO0P+lr0RP6YFoWmO4l7tL9RIyzVqmf0ZXEu
         3SOQ==
X-Gm-Message-State: AOAM5303v1+y+WiYi/guU7/SokpEvtGdPmHf69iBcBjcKZgObiRSchSB
        x6RHN2TKAsyP5QbPtmYdKVF+6RHD+faO8wfc26EKSQ==
X-Google-Smtp-Source: ABdhPJyaj2ytFpiOV/fxO8viq4xu4jMaO5vwKImGJFmj2puKI38hzMMIRyow+Da3M6fVTK3Q51BqXG9HNc1U+hzCkFY=
X-Received: by 2002:ab0:76d0:: with SMTP id w16mr12584108uaq.15.1625658432582;
 Wed, 07 Jul 2021 04:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.3-00000000000-20210707T103712Z-avarab@gmail.com> <patch-3.3-46c65a7ae12-20210707T103712Z-avarab@gmail.com>
In-Reply-To: <patch-3.3-46c65a7ae12-20210707T103712Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 7 Jul 2021 13:47:00 +0200
Message-ID: <CAFQ2z_MWMokX8hXdOJfiL9Yn=F-QUWe5VHXFEF5DoSBBJu=dmw@mail.gmail.com>
Subject: Re: [PATCH 3/3] strbuf.[ch]: make strbuf_fread() take hint, not size
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 7, 2021 at 12:39 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Change the strbuf_fread() function to take a "size_t hint" instead of
> a "size_t size", for consistency with e.g. strbuf_read(). We can then

Making strbuf_fread and strbuf_read consistent is weird because they
do different things. strbuf_read reads from fd until it's exhausted,
while strbuf_fread reads up to the size specified. So the argument
isn't really a hint.

shouldn't you rename it to strbuf_fread_once, analogous to strbuf_read_once=
 ?

bonus points for making the argument ordering consistent between
strbuf_fread and strbuf_read

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
