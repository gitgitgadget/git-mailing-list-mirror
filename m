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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACA2C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462CD613BC
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhDTMfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhDTMfq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:35:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C82FC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:35:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v13so6006559ple.9
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i/QCvtYqFtAr8YIIywtDOg48DRv53i9ckMyeOqSx3Bg=;
        b=pGZoihsB91K6B4QSR9Djb8GPoe/PS42b2gpJlfYOLzCuhTYOG4qeuERhlO+JO9w9UW
         Z+Xtri9NVnJxz8IUID/sQqLjwNoqQ+J7KZUsOHAFUjhbO7vFpUVxPXPHQBWVr22zTLd7
         Y2MjjbwOOpLhQidbT59tWDVMRYZ46cbDEo9X8QPlnCsl5VKFn714yLLHCItaQ8UtrKa7
         MRlYU3hEJ2M7LJP45UiCJt+qWTlUnzjlfTlKsbX8rIy9FrD0Qt+7iZrORhWfsgGPnpSl
         HKtzqUDpgJRElD4dXTnQoO6ZFEaU+OY36kuefLHRwSHSB/rH0eVNh/jOQcleWCCqKL6t
         YCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i/QCvtYqFtAr8YIIywtDOg48DRv53i9ckMyeOqSx3Bg=;
        b=N6mwX+NXTiFfQCJhSubYmbGotqkh4LAW2RXGEJzDElk2Z6BPqazILwOeBLwo1RgaQW
         jeajOCaskMrxsQuk64QMgwmHasA1/rnRCc/oVqvLYuCDOcfPlh9EBhKMDAcC6ta1B8aX
         lx5f+ns5SHk7d7tnpRKQNL1KZ0jjAXu06Sr3+pI59NlHWaf1yTKgidCoXH7AOCosNeQ6
         JkXzkMkazguqJUVfokx/HaWQIZypoq+WsnV69yFCflTTJxxM0JJKmwylZmpxIN5/j0mc
         97V86cZ7C94jx1xDfD/IHdXPrFpTdQ0l0amCPTXhlmqsSt60O/r00fP80ikvGeczZ+EW
         NtCg==
X-Gm-Message-State: AOAM531xpn09WCeVhiTdOY0DfcwmMXqmagT97N/dNNuUlviVhmE6geHe
        07I3jIy3cp0erbzgCnwBJMw=
X-Google-Smtp-Source: ABdhPJxYy46Dh8/UM4rYcxx/UIpgGWmYYM1a25vfVnsP3IJn91+uCo5z4TZ96YoOAnIetmazR2D0Qg==
X-Received: by 2002:a17:90a:2acb:: with SMTP id i11mr4583299pjg.131.1618922115126;
        Tue, 20 Apr 2021 05:35:15 -0700 (PDT)
Received: from ubuntu.mate (subs28-116-206-12-61.three.co.id. [116.206.12.61])
        by smtp.gmail.com with ESMTPSA id y8sm10021825pgr.48.2021.04.20.05.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:35:14 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     trygveaa@gmail.com
Cc:     git@vger.kernel.org, mirucam@gmail.com, pranit.bauva@gmail.com,
        christian.couder@gmail.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] test: add test for git bisect skip with --term* arguments
Date:   Tue, 20 Apr 2021 19:34:36 +0700
Message-Id: <20210420123435.35936-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210418151459.GC10839@aaberge.net>
References: <20210418151459.GC10839@aaberge.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current git bisect breakage happens when skipping in the middle of
bisect session which is started with --term-new and --term-old
arguments. This test expect that HEAD changes after skipping, in other
words HEAD before and after skipping must be different.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
NOTE: this patch is not intended for integrating into git.git, but
rather this patch is written to demonstrate this breakage. I hope that
the test can be added to t6030-bisect-porcelain.sh, and make this patch
redundant.  

 t/t6031-bisect-skip.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100755 t/t6031-bisect-skip.sh

diff --git a/t/t6031-bisect-skip.sh b/t/t6031-bisect-skip.sh
new file mode 100755
index 0000000000..0dfc6f0928
--- /dev/null
+++ b/t/t6031-bisect-skip.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+#
+# Copyright (c) 2021 Bagas Sanjaya
+#
+
+test_description='Tests git bisect --skip'
+
+exec </dev/null
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# hash variables
+HASH_SKIPPED_FROM=
+HASH_SKIPPED_TO=
+
+# initialize testing repo
+init() {
+	for i in `seq 1 20`; do
+		echo $i >> test &&
+		git add test && git commit -m $i
+	done
+}
+
+init
+
+test_expect_success 'test moving HEAD when skip bisecting' '
+	git bisect start --term-new=ok --term-old=whoops HEAD HEAD~9 &&
+	HASH_SKIPPED_FROM=$(git rev-parse --verify HEAD) &&
+	git bisect skip &&
+	HASH_SKIPPED_TO=$(git rev-parse --verify HEAD) &&
+	test $HASH_SKIPPED_FROM != $HASH_SKIPPED_TO
+'
-- 
2.25.1

