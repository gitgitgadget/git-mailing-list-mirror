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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27565C4320A
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E9DE60F22
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhHPUST (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhHPUSD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:18:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C784C0617AE
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:31 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x10so18976699wrt.8
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2v522cJCeZ6vdJddEQgLuThQpB3ilPxxkm8b49Q6Rq0=;
        b=o/uAVdfzaVSUYXnVTq4Zv6nhkngPdqeXzmfvN3do8NiPtxy+Ge0YUOwmvDs/gCb1Yh
         MiLvFLcKyMC0Aziv5NEJi7v3dYZ5VIjrtmllm/M4BwAAtSnCzTbAVEVLirCkMdMLtoI9
         EFyFC1GYzOjC+Sz4FDiR7/pNO8PNulCvxJvGbDS7G3dPn0a4b0XKHmwapHWeDOxgLh/h
         buNCQrlfZCWwgADcqCMOO0PqpcwhfyjFecEfhzz6ObuKlHk/YF0f6WIF76cryedjjx5d
         +LAwFHVql3NsB8gijnTV5jvqmX2+NCHKJ4MKvDTZgbDQt1zry5mLcVYfgIVO6UzTt0TG
         C/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2v522cJCeZ6vdJddEQgLuThQpB3ilPxxkm8b49Q6Rq0=;
        b=AEnlBd0wPre4LX+sZO8MyD7ufsfLwvQAbr9kCoU4NhyyR5yHbwnVIOCPspHo9A6fVc
         Lo6lQV7XL4odFUV9bnTLbOjXtPRsdcLgYrWAshXofSCzO70eeQFgX9nymNBMiSa762iq
         OXI/Xy4yWzp7ZjI6F1KBzJvN5qa0iW/wxtZc9awSPlaxJEDW9YNuVkeGAHk2f8aYdMOp
         S3NCcAIv+3KIvhJd5mkfmzeHw6qos3q5bciK325mgaCZC5LxYOUvUA2slB9u7ViAVXpk
         0IaLd/h5BXr65Z6N8x4XfHz/ojfRJewUO9CC6wkKnwxbeAZb6AmoaIM1VQOWwU9WlE8r
         r6Jw==
X-Gm-Message-State: AOAM5318EyuAISVUdC5P6NgIAfF1sPGpYiz4459WlYcEKitCsf3OlUYH
        128gLDgm4q82d5HMDg5VBUR8XPpEXj8=
X-Google-Smtp-Source: ABdhPJyApa742W3UFVv7FasZ4Vyj56kBrdJtr9ETSqGMKpccBB9CSO0GuYI502C3tYCnYCxnFcowiQ==
X-Received: by 2002:adf:fc89:: with SMTP id g9mr213316wrr.239.1629145049676;
        Mon, 16 Aug 2021 13:17:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm182846wma.25.2021.08.16.13.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:17:29 -0700 (PDT)
Message-Id: <0f325881389b3631ce03ce8ff1ee8bad44096a8e.1629145036.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
        <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 20:17:01 +0000
Subject: [PATCH v2 10/25] reftable: a generic binary tree implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
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
index 1d396c87be9..be14b66f9e3 100644
--- a/Makefile
+++ b/Makefile
@@ -2458,11 +2458,13 @@ REFTABLE_OBJS += reftable/block.o
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
index 00000000000..09a970e17b9
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
+		assert(test_compare(c->last, key) < 0);
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
+		assert(values + i == nodes[i]->key);
+		assert(nodes[i] ==
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

