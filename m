Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08CCC433E6
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB0276509F
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhCERVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 12:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCERUv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 12:20:51 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5FDC061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 09:20:50 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lr13so4931787ejb.8
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 09:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GfWETT/vfupVKkYoN+hGhprwhgaA22eDR0dBTFDNH7o=;
        b=aBjj7omykDV0z2GemxGRsmPlGSbhRKUu7CBdmDorM0zOEs3edxKcsbdQ43U0MQBCSL
         cKgiYY/0wilmBnCAn/QJptsZYdS7vKwhW8stmeSAANkutEmLjQZbV9T/9wBbwBI0vyWC
         c5LwNWoNOLw4NMLpy8Gw7ZLpIIQl3exOrr5/urNry3Bq90KgfGPPdrVqq2cNtNVQCmBo
         0AmdcnR0hRUYPLerDlgFXTLcW1ZGJmlF83ECeD0xo6Vh3OyldGaIwAfZT3Sq9ZF6E4VZ
         KMTbpuF3oe4ly+KI8DFwg+sKDhXXgQ71N+ird7M0q/PvbMVGwxpE8yvka3A++rZMO+0X
         WhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=GfWETT/vfupVKkYoN+hGhprwhgaA22eDR0dBTFDNH7o=;
        b=JXZ3OhjxOhyk0OnrlRia8JH1KqqbXgUAGbvS/EZnFfYZ5r1KwXvzYVO3gMqDW2bJON
         UIHmf/RJD7LJASWpj/0pKQQGNR/kk0O9Qi0uWH3oXOB3Ng6QxyENTNlb9accXx2ruuKO
         YmCC26RP9OPe4LdG3Dr3jtWYJZSKoDu/D3nvNCZWK4tAJYL+axhzhtyKxTfu6NXfSx5a
         rp0OBmcEQ5Met4TmM0e9uzlX+fkLdgb1UlFVb4PxrmjdQRKqVh8y6TwDeLIgSc63lt/V
         h76VFRhUtw5JVQ7S6+TlvwCuIlfbwDTqnWDLWYAMktBXAhdkuFvjH1rp/IvyCt2WF6Gm
         6JEw==
X-Gm-Message-State: AOAM531uQrCNOddCqKFzht0mPqo58Azcg472ZJiCWVHvHtUbS640gS+r
        d1IRMBYK8vOUaBIjvqXwys8=
X-Google-Smtp-Source: ABdhPJyktzgsuLiVEMAmRU9lUVle6Zf2DFUQcM5zYCXd0TnfyQ3vxSx5dpkKXejvwU2jy2+MiP2PxQ==
X-Received: by 2002:a17:906:c1ca:: with SMTP id bw10mr3212309ejb.510.1614964849491;
        Fri, 05 Mar 2021 09:20:49 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e8sm1895963edq.77.2021.03.05.09.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:20:49 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH] Makefile: fix bugs in coccicheck and speed it up
References: <20190506234334.GA13296@sigill.intra.peff.net>
 <20210302205103.12230-1-avarab@gmail.com>
 <YEIGzXMDax83cwAx@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YEIGzXMDax83cwAx@coredump.intra.peff.net>
Date:   Fri, 05 Mar 2021 18:20:47 +0100
Message-ID: <87im65tt3k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 05 2021, Jeff King wrote:

I sent out a v2 that should address your feedback in :
https://lore.kernel.org/git/20210305170724.23859-1-avarab@gmail.com/

Just brief notes:

> On Tue, Mar 02, 2021 at 09:51:03PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> What we were doing before was processing all our *.c files, and for
>> each of those *.c files we'd recursively look around for includes and
>> see if we needed to search/replace in those too.
>>=20
>> That we did that dates back to [1] when we were only processing *.c
>> files, and it was always very redundant. We'd e.g. visit the likes of
>> strbuf.h lots of times since it's widely used as an include.
>
> OK. I don't offhand know if processing the includes along with the C
> files buys us anything else. Coccinelle's behavior is often quite a
> mystery, but if we think this produces the same results with less time,
> I'm for it.
>
> BTW, this "dates back to when we were only processing *.c files"
> statement confused me a bit. Doesn't that include the current state
> before this patch?  I.e., this hunk:
>
>> -FOUND_C_SOURCES =3D $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
>> +FOUND_C_SOURCES =3D $(filter %.c %.h,$(shell $(FIND_SOURCE_FILES)))
>
> seems to be an important part of the change, without which moving away
> from --all-includes would be wrong.

Updated in the new 2/4 commit message.

>> Then in the most recent attempt to optimize coccicheck in [2] this
>> anti-pattern finally turned into a bug.
>>
>> Namely: before this change, if your coccicheck rule applied to
>> e.g. making a change in strbuf.h itself we'd get *lots* of duplicate
>> hunks applying the exact same change, as concurrent spatch processes
>> invoked by xargs raced one another. In one instance I ended up with 27
>> copies of the same hunk in a strbuf.patch.
>>=20
>> Setting SPATCH_BATCH_SIZE=3D0 and processing all the files in one giant
>> batch mitigated this. I suspect the author of [2] either mostly ran in
>> that mode, or didn't test on changes that impacted widely used header
>> files.
>
> This "turned into a bug" I didn't understand, though. That commit [2]
> just switched from always feeding files one at a time to letting you
> feed more than one.  So yes, feeding all at once (with
> SPATCH_BATCH_SIZE=3D0) mitigated the bug. But wouldn't any bug that shows
> up with SPATCH_BATCH_SIZE=3D1 have already existed previously?
>
> IOW, I don't think the batch-size stuff made anything worse. It made one
> specific case better, but that was not even its purpose.
>
> That is maybe splitting hairs, but I want to make sure I understand all
> of what you're claiming here. But also...

Explained in the new 2/4. Your commit introduced a regression, because
spatch does racy magic background locking, running N of them at a time
applying the same rule tripped it up.

I suspect it was racy before, but we didn't have overlapping rules in
multiple *.cocci files.

>> I'm entirely removing SPATCH_BATCH_SIZE. If you want to tweak it you
>> can tweak SPATCH_XARGS_FLAGS to e.g. "-n 256", or "-P 4 -n 128". But
>> in my testing it isn't worth it to tweak SPATCH_XARGS_FLAGS for a full
>> "make coccicheck".
>
> You hard-code this to 32 now. But I'm not sure if that's going to be the
> universal best value.
>
> Applying just part of your patch, but leaving SPATCH_BATCH_SIZE in
> place, like so:
>
> diff --git a/Makefile b/Makefile
> index dfb0f1000f..88cb157547 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1201,7 +1201,7 @@ SP_EXTRA_FLAGS =3D -Wno-universal-initializer
>  # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
>  # usually result in less CPU usage at the cost of higher peak memory.
>  # Setting it to 0 will feed all files in a single spatch invocation.
> -SPATCH_FLAGS =3D --all-includes --patch .
> +SPATCH_FLAGS =3D --no-includes --patch .
>  SPATCH_BATCH_SIZE =3D 1
>=20=20
>  include config.mak.uname
> @@ -2859,7 +2859,7 @@ check: config-list.h command-list.h
>  		exit 1; \
>  	fi
>=20=20
> -FOUND_C_SOURCES =3D $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
> +FOUND_C_SOURCES =3D $(filter %.c %.h,$(shell $(FIND_SOURCE_FILES)))
>  COCCI_SOURCES =3D $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
>=20=20
>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
>
> Then I get this with various batch sizes (using "make -j16" on an 8-core
> machine, so all of the patches are being run at the same time):
>
>   size |  real  |  user  | sys
>   -------------------------------
>     1  |  1m28s | 10m00s | 0m56s
>     2  |  1m03s |  7m49s | 0m33s
>     4  |  0m51s |  6m28s | 0m20s
>     8  |  0m45s |  6m02s | 0m14s
>    16  |  0m45s |  6m17s | 0m10s
>    32  |  0m44s |  6m33s | 0m07s
>    64  |  0m45s |  6m48s | 0m06s
>     0  |  1m08s | 10m08s | 0m03s
>
> So there's a sweet spot at 8. Doing "32" isn't that much worse (runtime
> is about the same, but we use more CPU), but it gets progressively worse
> as the batch size increases.
>
> That's the same sweet spot before your patch, too, btw. I know because I
> happened to be timing it the other day, as coccinelle 1.1.0 hit debian
> unstable. When I originally wrote the SPATCH_BATCH_SIZE feature, I think
> I was using 1.0.4 or 1.0.7. Back then SPATCH_BATCH_SIZE=3D0 was a clear
> win, assuming you had the memory. But in 1.0.8 it ran for many minutes
> without finishing. I found back then that "2" was the sweet spot. But
> now it's "8".
>
> All of which is to say: the timing difference between my "8" and "32"
> cases isn't that exciting. But the performance of spatch has been
> sufficiently baffling to me that I think it's worth keeping the knob.
>
> Your XARGS_FLAGS does accomplish something similar (and is in fact more
> flexible, though at the cost of being less abstract).  I'm OK to replace
> one with the other, but shouldn't it happen in a separate patch? It's
> completely orthogonal to the --no-includes behavior.

*nod*, set to a default of 8 in the new 4/4.

>> I'm also the whole "cat $@.log" introduced in [3]. Since we don't call
>> this in a loop anymore (and xargs will early-exit) we can just rely on
>> standard V=3D1 for debugging issues.
>
> I think this is missing the point of the cat. We've redirected spatch's
> stderr to the logfile. So if there's an error, you have no idea what it
> was without manually figuring out which file to cat. And V=3D1 doesn't
> help that.
>
> We could stop doing that redirection, but the problem is that spatch is
> very verbose. So the point was to store the output but only dump it
> when we see an error.
>
> So this part of the patch seems like a pure regression to me. E.g.,
> introduce a syntax error like:
>
> diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
> index 4490069df9..c6c6562a0a 100644
> --- a/contrib/coccinelle/free.cocci
> +++ b/contrib/coccinelle/free.cocci
> @@ -11,7 +11,7 @@ expression E;
>    free(E);
>=20=20
>  @@
> -expression E;
> +expression E
>  @@
>  - free(E);
>  + FREE_AND_NULL(E);
>
> and run "make coccicheck" before and after your patch:
>
>   [before]
>   $ make coccicheck
>   GIT_VERSION =3D 2.31.0.rc1.8.gbe7935ed8b.dirty
>       SPATCH contrib/coccinelle/free.cocci
>   init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
>   meta: parse error:=20
>     File "contrib/coccinelle/free.cocci", line 15, column 0, charpos =3D =
99
>     around =3D '@@',
>     whole content =3D @@
>
>   xargs: spatch: exited with status 255; aborting
>   make: *** [Makefile:2866: contrib/coccinelle/free.cocci.patch] Error 1
>
>   [after]
>   $ make coccicheck
>     SPATCH contrib/coccinelle/free.cocci
>   make: *** [Makefile:2875: contrib/coccinelle/free.cocci.patch] Error 124

The "cat $@.log" is back, but there's still some issues with it on
master now (I didn't change this) it'll spew a lot at you with xargs
since we emit the whole error output for every file, seemingly, before
cat-ing the file:

    make -j1 coccicheck SPATCH_FLAGS=3D--blahblah V=3D1 2>&1|grep -i exampl=
e.*use|wc -l
    464

Well, it's a bit better now on my series with a default batch size of 8:

    $ make -j1 coccicheck SPATCH_FLAGS=3D--blahblah V=3D1 2>&1|grep -i exam=
ple.*use|wc -l
    88

I got tired of dealing with the combination of shellscritp and make for
the day. But maybe something to do as a follow-up if anyone's
interested.
