Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD256C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8986520829
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekVxv1bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgERUbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 16:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgERUbf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 16:31:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25243C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m12so832914wmc.0
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x6i2Px1ek6/uPcyNJ5UEkMdJ4y+BTd9zBWPrqfLF2Zo=;
        b=ekVxv1bnEcx1fNY7ISopCYuqmWpBnnKYAg8yJlpUZ70jljD30Qi4iCD0Huk6c+eNPl
         RFhuB9LYre/MRYJcdyCcnCBCVB+ycMTxmZldQS+zzoHFGnO/h6LDBi7wPORFZfClaj8Y
         0Qv7RFMKSWz0IgrxwAxNTwHOuF16RdVaDbZf/5qYv6tmPiJBWeMfwuXs/x2LqCsM9Rc7
         uVfNzRc5IRyFJZHFOPaB/8GElX0BErS7wWg5UKNe21WzYpgB4SOiCJcvUcdma3Ib1Y5x
         B1ceSHx7QcVtqlOOPwBvTfT4RMafXZ1ifjWuwlTwFS6EOHW1MjRpdY2B8pPzx7mZBX3X
         +CFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x6i2Px1ek6/uPcyNJ5UEkMdJ4y+BTd9zBWPrqfLF2Zo=;
        b=N/fFKc+6v7Bpvg2hjDY1195wMM+IhVB/H2PW4v+qUS552YKRxhZl1VoK69KrAXH1et
         H5SJhIS0Ndfvu49Vb/v2yBpDnreKiKvJvEHezck806lCpR8vYV2S1CrDXSXvdPHI4Rx+
         KMx8ffvdj2yEmS779SikKsAyeQ/G6LA6uuJBOKQaegQinJhXGofPhlus1zqBnKMI+3SK
         bJKsJjdSpsgF1bBE5LX772seJj2X7drKAmX6Fqz7fs3iHVC+Jt5l87PGnJfeC7JY7Ht2
         nNa18tIBK6gAhZs+ft+SD6q95iSs3RIg8LRt3Hr1XFgVYzObgpkFWsjCRRjZJLDTGMdo
         pk2Q==
X-Gm-Message-State: AOAM533rbZx1ZXp4nb5MOqqhnejouf1NV1TSeOoneqOAUMgfxa2rk/Xd
        ZXfewO7FoUybyLOQyWPEa/fV0igQ
X-Google-Smtp-Source: ABdhPJwP83owPDW/BjYWSrpRv6sorJOqQu1h4SCC7ZC+WYnq0tmuyxmBWLkNiqaOp9ClcORAEhE5Sw==
X-Received: by 2002:a1c:307:: with SMTP id 7mr1222566wmd.104.1589833893376;
        Mon, 18 May 2020 13:31:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i21sm879373wml.5.2020.05.18.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 13:31:32 -0700 (PDT)
Message-Id: <6b248d5fdb4b7a5e5d6abdb9f29d9582b79d18a7.1589833884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
References: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 May 2020 20:31:22 +0000
Subject: [PATCH v14 7/9] Add GIT_DEBUG_REFS debugging mechanism
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
 refs/debug.c          | 309 ++++++++++++++++++++++++++++++++++++++++++
 refs/refs-internal.h  |   6 +
 t/t0033-debug-refs.sh |  18 +++
 5 files changed, 337 insertions(+)
 create mode 100644 refs/debug.c
 create mode 100755 t/t0033-debug-refs.sh

diff --git a/Makefile b/Makefile
index f4848a382f4..cec61455184 100644
--- a/Makefile
+++ b/Makefile
@@ -962,6 +962,7 @@ LIB_OBJS += rebase.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
+LIB_OBJS += refs/debug.o
 LIB_OBJS += refs/files-backend.o
 LIB_OBJS += refs/reftable-backend.o
 LIB_OBJS += refs/iterator.o
diff --git a/refs.c b/refs.c
index 8eb64a33d6e..9b456a46712 100644
--- a/refs.c
+++ b/refs.c
@@ -1745,6 +1745,9 @@ struct ref_store *get_main_ref_store(struct repository *r)
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
index 00000000000..7c07ec92137
--- /dev/null
+++ b/refs/debug.c
@@ -0,0 +1,309 @@
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
+			 unsigned int type)
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
+	printf("%d: %s %s -> %s (F=0x%x, T=0x%x)\n", i, refname, o, n, flags,
+	       type);
+}
+
+static void print_transaction(struct ref_transaction *transaction)
+{
+	printf("transaction {\n");
+	for (int i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = transaction->updates[i];
+		print_update(i, u->refname, &u->old_oid, &u->new_oid, u->flags,
+			     u->type);
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
+			       const char *ref_target,
+			       const char *refs_heads_master,
+			       const char *logmsg)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->create_symref(drefs->refs, ref_target,
+						 refs_heads_master, logmsg);
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
+static int debug_rename_ref(struct ref_store *ref_store, const char *oldref,
+			    const char *newref, const char *logmsg)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->rename_ref(drefs->refs, oldref, newref,
+					      logmsg);
+	return res;
+}
+static int debug_copy_ref(struct ref_store *ref_store, const char *oldref,
+			  const char *newref, const char *logmsg)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res =
+		drefs->refs->be->copy_ref(drefs->refs, oldref, newref, logmsg);
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
+	return res;
+}
+
+static int debug_for_each_reflog_ent(struct ref_store *ref_store,
+				     const char *refname, each_reflog_ent_fn fn,
+				     void *cb_data)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->for_each_reflog_ent(drefs->refs, refname, fn,
+						       cb_data);
+	return res;
+}
+static int debug_for_each_reflog_ent_reverse(struct ref_store *ref_store,
+					     const char *refname,
+					     each_reflog_ent_fn fn,
+					     void *cb_data)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->for_each_reflog_ent_reverse(
+		drefs->refs, refname, fn, cb_data);
+	return res;
+}
+
+static int debug_reflog_exists(struct ref_store *ref_store, const char *refname)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->reflog_exists(drefs->refs, refname);
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
index de2ead363f5..c4abab3d179 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -700,4 +700,10 @@ struct ref_store {
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
index 00000000000..96266a3ee3a
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

