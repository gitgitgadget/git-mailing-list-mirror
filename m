Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3D0C47420
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 16:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4368207FB
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 16:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBJj5Ctt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbgJAQLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 12:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732563AbgJAQLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 12:11:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC96C0613E5
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 09:11:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k10so6471503wru.6
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 09:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CAxBc0W6ghad+vh4fzTR8OgfCYrRc5AAVlVzk0uAjCg=;
        b=vBJj5CttCGrE+LX9L1ZClo+IOsM44v/KtCJVjXydR8cJRpmxol7AlxUmLmr0aNZPPL
         1zedo+iDb7Q4/UWhQHJ3S/0l6HiewkjAmVk1fIH9rsLOD138xfW9q9ZlAOCiDVEyTxyq
         cW4/QvwOMqvPtDlMAJqFYU4rGJrBg+pioB+sif2FfdOQZkiqqCv6eUdFct+Gb5CVhxYU
         +/b9wucId9RIsM4BCi4PeFRHGUIT+b5LX4TbLTn3wy+wgP8qjNwmGW1xOKCPa8NcMkGO
         ClsYqX/5Fx81qABcnDsnZtkbn/xCNAunG+jsXt/WRVP7477hPXdXOrgbPGhh72+COejj
         AU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CAxBc0W6ghad+vh4fzTR8OgfCYrRc5AAVlVzk0uAjCg=;
        b=STkQs0uEOijGy9CPPDO5+O6L0aDBUuiF2oZ2KrwoufwhuD64Fgh9ONUA+9OVGmyZRw
         A5tOAXHpqh5pUzahaN80eKuVGXdOsNdeb9rqza0SIrjWpUGSCIky7hTBl43qwLEZu3sj
         VwtxKWyw3NcW8L4R189Sint2Ym3Jam4h0AuDzkcLEvuL0xVpWwEOlG0sLnsPza+v6O5V
         aLSiTAmQOlsW8a0qVLHRI0gbc7Y4bSEI1RxHUIeN/0T562X90+O0c71srsDglHTARo9a
         0KV/J5B7ALUOKuDSzcUQbMx6GlNc7KabANlqXPACVeUnECHznhPNPN2Rzu4NrQtYVmK3
         LC1w==
X-Gm-Message-State: AOAM532HMX9YUqP3ZJYvLedwHcTTJnYK0m6nxdL6c/u9ohbKQxwUepTE
        fU+XUKayoth9a/LmX1Eptq6w78fBsM0=
X-Google-Smtp-Source: ABdhPJyAkrxqTqsjL/MuBlR47aBwI4KxY4n0jWMCu0aI4WRBcMp0Oy0VKXaCO2h1kVzZeiBzLW3SCQ==
X-Received: by 2002:adf:eb04:: with SMTP id s4mr10571562wrn.81.1601568674291;
        Thu, 01 Oct 2020 09:11:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm561761wmj.45.2020.10.01.09.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 09:11:12 -0700 (PDT)
Message-Id: <e30a7e02815121eeba34d7f27b352f675a7d9f60.1601568664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
        <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Oct 2020 16:10:58 +0000
Subject: [PATCH v2 08/13] reftable: a generic binary tree implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
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
index eda92b00ef..870e540f22 100644
--- a/Makefile
+++ b/Makefile
@@ -2379,12 +2379,14 @@ REFTABLE_OBJS += reftable/publicbasics.o
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
index 0000000000..320fd02a0f
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

