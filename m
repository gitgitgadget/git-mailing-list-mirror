Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF7BC4332F
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 17:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353331AbhLXRh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353329AbhLXRh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 12:37:59 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C40C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:37:58 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so5141730wmd.5
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8v7ojJpjsBksC2yNlLFEqMmoEDWJWL9ZCOPmaKiP4nI=;
        b=kf2ZVGl6VI0gk5/xc1QtFx+Z/ly5QaQGoqV2M+ySBcS9dei2z7WTdpd7eJJcObzYfQ
         AWtZMG+4sD9xJSA/zMhzp78ZruLYIf7odHyGpt0kYjPi1H/DcYBlhMfnY7DqRcoyi5gD
         Ru2PMM4K5cWEaR2u7Bc2THtYwMT/Z63y3nMUYOjPpylSQmBuwIE92y69EvpMhiLYV0Z2
         r0tQdchRa9nQC/O4S9i0J/c7kTRGLIf7ug9JPPtzHzxnk3CQSx1aC4xcvapDiq4oueyO
         37qqi0uApfL+UtORt8C5wsAbAU8wfC50ouS3bi70qnUV0tAtULm6EW6DCRp9HOWo4yk0
         E9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8v7ojJpjsBksC2yNlLFEqMmoEDWJWL9ZCOPmaKiP4nI=;
        b=BQpJU8Y2Oth4gItHwRj2AIONiYfSPpccAH3g+waRAe6RHxESugte16TgIqMdXmpnGg
         ZUxsr61biR0gKEqGyxhFjCvAiigEktnkrxLe4EpyFHkLfrudGGJgsUQymKpnisNA+XUY
         5e0qTmsgCfXNl80QlJTUeGFna+4mWGyv8au2hOHusILWZOP+GEEkndmDOSqLfDKBqA/x
         Ck8mNmeVOgRqf5KGVPa1RjIhJEkMtq5VO7LXmuvK0EqGqaompNeGX+IuwKAtOTWSx8MK
         uMJVo2pXg2lqaXXxNpT88X8xPYmp6GqRy06oCLgOZSu/dJiKEWYbyNx4nPFqKs7WpWWl
         QggQ==
X-Gm-Message-State: AOAM530lmERFaBpBRWNmdKCZTw9xm+rFy9kDUH2hlKieGmOZZmi7I/0m
        u0I+qqL5wrTpHngm4/wy2R7QZD4ZS2FWV+vd
X-Google-Smtp-Source: ABdhPJwGTT+jqnWNOLOB92wJnwmHXF7RQnmcaBCiaux4SEWak+7q+YS9IfPWZxJkY8UyigpFH4iUtw==
X-Received: by 2002:a1c:2606:: with SMTP id m6mr5783468wmm.52.1640367477012;
        Fri, 24 Dec 2021 09:37:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j3sm8033518wro.22.2021.12.24.09.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:37:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/8] Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
Date:   Fri, 24 Dec 2021 18:37:42 +0100
Message-Id: <patch-v2-3.8-ed6fd1c0bd1-20211224T173558Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1215.g6e154b84c77
In-Reply-To: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Combine the definitions of $(FIND_SOURCE_FILES) and $(LIB_H) to speed
up the Makefile, as these are the two main expensive $(shell) commands
that we execute unconditionally.

When see what was in $(FOUND_SOURCE_FILES) that wasn't in $(LIB_H) via
the ad-hoc test of:

    $(error $(filter-out $(LIB_H),$(filter %.h,$(ALL_SOURCE_FILES))))
    $(error $(filter-out $(ALL_SOURCE_FILES),$(filter %.h,$(LIB_H))))

We'll get, respectively:

    Makefile:850: *** t/helper/test-tool.h.  Stop.
    Makefile:850: *** .  Stop.

I.e. we only had a discrepancy when it came to
t/helper/test-tool.h. In terms of correctness this was broken before,
but now works:

    $ make t/helper/test-tool.hco
        HDR t/helper/test-tool.h

This speeds things up a lot:

    $ git -c hyperfine.hook.setup= hyperfine -L rev HEAD~1,HEAD~0 -s 'make NO_TCLTK=Y' 'make -j1 NO_TCLTK=Y' --warmup 10 -M 10
    Benchmark 1: make -j1 NO_TCLTK=Y' in 'HEAD~1
      Time (mean ± σ):     159.9 ms ±   6.8 ms    [User: 137.2 ms, System: 28.0 ms]
      Range (min … max):   154.6 ms … 175.9 ms    10 runs

    Benchmark 2: make -j1 NO_TCLTK=Y' in 'HEAD~0
      Time (mean ± σ):     100.0 ms ±   1.3 ms    [User: 84.2 ms, System: 20.2 ms]
      Range (min … max):    98.8 ms … 102.8 ms    10 runs

    Summary
      'make -j1 NO_TCLTK=Y' in 'HEAD~0' ran
        1.60 ± 0.07 times faster than 'make -j1 NO_TCLTK=Y' in 'HEAD~1'

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 54 ++++++++++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/Makefile b/Makefile
index 7dddea3caf3..d3ce0d22199 100644
--- a/Makefile
+++ b/Makefile
@@ -826,12 +826,33 @@ GENERATED_H += hook-list.h
 .PHONY: generated-hdrs
 generated-hdrs: $(GENERATED_H)
 
-LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
+## Exhaustive lists of our source files, either dynamically generated,
+## or hardcoded.
+SOURCES_CMD = ( \
+	git ls-files \
+		'*.[hcS]' \
+		'*.sh' \
+		':!*[tp][0-9][0-9][0-9][0-9]*' \
+		':!contrib' \
+		2>/dev/null || \
 	$(FIND) . \
-	-name .git -prune -o \
-	-name t -prune -o \
-	-name Documentation -prune -o \
-	-name '*.h' -print)))
+		\( -name .git -type d -prune \) \
+		-o \( -name '[tp][0-9][0-9][0-9][0-9]*' -prune \) \
+		-o \( -name contrib -type d -prune \) \
+		-o \( -name build -type d -prune \) \
+		-o \( -name 'trash*' -type d -prune \) \
+		-o \( -name '*.[hcS]' -type f -print \) \
+		-o \( -name '*.sh' -type f -print \) \
+		| sed -e 's|^\./||' \
+	)
+FOUND_SOURCE_FILES := $(shell $(SOURCES_CMD))
+
+FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
+FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))
+
+COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
+
+LIB_H = $(FOUND_H_SOURCES)
 
 LIB_OBJS += abspath.o
 LIB_OBJS += add-interactive.o
@@ -2758,26 +2779,6 @@ perl/build/man/man3/Git.3pm: perl/Git.pm
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
 	pod2man $< $@
 
-FIND_SOURCE_FILES = ( \
-	git ls-files \
-		'*.[hcS]' \
-		'*.sh' \
-		':!*[tp][0-9][0-9][0-9][0-9]*' \
-		':!contrib' \
-		2>/dev/null || \
-	$(FIND) . \
-		\( -name .git -type d -prune \) \
-		-o \( -name '[tp][0-9][0-9][0-9][0-9]*' -prune \) \
-		-o \( -name contrib -type d -prune \) \
-		-o \( -name build -type d -prune \) \
-		-o \( -name 'trash*' -type d -prune \) \
-		-o \( -name '*.[hcS]' -type f -print \) \
-		-o \( -name '*.sh' -type f -print \) \
-		| sed -e 's|^\./||' \
-	)
-
-FOUND_SOURCE_FILES = $(shell $(FIND_SOURCE_FILES))
-
 $(ETAGS_TARGET): $(FOUND_SOURCE_FILES)
 	$(QUIET_GEN)$(RM) $@+ && \
 	echo $(FOUND_SOURCE_FILES) | xargs etags -a -o $@+ && \
@@ -2987,9 +2988,6 @@ check: $(GENERATED_H)
 		exit 1; \
 	fi
 
-FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
-COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
-
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	$(QUIET_SPATCH) \
 	if test $(SPATCH_BATCH_SIZE) = 0; then \
-- 
2.34.1.1215.g6e154b84c77

