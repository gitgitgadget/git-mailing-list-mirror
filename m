Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C032C433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 18:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381873AbiAUSSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 13:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382059AbiAUSS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 13:18:28 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B669AC06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 10:18:27 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id s5so2322518ejx.2
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 10:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Nf2vTiQb3ES5dxvMtRDNlgIgxSieltMXDg8D9VmNYEE=;
        b=iDh6eyb83NWMtTcjlDPp+AeUksE8kCuBMXsPi9VwaE0X+yp9UOf7TchLd4D/ZNXfWZ
         ejxVrF4pVry8cpEp5IQj7yMqXrKRwQeU0qXvyaW1aQmYBAGxqdY+eigavqom7z/ghALP
         lBumaRd/s/P33udlZk8+1S5KBY15TkZQPR1FERkfaVuFNP7Z36CKXcEZmag9V97t+Lik
         gQwhIGKx7UFSHIOSf0bJh+62ebMT/zJpj7ezefsSi9V7UL6MjeQmW5Doh2xUIUNArvdp
         4nJCFMogAvbflddy0/TW6KonDrgAHSNnXATZiw4AZAMiTBEwLAUiGDj11dtIe9QMCHbd
         6gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Nf2vTiQb3ES5dxvMtRDNlgIgxSieltMXDg8D9VmNYEE=;
        b=d7sHa4F6khd8TWoCxXY6llQVr3dmhHpm3L/eyx9LhIv9ikbzmizxu0UYMxQVQr6OOl
         n9CtCM427HM8cEcDPPS2oyKM2+CBQM2ZFiWrA5y7kj7EUH9JU5LaKMSDFRx2j0owVb17
         SLD4HMjrwfAkdMF/s8Z6p3RXSVw+EIzkC+Mey8T27pVtF/GhdimT8xXomYdSoLYENTJv
         DJB3Zeo2hcdNEJ+0LK5UmMABXY5MD9M61/ycVYXSBFP4hiVC1Nrjti6ITEcnI/M/gSnr
         cFcld12jYLIo8BKQw6krs7S41TipcaYe1xf04Q6W/v4HEI+mml2rpzBJ7OCmr2AvxCO/
         LP/w==
X-Gm-Message-State: AOAM530iT2odj//mKOYmQxxwGRiiZmiG8ymiN1rlScgXV5hESLSbB3m/
        pthonqYgEA4AT2k1d1slJj8jeYlTWDxbPQ==
X-Google-Smtp-Source: ABdhPJwUg0rRx5KOMgLUdfmp/ykUweJ3Grzka0vC1vjNWWiYVAhEj7Peh6l8bI7IyJEjz0co3U0Uaw==
X-Received: by 2002:a17:907:d1a:: with SMTP id gn26mr4218231ejc.51.1642789105975;
        Fri, 21 Jan 2022 10:18:25 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j8sm2282063ejs.136.2022.01.21.10.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 10:18:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAyUS-002EN2-H4;
        Fri, 21 Jan 2022 19:18:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Paul Smith <paul@mad-scientist.net>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 3/3] Makefile: replace most hardcoded object lists
 with $(wildcard)
Date:   Fri, 21 Jan 2022 19:13:44 +0100
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
 <patch-v2-3.3-cd62d8f92d1-20211101T191231Z-avarab@gmail.com>
 <24482f96-7d87-1570-a171-95ec182f6091@gmail.com>
 <211106.86tugpfikn.gmgdl@evledraar.gmail.com>
 <40dbf962-2ccd-b4d6-7110-31317eb35e34@gmail.com>
 <xmqqtugl102l.fsf@gitster.g> <220121.86o845jnvv.gmgdl@evledraar.gmail.com>
 <4caf3c95-c19c-80c6-daea-84dcb3ec9663@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <4caf3c95-c19c-80c6-daea-84dcb3ec9663@gmail.com>
Message-ID: <220121.867datj6kv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 21 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 21/01/2022 12:01, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Nov 09 2021, Junio C Hamano wrote:
>>=20
>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>
>>>>> We can also have some DEVOPTS knob so we'll prune out files found if
>>>>> a
>>>>> $(shell)-out to "git status" tells us they're untracked. I wouldn't m=
ind
>>>>> that (and could implement it) if it was optional.
>>>>> Also note that you've got some of this already, e.g. we'll pick up
>>>>> *.h
>>>>> files via a glob for "make TAGS", the dependency graph etc.
>>>>
>>>> I'd be happier using 'git ls-files' with a glob if we need to move
>>>> away from listing the files explicitly rather than having to pass some
>>>> exclude list when running make. Having seen your comments below about
>>>> ls-files/find I had a look at the Makefile and they always seem to be
>>>> used together as "git ls-files ... || find ...". Doing that would mean
>>>> we wouldn't try to build any untracked files but still find everything
>>>> in a tarball.
>>>
>>> I've been quiet on this topic because honestly I do not find the
>>> pros-and-cons favourable for more use of wildcards [*].  Tools like
>>> git (especially .gitignore) and Makefile are to help users to be
>>> safely sloppy by ensuring that random crufts the users may create in
>>> the working tree for their convenience are not picked up by default
>>> unless the project to consciously expresses the desire to use them.
>>>
>>> Allowing to be sloppy while maintaining Makefile feels like a false
>>> economy, and having to paper it over by adding exceptions and
>>> forcing developers to learn such ad-hoc rules even more so.
>>>
>>>      Side note: TAGS generation and some other minor things may use
>>>      $(wildcard) and can throw tokens in cruft files in the output,
>>>      which is not ideal, but the damage is local.  We cannot treat
>>>      that the same as building binaries and tarballs.
>>>
>>> If we could use "git ls-files" consistently, that may make it
>>> somewhat safer; you'd at least need to "git add" a new file before
>>> it gets into the picture.  But it would be impossible, because we
>>> need to be able to bootstrap Git from a tarball extract.
>>>
>>>>>>> We could make this simpler still for the Makefile by moving
>>>>>>> "unix-socket.c" etc. to e.g. a "conditional-src/" directory, likewi=
se
>>>>>>> for $(PROGRAM_OBJS) to e.g. "programs/". If we did that we would not
>>>>>>> need the "$(filter-out)" for LIB_OBJS. I don't think that's worth i=
t,
>>>>>>> e.g. due to "git log -- <path>" on the files now needing a "--follo=
w".
>>>
>>> And it is not quite clear to me why we want to even more pile
>>> workaround like this on top.  This also is to paper over the mistake
>>> of being sloppy and using $(wildcard), which makes it unable to
>>> distinguish, among the ones that match a pattern, between FOO_OBJS
>>> and BAR_OBJS, no?  Moving files around in the working tree to group
>>> related things together is a good thing, and it has been a good move
>>> to separate built-ins and library-ish parts into different
>>> directories.  But the above does not sound like it.
>>>
>>> Other than "these source files may or may not be compiled
>>> depending", what trait do files in conditional-src/ share, other
>>> than "dividing them into a separate category makes it simpler to
>>> write Makefile using $(wildcard)"?  I do not think of a good one.
>>>
>>> The only time I found that the large list of files in Makefile was
>>> problematic was *NOT* when multiple topics added, renamed or removed
>>> the files (it is pretty much bog standard merge conflicts that do
>>> not happen very often to begin with).  It is when this kind of
>>> "large scale refactoring" for the sake of refactoring happens.
>>>
>>>> I'm not so worried about those other targets, but being able to
>>>> reliably build and test git with some cruft lying around is useful
>>>> though. I'm still not entirely sure what the motivation for this
>>>> change is (adding new files is not that common) but I think using the
>>>> established "git ls-files || find" pattern would be a good way of
>>>> globbing without picking up rubbish if there is a compelling reason to
>>>> drop the lists.
>>>
>>> Yes.
>> Reviewing the reftable coverity topic I was reminded of this
>> patch. I.e. in it we have this fix:
>> https://lore.kernel.org/git/xmqqtugl102l.fsf@gitster.g/
>> Which shows another advantage of using this sort of $(wildcard)
>> pattern,
>> i.e. if we had this:
>>=20=09
>> 	diff --git a/Makefile b/Makefile
>> 	index 5580859afdb..48ea18afa53 100644
>> 	--- a/Makefile
>> 	+++ b/Makefile
>> 	@@ -2443,33 +2443,9 @@ XDIFF_OBJS +=3D xdiff/xutils.o
>> 	 .PHONY: xdiff-objs
>> 	 xdiff-objs: $(XDIFF_OBJS)
>>=20=09
>> 	-REFTABLE_OBJS +=3D reftable/basics.o
>> 	-REFTABLE_OBJS +=3D reftable/error.o
>> 	-REFTABLE_OBJS +=3D reftable/block.o
>> 	-REFTABLE_OBJS +=3D reftable/blocksource.o
>> 	-REFTABLE_OBJS +=3D reftable/iter.o
>> 	-REFTABLE_OBJS +=3D reftable/publicbasics.o
>> 	-REFTABLE_OBJS +=3D reftable/merged.o
>> 	-REFTABLE_OBJS +=3D reftable/pq.o
>> 	-REFTABLE_OBJS +=3D reftable/reader.o
>> 	-REFTABLE_OBJS +=3D reftable/record.o
>> 	-REFTABLE_OBJS +=3D reftable/refname.o
>> 	-REFTABLE_OBJS +=3D reftable/generic.o
>> 	-REFTABLE_OBJS +=3D reftable/stack.o
>> 	-REFTABLE_OBJS +=3D reftable/tree.o
>> 	-REFTABLE_OBJS +=3D reftable/writer.o
>> 	-
>> 	-REFTABLE_TEST_OBJS +=3D reftable/basics_test.o
>> 	-REFTABLE_TEST_OBJS +=3D reftable/block_test.o
>> 	-REFTABLE_TEST_OBJS +=3D reftable/dump.o
>> 	-REFTABLE_TEST_OBJS +=3D reftable/merged_test.o
>> 	-REFTABLE_TEST_OBJS +=3D reftable/pq_test.o
>> 	-REFTABLE_TEST_OBJS +=3D reftable/record_test.o
>> 	-REFTABLE_TEST_OBJS +=3D reftable/readwrite_test.o
>> 	-REFTABLE_TEST_OBJS +=3D reftable/refname_test.o
>> 	-REFTABLE_TEST_OBJS +=3D reftable/stack_test.o
>> 	-REFTABLE_TEST_OBJS +=3D reftable/test_framework.o
>> 	-REFTABLE_TEST_OBJS +=3D reftable/tree_test.o
>> 	+REFTABLE_SOURCES =3D $(wildcard reftable/*.c)
>> 	+REFTABLE_OBJS +=3D $(filter-out test,$(REFTABLE_SOURCES:%.c=3D%.o))
>> 	+REFTABLE_TEST_OBJS +=3D $(filter test,$(REFTABLE_SOURCES:%.c=3D%.o))
>>=20=09
>> 	 TEST_OBJS :=3D $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/hel=
per/%,$(TEST_BUILTINS_OBJS))
>> We'd have a shorter Makefile, not need to manually maintain the
>> list,
>> and we'd have been getting linker errors all along on the dead code
>> (just showing one of many here):
>> 	$ make
>> 	[...]
>> 	/usr/bin/ld: reftable/libreftable.a(generic.o): in function `reftable_t=
able_seek_ref':
>> 	/home/avar/g/git/reftable/generic.c:17: multiple definition of `reftabl=
e_table_seek_ref'; reftable/libreftable.a(reftable.o):/home/avar/g/git/reft=
able/reftable.c:17: first defined here
>> 	[...]
>> 	clang: error: linker command failed with exit code 1 (use -v to see inv=
ocation)
>> 	make: *** [Makefile:2925: t/helper/test-tool] Error 1
>> 	make: Target 'all' not remade because of errors.
>
> Random cruft breaking the build was the reason I objected to this
> change, just because the cruft was being tracked by git in this case=20
> does not change that.

The difference is that the above is a "good" breakage, i.e. one where we
ended up carrying dead code in-tree, so it wouldn't have escaped the
lab.

Whereas I think that you're concerned that adding a WIP foobar.c to the
tree would break your compilation the next time you invoke 'make'.

Would something like this way of having our cake and eating it too
address your concerns?

I.e. if we have 'git' installed already we could just ask it about any
untracked files, and filter those out:
=20=20=20=20
    ifndef NO_WILDCARD_SECOND_GUESSING
    UNTRACKED_FILES :=3D $(shell git status --porcelain=3D1 2>/dev/null | s=
ed -n -e '/^\?? / { s/^.. //; p}')
    else
    UNTRACKED_FILES =3D
    endif
=20=20=20=20
    REFTABLE_SOURCES =3D $(filter-out $(UNTRACKED_FILES),$(wildcard reftabl=
e/*.c))
    REFTABLE_OBJS +=3D $(filter-out test,$(REFTABLE_SOURCES:%.c=3D%.o))
    REFTABLE_TEST_OBJS +=3D $(filter test,$(REFTABLE_SOURCES:%.c=3D%.o))

A non-demo implementation of this would piggy-back on the "git ls-files"
shell-out we already do, but since that requires some refactoring I
thought it would be better to demo it like this.
