Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BB9C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiJNPcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiJNPbx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:31:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB353F708D
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bk15so8089577wrb.13
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGmsNyij+p/pGl1CpEikcPadeNmFGDkLJ7eI/3Yc/4Q=;
        b=OL7/Djra6f+rLDYgFeL5rIpePNDBa8u5AaOeaYfgqBkEK/8dv70dDbwcJ7Jj+mEJTJ
         3doI4yDA1M4QMNTnXhwov1lvkug1lhYALlkxHAbg80wFzXGH2UgyY3SbxGsZMI2MR9r4
         imq10KsWalfsQGrMPvE1wBIuOIbsxRKZ9wOMTrZOWwi5rx8ZlFXUL5rnfN/IsKvgs/6F
         GAe5M6rlAq96Sl/i4M+byvfEqnQkS9StsukLNqYZMcb5ggPLLdlGXb3N8XUGaxdkTeNp
         4H+izoItPjLqbGDQHWiG5eEvG7ubOSo/1puwufeN0Polg0NXfI41TeiEiRBV2RPJkIHq
         AtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGmsNyij+p/pGl1CpEikcPadeNmFGDkLJ7eI/3Yc/4Q=;
        b=P6aFZQ89jjZijsi6EnqNxioKEtCauAK9mfWwgJSZZKmc7UtGzWK1bW707p5suRDfYu
         PBjtqRy9D0HqicLFOB7pu9TXMsRlngP4933a8Lmx0890H+L5mk9XYOIf1ujVtGH0FdfR
         6ElbBo4n5xJaK2mFJ19Ry3w/PwMALarBFf03PT7G/uUq6RQcRoAqCyT7yRhwhJP/SqEk
         6wNOYOkbaLCBXGeVCJFP+MEY0DDodB7eB/NfhiEQsuWxJQUzSIcZ0wrgaBlDpmLLpTSe
         ZjZZuHki+6mGq5FKIC4dg+nT0bC+ElWM/eq/x43t2S4dBlQNpJhzEIb8Qh6Wg8oan3zu
         UtHA==
X-Gm-Message-State: ACrzQf3tZDtZcWtkFBYddjTCWQV9o7KP6QUO8jTJUHShjtwBL9M0lb7i
        VrfQBVmvDxn9b0+LRzcCjNNCpSHU8tjTQQ==
X-Google-Smtp-Source: AMsMyM4DPdV84hVZLQFPObI+AisvPHb79h0S6io8gn00qy+yQovSdiwPwgLxbI9N3rOeKlV+/NTZWw==
X-Received: by 2002:a5d:4150:0:b0:22f:f9f6:cca1 with SMTP id c16-20020a5d4150000000b0022ff9f6cca1mr3923637wrq.510.1665761504275;
        Fri, 14 Oct 2022 08:31:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b003b47ff307e1sm2219053wmb.31.2022.10.14.08.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:31:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/11] cocci: optimistically use COMPUTE_HEADER_DEPENDENCIES
Date:   Fri, 14 Oct 2022 17:31:25 +0200
Message-Id: <patch-v3-09.11-739652eada9-20221014T152553Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com> <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
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
 Makefile | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 4e1da7206db..bd3b5c21d6f 100644
--- a/Makefile
+++ b/Makefile
@@ -1303,6 +1303,13 @@ SPATCH_INCLUDE_FLAGS = --all-includes
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
@@ -3175,14 +3182,18 @@ COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
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
@@ -3199,7 +3210,7 @@ endef
 
 define cocci-matrix
 
-$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(1),$(s)))
+$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s),$(s:%.c=%.o)))
 endef
 
 ifdef COCCI_GOALS
-- 
2.38.0.1092.g8c0298861b0

