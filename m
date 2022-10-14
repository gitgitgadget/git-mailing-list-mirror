Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25E5C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiJNPcd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiJNPbr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:31:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768AA6585
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bk15so8089082wrb.13
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hicRwkmhJQ9CHXVMhfSDNiha+q3HTlz5GM0evgAbHY8=;
        b=XcFiLnZwwNfEGvgjSbzMlUJe5bXkQqpNsJjTMCsW1q0TgPSIclZuNmzB9VdHA8zMvK
         5i6qD3Em4NDML8xn4bjD+0nnoDwfeIpG2mjYB+TYD5x7TTbMS4pvywoeJsKwwpjhwkxx
         itRHbwKUE7+x29WJQKcKM7AOJ5+Gb0dza2cyMjREraG7QEm0oRHvY8i5EuO9iBt/J5mk
         TAzxIXfFhXH1K0jM/VsLt7Iry9yxPGx6BkEZOJ6Eno7ULzp53a1ubVE9jI7q2/HZ3y3H
         6DlhwUcDxk3A2E7P5NSY1+RNQqIJcsaCqtRDOXP47liM0rJVkzodwayPpy0qjorCJ5LO
         Zcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hicRwkmhJQ9CHXVMhfSDNiha+q3HTlz5GM0evgAbHY8=;
        b=XG8YsGD9e85+sm74WMk1n6Axxu/IVV00gq7Fed4BnrVaf4ZZG4SzLjaQvUgiEswbL8
         eP3BcePCpE9TXRAGbOorkWi0IwMM/fU7RIz7GPmkFMlpQ04gQsHKU+qw/8U0QBK3uMQj
         6cVp5x88tvoifu8cF9Q9ob4giJSvIBZHJpKl5VX4K1xeNpXVrMVqDfLKPLPBzeyH2NS7
         W392pLuKAwM7+kB9oN8g4hLAFTUPNyocm2NV+rBo/doTYQXqP92+L0KwYJRPAS/ZINio
         jQ2GWZ4NHhQowvU+gv6zNOJdQbRUMggCrfTRoAPo4cOlAIY/x8FQwGABHz3X1oUmD+Cz
         Ye2w==
X-Gm-Message-State: ACrzQf2U8gLL5ARv2Vq3dHQlscCl/NzVNDG2jDGzLF2v/WzC0W5NKpjp
        2uzlk8iS7aWcuCtjG0HNoEYUMuvrgda6kg==
X-Google-Smtp-Source: AMsMyM6cMXv0f0LIsY5rTCNSmhdRITHVCX4GkHlPLZbAG+ZjKkyvt+Ys7c638JOWz22IiO9HQY+cSA==
X-Received: by 2002:a05:6000:1051:b0:22e:5d8a:d3d5 with SMTP id c17-20020a056000105100b0022e5d8ad3d5mr3806445wrx.476.1665761498633;
        Fri, 14 Oct 2022 08:31:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b003b47ff307e1sm2219053wmb.31.2022.10.14.08.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:31:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/11] cocci: split off include-less "tests" from SPATCH_FLAGS
Date:   Fri, 14 Oct 2022 17:31:22 +0200
Message-Id: <patch-v3-06.11-691be73b6fb-20221014T152553Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com> <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the "coccicheck-test" rule added in f7ff6597a75 (cocci: add a
"coccicheck-test" target and test *.cocci rules, 2022-07-05) to stop
using "--all-includes". The flags we'll need for the tests are
different than the ones we'll need for our main source code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2a106f633b9..535dece5d48 100644
--- a/Makefile
+++ b/Makefile
@@ -1300,6 +1300,7 @@ SANITIZE_ADDRESS =
 
 # For the 'coccicheck' target
 SPATCH_FLAGS = --all-includes
+SPATCH_TEST_FLAGS =
 # Setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
@@ -1309,6 +1310,7 @@ SPATCH_BATCH_SIZE = 1
 TRACK_SPATCH_DEFINES =
 TRACK_SPATCH_DEFINES += $(SPATCH)
 TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
+TRACK_SPATCH_DEFINES += $(SPATCH_TEST_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_BATCH_SIZE)
 GIT-SPATCH-DEFINES: FORCE
 	@FLAGS='$(TRACK_SPATCH_DEFINES)'; \
@@ -3190,7 +3192,7 @@ $(COCCI_TEST_RES_GEN): .build/%.res : %.c
 $(COCCI_TEST_RES_GEN): .build/%.res : %.res
 $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
 	$(call mkdir_p_parent_template)
-	$(QUIET_SPATCH_TEST)$(SPATCH) $(SPATCH_FLAGS) \
+	$(QUIET_SPATCH_TEST)$(SPATCH) $(SPATCH_TEST_FLAGS) \
 		--very-quiet --no-show-diff \
 		--sp-file $< -o $@ \
 		$(@:.build/%.res=%.c) && \
-- 
2.38.0.1092.g8c0298861b0

