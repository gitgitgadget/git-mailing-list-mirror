Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8C8ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 03:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiJ1DBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 23:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJ1DB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 23:01:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D8C4BD10
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 20:01:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ud5so9975150ejc.4
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 20:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=voZVJ9/je7TXZl41VfnvdR7LaAS0JGvt0wdX1Ks1Vqs=;
        b=eJjxRBGUj66wBuZJBzVTaWZg8YzTSo2lM/YiGfE0hw6szJAqWTfQ4k6twLeZVB1B6i
         SwI+/rIqMNJbzq3cHGVQQ7QWrZCFpu2XNCPIgMz6LOdHhgsmYnGU+Qg5ntHByf3WqZct
         pJ4n9/rnk4kUFdF3l7YowrgtwFUsQW1eWotkeXevMAPmnqFu7FrizIe8Jn8UjSzw5V0P
         u/PG/1d6MJerCsNhI2SyCkjFLoU6Yfi2pDwGKMGR8HFlooCdNujSpbGSVeTczG/tuSi4
         B7Qoc8JtCdem7jCFcMTADSK2P0gnl7ZsKcqXXfNTvCeEeV69rEy+shuv216JV/C4+pRP
         qylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=voZVJ9/je7TXZl41VfnvdR7LaAS0JGvt0wdX1Ks1Vqs=;
        b=AWHiuUCFtdjqmuJCX48oW0Id4jtUKWOKN+mOok72R4Wq1SGs5du7VsUcRJ5C0fIUCe
         R6mWzG+6JbpA9dNtru+Kfl2RDiEsupMD90WJy8U8VZW1K6yJnjNUXcFQX5f2/1qBa0uh
         A4iZghVrwybweTCTnA/dfY2At9oXZFIzcphT74GLr8Wwkxvc2Cy2tDQw6nb9yhc8rdEf
         TwGTyhBDKPGbB7sVsbczlVavT8JjHKX7wGd5bx0pKBVDWEed0sJUbc0sUDQ8u2zXt2fH
         aoc7QSdSffqSEqFg1cmkKgRNsna4/VguZgVePxW+KT3v6n8BgMsXjNGY+oKftz/Tk6yE
         JGVw==
X-Gm-Message-State: ACrzQf2ZzpELWOmP/huGmccDnBquuDLDBNkfu7skzv5vZRomy0ekAjYX
        cvVxVxYzOCa2o1p9QuirhEU=
X-Google-Smtp-Source: AMsMyM5+MpzMK44kDPlNup3oTgh+44g3evWHH38jN3sHC42eCBtAVB7p6fneki1Zq2Bc/gmixbOVeQ==
X-Received: by 2002:a17:907:72cb:b0:793:30b3:7f89 with SMTP id du11-20020a17090772cb00b0079330b37f89mr38857306ejc.259.1666926083230;
        Thu, 27 Oct 2022 20:01:23 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b3-20020a17090630c300b0073de0506745sm1532815ejb.197.2022.10.27.20.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 20:01:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooFcX-009kz2-2Q;
        Fri, 28 Oct 2022 05:01:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 4/4] Documentation: add lint-fsck-msgids
Date:   Fri, 28 Oct 2022 04:04:12 +0200
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
 <20221025224224.2352979-1-gitster@pobox.com>
 <20221025224224.2352979-5-gitster@pobox.com>
 <221026.867d0ncncu.gmgdl@evledraar.gmail.com>
 <Y1jG8p1aARb9+CV+@coredump.intra.peff.net>
 <221026.8635badbz5.gmgdl@evledraar.gmail.com>
 <Y1su99Kc0ex1W7bX@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y1su99Kc0ex1W7bX@coredump.intra.peff.net>
Message-ID: <221028.86sfj88xdq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 27 2022, Jeff King wrote:

> On Wed, Oct 26, 2022 at 01:35:43PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > (I had a similar thought after getting hit on the head by the recent
>> > t0450-txt-doc-vs-help.sh).
>>=20
>> Sorry about that. FWIW I've wanted to assert that for a while, and to do
>> it by e.g. having the doc *.txt blurbs generated from running "$buildin
>> -h" during the build.
>>=20
>> But when I suggested that I gathered That Junio wasn't up for that
>> approach, it does have its downsides thorugh. E.g. to build the docs
>> you'd now have to compile C code, and e.g. that git-scm.com publisher
>> written in Ruby would have to compile the code to generate its docs.
>
> Yes, it would definitely break the git-scm.com importer. It might be
> possible to make it work by actually running "make man" (or maybe even
> some partial targets) in a local repo. The nightly update job pulls all
> of the data using GitHub's API, but it does run in a heroku dyno that
> has git and gcc. Doing a shallow clone of the tag to build is probably
> more expensive, but the cost of an actual build isn't that important.
> 99% of the scheduled job runs are noops because there's no new version
> of Git to build manpages for; as long as those remain cheap-ish, we're
> OK.
>
> I also think in the long run that the site should move to a system that
> builds off a local repo, which we can trigger manually or via GitHub
> Actions. But that doesn't exist yet, and I don't think anyone's actively
> working on it.
>
> I also think it would be nice if the git-scm.com system relied more on
> "make man USE_ASCIIDOCTOR=3D1", possibly by hooking into
> asciidoctor-extensions.rb or similar, rather than munging files in an
> ad-hoc manner. But that's also a big change that nobody is actively
> working on.
>
> All of which is to say that yes, having docs depend on C code will cause
> work on the site, but it may be work that takes us in the right
> direction.

Good to know.

>> Or we could do it the other way around, and scape the *.txt for the *.c
>> generation, but then we need to run a new script for building
>> builtin/*.o. Also possible, and I think eventually both are better than
>> what t0450-txt-doc-vs-help.sh's doing now, but that was a less invasive
>> change than both...
>
> I think this particular case is tricky in that direction, because it's a
> big set of dependencies that aren't necessarily one-to-one. E.g.,
> builtin/log.c needs to depend on git-log.txt, but also on git-show.txt
> and git-format-patch.txt.

I was thinking of just a generated usage-strings.c or whatever. I.e. one
file with every usage string in it. Then you don't need to hunt down
which thing goes in which file. We'll just have a variable named
"builtin_format_patch_usage". Include it in "builtin.h" and it doesn't
matter if that's in builtin/log.c or builtin/format-patch.c.

It does mean you need to rebuild the C code for other built-ins every
time one of the SYNOPSIS sections changes, but doesn't happen too often.

>> >> +# Unfortunately our dependency management of generated headers used
>> >> +# from within other headers suck, so we'll need to list every user of
>> >> +# fsck.h here, but not too bad...
>> >> +FSCK_MSGIDS_H_BUILTINS =3D fsck index-pack mktag receive-pack unpack=
-objects
>> >> +$(foreach f,$(FSCK_MSGIDS_H_BUILTINS:%=3Dbuiltin/%),$f.sp $f.s $f.o)=
: fsck-msgids.h
>> >> +FSCK_MSGIDS_H_LIBS =3D fetch-pack fsck
>> >> +$(foreach f,$(FSCK_MSGIDS_H_LIBS),$f.sp $f.s $f.o): fsck-msgids.h
>> >
>> > I don't understand the "used within other headers" part here. Computed
>> > dependencies will get this right. It's only the initial build (before =
we
>> > have any computed dependencies) that needs to know that the C files in
>> > question depend on the generated file. But that is true whether they do
>> > so directly or indirectly.
>>=20
>> I forgot the full story, but luckily I wrote it down in the WIP commits
>> :) FWIW if you want to scour that it's mainly:
>>=20
>> 	https://github.com/avar/git/commit/a00f1cb9ea5 # add advice-type.h
>> 	https://github.com/avar/git/commit/9e080923a11 # generate 'struct advice
>
> That seems like the same problem to me. It's just that if something is
> in cache.h, then it's needed by basically everything, and so the
> dependency list is big.

I think I either did or was planning to take it out of cache.h as part
of that, we put way too much in cache.h.

Even advice.c depends on cache.h for its advice.h *sigh*.

Trying it just now putting advice.h in builtin.h instead leaves 10
top-level files not-compiling (and they just need the header).

I think it's fine to include common utilties in our "included by
everything" headers, but if we've got ~500 *.c files and something is
only needed by ~20 of them (as in this case) we should probably just
include it in those 20.

>> Anyway, in partial summary, why (and sorry this got so long):
>>=20
>>  * Yes, once we build e.g. fsck.o we have the full dependency tree,
>>    yay....
>>  * ...but only for gcc & clang, but we support other compilers.
>>  * ...for other compilers (or gcc & clang without the dep detection
>>    enabled) what should this do:

I didn't summarize this well enough, I should have said that whether you
have computed deps or not that.....

>>=20
>> 	make file-that-does-not-use-generated-header.o
>>=20
>>    It sucks a bit to have e.g. every *.o depend on command-list.h, when
>>    we only use it in 1-2 places, ditto the other headers.
> But that is already true of non-generated headers. If your system
> doesn't support computed deps, then all objects depend on all headers.

... this does not build e.g. command-list.h:

	make clean
	make grep.o

But this does:

	make clean
	make help.o

Because we've manually declared that.

[Re-arranging a bit]

> That all comes from b8ba629264 (Makefile: fold MISC_H into LIB_H,
> 2012-06-20).

Yes, but you get that for free whether you have computed deps or
not. I.e. your compiler is about to build the code anyway.

But it wasn't about to run a bunch of shellscripts to generate headers
it doesn't actually need.

> Yes, that sucks for you. But almost nobody actively develops on such a
> system, and people building Git to use rarely notice (because they are
> doing an initial build, or jumping versions, both of which generally
> require recompilation anyway).

I guess I'm "almost nobody" :) Not because I don't use computed deps,
but because I tend to e.g. do large interactive rebases with:

	git rebase -i 'make grep.o'

Or some other subset of our built assets/objects.

On that front no one thing is the end of the world, i.e. sure, if we run
some shellscript to make a needed-header.h that takes 10ms we can live
with it.

But it adds up, which is one reason I've been slowly trickling in
patches to optimize various common parts of the Makefile & those
scripts.

I think before I started that the fixed cost even to have just make
decide it had nothing to do was often 500ms-1s.

I think that's down to 1/4 or so of that on "master", and I've got some
local patches to get it consistently down to <50ms.

It adds up, especially when combined with ccache & the like. I.e. if i'm
testing 10 commits I happen to have cached a "rebase -i" goes from
noticeably slow (~10s) to not being so slow as to be distracting.

Anyway, all of which is to say that that's one thing I was aiming for:
If I was going to submit patches for new generated headers to find some
good trade-off between complexity and over-declaring dependencies.

>>  * We also have e.g. "make hdr-check", which works just fine now, but
>>    it's becausue we have no *.h file that uses another generated *.h
>>    file.
>
> I'm not that surprised. Probably it should depend on $(GENERATED_H), and
> possibly even be checking those files too.
>
>>  * I may be wrong (I'm just looking at some old "here be dragons" note
>>    of mine), but I think there's also an edge case where the dependency
>>    graph of .depend.d/* is correct *once you've always had it*, but if a
>>    file now e.g. depends on foo.h, and I make foo.h include a new
>>    foo-generated.h things go boom.
>
> That should work because the timestamp on foo.h will have been updated,
> causing anything that includes it to rebuild (and thus updating its
> computed dependencies to include foo-generated.h).

Yes, in general it should work, maybe there's some Heisenbug there. I
can't recall or reproduce it, sorry.

But that's a good thing, maybe there's no issue :)
