Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D0BC64991
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 14:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbiHYOgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 10:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbiHYOgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 10:36:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF92AA4F4
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 07:36:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a4so24928984wrq.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1yC5Wv1NsWdozjXB4QyYZ+Pc30xfRmVSE0XFWPKkjIo=;
        b=Rlz+XABr110kkjESOBZ4JhehCIa5MYpHo9gNE6h9yDCof1GiGRmL1YE412owaFrzCH
         ye5cMsKOmO74fCRra05eXdwBKFMxRmO3k45NGjTbpG4mTmTLfbmLP43KMM7zW4BSZdjD
         +FMBfnyK1JrqDggBbxxZTKWiP2drMDgaop9jBoFlC4DiS2k6grpsh1J4yZoQJm+RjimA
         prPIYC1K87ZEI8a7k5WaiELaPjhqsPvFVlDFSehgfv1eIEDPrYOlchjiF6v2W/c9mS0c
         wUkUmJuk8/hp5FLGrlsOzvk4A+a3YD2syqvJEB15Ht8ZkuwoNGTxKvDbfQOf9QTe8uKj
         p2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1yC5Wv1NsWdozjXB4QyYZ+Pc30xfRmVSE0XFWPKkjIo=;
        b=mJeh2t1i3ILC74QqJTdWzBBjquMatwVThtgpgtSU5VYAFBer8xow3GU8Pw/BbOphSk
         7rZhryTbdA/maafTz62nPQACeYYZ0gQ0y1CJ+rq88aeLW69HQSxtEPxJohz2GFcbtr+U
         nHsW43D6mSrA7jw9U0u7oirkAuBiESEZ/6BN9tYNblijPIz2nMKJnev+9CPUSWdtBAJ8
         Fw5g17nughqPVJ/WKjy1j1KiCS09+7JRagnMRHAsu6jKKRgHPfahZayvL1K+KXj9gozM
         e4eWUm3n5e6a171kvnGJVNjSZmKorkzgzGNU6oCjWHeeif0YpEXZ8/TE9geleG/2Mfql
         LoQw==
X-Gm-Message-State: ACgBeo2JKYJMidoDp7p/PC0OY0fQo7hJRXvWuOllYs/0WbqGBxWjMNwV
        Va73PP7hvhFDGNQzzI0vVBTNacyx5GA=
X-Google-Smtp-Source: AA6agR5O8NiGSWclGQbn1SYet6cdROuayt569bEjCQ3gTE69SbT6+VDFeu7rYDaGTHI/snVJfoR8FA==
X-Received: by 2002:a05:6000:1c0c:b0:225:569c:dd2c with SMTP id ba12-20020a0560001c0c00b00225569cdd2cmr2445826wrb.628.1661438182266;
        Thu, 25 Aug 2022 07:36:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m27-20020a056000181b00b0022549ac786asm14418027wrh.47.2022.08.25.07.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 07:36:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] Makefile: add ability to TAB-complete cocci *.patch rules
Date:   Thu, 25 Aug 2022 16:36:13 +0200
Message-Id: <patch-1.5-8604ac9bfbc-20220825T141212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Declare the contrib/coccinelle/<rule>.cocci.patch rules in such a way
as to allow TAB-completion, and slightly optimize the Makefile by
cutting down on the number of $(wildcard) in favor of defining
"coccicheck" and "coccicheck-pending" in terms of the same
incrementally filtered list.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index e8adeb09f1c..bd8faac61ee 100644
--- a/Makefile
+++ b/Makefile
@@ -3135,9 +3135,15 @@ check: $(GENERATED_H)
 		exit 1; \
 	fi
 
+COCCI = $(wildcard contrib/coccinelle/*.cocci)
+COCCI_PATCHES = $(addsuffix .patch,$(COCCI))
+COCCICHECK_PENDING = $(filter %.pending.cocci.patch,$(COCCI_PATCHES))
+COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_PATCHES))
+
 COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 
-%.cocci.patch: %.cocci $(COCCI_SOURCES)
+$(COCCI_PATCHES): $(COCCI_SOURCES)
+$(COCCI_PATCHES): %.patch: %
 	$(QUIET_SPATCH) \
 	if test $(SPATCH_BATCH_SIZE) = 0; then \
 		limit=; \
@@ -3174,11 +3180,11 @@ $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinell
 coccicheck-test: $(COCCI_TEST_RES_GEN)
 
 coccicheck: coccicheck-test
-coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/coccinelle/*.cocci)))
+coccicheck: $(COCCICHECK)
 
 # See contrib/coccinelle/README
 coccicheck-pending: coccicheck-test
-coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pending.cocci))
+coccicheck-pending: $(COCCICHECK_PENDING)
 
 .PHONY: coccicheck coccicheck-pending
 
@@ -3446,7 +3452,7 @@ profile-clean:
 
 cocciclean:
 	$(RM) -r .build/contrib/coccinelle
-	$(RM) contrib/coccinelle/*.cocci.patch*
+	$(RM) $(COCCI_PATCHES)*
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build
-- 
2.37.2.1279.g64dec4e13cf

