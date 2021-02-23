Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5EEC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176ED64E32
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhBWLm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhBWLm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 06:42:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C87BC061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:41:46 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l12so22238528wry.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLrWphbfjPZH8vMO+GQygKaLVWeEKOAnsPppuRPz2HA=;
        b=O5GrlQviT9F7wWf/cMg6s4aR8Mh3OjJIuRKBDnrLZ3zoN7JnteQmAajHrJnS5uZp+c
         MUjOtdl1zVlpTAZ2UDAVIj/OnwKuWF++Gx69k1SxsUKDLio3XP0nkzE/wC4Ca75BVnQG
         7DSX58sanyHssxQKnQgnKAnfCK5o9wy0E9BZZVcu3sQDyOOD9/hgSoRwRXfsWvl4bbuG
         bNhsuUDFskQyglNytEc3/UqEDKmAqhtkG3Ce1NbrJ817ClfVPijuMbN2kAj2dKmD/36w
         NpTTm7+rlAWKBeNQaFN4eRvVMNDQmGo4MIhAEvENJF8s8l+Mkwp86ITyEoEDSH/yoym3
         HuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLrWphbfjPZH8vMO+GQygKaLVWeEKOAnsPppuRPz2HA=;
        b=rDGGuScU6rabHQ75HOb1FYjMsLGpC2qOERoBxlajZgAxRZ455N9HROLbtuxjpR2H1c
         5dMTD8tsQKZMPXLao4e7jTNOgye0OyrSEhG426F9i+Ga2Q0gZXT7oRFnoubMbF9YreGa
         ZRx/CoSN4jThcjDvjzQpdZv/eFn9Jl2QLr+RwQo/KLi+KoAaGhJR+qvlsBWZL2sJSrJ1
         S+YbtJoFQ9gtAGBD9Lp5/+UVkvmPjED/Qn6dGNOjIIocxVsopsAu0qUfhN4DibVsTZR1
         1LqoPbvqvzBzmKcO+XfWMEuddDnfMu2G+YAu/dICO8zD9aMduumJE63+OnvHUwPgrp4T
         l+ng==
X-Gm-Message-State: AOAM533olAtaGlRKVL66s3V/gLPKxV4xt/qvkFGT9meQq05UoRuryKfK
        iomDY271rssEbr7rjihYGNm2xnF13xyuGQ==
X-Google-Smtp-Source: ABdhPJxyOvbB0+y7BQAN+Igf3kTh/CbPBToo+f6pPZgYEYJTabsVbh9Cp+96V+tK3Yjx7tlvbbMCdQ==
X-Received: by 2002:a5d:4570:: with SMTP id a16mr19099654wrc.179.1614080504690;
        Tue, 23 Feb 2021 03:41:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n9sm2391336wmi.43.2021.02.23.03.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 03:41:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/6] Makefile: add {program,xdiff,test,git,fuzz}-objs & objects targets
Date:   Tue, 23 Feb 2021 12:41:26 +0100
Message-Id: <20210223114132.24345-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210201111715.10200-1-avarab@gmail.com>
References: <20210201111715.10200-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addresses feedback on v2:
https://lore.kernel.org/git/20210201111715.10200-1-avarab@gmail.com/

Changes:

 - Added .PHONY targets as appropriate

 - Instead of removing fuzz-objs from "all" we now run it in the CI
   build instead. I think this accomplishes the goal of avoiding
   bitrot without needlessly compiling them on every build of git.

As Jeff points out in
https://lore.kernel.org/git/YBuc5iOCCHk4fPqs@coredump.intra.peff.net/
the use-case for having "{program-xdiff,test,git}-objs & objects"
targets is a bit harder to justify.

I still think they're useful, particularly for testing on e.g. slow
single-core VMs or other test setups (I use the GCC farm) where I know
I just want to compile e.g. "test" objects, and compiling one of them
takes 1-2 seconds.

It's an easy enough patch to carry, and now with 6/6 we even have an
in-tree consumer of one of them.

Ævar Arnfjörð Bjarmason (6):
  Makefile: guard against TEST_OBJS in the environment
  Makefile: split up long OBJECTS line
  Makefile: sort OBJECTS assignment for subsequent change
  Makefile: split OBJECTS into OBJECTS and GIT_OBJS
  Makefile: add {program,xdiff,test,git,fuzz}-objs & objects targets
  Makefile: build "$(FUZZ_OBJS)" in CI, not under "all"

 Makefile                  | 38 ++++++++++++++++++++++++++++----------
 ci/run-build-and-tests.sh |  1 +
 2 files changed, 29 insertions(+), 10 deletions(-)

Range-diff:
2:  a50b68fe195 = 1:  cf6d71dcf5a Makefile: guard against TEST_OBJS in the environment
3:  53656000ebe = 2:  ad7ac896c09 Makefile: split up long OBJECTS line
4:  d956624baea = 3:  575b2ab8e9c Makefile: sort OBJECTS assignment for subsequent change
5:  500ace9cfb4 = 4:  7fdaeb3616b Makefile: split OBJECTS into OBJECTS and GIT_OBJS
6:  8f7ce09e9bd ! 5:  765cf20c58c Makefile: add {program,xdiff,test,git}-objs & objects targets
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    Makefile: add {program,xdiff,test,git}-objs & objects targets
    +    Makefile: add {program,xdiff,test,git,fuzz}-objs & objects targets
     
         Add targets to compile the various *.o files we declared in commonly
         used *_OBJS variables. This is useful for debugging purposes, to
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    +@@ Makefile: ETAGS_TARGET = TAGS
    + FUZZ_OBJS += fuzz-commit-graph.o
    + FUZZ_OBJS += fuzz-pack-headers.o
    + FUZZ_OBJS += fuzz-pack-idx.o
    ++.PHONY: fuzz-objs
    ++fuzz-objs: $(FUZZ_OBJS)
    + 
    + # Always build fuzz objects even if not testing, to prevent bit-rot.
    + all:: $(FUZZ_OBJS)
     @@ Makefile: PROGRAM_OBJS += http-backend.o
      PROGRAM_OBJS += imap-send.o
      PROGRAM_OBJS += sh-i18n--envsubst.o
      PROGRAM_OBJS += shell.o
    ++.PHONY: program-objs
     +program-objs: $(PROGRAM_OBJS)
      
      # Binary suffix, set to .exe for Windows builds
    @@ Makefile: XDIFF_OBJS += xdiff/xmerge.o
      XDIFF_OBJS += xdiff/xpatience.o
      XDIFF_OBJS += xdiff/xprepare.o
      XDIFF_OBJS += xdiff/xutils.o
    ++.PHONY: xdiff-objs
     +xdiff-objs: $(XDIFF_OBJS)
      
      TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
    ++.PHONY: test-objs
     +test-objs: $(TEST_OBJS)
      
      GIT_OBJS += $(LIB_OBJS)
      GIT_OBJS += $(BUILTIN_OBJS)
      GIT_OBJS += common-main.o
      GIT_OBJS += git.o
    ++.PHONY: git-objs
     +git-objs: $(GIT_OBJS)
      
      OBJECTS += $(GIT_OBJS)
    @@ Makefile: OBJECTS += $(FUZZ_OBJS)
      ifndef NO_CURL
      	OBJECTS += http.o http-walker.o remote-curl.o
      endif
    ++.PHONY: objects
     +objects: $(OBJECTS)
      
      dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
1:  20ec032b390 ! 6:  bfedec4e5b4 Makefile: remove "all" on "$(FUZZ_OBJS)"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    Makefile: remove "all" on "$(FUZZ_OBJS)"
    +    Makefile: build "$(FUZZ_OBJS)" in CI, not under "all"
     
    -    Adding this as a dependency was intentionally done in
    +    Adding $(FUZZ_OBJS) as a dependency on "all" was intentionally done in
         5e472150800 (fuzz: add basic fuzz testing target., 2018-10-12).
     
    -    I don't see why we need to prevent bitrot here under "all" for these
    -    in particular, but not e.g. contrib/credential/**/*.c
    +    Rather than needlessly build these objects which aren't required for
    +    the build every time we make "all", let's instead move them to be
    +    built by the CI jobs.
     
    -    In any case, these files are rather trivial and from their commit log
    -    it seems the fuzz-all target is run by a few people already.
    +    The goal is to make sure that we don't inadvertently break these, we
    +    can accomplish that goal by building them in CI, rather than slowing
    +    down every build of git for everyone everywhere.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    -@@ Makefile: FUZZ_OBJS += fuzz-commit-graph.o
    - FUZZ_OBJS += fuzz-pack-headers.o
    - FUZZ_OBJS += fuzz-pack-idx.o
    +@@ Makefile: FUZZ_OBJS += fuzz-pack-idx.o
    + .PHONY: fuzz-objs
    + fuzz-objs: $(FUZZ_OBJS)
      
     -# Always build fuzz objects even if not testing, to prevent bit-rot.
     -all:: $(FUZZ_OBJS)
    @@ Makefile: FUZZ_OBJS += fuzz-commit-graph.o
      FUZZ_PROGRAMS += $(patsubst %.o,%,$(FUZZ_OBJS))
      
      # Empty...
    -@@ Makefile: $(FUZZ_PROGRAMS): all
    +@@ Makefile: FUZZ_CXXFLAGS ?= $(CFLAGS)
    + 
    + .PHONY: fuzz-all
    + 
    +-$(FUZZ_PROGRAMS): all
    ++$(FUZZ_PROGRAMS): all fuzz-objs
      	$(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
      		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
      
     -fuzz-all: $(FUZZ_PROGRAMS)
     +fuzz-all: $(FUZZ_PROGRAMS) $(FUZZ_OBJS)
    +
    + ## ci/run-build-and-tests.sh ##
    +@@ ci/run-build-and-tests.sh: windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
    + *) ln -s "$cache_dir/.prove" t/.prove;;
    + esac
    + 
    ++make fuzz-objs
    + make
    + case "$jobname" in
    + linux-gcc)
-- 
2.30.0.284.gd98b1dd5eaa7

