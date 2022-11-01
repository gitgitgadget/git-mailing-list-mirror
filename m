Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C35C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiKAWh0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiKAWgp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:36:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CF62034E
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:36:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b2so40797510eja.6
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxbYKbELPp7cXOUSqr2Kpjy5MCUwtMDRTybnIkab66A=;
        b=Eg09kla29pjKKRLqNUOT9vTnfr57YApFPE+gLoWbKPnxFKwoqSWN2IHaHBoIBD8kWy
         nqA6cSaE1fWrIYTlyTtKtWaRyQ9XvE0voyFkBIBh3idVKQF/9JoiMa34HRkSx73KorQe
         YxSBa5fTL63BTYRG+8jjPlpy2NT+ikhm5vZp7NL/P2u1Ss9ilu55Xr4g3lOfAhHAS97F
         aFOwbOVwLeTmfHqWGXskRbGj9fGc69pchm3Je9b3pm+6FKbWWeV1Kz5qlQ3WoZuh8ust
         0fThOY4evwQY3RwYHenR/fqsh+q2yOsRNkKaoKwVkjSCJZLV6z/hyouzxGQsK4SFMb8m
         2fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxbYKbELPp7cXOUSqr2Kpjy5MCUwtMDRTybnIkab66A=;
        b=60pHvkV4HbvAxILAfHH0WPNzxKCDXxuWCaazwdwiKV1Xl8r56UT3JE9VtqqzjCqoZp
         92QbEH4Yah3UdwL/e9LkQhRyDhsRB/ObucieYiuEKz91CR+5k3+zOkNh0I/SNLFujVf1
         0ZOw3MFykHtA1++4LzNjdXpbwzWWer4K/6eb1YpjlpzMd+XbgE6QPaPVHaH5eRFZbD7o
         +dgt8YxK3dYQRWa1umv3uD/U7ZNDXEZZeLNVIsxDRCJPVjXCrZT5G8bB8aWjMDnPCeHn
         sefMfbOiYVVYVv2S/0ySgrJg0yYXFMovmFOw6ygxNj6tDP5hwu7HO0U+XBs08kEjsMZP
         iquA==
X-Gm-Message-State: ACrzQf00MYGrYS+/Y1TIaxcMx/SRGQBOx4chCvWOLzMqfL1DhkVJgv/o
        ZHxWjDwzeOJcBSNG6/jyRY1mWHxLNBWT7g==
X-Google-Smtp-Source: AMsMyM5X9K0avmgDbYISB2rcebFmKVI5GMhjPU7kqhR4Iqh2KnbpL+jeGIH2wBgUxAKQJoVLKrazxg==
X-Received: by 2002:a17:907:7ea0:b0:7ad:ef1e:3bc6 with SMTP id qb32-20020a1709077ea000b007adef1e3bc6mr4746342ejc.690.1667342169577;
        Tue, 01 Nov 2022 15:36:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id rp7-20020a170906d96700b0078dd4c89781sm4693845ejb.35.2022.11.01.15.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:36:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 09/13] cocci: optimistically use COMPUTE_HEADER_DEPENDENCIES
Date:   Tue,  1 Nov 2022 23:35:51 +0100
Message-Id: <patch-v5-09.13-332fb6c8640-20221101T222616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the incremental rebuilding support of "coccicheck" by
piggy-backing on the computed dependency information of the
corresponding *.o file, rather than rebuilding all <RULE>/<FILE> pairs
if either their corresponding file changes, or if any header changes.

This in effect uses the same method that the "sparse" target was made
to use in c234e8a0ecf (Makefile: make the "sparse" target non-.PHONY,
2021-09-23), except that the dependency on the *.o file isn't a hard
one, we check with $(wildcard) if the *.o file exists, and if so we'll
depend on it.

This means that the common case of:

	make
	make coccicheck

Will benefit from incremental rebuilding, now changing e.g. a header
will only re-run "spatch" on those those *.c files that make use of
it:

By depending on the *.o we piggy-back on
COMPUTE_HEADER_DEPENDENCIES. See c234e8a0ecf (Makefile: make the
"sparse" target non-.PHONY, 2021-09-23) for prior art of doing that
for the *.sp files. E.g.:

    make contrib/coccinelle/free.cocci.patch
    make -W column.h contrib/coccinelle/free.cocci.patch

Will take around 15 seconds for the second command on my 8 core box if
I didn't run "make" beforehand to create the *.o files. But around 2
seconds if I did and we have those "*.o" files.

Notes about the approach of piggy-backing on *.o for dependencies:

 * It *is* a trade-off since we'll pay the extra cost of running the C
   compiler, but we're probably doing that anyway. The compiler is much
   faster than "spatch", so even though we need to re-compile the *.o to
   create the dependency info for the *.c for "spatch" it's
   faster (especially if using "ccache").

 * There *are* use-cases where some would like to have *.o files
   around, but to have the "make coccicheck" ignore them. See:
   https://lore.kernel.org/git/20220826104312.GJ1735@szeder.dev/

   For those users a:

	make
	make coccicheck SPATCH_USE_O_DEPENDENCIES=

   Will avoid considering the *.o files.

 * If that *.o file doesn't exist we'll depend on an intermediate file
   of ours which in turn depends on $(FOUND_H_SOURCES).

   This covers both an initial build, or where "coccicheck" is run
   without running "all" beforehand, and because we run "coccicheck"
   on e.g. files in compat/* that we don't know how to build unless
   the requisite flag was provided to the Makefile.

   Most of the runtime of "incremental" runs is now spent on various
   compat/* files, i.e. we conditionally add files to COMPAT_OBJS, and
   therefore conflate whether we *can* compile an object and generate
   dependency information for it with whether we'd like to link it
   into our binary.

   Before this change the distinction didn't matter, but now one way
   to make this even faster on incremental builds would be to peel
   those concerns apart so that we can see that e.g. compat/mmap.c
   doesn't depend on column.h.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                  | 15 +++++++++++++--
 contrib/coccinelle/README | 16 ++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 4bedff26285..c7c96d284dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1307,6 +1307,13 @@ SPATCH_INCLUDE_FLAGS = --all-includes
 SPATCH_FLAGS =
 SPATCH_TEST_FLAGS =
 
+# If *.o files are present, have "coccicheck" depend on them, with
+# COMPUTE_HEADER_DEPENDENCIES this will speed up the common-case of
+# only needing to re-generate coccicheck results for the users of a
+# given API if it's changed, and not all files in the project. If
+# COMPUTE_HEADER_DEPENDENCIES=no this will be unset too.
+SPATCH_USE_O_DEPENDENCIES = YesPlease
+
 # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
 TRACK_SPATCH_DEFINES =
 TRACK_SPATCH_DEFINES += $(SPATCH)
@@ -3181,14 +3188,18 @@ COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN) >$@
 
+ifeq ($(COMPUTE_HEADER_DEPENDENCIES),no)
+SPATCH_USE_O_DEPENDENCIES =
+endif
 define cocci-rule
 
 ## Rule for .build/$(1).patch/$(2); Params:
 # $(1) = e.g. "free.cocci"
 # $(2) = e.g. "grep.c"
+# $(3) = e.g. "grep.o"
 COCCI_$(1:contrib/coccinelle/%.cocci=%) += .build/$(1).patch/$(2)
 .build/$(1).patch/$(2): GIT-SPATCH-DEFINES
-.build/$(1).patch/$(2): .build/contrib/coccinelle/FOUND_H_SOURCES
+.build/$(1).patch/$(2): $(if $(and $(SPATCH_USE_O_DEPENDENCIES),$(wildcard $(3))),$(3),.build/contrib/coccinelle/FOUND_H_SOURCES)
 .build/$(1).patch/$(2): $(1)
 .build/$(1).patch/$(2): .build/$(1).patch/% : %
 	$$(call mkdir_p_parent_template)
@@ -3205,7 +3216,7 @@ endef
 
 define cocci-matrix
 
-$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(1),$(s)))
+$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s),$(s:%.c=%.o)))
 endef
 
 ifdef COCCI_GOALS
diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
index f0e80bd7f03..09ea8298e19 100644
--- a/contrib/coccinelle/README
+++ b/contrib/coccinelle/README
@@ -41,3 +41,19 @@ There are two types of semantic patches:
 
    This allows to expose plans of pending large scale refactorings without
    impacting the bad pattern checks.
+
+Git-specific tips & things to know about how we run "spatch":
+
+ * The "make coccicheck" will piggy-back on
+   "COMPUTE_HEADER_DEPENDENCIES". If you've built a given object file
+   the "coccicheck" target will consider its depednency to decide if
+   it needs to re-run on the corresponding source file.
+
+   This means that a "make coccicheck" will re-compile object files
+   before running. This might be unexpected, but speeds up the run in
+   the common case, as e.g. a change to "column.h" won't require all
+   coccinelle rules to be re-run against "grep.c" (or another file
+   that happens not to use "column.h").
+
+   To disable this behavior use the "SPATCH_USE_O_DEPENDENCIES=NoThanks"
+   flag.
-- 
2.38.0.1280.g8136eb6fab2

