Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12D6C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbiJZOVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiJZOU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:20:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BA943301
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:20:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id t25so16159615ejb.8
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vOHKiAGJsQWxkU3/tPJB3lIbnQfQ7gWezXRvf8tQws=;
        b=g2aoKL8nSLQpE2TSaJmFkQ9Ify2UnLXHbzPRRnrYP6J1LQztRAjTLaRR42i6+L+5yi
         GxrXYZMCWTKHTTrqr66GTGfkEFWy5mMu0llDOqWFzAILghzqcDegJS24pGmnOkO9vy/7
         lypWD2OjtX365123JQlpSt9nJIBXtSlCz9+yXmE0uFl+hRSb8DyiLC+sLMTEy6PQqUZW
         nndscNgB6V8vCLvBnxVcTUbI+13/CTxon05utLbtbqICj00mzwMJFzJ0CxUNXbCfudvK
         43ekhN45YpPKT2YHvzZriya9GgPVAnDzhJDEFKg8Dn0zIEQpdVtD+JUS14JnOrG7Nl2H
         ewIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vOHKiAGJsQWxkU3/tPJB3lIbnQfQ7gWezXRvf8tQws=;
        b=KZ05sN9l0Kprk+QYdrYCs/SUPN17h2m7UK6anYIz0dhWd1yo69Aa2gcGha7W1ADHH8
         jxt2uDGS22982Y9ywtsjKrmYBwWWhBizbEBq476G6+oXqhLAsWkfE1DkmDw6cnfKChb5
         /4r57C+BRS9k6xR4HPIMTLxqlNIpfuU8LPbOHjdKiY+YYtRT+xzWeODqCRz9MJS5Z6EU
         uANkQAYW8xgMhOuMsog5W8c5pfmQr7KqYtdltwTf/zZKQJW1uOL6Uqh7WtlVqVmWMDRL
         pxdclQPpKYL1o+/7Sznc6iaxTmy1KHHFEKtJ2x2+0VQldzDIM/Jfs1/nTHm9SltG73p+
         JLAQ==
X-Gm-Message-State: ACrzQf3HDc9fs27kLA0pjgwMVTB94rJiQxGx0OcydShc6rZmnjFOy0ej
        e1zntXHmbM7rvq7dfqvfIooCVBSpqQk=
X-Google-Smtp-Source: AMsMyM6Tiq7Wwpx+rTgRVhgHHYbEQXQW6dNRe/Y/Cs88wCQ/molrIjOahWdzt7n2/UmrmKqgLEy75Q==
X-Received: by 2002:a17:907:75d2:b0:7a0:72b8:236a with SMTP id jl18-20020a17090775d200b007a072b8236amr20899166ejc.47.1666794054645;
        Wed, 26 Oct 2022 07:20:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11-20020a50ea8b000000b004619f024864sm3605565edo.81.2022.10.26.07.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:20:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/12] Makefile + shared.mak: rename and indent $(QUIET_SPATCH_T)
Date:   Wed, 26 Oct 2022 16:20:28 +0200
Message-Id: <patch-v4-01.12-c0306e3c397-20221026T141005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
References: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In f7ff6597a75 (cocci: add a "coccicheck-test" target and test *.cocci
rules, 2022-07-05) we abbreviated "_TEST" to "_T" to have it align
with the rest of the "="'s above it.

Subsequent commits will add more QUIET_SPATCH_* variables, so let's
stop abbreviating this, and indent it in preparation for adding more
of these variables.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile   | 2 +-
 shared.mak | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 85f03c6aed1..0ca1781510e 100644
--- a/Makefile
+++ b/Makefile
@@ -3168,7 +3168,7 @@ $(COCCI_TEST_RES_GEN): .build/%.res : %.c
 $(COCCI_TEST_RES_GEN): .build/%.res : %.res
 $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
 	$(call mkdir_p_parent_template)
-	$(QUIET_SPATCH_T)$(SPATCH) $(SPATCH_FLAGS) \
+	$(QUIET_SPATCH_TEST)$(SPATCH) $(SPATCH_FLAGS) \
 		--very-quiet --no-show-diff \
 		--sp-file $< -o $@ \
 		$(@:.build/%.res=%.c) && \
diff --git a/shared.mak b/shared.mak
index 33f43edbf9a..96b06acc455 100644
--- a/shared.mak
+++ b/shared.mak
@@ -69,8 +69,10 @@ ifndef V
 	QUIET_SP       = @echo '   ' SP $<;
 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
 	QUIET_RC       = @echo '   ' RC $@;
-	QUIET_SPATCH   = @echo '   ' SPATCH $<;
-	QUIET_SPATCH_T = @echo '   ' SPATCH TEST $(@:.build/%=%);
+
+## Used in "Makefile": SPATCH
+	QUIET_SPATCH			= @echo '   ' SPATCH $<;
+	QUIET_SPATCH_TEST		= @echo '   ' SPATCH TEST $(@:.build/%=%);
 
 ## Used in "Documentation/Makefile"
 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
-- 
2.38.0.1251.g3eefdfb5e7a

