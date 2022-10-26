Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F304C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiJZOVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiJZOVE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:21:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FE11119DF
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y12so21467408edc.9
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gUHxyv5jodYFATism078SF5Z23nRAbbN8xGXGgTR6E=;
        b=Ie2D3FNyiWtpNAL/KhvcvWMiZls43QUp4lSSZ8JTUwFggTLLNTWZz2V6d0N21ErHER
         spYD5qTfZyPEbac6fFPGp1h63uLootY3t5nwhZkd+tZt+Pep1CZyfBupbR5OxF+dGwNw
         iGuqUSD2QfL2erU5j8giSI2pvg4tH5SLp2VV79DBznGP6iic3AYw5NfMSNd7OYBOEZT9
         u5H6rwuGUf1EiJhNy1fOJKIqDZYDP6ZTCCVAFh+b56QH7Lln/sAAAqOi3O9A7yRYFWns
         yPsdshXGWe63XF7U6rQYIOYkVj24U/tsQKf16dlpO8cHotQH7VeBnQOo1rW+N9z4j95z
         HFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gUHxyv5jodYFATism078SF5Z23nRAbbN8xGXGgTR6E=;
        b=Gv23J7GX9ZY92s3mvfOiztjRjh2/RaWTzwmYdBuugonCheTmjZoBVpZODwQfKQglZw
         2fUckWXIEeaantcrJhWdCqguGPc0mCC+ab0HL4qe1Nz6xS6MnnO/VQE8t0+uCz20X+kn
         ZpfS043nNfVINyXkQvPKY5oeMBYLtjgtFRW1ukZVtryKOYUELfC0W8Al6GbFd2oYusZR
         OfZO1E7C3gxItnSWa1ptjirgp3KKqee3rLnmLZ3IdWEbFOMUKvedYLDFqqQU91A9a06b
         ZqlrGXFHi9gOe/YoLHwyYF/D2SnnsQzvkbUCFHfaloPCTBaI0nLbAjOwutdHRj8Bp8pe
         RJpA==
X-Gm-Message-State: ACrzQf2e9aBbYmrC83TddtMn30eyZoxznQ/P45NRJAGM0jrqHX+n9DMk
        A4pu4yMaX71ceVNHXCdocCFQ5Oy++eQ=
X-Google-Smtp-Source: AMsMyM4PwGq/kyzdV+3gBJeKSO2gWg3qYEFKMuBWRTkWx+UPiS5ojyVkgzS2f/aJ2hexyIupiNarRA==
X-Received: by 2002:aa7:c58e:0:b0:461:77b:7bd with SMTP id g14-20020aa7c58e000000b00461077b07bdmr30532862edq.387.1666794061201;
        Wed, 26 Oct 2022 07:21:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11-20020a50ea8b000000b004619f024864sm3605565edo.81.2022.10.26.07.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:21:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 06/12] cocci: split off include-less "tests" from SPATCH_FLAGS
Date:   Wed, 26 Oct 2022 16:20:33 +0200
Message-Id: <patch-v4-06.12-1c30f4b543b-20221026T141005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
References: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
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
index 585d259c841..9d04b18a5b5 100644
--- a/Makefile
+++ b/Makefile
@@ -1301,6 +1301,7 @@ SANITIZE_ADDRESS =
 
 # For the 'coccicheck' target
 SPATCH_FLAGS = --all-includes
+SPATCH_TEST_FLAGS =
 # Setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
@@ -1310,6 +1311,7 @@ SPATCH_BATCH_SIZE = 1
 TRACK_SPATCH_DEFINES =
 TRACK_SPATCH_DEFINES += $(SPATCH)
 TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
+TRACK_SPATCH_DEFINES += $(SPATCH_TEST_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_BATCH_SIZE)
 GIT-SPATCH-DEFINES: FORCE
 	@FLAGS='$(TRACK_SPATCH_DEFINES)'; \
@@ -3194,7 +3196,7 @@ $(COCCI_TEST_RES_GEN): .build/%.res : %.c
 $(COCCI_TEST_RES_GEN): .build/%.res : %.res
 $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
 	$(call mkdir_p_parent_template)
-	$(QUIET_SPATCH_TEST)$(SPATCH) $(SPATCH_FLAGS) \
+	$(QUIET_SPATCH_TEST)$(SPATCH) $(SPATCH_TEST_FLAGS) \
 		--very-quiet --no-show-diff \
 		--sp-file $< -o $@ \
 		$(@:.build/%.res=%.c) && \
-- 
2.38.0.1251.g3eefdfb5e7a

