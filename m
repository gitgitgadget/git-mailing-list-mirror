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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1352C64E90
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9447D221F7
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkEIp3Yo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404758AbgKZTmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 14:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404660AbgKZTmp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 14:42:45 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1724CC0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:45 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id u10so457412wmm.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=puvy2p3sWHN7BXMEOvCUvaNMDvcRHjCNozT2Vlud4WE=;
        b=kkEIp3YoO7Nm0DDdi3ffbp+bWMHBY7gg45afNrZp6TiFKpazcUFUqLZ601F6kwdWeT
         Z68l73OlMS6r8HCBfJ2NNXgUg4Ss50GVtTguSeT45/2lVEAs8xCcjRRBrUOopfGPwCbs
         /w7zaE/cL5VLMqDnssmpg2IZ5m80nOp0lM3mOLqcxI0Dt1F5j2+Pv5X1L180GbPdJpJ3
         aevKkk7r22RkfZlFHL0kVs0M5eGiGWGYOjzn25xSHdviokLVxJjgnnjBzVIMmSTJ+cfG
         +/d2sQ8qteP20FC/Kx5cSzzN7xb/zKd3Q3jwwVUgCNY0nY14aUCGcjK/wKYWNdmdBErn
         t7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=puvy2p3sWHN7BXMEOvCUvaNMDvcRHjCNozT2Vlud4WE=;
        b=uOkVTFUWbHJBdPfs2vPUPOPLh6Qgrwlk/jvQgUa3fnMSktVoH0vqEbqNZ+4v75gPbl
         DijSA1mLpV0nYSujnppPYfd3dhe6QN7wsochw2xlBBEjZmJXr/4/trfvlBDNNIOD3vSl
         wIEvGUmn7pfcgD6tDXjNNwDfOjRNUkHDMgv4TeQySnkTVfBi7usbX8qFEaLkVowFY/AY
         WduT5WLPkuV07pQXtGk0NELi/p9wTHh8SxRixL+DJ+xj36V9XEE/OZ00OaEiDwwzZee1
         vClKfT9EKJmewQPCnQpOdna+5VINic5amdJsMB3S3zCqI2EXP8LNDG2fk6Jjs/vv4k15
         /XMw==
X-Gm-Message-State: AOAM530Ix+CIITBY6eo3Zzd/pALRTUE3ysNX8k0DYag1uM+JNM9gmlAO
        4B5lWmJNwZNIZtXMdTaWF8pm7IpT9XU=
X-Google-Smtp-Source: ABdhPJzvz6pv87l0aWAobV23a2pW+cV+JS2kv7/s3zkwCom8MEXBRmdKIMsh+i6h+/Cc1XKZ+DLBgQ==
X-Received: by 2002:a1c:4006:: with SMTP id n6mr5103955wma.135.1606419763484;
        Thu, 26 Nov 2020 11:42:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h204sm3472255wme.17.2020.11.26.11.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 11:42:42 -0800 (PST)
Message-Id: <24afac9c91a2eaf1529433a136d0f43aeae71550.1606419752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
        <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Nov 2020 19:42:24 +0000
Subject: [PATCH v3 09/16] reftable: a generic binary tree implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
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
index fcfe4075c3..89564d4c06 100644
--- a/Makefile
+++ b/Makefile
@@ -2395,12 +2395,14 @@ REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/publicbasics.o
 REFTABLE_OBJS += reftable/record.o
+REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/zlib-compat.o
 
+REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
-REFTABLE_TEST_OBJS += reftable/basics_test.o
+REFTABLE_TEST_OBJS += reftable/tree_test.o
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
diff --git a/reftable/tree.c b/reftable/tree.c
new file mode 100644
index 0000000000..0061d14e30
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
+	if (t->left != NULL) {
+		infix_walk(t->left, action, arg);
+	}
+	action(arg, t->key);
+	if (t->right != NULL) {
+		infix_walk(t->right, action, arg);
+	}
+}
+
+void tree_free(struct tree_node *t)
+{
+	if (t == NULL) {
+		return;
+	}
+	if (t->left != NULL) {
+		tree_free(t->left);
+	}
+	if (t->right != NULL) {
+		tree_free(t->right);
+	}
+	reftable_free(t);
+}
diff --git a/reftable/tree.h b/reftable/tree.h
new file mode 100644
index 0000000000..954512e9a3
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
+   is set, insert the key if it's not found. Else, return NULL.
+*/
+struct tree_node *tree_search(void *key, struct tree_node **rootp,
+			      int (*compare)(const void *, const void *),
+			      int insert);
+
+/* performs an infix walk of the tree. */
+void infix_walk(struct tree_node *t, void (*action)(void *arg, void *key),
+		void *arg);
+
+/*
+  deallocates the tree nodes recursively. Keys should be deallocated separately
+  by walking over the tree. */
+void tree_free(struct tree_node *t);
+
+#endif
diff --git a/reftable/tree_test.c b/reftable/tree_test.c
new file mode 100644
index 0000000000..6de9c9dbe5
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
+	struct curry *c = (struct curry *)arg;
+	if (c->last != NULL) {
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
+	test_tree();
+	return 0;
+}
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index c9deeaf08c..050551fa69 100644
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

