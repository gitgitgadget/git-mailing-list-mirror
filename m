Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484BFC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 09:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E18610A2
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 09:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbhI1Jxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 05:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239815AbhI1Jxq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 05:53:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3512AC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 02:52:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id dn26so3917435edb.13
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 02:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=uyl8XiJnGqZAI/Ji4BHmOade4GlFLvsYj9jFSrFBAQU=;
        b=jxZfHYQGwQwn9IXh0nOXyZHBVq5xnQ4/0rmUhNzCJ9T4MiVspwrzbLsHSlG3eEqgvv
         LDVvXuJ+p6c1iOFlf2viiP7BBP3Q6OYPcMn/FQ0Hv6f+9LGdswGeNkkRx+tV1m5VCf3w
         qNpeio24YdrdNAgg5MeG/jwxeMcZZjCk67M7qXc+8Qd5j5dV5ACsmaUsIATaF/iB+SF6
         AW4ATHsCOfmLSSTJU2vS++DXznHVASCh9YF7x6/al4+Ai2Al+DLfQctUyNVsgpNe4Gwp
         FwBSeT7JU5uvkkIX25dq/cWnQNuD6uR4dHzIRAHJlTtp3psyYku/3O7YHe3vuKH1Ce5t
         3lBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=uyl8XiJnGqZAI/Ji4BHmOade4GlFLvsYj9jFSrFBAQU=;
        b=2JTquLTY2yQyoOll66DK7FWNrKd06oj/Mceh4okt3F85wQ+r78nY2nVDFxgaKI7ueS
         aGhJ8+FXK43af8WJiX4eZ4RCd+Wj32a8K+rC+HfjFvzCQMwbIPDad5tn9ly5QO9CDVxI
         KZknJ9ip7hD69GueCPsz09464cHAhZDTqE1avB54fVjmCLptHyU3XvjSbOP6AGKd4O95
         urUHqgaJkRpjTHXTHoYPn3DOJY6Tm7Tj4krXPgVgr3hRwdJ3VUqqdGNFpd6RpS3PpTWq
         W6gwyjW1CpeK5K+aVnR0R241ZLFb6MWYkYvlwVNDd9hbhakEKIQJSJYRUoZtNw7V98d1
         cKwg==
X-Gm-Message-State: AOAM53009b8GUy5/nfOHmqtO9xnYkGk+B4Bu2GBuaVpnwAs8Oa42iRIL
        jUi6UY2wcOJmKgBTmSEsbJJHeoHlLuU0rQ==
X-Google-Smtp-Source: ABdhPJzLJy/hOfHNknymCDDV7qenkCQvAg2zWtutUwj6uuowLpV6ROjKgrO76fjnkXIrmjYafmKTUQ==
X-Received: by 2002:a17:906:b14d:: with SMTP id bt13mr5443382ejb.39.1632822724982;
        Tue, 28 Sep 2021 02:52:04 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f18sm12546704edt.60.2021.09.28.02.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 02:52:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, t.gummerer@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 2/3] Makefile: avoid multiple -Wall in CFLAGS
Date:   Tue, 28 Sep 2021 11:19:24 +0200
References: <20210928091054.78895-1-carenas@gmail.com>
 <20210928091054.78895-3-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210928091054.78895-3-carenas@gmail.com>
Message-ID: <87wnn1vxh8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 28 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> 6163f3f1a4 (config.mak.dev: add -Wall, primarily for -Wformat, to help
> autoconf users, 2018-10-12) adds a second -Wall in config.mak.dev to
> workaround the lack of one from config.mak.autogen.
>
> Since 6d5d4b4e93 (Makefile: allow for combining DEVELOPER=3D1 and
> CFLAGS=3D"...", 2019-02-22), that variable is set instead as part of
> DEVELOPER_FLAGS which won't be overriden by config.mak.autogen, so
> it can be safely removed from config.mak.dev if set instead in the
> Makefile.
>
> This also has the advantage of separating cleanly CFLAGS which are
> used for building with the ones that provide with diagnostics.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  Makefile       | 3 ++-
>  config.mak.dev | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9df565f27b..963b9e7c6b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1200,7 +1200,8 @@ endif
>  # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
>  # tweaked by config.* below as well as the command-line, both of
>  # which'll override these defaults.
> -CFLAGS =3D -g -O2 -Wall
> +CFLAGS =3D -g -O2
> +DEVELOPER_CFLAGS =3D -Wall
>  LDFLAGS =3D
>  CC_LD_DYNPATH =3D -Wl,-rpath,
>  BASIC_CFLAGS =3D -I.
> diff --git a/config.mak.dev b/config.mak.dev
> index c81be62a5c..90c47d2782 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -6,7 +6,6 @@ ifeq ($(filter no-error,$(DEVOPTS)),)
>  DEVELOPER_CFLAGS +=3D -Werror
>  SPARSE_FLAGS +=3D -Wsparse-error
>  endif
> -DEVELOPER_CFLAGS +=3D -Wall
>  ifeq ($(filter no-pedantic,$(DEVOPTS)),)
>  DEVELOPER_CFLAGS +=3D -pedantic
>  ifneq ($(filter clang4 gcc5,$(COMPILER_FEATURES)),)

This really breaks things for anyone who's relying on specifing CFLAGS
now to clobber the default -Wall configuration, e.g. on both xlc and aCC
after this:

    xlc: 1501-289 (W) Option -Wall was incorrectly specified. The option wi=
ll be ignored.
    cc: error 1914: bad form for `-W' option

I.e. they didn't work before, but I've got CFLAGS=3D"-g -O0" for both in
my build scripts, so they didn't get -Wall before, but now they do, so
I'll need:

    CFLAGS=3D<that> DEVELOPER_CFLAGS=3D

And in my own dev setup I do in config.mak: "CFLAGS=3D-g -O0", and then
rely on config.mak.dev to set -Wall, but if I did e.g.:

    DEVELOPER=3D CFLAGS=3D"-g -O0 -Wall"

I'd end up with -Wall twice, gcc doesn't complain, but maybe some other
toolchains do.

For the former case this seems like a really odd and leaky interface
since I don't have DEVELOPER=3D1. Let's leave DEVOPTS, DEVELOPER_CFLAGS
etc. etc. only in effect for anyone who turns on that option.

Anyway, I don't think it's a no-go to make a change in this direction,
and while it would break builds for some perhaps the end result is worth
it. I haven't really looked closely enough at the Makefile logic you're
untangling to form an opinion on it.

But I think this needs to at least have
s/DEVELOPER_CFLAGS/WARNING_CFLAGS/g or something.

But not to saddle you with an impossible task, wouldn't this whole thing
be much easier if we included config.mak* before setting our own CFLAGS
etc. defaults? But of course that would break for anyone relying on "+=3D"
working, so I don't know.
