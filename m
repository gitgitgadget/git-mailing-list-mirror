Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581B0C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432DC61262
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbhHXJQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbhHXJQS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 05:16:18 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAD2C061764
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 02:15:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g135so3022092wme.5
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aWFfsPaZVecHUlqbApkl7Mt4nHs4zvWSqxz/im34/Aw=;
        b=PfLceNaQd3QyciTkl0cjeaWLUZk5a871aEFL1VuJjFW134QdvIUuIn06AHX5+cRqEg
         XBFDF1trMscsp4I2NtndHkJ6UPN641EbTq8DSYzjOuh4WY4L9LQFb9ycUr+ifr3+K4YL
         pHOZUYua4FvAHl82cWIdgUOOmvUDjNAqJSnfNJKfkiGffK2fIZMPxKvdUEK0l/ROVDV9
         /qDTexeWHDAuyix2smPsRNYIj0fL+vevSi0bpguq9fPsgWCyrV9cvtgVVPPSKSKtXjJa
         U5LBNkd/sSJjdNBb+zoErVM34rgLjksKEACs4PBF9ir/SYy7lbx0L5ZGoPlh4OAa40c0
         NP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWFfsPaZVecHUlqbApkl7Mt4nHs4zvWSqxz/im34/Aw=;
        b=k2+/0eSSQtVvDt/yXVEk3GCQFdz/CGqzltpAAH6hFboCT9PCM8oOxJBQRMzGcQLziF
         mImsKKTvmYsvtnrSrQYA7P7gIDw9LVP12B7oIlD9peJPEH9PmL6O3yaDLRTJKNjrDPTJ
         qP522QBHWVySkJBRrn+QIfeONX9ldPhqME94GvtIsjseiMO+zTWFBxIT6gJxOgSqD9W0
         tkXWDaB0CpO0q92IFaysY8vgLL5S0rnsoCTuPXBt0H5XUwXa5rKGqAM/7wcLCFbKe3HC
         XLF60fM0OBmAsB0m8DcWGUxk6pQU/AHiMjK/R3yfuUXGoY0tzP7Y/U15EykNFNVd7xFQ
         Jjkw==
X-Gm-Message-State: AOAM5326qEoq5PjOja9O7Ibel+ECVt6MbbJR6LIXWVb+PonfWIJ9Fftp
        UBP0Tiv1PiUc3WtePdI2AiAECt5CjmcIqg==
X-Google-Smtp-Source: ABdhPJzBKsjeOkZyA1EumiEfMZfTo8Lssz2xxummYotZyi62fuyFxHAcdWuhNU3brk8MMhyx+2BI4w==
X-Received: by 2002:a05:600c:2f90:: with SMTP id t16mr3190133wmn.136.1629796532663;
        Tue, 24 Aug 2021 02:15:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u8sm1853104wmq.45.2021.08.24.02.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:15:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/4] test-tool: migrate read-cache-perf to parse_options()
Date:   Tue, 24 Aug 2021 11:15:23 +0200
Message-Id: <patch-v2-2.4-a68fa4a6355-20210824T091204Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.663.gbaff4edb973
In-Reply-To: <cover-v2-0.4-00000000000-20210824T091204Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20210824T091204Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the newly added (but then mostly copy/pasted) read-cache-perf
to use the parse_options() API. This will make things easier as we add
new options.

Since we check the "cnt = < 1" case now via more idiomatic
post-parse_options() assertions we can move from the for-loop to a
while-loop and ditch the "i" variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-read-cache-perf.c | 26 ++++++++++++++++++++------
 t/perf/p0002-read-cache.sh      |  2 +-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-read-cache-perf.c b/t/helper/test-read-cache-perf.c
index 90176c010a1..301e98797b4 100644
--- a/t/helper/test-read-cache-perf.c
+++ b/t/helper/test-read-cache-perf.c
@@ -1,18 +1,32 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "parse-options.h"
+
+static const char *read_cache_perf_usage[] = {
+	"test-tool read-cache-perf [<options>...]",
+	NULL
+};
 
 int cmd__read_cache_perf(int argc, const char **argv)
 {
 	struct repository *r = the_repository;
-	int i, cnt = 1;
+	int cnt = -1;
+	struct option options[] = {
+		OPT_INTEGER(0, "count", &cnt, "number of passes"),
+		OPT_END()
+	};
 
-	if (argc == 2)
-		cnt = strtol(argv[1], NULL, 0);
-	else
-		die("usage: test-tool read-cache-perf [<count>]");
+	argc = parse_options(argc, argv, "test-tools", options,
+			     read_cache_perf_usage, 0);
+	if (argc)
+		usage_msg_opt("Too many arguments.", read_cache_perf_usage,
+			      options);
+	if (cnt < 1)
+		usage_msg_opt("Need at least one pass.", read_cache_perf_usage,
+			      options);
 
 	setup_git_directory();
-	for (i = 0; i < cnt; i++) {
+	while (cnt--) {
 		repo_read_index(r);
 		discard_index(r->index);
 	}
diff --git a/t/perf/p0002-read-cache.sh b/t/perf/p0002-read-cache.sh
index d0ba5173fb1..1762b648654 100755
--- a/t/perf/p0002-read-cache.sh
+++ b/t/perf/p0002-read-cache.sh
@@ -8,7 +8,7 @@ test_perf_default_repo
 
 count=1000
 test_perf "read_cache/discard_cache $count times" "
-	test-tool read-cache-perf $count
+	test-tool read-cache-perf --count=$count
 "
 
 test_done
-- 
2.33.0.663.gbaff4edb973

