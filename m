Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B00C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 12:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiJZMJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 08:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbiJZMJG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 08:09:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1E4E52EF
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 05:08:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a5so27972430edb.11
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QcTjTIiVpl81rGq1zICwhxTmI1ga58dOZC3lCMCvqFg=;
        b=FiZw3wMZVqIZNkMmr4ZNexaGtDnEDLLzq0HN68A110hw1sRPMNnmaBmC5KDmNaK2g3
         DwZE7cdlLHKPKAYPp52tr+OR38kHKp9EyLAM/ALCW9dSXVfeZDOya9z3ZgNbhsXRpaeF
         ZoCp2Ig/bdA8RXNsrjxoylPE3U6d7jEbpR/GYY2MGFOurrtIOOIpkxzYr/6N8E+VRuam
         AundHTvdhRRBcaUFNPVPVNdiG56NuIApkgdoWYwk9ab+/QTWi0EOPU+1kPZ2t/G+ltLJ
         CIx767ewYydO40DRu2qfl1xpfQpBaskn506EcjzSYaBo+b94aUu3aMd6IlQpB0UKELEZ
         TVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QcTjTIiVpl81rGq1zICwhxTmI1ga58dOZC3lCMCvqFg=;
        b=gI0RjBHr3FNZa21l1vQlOcrEdJhE2CgwdswtPLIsbVUq2spU4iQHDorn0niTFh14Wa
         bXadGOzKqo9LWUMwHFGMmdR+0SxRIIJ9KUmpeiumBVKfJLdYfHMF3H2c0mKgSf9Adn8j
         t2lDIuvKeqeWMzJS69orit8NQJhfyv1qpSiN1sq+fOlOy1Ww3E7jsz2gATVGVmCuDaZy
         MPYrg5atpHabMMuFPbb6829QYpmFVqJo2fc2XMMYQz1ayPD+5ILUpVo0LF2GtkjcrCjP
         uzbQsTJAYOb/G30uvKtd1UB4szy4djShOdzQ7bVjKXgz4Qp4ahgbES9b4A3wT+V7ydVe
         IpsQ==
X-Gm-Message-State: ACrzQf05Vp8sio8xEEElaBl966MBU1RgmJ/HLDpD9PfhRsrCayCwOmO2
        6xCcmdXtRey/KbAjK4QbEXYjePL682U=
X-Google-Smtp-Source: AMsMyM7H5XM+mB5vJYW4MmR+/gZ4brj+F2YNszjavX9wV5ljVBLoOJxGqbBt58tjIeFggJE0rsE4xQ==
X-Received: by 2002:a05:6402:538a:b0:457:b602:d5a6 with SMTP id ew10-20020a056402538a00b00457b602d5a6mr40646528edb.371.1666786082745;
        Wed, 26 Oct 2022 05:08:02 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bi24-20020a170906a25800b0078d3a075525sm2889423ejb.56.2022.10.26.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:08:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1onfCQ-008dhY-1i;
        Wed, 26 Oct 2022 14:07:58 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 4/4] Documentation: add lint-fsck-msgids
Date:   Wed, 26 Oct 2022 13:35:43 +0200
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
 <20221025224224.2352979-1-gitster@pobox.com>
 <20221025224224.2352979-5-gitster@pobox.com>
 <221026.867d0ncncu.gmgdl@evledraar.gmail.com>
 <Y1jG8p1aARb9+CV+@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y1jG8p1aARb9+CV+@coredump.intra.peff.net>
Message-ID: <221026.8635badbz5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 26 2022, Jeff King wrote:

> On Wed, Oct 26, 2022 at 04:43:32AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>>=20
>> On Tue, Oct 25 2022, Junio C Hamano wrote:
>>=20
>> > During the initial development of the fsck-msgids.txt feature, it
>> > has become apparent that it is very much error prone to make sure
>> > the description in the documentation file are sorted and correctly
>> > match what is in the fsck.h header file.
>>=20
>> I have local fixes for the same issues in the list of advice in our
>> docs, some of it's missing, wrong, out of date etc.
>>=20
>> I tried to quickly adapt the generation script I had for that, which
>> works nicely, and by line count much shorter than the lint :)
>
> Yeah, my instinct here was to generate rather than lint. If you make a
> mistake and the linter hits you over the head, that is better than
> quietly letting your mistake go. But better still is making it
> impossible to make in the first place.
>
> The downside is added complexity to the build, but it doesn't seem too
> bad in this case.

Yeah, it's not, I have local patches to generate advice-{type,config}.h,
and builtin.h. This is a quick POC to do it for fsck-msgids.h.

I see I forgot the .gitignore entry, so it's a rough POC :)

> (I had a similar thought after getting hit on the head by the recent
> t0450-txt-doc-vs-help.sh).

Sorry about that. FWIW I've wanted to assert that for a while, and to do
it by e.g. having the doc *.txt blurbs generated from running "$buildin
-h" during the build.

But when I suggested that I gathered That Junio wasn't up for that
approach, it does have its downsides thorugh. E.g. to build the docs
you'd now have to compile C code, and e.g. that git-scm.com publisher
written in Ruby would have to compile the code to generate its docs.

Or we could do it the other way around, and scape the *.txt for the *.c
generation, but then we need to run a new script for building
builtin/*.o. Also possible, and I think eventually both are better than
what t0450-txt-doc-vs-help.sh's doing now, but that was a less invasive
change than both...

>> Having to exhaustively list every *.c file that uses fsck.h is a bit of
>> a bother, but we have the same with the other generated *.h's, so it
>> shouldn't be too bad.
>
> It feels like this could be made much shorter by having a separate
> fsck-msgs.h and not including it from fsck.h. Only fsck.c and mktag.c
> need the actual list. It would probably have to stop being an "enum",
> though.

Yes, that would make it shorter, but C doesn't have forward decls of
enums, so we'd need to make it "int", ....

> Another alternative is to generate the doc from the code, rather than
> the other way around.

*nod* :)

>> +# Unfortunately our dependency management of generated headers used
>> +# from within other headers suck, so we'll need to list every user of
>> +# fsck.h here, but not too bad...
>> +FSCK_MSGIDS_H_BUILTINS =3D fsck index-pack mktag receive-pack unpack-ob=
jects
>> +$(foreach f,$(FSCK_MSGIDS_H_BUILTINS:%=3Dbuiltin/%),$f.sp $f.s $f.o): f=
sck-msgids.h
>> +FSCK_MSGIDS_H_LIBS =3D fetch-pack fsck
>> +$(foreach f,$(FSCK_MSGIDS_H_LIBS),$f.sp $f.s $f.o): fsck-msgids.h
>
> I don't understand the "used within other headers" part here. Computed
> dependencies will get this right. It's only the initial build (before we
> have any computed dependencies) that needs to know that the C files in
> question depend on the generated file. But that is true whether they do
> so directly or indirectly.

I forgot the full story, but luckily I wrote it down in the WIP commits
:) FWIW if you want to scour that it's mainly:

	https://github.com/avar/git/commit/a00f1cb9ea5 # add advice-type.h
	https://github.com/avar/git/commit/9e080923a11 # generate 'struct advice

Also, before generating builtin.h I've got e.g. this:

	https://github.com/avar/git/commit/5a5360d0134 # just check with 'make' th=
at any file is sorted

To actualy generate it, very WIP:

        http://github.com/avar/git/commit/cf1d02fa6b2

Anyway, in partial summary, why (and sorry this got so long):

 * Yes, once we build e.g. fsck.o we have the full dependency tree,
   yay....
 * ...but only for gcc & clang, but we support other compilers.
 * ...for other compilers (or gcc & clang without the dep detection
   enabled) what should this do:

	make file-that-does-not-use-generated-header.o

   It sucks a bit to have e.g. every *.o depend on command-list.h, when
   we only use it in 1-2 places, ditto the other headers.

   The approach I took to this was to manually list headers that had
   "small uses" (1-10), but say that all of *.h dependend on running the
   *.sh to generate some "widely used" headers.

   E.g. if we generate builtin.h we'll either need that, or add
   builtin/%.o as a dependency, with a manual listing of the handful of
   uses outside of that subdirectory.

 * .... or just not care about any of that, i.e. to have all of our *.sh
   run on the "first build" no matter what, which certainly simplifies
   things, but once you have e.g. 5-10 generated headers doing e.g.:

	make grep.o

   and having it build command-list.h or whatever is a bit noisy, but
   it's a trade-off of manually maintaining deps v.s. not.

 * Our "COMPUTED_HEADER_DEPENDENCIES" only happens when you build the
   *.o, but we have *.sp and *.s targets too. I have some local changes
   *to generalize that, so we e.g. get proper dependencies for building
   **.s files.

 * We also have e.g. "make hdr-check", which works just fine now, but
   it's becausue we have no *.h file that uses another generated *.h
   file.

   Actually, I suspect the posted WIP change is broken in that regard
   (but doing this for real on my topic branch works), i.e. we need to
   start caring about deps for those auxiliary targets.

 * I may be wrong (I'm just looking at some old "here be dragons" note
   of mine), but I think there's also an edge case where the dependency
   graph of .depend.d/* is correct *once you've always had it*, but if a
   file now e.g. depends on foo.h, and I make foo.h include a new
   foo-generated.h things go boom.

   That issue (it if even exists, sorry, I'm blanking on the details)
   was solvable by just doing a "make clean", and building again,
   i.e. once we had re-built once we were OK, it was only a problem with
   an older checkout with an existing build pulling new sources.

   Still, I wanted to not make that case annoying either if I added a
   generated header...
