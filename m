Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED2CC433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiKAWhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiKAWgk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:36:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B91E1A3B5
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:36:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t25so40792358ejb.8
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mzFEpdaqsDCo8f2gxQ7sl29y3emxaFEH+mHNyQ34cE=;
        b=Mp21wHW+URjliteZxnRUo8jUKBDxJviG6jI8bQcIJY9a8irTMj2ocWLq4UFFgLI8yq
         RJAmbACyaVfybyaafdMhm5Z2FCcjVEI9JsvPqxZja3f6MZ967HkMZGyHlCs++SnJs9pv
         pm8nmzMETkYFeJ0AsUmPWH17PB4//qAO2nADpHaVvXsUqJb06qmEdKlX0uxN+9xnxucQ
         MZpWklz7PU8+cGnxJNh2v8WsIdms+MJeM2djrYACFPR01mSIX6uXcPICrDabOFujwXkS
         mxYrESPRyLzT586rZwopYCWeP6fvblpBV0yjPfGxddSeXNmmlpUpqIFaHiu09qE/qjZS
         fdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mzFEpdaqsDCo8f2gxQ7sl29y3emxaFEH+mHNyQ34cE=;
        b=KFmDVlgTeaP1jzfAz1AwFhFR2f4PzoMl0VM9hJJQIYxV5fxnBsMZhK5/ONbVFJlXQx
         0AK7Xds6MVJRW0WLScRjLSaalaUkeLdRNaR2yI6ceiE5z/qTFLJQ4Q5/PX2HJHpZQoSA
         gcTunSOCHWJDhttk02uRUvR+TI5vEs1WxiHYBMEUiuZGaAxoXsr45HFE6E4K4XJfeobQ
         cZPLob9WvtatSnKqlq6lCpmKEfhnZYA14ajFXsB+WEHks/BpUhFOL48LzaZjic/tsrJW
         +EI52GEuy84lbJzrvh0KsEtXTHUEXa+Kozt56oDDpUmnIvHbdkF4PoeTdIUe1XfUbyJP
         9ZAQ==
X-Gm-Message-State: ACrzQf0zB8ccMr2TfuquULQUauAY5z8Ezq5H3Zwm8ok2/UN4WGxBxSwE
        ipihfHfeBG3HE4q4ZEWtevp82DHonDerXg==
X-Google-Smtp-Source: AMsMyM4uhDFiuL//YHmxqRMlDgM/brtXd+DRDkM4z2cBTpnRNjdvxOGVH2lz/TXHUtAFghy8AGMU7Q==
X-Received: by 2002:a17:906:9b8e:b0:791:8f57:6845 with SMTP id dd14-20020a1709069b8e00b007918f576845mr20998243ejc.174.1667342164452;
        Tue, 01 Nov 2022 15:36:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id rp7-20020a170906d96700b0078dd4c89781sm4693845ejb.35.2022.11.01.15.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:36:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 04/13] Makefile: have "coccicheck" re-run if flags change
Date:   Tue,  1 Nov 2022 23:35:46 +0100
Message-Id: <patch-v5-04.13-460025dbbf6-20221101T222616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
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
"make cocciclean".

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
 Makefile   | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/.gitignore b/.gitignore
index cb0231fb401..0832f1da77b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -8,6 +8,7 @@
 /GIT-PERL-HEADER
 /GIT-PYTHON-VARS
 /GIT-SCRIPT-DEFINES
+/GIT-SPATCH-DEFINES
 /GIT-USER-AGENT
 /GIT-VERSION-FILE
 /bin-wrappers/
diff --git a/Makefile b/Makefile
index 828d332096a..d81b0931ddd 100644
--- a/Makefile
+++ b/Makefile
@@ -1308,6 +1308,18 @@ SANITIZE_ADDRESS =
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
@@ -3156,6 +3168,7 @@ COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
 COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 
 COCCI_PATCHES = $(COCCI_RULES:%=%.patch)
+$(COCCI_PATCHES): GIT-SPATCH-DEFINES
 $(COCCI_PATCHES): $(COCCI_SOURCES)
 $(COCCI_PATCHES): %.patch: %
 	$(QUIET_SPATCH) \
@@ -3179,6 +3192,7 @@ $(COCCI_PATCHES): %.patch: %
 	fi
 
 COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
+$(COCCI_TEST_RES_GEN): GIT-SPATCH-DEFINES
 $(COCCI_TEST_RES_GEN): .build/%.res : %.c
 $(COCCI_TEST_RES_GEN): .build/%.res : %.res
 $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
@@ -3465,6 +3479,7 @@ profile-clean:
 	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
 
 cocciclean:
+	$(RM) GIT-SPATCH-DEFINES
 	$(RM) -r .build/contrib/coccinelle
 	$(RM) contrib/coccinelle/*.cocci.patch*
 
-- 
2.38.0.1280.g8136eb6fab2

