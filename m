Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2158C07E9C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAED06136E
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbhGNIib (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 04:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238503AbhGNIib (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 04:38:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1507C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 01:35:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bu12so2135088ejb.0
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gK/Bcs3fwJhVFOC7OE8ZPnbUiB8MXKAH0AXeAfezzf8=;
        b=nMF8GPRsVGI+ZIk42TprHvbW8JRSkGTDBqMf/VLDcs3dUN/dERk2YFoYnJL3NCdAGL
         gYNaDwYsHAyg9QUhuUpITp+FAVnBjEeVPDW0ucViFbvEgbWGdDgmxD/e3WXQaUo9yfXd
         FGrH2ZOb+dwdkvvc0EAxGYa6E+oF2IkD/6YvMETo+VdYqOrZXUcv8nQJzWnQTPZXTIi5
         E+TvSOajPe9XgvGdZy9Gh2L6aj3gbTYqGHPcykIVOzwXuNZLLHASDr7R47RPn9prBndA
         l40ZTigNblDRPq5H3qF/dJye2ymw9rRxYRnHoqM3Pza7iZJ2vRp5ZSk5b58dfo0KffjL
         tPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gK/Bcs3fwJhVFOC7OE8ZPnbUiB8MXKAH0AXeAfezzf8=;
        b=iBawaT2wkfV2E7M7KouOJpJ+jUK8YtGdGrOwOSNBQBTVjT0lGnkk1Uk3o2clthFCXU
         PFXEtOdUFMRAfJmOt4jHayR40DTLTM2EgqvxYlqjhAIuDuNxpAhW0ebSWTtf+6fy+N2Z
         rPKtDv053IIeNcKRfGwHT4rusRawvQSZNeN5q35k7BWviXQe0CFvfvd/Kp24EIEvFAZw
         ZBJFhn+uhqAJlBBaEufbSopN1IiAdn3hAK4Y/m1Wj7CZaVH+AjrLRwY1JNyzrb9tg6IL
         QmphD/f8o2rWIEu3hANw49JFvwDZSNTv2WO123hGzI9tpjp8ZR8wVsROLHvHHX3YK3Fs
         nwCg==
X-Gm-Message-State: AOAM533bhwGPiC9PCoaWSH3hlTOw4bLzbmnedI4kLkeYqZXC4s1zwDPm
        KII2u6jpYh3CHOHGfumJlL42TEoZG/bI+FSj
X-Google-Smtp-Source: ABdhPJw1t3Z+qGLykhGQfVGQiuQyZvmj9xNXBJ9SSgLYhDVBKUVcL2KdcJLEEbyB/YOwbSFeg9AECg==
X-Received: by 2002:a17:906:1703:: with SMTP id c3mr11054276eje.64.1626251737237;
        Wed, 14 Jul 2021 01:35:37 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c28sm488154ejc.102.2021.07.14.01.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 01:35:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6? 15/17] refs API: make resolve_ref_unsafe() not set
 errno
Date:   Wed, 14 Jul 2021 10:32:38 +0200
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
 <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
 <patch-15.17-446b50280be-20210711T162803Z-avarab@gmail.com>
 <CAFQ2z_MNEb=tb+iVjE3n33Lq8tfKNKnaMOvxm6z0cwXChbuSQA@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAFQ2z_MNEb=tb+iVjE3n33Lq8tfKNKnaMOvxm6z0cwXChbuSQA@mail.gmail.com>
Message-ID: <87o8b51eea.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 13 2021, Han-Wen Nienhuys wrote:

> On Sun, Jul 11, 2021 at 6:30 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> +       refs =3D get_main_ref_store(the_repository);
>> +       head =3D refs_resolve_ref_unsafe_with_errno(refs, "HEAD", 0, NUL=
L, NULL,
>> +                                                 &resolve_errno);
>> +       if (!head) {
>> +               errno =3D resolve_errno;
>
> This adds another place where we'd use global errno to communicate.
> Isn't there a die() function that takes an errno value explicitly?

No, not that I know of. I suppose we could refactor fmt_with_err() in
usage.c to somehow be exposed and add e.g. a:

    die_saved_errno(&saved_errno, "msg %s", ....);

But I really don't see the point.

The trouble with using errno is generally introducing undesired action
at a distance, here we're setting it immediately before calling
die_errno(), so there's not much action or distance we should/could be
worried about.

E.g. xmkstemp() in wrapper.c uses this pattern, i.e.:

    errno =3D saved_errno;
    die_errno(...)
