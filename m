Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16270C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A1961DD2
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhF2LPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 07:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhF2LPw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 07:15:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EB4C061767
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 04:13:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i94so25366857wri.4
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 04:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkFecYtmMrIqHZBK4+m3WzH/C4uDf52UQVpYP73Upvc=;
        b=Cb/GNyR8Ab5xQNJRl3VPdRp9NV/Li/fduTJfzDPlYMXYp/mOhmSJRMtS7AWm4YfFd+
         +wbWlIhM2gDn2ggZWFmPy+8qXLmC97bvE9olmMG68iBZ0WwjcS3syeRVIRN9tQtVXruP
         Qq7DYEiQ7reKRa/U4UxA2c+WHtj3jfvFZnBUrOei8s1gJMGv/Sn5oVfacR8fG/pZqSwe
         A5BNO+/G5YqeTxxnZjj5+UFlFpzYK7W3M8mlFYYk4hpqLv1DG0krH3C56X6tc4i+OXsm
         XDHai/wNmSOHNB2CyoPiaHvsHWJp+uLVft0zh3WmQhANNSPQwG+k3x5ilD4/CeYFEz9Y
         ceBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkFecYtmMrIqHZBK4+m3WzH/C4uDf52UQVpYP73Upvc=;
        b=Ds/yyjLcnNfyEquEcEh4or1rIKVn/xgCD+Err4mpA7g3LvJIsIEuyYUq57NYNqjLLq
         kCoyLZ5FbNghFsSPI/TaWUlqA/vHkcJofP7ccfiHSHs0B7ygoWeomJP2IicylKJpOcx9
         HBR8nvs8r6B/BMxyJlpfcVyqLNZhCz2W42+Z4qoWXSE1lIMm58CDzFivi3QmKx0QBZcW
         m71HHB9VJp4wtlmuKHQa7NSpGZn3b3JizK5kKqUKwzCl5DLawaAKqfujk6xejEeaFsB1
         3/AiMpVWnoTM4a5dWnylLYaZKeMS/7kQ920Zt3NaFV5TC8y4HXg+5AHWCedK22h129TK
         puMA==
X-Gm-Message-State: AOAM532kc5SOAf+lNPpqBZGylTy+U2fRIPMh9wUs2UotDw3JVHjvsiNM
        KvBWDiGhpdHgev36n1HMPuGmKpRGRyvcMw==
X-Google-Smtp-Source: ABdhPJzmrfrTce56mWFs8rm5miXd2SVKfg/fq/oH2SGuQT5QqvlZ9LT4knqKQJSYcm/3Dzi73lg/Ug==
X-Received: by 2002:adf:f48c:: with SMTP id l12mr33140689wro.194.1624965203062;
        Tue, 29 Jun 2021 04:13:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1sm2499370wmn.10.2021.06.29.04.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 04:13:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] Makefile: don't use "FORCE" for tags targets
Date:   Tue, 29 Jun 2021 13:12:58 +0200
Message-Id: <patch-4.5-b924cc3f56-20210629T110837Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.613.g20d5ce26552
In-Reply-To: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com> <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "FORCE" dependency from the "tags", "TAGS" and "cscope.out"
targets, instead make them depend on whether or not the relevant
source files have changed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 2e3b257164..7b0d9773b0 100644
--- a/Makefile
+++ b/Makefile
@@ -2727,19 +2727,21 @@ FIND_SOURCE_FILES = ( \
 		| sed -e 's|^\./||' \
 	)
 
-$(ETAGS_TARGET): FORCE
+FOUND_SOURCE_FILES = $(shell $(FIND_SOURCE_FILES))
+
+$(ETAGS_TARGET): $(FOUND_SOURCE_FILES)
 	$(QUIET_GEN)$(RM) "$(ETAGS_TARGET)+" && \
 	$(FIND_SOURCE_FILES) | xargs etags -a -o "$(ETAGS_TARGET)+" && \
 	mv "$(ETAGS_TARGET)+" "$(ETAGS_TARGET)"
 
-tags: FORCE
+tags: $(FOUND_SOURCE_FILES)
 	$(QUIET_GEN)$(RM) tags+ && \
 	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
 	mv tags+ tags
 
-cscope.out:
+cscope.out: $(FOUND_SOURCE_FILES)
 	$(QUIET_GEN)$(RM) cscope.out && \
-	$(FIND_SOURCE_FILES) | xargs cscope -f$@ -b
+	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b
 
 .PHONY: cscope
 cscope: cscope.out
@@ -2923,7 +2925,7 @@ check: config-list.h command-list.h
 		exit 1; \
 	fi
 
-FOUND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
+FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
 COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
-- 
2.32.0.613.g20d5ce26552

