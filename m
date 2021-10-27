Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3541C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D878161073
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244211AbhJ0VPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 17:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244206AbhJ0VPA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 17:15:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F461C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 14:12:34 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w15so15905051edc.9
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 14:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Oq6JoQiD7GPh/F2LDhbUtRKbCavqB25JpHycdL6vE3w=;
        b=EkSK3LqJRxUChwU4hmNyGzHXIGFEDiaN93w/mhNUtPe6UE3L/4gsZO2eWcMJgFK5gj
         R0gXIycXqKwaPam+x9l0+fGnEts4IxwUrmNzkCUScq8XHMtoWSoS6l2NTmk7PwoneeQ4
         s6EHBQV52u98Si5Xx8i/SSF5068frSyXd6c/29Eb5T8DbMmcQJ65bjR99Wdj41NbSzdC
         4/fWEha49T4Ro38Ah82gIsy2GeroZzxkC+Q09JcJMFFmXCSrykS/zrt9/uswarrYTphn
         X85ZlCBruPTJ3v5TXCsQ36Ell7c5IL2oeN5czFo4J4GBwfYDlNy7/xQH+96oByQYjrKW
         n0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Oq6JoQiD7GPh/F2LDhbUtRKbCavqB25JpHycdL6vE3w=;
        b=CNIdomk0ZGgGRc+L6KMfVxk6hp7OPTh6oqdAfEpix5a4m+d96pEWqp6ZJVtSrSoec5
         KNBhEMn40IH4fPjnL14mkHq7d4N9p5GYQjFdKOIbJYISNFcXHkJ2wLPs+Kje6wofuUju
         QmzMht5J2Vg6wl74YCDPmOm8IIlqDeJDESPyxWKWrhEAhTFYzKXqBRx3dEzMKtV63fWX
         hfTKMmJslEqxMp/L2Kzj/LTCGK2HYzlxMlYsSVrmhSG/a+c7wB42s7NxLfr93u1o9t6c
         S9ie7546klJ82UTt0ANxGr7t49yS7W2YNCxqVzca6kx6EeKM82Cgz1NSxA2Euzoh3yGJ
         OKoA==
X-Gm-Message-State: AOAM530GUg7vfRmB8xPtUgIrXYxjhVAyiA5NOn23RBkCuC8cjuVxHmsA
        k2cT2zPT6aLspHaegrlru80=
X-Google-Smtp-Source: ABdhPJwnJ5PF9Z+y8hJ+NIxAiKk9m8oGPBpKQShBiFmwWDxCrWSwOMP/R3arTkq2XHM5XfICZaOusg==
X-Received: by 2002:a17:906:c005:: with SMTP id e5mr8597ejz.480.1635369152468;
        Wed, 27 Oct 2021 14:12:32 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r15sm663978edd.96.2021.10.27.14.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:12:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfqDn-0021od-I0;
        Wed, 27 Oct 2021 23:12:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] leak tests: add an interface to the LSAN_OPTIONS
 "suppressions"
Date:   Wed, 27 Oct 2021 22:57:52 +0200
References: <211022.86sfwtl6uj.gmgdl@evledraar.gmail.com>
 <patch-1.1-9190f3c128f-20211022T102725Z-avarab@gmail.com>
 <YXhjstW2XAnixEqh@nand.local> <YXhvAQgxKpq65qcg@coredump.intra.peff.net>
 <211027.86v91iyis4.gmgdl@evledraar.gmail.com>
 <YXkWhFGS/uTAnsI1@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YXkWhFGS/uTAnsI1@coredump.intra.peff.net>
Message-ID: <211027.865ytixjcw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 27 2021, Jeff King wrote:

> On Wed, Oct 27, 2021 at 10:04:17AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >   - it keeps the annotations near the code. Yes, that creates conflicts
>> >     when the code is changed (or the leak is actually fixed), but that=
's
>> >     a feature. It keeps them from going stale.
>>=20
>> I fully agree with you in general for "good" uses of UNLEAK(). E.g. cons=
ider:
>>=20
>>     struct strbuf buf =3D xmalloc(...);
>>     [...]
>>     UNLEAK(buf);
>>=20
>> If I was fixing leaks in that sort of code what I pointed out downthread
>> in [1] wouldn't apply.
>
> I'm OK with such a use of UNLEAK(), though of course you could probably
> just free the buffer in that instance.
>
> But...
>
>> So to clarify, I'm not asking in [1] that UNLEAK() not be used at all
>> while we have in-flight leak fixes. I.e. I'd run into a textual
>> conflict, but that would be trivial to resolve, and obvious what the
>> semantic & textual conflict was.
>>=20
>> Rather, it's not marking specific leaks, but UNLEAK() on a container
>> struct that's problematic.
>
> ...that's the whole point of UNLEAK(), IMHO. You know that the container
> struct is leaked, but you don't care because the program is about to
> exit, or there's no easy way to avoid the leak.
>
> So it's not the "container" element, but rather it can be a problem if
> people annotate too broadly (you will miss some leaks). In the case of
> rev_info, there is no way to _not_ leak right now, because it has no
> cleanup function.

It doesn't have one, but there are uses of setup_revisions() and
rev_info usage that don't leak, as that builtin/rev-list.c case shows.

I mean, in that case it's not doing much of anything, but at least we
test that setup_revisions() itself doesn't leak right now, but wouldn't
with UNLEAK().

> In the long run we should probably add one.

After the current in-flight patches I've got making diff_free() a bit
more useful, and then a revisions_release() that'll handle most cases,
which gets us started on mass-marking the tests as leak free.

So just FWIW I'm not saying "hey can we hold off on that UNLEAK() for
far future xyz", but for a thing I've got queued up that I'd rather not
start rewriting...

> [...]But in the meantime, annotating them so we can find the
> _interesting_ leaks is worth doing (and that was the whole point of
> adding UNLEAK in the first place.
>
> And I think the UNLEAK() calls in Taylor's patch are fine in that sense.
> While yes, _some_ runs of those commands will not leak, the point is to
> say that when they do leak, they are not interesting. And they are not
> interesting because that rev_info is in scope until the program exits,
> so anything it points to is only leaked at a moment where we no longer
> care.

I don't per-se care about leaks at program exit either, but am making
them leak-free as a proxy for making the relevant APIs useful for
persistent use.

So I think the historical approach of just sprinkling UNLEAK() since
we're exiting anyway is taking too narrow of a view.

In that case if we'd like to see if revisions.[ch] is leak-free we'd
need parallel test-helper tests (or whatever) for all its features, or
we can just piggy-back on every "git log" invocation in the test
suite...

>> So we wouldn't just be marking a known specific leak, but hiding all
>> leaks & non-leaks in container from the top-level, and thus hide
>> potential regressions, an addition to attaining the end-goal of marking
>> some specific test as passing.
>
> I'd argue it _is_ a known specific leak. It is rev_info going out of
> scope that causes the leak, not rev_info holding on to memory in things
> like its pending array.
>
> Now those can be interesting, too (if it no longer needs the memory, can
> it perhaps get rid of it). But IMHO all of that is pretty secondary to
> clearing the noise so you can find "true" leaks (ones where some
> sub-function really is allocating and then losing the pointer entirely,
> especially if it's called an arbitrary number of times).

I wasn't trying to get into the philosophical discussion of whether a
struct or a struct it contains can be said to be the "real" source of a
leak :)

Yeah, I agree that from that POV there's no difference.

I'm merely referring to the practical aspect of patches I've got queued
up, which do things like fix all leaks of rev_info.pending, mark tests
that now pass, fix another rev_info.whatever, mark tests etc.

For rev_info in particular it's a bit iffy to UNLEAK() it, since it also
contains pointers to stuff it doesn't "own", sometimes things are
allocated and handed off to it, sometimes for a while, sometimes
permanently.

So by UNLEAK()ing it you're not just unleaking "its" memory, but
potentially hiding leaks in APIs that need to interact with it in that
way. E.g. mailmap.c is one of those cases.

>> >   - leak-checkers only know where things are allocated, not who is
>> >     supposed to own them. So you're often annotating the wrong thing;
>> >     it's not a strdup() call which is buggy and leaking, but the
>> >     function five layers up the stack which was supposed to take
>> >     ownership and didn't.
>>=20
>> As noted in [3] this case is because the LSAN suppressions list was in
>> play, so we excluded the meaningful part of the stack trace (which is
>> shown in that mail).
>
> I don't think that's true at all. The annotations you showed in that
> message, for example, are pointing at add_rev_cmdline(). But that is
> _not_ the source of the leak, nor where it should be fixed. It is a
> necessary part of how rev_info works. The leak is when the rev_info goes
> out of scope without anybody cleaning it up.
>
>> Hrm, now that I think about it I think that the cases where I had to
>> resort to valgrind to get around such crappy stacktraces (when that was
>> all I got, even without suppressions) were probably all because there
>> was an UNLEAK() in play...
>
> I don't see how UNLEAK() would impact stack traces. It should either
> make something not-leaked-at-all (in which case LSan will no longer
> mention it), or it does nothing (it throws some wasted memory into a
> structure which is itself not leaked).

Yes, I think either categorically wrong here, or it applies to some
other case I wasn't able to dig up. Or maybe not, doesn't Taylor's
example take it from "Direct leak" to "Indirect leak" with the
suppression in play? I think those were related somehow (but don't have
that in front of me as I type this out).

E.g. (to reinforce your point) try compiling with SANITIZE=3Dleak and runni=
ng:

    $ TZ=3DUTC t/helper/test-tool date show:format:%z 1466000000 +0200
    1466000000 -> +0000
    +0200 -> +0000
=20=20=20=20
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    =3D=3D335188=3D=3DERROR: LeakSanitizer: detected memory leaks
=20=20=20=20
    Direct leak of 3 byte(s) in 1 object(s) allocated from:
        #0 0x7f31cdd21db0 in __interceptor_malloc ../../../../src/libsaniti=
zer/lsan/lsan_interceptors.cpp:54
        #1 0x7f31cdb04e4a in __GI___strdup string/strdup.c:42
=20=20=20=20
    SUMMARY: LeakSanitizer: 3 byte(s) leaked in 1 allocation(s).

Now try with "SANITIZE=3D" and valgrind can give you the "real" source:

    $ TZ=3DUTC valgrind --leak-check=3Dfull t/helper/test-tool date show:fo=
rmat:%z 1466000000 +0200
    =3D=3D336515=3D=3D Memcheck, a memory error detector
    =3D=3D336515=3D=3D Copyright (C) 2002-2017, and GNU GPL'd, by Julian Se=
ward et al.
    =3D=3D336515=3D=3D Using Valgrind-3.16.1 and LibVEX; rerun with -h for =
copyright info
    =3D=3D336515=3D=3D Command: t/helper/test-tool date show:format:%z 1466=
000000 +0200
    =3D=3D336515=3D=3D
    1466000000 -> +0000
    +0200 -> +0000
    =3D=3D336515=3D=3D
    =3D=3D336515=3D=3D HEAP SUMMARY:
    =3D=3D336515=3D=3D     in use at exit: 1,208 bytes in 13 blocks
    =3D=3D336515=3D=3D   total heap usage: 50 allocs, 37 frees, 27,593 byte=
s allocated
    =3D=3D336515=3D=3D
    =3D=3D336515=3D=3D 3 bytes in 1 blocks are definitely lost in loss reco=
rd 1 of 13
    =3D=3D336515=3D=3D    at 0x483877F: malloc (vg_replace_malloc.c:307)
    =3D=3D336515=3D=3D    by 0x49C6E4A: strdup (strdup.c:42)
    =3D=3D336515=3D=3D    by 0x261E3A: xstrdup (wrapper.c:29)
    =3D=3D336515=3D=3D    by 0x152785: parse_date_format (date.c:991)
    =3D=3D336515=3D=3D    by 0x116A34: show_dates (test-date.c:39)
    =3D=3D336515=3D=3D    by 0x116DE9: cmd__date (test-date.c:116)
    =3D=3D336515=3D=3D    by 0x115227: cmd_main (test-tool.c:127)
    =3D=3D336515=3D=3D    by 0x115334: main (common-main.c:52)
    =3D=3D336515=3D=3D
    =3D=3D336515=3D=3D LEAK SUMMARY:
    =3D=3D336515=3D=3D    definitely lost: 3 bytes in 1 blocks
    =3D=3D336515=3D=3D    indirectly lost: 0 bytes in 0 blocks
    =3D=3D336515=3D=3D      possibly lost: 0 bytes in 0 blocks
    =3D=3D336515=3D=3D    still reachable: 1,205 bytes in 12 blocks
    =3D=3D336515=3D=3D         suppressed: 0 bytes in 0 blocks
    =3D=3D336515=3D=3D Reachable blocks (those to which a pointer was found=
) are not shown.
    =3D=3D336515=3D=3D To see them, rerun with: --leak-check=3Dfull --show-=
leak-kinds=3Dall
    =3D=3D336515=3D=3D
    =3D=3D336515=3D=3D For lists of detected and suppressed errors, rerun w=
ith: -s
    =3D=3D336515=3D=3D ERROR SUMMARY: 1 errors from 1 contexts (suppressed:=
 0 from 0)

I don't know why it habitually loses track of seemingly easy-to-track
leaks sometimes, but it does. There isn't an UNLEAK() in play here.

When I run into these I try it with valgrind, fix the leak, then test
again with SANITIZE=3Dleak. I haven't found cases where it actually misses
things, just cases where the stack traces suck.
