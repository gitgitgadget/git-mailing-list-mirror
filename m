Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43706C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 22:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351753AbiA1WkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 17:40:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57916 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiA1WkL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 17:40:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C97BB180190;
        Fri, 28 Jan 2022 17:40:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wBpPligmOtQK
        9MwzWM44AbYQdFB05nyiNwDbX+o90Ns=; b=CjpmVwZAEPpXFnCmy1FVJ53/Dog6
        /5/XttO2HPyuLg4h35HQ9L0vBs18hVgDhL5ngxmPeloeNPjJKpH82ZKw4M1GiS/X
        L5SKjUiz4VQ82LgQ1gJlyNlUQHNxqzLHs/fjlrK8yFc9A7AsZrl4vJAgNhDOuK6D
        va9fN2SorO3Nt9Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE3D018018F;
        Fri, 28 Jan 2022 17:40:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1C5BF18018E;
        Fri, 28 Jan 2022 17:40:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/2] C99: remove hardcoded-out !HAVE_VARIADIC_MACROS
 code
References: <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
        <cover-v2-0.2-00000000000-20220128T110330Z-avarab@gmail.com>
        <patch-v2-2.2-966d96505cb-20220128T110330Z-avarab@gmail.com>
Date:   Fri, 28 Jan 2022 14:40:06 -0800
In-Reply-To: <patch-v2-2.2-966d96505cb-20220128T110330Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 28 Jan
 2022 12:11:09
        +0100")
Message-ID: <xmqq4k5nwkl5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3EA28B80-808B-11EC-BD7A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove the "else" branches of the HAVE_VARIADIC_MACROS macro, which
> has been unconditionally omitted since 765dc168882 (git-compat-util:
> always enable variadic macros, 2021-01-28).
>
> Since they were hardcoded out anyone trying to compile a version of

"compile" -> "use a compiler without variadic macro support to compile"

> git v2.31.0 or later would have had a compilation error. 10 months
> across a few releases since then should have been enough time for
> anyone who cared to run into that and report the issue.

OK.

The verb "hardcode out" sounds iffy to me, but the reasoning above
and all the additions and removals in in this patch look quite
sensible.

Some paragraphs that merely got moved probably needs more work,
though.

>  Documentation/CodingGuidelines |   3 +
>  banned.h                       |   5 --
>  git-compat-util.h              |  12 ---
>  trace.c                        |  80 +-------------------
>  trace.h                        | 133 +++++++++++++--------------------
>  trace2.c                       |  39 ----------
>  trace2.h                       |  25 -------
>  usage.c                        |  15 +---
>  8 files changed, 58 insertions(+), 254 deletions(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuide=
lines
> index 0e27b5395d8..1858075a159 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -210,6 +210,9 @@ For C programs:
>     . since mid 2017 with 512f41cf, we have been using designated
>       initializers for array (e.g. "int array[10] =3D { [5] =3D 2 }").
> =20
> +   . since early 2021 with 765dc168882, we have been using variadic
> +     macros, mostly for printf-like trace and debug macros.

OK.

> @@ -218,7 +143,23 @@ void trace_performance_leave(const char *format, .=
..);
>   *
>   * which is invalid (note the ',)'). With GNUC, '##__VA_ARGS__' drops =
the
>   * comma, but this is non-standard.
> + *
> + * TRACE_CONTEXT may be set to __FUNCTION__ if the compiler supports i=
t. The
> + * default is __FILE__, as it is consistent with assert(), and static =
function
> + * names are not necessarily unique.
> + *
> + * __FILE__ ":" __FUNCTION__ doesn't work with GNUC, as __FILE__ is su=
pplied
> + * by the preprocessor as a string literal, and __FUNCTION__ is filled=
 in by
> + * the compiler as a string constant.

Want to say that it is a possibility to use pasted string literal
that involves __FILE__ and __LINE__ here?

> + */
> +#ifndef TRACE_CONTEXT
> +# define TRACE_CONTEXT __FILE__
> +#endif

> +
> +/**
> + * Prints a formatted message, similar to printf.
>   */
> +#define trace_printf(...) trace_printf_key(&trace_default_key, __VA_AR=
GS__)

OK.

> +/**
> + * Prints a formatted message, followed by a quoted list of arguments.
> + */

This comment was OK in front of the declaration of the function
version of this thing, i.e.

    void trace_argv_printf(const char **argv, const char *format, ...);

because the function prototype made it clear what type the initial
parameters are.

But it is way too inadequate for the varargs macro version of this
function, since ...

>  #define trace_argv_printf(argv, ...)					    \

... it is harder to tell what argv is without type and impossible to
know the next one is a format string.  Just moving it around is not
enough; it needs to be a bit more helpful.

> @@ -236,12 +178,32 @@ void trace_performance_leave(const char *format, =
...);
>  					    argv, __VA_ARGS__);		    \
>  	} while (0)
> =20
> +/**
> + * Prints the strbuf, without additional formatting (i.e. doesn't
> + * choke on `%` or even `\0`).
> + */

Likewise.  The function version was declared as

	trace_strbuf(struct trace_key *key, const struct strbuf *data)

so mention of "strbuf" was sufficient to tell that the second
parameter is what gets printed.  With the macro version, the comment
needs to make an extra effort, as the reader has less clue to work
with, compared to the function version.

Thanks.
