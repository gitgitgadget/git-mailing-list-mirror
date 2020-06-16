Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7421CC433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D8F20776
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7brNVHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbgFPTVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbgFPTU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:20:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD103C061755
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so21966577wru.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jxeLNbvjxI9czDM/P3o7kTqJWm8wwTkkCRnHOc3t/Ok=;
        b=U7brNVHdjd26q23b1UDIdKeBPmEjs1BPlCsDFKlc5rxOiEYGjtqDZUlajLuSN/FEBZ
         ST2nb6GphutkfgPCuDrfHwsSDv4oYqzrTGXmsVUsIPAq3gkag8PDAhvgLMFGAzsWXY1c
         IaTaq82pVuINnTJ1AJ7U+YQ6LfvtGJ1bOjnjG/PNPBaWuEktYsRffJvjEyd0XyRFTVQo
         /OMX8/8/5ClbKuQL7zPTcXyo1ciC0ulWtKBnmVNdQo0qS7XNlFK1HtewuAHbG1ROtRzu
         Lhn4iRRzvJx6KjM3IfF62iRwAcCrTaoGHS6U47ls3jQXkweYc1hC/DE4kLJR6eMjz7Q9
         Hs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jxeLNbvjxI9czDM/P3o7kTqJWm8wwTkkCRnHOc3t/Ok=;
        b=JvYTPUlm5THvNAenAdZti77a4+k276UCyhhl+NC7U7COJ7b7y7ZXTdvhg36lVeVxmt
         yn6yaz/KbTQS/nyAYEp/7JBALNyJjtuZ09oMlw4Uh5EeTze9r9t3cScfEOF/g9lP1+/9
         t5EK8DBfFQUDkye/KEghCeEWJ6CQp9qXpGKpdruoNWXxammQdXYnu3v0I2/7NIy2fDdH
         jnmmu6JPCDYAZNsk3tZYJ7gqTiebM9WXBqDLH2Wr9NNFeNpsqX7+7DW2c8Aj+zb4cANU
         LoE8ALIrHOxoxbZF9cw3fxD5RnmkRMQoAT/Jxn+X23nAcbMYmNBMMZUW7ZHpQzD2JTHJ
         ibOg==
X-Gm-Message-State: AOAM530xkftZeNnz+Cm2o/JlcCIuMdUSX28fUZxZKU8YyT14lYuK4bYh
        ayzodMzQ8vq6b18qahmOgO/FTN0X
X-Google-Smtp-Source: ABdhPJy6z+A0DBd3it7jj+fIK2QRYxujSElDhc6ugMKV7l733ZPR+vbXsf5K9amFlePOYffVxUPjHw==
X-Received: by 2002:adf:e887:: with SMTP id d7mr4525423wrm.62.1592335257095;
        Tue, 16 Jun 2020 12:20:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm5277490wmg.38.2020.06.16.12.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 12:20:56 -0700 (PDT)
Message-Id: <88640ea13f92e9b24458d1de3188bf7233ba166d.1592335243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
References: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
        <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 19:20:39 +0000
Subject: [PATCH v17 14/17] Add GIT_DEBUG_REFS debugging mechanism
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

When set in the environment, GIT_DEBUG_REFS makes git print operations and
results as they flow through the ref storage backend. This helps debug
discrepancies between different ref backends.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile              |   1 +
 refs.c                |   3 +
 refs/debug.c          | 358 ++++++++++++++++++++++++++++++++++++++++++
 refs/refs-internal.h  |   6 +
 t/t0033-debug-refs.sh |  18 +++
 5 files changed, 386 insertions(+)
 create mode 100644 refs/debug.c
 create mode 100755 t/t0033-debug-refs.sh

diff --git a/Makefile b/Makefile
index feb2e52ad22..9c71bbdcbb8 100644
--- a/Makefile
+++ b/Makefile
@@ -961,6 +961,7 @@ LIB_OBJS += rebase.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
+LIB_OBJS += refs/debug.o
 LIB_OBJS += refs/files-backend.o
 LIB_OBJS += refs/reftable-backend.o
 LIB_OBJS += refs/iterator.o
diff --git a/refs.c b/refs.c
index 4409080dfd8..bd1f3cc0e45 100644
--- a/refs.c
+++ b/refs.c
@@ -1750,6 +1750,9 @@ struct ref_store *get_main_ref_store(struct repository *r)
 						 r->ref_storage_format :
 						 DEFAULT_REF_STORAGE,
 					 REF_STORE_ALL_CAPS);
+	if (getenv("GIT_DEBUG_REFS")) {
+		r->refs_private = debug_wrap(r->refs_private);
+	}
 	return r->refs_private;
 }
 
diff --git a/refs/debug.c b/refs/debug.c
new file mode 100644
index 00000000000..c33e684f5fc
--- /dev/null
+++ b/refs/debug.c
@@ -0,0 +1,358 @@
+
+#include "refs-internal.h"
+
+struct debug_ref_store {
+	struct ref_store base;
+	struct ref_store *refs;
+};
+
+extern struct ref_storage_be refs_be_debug;
+struct ref_store *debug_wrap(struct ref_store *store);
+
+struct ref_store *debug_wrap(struct ref_store *store)
+{
+	struct debug_ref_store *res = malloc(sizeof(struct debug_ref_store));
+	res->refs = store;
+	base_ref_store_init((struct ref_store *)res, &refs_be_debug);
+	return (struct ref_store *)res;
+}
+
+static int debug_init_db(struct ref_store *refs, struct strbuf *err)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
+	int res = drefs->refs->be->init_db(drefs->refs, err);
+	return res;
+}
+
+static int debug_transaction_prepare(struct ref_store *refs,
+				     struct ref_transaction *transaction,
+				     struct strbuf *err)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
+	int res;
+	transaction->ref_store = drefs->refs;
+	res = drefs->refs->be->transaction_prepare(drefs->refs, transaction,
+						   err);
+	return res;
+}
+
+static void print_update(int i, const char *refname,
+			 const struct object_id *old_oid,
+			 const struct object_id *new_oid, unsigned int flags,
+			 unsigned int type, const char *msg)
+{
+	char o[200] = "null";
+	char n[200] = "null";
+	if (old_oid)
+		oid_to_hex_r(o, old_oid);
+	if (new_oid)
+		oid_to_hex_r(n, new_oid);
+
+	type &= 0xf; /* see refs.h REF_* */
+	flags &= REF_HAVE_NEW | REF_HAVE_OLD | REF_NO_DEREF |
+		 REF_FORCE_CREATE_REFLOG | REF_LOG_ONLY;
+	printf("%d: %s %s -> %s (F=0x%x, T=0x%x) \"%s\"\n", i, refname, o, n,
+	       flags, type, msg);
+}
+
+static void print_transaction(struct ref_transaction *transaction)
+{
+	printf("transaction {\n");
+	for (int i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = transaction->updates[i];
+		print_update(i, u->refname, &u->old_oid, &u->new_oid, u->flags,
+			     u->type, u->msg);
+	}
+	printf("}\n");
+}
+
+static int debug_transaction_finish(struct ref_store *refs,
+				    struct ref_transaction *transaction,
+				    struct strbuf *err)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
+	int res;
+	transaction->ref_store = drefs->refs;
+	res = drefs->refs->be->transaction_finish(drefs->refs, transaction,
+						  err);
+	print_transaction(transaction);
+	printf("finish: %d\n", res);
+	return res;
+}
+
+static int debug_transaction_abort(struct ref_store *refs,
+				   struct ref_transaction *transaction,
+				   struct strbuf *err)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
+	int res;
+	transaction->ref_store = drefs->refs;
+	res = drefs->refs->be->transaction_abort(drefs->refs, transaction, err);
+	return res;
+}
+
+static int debug_initial_transaction_commit(struct ref_store *refs,
+					    struct ref_transaction *transaction,
+					    struct strbuf *err)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
+	int res;
+	transaction->ref_store = drefs->refs;
+	res = drefs->refs->be->initial_transaction_commit(drefs->refs,
+							  transaction, err);
+	return res;
+}
+
+static int debug_pack_refs(struct ref_store *ref_store, unsigned int flags)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->pack_refs(drefs->refs, flags);
+	return res;
+}
+
+static int debug_create_symref(struct ref_store *ref_store,
+			       const char *ref_name, const char *target,
+			       const char *logmsg)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->create_symref(drefs->refs, ref_name, target,
+						 logmsg);
+	printf("create_symref: %s -> %s \"%s\": %d\n", ref_name, target, logmsg,
+	       res);
+	return res;
+}
+
+static int debug_delete_refs(struct ref_store *ref_store, const char *msg,
+			     struct string_list *refnames, unsigned int flags)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res =
+		drefs->refs->be->delete_refs(drefs->refs, msg, refnames, flags);
+	return res;
+}
+
+static int debug_rename_ref(struct ref_store *ref_store, const char *oldref,
+			    const char *newref, const char *logmsg)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->rename_ref(drefs->refs, oldref, newref,
+					      logmsg);
+	printf("rename_ref: %s -> %s \"%s\": %d\n", oldref, newref, logmsg,
+	       res);
+	return res;
+}
+
+static int debug_copy_ref(struct ref_store *ref_store, const char *oldref,
+			  const char *newref, const char *logmsg)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res =
+		drefs->refs->be->copy_ref(drefs->refs, oldref, newref, logmsg);
+	printf("copy_ref: %s -> %s \"%s\": %d\n", oldref, newref, logmsg, res);
+	return res;
+}
+
+static int debug_write_pseudoref(struct ref_store *ref_store,
+				 const char *pseudoref,
+				 const struct object_id *oid,
+				 const struct object_id *old_oid,
+				 struct strbuf *err)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->write_pseudoref(drefs->refs, pseudoref, oid,
+						   old_oid, err);
+	char o[100] = "null";
+	char n[100] = "null";
+	if (oid)
+		oid_to_hex_r(o, oid);
+	if (old_oid)
+		oid_to_hex_r(n, old_oid);
+	printf("write_pseudoref: %s, %s => %s, err %s: %d\n", pseudoref, o, n,
+	       err->buf, res);
+	return res;
+}
+
+static int debug_delete_pseudoref(struct ref_store *ref_store,
+				  const char *pseudoref,
+				  const struct object_id *old_oid)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->delete_pseudoref(drefs->refs, pseudoref,
+						    old_oid);
+	char hex[100] = "null";
+	if (old_oid)
+		oid_to_hex_r(hex, old_oid);
+	printf("delete_pseudoref: %s (%s): %d\n", pseudoref, hex, res);
+	return res;
+}
+
+static struct ref_iterator *
+debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
+			 unsigned int flags)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	struct ref_iterator *res =
+		drefs->refs->be->iterator_begin(drefs->refs, prefix, flags);
+	return res;
+}
+
+static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
+			      struct object_id *oid, struct strbuf *referent,
+			      unsigned int *type)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = 0;
+
+	oidcpy(oid, &null_oid);
+	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
+					    type);
+
+	if (res == 0) {
+		printf("read_raw_ref: %s: %s (=> %s) type %x: %d\n", refname,
+		       oid_to_hex(oid), referent->buf, *type, res);
+	} else {
+		printf("read_raw_ref: %s err %d\n", refname, res);
+	}
+	return res;
+}
+
+static struct ref_iterator *
+debug_reflog_iterator_begin(struct ref_store *ref_store)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	struct ref_iterator *res =
+		drefs->refs->be->reflog_iterator_begin(drefs->refs);
+	printf("for_each_reflog_iterator_begin\n");
+	return res;
+}
+
+struct debug_reflog {
+	const char *refname;
+	each_reflog_ent_fn *fn;
+	void *cb_data;
+};
+
+static int debug_print_reflog_ent(struct object_id *old_oid,
+				  struct object_id *new_oid,
+				  const char *committer, timestamp_t timestamp,
+				  int tz, const char *msg, void *cb_data)
+{
+	struct debug_reflog *dbg = (struct debug_reflog *)cb_data;
+	int ret;
+	char o[100] = "null";
+	char n[100] = "null";
+	if (old_oid)
+		oid_to_hex_r(o, old_oid);
+	if (new_oid)
+		oid_to_hex_r(n, new_oid);
+
+	ret = dbg->fn(old_oid, new_oid, committer, timestamp, tz, msg,
+		      dbg->cb_data);
+	printf("reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
+	       dbg->refname, ret, o, n, committer, (long int)timestamp, msg);
+	return ret;
+}
+
+static int debug_for_each_reflog_ent(struct ref_store *ref_store,
+				     const char *refname, each_reflog_ent_fn fn,
+				     void *cb_data)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	struct debug_reflog dbg = {
+		.refname = refname,
+		.fn = fn,
+		.cb_data = cb_data,
+	};
+
+	int res = drefs->refs->be->for_each_reflog_ent(
+		drefs->refs, refname, &debug_print_reflog_ent, &dbg);
+	printf("for_each_reflog: %s: %d\n", refname, res);
+	return res;
+}
+
+static int debug_for_each_reflog_ent_reverse(struct ref_store *ref_store,
+					     const char *refname,
+					     each_reflog_ent_fn fn,
+					     void *cb_data)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	struct debug_reflog dbg = {
+		.refname = refname,
+		.fn = fn,
+		.cb_data = cb_data,
+	};
+	int res = drefs->refs->be->for_each_reflog_ent_reverse(
+		drefs->refs, refname, &debug_print_reflog_ent, &dbg);
+	printf("for_each_reflog_reverse: %s: %d\n", refname, res);
+	return res;
+}
+
+static int debug_reflog_exists(struct ref_store *ref_store, const char *refname)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->reflog_exists(drefs->refs, refname);
+	printf("reflog_exists: %s: %d\n", refname, res);
+	return res;
+}
+
+static int debug_create_reflog(struct ref_store *ref_store, const char *refname,
+			       int force_create, struct strbuf *err)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->create_reflog(drefs->refs, refname,
+						 force_create, err);
+	return res;
+}
+
+static int debug_delete_reflog(struct ref_store *ref_store, const char *refname)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->delete_reflog(drefs->refs, refname);
+	return res;
+}
+
+static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
+			       const struct object_id *oid, unsigned int flags,
+			       reflog_expiry_prepare_fn prepare_fn,
+			       reflog_expiry_should_prune_fn should_prune_fn,
+			       reflog_expiry_cleanup_fn cleanup_fn,
+			       void *policy_cb_data)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->reflog_expire(drefs->refs, refname, oid,
+						 flags, prepare_fn,
+						 should_prune_fn, cleanup_fn,
+						 policy_cb_data);
+	return res;
+}
+
+struct ref_storage_be refs_be_debug = {
+	NULL,
+	"debug",
+	NULL,
+	debug_init_db,
+	debug_transaction_prepare,
+	debug_transaction_finish,
+	debug_transaction_abort,
+	debug_initial_transaction_commit,
+
+	debug_pack_refs,
+	debug_create_symref,
+	debug_delete_refs,
+	debug_rename_ref,
+	debug_copy_ref,
+
+	debug_write_pseudoref,
+	debug_delete_pseudoref,
+
+	debug_ref_iterator_begin,
+	debug_read_raw_ref,
+
+	debug_reflog_iterator_begin,
+	debug_for_each_reflog_ent,
+	debug_for_each_reflog_ent_reverse,
+	debug_reflog_exists,
+	debug_create_reflog,
+	debug_delete_reflog,
+	debug_reflog_expire,
+};
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 7afe4c28310..5417623c86e 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -713,4 +713,10 @@ struct ref_store {
 void base_ref_store_init(struct ref_store *refs,
 			 const struct ref_storage_be *be);
 
+/*
+ * Print out ref operations as they occur. Useful for debugging alternate ref
+ * backends.
+ */
+struct ref_store *debug_wrap(struct ref_store *store);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/t/t0033-debug-refs.sh b/t/t0033-debug-refs.sh
new file mode 100755
index 00000000000..ed76c2c84a1
--- /dev/null
+++ b/t/t0033-debug-refs.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+#
+# Copyright (c) 2020 Google LLC
+#
+
+test_description='cross-check reftable with files, using GIT_DEBUG_REFS output'
+
+. ./test-lib.sh
+
+test_expect_success 'GIT_DEBUG_REFS' '
+	git init --ref-storage=files files &&
+	git init --ref-storage=reftable reftable &&
+	(cd files && GIT_DEBUG_REFS=1 test_commit message file) > files.txt &&
+	(cd reftable && GIT_DEBUG_REFS=1 test_commit message file) > reftable.txt &&
+	test_cmp files.txt reftable.txt
+'
+
+test_done
-- 
gitgitgadget

