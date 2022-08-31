Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87384ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiHaU6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiHaU6J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:58:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D70DA3F0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id s23so7975908wmj.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Kdy5vFeElnRH1nV4Cp8wiUhmD094GQ6MJvqpTruDVec=;
        b=f030PgT//Dk6bVTPodRoV360iZoZoZad1lTCVCQfryUwAgTLNu/IE770vqEzcOLOjb
         AbRRBle5E3FidbUIscgXtCKdKWDa8IC70dxPjs/l6WvNfeBvGiR9EoDSLrb2d8z+Vkz+
         FAxpkOgsh/jmUTEwmPoOdT1LpkR4Vc2JK8ticbvx8CYas57aXcYpPSDtQrORG0ZPd8RJ
         EHU9UKg2em4UlDmplwyWPwYrxPejA6O6CTNLv2cnj4j1TD3VFE75qymamN30OWSIBHRM
         azfmYt174I/uiH08e4KVK1m+wbEaw7K+RGLpkksA0CZKHCrn333/4k+53PGxsOP+2zA4
         +Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Kdy5vFeElnRH1nV4Cp8wiUhmD094GQ6MJvqpTruDVec=;
        b=co1VY595EsvXpg5kAOOhXsXYhIDGX6LklRRAuhnZXTvsDSogN6ujhTv1Qx/Tkd0FFU
         xxU2SsoE19o7ZUGws52gNMNVys7NFwH4m94LIK0NtL/VQMomD9iPFRjXI/9jCfs5smUj
         TZjkOrhGIZs6Cwaa52dyFYlrxsWg1Il6QiAVG2q91w+g7932+qtFLCQZh48spUQcydAS
         PILqqGBFsQIxZ1xyqBmJDZ/IVakpp/ADddZzS/gLuQD4fw0ZD4Gb8R2TCMvDtxBt/BD9
         xA519CU+vp9PuWc4fwe29ZRmzIeaplFzI24p11uPofhkncP2V3OClXCT84s893dOX6MS
         zAKg==
X-Gm-Message-State: ACgBeo23vrW9RZCsgvM0YF6nA6uZnDMR9ptJg5ytdTPeYzHfDTNKcTRG
        hjtIYY7qR0CNyCy6QFAONd/urgPgWMyg+w==
X-Google-Smtp-Source: AA6agR6bRbuerNmTG0CtAHJhdHLTyN5rrZww+lSEXdtQ4NMaGaEHnohqMAK2w0Rwg7K/yLApXJmobw==
X-Received: by 2002:a05:600c:a46:b0:3a6:9c49:b751 with SMTP id c6-20020a05600c0a4600b003a69c49b751mr3115272wmq.169.1661979486280;
        Wed, 31 Aug 2022 13:58:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i16-20020adffc10000000b002253af82fa7sm15766955wrr.9.2022.08.31.13.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:58:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/9] Makefile: have "coccicheck" re-run if flags change
Date:   Wed, 31 Aug 2022 22:57:50 +0200
Message-Id: <patch-v2-3.9-63cf9f58d99-20220831T205130Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
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
 Makefile   | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/.gitignore b/.gitignore
index 80b530bbed2..e67085f6918 100644
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
index 42a70eeaef4..55ae3a2feda 100644
--- a/Makefile
+++ b/Makefile
@@ -1300,6 +1300,18 @@ SANITIZE_ADDRESS =
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
@@ -3146,6 +3158,7 @@ COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_PATCHES))
 
 COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 
+$(COCCI_PATCHES): GIT-SPATCH-DEFINES
 $(COCCI_PATCHES): $(COCCI_SOURCES)
 $(COCCI_PATCHES): %.patch: %
 	$(QUIET_SPATCH) \
@@ -3169,6 +3182,7 @@ $(COCCI_PATCHES): %.patch: %
 	fi
 
 COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
+$(COCCI_TEST_RES_GEN): GIT-SPATCH-DEFINES
 $(COCCI_TEST_RES_GEN): .build/%.res : %.c
 $(COCCI_TEST_RES_GEN): .build/%.res : %.res
 $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
-- 
2.37.3.1420.g76f8a3d556c

