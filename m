Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4476EC43217
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiJNPcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiJNPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:31:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D601974C5
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j16so8136191wrh.5
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=na5KVCc787YYRRVbEjsF0Jc3yy2yFna5hjPBXuQ7J30=;
        b=nMiySAH8ZuoIBfeKRihWFkZ5MSAmJ5E+v3JHhqpfPegk+UPwV/vYn8gzExZ5jTMK6q
         miBvGy/WftlcPb/x9BNaKnztuDBee745Q0j1DChOru+mmZS/mbFHCB4rXXNGgyuAiQdX
         n2LeKWlx03QJy1qZWx3GU7W9Vr/bMiAbfS2AK5DZQV7XN0ZGl6phJDbSWa3C9jhbnt+3
         PVbyCnE5zpPOLXCwWhUYrqKSkJY0vdbu8v2ZvzbdOQNptG6tdB/NLX22PqOGCYppZdBB
         yH0eENeyzGa+8Wv0xp15/+71AAdKgvPvLSOqHI/Ml2xd9CliCAOH1GvkrhCOQRgiEDc+
         k8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=na5KVCc787YYRRVbEjsF0Jc3yy2yFna5hjPBXuQ7J30=;
        b=Gj+YUySn38IOWpeG6rlGsiPuNVDxCr2uflrEH+ZetyQdRNfV+R+N85gvDEHu9y06Zq
         m0mZA0OVdbZmDRVx+U7zupxkddG/sbwUxmna+cFrt63CgNqt/mfl3eoZ3umVH6JK9LVU
         NxLXe6Awo35njuvicYfcEOQZo2iHuvIOQaFZCI7tAYrkIGY4xetxyVdTQGqWjlw7aS7s
         Tuzycfc3Pl6bnDAjZaeiISYQNihMsoVS1PxW5ZxALsbSAOCamDbbDcBDNcstZ1MeH4J9
         rXEIY9h6KjXHZ1Pa+6IPYo38gBKuhkw2ZGwzotaaPilv+sD3hjjNvsLL/8NZ3K0R6BJH
         5uHw==
X-Gm-Message-State: ACrzQf0h0bDD5LgVBEtxNSMRoWBW10iwn7Lezbsnov6X6canZR92Cmia
        ENZYjE56zExu7maTMnA49o1ejbQQpXRfRQ==
X-Google-Smtp-Source: AMsMyM6/kf56qDHqCeHVIM9MXHE3ZelsvAHVqzlkmVnBk5D+WtP/cql71xV3y4jy2uUiDwgjeZGpaw==
X-Received: by 2002:adf:c747:0:b0:231:65ef:2fe5 with SMTP id b7-20020adfc747000000b0023165ef2fe5mr3750430wrh.594.1665761496133;
        Fri, 14 Oct 2022 08:31:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b003b47ff307e1sm2219053wmb.31.2022.10.14.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:31:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/11] Makefile: have "coccicheck" re-run if flags change
Date:   Fri, 14 Oct 2022 17:31:20 +0200
Message-Id: <patch-v3-04.11-f779a2d22aa-20221014T152552Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com> <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
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
index 4647f317ede..d62f2311107 100644
--- a/Makefile
+++ b/Makefile
@@ -1304,6 +1304,18 @@ SANITIZE_ADDRESS =
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
@@ -3148,6 +3160,7 @@ COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
 COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 
 COCCI_PATCHES = $(COCCI_RULES:%=%.patch)
+$(COCCI_PATCHES): GIT-SPATCH-DEFINES
 $(COCCI_PATCHES): $(COCCI_SOURCES)
 $(COCCI_PATCHES): %.patch: %
 	$(QUIET_SPATCH) \
@@ -3171,6 +3184,7 @@ $(COCCI_PATCHES): %.patch: %
 	fi
 
 COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
+$(COCCI_TEST_RES_GEN): GIT-SPATCH-DEFINES
 $(COCCI_TEST_RES_GEN): .build/%.res : %.c
 $(COCCI_TEST_RES_GEN): .build/%.res : %.res
 $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
@@ -3457,6 +3471,7 @@ profile-clean:
 	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
 
 cocciclean:
+	$(RM) GIT-SPATCH-DEFINES
 	$(RM) -r .build/contrib/coccinelle
 	$(RM) contrib/coccinelle/*.cocci.patch*
 
-- 
2.38.0.1092.g8c0298861b0

