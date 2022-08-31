Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E95AECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiHaU63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiHaU6O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:58:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C639DDC0A4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:12 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m16so19773336wru.9
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=aVntDdu/R532+e6kQTUwlzZ9vCj8nZYJDEwRHN1bdRE=;
        b=p8ZV/+BOzwQV9cR0bxRCzk0N9/LKS5JHuTfdO6EIgqIVA7m8YO/wPc7g7vEUVzbMpI
         H97NZvdpr7UBqHo0OGbfRdODUpRVBOsAw08eahsGg2Nnh76II6LWCQv4KsNozR/ILhFv
         MmiQ/mzZCprrKpu4cbsQKYXP3ZUtkdqH5hIam/K8cWHFnMBqE4FFQYkOY930fAEItlAP
         Tzwvk5Dp/nW0lOrdijCdj5icdrCuChQdnBlAajQJmQvI+DshhFl1PzO8Ly2yxbdxHWGK
         skbsJb4Rw7SFYahbVsBXrycOzXHCA3//GuP2RVC3/L3dLUsdVub3cVhr6D8CRXlNOJDX
         LOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aVntDdu/R532+e6kQTUwlzZ9vCj8nZYJDEwRHN1bdRE=;
        b=fn49DvRIy4ApsStQYMS6B+mz7vGqfYbAK6JnrQf7RFsa5din9RBU+mHG7DoDNaVXtM
         hUXh+3Rgko9ZgpiRFsKm+gSShunhSYExMgfpVtHlra2GBORdaseJdMAXAWNv+n7Q7QuE
         k8C12p7kVuhnM9GAGkkMavAOenTXuwpxihkav29aKLxd5F2H9XO11w/s0IamS2ZNN/ow
         aWSeHuR12lXFNkrNi51dhPGD7X6bccuyNcC9eGtfMRNVRyMEgjWMUTn9KHnpbHUIBhER
         tG55svbfohGZ9JOF0/HSQvGH3C9BfQnmjfizePXNS8M16FACgLvFfa6FVcAMmr7Mb+w0
         7Xig==
X-Gm-Message-State: ACgBeo2HbYtOQ6js3smdpI14I64UYfJzCUcoyX1KKhZu9nmmgVx/eIMU
        JPJo8l1UaqyDKJqrxi/5qkm6ppdUgzt1dQ==
X-Google-Smtp-Source: AA6agR76Nl9PjMck6ChYqjJqiwrerr2onObSZ1y/fN7GhG2XiK1rOr5KEvs396+282vr4CUuMVVPXQ==
X-Received: by 2002:a5d:6a85:0:b0:226:d8d9:20ab with SMTP id s5-20020a5d6a85000000b00226d8d920abmr10001354wru.514.1661979490934;
        Wed, 31 Aug 2022 13:58:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i16-20020adffc10000000b002253af82fa7sm15766955wrr.9.2022.08.31.13.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:58:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/9] cocci: optimistically use COMPUTE_HEADER_DEPENDENCIES
Date:   Wed, 31 Aug 2022 22:57:55 +0200
Message-Id: <patch-v2-8.9-536dce45eef-20220831T205130Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
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
 Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 562820301c4..9e2ef8f0dc4 100644
--- a/Makefile
+++ b/Makefile
@@ -3170,14 +3170,20 @@ COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN) >$@
 
+SPATCH_USE_O_DEPENDENCIES = yes
+ifeq ($(COMPUTE_HEADER_DEPENDENCIES),no)
+SPATCH_USE_O_DEPENDENCIES =
+endif
+
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
@@ -3194,7 +3200,7 @@ endef
 
 define cocci-matrix-2
 
-$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s)))
+$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s),$(s:%.c=%.o)))
 endef
 define cocci-matrix-1
 $(foreach c,$(COCCI),$(call cocci-matrix-2,$(c)))
-- 
2.37.3.1420.g76f8a3d556c

