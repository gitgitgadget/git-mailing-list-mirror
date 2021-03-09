Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FD3C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5746764FF3
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhCIQke (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCIQkS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 11:40:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F17C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 08:40:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so5303605pjc.2
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 08:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EDgVu2dtSz7UcZGx2VswCIULyQVkiWznirrccFljwuw=;
        b=De0LZMuyh2yaJyUI8wwixg/J7zu9rrNot2lpNhKMSNxTSTYE750xaN5+IdTK3Rac7H
         xUVkhe8fCLG3mAPtI2FuAl3fTOq39QVR9hwkGLtE9TriD0TEXJ8/80ONelBeZ1jmFu0x
         cWvwGFrGebtfMGc2+TQp9mnrJ7k1bONAA2jUgP0ut1CUtHH4tVBlKAq/fjre6FfFj0io
         Gpp/lYF7iM6gN4xmUhr0P4OvJKXMwQYn3hOLxDqaCTCYueXnHUwHChP97A3RhqouAt7G
         D/VAugnMKn83JWw/4qbSuer+F4hRbieVZbzoEfhQ2deVJFTQByqqz4fnSrUIrV9uRomF
         2ZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EDgVu2dtSz7UcZGx2VswCIULyQVkiWznirrccFljwuw=;
        b=M0N5mBnUUUWWp0Ty2dbfBMM4fCtffSg3vTB4xB4UTDJ4lrlfR+ZeZaSRgWXdIezLUE
         8loouczC1lic7x6yke5j6SuHoqPfbBWh5qsaTo1gmoXO4eeeNNpcq9c9nt1laHvmq0Xe
         DBynrH3xHHShk8aamnUvNahZLMs8K5ofEc3lQ1KY7XjXeoYzp+odBPRzqqhg3eKFN9TY
         eIrxIewqnR78m8Aa10LX+UELER/SJkEcSQdIA0jin0dgfLzw4/WqkgIKHiifcRTfI0tA
         UJ+XM1+zGigCH8PkvZx7ZK2DfCKvsdtIbwyUdcXYyK6f79jbTdqKkaBJ+QQPzZupLuDg
         0rgQ==
X-Gm-Message-State: AOAM5301rEd4eygZYRJpkDYTKB/efjzB8LWq1PQ/k/h0wcxOqnTE6Iex
        o4B5Dx1UL3bW/ApBe2MprWDGjqTeIUyMyxFJcvE=
X-Google-Smtp-Source: ABdhPJxpjl69Aj4VM9p2/7HOTC63z278dOp5j4wI12XcRJwhMuSpIWeIhyxYEdksq2mfxRgWl6Gfh5qx5vBUUX9iu3E=
X-Received: by 2002:a17:902:c589:b029:e6:3a39:d4a0 with SMTP id
 p9-20020a170902c589b02900e63a39d4a0mr7657722plx.76.1615308017733; Tue, 09 Mar
 2021 08:40:17 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-4-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-4-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 08:40:06 -0800
Message-ID: <CABPp-BEDwXuLEMiwRscafe-MRfBSGYdonKAu97WZSWe575GvMA@mail.gmail.com>
Subject: Re: [PATCH 03/30] cache.h: add a comment to object_type()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 7:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Add a comment to the object_type() function to explain what it
> returns, and whet the "mode" is in the "else" case.

s/whet/what/ ?


>
> The object_type() function dates back to 4d1012c3709 (Fix rev-list
> when showing objects involving submodules, 2007-11-11). It's not
> immediately obvious to someone looking at its history and how it's
> come to be used.
>
> Despite what Linus noted in 4d1012c3709 (Fix rev-list when showing
> objects involving submodules, 2007-11-11) about wanting to move away
> from users of object_type() relying on S_ISLNK(mode) being true here
> we do currently rely on that. If this is changed to a condition to
> only return OBJ_BLOB on S_ISREG(mode) then t4008, t4023 and t7415 will
> have failing tests.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  cache.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/cache.h b/cache.h
> index d9281496140..e513f0ee5b4 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -451,11 +451,16 @@ enum object_type {
>         OBJ_MAX
>  };
>
> +/*
> + * object_type() returns an object of a type that'll appear in a tree,
> + * so no OBJ_TAG is possible. This is mostly (and dates back to)
> + * consumers of the tree-walk.h API's "mode" field.
> + */
>  static inline enum object_type object_type(unsigned int mode)
>  {
>         return S_ISDIR(mode) ? OBJ_TREE :
>                 S_ISGITLINK(mode) ? OBJ_COMMIT :
> -               OBJ_BLOB;
> +               OBJ_BLOB; /* S_ISREG(mode) || S_ISLNK(mode) */
>  }
>
>  /* Double-check local_repo_env below if you add to this list. */
> --
> 2.31.0.rc0.126.g04f22c5b82
