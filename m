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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EC5C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AC823B31
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgLIOC7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732781AbgLIOB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 09:01:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EB2C061285
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 06:00:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id x6so1846816wro.11
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 06:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kmTaSl1V6fQm6G4+IW71nCIJW8ZmPn8MUkbzlmuR2Xs=;
        b=gJ082F5Tsh4XyieqCY8/DO34R5mjM6uAFYCxN3+praKZbim8uOvaCaCFP4cVT2Azc0
         mHYHFj0/AHeET0UZYJqj8oDRdD/GQfiY4TG7vlJFu0+zLwDIY7dUYwcl+flfr3rv2q5A
         u6zCroeKw+nsb2I4+PaQE+xaNvoa4Qqp0w0UQc21zH+AnZ0N0J51WLicFhGnSHj2IrX8
         dL2cPmw9C4BeElhptfVJU4HiYmfD86xtUN2Oaji87/bZvVVEA/6NvNrdCazYiE/6Xrwk
         x1ZJTX9CB5LGFl3L5RA0yPXZDMfJVjyu+35j1O+/cty6+ZYXAr7Znlo6EJgEkU31LwQQ
         5JDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kmTaSl1V6fQm6G4+IW71nCIJW8ZmPn8MUkbzlmuR2Xs=;
        b=MbGwV40grmg6689FNQ0AbYcG7iqH/aVpZEGo321QIGKLLre+Mi/TQJXfJQEtCaREo/
         xqKdSzX1p1k06V+1t9e29lfHIMHW6NEBfpVkoF88HmEULZMdyuK+KhWMdHfqTIEOTJj+
         Rjmd55fqW8hvjMyn2EmtkN1yqV9fxKLH1jN+EjTxp89r5w/NFP7NSRgvpaNJ+m3X4QYQ
         HSFT3Jrbi23gNVLWohQ2q8fosoxOX73Hiau0QwhC+pZs4M9cgYzMg7ljgMWfWoPqToVf
         Iklnau1NT6MsfJzO5sRDliER7M14M91pnb4vBRNnE1qCssz4L9SHVp3cW7jX8+l3RFaT
         Uxhg==
X-Gm-Message-State: AOAM531lsx0hkjk4vEbEtIs9RTUFszq4BR3xUAmeY8Y9MBHWnwF8LzzU
        5tIUf7VMtTs0it5BB8736zLy7RNqIuI=
X-Google-Smtp-Source: ABdhPJy+fFN4k4NYbAJW+51wFFpKbj0H3cNVQgf6/EiEJEQwujlSVQFr/243LCgvyagUu8fbtreo5w==
X-Received: by 2002:adf:9b91:: with SMTP id d17mr2887751wrc.32.1607522439399;
        Wed, 09 Dec 2020 06:00:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5sm4003637wrp.56.2020.12.09.06.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:00:38 -0800 (PST)
Message-Id: <6968dbc3828f22369cc92bf56e3a7855769415fa.1607522429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
        <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 14:00:22 +0000
Subject: [PATCH v4 08/15] reftable: a generic binary tree implementation
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
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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
index abe0dda5777..734c05655b2 100644
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
index 00000000000..0061d14e306
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
index 00000000000..26d1e694252
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

