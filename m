Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE6AC65C0D
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 14:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242076AbiHYOgh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 10:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242056AbiHYOga (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 10:36:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017B4AB189
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 07:36:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n17so277935wrm.4
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=N5jFCS2rph2mfSaem0PO14uWeAUqXg8pBdj6jplhKtM=;
        b=f+gAAiKsFNRPeJfFlvuYzeCb4gcaBgnpvPHEW1lLyGUGVqKX0PV6Ud2K9gZoqGQKNO
         gFiwgxU77THZu61hbw5pjynMfd4OxHxfUvcabtbJxwW5yFRdnMF8lRn6Hl+sRyyFl5jU
         ERT7nnDBTS58+MzxNN85TplSpt9ZFDxYQiRuT70cSi8Tm7pvbTk8Au7WCBuwJeXwzSj0
         OEe8OR/kDoYpIBxXZwwhbTQ5xJBHcroVuo/IPTzRObMgBiliP5fBFleXXoB8eRSp1586
         laKklRWJFaNaOe432efprRNLG+DIsDUBqdzmShAl2vXhba+Igs/QLmjJlRBD5xRRBO9O
         /G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=N5jFCS2rph2mfSaem0PO14uWeAUqXg8pBdj6jplhKtM=;
        b=i6QpuhdEzysrxPjAhhHTBtJRZjf9vV9B+5PuFE/+behYc9iPJalzug6ot4YO0xGDXi
         C8IUhupgfLqWlJVRxhNa6C+Nh86vSNost9xgnMhinqo8RKecmDashdq1jdk6W02tpGW4
         nMA/YiYcqcMHbHX+CpaSr9ExOkhIJqUtcASCDvjbCtOnXH08nPj3gr2IaVwHHMMpp3h3
         8gEl2rily3Z+6Df+w9XJK6/0xR+sdwaHuLkqfluD5uFIHRUhW/SbSWmWJuRja1TQYJ32
         +iwTDHc1NRML2xo7eaLAol8AVr6lUNRv7xryBvxfRLm3SUqn2rqXkaujDLasEsHKV0dV
         kd9w==
X-Gm-Message-State: ACgBeo08sd/N09eYtoQMZZh4UofIvL5j367jR/nMnaKxR5ZKk9g+f/nE
        pC5biFH8rDjpqfdGQ1BdtqbhOVGL8js=
X-Google-Smtp-Source: AA6agR4dRQnmnXyPiTJOPuE6Rl50El3w3OVKSmN3mpJNTtZz2acdkyzfScfK0Q3Uq6iQXxLwdddUHg==
X-Received: by 2002:a5d:6e8e:0:b0:220:5fa1:d508 with SMTP id k14-20020a5d6e8e000000b002205fa1d508mr2658839wrz.337.1661438183199;
        Thu, 25 Aug 2022 07:36:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m27-20020a056000181b00b0022549ac786asm14418027wrh.47.2022.08.25.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 07:36:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] Makefile: have "coccicheck" re-run if flags change
Date:   Thu, 25 Aug 2022 16:36:14 +0200
Message-Id: <patch-2.5-db3b3427668-20220825T141212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an issue with the "coccicheck" family of rules that's been here
since 63f0a758a06 (add coccicheck make target, 2016-09-15), unlike
e.g. "make grep.o" we wouldn't re-run it when $(SPATCH) or
$(SPATCH_FLAGS) changed. To test new flags we needed to first do a
"make clean".

This now uses the same (copy/pasted) pattern as other "DEFINES"
rules. As a result we'll re-run properly. This can be demonstrated
e.g. on the issue noted in [1]:

	$ make contrib/coccinelle/xcalloc.cocci.patch COCCI_SOURCES=promisor-remote.c V=1
	[...]
	    SPATCH contrib/coccinelle/xcalloc.cocci
	$ make contrib/coccinelle/xcalloc.cocci.patch COCCI_SOURCES=promisor-remote.c SPATCH_FLAGS="--all-includes --recursive-includes"
	    * new spatch flags
	    SPATCH contrib/coccinelle/xcalloc.cocci
	     SPATCH result: contrib/coccinelle/xcalloc.cocci.patch
	$

1. https://lore.kernel.org/git/20220823095602.GC1735@szeder.dev/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore |  1 +
 Makefile   | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/.gitignore b/.gitignore
index 42fd7253b44..a32ad64d4c9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,6 +10,7 @@
 /GIT-PERL-HEADER
 /GIT-PYTHON-VARS
 /GIT-SCRIPT-DEFINES
+/GIT-SPATCH-DEFINES
 /GIT-USER-AGENT
 /GIT-VERSION-FILE
 /bin-wrappers/
diff --git a/Makefile b/Makefile
index bd8faac61ee..749eb9b25e3 100644
--- a/Makefile
+++ b/Makefile
@@ -1296,6 +1296,18 @@ SANITIZE_ADDRESS =
 SPATCH_FLAGS = --all-includes
 SPATCH_BATCH_SIZE = 1
 
+# Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
+TRACK_SPATCH_DEFINES =
+TRACK_SPATCH_DEFINES += $(SPATCH)
+TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
+TRACK_SPATCH_DEFINES += $(SPATCH_BATCH_SIZE)
+GIT-SPATCH-DEFINES: FORCE
+	@FLAGS='$(TRACK_SPATCH_DEFINES)'; \
+	    if test x"$$FLAGS" != x"`cat GIT-SPATCH-DEFINES 2>/dev/null`" ; then \
+		echo >&2 "    * new spatch flags"; \
+		echo "$$FLAGS" >GIT-SPATCH-DEFINES; \
+            fi
+
 include config.mak.uname
 -include config.mak.autogen
 -include config.mak
@@ -3142,6 +3154,7 @@ COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_PATCHES))
 
 COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 
+$(COCCI_PATCHES): GIT-SPATCH-DEFINES
 $(COCCI_PATCHES): $(COCCI_SOURCES)
 $(COCCI_PATCHES): %.patch: %
 	$(QUIET_SPATCH) \
@@ -3165,6 +3178,7 @@ $(COCCI_PATCHES): %.patch: %
 	fi
 
 COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
+$(COCCI_TEST_RES_GEN): GIT-SPATCH-DEFINES
 $(COCCI_TEST_RES_GEN): .build/%.res : %.c
 $(COCCI_TEST_RES_GEN): .build/%.res : %.res
 $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
-- 
2.37.2.1279.g64dec4e13cf

