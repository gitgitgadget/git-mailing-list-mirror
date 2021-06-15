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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DFEC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EEB3613ED
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFOKIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbhFOKIh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 06:08:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D5DC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 03:06:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s15so9386743edt.13
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 03:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=fbt67KeJrZ+vGnowLvcihNc+/u7AQ8c3TybcgJ/vT0g=;
        b=qf+xdwNB6iTyS0HtejLiVyxErGQETGFhDxtw7q7UlfFacDKB0Viginmg6w3Razfp6U
         S6G4/0VVk6LdvC8MqUBb77M/dXfF2sTHPTumOFyZoj1XDpCOpGXGUJpzHknWfs5H5fJ/
         cWTNk8c6SX4qUZbZMaCBi3/OoLHhS83LfRgxfuTm0TAumkLbG1zeblQiSYYvn7tkHLlo
         IcO8+ncz22pYJFW021elWcZ0itE6fcUqi7wLXOTW1moLlwhqLs2UOFq+695C2dd4+R5N
         qOBD0FQFfWVhp7P68rdJS8puo87xVUxPsqkk77Sd7cyiPtcxZj4LOI2Txxthu5h9FS7g
         ltRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=fbt67KeJrZ+vGnowLvcihNc+/u7AQ8c3TybcgJ/vT0g=;
        b=ntRmlG6hYRr5ZxcrjHlLLAoQriV3Kt+/OtLmq1O338OGPeFGTzBCoctjyg1H11ef2t
         ukI3beNpdxK+E8f2ScP6doBcqNNbb5SolPuZIEQjvd31oA1WQ/dJdCUMTm3h1UNxjov7
         loNWr8haVJgMKQUcAdYfKg6EgO/U8Gay/WhzX9yjrxv+uBR+ANe4pB/iyBJrFchD40Fs
         NXDx2FEbo9ruC9Ne93JI4QUejAuKK7z3T/S5txzERthfFccnbUDT8Y1waHS5fA2YGiMD
         muHanSkfBYb01UwMG6TRvnJ8G5mnI54lA8LkiiJepU13F5Dpnw/o1dNRrKKjH+Chrwmj
         CZqQ==
X-Gm-Message-State: AOAM530ECpMnAM258Vm7HELMUPc6U0WCV5q7qMcLys6gOAy58r1/bFsv
        b6P3WWZXbikFagLlwfD0XfCQBpiXnnxO8Q==
X-Google-Smtp-Source: ABdhPJwvg7vIGDew4oXlJJKqNHZ1cIxxl6kvU2BjDqniikYqwIfMA1JDgI7LQyB4MHb8fh9Zbh4KnQ==
X-Received: by 2002:aa7:d84e:: with SMTP id f14mr22118528eds.12.1623751589052;
        Tue, 15 Jun 2021 03:06:29 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v21sm3997997eju.78.2021.06.15.03.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 03:06:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
Subject: Re: [PATCH v2 30/30] hook-list.h: add a generated list of hooks,
 like config-list.h
Date:   Tue, 15 Jun 2021 12:02:31 +0200
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
 <patch-30.30-bc086454d68-20210614T101920Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <patch-30.30-bc086454d68-20210614T101920Z-avarab@gmail.com>
Message-ID: <87im2fzbks.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 14 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Resolve a long-standing TODO item in bugreport.c of there being no
> centralized listing of hooks, this fixes a bug with the bugreport
> listing only knowing about 1/4 of the p4 hooks. It didn't know about
> the "reference-transaction" hook either.
>
> We can now make sure this is kept up-to-date, as the hook.c library
> will die if asked to find a hook we don't know about yet. The only
> (undocumented) exception is the artificial "test-hook" used in our own
> test suite. Move some of the tests away from the "does-not-exist"
> pseudo-hook, and test for the new behavior.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  .gitignore           |  1 +
>  Makefile             | 14 +++++++++++---
>  builtin/bugreport.c  | 44 ++++++++------------------------------------
>  generate-hooklist.sh | 24 ++++++++++++++++++++++++
>  hook.c               | 22 ++++++++++++++++++++++
>  t/t1800-hook.sh      | 14 +++++++++++---
>  6 files changed, 77 insertions(+), 42 deletions(-)
>  create mode 100755 generate-hooklist.sh
>
> diff --git a/.gitignore b/.gitignore
> index de39dc9961b..66189ca3cdc 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -191,6 +191,7 @@
>  /gitweb/static/gitweb.min.*
>  /config-list.h
>  /command-list.h
> +/hook-list.h
>  *.tar.gz
>  *.dsc
>  *.deb
> diff --git a/Makefile b/Makefile
> index a6b71a0fbed..d0532f3c744 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -817,6 +817,7 @@ XDIFF_LIB =3D xdiff/lib.a
>=20=20
>  GENERATED_H +=3D command-list.h
>  GENERATED_H +=3D config-list.h
> +GENERATED_H +=3D hook-list.h

This fails CI on the Windows boxes (or some of them...) because we hard
rely on cmake there since semi-recently; See 4c2c38e800f (ci:
modification of main.yml to use cmake for vs-build job, 2020-06-26).

Fixing that seems to be a matter of copying some similar boilerplate
around, but I haven't tried.

I was somewhat surprised that cmake support being semi-mandatory seems
to have snuck up on us (or at least on me). The docs in
compat/vcbuild/README still suggest you need make, so perhaps the CI on
Windows could be split up into something that uses "make" and one that
just checks for the cmake compatibility.

It's not that I much prefer the Makefile, but I do think the state of
affairs of needing to duplicate any work of patching the Makefile would
be a step back for me, but maybe the benefit on Windows is so large as
to be worth it...
