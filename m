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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62380C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D9AB61100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343631AbhIISt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245352AbhIIStL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:49:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5965DC0613F0
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n5so3929683wro.12
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NqfiJsyECBc1PhDMJ1UiCYytYgX6tG6TloGUqDwSNms=;
        b=OLxcQcWTxWND7xCoHVCRdv1GoF6/oXIcoJQTylb2gHVoE91HOsOPTkmlHM9fMn8U4L
         LbCYuTEjkJNbqlU0rV1BKes2Hb1QWJygdCjhWCNq9Kv04NSiLLYnqSvKvDJM5YQx6u9+
         4/1sfcQ28/4qKy+sCYvNp9M8n4iXAkibq+bfeIRdB+V23cWTXzYSO39V7mi7aIRBc4JA
         xhkT6tPUbXkaISOreXaRdRYyqywI07mx5Dq6IMSkUaurKUrslB+cc5up3Pc60PRi558n
         wB7SE7C7GfHIPtDi/rbW0yLBjcgzkOaOLugTdrdOYxJ1tDJ0L2ITLZOWSMe7LsFlKZ/j
         NF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NqfiJsyECBc1PhDMJ1UiCYytYgX6tG6TloGUqDwSNms=;
        b=7qlGEAtnVOg1EzE+x/71VppWppzSawgt9LX9ScGmIm16ldvCallxqaABeLOx+sBSQY
         /Eg9AA/wGRPh+NSO/aBJMzJ8FQ7lEQJo3UsyDA3rClgijSesle6eWksAGkv3O6T9yEe1
         UvxAJ2WsRCOHs3WXozJgj6Kh408uyxmWWSB9Md63eponOkUuhs1GVR1FyhV9wczHBMBH
         A/7EJ4uKcSJw4JIHuwmiqx9eBWDeufH57LYbq1a3r2KcfzLya2xVCgIdkE9RtiUFc74H
         Fdfg0fNYMvjT4uEAcnW8ghsxDbCWmlR6X7DsJWdEHeTeJ41kf9nAfo/+Kk5UKrTaQZwv
         /DyQ==
X-Gm-Message-State: AOAM530n2RScmC8iVH1jEWd0qjHLp0TAuPGOWa16gYN+kU/drUrHUkOF
        R2CrjEEk4XQcHhoJocHu5u875Rzt65w=
X-Google-Smtp-Source: ABdhPJxduJzMebf/ne3vdH1CRLkl5pSMj0nTaroQgVysYF6s/gBBb933riSdCSnvHVzNNer/E99kYw==
X-Received: by 2002:a5d:528b:: with SMTP id c11mr5250556wrv.369.1631213274933;
        Thu, 09 Sep 2021 11:47:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16sm2816960wrh.44.2021.09.09.11.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:47:54 -0700 (PDT)
Message-Id: <5a5c108d601ef6904f74597889deb09f8009c695.1631213265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 18:47:39 +0000
Subject: [PATCH v2 14/19] reftable: add a heap-based priority queue for
 reftable records
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

This is needed to create a merged view multiple reftables

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                  |   2 +
 reftable/pq.c             | 105 ++++++++++++++++++++++++++++++++++++++
 reftable/pq.h             |  33 ++++++++++++
 reftable/pq_test.c        |  82 +++++++++++++++++++++++++++++
 reftable/reftable-tests.h |   1 +
 t/helper/test-reftable.c  |   1 +
 6 files changed, 224 insertions(+)
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/pq_test.c

diff --git a/Makefile b/Makefile
index 1c0bb449027..d2c9b0097a7 100644
--- a/Makefile
+++ b/Makefile
@@ -2462,6 +2462,7 @@ REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/iter.o
 REFTABLE_OBJS += reftable/publicbasics.o
+REFTABLE_OBJS += reftable/pq.o
 REFTABLE_OBJS += reftable/reader.o
 REFTABLE_OBJS += reftable/record.o
 REFTABLE_OBJS += reftable/refname.o
@@ -2472,6 +2473,7 @@ REFTABLE_OBJS += reftable/writer.o
 
 REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
diff --git a/reftable/pq.c b/reftable/pq.c
new file mode 100644
index 00000000000..efc474017a2
--- /dev/null
+++ b/reftable/pq.c
@@ -0,0 +1,105 @@
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
+int pq_less(struct pq_entry *a, struct pq_entry *b)
+{
+	struct strbuf ak = STRBUF_INIT;
+	struct strbuf bk = STRBUF_INIT;
+	int cmp = 0;
+	reftable_record_key(&a->rec, &ak);
+	reftable_record_key(&b->rec, &bk);
+
+	cmp = strbuf_cmp(&ak, &bk);
+
+	strbuf_release(&ak);
+	strbuf_release(&bk);
+
+	if (cmp == 0)
+		return a->index > b->index;
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
+		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i])) {
+			min = j;
+		}
+		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min])) {
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
+		if (pq_less(&pq->heap[j], &pq->heap[i])) {
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
index 00000000000..56fc1b6d873
--- /dev/null
+++ b/reftable/pq.h
@@ -0,0 +1,33 @@
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
+int pq_less(struct pq_entry *a, struct pq_entry *b);
+
+#endif
diff --git a/reftable/pq_test.c b/reftable/pq_test.c
new file mode 100644
index 00000000000..aaa86d12247
--- /dev/null
+++ b/reftable/pq_test.c
@@ -0,0 +1,82 @@
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
+void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
+{
+	int i = 0;
+	for (i = 1; i < pq.len; i++) {
+		int parent = (i - 1) / 2;
+
+		assert(pq_less(&pq.heap[parent], &pq.heap[i]));
+	}
+}
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
+			EXPECT(strcmp(last, ref->refname) < 0);
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
@@ -12,6 +12,7 @@ https://developers.google.com/open-source/licenses/bsd
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
gitgitgadget

