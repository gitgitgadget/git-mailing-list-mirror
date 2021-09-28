Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644A5C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 21:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F99C6136F
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 21:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbhI1Vbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 17:31:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57352 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbhI1Vbu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 17:31:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BBB1F3461;
        Tue, 28 Sep 2021 17:30:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Xhxg2+QjXHSx
        PTn8fKZxCed9HJfBzSzbC/OgOVeuJfk=; b=fNGSqauV1ZJ5CEnSAC6jjAMgUrm9
        GQ2d2sd8jDy/ifkX0EYZBklPQ2ZG7tHne4+3vJkmyIFQLshvMFJASDkbhb2+ytWs
        fhXmGS93Yx9P6wredYAMwbyUgBN8NQ5G0v5YeUA6v5D/zUyONldjqyMBbCzX1A3D
        +yLB2LTIiRdgS80=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9860AF3460;
        Tue, 28 Sep 2021 17:30:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA6E7F345C;
        Tue, 28 Sep 2021 17:30:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, t.gummerer@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 3/3] config.mak.dev: simplify compiler check for
 multiple compilers
References: <20210928091054.78895-1-carenas@gmail.com>
        <20210928091054.78895-4-carenas@gmail.com>
        <87k0j0x5mg.fsf@evledraar.gmail.com>
Date:   Tue, 28 Sep 2021 14:30:02 -0700
In-Reply-To: <87k0j0x5mg.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 28 Sep 2021 14:07:09 +0200")
Message-ID: <xmqq4ka4jsmd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3F71E3B4-20A3-11EC-97D4-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Anyway, feel free to ignore the below, and I think it's certainly not
> needed for this series, just my 0.02 if you're eventually refactoring
> some of this.
>
> diff --git a/config.mak.dev b/config.mak.dev
> index 0a87d8cbe9d..df27340b4b0 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -2,6 +2,14 @@ ifndef COMPILER_FEATURES
>  COMPILER_FEATURES :=3D $(shell ./detect-compiler $(CC))
>  endif
> =20
> +# These are all the empty string if the compiler *isn't* X or
> +# earlier. Note that clang v5, v6 etc. also qualify as "have v4".

I had to read this three times and still cannot decide what it wants
ot say.

> +CC_HAVE_CLANG4 =3D $(filter clang4,$(COMPILER_FEATURES))
> +CC_HAVE_GCC4 =3D $(filter gcc4,$(COMPILER_FEATURES))
> +CC_HAVE_GCC5 =3D $(filter gcc5,$(COMPILER_FEATURES))
> +CC_HAVE_GCC6 =3D $(filter gcc6,$(COMPILER_FEATURES))
> +CC_HAVE_GCC10 =3D $(filter gcc10,$(COMPILER_FEATURES))

It is empty if the compiler isn't X.  It is also empty if the
compiler isn't earlier than X?  That would mean version (X+1) would
qualify, as it is not X, which is not what we want.

I think you meant "... empty string, unless the compiler is X or
later."

Also, I often see "Note that" to imply "despite what I just said",
but as far as I can tell CLANG4 is not all that special and follows
the same general rule.  Perhaps "Note that" -> "For example," is
needed to clarify.

Having said all that, I find that the original=20

	ifneq ($(filter x y, $(COMPILER_FEATURES)),)

idiom is readable enough, and

	ifneq ($(CC_HAVE_X)$(CC_HAVE_Y),)

does not necessarily make it easier to spot X and Y that are being
checked with the conditional.

>  ifeq ($(filter no-error,$(DEVOPTS)),)
>  DEVELOPER_CFLAGS +=3D -Werror
>  SPARSE_FLAGS +=3D -Wsparse-error
> @@ -9,9 +17,9 @@ endif
>  DEVELOPER_CFLAGS +=3D -Wall
>  ifeq ($(filter no-pedantic,$(DEVOPTS)),)
>  DEVELOPER_CFLAGS +=3D -pedantic
> -ifneq ($(filter clang4 gcc5,$(COMPILER_FEATURES)),)
> +ifneq ($(CC_HAVE_CLANG4)$(CC_HAVE_GCC5),)
