Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 806F120966
	for <e@80x24.org>; Thu,  6 Apr 2017 01:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756548AbdDFBjm (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 21:39:42 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33639 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756280AbdDFBjj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 21:39:39 -0400
Received: by mail-qt0-f195.google.com with SMTP id r45so3946887qte.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 18:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O0Me1IPnCy21siL0oCJl6zXboA6XrBX/JFVkPQYEhv4=;
        b=b42WsQ7lKgcWSOv70dhQcPQGE2bdD3otdSkHmV8wLfdzqQaqLJ4STmIKgHmMLjBUI3
         9Y4qNHCUKD+4MGHca6ehfDtoxGi0ddhyJij62juWuuPQs9ljh+8arMfqgq0K2+lkP1Fz
         8Y8zQBJ6c5+bd3msR0vA0VaD/UqarHyAsdHh3E71n3W8NR/hXzxQ+BUOxtS0YzmCOeh3
         3ymaFFn+nECUOaGz8u7yb0zH4yZzpcNt7pOeVWUudcD4+0gBrxUBeJIyHdN2PO7e9M2P
         Vg2X7Mox7ftamKgkSw7JOwrfbEn6L/Ryzu+960UUtcorgTRreauyBl+qp7EIE7WN+HJF
         ZUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O0Me1IPnCy21siL0oCJl6zXboA6XrBX/JFVkPQYEhv4=;
        b=DgfpliIOngpQbQO4PCACoa94ViUQtJkXOGsjDNxyY48fLpPZPOXn3Z6gwnbN9Rt0z4
         dsuRjh8GqwNBqaGBSrDRV7TaX5gdASA6xc4ESfLO5ptDV/72qmjAcxxgjNHDghlRZ6Vx
         EQPoGuwE/borh6xdDCLVOGm1TTjepXxDAamOFGgwYoL22HdCG6xepCqx9wceUnxeAmSf
         eZ1EXYBOZElq12M6iMbG0FzzZEDswvPLyTXTTXNF8ikBN+j0L7V8DrOAFiGMM8C/WhJH
         hj/SvxOMFHGCCBoo73627q0GjQKdgMxwzWxksXze3J5mI+lDSvWPfewZzwxVAWiOFans
         qT2g==
X-Gm-Message-State: AFeK/H3P9Wgh/rmY62zX2cNjtYBln7vCSqteb82Ymo7qNmbc00TJr2Mqe5WMlf4gkkGd5g==
X-Received: by 10.200.50.231 with SMTP id a36mr34769178qtb.156.1491442778740;
        Wed, 05 Apr 2017 18:39:38 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net ([187.11.121.49])
        by smtp.gmail.com with ESMTPSA id b78sm58718qkc.50.2017.04.05.18.39.35
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 18:39:37 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v8 1/5] dir_iterator: add tests for dir_iterator API
Date:   Wed,  5 Apr 2017 22:39:23 -0300
Message-Id: <1491442767-54068-2-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
References: <1491442767-54068-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create t/helper/test-dir-iterator.c, which prints relevant information
about a directory tree iterated over with dir_iterator.

Create t/t0065-dir-iterator.sh, which tests that dir_iterator does
iterate through a whole directory tree.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 Makefile                     |  1 +
 t/helper/.gitignore          |  1 +
 t/helper/test-dir-iterator.c | 29 +++++++++++++++++++++++
 t/t0065-dir-iterator.sh      | 55 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0065-dir-iterator.sh

diff --git a/Makefile b/Makefile
index 9b36068..41ce9ab 100644
--- a/Makefile
+++ b/Makefile
@@ -614,6 +614,7 @@ TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
+TEST_PROGRAMS_NEED_X += test-dir-iterator
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-dump-split-index
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 758ed2e..a7d74d3 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -3,6 +3,7 @@
 /test-config
 /test-date
 /test-delta
+/test-dir-iterator
 /test-dump-cache-tree
 /test-dump-split-index
 /test-dump-untracked-cache
diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
new file mode 100644
index 0000000..0394a13
--- /dev/null
+++ b/t/helper/test-dir-iterator.c
@@ -0,0 +1,29 @@
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "iterator.h"
+#include "dir-iterator.h"
+
+int cmd_main(int argc, const char **argv) {
+	struct strbuf path = STRBUF_INIT;
+	struct dir_iterator *diter;
+
+	if (argc < 2)
+		die("BUG: test-dir-iterator needs one argument");
+
+	strbuf_add(&path, argv[1], strlen(argv[1]));
+
+	diter = dir_iterator_begin(path.buf);
+
+	while (dir_iterator_advance(diter) == ITER_OK) {
+		if (S_ISDIR(diter->st.st_mode))
+			printf("[d] ");
+		else if (S_ISREG(diter->st.st_mode))
+			printf("[f] ");
+		else
+			printf("[?] ");
+
+		printf("(%s) [%s] %s\n", diter->relative_path, diter->basename, diter->path.buf);
+	}
+
+	return 0;
+}
diff --git a/t/t0065-dir-iterator.sh b/t/t0065-dir-iterator.sh
new file mode 100755
index 0000000..b6d76dd
--- /dev/null
+++ b/t/t0065-dir-iterator.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='Test directory iteration.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir -p dir &&
+	mkdir -p dir/a/b/c/ &&
+	>dir/b &&
+	>dir/c &&
+	mkdir -p dir/d/e/d/ &&
+	>dir/a/b/c/d &&
+	>dir/a/e &&
+	>dir/d/e/d/a &&
+
+	mkdir -p dir2/a/b/c/ &&
+	>dir2/a/b/c/d
+'
+
+cat >expect-sorted-output <<-\EOF &&
+[d] (a) [a] ./dir/a
+[d] (a/b) [b] ./dir/a/b
+[d] (a/b/c) [c] ./dir/a/b/c
+[d] (d) [d] ./dir/d
+[d] (d/e) [e] ./dir/d/e
+[d] (d/e/d) [d] ./dir/d/e/d
+[f] (a/b/c/d) [d] ./dir/a/b/c/d
+[f] (a/e) [e] ./dir/a/e
+[f] (b) [b] ./dir/b
+[f] (c) [c] ./dir/c
+[f] (d/e/d/a) [a] ./dir/d/e/d/a
+EOF
+
+test_expect_success 'dir-iterator should iterate through all files' '
+	test-dir-iterator ./dir >out &&
+	sort <out >./actual-pre-order-sorted-output &&
+
+	test_cmp expect-sorted-output actual-pre-order-sorted-output
+'
+
+cat >expect-pre-order-output <<-\EOF &&
+[d] (a) [a] ./dir2/a
+[d] (a/b) [b] ./dir2/a/b
+[d] (a/b/c) [c] ./dir2/a/b/c
+[f] (a/b/c/d) [d] ./dir2/a/b/c/d
+EOF
+
+test_expect_success 'dir-iterator should list files in the correct order' '
+	test-dir-iterator ./dir2 >actual-pre-order-output &&
+
+	test_cmp expect-pre-order-output actual-pre-order-output
+'
+
+test_done
-- 
2.7.4 (Apple Git-66)

