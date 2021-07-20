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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55E2C636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53EA610CC
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhGTQ0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbhGTQYW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:24:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D3BC0613E1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:04:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a13so26749495wrf.10
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EzSvWhD664LH+f880EJGnAsq5NbF3QbDTpvtbtbxoLY=;
        b=LsX1/UV8Zd8lTeUGgeJxKgy0eqwA6wCjycKTtoHC2s2WyFGvjmyBzE/Ev6mIk26ir0
         4ivsSAZB+viz08oN4Hsji/MQJ+GmHRXe8hyxO4HVVJUVce8GezihAn5cUbzyE7ssspoY
         Fq2fkErCZxisrtV+IfPcyGY71RxB6y6Wj2T0WcfVa6TMr3rACdOpIalbpajmJSBQVb/4
         /272EF38JFHCiz2qq/FsDHGWBOhbZ3chgTrdzZmmTWG5+7nDz1WAWW7TuBgYkl9qoBjl
         BRjpMkvcUD2j2noTb29A7CA4U60LS62RmveG2V3z5DyCUR4ci+sUKGif6PqUaWcPpz5l
         9nkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EzSvWhD664LH+f880EJGnAsq5NbF3QbDTpvtbtbxoLY=;
        b=JDfmegno9M1zkxZiLUZmpgtMtMBYTkPlMgvSHQ+rOwtGiQ7QtCDVnSGaNEQ+4Wn7Gd
         v46/eqxvMZJTK2VCPGk4WOfcs85uJ1bfhrpXQZPfR4OGR5D1irOOMDodf5TySLsHP9Vf
         y0lQ2U88XZ4Q0cZkh16ukSBLGVjlAHUb7ti9Bn3bLuabRbu0GqoyEFtcl6+qSCG0LcPu
         0u+N9rmLAEAJTLJe5ZjD/PzzGNM/tsKKkTM6ELM527CFGM1saRvglOV3bbaijEfOERHM
         naPFfaSjk0XDu3WzmXMXqhfDS2N9aGC3O3lH07GUSzjmw/8LedcHEji4i3suQUkqBGJc
         5ACg==
X-Gm-Message-State: AOAM5326VpEZ15dIHQhcoy6jPgYYOFUaEtKYv1eMU8zwr9LzuP7PSMIp
        6AOsg2LBaj6+03dDj26B5Wr2wR9Di9w=
X-Google-Smtp-Source: ABdhPJwFhhxacQpBlfhwXZMRTvPstOubEMXqF+0C3gHU3Dt7a6rSOdZPcvDQrNEVN5uVHZbjKw4iqA==
X-Received: by 2002:adf:ed07:: with SMTP id a7mr38628085wro.70.1626800697890;
        Tue, 20 Jul 2021 10:04:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q81sm3427905wme.18.2021.07.20.10.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:04:57 -0700 (PDT)
Message-Id: <4d7745e65529c3e77cc6d016ca75084e265c96fb.1626800687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 17:04:35 +0000
Subject: [PATCH 15/26] reftable: add a heap-based priority queue for reftable
 records
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
index 235d30b55d6..2123aa782c9 100644
--- a/Makefile
+++ b/Makefile
@@ -2454,6 +2454,7 @@ REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/iter.o
 REFTABLE_OBJS += reftable/publicbasics.o
+REFTABLE_OBJS += reftable/pq.o
 REFTABLE_OBJS += reftable/reader.o
 REFTABLE_OBJS += reftable/record.o
 REFTABLE_OBJS += reftable/refname.o
@@ -2464,6 +2465,7 @@ REFTABLE_OBJS += reftable/writer.o
 
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

