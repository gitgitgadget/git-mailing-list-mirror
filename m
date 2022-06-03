Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EB1CCA473
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345061AbiFCSkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347221AbiFCSjG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DFB2616
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r123-20020a1c2b81000000b0039c1439c33cso4745992wmr.5
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vPWxm4jewQr4g5pmSjkl40nxw8y46JPP5i4gCPXmvec=;
        b=khcfuuDbTU3QC38Ven46lVMZEK7cl3HFZ8y06We5FMH8KRw+kZikIwiqYwsy/GmF6u
         yZTa4ZhQEsnPrBpIVFA33WrpMuHKOTkW7hEC6P52N//AUbKdcCLCODCsVkyH/O+5u8aN
         A/u3SOHSe4lxvHiE+dEyz6PiKonqWiPB1s+hEPvsq57SyCwJUCGtjDNDIsSLSUDdIqHX
         ecql4i7iZ4IkUCPMp/aKJ6sIPYxPwTz8w3va0jbKD1W7GTT2Gx0nYOXUNU27JP8lH4Uk
         /Q3Y6dz4rUeoJ4ggE9iUu0vXWdCVOb/eLTzFWcSOHrf7KAvCgqvzn10auKFt/4mxWXIX
         IgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPWxm4jewQr4g5pmSjkl40nxw8y46JPP5i4gCPXmvec=;
        b=FSmMWRQbG/oDf9YITb50fJ+Z8QU5cxt1QeSBs4N96ABEYaUOyaH4J/yEmRD+HygnGk
         6rA5DVYOLiAkfbTX/l+FX/WP47TCBTM6VxZ6t8jE6mTf+PPpARQyj87ay83eLGH5f0+O
         7QasOdlBB/0Z5T1hGQgDY7AlVke7lJIAiAk6A5cz7EgoR6m9ZvH576UfrWuNe9fx7+Hq
         J79cNK5tExIJJTWrMVz6ZGGcWCaYY6vrBzH69x7Kx5nHlcD9b9nRVeaDuaFENSqKEthi
         i+Qb+9WtDrUqjGLG0zl4bmfkVyF5lrP4yvXF7TDXaSKhaA9G4qchAHC62j0Z2vGYdKCo
         jJkQ==
X-Gm-Message-State: AOAM530tIziCBCvYzOrcdy2OnZylch00AU5A8sV8PfVO2r8VFMSQtA2i
        nasbFdcSkjeWXv6Tb4SH584b8IQUl7teug==
X-Google-Smtp-Source: ABdhPJw3JVSI4ZTGWu6zuLvJMqjHs37nQLsP2pPdg42UDmkAuthw0/JqEQITVk8ZSgtsssksLDmHSQ==
X-Received: by 2002:a05:600c:1f07:b0:397:8dea:ee74 with SMTP id bd7-20020a05600c1f0700b003978deaee74mr10033854wmb.148.1654281493538;
        Fri, 03 Jun 2022 11:38:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:38:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 14/15] config.mak.dev: add a DEVOPTS=analyzer mode to use GCC's -fanalyzer
Date:   Fri,  3 Jun 2022 20:37:51 +0200
Message-Id: <RFC-patch-14.15-9cf550688d4-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an option to compile with GCC's -fanalyzer, which as noted in [1]
and [2] has become much more useful in the recently released GCC v12
series.

Here we're quieting a few outstanding -fanalyzer issues that require
us to use -Wno-error=* on an entire file:

 * range-diff.c, because it involves loop variables and would be
   painfully verbose to instrument with the ASSERT_FOR_FANALYZER() macro
   introduced in the subsequent commit.

 * http-fetch.c and fsmonitor-settings.c, because those aren't issues
   where we're referencing NULL, and therefore we can't quiet it with an
   assert().

For non-GCC compilers I considered wrapping the DEVOPTS logic in:

	ifneq ($(filter gcc10,$(COMPILER_FEATURES)),)
	endif

Which would make it OK to specify DEVOPTS=analyzer under other
compilers, or on older GCC. But then we'd silently ignore the option
on those. Let's instead trust the compiler to error out if it doesn't
support -fanalyzer.

There are various limitations and bugs in the analyzer engine, e.g. I
filed [3] for a false positive in builtin/merge-file.c before GCC v12
was released, which was subsequently fixed in GCC 12 trunk in [4], but
many other issues remain.

1. https://developers.redhat.com/articles/2022/04/12/state-static-analysis-gcc-12-compiler
2. https://gcc.gnu.org/gcc-12/changes.html
3. https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105264
4. https://gcc.gnu.org/git/gitweb.cgi?p=gcc.git;h=a358e4b60815b41e27f3508014ceb592f86b9b45

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile       | 14 ++++++++++++
 config.mak.dev | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/Makefile b/Makefile
index 18ca6744a50..129d55f5992 100644
--- a/Makefile
+++ b/Makefile
@@ -507,6 +507,20 @@ include shared.mak
 #    no-pedantic:
 #
 #        Disable -pedantic compilation.
+#
+#    analyzer:
+#
+#        Compile with GCC's -fanalyzer, this analysis is much more
+#        expensive than other GCC warnings.
+#
+#        The set of analysis flags is curated based on known issues
+#        and compiler version. Known issues are made into non-fatal
+#        warnings (even "no-error" isn't set).
+#
+#    no-suppress-analyzer:
+#
+#        When using "analyzer" disable the suppression of known
+#        -fanalyzer issues.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
diff --git a/config.mak.dev b/config.mak.dev
index c3104f400b2..d6f5be92297 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -72,3 +72,64 @@ DEVELOPER_CFLAGS += -Wno-error=dangling-pointer
 endif
 
 GIT_TEST_PERL_FATAL_WARNINGS = YesPlease
+
+# GCC's -fanalyzer mode
+ifeq ($(filter analyzer,$(DEVOPTS)),analyzer)
+
+ifeq ($(filter gcc1,$(COMPILER_FEATURES)),)
+$(error you must be using a new-ish version of GCC for DEVOPTS=analyzer, your \
+$(CC) is not GCC at all!)
+endif
+
+DEVELOPER_CFLAGS += -fanalyzer
+
+## -fanalyzer exists exists as of gcc10, but versions older than gcc12
+## have a lot of false positives.
+ifeq ($(filter gcc12,$(COMPILER_FEATURES)),)
+DEVELOPER_CFLAGS += -Wno-analyzer-double-free
+DEVELOPER_CFLAGS += -Wno-analyzer-free-of-non-heap
+endif
+
+## Helper templates to whitelist existing issues
+define fn_disable_analyzer_tmpl
+$(1).sp $(1).s $(1).o: EXTRA_CPPFLAGS += $(2)
+
+endef
+
+define fn_disable_analyzer
+$(foreach f,$(2),$(call fn_disable_analyzer_tmpl,$(f),$(1)))
+endef
+
+## -Wno-error=analyzer-null-dereference
+$(eval $(call fn_disable_analyzer, \
+	-Wno-error=analyzer-null-dereference, \
+	range-diff \
+))
+## -Wno-error=analyzer-malloc-leak
+$(eval $(call fn_disable_analyzer, \
+	-Wno-error=analyzer-malloc-leak, \
+	fsmonitor-settings \
+))
+## per-GCC version annotations
+### -Wno-error=analyzer-use-of-uninitialized-value: gcc >= 12
+ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
+$(eval $(call fn_disable_analyzer, \
+	-Wno-error=analyzer-use-of-uninitialized-value, \
+	http-fetch \
+))
+else # gcc < 12
+### -Wno-error=analyzer-null-dereference: gcc == 11
+ifneq ($(filter gcc11,$(COMPILER_FEATURES)),)
+$(eval $(call fn_disable_analyzer, \
+	-Wno-error=analyzer-null-dereference, \
+	merge \
+	xdiff/xemit \
+	reftable/reader \
+))
+else
+$(error Your GCC version is too old for -fanalyze, or you are using \
+gcc10 which has it, but has too many false positives!)
+endif
+endif # gcc < 12
+
+endif
-- 
2.36.1.1124.g577fa9c2ebd

