Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87736C433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4065C6100C
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhEHAJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 20:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhEHAJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 20:09:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A07C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 17:08:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t11-20020a05600c198bb02901476e13296aso5754190wmq.0
        for <git@vger.kernel.org>; Fri, 07 May 2021 17:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v5loYWvSZoqGvlhAuSo5IwrvfMT/3yTkKMM6xGuLRpM=;
        b=k+b1udKWAvAYQclVzngwJh8TxOLXYxNEZFUbAkzGZY3Y67E1bRNNOS8Eh/b7bsBTRr
         ah5DNO28Hs+DI5Pr48ylWTkaLRtyPer2EHVJb0XUuJybCpFG3U5VWuhI1otwkC43CuQS
         AdY0ToXKS0fJJPM6oDcQZekD3Hj/TJE2rHFl8GXXhIoSsrp7MbraBom00/ZOvqme73wH
         9jLwwPPQW4fopOGymN1+TOZQZN4asZcLmREfq4P63r4wKWgK29JAjiKY+2DTexK7eF+m
         N1gmG6fqmmi6MHpUAx4HTOq01Ag4CUQmOJMFI8KFqRJW/xTdT0WwgWj5dx82tIrM3rQx
         WqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v5loYWvSZoqGvlhAuSo5IwrvfMT/3yTkKMM6xGuLRpM=;
        b=JaYHVWDgjRFhcIZV0gxyEOE94AlXiFQ4HO9Hpch7WB5AnL5P1poGSNvzxxtmvAf3LL
         UvFQHs13xhKpA/F/5iW0Z8+q1mSC5+Sf0LutpvmiMSBt1fAwDyFCXxV92nezf8JNVruX
         2tbxzYkZdMytkZMKRmjErx7+97JToTWklNVKIVo5z0B2E/4YC5L8cnGP1dWBUnpXXVdR
         XUiezsTgSGAn/tbHc5zmO4IYFouSQuidcfQVkKC/270z/W9DzZNW458Jxf888ns3XMQZ
         tCGtBW6P3mkDEhtDij6R378Y7/iIkCWwt0pM49mv7f79dY6tNU8kQmXVd5nmB5rXgiik
         Sk3Q==
X-Gm-Message-State: AOAM532Qiblj8MJxJ5sJ1hdrwy3wH+DvvW2xzKKoHCDBunN5NiBgdKqv
        +K+S93MepbvERwNk8TzOt9W0yOEWj3c=
X-Google-Smtp-Source: ABdhPJwBFiVWqxgBk6MSaz/+5n5jplIw4i8qnICoIj/WL6h8VYsd8PPErDJCmahPNKeuQ3yzVk6l2A==
X-Received: by 2002:a1c:804a:: with SMTP id b71mr12827849wmd.82.1620432502569;
        Fri, 07 May 2021 17:08:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t7sm10012997wrw.60.2021.05.07.17.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 17:08:22 -0700 (PDT)
Message-Id: <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620432500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
        <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 00:08:13 +0000
Subject: [PATCH v2 1/8] t7300: add testcase showing unnecessary traversal into
 ignored directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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

