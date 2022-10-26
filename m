Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD44C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiJZOVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbiJZOU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:20:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9AA349A6
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:20:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d26so21590290eje.10
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrOch5qAmdrS02q4zQ8LThy1AP9UuLzBpXTXYB0GQcA=;
        b=IJxBUYN3t8Gm8nCRhZRGAx15zl8G0hJ61lSU9jYGbDyHQ9wQ5S2Zc/O1OxbO4p2O4q
         0gdWlCfErjMtnoAdWAT32fBXvlCfoYdVZ3lFYdq/797C1C0DiPgxl4LtNfJirtsCEgj2
         85A5KGubOYOFrK6e/2uA49izql06nHos5SUlC5pip6ayXuiM/J04Y4IOwoGt81HrkY6Y
         OW+oQYmBsq6pHSArZOVdw6H5yv/sJiHY0zXm1DR99cjS/vnkaqCkp43L0iHxsRSad9Xp
         5soGQ45/PWaEZgN8KT4LLXdXt0ndJMlAjVAS5RU0RJybDFUQpuTGLLSzp4rNxPj48CEC
         pMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrOch5qAmdrS02q4zQ8LThy1AP9UuLzBpXTXYB0GQcA=;
        b=Mb6A3B53uAU8JVzefowsx80NT7W0qsaUrszzvb4GqxUw6q4cskMngKN/5Al71PKqnj
         dGzY/Jba/jirbE8nP/wTGDQX0sAEuuvjX8sZGOxhrUjt0CeFHWZ3Kxx2fP55Sx6tmXEO
         84dtUaPDAaOiXCZjIk13i3yvm5r4tiNd6uP00uVSmph7lk/0hL7Wkku4gYtB1ejn2oWp
         ZJC8Z2hpcbIxnrE41kxuu8Po8gO/70uaJT1+BBkijbETdv5XprexzR9iF7kbgZQqH9st
         q0ASWbqUI6NNQy3El0RCsQXdbRiPKo+n/SzMqy36xtXq9FOfDyHLAmC+PLqIDfXBSw77
         5rSQ==
X-Gm-Message-State: ACrzQf0D6yPuBBvjRo625rt/N+FlLH3naLgD7pIcDxnC+OZmZV1P2IVI
        l+X9XeW9tGinvgP0tQ8dEP+Ba2tTEmc=
X-Google-Smtp-Source: AMsMyM7UjKcuhNHUJexH3LNhn0grOkq6uTJr2eNKqg97mm1ViTfUry0SReFragRwX155SO8wVwekXA==
X-Received: by 2002:a17:907:3f19:b0:7a3:2317:4221 with SMTP id hq25-20020a1709073f1900b007a323174221mr17994137ejc.562.1666794053699;
        Wed, 26 Oct 2022 07:20:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11-20020a50ea8b000000b004619f024864sm3605565edo.81.2022.10.26.07.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:20:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/12] cocci: make "incremental" possible + a ccache-like tool
Date:   Wed, 26 Oct 2022 16:20:27 +0200
Message-Id: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
References: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of the series to have "make coccicheck" run
incrementally. For the v1 and general overview see:
https://lore.kernel.org/git/cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com/

For me a "make coccicheck" on master takes ~7m, with
"SPATCH_BATCH_SIZE=0" (the usual way to speed it up on a beefy box)
it's ~6m.

With this topic it takes 2m30s with no caching, and using the
"spatchcache" tool in 12/12 10s. The ~6-7m to ~2m30s speed-up is
mostly 11/12, i.e. we now concatenate the rules.

But being able to run this in ~10s once you set up "spatchcache" means
that incremental runs become viable (e.g. sanity checks when merging
topics in a loop).

These numbers are on a 8 core colo'd box, so YMMV. For GitHub CI the
"static-analysis" (which has more than just "make coccicheck") now
takes ~8m instead of ~15m.

Changes since v4:

 * update contrib/coccinelle/README as we go, see the range-diff
   below.

 * Added a 10/12 to remove named rules that didn't need their names,
   as we make an ALL.cocci these are more likely to collide.

 * I made the spatchcache tool faster, it spend ~40ms per run on a
   cache hit, mostly on running "git config", now it can be told via
   environment variables to use its default, and not ask the config,
   which makes it take ~10ms on a cache hit.

 * We now explain in 11/12's README addition that rule names are now
   global, as we concatenate all the *.cocci files.

Ævar Arnfjörð Bjarmason (12):
  Makefile + shared.mak: rename and indent $(QUIET_SPATCH_T)
  cocci rules: remove unused "F" metavariable from pending rule
  Makefile: add ability to TAB-complete cocci *.patch rules
  Makefile: have "coccicheck" re-run if flags change
  Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
  cocci: split off include-less "tests" from SPATCH_FLAGS
  cocci: split off "--all-includes" from SPATCH_FLAGS
  cocci: make "coccicheck" rule incremental
  cocci: optimistically use COMPUTE_HEADER_DEPENDENCIES
  cocci rules: remove <id>'s from rules that don't need them
  cocci: run against a generated ALL.cocci
  spatchcache: add a ccache-alike for "spatch"

 .gitignore                                    |   1 +
 Makefile                                      | 159 +++++++--
 contrib/coccinelle/.gitignore                 |   1 +
 contrib/coccinelle/README                     |  49 +++
 contrib/coccinelle/hashmap.cocci              |   2 +-
 contrib/coccinelle/preincr.cocci              |   2 +-
 contrib/coccinelle/spatchcache                | 304 ++++++++++++++++++
 contrib/coccinelle/strbuf.cocci               |   2 +-
 contrib/coccinelle/swap.cocci                 |   2 +-
 .../coccinelle/the_repository.pending.cocci   |   1 -
 shared.mak                                    |  10 +-
 11 files changed, 501 insertions(+), 32 deletions(-)
 create mode 100755 contrib/coccinelle/spatchcache

Range-diff against v3:
 1:  4494c91df9a =  1:  c0306e3c397 Makefile + shared.mak: rename and indent $(QUIET_SPATCH_T)
 2:  8219b1b12f2 =  2:  14e757cc020 cocci rules: remove unused "F" metavariable from pending rule
 3:  6dbfafa08fd =  3:  210dbc6b101 Makefile: add ability to TAB-complete cocci *.patch rules
 4:  f779a2d22aa =  4:  b859dae7509 Makefile: have "coccicheck" re-run if flags change
 5:  ab25b586f38 !  5:  11b9227722b Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
    @@ Commit message
         preceded it. As subsequent commits will add such comments we need to
         split the existing comment up.
     
    +    The wrapping for the "SPATCH_BATCH_SIZE" is now a bit odd, but
    +    minimizes the diff size. As a subsequent commit will remove that
    +    feature altogether this is worth it.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
 6:  691be73b6fb =  6:  1c30f4b543b cocci: split off include-less "tests" from SPATCH_FLAGS
 7:  2ca5ea5beca =  7:  86827388627 cocci: split off "--all-includes" from SPATCH_FLAGS
 8:  2072a508064 =  8:  340ce523436 cocci: make "coccicheck" rule incremental
 9:  739652eada9 !  9:  134b3743a60 cocci: optimistically use COMPUTE_HEADER_DEPENDENCIES
    @@ Makefile: endef
      endef
      
      ifdef COCCI_GOALS
    +
    + ## contrib/coccinelle/README ##
    +@@ contrib/coccinelle/README: There are two types of semantic patches:
    + 
    +    This allows to expose plans of pending large scale refactorings without
    +    impacting the bad pattern checks.
    ++
    ++Git-specific tips & things to know about how we run "spatch":
    ++
    ++ * The "make coccicheck" will piggy-back on
    ++   "COMPUTE_HEADER_DEPENDENCIES". If you've built a given object file
    ++   the "coccicheck" target will consider its depednency to decide if
    ++   it needs to re-run on the corresponding source file.
    ++
    ++   This means that a "make coccicheck" will re-compile object files
    ++   before running. This might be unexpected, but speeds up the run in
    ++   the common case, as e.g. a change to "column.h" won't require all
    ++   coccinelle rules to be re-run against "grep.c" (or another file
    ++   that happens not to use "column.h").
    ++
    ++   To disable this behavior use the "SPATCH_USE_O_DEPENDENCIES=NoThanks"
    ++   flag.
 -:  ----------- > 10:  89f778ac055 cocci rules: remove <id>'s from rules that don't need them
10:  52177ea2a68 ! 11:  a848d09527f cocci: run against a generated ALL.cocci
    @@ contrib/coccinelle/.gitignore
     +/ALL.cocci
      *.patch*
     
    + ## contrib/coccinelle/README ##
    +@@ contrib/coccinelle/README: Git-specific tips & things to know about how we run "spatch":
    + 
    +    To disable this behavior use the "SPATCH_USE_O_DEPENDENCIES=NoThanks"
    +    flag.
    ++
    ++ * To speed up our rules the "make coccicheck" target will by default
    ++   concatenate all of the *.cocci files here into an "ALL.cocci", and
    ++   apply it to each source file.
    ++
    ++   This makes the run faster, as we don't need to run each rule
    ++   against each source file. See the Makefile for further discussion,
    ++   this behavior can be disabled with "SPATCH_CONCAT_COCCI=".
    ++
    ++   But since they're concatenated any <id> in the <rulname> (e.g. "@
    ++   my_name", v.s. anonymous "@@") needs to be unique across all our
    ++   *.cocci files. You should only need to name rules if other rules
    ++   depend on them (currently only one rule is named).
    +
      ## shared.mak ##
     @@ shared.mak: ifndef V
      ## Used in "Makefile": SPATCH
11:  f7ca3f9c9af ! 12:  a728aa301a6 spatchcache: add a ccache-alike for "spatch"
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## contrib/coccinelle/README ##
    +@@ contrib/coccinelle/README: Git-specific tips & things to know about how we run "spatch":
    +    my_name", v.s. anonymous "@@") needs to be unique across all our
    +    *.cocci files. You should only need to name rules if other rules
    +    depend on them (currently only one rule is named).
    ++
    ++ * To speed up incremental runs even more use the "spatchcache" tool
    ++   in this directory as your "SPATCH". It aimns to be a "ccache" for
    ++   coccinelle, and piggy-backs on "COMPUTE_HEADER_DEPENDENCIES".
    ++
    ++   It caches in Redis by default, see it source for a how-to.
    ++
    ++   In one setup with a primed cache "make coccicheck" followed by a
    ++   "make clean && make" takes around 10s to run, but 2m30s with the
    ++   default of "SPATCH_CONCAT_COCCI=Y".
    ++
    ++   With "SPATCH_CONCAT_COCCI=" the total runtime is around ~6m, sped
    ++   up to ~1m with "spatchcache".
    ++
    ++   Most of the 10s (or ~1m) being spent on re-running "spatch" on
    ++   files we couldn't cache, as we didn't compile them (in contrib/*
    ++   and compat/* mostly).
    ++
    ++   The absolute times will differ for you, but the relative speedup
    ++   from caching should be on that order.
    +
      ## contrib/coccinelle/spatchcache (new) ##
     @@
     +#!/bin/sh
    @@ contrib/coccinelle/spatchcache (new)
     +# driving "spatch" in git.git, in particular if we invoke:
     +#
     +#	make
    ++#	# See "spatchCache.cacheWhenStderr" for why "--very-quiet" is
    ++#	# used
     +#	make coccicheck SPATCH_FLAGS=--very-quiet
     +#
     +# We can with COMPUTE_HEADER_DEPENDENCIES (auto-detected as true with
    @@ contrib/coccinelle/spatchcache (new)
     +# spatchCache.{trace,debug} to debug whether something is set in the
     +# cache, as we'll write to the spatch logs in .build/* we'd otherwise
     +# always emit a NOCACHE.
    ++#
    ++# Reading the config can make the command much slower, to work around
    ++# this the config can be set in the environment, with environment
    ++# variable name corresponding to the config key. "default" can be used
    ++# to use whatever's the script default, e.g. setting
    ++# spatchCache.cacheWhenStderr=true and deferring to the defaults for
    ++# the rest is:
    ++#
    ++#	export GIT_CONTRIB_SPATCHCACHE_DEBUG=default
    ++#	export GIT_CONTRIB_SPATCHCACHE_TRACE=default
    ++#	export GIT_CONTRIB_SPATCHCACHE_CACHEWHENSTDERR=true
    ++#	export GIT_CONTRIB_SPATCHCACHE_SPATCH=default
    ++#	export GIT_CONTRIB_SPATCHCACHE_DEPENDFORMAT=default
    ++#	export GIT_CONTRIB_SPATCHCACHE_SETCMD=default
    ++#	export GIT_CONTRIB_SPATCHCACHE_GETCMD=default
     +
     +set -e
     +
    ++env_or_config () {
    ++	env="$1"
    ++	shift
    ++	if test "$env" = "default"
    ++	then
    ++		# Avoid expensive "git config" invocation
    ++		return
    ++	elif test -n "$env"
    ++	then
    ++		echo "$env"
    ++	else
    ++		git config $@ || :
    ++	fi
    ++}
    ++
     +## Our own configuration & options
    -+debug=$(git config --bool "spatchCache.debug")
    ++debug=$(env_or_config "$GIT_CONTRIB_SPATCHCACHE_DEBUG" --bool "spatchCache.debug")
     +if test "$debug" != "true"
     +then
     +	debug=
    @@ contrib/coccinelle/spatchcache (new)
     +	set -x
     +fi
     +
    -+trace=$(git config --bool "spatchCache.trace")
    ++trace=$(env_or_config "$GIT_CONTRIB_SPATCHCACHE_TRACE" --bool "spatchCache.trace")
     +if test "$trace" != "true"
     +then
     +	trace=
    @@ contrib/coccinelle/spatchcache (new)
     +	trace=true
     +fi
     +
    -+cacheWhenStderr=$(git config --bool "spatchCache.cacheWhenStderr")
    ++cacheWhenStderr=$(env_or_config "$GIT_CONTRIB_SPATCHCACHE_CACHEWHENSTDERR" --bool "spatchCache.cacheWhenStderr")
     +if test "$cacheWhenStderr" != "true"
     +then
     +	cacheWhenStderr=
    @@ contrib/coccinelle/spatchcache (new)
     +	echo "$@" >&2
     +}
     +
    -+spatch=$(git config --path "spatchCache.spatch" || :)
    ++spatch=$(env_or_config "$GIT_CONTRIB_SPATCHCACHE_SPATCH" --path "spatchCache.spatch")
     +if test -n "$spatch"
     +then
     +	if test -n "$debug"
    @@ contrib/coccinelle/spatchcache (new)
     +fi
     +
     +dependFormat='$dirname/.depend/${basename%.c}.o.d'
    -+dependFormatCfg=$(git config "spatchCache.dependFormat" || :)
    ++dependFormatCfg=$(env_or_config "$GIT_CONTRIB_SPATCHCACHE_DEPENDFORMAT" "spatchCache.dependFormat")
     +if test -n "$dependFormatCfg"
     +then
     +	dependFormat="$dependFormatCfg"
     +fi
     +
    -+set=$(git config spatchCache.setCmd || :)
    -+get=$(git config spatchCache.getCmd || :)
    ++set=$(env_or_config "$GIT_CONTRIB_SPATCHCACHE_SETCMD" "spatchCache.setCmd")
    ++get=$(env_or_config "$GIT_CONTRIB_SPATCHCACHE_GETCMD" "spatchCache.getCmd")
     +
     +## Parse spatch()-like command-line for caching info
     +arg_sp=
-- 
2.38.0.1251.g3eefdfb5e7a

