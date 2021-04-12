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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB7EC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C1F61222
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244249AbhDLRQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244011AbhDLRQD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:03 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA5BC06138D
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e7so4771279wrs.11
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=98ippXJIzWiecn72dQL/jdkeNegtNbH2YlFsFIjeIB8=;
        b=fWrN9FVcvECiE4WuW/C8Q+3T6RHelwCmmCuZ+59G/grFBmmXgNBpBCLrTAUL3anNgc
         JJSIU3NGdYxY7rHIJWdR5fC0ymCmlu92jGXwklXjDNxKLq2pPh+7Mqn023aCvDryJRHe
         dWXw4imGeU+1NO03V+GViewOxH3mzddGe+5b3NO65xc24WjgM+C65oqBwt/51yAe5ZJ1
         HBFEuyf2YMURwMpqOoQdPiXMBFNEfkdDriRjphTyE2wiZQ0rg5EdWLDpSjB02Vg5j6r8
         1ylPjQy3B2+3y5pzByG1p9Y+5zqvkEiRwaqZFjQIHz1Ch4bVltCJFAF0NWsZP+qsYPfR
         tIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=98ippXJIzWiecn72dQL/jdkeNegtNbH2YlFsFIjeIB8=;
        b=cnq/7klvsBOVBNY5vD3XZ3Rk3OAcPwxU9dvxrstapXvJ5bseK7ngrEWus4BnR3R3ZC
         Gei1cC8j6+Hr7q/n1DbKt7q8ve8lqSTpyu5yIRk2JWnRfPptoE++MwEa5bK7owLpAAAh
         Rgg7kdjBzTepx0T5m/YYtY7ve3zQ3xkfEYjCVmx0FEGWrE2UverzR5xk7LUxm06CQqt7
         f2gs5fSJIqvSup7gusV1ys/FLPzILRyajUiV66p58SuSAZj3KzarFDhmd6xNprbc6Y8P
         jBB+tRGNsjQ+ZrG5DiyGpokXkrqLqcRpM0fZDyg305g5bas5barhArK5WFJ+I/LUHAHT
         8Gcg==
X-Gm-Message-State: AOAM530ZVqgIjyobyHiPJ/zxduNDfsf1IK0h64sVFZienJHAO5XqLUw3
        sBpn4LGccEU8tWPVKhQfOJSdeZ0BTJo5kA==
X-Google-Smtp-Source: ABdhPJzRWDnR/QUfQKLk7wYZFN2tkuuCI0Ha2XnrDNwAKxtUVPSF3t2o0BZDgWhU77zrVkD9JY/duA==
X-Received: by 2002:adf:f991:: with SMTP id f17mr7732677wrr.5.1618247742433;
        Mon, 12 Apr 2021 10:15:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/22] pickaxe tests: add missing test for --no-pickaxe-regex being an error
Date:   Mon, 12 Apr 2021 19:15:13 +0200
Message-Id: <patch-06.22-1696076bb09-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing test for --no-pickaxe-regex. This has been an error ever
since before the -S or -G options were added, or since
7ae0b0cb65f (git-log (internal): more options., 2006-03-01).

The reason for adding this test is that Junio suggested in [1] in
response to a later test addition in this series that it might be good
to support --no-pickaxe-regex in combination with -G. This would allow
for fixed-string searching with -G, similr to grep's --fixed-strings
mode.

I agree that that would make sense if anyone would like to implement
it, but since it dies right now let's first add this test to assert
the existing long-standing behavior. We can always add support for
--[no-]pickaxe-regex in combination with -G at some later date.

1. http://lore.kernel.org/git/xmqqwnto9pt7.fsf@gitster.g

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4209-log-pickaxe.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 21e22af1e7e..532bb875f02 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -66,6 +66,18 @@ test_expect_success 'usage' '
 	grep "mutually exclusive" err
 '
 
+test_expect_success 'usage: --no-pickaxe-regex' '
+	cat >expect <<-\EOF &&
+	fatal: unrecognized argument: --no-pickaxe-regex
+	EOF
+
+	test_expect_code 128 git log -Sstring --no-pickaxe-regex 2>actual &&
+	test_cmp expect actual &&
+
+	test_expect_code 128 git log -Gstring --no-pickaxe-regex 2>err &&
+	test_cmp expect actual
+'
+
 test_log	expect_initial	--grep initial
 test_log	expect_nomatch	--grep InItial
 test_log_icase	expect_initial	--grep InItial
-- 
2.31.1.639.g3d04783866f

