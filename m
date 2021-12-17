Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEC8C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 01:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhLQBjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 20:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhLQBjc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 20:39:32 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0935EC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:32 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t26so1183486wrb.4
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vyVX7vFQo4mbngJNkWiPsdexLI7VJfo7rtVmDgfWzgQ=;
        b=nqx5KZrR0LJCc6x+DA4z4U50MoVjvajlgbysp1EoFxSshdKw2qkU2gs5dK/oibHnA7
         Tx638bcBFbltxA5Lf2q/15VRB2J4XjQeIdgla67JoGYLHQTlTmGx9o5zkbuDCGa0sOH2
         la00vjFUDWpOnezWbQLAv+oYxS9cIm6wzCbpUdlIb+F/CbgsKKVdhvxUjUCk8z/F6SHZ
         iDq53CFwd1lq0c8NBz57Oh3Ab9uXN0z65L8squevBuzvWmc/lQCJi/ZBUyBmm0Si/cfD
         djFcuLsJpZ4iTx4OxOegaiDt30FMDbXAq9+/Xl7kIRZACfoI0wbXIxExrMm2EvzK69id
         wmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vyVX7vFQo4mbngJNkWiPsdexLI7VJfo7rtVmDgfWzgQ=;
        b=Flc0v1o74u/OwZap+3lhKwMw/cHlIYWf9BcRBLOw6KzoQP2SdHZvnWu4tgCObw9Fke
         sNTjalzHQHnzmZ8c3UJw7wkaEU+y0uTifBUj3F16MIgLCMIxln5kCcuF95ihS7jdseEc
         F0t1cF4BFQGhqGPVaaGPxVqL7P8XJ9gybfmTs9+rrTs9Cy3cebCqWh491e+PTNB30LaD
         7mnEyQJoKSG2itidoNYaMW3qhoI5DM1lNSEPE9vGqGkCF3o0Lu1Zx7swz9H+8XNJbzPC
         uk1mPoDxPvlHqRQAuMkYNTOeyabeUDVtqmSy5oYQyDm4t/BAO7KPtfeTdvnNtJe385Ly
         nSMQ==
X-Gm-Message-State: AOAM532vTGS+Hq15YRlE5LWTgcK32Ige9jEY9njFjtHck3vddgtBEhIm
        VamTOKKq/XKT0rg5jbprd/et3L9/0WKmOA==
X-Google-Smtp-Source: ABdhPJyJuYrk+fVHWNlY80pllhaCERVw5BrPUHBKebCf00g6lGD6yiSj+pQPz2LdmTgXUxwekfGBxQ==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr468199wrw.591.1639705170120;
        Thu, 16 Dec 2021 17:39:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c4sm5843869wrr.37.2021.12.16.17.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 17:39:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/8] Makefile: optimize noop runs, add shared.mak
Date:   Fri, 17 Dec 2021 02:39:18 +0100
Message-Id: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic is split-up from v4 of ab/make-dependency[1], and is the
last topic I've split up from that which I'll submit before the
outstanding ones land.

This speeds up noop runs of "make" by a lot. After a "make" running a
"make -j1" with this is ~1.5 faster than on "master"[2], and around 3x
as fast with "make -j1 NO_TCLTK=Y" (the TCL part takes a lot of time,
but that's another matter).

As shown in 8/8 the only meaningful change to existing Makefile rules
makes things simpler, while making them much faster. In 3/8 a rather
trivial change to use ":=" instead of "=" for a "$(shell)" assignment
likewise speeds things up.

The "shared.mak" introduced while getting to 8/8 will then be used by
follow-on topics to make introducing shared behavior (particularly via
$(call), which we can now rely on) easier.

The range-diff to [1] shows changes from that topic. Most of them are
from pulling this topic out of those larger changes. I also re-ran all
the benchmarks & updated those in the commit messages.

1. https://lore.kernel.org/git/cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com/
2. $ git -c hyperfine.hook.setup= hyperfine -L rev origin/master,HEAD~0 -s 'make' 'make -j1' --warmup 1
   Benchmark 1: make -j1' in 'origin/master
     Time (mean ± σ):     563.1 ms ±  14.5 ms    [User: 453.3 ms, System: 117.6 ms]
     Range (min … max):   542.7 ms … 595.0 ms    10 runs

   Benchmark 2: make -j1' in 'HEAD~0
     Time (mean ± σ):     362.5 ms ±   4.5 ms    [User: 299.7 ms, System: 73.9 ms]
     Range (min … max):   356.9 ms … 369.4 ms    10 runs

   Summary
     'make -j1' in 'HEAD~0' ran
       1.55 ± 0.04 times faster than 'make -j1' in 'origin/master'
3. git -c hyperfine.hook.setup= hyperfine -L rev origin/master,HEAD~0 -s 'make' 'make -j1 NO_TCLTK=Y' --warmup 1
   Benchmark 1: make -j1 NO_TCLTK=Y' in 'origin/master
     Time (mean ± σ):     291.1 ms ±  24.1 ms    [User: 225.6 ms, System: 68.9 ms]
     Range (min … max):   275.0 ms … 353.9 ms    10 runs

   Benchmark 2: make -j1 NO_TCLTK=Y' in 'HEAD~0
     Time (mean ± σ):      95.8 ms ±   0.7 ms    [User: 81.9 ms, System: 18.1 ms]
     Range (min … max):    94.8 ms …  98.4 ms    31 runs

   Summary
     'make -j1 NO_TCLTK=Y' in 'HEAD~0' ran
       3.04 ± 0.25 times faster than 'make -j1 NO_TCLTK=Y' in 'origin/master'

Ævar Arnfjörð Bjarmason (8):
  Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
  Makefile: disable GNU make built-in wildcard rules
  Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
  Makefile: move ".SUFFIXES" rule to shared.mak
  Makefile: move $(comma), $(empty) and $(space) to shared.mak
  Makefile: add "$(QUIET)" boilerplate to shared.mak
  Makefile: use $(wspfx) for $(QUIET...) in shared.mak
  Makefiles: add and use wildcard "mkdir -p" template

 Documentation/Makefile |  63 +++-------------------
 Makefile               | 118 +++++++++++++----------------------------
 config.mak.uname       |   1 -
 shared.mak             | 109 +++++++++++++++++++++++++++++++++++++
 t/Makefile             |   3 ++
 t/interop/Makefile     |   3 ++
 templates/Makefile     |   8 ++-
 7 files changed, 160 insertions(+), 145 deletions(-)
 create mode 100644 shared.mak

Range-diff:
 1:  1621ca72c1d <  -:  ----------- Makefile: don't invoke msgfmt with --statistics
 2:  b7c36c9fea0 <  -:  ----------- Makefile: don't set up "perl/build" rules under NO_PERL=Y
 3:  29b000eb0f1 <  -:  ----------- Makefile: use "=" not ":=" for po/* and perl/*
 4:  daead5ec293 <  -:  ----------- Makefile: clean perl/build/ even with NO_PERL=Y
 5:  3c987590740 <  -:  ----------- Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
 6:  b57f582ccd3 <  -:  ----------- Makefile: guard Perl-only variable assignments
 7:  fcdee92f64c <  -:  ----------- Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
 8:  1e25b532ca2 <  -:  ----------- Makefile: adjust Perl-related comments & whitespace
 9:  77d9855bfcf <  -:  ----------- Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
10:  6004cdcd8d9 <  -:  ----------- Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
11:  17b30e96057 <  -:  ----------- Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
12:  30ddf7da2c8 !  1:  f74b47662b7 Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
    @@ shared.mak (new)
     +#
     +#    info make --index-search=.DELETE_ON_ERROR
     +.DELETE_ON_ERROR:
    +
    + ## t/Makefile ##
    +@@
    ++# Import tree-wide shared Makefile behavior and libraries
    ++include ../shared.mak
    ++
    + # Run tests
    + #
    + # Copyright (c) 2005 Junio C Hamano
    +
    + ## t/interop/Makefile ##
    +@@
    ++# Import tree-wide shared Makefile behavior and libraries
    ++include ../../shared.mak
    ++
    + -include ../../config.mak
    + export GIT_TEST_OPTIONS
    + 
    +
    + ## templates/Makefile ##
    +@@
    ++# Import tree-wide shared Makefile behavior and libraries
    ++include ../shared.mak
    ++
    + # make and install sample templates
    + 
    + ifndef V
21:  dd569a59c74 !  2:  b0c63abe091 Makefile: disable GNU make built-in wildcard rules
    @@ Commit message
         Makefile: disable GNU make built-in wildcard rules
     
         Override built-in rules of GNU make that use a wildcard target. This
    -    speeds things up significantly as we don't need to stat() so many
    -    files just in case we'd be able to retrieve their contents from RCS or
    -    SCCS. See [1] for an old mailing list discussion about how to disable
    -    these.
    -
    -    This gives us a noticeable speedup on a no-op run:
    -
    -        $ git hyperfine -L rev HEAD~1,HEAD~0 -s 'make -j8 all NO_TCLTK=Y' 'make NO_TCLTK=Y' --warmup 10 -M 10
    -        Benchmark 1: make NO_TCLTK=Y' in 'HEAD~1
    -          Time (mean ± σ):     182.2 ms ±   4.1 ms    [User: 146.8 ms, System: 49.5 ms]
    -          Range (min … max):   179.6 ms … 193.4 ms    10 runs
    -
    -        Benchmark 2: make NO_TCLTK=Y' in 'HEAD~0
    -          Time (mean ± σ):     167.9 ms ±   1.3 ms    [User: 127.8 ms, System: 55.6 ms]
    -          Range (min … max):   166.1 ms … 170.4 ms    10 runs
    -
    -        Summary
    -          'make NO_TCLTK=Y' in 'HEAD~0' ran
    -            1.09 ± 0.03 times faster than 'make NO_TCLTK=Y' in 'HEAD~1'
    -
    -    Running the same except with 'strace -c -S calls make' as the
    -    benchmark command shows (under --show-output) that we went from ~7716
    -    syscalls to ~7519, mostly a reduction in [l]stat().
    -
    -    We could also invoke make with "-r" by setting "MAKEFLAGS = -r" early,
    -    adding a "-r" variant to the above benchmark shows that it may be 1.01
    -    or so faster (but in my tests, always with a much bigger error
    -    bar). But doing so is a much bigger hammer, since it will disable all
    -    built-in rules, some (all?) of which can be seen with:
    +    can speeds things up significantly as we don't need to stat() so many
    +    files. GNU make does that by default to see if it can retrieve their
    +    contents from RCS or SCCS. See [1] for an old mailing list discussion
    +    about how to disable these.
    +
    +    The speed-up may wary. I've seen 1-10% depending on the speed of the
    +    local disk, caches, -jN etc. Running:
    +
    +        strace -f -c -S calls make -j1 NO_TCLTK=Y
    +
    +    Shows that we reduce the number of syscalls we make, mostly in "stat"
    +    calls.
    +
    +    We could also invoke make with "-r" by setting "MAKEFLAGS = -r"
    +    early. Doing so might make us a bit faster still. But doing so is a
    +    much bigger hammer, since it will disable all built-in rules,
    +    some (all?) of which can be seen with:
     
             make -f/dev/null -p | grep -v -e ^# -e ^$
     
22:  4168a7e3b30 !  3:  c6c6f7cf8d8 Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
    @@ Commit message
     
         This speeds things up a lot:
     
    -        $ git -c hyperfine.hook.setup= hyperfine -L rev HEAD~1,HEAD~0 -s 'make -j8 all NO_TCLTK=Y' 'make NO_TCLTK=Y' --war
    -        mup 10 -M 10
    -        Benchmark 1: make NO_TCLTK=Y' in 'HEAD~1
    -          Time (mean ± σ):      99.5 ms ±   0.5 ms    [User: 83.4 ms, System: 20.7 ms]
    -          Range (min … max):    98.8 ms … 100.2 ms    10 runs
    +        $ git -c hyperfine.hook.setup= hyperfine -L rev HEAD~1,HEAD~0 -s 'make NO_TCLTK=Y' 'make -j1 NO_TCLTK=Y' --warmup 10 -M 10
    +        Benchmark 1: make -j1 NO_TCLTK=Y' in 'HEAD~1
    +          Time (mean ± σ):     159.9 ms ±   6.8 ms    [User: 137.2 ms, System: 28.0 ms]
    +          Range (min … max):   154.6 ms … 175.9 ms    10 runs
     
    -        Benchmark 2: make NO_TCLTK=Y' in 'HEAD~0
    -          Time (mean ± σ):      69.4 ms ±   0.5 ms    [User: 58.8 ms, System: 14.2 ms]
    -          Range (min … max):    68.9 ms …  70.3 ms    10 runs
    +        Benchmark 2: make -j1 NO_TCLTK=Y' in 'HEAD~0
    +          Time (mean ± σ):     100.0 ms ±   1.3 ms    [User: 84.2 ms, System: 20.2 ms]
    +          Range (min … max):    98.8 ms … 102.8 ms    10 runs
     
             Summary
    -          'make NO_TCLTK=Y' in 'HEAD~0' ran
    -            1.43 ± 0.01 times faster than 'make NO_TCLTK=Y' in 'HEAD~1'
    +          'make -j1 NO_TCLTK=Y' in 'HEAD~0' ran
    +            1.60 ± 0.07 times faster than 'make -j1 NO_TCLTK=Y' in 'HEAD~1'
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Makefile: GENERATED_H += hook-list.h
      LIB_OBJS += abspath.o
      LIB_OBJS += add-interactive.o
     @@ Makefile: perl/build/man/man3/Git.3pm: perl/Git.pm
    - 	$(call mkdir_p_parent_template)
    - 	$(QUIET_GEN)pod2man $< $@
    + 	$(QUIET_GEN)mkdir -p $(dir $@) && \
    + 	pod2man $< $@
      
     -FIND_SOURCE_FILES = ( \
     -	git ls-files \
23:  48a3927d972 !  4:  ed64cd1bd4a Makefile: move ".SUFFIXES" rule to shared.mak
    @@ Commit message
     
         This doesn't benefit the main Makefile at all, since it already had
         the rule, but since we're including shared.mak in other Makefiles
    -    starts to benefit them. E.g. running the 'man" target is now ~1.3x
    -    faster:
    +    starts to benefit them. E.g. running the 'man" target is now faster:
     
    -        $ git -c hyperfine.hook.setup= hyperfine -L rev HEAD~1,HEAD~0 -s 'make -j8 -C Documentation man' 'make -C Documentation man' --warmup 10 -M 10
    -        Benchmark 1: make -C Documentation man' in 'HEAD~1
    -          Time (mean ± σ):      87.2 ms ±   1.0 ms    [User: 79.3 ms, System: 10.8 ms]
    -          Range (min … max):    86.3 ms …  89.7 ms    10 runs
    +        $ git -c hyperfine.hook.setup= hyperfine -L rev HEAD~1,HEAD~0 -s 'make -C Documentation man' 'make -C Documentation -j1 man'
    +        Benchmark 1: make -C Documentation -j1 man' in 'HEAD~1
    +          Time (mean ± σ):     121.7 ms ±   8.8 ms    [User: 105.8 ms, System: 18.6 ms]
    +          Range (min … max):   112.8 ms … 148.4 ms    26 runs
     
    -        Benchmark 2: make -C Documentation man' in 'HEAD~0
    -          Time (mean ± σ):      64.5 ms ±   0.6 ms    [User: 54.5 ms, System: 13.0 ms]
    -          Range (min … max):    63.8 ms …  65.7 ms    10 runs
    +        Benchmark 2: make -C Documentation -j1 man' in 'HEAD~0
    +          Time (mean ± σ):      97.5 ms ±   8.0 ms    [User: 80.1 ms, System: 20.1 ms]
    +          Range (min … max):    89.8 ms … 111.8 ms    32 runs
     
             Summary
    -          'make -C Documentation man' in 'HEAD~0' ran
    -            1.35 ± 0.02 times faster than 'make -C Documentation man' in 'HEAD~1'
    +          'make -C Documentation -j1 man' in 'HEAD~0' ran
    +            1.25 ± 0.14 times faster than 'make -C Documentation -j1 man' in 'HEAD~1'
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
13:  f378a7dc35e =  5:  1749085b929 Makefile: move $(comma), $(empty) and $(space) to shared.mak
14:  13cbb851d32 <  -:  ----------- Makefile: re-add and use the "shellquote" macros
15:  337953e4994 <  -:  ----------- Makefile: add a "TRACK_template" for GIT-*{FLAGS,DEFINES,...}
16:  5bb597c1993 !  6:  c25284b24cf Makefile: add "$(QUIET)" boilerplate to shared.mak
    @@ config.mak.uname: vcxproj:
      
     
      ## shared.mak ##
    -@@ shared.mak: space = $(empty) $(empty)
    - wspfx = $(space)$(space)$(space)
    - wspfx_sq = $(call shellquote,$(wspfx))
    - 
    +@@
    + comma = ,
    + empty =
    + space = $(empty) $(empty)
    ++
     +### Quieting
     +## common
     +QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
    @@ shared.mak: space = $(empty) $(empty)
     +	export V
     +endif
     +endif
    -+
    - ### Templates
    - 
    - ## Template for making a GIT-SOMETHING, which changes if a
     
      ## templates/Makefile ##
     @@
17:  3c4d0589667 <  -:  ----------- Makefile: use $(wspfx) for $(QUIET...) in shared.mak
 -:  ----------- >  7:  3daef7672be Makefile: use $(wspfx) for $(QUIET...) in shared.mak
18:  be5882b2c99 !  8:  aca560ca410 Makefiles: add and use wildcard "mkdir -p" template
    @@ Commit message
         shows that this is faster, in addition to being less verbose and more
         reliable (this uses my "git-hyperfine" thin wrapper for "hyperfine"[3]):
     
    -        $ git hyperfine -L rev HEAD~0,HEAD~1 -b 'make -C Documentation lint-docs' -p 'rm -rf Documentation/.build' 'make -C Documentation lint-docs'
    -        Benchmark 1: make -C Documentation lint-docs' in 'HEAD~0
    -          Time (mean ± σ):      2.129 s ±  0.011 s    [User: 1.840 s, System: 0.321 s]
    -          Range (min … max):    2.121 s …  2.158 s    10 runs
    +        $ git -c hyperfine.hook.setup= hyperfine -L rev HEAD~1,HEAD~0 -s 'make -C Documentation lint-docs' -p 'rm -rf Documentation/.build' 'make -C Documentation -j1 lint-docs'
    +        Benchmark 1: make -C Documentation -j1 lint-docs' in 'HEAD~1
    +          Time (mean ± σ):      2.914 s ±  0.062 s    [User: 2.449 s, System: 0.489 s]
    +          Range (min … max):    2.834 s …  3.020 s    10 runs
     
    -        Benchmark 2: make -C Documentation lint-docs' in 'HEAD~1
    -          Time (mean ± σ):      2.659 s ±  0.002 s    [User: 2.306 s, System: 0.397 s]
    -          Range (min … max):    2.657 s …  2.662 s    10 runs
    +        Benchmark 2: make -C Documentation -j1 lint-docs' in 'HEAD~0
    +          Time (mean ± σ):      2.315 s ±  0.062 s    [User: 1.950 s, System: 0.386 s]
    +          Range (min … max):    2.229 s …  2.397 s    10 runs
     
             Summary
    -          'make -C Documentation lint-docs' in 'HEAD~0' ran
    -            1.25 ± 0.01 times faster than 'make -C Documentation lint-docs' in 'HEAD~1'
    +          'make -C Documentation -j1 lint-docs' in 'HEAD~0' ran
    +            1.26 ± 0.04 times faster than 'make -C Documentation -j1 lint-docs' in 'HEAD~1'
     
         So let's use that pattern both for the "lint-docs" target, and a few
         miscellaneous other targets.
    @@ Makefile: all:: $(MOFILES)
     +	$(call mkdir_p_parent_template)
     +	$(QUIET_MSGFMT)$(MSGFMT) -o $@ $<
      
    - ifndef NO_PERL
    - LIB_PERL = $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
    -@@ Makefile: LIB_CPAN = $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
    - LIB_CPAN_GEN = $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_CPAN))
    + LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
    + LIB_PERL_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
    +@@ Makefile: NO_PERL_CPAN_FALLBACKS_SQ = $(subst ','\'',$(NO_PERL_CPAN_FALLBACKS))
    + endif
      
      perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
     -	$(QUIET_GEN)mkdir -p $(dir $@) && \
    @@ Makefile: LIB_CPAN = $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
     +	$(QUIET_GEN) \
      	sed -e 's|@@LOCALEDIR@@|$(perl_localedir_SQ)|g' \
      	    -e 's|@@NO_GETTEXT@@|$(NO_GETTEXT_SQ)|g' \
    - 	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(call shq,$(NO_PERL_CPAN_FALLBACKS))|g' \
    -@@ Makefile: endif
    + 	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
    + 	< $< > $@
      
    - # install-man depends on Git.3pm even with NO_PERL=Y
      perl/build/man/man3/Git.3pm: perl/Git.pm
     -	$(QUIET_GEN)mkdir -p $(dir $@) && \
     -	pod2man $< $@
     +	$(call mkdir_p_parent_template)
     +	$(QUIET_GEN)pod2man $< $@
      
    - FIND_SOURCE_FILES = ( \
    - 	git ls-files \
    + $(ETAGS_TARGET): $(FOUND_SOURCE_FILES)
    + 	$(QUIET_GEN)$(RM) $@+ && \
     @@ Makefile: test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
      all:: $(TEST_PROGRAMS) $(test_bindir_programs)
      
    @@ Makefile: test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_
      ## shared.mak ##
     @@ shared.mak: ifndef V
      	QUIET          = @
    - 	QUIET_GEN      = @echo $(wspfx_sq) GEN $@;
    + 	QUIET_GEN      = @echo $(wspfx_SQ) GEN $@;
      
    -+	QUIET_MKDIR_P_PARENT  = @echo $(wspfx_sq) MKDIR -p $(@D);
    ++	QUIET_MKDIR_P_PARENT  = @echo $(wspfx_SQ) MKDIR -p $(@D);
     +
      ## Used in "Makefile"
    - 	QUIET_CC       = @echo $(wspfx_sq) CC $@;
    - 	QUIET_AR       = @echo $(wspfx_sq) AR $@;
    + 	QUIET_CC       = @echo $(wspfx_SQ) CC $@;
    + 	QUIET_AR       = @echo $(wspfx_SQ) AR $@;
     @@ shared.mak: ifndef V
    + 	export V
      endif
      endif
    - 
    -+## Helpers
    ++
    ++### Templates
    ++
    ++## mkdir_p_parent: lazily "mkdir -p" the path needed for a $@
    ++## file. Uses $(wildcard) to avoid the "mkdir -p" if it's not
    ++## needed.
    ++##
    ++## Is racy, but in a good way; we might redundantly (and safely)
    ++## "mkdir -p" when running in parallel, but won't need to exhaustively
    ++## individual rules for "a" -> "prefix" -> "dir" -> "file" if given a
    ++## "a/prefix/dir/file". This can instead be inserted at the start of
    ++## the "a/prefix/dir/file" rule.
     +define mkdir_p_parent_template
     +$(if $(wildcard $(@D)),,$(QUIET_MKDIR_P_PARENT)$(shell mkdir -p $(@D)))
     +endef
    -+
    - ### Templates
    - 
    - ## Template for making a GIT-SOMETHING, which changes if a
19:  2710f8af6cd <  -:  ----------- Makefile: correct the dependency graph of hook-list.h
20:  59f22a0269a <  -:  ----------- Makefile: use $(file) I/O instead of "FORCE" when possible
-- 
2.34.1.1119.g7a3fc8778ee

