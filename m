Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0166CC2BB84
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D14520732
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeG63xvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgIPTLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 15:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgIPTK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 15:10:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58059C061352
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id a9so4163138wmm.2
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K9TBxxnClvyMzV16ZhiWZhbjDPodwn9kOmETXxQbBn0=;
        b=jeG63xvd8lAQ1A2M5hJYcFn/eBpozHo/Xs6xsyQ4BWc9pIZBIAV30AhzzajSzBZnsT
         EExQhUiz10H99ol5vbSJRiBiKkS2BFA3nB9g99wekl2sUPsX+1CEH+q+vozGj+ddz0Nw
         M0wypC8aBvbYk5HAGx4X3dQ/BT+wfS+sIrq3+ASvYvdEuD0zpLj5qbjrwiBOr6YTpmVf
         TfG8dZ7MEgXEEbfrRHEAbObsm8CSvfK6uX3853pEj9rVOiD4OqEq5uqBVeL2+5KczOaP
         AgftJksGISMjS2R9lSmFuzvpeFrPIjapl46rZ0s/+pJ9kIi3Mu5U2Y605p1KtzM2mCIE
         NEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K9TBxxnClvyMzV16ZhiWZhbjDPodwn9kOmETXxQbBn0=;
        b=JymyMJ48gMC2iFzmJBLuRqTqfWE/HsWIm5FCUQnyMcvX5dusDR1oX9fES4L1QgrE9u
         6jyaq0/vAx4zFgT2rcK1SeGSCbjHCAx9elcbFSoBYpI/SSablVFrtKI4A94nF0wBVJI3
         A8j5EEFyHM1PcxmQl3LIMSLMIdirPQz3xtPWUeIDK/IH7+1ge/MuKREm74lvl7GdORJd
         up62qTeUrlnfE9zXsRr0p/frcYj06dgiGLaFSFNjg/d1C0mQkNcuPrMAf0OxQAkqyDfq
         Aop2QxSY9B8PaC8KzORArpG8SF2w5w4x3KVTAn3oKF2KcZ3RdPLZOr93Xg+yJJ+6IjUX
         B25Q==
X-Gm-Message-State: AOAM531htY+k79h7VeKVCBmvHAl6/nePBUvDfF87ZzSImLt31Pwbie+2
        gZBwW/Iq5xMZomBcbZ6fz/EeWK4WIOE=
X-Google-Smtp-Source: ABdhPJyvQzZ/IsfEykZ9xSmt2t1zn1ihiZRlnCMKDEOex6JvBbZaQVCUlqAt0SMMASoJh/bBSZFt1Q==
X-Received: by 2002:a1c:f20b:: with SMTP id s11mr6468306wmc.144.1600283423715;
        Wed, 16 Sep 2020 12:10:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4sm35960727wru.65.2020.09.16.12.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:10:23 -0700 (PDT)
Message-Id: <17fb8d050dae2efd84f090268095da4d04b15c88.1600283416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 19:10:11 +0000
Subject: [PATCH 08/13] reftable: a generic binary tree implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is necessary for building a OID => ref map on write

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                 |  2 ++
 reftable/tree.c          | 63 ++++++++++++++++++++++++++++++++++++++++
 reftable/tree.h          | 34 ++++++++++++++++++++++
 reftable/tree_test.c     | 62 +++++++++++++++++++++++++++++++++++++++
 t/helper/test-reftable.c |  1 +
 5 files changed, 162 insertions(+)
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/tree_test.c

diff --git a/Makefile b/Makefile
index a897818a7e..b96c235087 100644
--- a/Makefile
+++ b/Makefile
@@ -2351,12 +2351,14 @@ REFTABLE_OBJS += reftable/publicbasics.o
 REFTABLE_OBJS += reftable/compat.o
 REFTABLE_OBJS += reftable/record.o
 REFTABLE_OBJS += reftable/strbuf.o
+REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/zlib-compat.o
 
 REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/strbuf_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
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
index 0000000000..c6d448cbe8
--- /dev/null
+++ b/reftable/tree_test.c
@@ -0,0 +1,62 @@
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
+#include "reftable.h"
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
+	void *values[11] = { 0 };
+	struct tree_node *nodes[11] = { 0 };
+	int i = 1;
+	struct curry c = { 0 };
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
+	add_test_case("test_tree", &test_tree);
+	return test_main(argc, argv);
+}
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 81a9bd5667..9c4e0f42dc 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -6,5 +6,6 @@ int cmd__reftable(int argc, const char **argv)
 	block_test_main(argc, argv);
 	record_test_main(argc, argv);
 	strbuf_test_main(argc, argv);
+	tree_test_main(argc, argv);
 	return 0;
 }
-- 
gitgitgadget

