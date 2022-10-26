Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95704C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiJZOVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiJZOVB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:21:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3F7349A6
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 21so7759579edv.3
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHLyDeDPp9XFvz035IF7DJtTdySzQpKaWA8bBxRPbDo=;
        b=Us0k34wzk1h25F4quIufFcpg+q8774JrutjHVaPXy2L964cPZxyVzS7ftvgMAmsEXF
         IyolSZLkSJLGu9/vzbtkBim2fGkQ60HCfsDfUnZ7xRGYnFgdGLkrNcvICrPB7apgg2HG
         +i1n7Lbl3i9ZqckxJb3Iqs7SHdSx2znq4PjxBlRrOEaxddqCatBS5p6XUg2ffhHluqgA
         lxSFrcQc8Nkt2tzP2cFpMm03dBGyj4B1OhztSiAfT6YJWiAwzKhKReB5DHdKNblKFEBP
         ySyqpiEcujBoHW2KDX/Ln3Jv7dxYDvJCCitHtZjHsvnnLY+LSn1NIkoAioprMXvKYWOc
         JfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHLyDeDPp9XFvz035IF7DJtTdySzQpKaWA8bBxRPbDo=;
        b=aQgrlBvqKbwnjsHLvpvXK+6tLyEJ4vS5NgSmI6SWK4hU7Ii/Ez8KIggHG2jzjW7ygI
         YXc05Eqzt4iFCicvNqQkZrcB1Cy6cPcIhN0bl2zT7FsJS0Hxjnci1lqYp8ZsifLZ8EfN
         TsLEx87cQiC/r9nQR8AZjMkOJCZ2nSlS2mOsnRKm3R5piSabjm8w6C/lg+YPkdbwluOB
         o5RZDR6lwbMRiQ540NPW2VrPDcUyT43wHPDpyagW2+2sByl5Ykdxfx45qmSDJ/3OIolA
         1TYpSy5hKCX5kQgUZRtgtmYEaTp90ZBD04TSrvR7mCLLoWg6dTSZLcN1/SBNCyTw7WMp
         6wgg==
X-Gm-Message-State: ACrzQf14xCLvmjSuJlJQA+GSLCprbYKOZNiBAn5F8T6NpqxNzijGqT44
        gXWi53H5UuhepnVhZ93BRO8eb2B7+IM=
X-Google-Smtp-Source: AMsMyM6/BEPQwkJr94/qUlifhQ8U3DaIR7cYBhFakzDdKJejhHItua/flDBTpkV7p8vo1hbumqv0tg==
X-Received: by 2002:a05:6402:b6b:b0:461:b9b2:6d58 with SMTP id cb11-20020a0564020b6b00b00461b9b26d58mr16545859edb.186.1666794058270;
        Wed, 26 Oct 2022 07:20:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11-20020a50ea8b000000b004619f024864sm3605565edo.81.2022.10.26.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:20:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/12] Makefile: have "coccicheck" re-run if flags change
Date:   Wed, 26 Oct 2022 16:20:31 +0200
Message-Id: <patch-v4-04.12-b859dae7509-20221026T141005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
References: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
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
index 62720c6135d..7cce39270d4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -7,6 +7,7 @@
 /GIT-PERL-HEADER
 /GIT-PYTHON-VARS
 /GIT-SCRIPT-DEFINES
+/GIT-SPATCH-DEFINES
 /GIT-USER-AGENT
 /GIT-VERSION-FILE
 /bin-wrappers/
diff --git a/Makefile b/Makefile
index b638a548182..7d4518653ce 100644
--- a/Makefile
+++ b/Makefile
@@ -1305,6 +1305,18 @@ SANITIZE_ADDRESS =
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
@@ -3152,6 +3164,7 @@ COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
 COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 
 COCCI_PATCHES = $(COCCI_RULES:%=%.patch)
+$(COCCI_PATCHES): GIT-SPATCH-DEFINES
 $(COCCI_PATCHES): $(COCCI_SOURCES)
 $(COCCI_PATCHES): %.patch: %
 	$(QUIET_SPATCH) \
@@ -3175,6 +3188,7 @@ $(COCCI_PATCHES): %.patch: %
 	fi
 
 COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
+$(COCCI_TEST_RES_GEN): GIT-SPATCH-DEFINES
 $(COCCI_TEST_RES_GEN): .build/%.res : %.c
 $(COCCI_TEST_RES_GEN): .build/%.res : %.res
 $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
@@ -3461,6 +3475,7 @@ profile-clean:
 	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
 
 cocciclean:
+	$(RM) GIT-SPATCH-DEFINES
 	$(RM) -r .build/contrib/coccinelle
 	$(RM) contrib/coccinelle/*.cocci.patch*
 
-- 
2.38.0.1251.g3eefdfb5e7a

