Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBD4C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6574206FA
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oc9FAAza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgFESDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgFESDj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 14:03:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4DFC08C5C4
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 11:03:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c3so10627804wru.12
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qpGPMwGt+5MZ4pm2xnWjL3z8aMW10vQNKdYoxf+PhoU=;
        b=Oc9FAAzaO2+eUkn1oq3JvaYVvxBdd29lLscBNKE0hrfOh/rJ3z91w2lLJpEEpbR1y8
         Dmn07PxWAASbEzNwtMh+8QScPEasRZ+2FhbqES4cX05U+YC7BY54wF6E4tvJCwAbENqi
         qKYFe7yOdX2OZPwx0i2IawK4FoxK5sY81x56jYR/DgX1Vm9kJ+JS3ZQLJZRfjyrE33m3
         5hh0bwMz0caqrja/k3XeoUkvzvPmq/YSaJrPhVDqVNxdJG+GIj7ltjTyZjSv3Jx/dFzv
         RR8BNnUR5RoZC9bfPKPCjV92v8Hmk4PvPUZa9phwQvbRSmDVt3k/4OtNjnFu52CrFllH
         xnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qpGPMwGt+5MZ4pm2xnWjL3z8aMW10vQNKdYoxf+PhoU=;
        b=rAQgdhtszQvmI3dYesDqm7wCLv0+VTIQXMj9mzzQpwAZQT9UZ8fwbGu6hpWmVcXC1Y
         Q0rC7LlSGS0INncd28ehg2ADHMkqnJzUqDeQMHUnzUG9RsRQaLBBv5So33Msfpqo/9xT
         j5wKQc79PEJEyzV6o4CfCj6ukj6YTgkIOFJSHtG+96+h4IJpgK9fT/N4wAJdHU5Np1SL
         9PKBqTyLPr4eKr6HTC5n7pGgbhgLAuHgJjnrBXnHWYAN9YSkz+d068QL7H1kE6D6T1Sp
         5rMigkRSW5FpSgEobkgK16Infw8Be1aAfOxc/LfN6FEcDmA7yhsimXZoz4dRowk29bLQ
         0V0Q==
X-Gm-Message-State: AOAM532OlE0g5mrBbsR4ca1csjm141W2k7ie8liDuo+stW6UhAiTY8M/
        d65e0aMRopy/XkrG0zNEjDlafKUe
X-Google-Smtp-Source: ABdhPJwb43FGtRMWPqk73RbQD+t53n3qwI7BQu6xSOu9C0UEOTJcv4GbrRDAbL1NhBzgIE/b2J5l7g==
X-Received: by 2002:adf:cd08:: with SMTP id w8mr10555488wrm.36.1591380217378;
        Fri, 05 Jun 2020 11:03:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5sm13044927wrw.19.2020.06.05.11.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:03:36 -0700 (PDT)
Message-Id: <1f193b6da23c2f8bff7ff05f9264d6098d797a7c.1591380200.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
        <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 18:03:16 +0000
Subject: [PATCH v16 12/14] Add GIT_DEBUG_REFS debugging mechanism
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
index a39896191c7..1d09af7fd8d 100644
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

