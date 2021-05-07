Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE45AC433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982E16112F
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhEGEGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 00:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhEGEGC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 00:06:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687A5C061761
        for <git@vger.kernel.org>; Thu,  6 May 2021 21:05:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v12so7681015wrq.6
        for <git@vger.kernel.org>; Thu, 06 May 2021 21:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v5loYWvSZoqGvlhAuSo5IwrvfMT/3yTkKMM6xGuLRpM=;
        b=gXP0fZ5Z2gSNnx7F5XOQiO3EUGz/wLQMvtvmEBea9NBDKBL7rOJakXYMjD1M1ftTmD
         D1kS1cBSENi2GaT/AwetMsWkDKqWG8+6EcWDdEO6Dedk9fUay0UL/d3YWU9E3EoW6VAq
         Cg1k6FJWtfedrjGNvCw3MoVFPX8z/pBq2HUBgwWL3LFGPu3bRuMEWdurKuVdJG0ii+WJ
         ikM3b18nD/oIwVaBpPcrzjzLHtDhDi/bG0gOluVNS2VC/xGq47svlAyO8DQm7FeOi9sx
         yuF33zTmRODU1AmYlqek2AEzfOrNSRfwpsJg+q6DRkY64+wXsb9qfL2+dFmAHO21/XGb
         PM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v5loYWvSZoqGvlhAuSo5IwrvfMT/3yTkKMM6xGuLRpM=;
        b=lm+b3pU2rJV2Al19TJj7FoYTfX1tER1LgqNKVMXWqiNGSzq/rJ96Q4pw3+tmgS9t10
         A07bmMk3DFCTCIo7LXtJ0B06yoOs7rcQe8IFQlJNw6M51Uu90jwKjJmNaQKTYSRjQWD6
         hAPiQxrNDX2x8A8dBqXP5UiHyqloRZS+Hicx44oUegdFOCuo+2zLRkP4MQPSchCeSvrp
         ndWkH4VMhDUpIKWoX0KPSm6Rxc8R5toJy4PXoINcdJRdLLQ7BNejVf62edOdVQZrDnsi
         5hZm/ezJLZ11PEI7VFw16KWyMotENa01LQe1JB4/gq1rfYetGVffQpmKB5ZWtHY7CgSj
         wwsw==
X-Gm-Message-State: AOAM530Fq8rtWf/a9mMCm41nmTIVYEwTk3vtf51/kDeJBjXSeF9WbhrX
        PVdmkmzCUPiSOY74Z/i9WIm1S5itOWM=
X-Google-Smtp-Source: ABdhPJxbpgeaSVt+BZADE6I+mSfmqLGkvA5kaMrH59IGTfCm/TDDYITQs2BUY9mewnDYpxlaEGcckQ==
X-Received: by 2002:adf:fc42:: with SMTP id e2mr9680453wrs.302.1620360302236;
        Thu, 06 May 2021 21:05:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b20sm6902657wmj.3.2021.05.06.21.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 21:05:01 -0700 (PDT)
Message-Id: <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620360300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 07 May 2021 04:04:56 +0000
Subject: [PATCH 1/5] t7300: add testcase showing unnecessary traversal into
 ignored directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

PNPM is apparently creating deeply nested (but ignored) directory
structures; traversing them is costly performance-wise, unnecessary, and
in some cases is even throwing warnings/errors because the paths are too
long to handle on various platforms.  Add a testcase that demonstrates
this problem.

Initial-test-by: Jason Gore <Jason.Gore@microsoft.com>
Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7300-clean.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index a74816ca8b46..5f1dc397c11e 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -746,4 +746,44 @@ test_expect_success 'clean untracked paths by pathspec' '
 	test_must_be_empty actual
 '
 
+test_expect_failure 'avoid traversing into ignored directories' '
+	test_when_finished rm -f output error &&
+	test_create_repo avoid-traversing-deep-hierarchy &&
+	(
+		cd avoid-traversing-deep-hierarchy &&
+
+		>directory-random-file.txt &&
+		# Put this file under directory400/directory399/.../directory1/
+		depth=400 &&
+		for x in $(test_seq 1 $depth); do
+			mkdir "tmpdirectory$x" &&
+			mv directory* "tmpdirectory$x" &&
+			mv "tmpdirectory$x" "directory$x"
+		done &&
+
+		git clean -ffdxn -e directory$depth >../output 2>../error &&
+
+		test_must_be_empty ../output &&
+		# We especially do not want things like
+		#   "warning: could not open directory "
+		# appearing in the error output.  It is true that directories
+		# that are too long cannot be opened, but we should not be
+		# recursing into those directories anyway since the very first
+		# level is ignored.
+		test_must_be_empty ../error &&
+
+		# alpine-linux-musl fails to "rm -rf" a directory with such
+		# a deeply nested hierarchy.  Help it out by deleting the
+		# leading directories ourselves.  Super slow, but, what else
+		# can we do?  Without this, we will hit a
+		#     error: Tests passed but test cleanup failed; aborting
+		# so do this ugly manual cleanup...
+		while test ! -f directory-random-file.txt; do
+			name=$(ls -d directory*) &&
+			mv $name/* . &&
+			rmdir $name
+		done
+	)
+'
+
 test_done
-- 
gitgitgadget

