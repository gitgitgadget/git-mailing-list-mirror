Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC6AECAAA3
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 10:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245269AbiHZKnU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 06:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiHZKnR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 06:43:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0BBD83CD
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 03:43:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id lx1so2342225ejb.12
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 03:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=ko5E5qf25vqlqoWKsMPMG9fHrknnr73OxVxRAVHGqHQ=;
        b=J6GkFFq/HIJPOKlEeGk15V46uxcisdIxNpb2hPdkWUNBGELYjogRjIjysAkf2sqWIM
         kuCP+r0JuWaMJ1ZFpbtzvOL9qS5RDPQvN2gOQ5jsbM6dDU932rl6uxQjTbclHPGAWGLS
         dZRo7uIk8OoSie7gjwih3ee+7MnQfzfpi3U9s0xF1z6QWADBCG3s9WAujTRLclzD+1/V
         IGdTcmY0HSrG40prLe5rG/NkPVRbDwtWWX259wMPPF5wz13CL4VDRfkCtCb568HImOVR
         T6SdLWR7VmpF90arIaYvUFjaY+KYsvxL2BTOgX7VqIdxx+0ewOjywP9dKZBgFNksrCCw
         hWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=ko5E5qf25vqlqoWKsMPMG9fHrknnr73OxVxRAVHGqHQ=;
        b=JyXu5Nu4rK8lwantIGYhGYQzpmZVDMAB1bcq82+6drrSJKM4n+8KhO7MWK//4x9hQT
         bZg5w3TyNqhfFx14Y1zCWEy79S5Az1Cvz2C4KmQ3Mo5rS1u0Zk/Laj/RSLU8ZMR2HmGc
         4ullcedjMrKqZTJ1iYDlep6eEEINpb9dENLXXgnJ4ZFq6vWuwGukc+iLUf+OtE37NWR8
         u5aPm5ZMNtI+O48DDtPOUyYaNpS6vxUSgHAvjKoOtj3UvExOC8/RTYbmexXQmhy1Xswz
         FiSZu7OVUz8dm2HYIe/PGT1j2qf+fU7/hZrfZ8G9br2zoMbpbfRag2R/FCeUSAjaTHAM
         QSPg==
X-Gm-Message-State: ACgBeo0h3ITwKPqsf91tNG64QzteXLso2mdFALG2jZlUYqMlQWHIEtNX
        Elqj/hhUr9AN4Y6Kb4WSfAU=
X-Google-Smtp-Source: AA6agR5nDgMUh2ncSaiu/7DAeLweORFRVkwDvay7FSoTSW5ZKT39RiBzsIRCOP7usu+Bo5ovFdhlhg==
X-Received: by 2002:a17:906:58ca:b0:73d:c7d5:bb39 with SMTP id e10-20020a17090658ca00b0073dc7d5bb39mr5123620ejs.305.1661510594499;
        Fri, 26 Aug 2022 03:43:14 -0700 (PDT)
Received: from localhost (78-131-17-114.pool.digikabel.hu. [78.131.17.114])
        by smtp.gmail.com with ESMTPSA id t1-20020a17090616c100b0073100dfa7b5sm764714ejd.33.2022.08.26.03.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 03:43:13 -0700 (PDT)
Date:   Fri, 26 Aug 2022 12:43:12 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] cocci: make "coccicheck" rule incremental
Message-ID: <20220826104312.GJ1735@szeder.dev>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
 <patch-3.5-6fa83695f1f-20220825T141212Z-avarab@gmail.com>
 <20220825194418.GI1735@szeder.dev>
 <220826.861qt43pcc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220826.861qt43pcc.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2022 at 12:18:28AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Aug 25 2022, SZEDER Gábor wrote:
> 
> Thanks for taking a look!
> 
> > On Thu, Aug 25, 2022 at 04:36:15PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> * Since we create a single "*.cocci.patch+" we don't know where to
> >>   pick up where we left off. Note that (per [1]) we've had a race
> >>   condition since 960154b9c17 (coccicheck: optionally batch spatch
> >>   invocations, 2019-05-06) which might result in us producing corrupt
> >>   patches to to the concurrent appending to "$@+" in the pre-image.
> >> 
> >>   That bug is now fixed.
> >
> > There is no bug, because there is no concurrent appending to "$@+".
> > The message you mention seems to be irrelevant, as it talks about
> > 'xargs -P', but the invocation in '%.cocci.patch' targets never used
> > '-P'.
> 
> I think this is just confusing, I'll amend/rephrase.
> 
> And at this point I honestly can't remember if I'm conflating this with
> an issue with my earlier proposed series here (I drafted this a while
> ago), or a rather obscure "hidden" feature that I did use to speed up
> coccicheck for myself for a while. Which is that you can do e.g.:
> 
> 	make coccicheck SPATCH_BATCH_SIZE="8 -P 8"
> 
> Which will invoke xargs with the "-P 8" option in batches of 8 files.

Abusing SPATCH_BATCH_SIZE to try to shoot yourself in the foot
definitely doesn't qualify as "bug" in my book :)

> That's never a thing that 960154b9c17 expected, and it only worked as an
> accident, but it *would* work, and unless you got unlucky with the races
> involved would generally speed up your coccicheck.
> 
> >> Which is why we'll not depend on $(FOUND_H_SOURCES) but the *.o file
> >> corresponding to the *.c file, if it exists already. This means that
> >> we can do:
> >> 
> >>     make all
> >>     make coccicheck
> >>     make -W column.h coccicheck
> >> 
> >> By depending on the *.o we piggy-back on
> >> COMPUTE_HEADER_DEPENDENCIES. See c234e8a0ecf (Makefile: make the
> >> "sparse" target non-.PHONY, 2021-09-23) for prior art of doing that
> >> for the *.sp files. E.g.:
> >> 
> >>     make contrib/coccinelle/free.cocci.patch
> >>     make -W column.h contrib/coccinelle/free.cocci.patch
> >> 
> >> Will take around 15 seconds for the second command on my 8 core box if
> >> I didn't run "make" beforehand to create the *.o files. But around 2
> >> seconds if I did and we have those "*.o" files.
> >> 
> >> Notes about the approach of piggy-backing on *.o for dependencies:
> >> 
> >> * It *is* a trade-off since we'll pay the extra cost of running the C
> >>   compiler, but we're probably doing that anyway.
> >
> > This assumption doesn't hold, and I very much dislike the idea of
> > depending on *.o files:
> 
> It's my fault for not calling this out more explicitly, but it
> *optionally* depends on the *.o files, but if you don't have them
> compiled already a "make coccicheck" will just use "spatch", and nothing
> else.
> 
> See the CI run/output for this series:
> https://github.com/avar/git/runs/8017916844?check_suite_focus=true
> 
> >   - Our static-analysis CI job doesn't build Git, now it will have to.
> 
> Aside from this series which doesn't change how it works, maintaining
> this doesn't seem important to me. E.g. as I noted in [1] coccinelle
> will happily run on code that doesn't even compile.
> 
> So running the compiler during "static-analysis" (or another step that
> it would depend on, maybe "pedantic" or "sparse") seems like a good (but
> separate change).

It seems like a bad and undesired change to me.  We have plenty of
other jobs that do build Git.  It's just a waste of time to do it in a
job that doesn't actually need it.

> You don't want to wonder about odd coccinelle output, only to see it's
> trying to make sense of C source that doesn't even compile.

You don't even want to look at Coccinelle output at all, if any of the
other jobs were to fail for whatever reason.

> >   - I don't have Coccinelle installed, because my distro doesn't ship
> >     it, and though the previous release did ship it, it was outdated.
> >     Instead I use Coccinelle's most recent version from a container
> >     which doesn't contain any build tools apart from 'make' for 'make
> >     coccicheck'.
> >
> >     With this patch series I can't use this containerized Coccinelle
> >     at all, because even though I've already built git on the host,
> >     the dependency on *.o files triggers a BUILD-OPTIONS check during
> >     'make coccicheck', and due to the missing 'curl-config' the build
> >     options do differ, triggering a rebuild, which in the absence of a
> >     compiler fails.
> >
> >     And then the next 'make' on the host will have to rebuild
> >     everything again...
> 
> There may be some odd interaction here, but it's unclear if you've
> actually tried to do this with this series, because unless I've missed
> some edge case this should all still work, per the above.

It did not work:

  # Host:
  $ make
    SUBDIR git-gui
    SUBDIR gitk-git
    SUBDIR templates

  # Container:
  $ time make coccicheck -j4 SPATCH_FLAGS=--all-includes
  GIT_VERSION = 2.37.GIT
  make: curl-config: Command not found
      * new build flags
      CC chdir-notify.o
      CC imap-send.o
  /bin/sh: 1: gcc-10: not found
  /bin/sh: 1: gcc-10: not found
  make: *** [Makefile:2605: chdir-notify.o] Error 127
  make: *** Waiting for unfinished jobs....
  make: *** [Makefile:2605: imap-send.o] Error 127
      CC usage.o
  /bin/sh: 1: gcc-10: not found
  make: *** [Makefile:2605: usage.o] Error 127

  # Host again:
  $ make
  GIT_VERSION = 2.37.2.387.g804ba1c054
      * new build flags
      CC fuzz-commit-graph.o
  [ ... rebuild ... ]

> What *won't* work is avoiding potential re-compilation of *.o files if
> you *have them already* when you run "make coccicheck". I'm not familiar
> with this type of setup, are you saying you're running "make coccicheck"
> on a working directory that already has *.o files, but you want it to
> ignore the *.o?
> 
> That could easily be made optional, but I just assumed that nobody would
> care. If you want that can you try this on top and see if it works for
> you?:
> 	
> 	diff --git a/Makefile b/Makefile
> 	index 9410a587fc0..11d83c490b4 100644
> 	--- a/Makefile
> 	+++ b/Makefile
> 	@@ -3174,6 +3174,11 @@ TINY_FOUND_H_SOURCES += strbuf.h
> 	 	$(call mkdir_p_parent_template)
> 	 	$(QUIET_GEN) >$@
> 	 
> 	+SPATCH_USE_O_DEPENDENCIES = yes
> 	+ifeq ($(COMPUTE_HEADER_DEPENDENCIES),no)
> 	+SPATCH_USE_O_DEPENDENCIES =
> 	+endif
> 	+
> 	 define cocci-rule
> 	 
> 	 ## Rule for .build/$(1).patch/$(2); Params:
> 	@@ -3181,7 +3186,7 @@ define cocci-rule
> 	 # 2 = $(2)
> 	 COCCI_$(1:contrib/coccinelle/%.cocci=%) += .build/$(1).patch/$(2)
> 	 .build/$(1).patch/$(2): GIT-SPATCH-DEFINES
> 	-.build/$(1).patch/$(2): $(if $(wildcard $(3)),$(3),$(if $(filter $(USE_TINY_FOUND_H_SOURCES),$(3)),$(TINY_FOUND_H_SOURCES),.build/contrib/coccinelle/FOUND_H_SOURCES))
> 	+.build/$(1).patch/$(2): $(if $(and $(SPATCH_USE_O_DEPENDENCIES),$(wildcard $(3))),$(3),$(if $(filter $(USE_TINY_FOUND_H_SOURCES),$(3)),$(TINY_FOUND_H_SOURCES),.build/contrib/coccinelle/FOUND_H_SOURCES))
> 	 .build/$(1).patch/$(2): $(1)
> 	 .build/$(1).patch/$(2): .build/$(1).patch/% : %
> 	 	$$(call mkdir_p_parent_template)

OK, with these changes on top I can run 'make coccicheck' in the
container after Git was built on the host.

And I noticed a few behavior changes:

  - 'make coccicheck' currently prints ~"Nr-of-semantic-patches"
    lines, but with this change it grows to "Nr-of-semantic-patches *
    Nr-of-source-files" lines.

    I didn't like this when I did something similar a few years ago in

      https://public-inbox.org/git/20180802115522.16107-1-szeder.dev@gmail.com/

    and I don't like it now, either, but oh well, there is always
    'make -s' (though Peff thought it's "eye candy" back then :).

  - Any transformation found during 'make coccicheck' is now
    considered an error.

    With 'SPATCH_FLAGS=--recursive-includes' I got this:

      [... gazillions of SPATCH .build/... lines ... ]
          SPATCH .build/contrib/coccinelle/hashmap.cocci.patch/config.c
          SPATCH MERGE contrib/coccinelle/array.cocci.patch
          SPATCH MERGE contrib/coccinelle/commit.cocci.patch
          SPATCH MERGE contrib/coccinelle/xcalloc.cocci.patch
          SPATCH MERGE contrib/coccinelle/preincr.cocci.patch
          SPATCH MERGE contrib/coccinelle/free.cocci.patch
          SPATCH MERGE contrib/coccinelle/equals-null.cocci.patch
          SPATCH MERGE contrib/coccinelle/xopen.cocci.patch
          SPATCH MERGE contrib/coccinelle/qsort.cocci.patch
          SPATCH MERGE contrib/coccinelle/xstrdup_or_null.cocci.patch
          SPATCH MERGE contrib/coccinelle/swap.cocci.patch
          SPATCH MERGE contrib/coccinelle/strbuf.cocci.patch
          SPATCH MERGE contrib/coccinelle/object_id.cocci.patch
          SPATCH MERGE contrib/coccinelle/flex_alloc.cocci.patch
          SPATCH RESULT contrib/coccinelle/array.cocci.patch
          SPATCH RESULT contrib/coccinelle/commit.cocci.patch
          SPATCH RESULT contrib/coccinelle/xcalloc.cocci.patch
              diff -u -p a/promisor-remote.c b/promisor-remote.c
              --- a/promisor-remote.c
              +++ b/promisor-remote.c
              @@ -146,7 +146,7 @@ static void promisor_remote_init(struct
               	if (r->promisor_remote_config)
               		return;
               	config = r->promisor_remote_config =
              -		xcalloc(sizeof(*r->promisor_remote_config), 1);
              +		xcalloc(1, sizeof(*r->promisor_remote_config));
               	config->promisors_tail = &config->promisors;
               
               	repo_config(r, promisor_remote_config, config);
      make: *** [Makefile:3218: .build/contrib/coccinelle/xcalloc.cocci.patch.ok] Error 1
      make: *** Waiting for unfinished jobs....

    So it seems that if more than one semantic patches find something
    to transform, then only the transformations from the first will
    be generated (and printed).

    Note, however, that if transformations are found while "manually"
    applying semantic patches, i.e. running 'make foo.cocci.patch',
    then it's not an error.

  - The resulting transformations from (only one of) the semantic
    patches are now printed at the end of 'make coccicheck'.  I doubt
    it's desirable, but even if it is, it's an independent change, and
    the static analysis CI job needs a corresponding update, because
    it already 'cat's all non-empty '.cocci.patch' files.

    Note, however, that if transformations are found while "manually"
    applying semantic patches, then neither the transformations are
    printed, nor anything that would indicate that there were any
    transformations.

  - As I remember before this series the SPATCH TESTs were always run
    first during 'make coccicheck'.  I don't know whether that was
    intentional and there were dependencies to enforce that order, or
    'make' just happened to schedule them in that order on my system.
    Or maybe I'm just misremembering, but it does make sense to me to
    run those tests first (or at least before applying the
    corresponding semantic patches to the whole tree).

    With this series the tests were run near the end:

      [...]
      SPATCH .build/contrib/coccinelle/unused.cocci.patch/git.c
      SPATCH .build/contrib/coccinelle/unused.cocci.patch/color.c
      MKDIR -p .build/contrib/coccinelle/tests
      SPATCH TEST contrib/coccinelle/tests/unused.res
      SPATCH TEST contrib/coccinelle/tests/free.res
      SPATCH .build/contrib/coccinelle/hashmap.cocci.patch/upload-pack.c
      SPATCH .build/contrib/coccinelle/hashmap.cocci.patch/merge-ort-wrappers.c
      [...]

    'hashmap.cocci' happened to be applied last.

> I'd need to split up the already long line, but with *.o files compiled
> and:
> 	
> 	$ time make -W column.h contrib/coccinelle/free.cocci.patch COMPUTE_HEADER_DEPENDENCIES=yes
> 	    CC wt-status.o
> 	    CC builtin/branch.o
> 	    CC builtin/clean.o
> 	    CC builtin/column.o
> 	    CC builtin/commit.o
> 	    CC builtin/tag.o
> 	    CC column.o
> 	    CC help.o
> 	    SPATCH .build/contrib/coccinelle/free.cocci.patch/builtin/commit.c
> 	    SPATCH .build/contrib/coccinelle/free.cocci.patch/builtin/tag.c
> 	    SPATCH .build/contrib/coccinelle/free.cocci.patch/builtin/column.c
> 	    SPATCH .build/contrib/coccinelle/free.cocci.patch/column.c
> 	    SPATCH .build/contrib/coccinelle/free.cocci.patch/wt-status.c
> 	    SPATCH .build/contrib/coccinelle/free.cocci.patch/builtin/branch.c
> 	    SPATCH .build/contrib/coccinelle/free.cocci.patch/builtin/clean.c
> 	    SPATCH .build/contrib/coccinelle/free.cocci.patch/help.c
> 	    SPATCH MERGE contrib/coccinelle/free.cocci.patch
> 	
> 	real    0m0.550s
> 	user    0m0.505s
> 	sys     0m0.096s
> 
> But if you set COMPUTE_HEADER_DEPENDENCIES=yes it'll take ~4s (on that
> box), and well re-apply the free.cocci rule to all the *.c files (and
> this is all with the caching mechanism in 5/5, real "spatch" will be
> much slower).

Unfortunately:

  # After a successful 'make coccicheck' in the container:
  $ time make -W column.h contrib/coccinelle/free.cocci.patch COMPUTE_HEADER_DEPENDENCIES=yes
  make: curl-config: Command not found
      * new spatch flags
      * new build flags
      CC chdir-notify.o
  /bin/sh: 1: gcc-10: not found
      CC imap-send.o
  /bin/sh: 1: gcc-10: not found
  make: *** [Makefile:2605: chdir-notify.o] Error 127
  make: *** Waiting for unfinished jobs....
  make: *** [Makefile:2605: imap-send.o] Error 127
      CC usage.o
  /bin/sh: 1: gcc-10: not found
  make: *** [Makefile:2605: usage.o] Error 127

> If you already have git compiled (or partially compiled) the "happy
> path" to avoiding work is almost definitely to re-compile that *.o
> because the *.c changed, at which point we'll be able to see if we even
> need to re-run any of the coccinelle rules. Usually we'll need to re-run
> a far smaller set than the full set we operate on now.
> 
> >>  * We can take better advantage of parallelism, while making sure that
> >>    we don't racily append to the contrib/coccinelle/swap.cocci.patch
> >>    file from multiple workers.
> >> 
> >>    Before this change running "make coccicheck" would by default end
> >>    up pegging just one CPU at the very end for a while, usually as
> >>    we'd finish whichever *.cocci rule was the most expensive.
> >> 
> >>    This could be mitigated by combining "make -jN" with
> >>    SPATCH_BATCH_SIZE, see 960154b9c17 (coccicheck: optionally batch
> >>    spatch invocations, 2019-05-06). But doing so required careful
> >>    juggling, as e.g. setting both to 4 would yield 16 workers.
> >
> > No, setting both to 4 does yield 4 workers.
> >
> > SPATCH_BATCH_SIZE has nothing to do with parallelism; it is merely the
> > number of C source files that we pass to a single 'spatch' invocation,
> > but for any given semantic patch it's still a sequential loop.
> 
> Thanks, will fix. I see I conflated SPATCH_BATCH_SIZE with spatch's
> --jobs there (although from experimentation that seems to have pretty
> limited parallelism).

'spatch --jobs' works just fine; the problem is that we use 'spatch'
wrong.

> 
> 1. https://lore.kernel.org/git/220825.86ilmg4mil.gmgdl@evledraar.gmail.com/
