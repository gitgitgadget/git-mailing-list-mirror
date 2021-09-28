Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0546C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 21:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF54F61139
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 21:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242872AbhI1VVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 17:21:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54807 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbhI1VVd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 17:21:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FF1B14B2F6;
        Tue, 28 Sep 2021 17:19:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wr1zY/aA2mug
        H6l14PamJ+mUxQXRBpHZ2rZg0HhEI/I=; b=uyTD+bawMTiqOFNIi2FrNZOA/6F+
        GkYP66ddknsDzjYi+IfB/7PCrPq6PbHFJ4+FAvb4UzBucOgBr2oPHpFaT1k67pKv
        OchVCeXrOiAsUbQRCfG0qg8ZZT2+mWOgPfM7viiVqbW33V6oGyI07/MkJiG2YHJQ
        bj9isRRTs/qOdMU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2845914B2F5;
        Tue, 28 Sep 2021 17:19:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8800514B2F4;
        Tue, 28 Sep 2021 17:19:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, t.gummerer@gmail.com, avarab@gmail.com,
        pclouds@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH 2/3] Makefile: avoid multiple -Wall in CFLAGS
References: <20210928091054.78895-1-carenas@gmail.com>
        <20210928091054.78895-3-carenas@gmail.com>
Date:   Tue, 28 Sep 2021 14:19:49 -0700
In-Reply-To: <20210928091054.78895-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 28 Sep 2021 02:10:53 -0700")
Message-ID: <xmqqbl4cjt3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D0C0797C-20A1-11EC-9168-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 6163f3f1a4 (config.mak.dev: add -Wall, primarily for -Wformat, to help
> autoconf users, 2018-10-12) adds a second -Wall in config.mak.dev to
> workaround the lack of one from config.mak.autogen.
>
> Since 6d5d4b4e93 (Makefile: allow for combining DEVELOPER=3D1 and
> CFLAGS=3D"...", 2019-02-22), that variable is set instead as part of
> DEVELOPER_FLAGS which won't be overriden by config.mak.autogen, so
> it can be safely removed from config.mak.dev if set instead in the
> Makefile.

Hmph, don't this break non-developers, though?

They now do not get -Wall that they used to?  Or am I reading the
patch incorrectly?

Thanks.

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
