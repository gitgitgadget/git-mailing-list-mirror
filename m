Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110A2C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbhLJK1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbhLJK1c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:27:32 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B119C0617A1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:23:57 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x15so28977556edv.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=p7+3c7MAncaZnaNLD21trmpGATS0DBjdWzgtLWA9wXY=;
        b=N8nIAThJHPoiJCuuCc9kxADxv/W3nkogi+5bztwggxFbQydvjhwnMclfRg0jH7eHEP
         6DPyRat2+KUszvk5w8EEhTkyb+FpKq48LHEeXAV1yTgjyGNf0RjIv23XzrX8v7LXrr6J
         nm/QeQnIaUP9KqYODGeyTj9t9fckjN5NiWGfz0dAD5yAzbtdlaJcYsKC8xc5kCwW5ZR4
         m+J2030wpUldY4v2F7GcZn698nUl6waPhG585U/zdcR4SOioOLMpHGAXttCL/Dj3zZHM
         8pxWMklfMYeFavJOeoTgc6/lgClmLQspEuCxYnVDYEtP6GS5TTNjG8HSm0xmt0Hd+LAQ
         yLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=p7+3c7MAncaZnaNLD21trmpGATS0DBjdWzgtLWA9wXY=;
        b=kuU7KVBD++kNjo4i/5Hsd00xEWFaJlqkUabAt+q9sOqteT1e3n3VLSsdZMjlJ0b/Sa
         LmL6P2w8bgBv7FE6johbngFMiU8PE2HAXLmzXpO1uTU7idlxiVdDEU6JA6ucJm0xjq1L
         ihP/o4OvpT1IDsh4lxFGI2MoKrPJKNuHRS05Px+7xnjGj6if9ijK6v8nzh6gj6znY4E3
         QmRwHH6aiXgVG8H62vUv7n0HQREmf+rCxXufhRNtXEOG9eJG+lNmhtgDilToEnjk60K+
         NwBybyQ5NRvQbp368TUJu7t2goiD7AtSBfgV8Iv06E4o2ruz5PkY6QfL4xpvu47gTDiI
         odlA==
X-Gm-Message-State: AOAM533PNRm3OkBPIZ0voV396VkODktZi5XV6lKlDYS4rf3hLDSAvTnj
        tvkyhxSDMHZLwprbJ1Jj5MI=
X-Google-Smtp-Source: ABdhPJxAnIdExl2h1TuuQprTgP1RAamkRw60OM83W9DJvmKYWekJWAGtR0yCyZ09AOa0JJmlaLov+w==
X-Received: by 2002:a05:6402:3cd:: with SMTP id t13mr37261838edw.97.1639131836012;
        Fri, 10 Dec 2021 02:23:56 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hs8sm1254743ejc.53.2021.12.10.02.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 02:23:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvd4E-000Giv-JY;
        Fri, 10 Dec 2021 11:23:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 02/10] range-diff.c: don't use st_mult() for signed
 "int"
Date:   Fri, 10 Dec 2021 11:22:59 +0100
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <RFC-patch-02.10-bd7d014c531-20211209T191653Z-avarab@gmail.com>
 <YbLL/YWbjc/sPRyH@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YbLL/YWbjc/sPRyH@coredump.intra.peff.net>
Message-ID: <211210.86lf0sdah1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 09 2021, Jeff King wrote:

> On Thu, Dec 09, 2021 at 08:19:19PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> As documented in 320d0b493a2 (add helpers for detecting size_t
>> overflow, 2016-02-19) the arguments to st_mult() and st_add() "must be
>> unsigned".
>
> This isn't correct. The comment that says "must be unsigned" is for
> unsigned_mult_overflows(). Which indeed would not work correctly for a
> signed type. But st_add() is a separate function (and not a macro)
> because that means its arguments will always be promoted or converted
> into a size_t. And so no matter what you pass it, it will always itself
> pass a size_t into unsigned_mult_overflows().
>
>> In subsequent commits further overflows resulting in segfaults will be
>> fixed in this code, but let's start by removing this supposed guard
>> that does nothing except give us a false sense of
>> security. E.g. providing an "n" of INT_MAX here will result in "1" on
>> my system, causing us to write into memory.
>
> This guard doesn't do nothing. Your patch here:
>
>> @@ -312,7 +312,7 @@ static void get_correspondences(struct string_list *=
a, struct string_list *b,
>>  	int *cost, c, *a2b, *b2a;
>>  	int i, j;
>>=20=20
>> -	ALLOC_ARRAY(cost, st_mult(n, n));
>> +	ALLOC_ARRAY(cost, n * n);
>>  	ALLOC_ARRAY(a2b, n);
>>  	ALLOC_ARRAY(b2a, n);
>
> makes things strictly worse, because that "n * n" may overflow and cause
> us to under-allocate the array. You can see it in isolation with some
> extra code like this:
>
> diff --git a/git.c b/git.c
> index 5ff21be21f..63349e4b79 100644
> --- a/git.c
> +++ b/git.c
> @@ -850,11 +850,23 @@ static int run_argv(int *argcp, const char ***argv)
>  	return done_alias;
>  }
>=20=20
> +static void foo(void)
> +{
> +	int n =3D 2 << 16;
> +
> +	printf("n =3D %d\n", n);
> +	printf("raw mult =3D %"PRIuMAX"\n", (uintmax_t)(n * n));
> +	printf("st_mult =3D %"PRIuMAX"\n", (uintmax_t)st_mult(n, n));
> +	exit(0);
> +}
> +
>  int cmd_main(int argc, const char **argv)
>  {
>  	const char *cmd;
>  	int done_help =3D 0;
>=20=20
> +	foo();
> +
>  	cmd =3D argv[0];
>  	if (!cmd)
>  		cmd =3D "git-help";
>
> With st_mult, we get the correct answer of 16GB. Without it, we end up
> with 0!
>
> Back to the original code, if you generate a test setup like this:
>
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index e30bc48a29..f552d3086e 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -772,4 +772,11 @@ test_expect_success '--left-only/--right-only' '
>  	test_cmp expect actual
>  '
>=20=20
> +test_expect_success 'giant case' '
> +	test_commit base &&
> +	test_commit_bulk --ref=3Drefs/heads/v1 --message=3D"v1 commit %s" 32768=
 &&
> +	test_commit_bulk --ref=3Drefs/heads/v2 --message=3D"v2 commit %s" 32768=
 &&
> +	git range-diff base v1 v2
> +'
> +
>  test_done
>
> Then we'd allocate a 0-length array for "cost" and segfault as soon as
> we try to put anything in it. You can confirm this by applying your
> patch, running under gdb, and stopping at the xmalloc() call inside
> get_correspondences(). With st_mult(), then we come up with the correct
> value of 16GB (or complain about overflow on a 32-bit system).
>
> So st_add() is working as advertised here; it's goal is just to make
> sure we never under-allocate. You are right, though, that the code after
> that in get_correspondences() has trouble because of the signedness. If
> the code used an "unsigned int", it would still be _wrong_. But when it
> overflowed, it would always come up with a value under 4GB. So it might
> produce a wrong answer, but it couldn't possibly point outside the
> bounds of the array and cause a security problem.
>
> But because it's a signed int, we overflow to a negative value and try
> to look at memory far before the start of the array. So I can see how it
> is tempting to argue that this st_mult() isn't really helping since we
> segfault anyway. But I'd disagree. By correctly computing the value of
> 16GB instead of "0", we know that the ALLOC_ARRAY() line is doing the
> right thing. And it may choose not to continue if it can't allocate
> 16GB. That may happen because you don't have the RAM, but also because
> of GIT_ALLOC_LIMIT.
>
> So if you set GIT_ALLOC_LIMIT=3D4g, for example, you are immune to the bug
> here. We'd refuse the allocation and die there, which protects
> downstream code from trying to fill in the array with bogus arithmetic.
>
> Dropping the st_mult() does nothing to fix the actual problem (which is
> that this function should use a more appropriate type), but introduces
> new failure modes.

Yes you're entirely right. I had some stupid blinders on while writing
this. FWIW I think I was experimenting with some local macros and
conflated a testing of the overflow of n*n in gdb with the caste'd
version, which you rightly point out here won't have the overflow issue
at all. Sorry.
