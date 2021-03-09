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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951F3C43333
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED0D6527B
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhCIQCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhCIQCk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 11:02:40 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FDFC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 08:02:40 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l12so16655743wry.2
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 08:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9wwBgK547eCjYqL3AD7xHjSQx8tWG6Kyl7u9okMmN4g=;
        b=GopaismM0RG3D0UjUJhMLl0IYrnpo+N5q0NOfzP4rkCv+1+ifngRKuL/VYndqSR3rq
         ce4iux5kbAep5oyOAYQMSFaMRiTKJfCxFL9kSNJWJdZ846hmnfFI06IAUnfeico0Z7dd
         QHUuEFbMYzDHIM1pHZkKV/dPqLwWhAkrkBrrQyyK1B7Mt5RMxzvDOu7Lk/1+zYRmKDUo
         ZvXwa9MXRkITDeFUc/WvBaQN6bGioySPClEXuJ26OXt4bq8QU9yrL2XI/Bve/t0Q3Kwl
         SBveNnOvH4HOB6Vps6VJKJE6ZavMYhQ8w0M0myLp8JmNw85qP+rjFkfxvWQbs3wjN9qJ
         J2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9wwBgK547eCjYqL3AD7xHjSQx8tWG6Kyl7u9okMmN4g=;
        b=pElbAHzfov0WzKRRgI97p1kXuB1RQjqPiil4iaJOO2Hk0IbdhmDZOuaSJa6cRYyW4p
         KWNu7Rixj6wKLesBYne1SOrtkB5fPeUl4gYI0BQ1nzY8s7RI3Hquk3givSgM+OLZcBhu
         jvcSi/ufILR79OY+TzP981Fkj11qpAkOQSajNAkBifZDXF6ElySScG3qdcuG9mcRYII3
         VFyenUHjwOCpxj7TAReCChG7TwWdzv7ubK4Upijzwx/ds8A+DD6MMvY1StSV4vZcZk2B
         IH7dYJxkD8zpJNIKVB+KiofLHGILTNfyPUc1NqWg39CNgO26JnQ96mpC4VY1RcnVMSXZ
         RYag==
X-Gm-Message-State: AOAM532+Aqfdkz7ZODNTWTq/PgsTGi925YdFuKd26o5On+RI5DcAtKsT
        jw9oQCEosuQSbA8li5zKXgpMUQCvvXa56A==
X-Google-Smtp-Source: ABdhPJxChRNZYw9xKOrIFqnWeC5wyUP87m53m48PBt2kzBPBzfM/pHwXclp33PLBxZLsXRilDdQO1g==
X-Received: by 2002:a5d:5492:: with SMTP id h18mr18121122wrv.340.1615305755695;
        Tue, 09 Mar 2021 08:02:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n6sm5089223wmd.27.2021.03.09.08.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 08:02:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/7] test-lib: indent and format GIT_TEST_TEE_OUTPUT_FILE code
Date:   Tue,  9 Mar 2021 17:02:17 +0100
Message-Id: <20210309160219.13779-6-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <87r1kzj7xi.fsf@evledraar.gmail.com>
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the indentation and formatting of the GIT_TEST_TEE_OUTPUT_FILE
code block added in 44138559e8 (test-lib.sh: optionally output to
test-results/$TEST.out, too, 2009-02-04).

This brings it in line with the general style in our test library, and
makes it easier to read modifications of it in subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8562b11b817..aa7068b06b6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -361,8 +361,10 @@ then
 	# from any previous runs.
 	>"$GIT_TEST_TEE_OUTPUT_FILE"
 
-	(GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1;
-	 echo $? >"$TEST_RESULTS_BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
+	(
+		GIT_TEST_TEE_STARTED=done ${TEST_SHELL_PATH} "$0" "$@" 2>&1
+		echo $? >"$TEST_RESULTS_BASE.exit"
+	) | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
 	test "$(cat "$TEST_RESULTS_BASE.exit")" = 0
 	exit
 fi
-- 
2.31.0.rc1.210.g0f8085a843c

