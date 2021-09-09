Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B5BC433FE
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C79BE61100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245729AbhIIStv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245014AbhIIStI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:49:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCC9C0613C1
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d6so3940778wrc.11
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gnbFrauqPj2CcoiVdgZ8s35rgWABFI51ejPN6txeGCE=;
        b=C0yFvJAy+4Z9qsFH8vuzLVN0jLTSVBCzkXTfO0F4xh6UrwwvWZzWaQcNsHMcIJymtS
         mFwyFAsDBP/0duDg8Q2s522XMgwufNSmsoGBvuXSOREHwCbT4EdAS4vdQtsXrvRjVhb+
         g7g6ENPgK9GsNxzOcE5wBx1oX7ErGQdXxSi5Sspj59qd3DMZ/DryuCZJCQJUgLbW+JFr
         9aSbOcYxEvvfNCJ8QxxevY3elfOGnTl9aFD27v+JWNwlhl5DqCSFwg+3FsksJl8l3GP2
         0ej/7yP5rPHD0aREoUEa6rHweqZKcARzEEPTyi5ka8/VDNcALfdGDuPt7Cua6IxKhfqQ
         crSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gnbFrauqPj2CcoiVdgZ8s35rgWABFI51ejPN6txeGCE=;
        b=n8O7nJHSS9ENseVOcdnVV8WIlq4SQ1aV+/n5O6tiFBNMtpwoi6aJsOxpuWh4vhW4RF
         wvKA2goDyCpQNtzYgr6JVM97YBBaoBge2MrRxsAZ0yck2g1arfbXe4CWzUA8CfWi2DsX
         XcR71TJ7Twmk18ZKiSkzqwSZdGZ5CUb1OalRjrgBf8Zrf68kKCrzv1NSsTQrqvK5rR1E
         6lItOpH4FBH0OIVIP4GeMfm353nfUSH3xl/xIqt1Sj2Jkmbc2wJcbq7A9+qmXMreHTXT
         iPnR67D1S3xhn+SRPumu8zxistb9YInpZ0uXGZtzmHs7YWlTTNVeQYxQ/MISOjExlG3a
         A0/w==
X-Gm-Message-State: AOAM532J/ZrJ82bC0zApqPI7nKUszc4OrjDrRil2K0T/w/TaLEoc/l4Q
        zluL/On1k4nHCM+R+r5ytvzcd+a9qT0=
X-Google-Smtp-Source: ABdhPJwc5qa/q86I33vunL8da15T+51A1ZqM/Ihbb+fQZZf62GlRb+sTgfNyqc6oewKP+Dlofj+CWg==
X-Received: by 2002:a5d:6781:: with SMTP id v1mr5377101wru.249.1631213271751;
        Thu, 09 Sep 2021 11:47:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d129sm2511233wmd.23.2021.09.09.11.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:47:51 -0700 (PDT)
Message-Id: <8d2e8be5795c9e32726fe519b1c1979a581e3a44.1631213265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 18:47:34 +0000
Subject: [PATCH v2 09/19] reftable: a generic binary tree implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The reftable format includes support for an (OID => ref) map. This map can speed
up visibility and reachability checks. In particular, various operations along
the fetch/push path within Gerrit have ben sped up by using this structure.

The map is constructed with help of a binary tree. Object IDs are hashes, so
they are uniformly distributed. Hence, the tree does not attempt forced
rebalancing.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                 |  4 ++-
 reftable/tree.c          | 63 ++++++++++++++++++++++++++++++++++++++++
 reftable/tree.h          | 34 ++++++++++++++++++++++
 reftable/tree_test.c     | 61 ++++++++++++++++++++++++++++++++++++++
 t/helper/test-reftable.c |  1 +
 5 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/tree_test.c

diff --git a/Makefile b/Makefile
index 14a0a1f7643..157ff1edba8 100644
--- a/Makefile
+++ b/Makefile
@@ -2462,11 +2462,13 @@ REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/publicbasics.o
 REFTABLE_OBJS += reftable/record.o
+REFTABLE_OBJS += reftable/tree.o
 
+REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
-REFTABLE_TEST_OBJS += reftable/basics_test.o
+REFTABLE_TEST_OBJS += reftable/tree_test.o
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
diff --git a/reftable/tree.c b/reftable/tree.c
new file mode 100644
index 00000000000..82db7995dd6
--- /dev/null
+++ b/reftable/tree.c
@@ -0,0 +1,63 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "tree.h"
+
+#include "basics.h"
+#include "system.h"
+
+struct tree_node *tree_search(void *key, struct tree_node **rootp,
+			      int (*compare)(const void *, const void *),
+			      int insert)
+{
+	int res;
+	if (*rootp == NULL) {
+		if (!insert) {
+			return NULL;
+		} else {
+			struct tree_node *n =
+				reftable_calloc(sizeof(struct tree_node));
+			n->key = key;
+			*rootp = n;
+			return *rootp;
+		}
+	}
+
+	res = compare(key, (*rootp)->key);
+	if (res < 0)
+		return tree_search(key, &(*rootp)->left, compare, insert);
+	else if (res > 0)
+		return tree_search(key, &(*rootp)->right, compare, insert);
+	return *rootp;
+}
+
+void infix_walk(struct tree_node *t, void (*action)(void *arg, void *key),
+		void *arg)
+{
+	if (t->left) {
+		infix_walk(t->left, action, arg);
+	}
+	action(arg, t->key);
+	if (t->right) {
+		infix_walk(t->right, action, arg);
+	}
+}
+
+void tree_free(struct tree_node *t)
+{
+	if (t == NULL) {
+		return;
+	}
+	if (t->left) {
+		tree_free(t->left);
+	}
+	if (t->right) {
+		tree_free(t->right);
+	}
+	reftable_free(t);
+}
diff --git a/reftable/tree.h b/reftable/tree.h
new file mode 100644
index 00000000000..fbdd002e23a
--- /dev/null
+++ b/reftable/tree.h
@@ -0,0 +1,34 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef TREE_H
+#define TREE_H
+
+/* tree_node is a generic binary search tree. */
+struct tree_node {
+	void *key;
+	struct tree_node *left, *right;
+};
+
+/* looks for `key` in `rootp` using `compare` as comparison function. If insert
+ * is set, insert the key if it's not found. Else, return NULL.
+ */
+struct tree_node *tree_search(void *key, struct tree_node **rootp,
+			      int (*compare)(const void *, const void *),
+			      int insert);
+
+/* performs an infix walk of the tree. */
+void infix_walk(struct tree_node *t, void (*action)(void *arg, void *key),
+		void *arg);
+
+/*
+ * deallocates the tree nodes recursively. Keys should be deallocated separately
+ * by walking over the tree. */
+void tree_free(struct tree_node *t);
+
+#endif
diff --git a/reftable/tree_test.c b/reftable/tree_test.c
new file mode 100644
index 00000000000..cbff1255886
--- /dev/null
+++ b/reftable/tree_test.c
@@ -0,0 +1,61 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "tree.h"
+
+#include "basics.h"
+#include "record.h"
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+static int test_compare(const void *a, const void *b)
+{
+	return (char *)a - (char *)b;
+}
+
+struct curry {
+	void *last;
+};
+
+static void check_increasing(void *arg, void *key)
+{
+	struct curry *c = arg;
+	if (c->last) {
+		EXPECT(test_compare(c->last, key) < 0);
+	}
+	c->last = key;
+}
+
+static void test_tree(void)
+{
+	struct tree_node *root = NULL;
+
+	void *values[11] = { NULL };
+	struct tree_node *nodes[11] = { NULL };
+	int i = 1;
+	struct curry c = { NULL };
+	do {
+		nodes[i] = tree_search(values + i, &root, &test_compare, 1);
+		i = (i * 7) % 11;
+	} while (i != 1);
+
+	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
+		EXPECT(values + i == nodes[i]->key);
+		EXPECT(nodes[i] ==
+		       tree_search(values + i, &root, &test_compare, 0));
+	}
+
+	infix_walk(root, check_increasing, &c);
+	tree_free(root);
+}
+
+int tree_test_main(int argc, const char *argv[])
+{
+	RUN_TEST(test_tree);
+	return 0;
+}
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index c9deeaf08c7..050551fa698 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -6,5 +6,6 @@ int cmd__reftable(int argc, const char **argv)
 	basics_test_main(argc, argv);
 	block_test_main(argc, argv);
 	record_test_main(argc, argv);
+	tree_test_main(argc, argv);
 	return 0;
 }
-- 
gitgitgadget

