Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8360ECAAA3
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 22:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiHYWz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 18:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244254AbiHYWzx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 18:55:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19094AEDA5
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 15:55:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w10so128230edc.3
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 15:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=RpaqxK18uEfPG2b1WBYaKOKQDCMfGWXq4fNQBqFsKgY=;
        b=WEGseHPa36TZwV1wq3nNXjeiKqIjbcPfpuPR4Op+4nvRqWF+w/JUqp4INx+BrdfIFW
         5hr/btn2FGuqzCBFQD39PgAM4MDZhbTpEg6Hw11DNnmOCgluKUL3e9D8j8TVWqRJzG8F
         g/NhEZDPvEFEAii8EE/zKKer4RxV8P8ZfgbGI8EfgkJekCRxp2QF6TEp74sttmvfqUIo
         4tVwXkfa7iH0/NN/nlgKs5JstXsHomhaziQYQ9hTMdEVv3eCzlvowSOc4716sTwR4udt
         fvpdlEjEuSv5MolzgbbiwQZrnR3qCRCOk1OPeTpmVho4MytMf3ZkYrASxnzO5HeECEpM
         J59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=RpaqxK18uEfPG2b1WBYaKOKQDCMfGWXq4fNQBqFsKgY=;
        b=7Sn2Kjs3VtPjiHBo5mEWj3GXO3TRin4mLoAmoVd9l6Xra+3khZmbNUabfJNzutmtX0
         QOcCRLkE5wiWcBMPCwvhzKYpOpoWT7Yfcx4m/swYPtDHLKfK3VCE4Nt2ctY8qA236RwR
         IVgYahn90osvqoZQd4PcM5CevFmQuRThz2fPcKQJ9ca6TMak6Vi6kMayWL0/SHHarkW+
         +OJnO8fMV3m59wNiXQzQprI6o/WpPcarznx2HTTfHAyD/FXEkEjxJVqxt1mpVAOG5rfD
         Rg2iebnH3ER4jrdeuCxAGa0hNB0FvcMOxiCM2oy5T6hvz5tiwoOrfCzlL/YsHBjCjyHu
         DGjA==
X-Gm-Message-State: ACgBeo2Lz5ymwduokfYUGiRuF/TAJAecEZKX/Z9r3014pgQ2F19gjkWR
        vQD4wF1cF39fM2Zh97RPpUA=
X-Google-Smtp-Source: AA6agR5/wIRL2/Oqn1UUq+m+0wopqBJnuEVjdXn4jHIvip46EXjI33JXXriWZXtNjrRH0nh4hnmRmQ==
X-Received: by 2002:a05:6402:350b:b0:43e:f4be:c447 with SMTP id b11-20020a056402350b00b0043ef4bec447mr4893439edd.427.1661468148910;
        Thu, 25 Aug 2022 15:55:48 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906538100b007308bebce51sm158611ejo.171.2022.08.25.15.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:55:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oRLlL-001TM4-1e;
        Fri, 26 Aug 2022 00:55:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] cocci: make "coccicheck" rule incremental
Date:   Fri, 26 Aug 2022 00:18:28 +0200
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
 <patch-3.5-6fa83695f1f-20220825T141212Z-avarab@gmail.com>
 <20220825194418.GI1735@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220825194418.GI1735@szeder.dev>
Message-ID: <220826.861qt43pcc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 25 2022, SZEDER G=C3=A1bor wrote:

Thanks for taking a look!

> On Thu, Aug 25, 2022 at 04:36:15PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> * Since we create a single "*.cocci.patch+" we don't know where to
>>   pick up where we left off. Note that (per [1]) we've had a race
>>   condition since 960154b9c17 (coccicheck: optionally batch spatch
>>   invocations, 2019-05-06) which might result in us producing corrupt
>>   patches to to the concurrent appending to "$@+" in the pre-image.
>>=20
>>   That bug is now fixed.
>
> There is no bug, because there is no concurrent appending to "$@+".
> The message you mention seems to be irrelevant, as it talks about
> 'xargs -P', but the invocation in '%.cocci.patch' targets never used
> '-P'.

I think this is just confusing, I'll amend/rephrase.

And at this point I honestly can't remember if I'm conflating this with
an issue with my earlier proposed series here (I drafted this a while
ago), or a rather obscure "hidden" feature that I did use to speed up
coccicheck for myself for a while. Which is that you can do e.g.:

	make coccicheck SPATCH_BATCH_SIZE=3D"8 -P 8"

Which will invoke xargs with the "-P 8" option in batches of 8 files.

That's never a thing that 960154b9c17 expected, and it only worked as an
accident, but it *would* work, and unless you got unlucky with the races
involved would generally speed up your coccicheck.

>> Which is why we'll not depend on $(FOUND_H_SOURCES) but the *.o file
>> corresponding to the *.c file, if it exists already. This means that
>> we can do:
>>=20
>>     make all
>>     make coccicheck
>>     make -W column.h coccicheck
>>=20
>> By depending on the *.o we piggy-back on
>> COMPUTE_HEADER_DEPENDENCIES. See c234e8a0ecf (Makefile: make the
>> "sparse" target non-.PHONY, 2021-09-23) for prior art of doing that
>> for the *.sp files. E.g.:
>>=20
>>     make contrib/coccinelle/free.cocci.patch
>>     make -W column.h contrib/coccinelle/free.cocci.patch
>>=20
>> Will take around 15 seconds for the second command on my 8 core box if
>> I didn't run "make" beforehand to create the *.o files. But around 2
>> seconds if I did and we have those "*.o" files.
>>=20
>> Notes about the approach of piggy-backing on *.o for dependencies:
>>=20
>> * It *is* a trade-off since we'll pay the extra cost of running the C
>>   compiler, but we're probably doing that anyway.
>
> This assumption doesn't hold, and I very much dislike the idea of
> depending on *.o files:

It's my fault for not calling this out more explicitly, but it
*optionally* depends on the *.o files, but if you don't have them
compiled already a "make coccicheck" will just use "spatch", and nothing
else.

See the CI run/output for this series:
https://github.com/avar/git/runs/8017916844?check_suite_focus=3Dtrue

>   - Our static-analysis CI job doesn't build Git, now it will have to.

Aside from this series which doesn't change how it works, maintaining
this doesn't seem important to me. E.g. as I noted in [1] coccinelle
will happily run on code that doesn't even compile.

So running the compiler during "static-analysis" (or another step that
it would depend on, maybe "pedantic" or "sparse") seems like a good (but
separate change).

You don't want to wonder about odd coccinelle output, only to see it's
trying to make sense of C source that doesn't even compile.

>   - I don't have Coccinelle installed, because my distro doesn't ship
>     it, and though the previous release did ship it, it was outdated.
>     Instead I use Coccinelle's most recent version from a container
>     which doesn't contain any build tools apart from 'make' for 'make
>     coccicheck'.
>
>     With this patch series I can't use this containerized Coccinelle
>     at all, because even though I've already built git on the host,
>     the dependency on *.o files triggers a BUILD-OPTIONS check during
>     'make coccicheck', and due to the missing 'curl-config' the build
>     options do differ, triggering a rebuild, which in the absence of a
>     compiler fails.
>
>     And then the next 'make' on the host will have to rebuild
>     everything again...

There may be some odd interaction here, but it's unclear if you've
actually tried to do this with this series, because unless I've missed
some edge case this should all still work, per the above.

What *won't* work is avoiding potential re-compilation of *.o files if
you *have them already* when you run "make coccicheck". I'm not familiar
with this type of setup, are you saying you're running "make coccicheck"
on a working directory that already has *.o files, but you want it to
ignore the *.o?

That could easily be made optional, but I just assumed that nobody would
care. If you want that can you try this on top and see if it works for
you?:
=09
	diff --git a/Makefile b/Makefile
	index 9410a587fc0..11d83c490b4 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -3174,6 +3174,11 @@ TINY_FOUND_H_SOURCES +=3D strbuf.h
	 	$(call mkdir_p_parent_template)
	 	$(QUIET_GEN) >$@
=09=20
	+SPATCH_USE_O_DEPENDENCIES =3D yes
	+ifeq ($(COMPUTE_HEADER_DEPENDENCIES),no)
	+SPATCH_USE_O_DEPENDENCIES =3D
	+endif
	+
	 define cocci-rule
=09=20
	 ## Rule for .build/$(1).patch/$(2); Params:
	@@ -3181,7 +3186,7 @@ define cocci-rule
	 # 2 =3D $(2)
	 COCCI_$(1:contrib/coccinelle/%.cocci=3D%) +=3D .build/$(1).patch/$(2)
	 .build/$(1).patch/$(2): GIT-SPATCH-DEFINES
	-.build/$(1).patch/$(2): $(if $(wildcard $(3)),$(3),$(if $(filter $(USE_TI=
NY_FOUND_H_SOURCES),$(3)),$(TINY_FOUND_H_SOURCES),.build/contrib/coccinelle=
/FOUND_H_SOURCES))
	+.build/$(1).patch/$(2): $(if $(and $(SPATCH_USE_O_DEPENDENCIES),$(wildcar=
d $(3))),$(3),$(if $(filter $(USE_TINY_FOUND_H_SOURCES),$(3)),$(TINY_FOUND_=
H_SOURCES),.build/contrib/coccinelle/FOUND_H_SOURCES))
	 .build/$(1).patch/$(2): $(1)
	 .build/$(1).patch/$(2): .build/$(1).patch/% : %
	 	$$(call mkdir_p_parent_template)

I'd need to split up the already long line, but with *.o files compiled
and:
=09
	$ time make -W column.h contrib/coccinelle/free.cocci.patch COMPUTE_HEADER=
_DEPENDENCIES=3Dyes
	    CC wt-status.o
	    CC builtin/branch.o
	    CC builtin/clean.o
	    CC builtin/column.o
	    CC builtin/commit.o
	    CC builtin/tag.o
	    CC column.o
	    CC help.o
	    SPATCH .build/contrib/coccinelle/free.cocci.patch/builtin/commit.c
	    SPATCH .build/contrib/coccinelle/free.cocci.patch/builtin/tag.c
	    SPATCH .build/contrib/coccinelle/free.cocci.patch/builtin/column.c
	    SPATCH .build/contrib/coccinelle/free.cocci.patch/column.c
	    SPATCH .build/contrib/coccinelle/free.cocci.patch/wt-status.c
	    SPATCH .build/contrib/coccinelle/free.cocci.patch/builtin/branch.c
	    SPATCH .build/contrib/coccinelle/free.cocci.patch/builtin/clean.c
	    SPATCH .build/contrib/coccinelle/free.cocci.patch/help.c
	    SPATCH MERGE contrib/coccinelle/free.cocci.patch
=09
	real    0m0.550s
	user    0m0.505s
	sys     0m0.096s

But if you set COMPUTE_HEADER_DEPENDENCIES=3Dyes it'll take ~4s (on that
box), and well re-apply the free.cocci rule to all the *.c files (and
this is all with the caching mechanism in 5/5, real "spatch" will be
much slower).

If you already have git compiled (or partially compiled) the "happy
path" to avoiding work is almost definitely to re-compile that *.o
because the *.c changed, at which point we'll be able to see if we even
need to re-run any of the coccinelle rules. Usually we'll need to re-run
a far smaller set than the full set we operate on now.

>>  * We can take better advantage of parallelism, while making sure that
>>    we don't racily append to the contrib/coccinelle/swap.cocci.patch
>>    file from multiple workers.
>>=20
>>    Before this change running "make coccicheck" would by default end
>>    up pegging just one CPU at the very end for a while, usually as
>>    we'd finish whichever *.cocci rule was the most expensive.
>>=20
>>    This could be mitigated by combining "make -jN" with
>>    SPATCH_BATCH_SIZE, see 960154b9c17 (coccicheck: optionally batch
>>    spatch invocations, 2019-05-06). But doing so required careful
>>    juggling, as e.g. setting both to 4 would yield 16 workers.
>
> No, setting both to 4 does yield 4 workers.
>
> SPATCH_BATCH_SIZE has nothing to do with parallelism; it is merely the
> number of C source files that we pass to a single 'spatch' invocation,
> but for any given semantic patch it's still a sequential loop.

Thanks, will fix. I see I conflated SPATCH_BATCH_SIZE with spatch's
--jobs there (although from experimentation that seems to have pretty
limited parallelism).

1. https://lore.kernel.org/git/220825.86ilmg4mil.gmgdl@evledraar.gmail.com/
