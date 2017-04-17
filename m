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
	by dcvr.yhbt.net (Postfix) with ESMTP id A9BF120A04
	for <e@80x24.org>; Mon, 17 Apr 2017 20:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932200AbdDQUvv (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 16:51:51 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35464 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbdDQUvt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 16:51:49 -0400
Received: by mail-qk0-f195.google.com with SMTP id k139so21116027qke.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qjSokgMLv2L7QqhP1H5ltIZ6vUs34ywP+qEGK95Pzfg=;
        b=UKc/EFWfZoGmQe6iOcIhoITDz45a/EzjxtO0pCLb7Dp7UDZpLkNzLFCHt+N6k398kM
         pEJEpTifhA3a5nC89il7cNWXQdD/VI1j6Hm6BJTbs7mu0qnjrPILL0479aFCjBBIQ3zQ
         OWeJj/tYja1poGKw9WTPEOlKXUT7omR6pvifdapR1i7STzUxq6ohbS2BzQBHf+WmSjAm
         62w5Nzyf7GqA4NCgVki9nSWD6bxaUQ7KMwtLJaLNSRMSdzUEmMF1c5AojKF2mCMnvaUz
         TSTI9gkGJF4KH+pseAKZpM2ISrGP0haJ1eWDxsTQ8HCca8m7ZmUfYhjPxmK/3bannStf
         eXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qjSokgMLv2L7QqhP1H5ltIZ6vUs34ywP+qEGK95Pzfg=;
        b=P9N1kEx/3AhNRDj+kShbyNJ/f4eG3TAhF0SoyZktACXfzPqPnU5K2qntWZgdOtxql1
         ujI79x0XAsR/JlfFNUxtmO0vbGGoyjrKUJGl0VCQMd16u8W36RpfjBcyFfAn79aT54y6
         ZNAgyopf33Ks9kgZMrmaqEElQ5DTn+bc0yVx3xH4hH33J2qu5H7nPFLsQ1tMAv2EQo+k
         lSR7BqtEmKzgv1qtZmlWduuV3S2N297kQ+U9wkulLkIbnw3TnJV0Y2GtqdzLTwt+uQy9
         p1imP5RRJ6A8NzcX++mdeBwLs0vkzwkb80AQr1VAh4oc4ZLjA0UAJullSpGGZBMtxQaF
         5WMg==
X-Gm-Message-State: AN3rC/6auoyM4JAzA6Egi0aWa4VNmfHTOHX4lAkHb7KdoZ6SfhUhTWCx
        FC23SqNgTHpYLw==
X-Received: by 10.55.6.83 with SMTP id 80mr11348452qkg.156.1492462308932;
        Mon, 17 Apr 2017 13:51:48 -0700 (PDT)
Received: from localhost.localdomain ([179.222.191.2])
        by smtp.gmail.com with ESMTPSA id f203sm8093848qka.11.2017.04.17.13.51.45
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 13:51:47 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v9 1/5] dir_iterator: add tests for dir_iterator API
Date:   Mon, 17 Apr 2017 17:51:32 -0300
Message-Id: <1492462296-4990-2-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1492462296-4990-1-git-send-email-bnmvco@gmail.com>
References: <1492462296-4990-1-git-send-email-bnmvco@gmail.com>
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
 t/helper/test-dir-iterator.c | 30 ++++++++++++++++++++++++
 t/t0065-dir-iterator.sh      | 55 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)
 create mode 100644 t/helper/test-dir-iterator.c
 create mode 100755 t/t0065-dir-iterator.sh

diff --git a/Makefile b/Makefile
index d595ea3..a5c1ac0 100644
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
index 0000000..a7d1470
--- /dev/null
+++ b/t/helper/test-dir-iterator.c
@@ -0,0 +1,30 @@
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "iterator.h"
+#include "dir-iterator.h"
+
+int cmd_main(int argc, const char **argv)
+{
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

