Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509DAC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3345661BF8
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhKQKXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbhKQKXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:25 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A75C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:26 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso1661200wme.3
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zc//OQ0U/S8GD7Gkrv9srSPn/TCksK2Mb8AE49kCOLY=;
        b=ikug1euqHxlnfo7RVBi70BHmaFRYjK86US7ddGvIzHRBU1tK2FR/9441AWIOuUDj4F
         vra2Ws4s2KzkvLaE8kq5bNbG6fsp/1OR+bZn3vFpprZ7ouvz9hJDiN1srDgUGhyVbIiq
         xLBcaS5V95c3j/BO823Oruy1GOPZlXJTCcoxanMOggF+ZyVPBMPvtarxk0bu+aLZL8dA
         KIe8xwexCUu1uzCNja6a0xoEYfqkoMp3DCcr+k7tB2hBYcfElpPKk3e0B/+zFIDLdFBw
         kNRFr0ycTJ8HHqLO8afqSkVVKcOEIe5hAnUw7cWV+LD1rv8BiO6gNvmKBI5Sfme5f74q
         LbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zc//OQ0U/S8GD7Gkrv9srSPn/TCksK2Mb8AE49kCOLY=;
        b=uHx+dVlp3fTaUfYvz44ctuZN3qYRfHLtM8z7mlL2cYd6mbLSMM7BdcgpqpD/Unn5MV
         dZ7imxoXEgSIP3EejZ+rNQtn2HKs0jWfmPKNgwNU1II8xWUDKQ8Ee+AE2Y6gZRnxF3f7
         qlv1RsMjX0Bo/3pCmJPu2kfi4Ik7MakywUG5cKiPA4k5aqQ1bTD9R+ZV/nGRbzCNqkxZ
         Quo5hfubLZIBeeJKSGCuN3OJlgxEFfjTc8am+7XDOLStc2R1muqrr4ZmGaxgI+LXezmi
         APcif+O7YlHYnc9rt5eURl+yHk8hYYjmfdmZueImDhck6o7H/EVjMkJdHP6KpdH4s2kJ
         T1Sg==
X-Gm-Message-State: AOAM5302YjpKJvbjLi0ANCSGRZh7SsD11+NwvLx/PNJdimkgeRo/2yjT
        GpnC/XjKgmgU7/aB2CAdWwQX+9ROuzMpTQ==
X-Google-Smtp-Source: ABdhPJyjv+8b8d8Nz3m4T91OoT3aYbMKF9BIrAcyTcE25sJOO3z3R6iWL5zcVcCUVTWS2Fqk8cfjbQ==
X-Received: by 2002:a1c:4681:: with SMTP id t123mr77348986wma.83.1637144424869;
        Wed, 17 Nov 2021 02:20:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/23] Makefile: dependency fixes, make noop runtime ~1.4x faster
Date:   Wed, 17 Nov 2021 11:19:59 +0100
Message-Id: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in v2[1] this series fixes various dependency issues in the
Makfile. See [2] for before/after benchmark numbers.

This v4 addresses small issues Mike Hommey noted, and clarifies
various questions that came up with updated commit messages.

There's also a fix-for-the-fix here in removing the "hook.c"
dependency on hook-list.h in 19/23.

1. https://lore.kernel.org/git/cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (23):
  Makefile: don't invoke msgfmt with --statistics
  Makefile: don't set up "perl/build" rules under NO_PERL=Y
  Makefile: use "=" not ":=" for po/* and perl/*
  Makefile: clean perl/build/ even with NO_PERL=Y
  Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
  Makefile: guard Perl-only variable assignments
  Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
  Makefile: adjust Perl-related comments & whitespace
  Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
  Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
  Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
  Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
  Makefile: move $(comma), $(empty) and $(space) to shared.mak
  Makefile: re-add and use the "shellquote" macros
  Makefile: add a "TRACK_template" for GIT-*{FLAGS,DEFINES,...}
  Makefile: add "$(QUIET)" boilerplate to shared.mak
  Makefile: use $(wspfx) for $(QUIET...) in shared.mak
  Makefiles: add and use wildcard "mkdir -p" template
  Makefile: correct the dependency graph of hook-list.h
  Makefile: use $(file) I/O instead of "FORCE" when possible
  Makefile: disable GNU make built-in wildcard rules
  Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
  Makefile: move ".SUFFIXES" rule to shared.mak

 .gitignore             |   2 +-
 Documentation/Makefile |  71 +---------
 Makefile               | 314 +++++++++++++++--------------------------
 config.mak.uname       |   1 -
 git-cvsserver.perl     |   6 +-
 git-send-email.perl    |   7 +-
 git-svn.perl           |   2 +-
 shared.mak             | 187 ++++++++++++++++++++++++
 t/Makefile             |  34 ++---
 templates/Makefile     |  19 +--
 10 files changed, 337 insertions(+), 306 deletions(-)
 create mode 100644 shared.mak

Range-diff against v3:
 1:  1621ca72c1d =  1:  1621ca72c1d Makefile: don't invoke msgfmt with --statistics
 2:  b7c36c9fea0 =  2:  b7c36c9fea0 Makefile: don't set up "perl/build" rules under NO_PERL=Y
 3:  510499d18ba !  3:  29b000eb0f1 Makefile: use "=" not ":=" for po/* and perl/*
    @@ Commit message
         think I copied some POC code), and in 2017 I used the 2011 commit for
         reference.
     
    +    This doesn't make much if any of a practical difference, doing this is
    +    cheap either way, but as simply-expanded variables in our Makefile
    +    generally indicate special behavior (e.g. making a copy now, and
    +    modifying the RHS later) let's change these to show that nothing odd
    +    is going on here).
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
 4:  37f3591bcca =  4:  daead5ec293 Makefile: clean perl/build/ even with NO_PERL=Y
 5:  e38c90ad0b6 !  5:  3c987590740 Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
    @@ Commit message
         file that'll be used as a dependency for other files, as in this case
         for GIT-PERL-HEADER.
     
    +    We have had a hard dependency on .DELETE_ON_ERROR since
    +    7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR" flag,
    +    2021-06-29), so this is a pure cleanup as a follow-up to that
    +    commit. Support for the ".DELETE_ON_ERROR" target itself is much older
    +    than any GNU make version we support, it was added to GNU make in
    +    1994.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
 6:  98e14c7eba9 =  6:  b57f582ccd3 Makefile: guard Perl-only variable assignments
 7:  047a42b01cf =  7:  fcdee92f64c Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
 8:  0c0a3de390e =  8:  1e25b532ca2 Makefile: adjust Perl-related comments & whitespace
 9:  1ece3160915 =  9:  77d9855bfcf Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
10:  e9b61cd0ba5 = 10:  6004cdcd8d9 Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
11:  b020f8e3257 = 11:  17b30e96057 Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
12:  19539ce7d2d = 12:  30ddf7da2c8 Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
13:  6c9291c2c9f = 13:  f378a7dc35e Makefile: move $(comma), $(empty) and $(space) to shared.mak
14:  e811a907b08 = 14:  13cbb851d32 Makefile: re-add and use the "shellquote" macros
15:  fac30fe8b56 ! 15:  337953e4994 Makefile: add a "TRACK_template" for GIT-*{FLAGS,DEFINES,...}
    @@ shared.mak: shelldquote = '"$(call shdq,$(call shq,$(1)))"'
     +$(1): FORCE
     +	@FLAGS='$$($(2))'; \
     +	if ! test -f $(1) ; then \
    -+		echo $(wspfx_sq) "$(1) PARAMETERS (new)" $@; \
    ++		echo $(wspfx_sq) "$(1) PARAMETERS (new)"; \
     +		echo "$$$$FLAGS" >$(1); \
     +	elif test x"$$$$FLAGS" != x"`cat $(1) 2>/dev/null`" ; then \
    -+		echo $(wspfx_sq) "$(1) PARAMETERS (changed)" $@; \
    ++		echo $(wspfx_sq) "$(1) PARAMETERS (changed)"; \
     +		echo "$$$$FLAGS" >$(1); \
     +	fi
     +endef
16:  a3e3acea82d = 16:  5bb597c1993 Makefile: add "$(QUIET)" boilerplate to shared.mak
17:  22264f431c8 = 17:  3c4d0589667 Makefile: use $(wspfx) for $(QUIET...) in shared.mak
18:  d61e2b44f68 = 18:  be5882b2c99 Makefiles: add and use wildcard "mkdir -p" template
19:  234b4eb613c ! 19:  2710f8af6cd Makefile: correct the dependency graph of hook-list.h
    @@ Commit message
         inadvertently made to depend on hook-list.h, but it's used by
         builtin/bugreport.c.
     
    +    The hook.c also does not depend on hook-list.h. It did in an earlier
    +    version of the greater series cfe853e66be was extracted from, but not
    +    anymore. We might end up needing that line again, but let's remove it
    +    for now.
    +
         Reported-by: Mike Hommey <mh@glandium.org>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
     @@ Makefile: git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
    + 		$(filter %.o,$^) $(LIBS)
      
      help.sp help.s help.o: command-list.h
    - hook.sp hook.s hook.o: hook-list.h
    +-hook.sp hook.s hook.o: hook-list.h
     +builtin/bugreport.sp builtin/bugreport.s builtin/bugreport.o: hook-list.h
      
     -builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h GIT-PREFIX
20:  567ad5c3ebc = 20:  59f22a0269a Makefile: use $(file) I/O instead of "FORCE" when possible
21:  cb3ae5ce00b ! 21:  dd569a59c74 Makefile: disable GNU make built-in wildcard rules
    @@ Commit message
         benchmark command shows (under --show-output) that we went from ~7716
         syscalls to ~7519, mostly a reduction in [l]stat().
     
    +    We could also invoke make with "-r" by setting "MAKEFLAGS = -r" early,
    +    adding a "-r" variant to the above benchmark shows that it may be 1.01
    +    or so faster (but in my tests, always with a much bigger error
    +    bar). But doing so is a much bigger hammer, since it will disable all
    +    built-in rules, some (all?) of which can be seen with:
    +
    +        make -f/dev/null -p | grep -v -e ^# -e ^$
    +
    +    We may have something that relies on them, so let's go for the more
    +    isolated optimization here that gives us most or all of the wins.
    +
         1. https://lists.gnu.org/archive/html/help-make/2002-11/msg00063.html
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
22:  88cfc946b37 = 22:  4168a7e3b30 Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
23:  276e226f0a8 = 23:  48a3927d972 Makefile: move ".SUFFIXES" rule to shared.mak
-- 
2.34.0.796.g2c87ed6146a

