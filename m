Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D0CC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097876137B
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhHWMOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbhHWMNw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:13:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A2BC06129E
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k29so25950108wrd.7
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f51ANSugqYp8XtuY5eD6+ttxCxJ1SCPnKfoLtNn44f0=;
        b=p1EmCcbNkIOzj7awbXFtBgLu182yAPbXkzrXvo/95os0g4+ZG/JhfXPW/YcTm/iuDA
         5Zd6F2TF+4aQ/zx3Bt/A3XFNqF+19bw//0OoWNKa1ZLrPfpITqf3RYlo3HsUAQR5Qw9D
         W+KZJd+ULvgsbtPH+9yr08kra3fwvVc9XGpDXaMPRwuit4fxII7KCDAhtIBoJef2zhF4
         Dzas6hNnOiLcVKYDbNSlCor9guV41mnfm42Moyy4IQp6loZ4Kcl/cld3hc+chn5mUpW3
         ssIG8vPAw94euVe3Q5G+uI9RP3pw8LajYRGvD2LSiKxYmKolq//1EQCbcIeoGOv7FIu/
         ZuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f51ANSugqYp8XtuY5eD6+ttxCxJ1SCPnKfoLtNn44f0=;
        b=HTVfNQt5qJAdqTWQyYeFOcHvbMdC7hrDuB/Z7QdLiPGkWgscW+xJfv+RwU0xXpRP5B
         KRAuXp5CZlaf89sLtlwuIwp+Q2k1j/p9YTyjTxEjXnmrfw5X5UPotaE6BiaardR1RaQB
         zRWx9Z8ThpimHcbfCq+VgiQa4HNT56wAf8/POTypIgoaDT/a+qNNx5PbPF/76dGDVrEo
         jpHEphlAPu7GlyBPeEDiCjR7DmCFouU77+0TzKU9/wdR6LCyRPilFqJs74IVv65nrfoc
         +TNHQzTAxtDPAjurUcD7NUp6fry55PN2Wp+73eS/l5n3oRNeONe+7cqYtqpdWdU3WJJw
         OMXw==
X-Gm-Message-State: AOAM53100F9icwT7c8zaW5v7xJ9CwXWzXV/QdjFkAF8LHjYbxYHlULYs
        fVKwEwxh4bc40LHkhv6tP2gtmqXVUN5PV/kK
X-Google-Smtp-Source: ABdhPJxIcTLZab7qGHIDyf99WqBqNGe9WWsykX6SDzw04F57Pous/yK2F4vciTCaBmGM4Gc3u7utDQ==
X-Received: by 2002:a5d:45c2:: with SMTP id b2mr12941909wrs.188.1629720788223;
        Mon, 23 Aug 2021 05:13:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:13:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 15/28] reftable: add a heap-based priority queue for reftable records
Date:   Mon, 23 Aug 2021 14:12:26 +0200
Message-Id: <patch-v4-15.28-a9880fc1a10-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is needed to create a merged view multiple reftables

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                  |   2 +
 reftable/pq.c             | 115 ++++++++++++++++++++++++++++++++++++++
 reftable/pq.h             |  32 +++++++++++
 reftable/pq_test.c        |  72 ++++++++++++++++++++++++
 reftable/reftable-tests.h |   1 +
 t/helper/test-reftable.c  |   1 +
 6 files changed, 223 insertions(+)
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/pq_test.c

diff --git a/Makefile b/Makefile
index 5e2ff446894..744a63b9d2c 100644
--- a/Makefile
+++ b/Makefile
@@ -2458,6 +2458,7 @@ REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/iter.o
 REFTABLE_OBJS += reftable/publicbasics.o
+REFTABLE_OBJS += reftable/pq.o
 REFTABLE_OBJS += reftable/reader.o
 REFTABLE_OBJS += reftable/record.o
 REFTABLE_OBJS += reftable/refname.o
@@ -2468,6 +2469,7 @@ REFTABLE_OBJS += reftable/writer.o
 
 REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
diff --git a/reftable/pq.c b/reftable/pq.c
new file mode 100644
index 00000000000..8918d158e2d
--- /dev/null
+++ b/reftable/pq.c
@@ -0,0 +1,115 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "pq.h"
+
+#include "reftable-record.h"
+#include "system.h"
+#include "basics.h"
+
+static int pq_less(struct pq_entry a, struct pq_entry b)
+{
+	struct strbuf ak = STRBUF_INIT;
+	struct strbuf bk = STRBUF_INIT;
+	int cmp = 0;
+	reftable_record_key(&a.rec, &ak);
+	reftable_record_key(&b.rec, &bk);
+
+	cmp = strbuf_cmp(&ak, &bk);
+
+	strbuf_release(&ak);
+	strbuf_release(&bk);
+
+	if (cmp == 0)
+		return a.index > b.index;
+
+	return cmp < 0;
+}
+
+struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq)
+{
+	return pq.heap[0];
+}
+
+int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq)
+{
+	return pq.len == 0;
+}
+
+void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
+{
+	int i = 0;
+	for (i = 1; i < pq.len; i++) {
+		int parent = (i - 1) / 2;
+
+		assert(pq_less(pq.heap[parent], pq.heap[i]));
+	}
+}
+
+struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
+{
+	int i = 0;
+	struct pq_entry e = pq->heap[0];
+	pq->heap[0] = pq->heap[pq->len - 1];
+	pq->len--;
+
+	i = 0;
+	while (i < pq->len) {
+		int min = i;
+		int j = 2 * i + 1;
+		int k = 2 * i + 2;
+		if (j < pq->len && pq_less(pq->heap[j], pq->heap[i])) {
+			min = j;
+		}
+		if (k < pq->len && pq_less(pq->heap[k], pq->heap[min])) {
+			min = k;
+		}
+
+		if (min == i) {
+			break;
+		}
+
+		SWAP(pq->heap[i], pq->heap[min]);
+		i = min;
+	}
+
+	return e;
+}
+
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e)
+{
+	int i = 0;
+	if (pq->len == pq->cap) {
+		pq->cap = 2 * pq->cap + 1;
+		pq->heap = reftable_realloc(pq->heap,
+					    pq->cap * sizeof(struct pq_entry));
+	}
+
+	pq->heap[pq->len++] = e;
+	i = pq->len - 1;
+	while (i > 0) {
+		int j = (i - 1) / 2;
+		if (pq_less(pq->heap[j], pq->heap[i])) {
+			break;
+		}
+
+		SWAP(pq->heap[j], pq->heap[i]);
+
+		i = j;
+	}
+}
+
+void merged_iter_pqueue_release(struct merged_iter_pqueue *pq)
+{
+	int i = 0;
+	for (i = 0; i < pq->len; i++) {
+		reftable_record_destroy(&pq->heap[i].rec);
+	}
+	FREE_AND_NULL(pq->heap);
+	pq->len = pq->cap = 0;
+}
diff --git a/reftable/pq.h b/reftable/pq.h
new file mode 100644
index 00000000000..385d2fb139a
--- /dev/null
+++ b/reftable/pq.h
@@ -0,0 +1,32 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef PQ_H
+#define PQ_H
+
+#include "record.h"
+
+struct pq_entry {
+	int index;
+	struct reftable_record rec;
+};
+
+struct merged_iter_pqueue {
+	struct pq_entry *heap;
+	size_t len;
+	size_t cap;
+};
+
+struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq);
+int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq);
+void merged_iter_pqueue_check(struct merged_iter_pqueue pq);
+struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e);
+void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
+
+#endif
diff --git a/reftable/pq_test.c b/reftable/pq_test.c
new file mode 100644
index 00000000000..ad21673e854
--- /dev/null
+++ b/reftable/pq_test.c
@@ -0,0 +1,72 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "system.h"
+
+#include "basics.h"
+#include "constants.h"
+#include "pq.h"
+#include "record.h"
+#include "reftable-tests.h"
+#include "test_framework.h"
+
+static void test_pq(void)
+{
+	char *names[54] = { NULL };
+	int N = ARRAY_SIZE(names) - 1;
+
+	struct merged_iter_pqueue pq = { NULL };
+	const char *last = NULL;
+
+	int i = 0;
+	for (i = 0; i < N; i++) {
+		char name[100];
+		snprintf(name, sizeof(name), "%02d", i);
+		names[i] = xstrdup(name);
+	}
+
+	i = 1;
+	do {
+		struct reftable_record rec =
+			reftable_new_record(BLOCK_TYPE_REF);
+		struct pq_entry e = { 0 };
+
+		reftable_record_as_ref(&rec)->refname = names[i];
+		e.rec = rec;
+		merged_iter_pqueue_add(&pq, e);
+		merged_iter_pqueue_check(pq);
+		i = (i * 7) % N;
+	} while (i != 1);
+
+	while (!merged_iter_pqueue_is_empty(pq)) {
+		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+		struct reftable_ref_record *ref =
+			reftable_record_as_ref(&e.rec);
+
+		merged_iter_pqueue_check(pq);
+
+		if (last) {
+			assert(strcmp(last, ref->refname) < 0);
+		}
+		last = ref->refname;
+		ref->refname = NULL;
+		reftable_free(ref);
+	}
+
+	for (i = 0; i < N; i++) {
+		reftable_free(names[i]);
+	}
+
+	merged_iter_pqueue_release(&pq);
+}
+
+int pq_test_main(int argc, const char *argv[])
+{
+	RUN_TEST(test_pq);
+	return 0;
+}
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index 3d541fa5c0c..0019cbcfa49 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -12,6 +12,7 @@ license that can be found in the LICENSE file or at
 int basics_test_main(int argc, const char **argv);
 int block_test_main(int argc, const char **argv);
 int merged_test_main(int argc, const char **argv);
+int pq_test_main(int argc, const char **argv);
 int record_test_main(int argc, const char **argv);
 int refname_test_main(int argc, const char **argv);
 int readwrite_test_main(int argc, const char **argv);
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 898aba836fd..0b5a1701df1 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -5,6 +5,7 @@ int cmd__reftable(int argc, const char **argv)
 {
 	basics_test_main(argc, argv);
 	block_test_main(argc, argv);
+	pq_test_main(argc, argv);
 	record_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
 	tree_test_main(argc, argv);
-- 
2.33.0.662.gbaddc25a55e

