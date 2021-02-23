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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF566C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8667660202
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhBWLnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhBWLnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 06:43:08 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70E8C06178C
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:41:49 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n8so22202812wrm.10
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nsIaI8EnvQG7QcTzmpcg72SJ8k3WAOpxMRDPCmWTHog=;
        b=g84OIUAuyFRIAhA9tO6J6UTqKEmobZZCl7KwzqDEYjP6tdRTlCplBDF+Y1bjuZui7I
         dbrVoo72hfdz6anMJ2gB/FmmrfJPvg/CBnlqV2MekuIakTobhy3qw/bU9JEiW1Lu7+lg
         brLql83EyeN36HPg1C1eVOQUnwut0j/DC6xXpHSKLiZgvotXhrWyR0UvonA8ADLK6Ry5
         qeBgsDgWItqeYxCMRXwx/usAHx6UfadOQnloNHIgkqC/f2G5gFPGvZa0ngSfJ1YXP9HY
         MxDtsU5l/k1iTZOiwxx4RRdJjw5W6jMoLDE4U4llvBs14ftjx8CogmSld1MOON5DP3ID
         Bgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nsIaI8EnvQG7QcTzmpcg72SJ8k3WAOpxMRDPCmWTHog=;
        b=H1geQAMC4zdyGW/UqByC78ph9AMR/ROVJ2TLCOeOYdPOF6lfvpIlXvJ4w9GbLbWR+W
         TQBDGd3ynKrjeAA9272ZJnRn+nTDbd47x3MC9zJFksrL+WbitP0B3YbwF7RjL/Ffhqgi
         SbiSsdQ93UAewc02tOhnmd8yCksgfFHmmK+mEqZW0W7BuMBQvbAcs43oSofxNcFRD6sJ
         /MzcrWLkAl8Jb1PftrblGaIsocHC+awLj+Sd97Gzr9ttJ789YlB0mCdheaexd3DuNqkq
         kMlyrTRZL/Sm9njvGtq/3TPCHhcTgt1gVJTUUbgM81CdAur3b8UzuVv0qmlmQZur1yYn
         XlKQ==
X-Gm-Message-State: AOAM532PvPq/DJzDK3Uyfq8lCBFMaBLC0tBQVVziOIo1VQH2IjxSm8Np
        +1oEKituCOHpo9a7W1DrqhY/Ho3I+/Ivfg==
X-Google-Smtp-Source: ABdhPJyef6rAb/wZlUW4u4wh+zzdwuYBJ28rIY9bOJ1pcjAqn6+VtCWwRIjYvSRj00cAhUlM54F1qg==
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr25350975wrq.136.1614080508319;
        Tue, 23 Feb 2021 03:41:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n9sm2391336wmi.43.2021.02.23.03.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 03:41:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/6] Makefile: add {program,xdiff,test,git,fuzz}-objs & objects targets
Date:   Tue, 23 Feb 2021 12:41:31 +0100
Message-Id: <20210223114132.24345-6-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210201111715.10200-1-avarab@gmail.com>
References: <20210201111715.10200-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add targets to compile the various *.o files we declared in commonly
used *_OBJS variables. This is useful for debugging purposes, to
e.g. get to the point where we can compile a git.o. See [1] for a
use-case for this target.

https://lore.kernel.org/git/YBCGtd9if0qtuQxx@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Makefile b/Makefile
index 8b087f68b3f..10f7baa74b0 100644
--- a/Makefile
+++ b/Makefile
@@ -662,6 +662,8 @@ ETAGS_TARGET = TAGS
 FUZZ_OBJS += fuzz-commit-graph.o
 FUZZ_OBJS += fuzz-pack-headers.o
 FUZZ_OBJS += fuzz-pack-idx.o
+.PHONY: fuzz-objs
+fuzz-objs: $(FUZZ_OBJS)
 
 # Always build fuzz objects even if not testing, to prevent bit-rot.
 all:: $(FUZZ_OBJS)
@@ -679,6 +681,8 @@ PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += imap-send.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
+.PHONY: program-objs
+program-objs: $(PROGRAM_OBJS)
 
 # Binary suffix, set to .exe for Windows builds
 X =
@@ -2372,13 +2376,19 @@ XDIFF_OBJS += xdiff/xmerge.o
 XDIFF_OBJS += xdiff/xpatience.o
 XDIFF_OBJS += xdiff/xprepare.o
 XDIFF_OBJS += xdiff/xutils.o
+.PHONY: xdiff-objs
+xdiff-objs: $(XDIFF_OBJS)
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
+.PHONY: test-objs
+test-objs: $(TEST_OBJS)
 
 GIT_OBJS += $(LIB_OBJS)
 GIT_OBJS += $(BUILTIN_OBJS)
 GIT_OBJS += common-main.o
 GIT_OBJS += git.o
+.PHONY: git-objs
+git-objs: $(GIT_OBJS)
 
 OBJECTS += $(GIT_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
@@ -2388,6 +2398,8 @@ OBJECTS += $(FUZZ_OBJS)
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
 endif
+.PHONY: objects
+objects: $(OBJECTS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
 dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
-- 
2.30.0.284.gd98b1dd5eaa7

