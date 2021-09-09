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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4A8C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 815AC610FF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbhIISuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245559AbhIIStO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:49:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912DFC061794
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i23so30077wrb.2
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=niytwrRovUqVYof6uia0f4Mo0aS082Xgqfh1GdEq5Tw=;
        b=RG7fdQT0j5KAGhb0wG6RB8T79gtH/IIcg57zNbGwJdH4JtbFjmQUTTdwCqSptJOjoh
         TGFlBRloBz8AYGC9tyPMyyVKVJ1E2qX56Wid5h0vKdULXvp2S/NM7ZQ2CMqpTKvqfPs0
         YDLmdubqCX2fWSUoJaCWM9cU/BxtqbhJAQ+atoqxWXMGw/ubham3mSaL9ws7V9pT7orc
         rQkkDhegcTIs9WFBt08TvtP8n0u/H34en+7wyBuxrqWWIjMXCc85WqrcqtKyjgmQ73Qo
         XTRJh5Jwbn3M17QBQEKS8IfXJ+6QT/llH7zKDliDYO5NrAoZsKfJSczsmKtHNWTExlgI
         6FIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=niytwrRovUqVYof6uia0f4Mo0aS082Xgqfh1GdEq5Tw=;
        b=PXUK8oowoSQLgqrGUhrZBuwu51lTgcXGynSGH5yMXa+kj5XD1m0fQuh98kxt6raS0O
         ZXsPI01ysszzj4aVY5PB6d8S1TNWZmoBGdAi4d53Th6oCzLeQQm3i/H5NsA245+B2Emt
         eBsQuKkZd200oiS4C87VaYPedmkMLWVoTlTomtURlmYu9xbrC4cL56Li2o/nYYF/7eTO
         VIiF3IMApwsViWRCQRzHjzJBqPySSojrCADSsfqIYtyNrVleFNJr6nfAtMloylsiFWma
         kDdar/QP7CnC37YqXDR7DwnBBWK4rfRn+gZAkhA6EgRLZD3dvcsj43l6gHRYk+bAOWg+
         wsUg==
X-Gm-Message-State: AOAM53317DoviRZob/ih94thr1awWEneYB6ICzyYouqTqIfRPm3EDPzt
        Tqf1EJE4Fsr99SGs7mICAqWksKTnzhI=
X-Google-Smtp-Source: ABdhPJyl53bnQya/hAoLL3MOn6gsUBYAiO4bRxo0sOK/2tnlaTpLZCY/8fpyzdorlb1nJAVrC6zX9A==
X-Received: by 2002:a5d:5610:: with SMTP id l16mr5003115wrv.102.1631213276155;
        Thu, 09 Sep 2021 11:47:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18sm2611466wrd.56.2021.09.09.11.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:47:55 -0700 (PDT)
Message-Id: <e9598889af27e1a585f3742be037c238779fdff9.1631213265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 18:47:41 +0000
Subject: [PATCH v2 16/19] reftable: implement refname validation
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

The packed/loose format has restrictions on refnames: a and a/b cannot
coexist. This limitation does not apply to reftable per se, but must be
maintained for interoperability. This code adds validation routines to
abort transactions that are trying to add invalid names.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                 |   1 +
 reftable/refname.c       | 209 +++++++++++++++++++++++++++++++++++++++
 reftable/refname.h       |  29 ++++++
 reftable/refname_test.c  | 102 +++++++++++++++++++
 t/helper/test-reftable.c |   1 +
 5 files changed, 342 insertions(+)
 create mode 100644 reftable/refname.c
 create mode 100644 reftable/refname.h
 create mode 100644 reftable/refname_test.c

diff --git a/Makefile b/Makefile
index 27f29779c9a..76761ef16a6 100644
--- a/Makefile
+++ b/Makefile
@@ -2478,6 +2478,7 @@ REFTABLE_TEST_OBJS += reftable/merged_test.o
 REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
+REFTABLE_TEST_OBJS += reftable/refname_test.o
 REFTABLE_TEST_OBJS += reftable/test_framework.o
 REFTABLE_TEST_OBJS += reftable/tree_test.o
 
diff --git a/reftable/refname.c b/reftable/refname.c
new file mode 100644
index 00000000000..95734969324
--- /dev/null
+++ b/reftable/refname.c
@@ -0,0 +1,209 @@
+/*
+  Copyright 2020 Google LLC
+
+  Use of this source code is governed by a BSD-style
+  license that can be found in the LICENSE file or at
+  https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "system.h"
+#include "reftable-error.h"
+#include "basics.h"
+#include "refname.h"
+#include "reftable-iterator.h"
+
+struct find_arg {
+	char **names;
+	const char *want;
+};
+
+static int find_name(size_t k, void *arg)
+{
+	struct find_arg *f_arg = arg;
+	return strcmp(f_arg->names[k], f_arg->want) >= 0;
+}
+
+static int modification_has_ref(struct modification *mod, const char *name)
+{
+	struct reftable_ref_record ref = { NULL };
+	int err = 0;
+
+	if (mod->add_len > 0) {
+		struct find_arg arg = {
+			.names = mod->add,
+			.want = name,
+		};
+		int idx = binsearch(mod->add_len, find_name, &arg);
+		if (idx < mod->add_len && !strcmp(mod->add[idx], name)) {
+			return 0;
+		}
+	}
+
+	if (mod->del_len > 0) {
+		struct find_arg arg = {
+			.names = mod->del,
+			.want = name,
+		};
+		int idx = binsearch(mod->del_len, find_name, &arg);
+		if (idx < mod->del_len && !strcmp(mod->del[idx], name)) {
+			return 1;
+		}
+	}
+
+	err = reftable_table_read_ref(&mod->tab, name, &ref);
+	reftable_ref_record_release(&ref);
+	return err;
+}
+
+static void modification_release(struct modification *mod)
+{
+	/* don't delete the strings themselves; they're owned by ref records.
+	 */
+	FREE_AND_NULL(mod->add);
+	FREE_AND_NULL(mod->del);
+	mod->add_len = 0;
+	mod->del_len = 0;
+}
+
+static int modification_has_ref_with_prefix(struct modification *mod,
+					    const char *prefix)
+{
+	struct reftable_iterator it = { NULL };
+	struct reftable_ref_record ref = { NULL };
+	int err = 0;
+
+	if (mod->add_len > 0) {
+		struct find_arg arg = {
+			.names = mod->add,
+			.want = prefix,
+		};
+		int idx = binsearch(mod->add_len, find_name, &arg);
+		if (idx < mod->add_len &&
+		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
+			goto done;
+	}
+	err = reftable_table_seek_ref(&mod->tab, &it, prefix);
+	if (err)
+		goto done;
+
+	while (1) {
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err)
+			goto done;
+
+		if (mod->del_len > 0) {
+			struct find_arg arg = {
+				.names = mod->del,
+				.want = ref.refname,
+			};
+			int idx = binsearch(mod->del_len, find_name, &arg);
+			if (idx < mod->del_len &&
+			    !strcmp(ref.refname, mod->del[idx])) {
+				continue;
+			}
+		}
+
+		if (strncmp(ref.refname, prefix, strlen(prefix))) {
+			err = 1;
+			goto done;
+		}
+		err = 0;
+		goto done;
+	}
+
+done:
+	reftable_ref_record_release(&ref);
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+static int validate_refname(const char *name)
+{
+	while (1) {
+		char *next = strchr(name, '/');
+		if (!*name) {
+			return REFTABLE_REFNAME_ERROR;
+		}
+		if (!next) {
+			return 0;
+		}
+		if (next - name == 0 || (next - name == 1 && *name == '.') ||
+		    (next - name == 2 && name[0] == '.' && name[1] == '.'))
+			return REFTABLE_REFNAME_ERROR;
+		name = next + 1;
+	}
+	return 0;
+}
+
+int validate_ref_record_addition(struct reftable_table tab,
+				 struct reftable_ref_record *recs, size_t sz)
+{
+	struct modification mod = {
+		.tab = tab,
+		.add = reftable_calloc(sizeof(char *) * sz),
+		.del = reftable_calloc(sizeof(char *) * sz),
+	};
+	int i = 0;
+	int err = 0;
+	for (; i < sz; i++) {
+		if (reftable_ref_record_is_deletion(&recs[i])) {
+			mod.del[mod.del_len++] = recs[i].refname;
+		} else {
+			mod.add[mod.add_len++] = recs[i].refname;
+		}
+	}
+
+	err = modification_validate(&mod);
+	modification_release(&mod);
+	return err;
+}
+
+static void strbuf_trim_component(struct strbuf *sl)
+{
+	while (sl->len > 0) {
+		int is_slash = (sl->buf[sl->len - 1] == '/');
+		strbuf_setlen(sl, sl->len - 1);
+		if (is_slash)
+			break;
+	}
+}
+
+int modification_validate(struct modification *mod)
+{
+	struct strbuf slashed = STRBUF_INIT;
+	int err = 0;
+	int i = 0;
+	for (; i < mod->add_len; i++) {
+		err = validate_refname(mod->add[i]);
+		if (err)
+			goto done;
+		strbuf_reset(&slashed);
+		strbuf_addstr(&slashed, mod->add[i]);
+		strbuf_addstr(&slashed, "/");
+
+		err = modification_has_ref_with_prefix(mod, slashed.buf);
+		if (err == 0) {
+			err = REFTABLE_NAME_CONFLICT;
+			goto done;
+		}
+		if (err < 0)
+			goto done;
+
+		strbuf_reset(&slashed);
+		strbuf_addstr(&slashed, mod->add[i]);
+		while (slashed.len) {
+			strbuf_trim_component(&slashed);
+			err = modification_has_ref(mod, slashed.buf);
+			if (err == 0) {
+				err = REFTABLE_NAME_CONFLICT;
+				goto done;
+			}
+			if (err < 0)
+				goto done;
+		}
+	}
+	err = 0;
+done:
+	strbuf_release(&slashed);
+	return err;
+}
diff --git a/reftable/refname.h b/reftable/refname.h
new file mode 100644
index 00000000000..a24b40fcb42
--- /dev/null
+++ b/reftable/refname.h
@@ -0,0 +1,29 @@
+/*
+  Copyright 2020 Google LLC
+
+  Use of this source code is governed by a BSD-style
+  license that can be found in the LICENSE file or at
+  https://developers.google.com/open-source/licenses/bsd
+*/
+#ifndef REFNAME_H
+#define REFNAME_H
+
+#include "reftable-record.h"
+#include "reftable-generic.h"
+
+struct modification {
+	struct reftable_table tab;
+
+	char **add;
+	size_t add_len;
+
+	char **del;
+	size_t del_len;
+};
+
+int validate_ref_record_addition(struct reftable_table tab,
+				 struct reftable_ref_record *recs, size_t sz);
+
+int modification_validate(struct modification *mod);
+
+#endif
diff --git a/reftable/refname_test.c b/reftable/refname_test.c
new file mode 100644
index 00000000000..8645cd93bbd
--- /dev/null
+++ b/reftable/refname_test.c
@@ -0,0 +1,102 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "basics.h"
+#include "block.h"
+#include "blocksource.h"
+#include "constants.h"
+#include "reader.h"
+#include "record.h"
+#include "refname.h"
+#include "reftable-error.h"
+#include "reftable-writer.h"
+#include "system.h"
+
+#include "test_framework.h"
+#include "reftable-tests.h"
+
+struct testcase {
+	char *add;
+	char *del;
+	int error_code;
+};
+
+static void test_conflict(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+	struct reftable_ref_record rec = {
+		.refname = "a/b",
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = "destination", /* make sure it's not a symref.
+						*/
+		.update_index = 1,
+	};
+	int err;
+	int i;
+	struct reftable_block_source source = { NULL };
+	struct reftable_reader *rd = NULL;
+	struct reftable_table tab = { NULL };
+	struct testcase cases[] = {
+		{ "a/b/c", NULL, REFTABLE_NAME_CONFLICT },
+		{ "b", NULL, 0 },
+		{ "a", NULL, REFTABLE_NAME_CONFLICT },
+		{ "a", "a/b", 0 },
+
+		{ "p/", NULL, REFTABLE_REFNAME_ERROR },
+		{ "p//q", NULL, REFTABLE_REFNAME_ERROR },
+		{ "p/./q", NULL, REFTABLE_REFNAME_ERROR },
+		{ "p/../q", NULL, REFTABLE_REFNAME_ERROR },
+
+		{ "a/b/c", "a/b", 0 },
+		{ NULL, "a//b", 0 },
+	};
+	reftable_writer_set_limits(w, 1, 1);
+
+	err = reftable_writer_add_ref(w, &rec);
+	EXPECT_ERR(err);
+
+	err = reftable_writer_close(w);
+	EXPECT_ERR(err);
+	reftable_writer_free(w);
+
+	block_source_from_strbuf(&source, &buf);
+	err = reftable_new_reader(&rd, &source, "filename");
+	EXPECT_ERR(err);
+
+	reftable_table_from_reader(&tab, rd);
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct modification mod = {
+			.tab = tab,
+		};
+
+		if (cases[i].add) {
+			mod.add = &cases[i].add;
+			mod.add_len = 1;
+		}
+		if (cases[i].del) {
+			mod.del = &cases[i].del;
+			mod.del_len = 1;
+		}
+
+		err = modification_validate(&mod);
+		EXPECT(err == cases[i].error_code);
+	}
+
+	reftable_reader_free(rd);
+	strbuf_release(&buf);
+}
+
+int refname_test_main(int argc, const char *argv[])
+{
+	RUN_TEST(test_conflict);
+	return 0;
+}
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 8087f2da4e6..c8db6852c35 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -8,6 +8,7 @@ int cmd__reftable(int argc, const char **argv)
 	merged_test_main(argc, argv);
 	pq_test_main(argc, argv);
 	record_test_main(argc, argv);
+	refname_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
 	tree_test_main(argc, argv);
 	return 0;
-- 
gitgitgadget

