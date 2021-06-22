Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3333C49EA4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 14:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA5CD61374
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 14:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhFVOXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhFVOXt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 10:23:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA34EC06175F
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 07:21:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a11so23890870wrt.13
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r2F0mwQWsf2MYZfsd8hVyE7T38UqUbUXq6hLAlWDdYE=;
        b=IWswlEbBHUweswefjQSGQ6Ek/2DV8dXBL0XJvl23EIsX7R8LK7XUHzUKJjRq/7ePSn
         YwGy/yHju5HAc42sgRAZdy5438Rf5LFKmrq2WsuwkNE6A1gPi5T0GVS8HM3Lhbg12H5O
         NZnM2vycGxZVWi+D5AAu2p1QcbaQcCnydRIycD6amue7gdkDtxSVCszd0hfsWg+A5QGt
         YMpa2/UyGhMmRIhcGoLCVk439F0RbEuWqymjwPyEe5WRt1akbCdv3DG34bk8E2Tr/5hC
         IOBwnvicOWQuq9FEru/bqBW4HtPaRo2/6eQPFZ6HgsXcXOpOI8dTpQ7TQRuELgg/tTY7
         D5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r2F0mwQWsf2MYZfsd8hVyE7T38UqUbUXq6hLAlWDdYE=;
        b=tZ+u30/Zm0O8IgiQBaB/xYHYRAp0sfagm+NoDGL6omPQ7dQ+SOrqOjY6I0RFoVAg+w
         USJHo8obgrcMtMWepsoOHkS77Viu74oKx6vGgMUIekbDN3/Hjznf/4GEU+rWaBOxbqVq
         AZ2vZSP1cG2ted3hUu+ZhVBmzdvHUOuASWNaT2jAkViuoz24S401Stl+b9uFQw94PVPf
         n+d/Nb48jke7id4TKuvZCKszRT4ovExotfT00pnWVCHssCW0zO+xC7QGS37bxUlqeSJs
         ZroxSpGo8qKtMGVPcSFVoCCNgzFIU15w8/8sgEIh24CA3xaIaKXVePyKTrCyO43rpC7v
         a74w==
X-Gm-Message-State: AOAM531uxs4XBsK29QlXJRJxKZl22Kz23uwthZ+DAOix3RW5w5fx/VhG
        ZGhbbtRJJS2KEhMoNoyW99kXmVNhl+LWCQ==
X-Google-Smtp-Source: ABdhPJw0ULuN8FDB+O4B4x+BR4MiaTDSfmHig7AOhDyKFq5TRUp8pQI5yQwkDHp5fNOKleAxPyb7JA==
X-Received: by 2002:adf:f34c:: with SMTP id e12mr5063967wrp.299.1624371691401;
        Tue, 22 Jun 2021 07:21:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm22617395wre.84.2021.06.22.07.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 07:21:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] Makefile: don't use "FORCE" for tags targets
Date:   Tue, 22 Jun 2021 16:21:27 +0200
Message-Id: <patch-3.3-67fc87665d6-20210622T141844Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "FORCE" dependency from the "tags", "TAGS" and "cscope.out"
targets, instead make them depend on whether or not the relevant
source files have changed.

I'm also removing the "-o" option from them, that seems to have been
cargo-culted when they were initially added in f81e7c626f3 (Makefile:
Add TAGS and tags targets, 2006-03-18). It would make sense to use
that option if we had been appending to tag files, it doesn't make any
sense that it was used after we'd just removed the files file being
appended to.

This will potentially cause a partial file to be left behind if the
command dies, but my in-flight series to use the ".DELETE_ON_ERROR"
flag in the Makefile[1] will make that problem go away. I think even
without that it's not problem we need to worry about in these cases.

1. https://lore.kernel.org/git/patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 25d2a3e5ddc..89d261230fb 100644
--- a/Makefile
+++ b/Makefile
@@ -2727,18 +2727,19 @@ FIND_SOURCE_FILES = ( \
 		| sed -e 's|^\./||' \
 	)
 
-$(ETAGS_TARGET): FORCE
-	$(QUIET_GEN)$(RM) "$(ETAGS_TARGET)+" && \
-	$(FIND_SOURCE_FILES) | xargs etags -a -o "$(ETAGS_TARGET)+" && \
-	mv "$(ETAGS_TARGET)+" "$(ETAGS_TARGET)"
+FOUND_SOURCE_FILES = $(shell $(FIND_SOURCE_FILES))
 
-tags: FORCE
-	$(QUIET_GEN)$(RM) tags+ && \
-	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
-	mv tags+ tags
+$(ETAGS_TARGET): $(FOUND_SOURCE_FILES)
+	$(QUIET_GEN)echo $(FOUND_SOURCE_FILES) | \
+	xargs etags -o $@
+
+tags: $(FOUND_SOURCE_FILES)
+	$(QUIET_GEN)echo $(FOUND_SOURCE_FILES) | \
+	xargs ctags -o $@
 
 cscope.out:
-	$(FIND_SOURCE_FILES) | xargs cscope -f$@ -b
+	$(QUIET_GEN)echo $(FOUND_SOURCE_FILES) | \
+	xargs cscope -f$@ -b
 
 .PHONY: cscope
 cscope: cscope.out
@@ -2922,7 +2923,7 @@ check: config-list.h command-list.h
 		exit 1; \
 	fi
 
-FOUND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
+FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
 COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
-- 
2.32.0.599.g3967b4fa4ac

