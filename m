Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4887AC433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17551206F1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5p2eU04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbgF2VO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729633AbgF2S5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE56C031C44
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so16409494wmi.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XRbb3bNuvEpHmPqSUBXCjA6DBebdWuZbaMlzSZAmKQk=;
        b=U5p2eU04p+G/T1Xd3e5TdySmVfIW1+n9lmVgPuKlkpYDfEdKPfCHeMr0HZ+XSseD59
         Dd/a6nbxeSSVSVYhM29mg5L9siCX7LsweNw0xCg7teFIJSpEKIu77oHY23iWPzZFczd6
         SKBEeD7mn8qDm10TROJqm8HxB3XVMeFURKKekSQHZGx1PjigiR9pTfpHvd+pLsPswC4L
         bGv2ff/aQ3Q3z7WpRFFbRohkezp8ztIfzb7zLeKaiPKp60b3UyaeHcjEWRjcYzXDoXNt
         kk6V85R3HjnMkg0QiPx24qQ8VLnpoywlV3T5U9PYjwPIJVu6Kz1Wd2zWNteeLVknTrA2
         dSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XRbb3bNuvEpHmPqSUBXCjA6DBebdWuZbaMlzSZAmKQk=;
        b=nqHgug5ltQoAgbipcgEvewJeSJg1nauBACmbsO2ZhdvPHhbX+6riYwyUCmoC4oLjxj
         NV2N+SxyaLHYdYwYAvXz6lTG0X29rqVwWJsbFJSJepuL6axtlCtQuilfDQTPLLd2Kcdq
         qz1aX2pHWp2U1oYdOcGBg/wfH3JSwyrvTZ0OYq4hOAbshnQ6kG4pm4Aqo7hJC7yN+mKs
         qQx72/6+WyKkEdzJMpJKsQ/jQr+SPumyJ5R60N0mXcMbPtiLRVS004XGA6xYftvHKlgp
         1eFfJ8vuNHDyF5iQ/pJMlOHIZw9Qor0yseWC7CTXxaxubAYAzIqoTVeyLW+ekFAXZJte
         k2XA==
X-Gm-Message-State: AOAM530snOzinYWRB5XF4J5UiXcwDdrZUaR3dMnQLp9pmmSJdVatAl61
        501qkMKMjBL0GqzM/YaFouKiCXZPGo0=
X-Google-Smtp-Source: ABdhPJyvufYiQPWnZcbO65dn34vDy9H3hbtMnGVzbNMZc3lRtn3HTDzKQLS8dnSMFklitWFhq0Bc8w==
X-Received: by 2002:a7b:c0da:: with SMTP id s26mr16911418wmh.96.1593457034703;
        Mon, 29 Jun 2020 11:57:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 30sm766650wrm.74.2020.06.29.11.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:57:14 -0700 (PDT)
Message-Id: <c7512657050e5278d72b6b03600b0c1dd711984f.1593457018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:54 +0000
Subject: [PATCH v19 16/20] Add GIT_DEBUG_REFS debugging mechanism
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
 builtin/worktree.c    |   6 +-
 refs.c                |   3 +
 refs/debug.c          | 416 ++++++++++++++++++++++++++++++++++++++++++
 refs/refs-internal.h  |   6 +
 t/t0033-debug-refs.sh |  18 ++
 6 files changed, 449 insertions(+), 1 deletion(-)
 create mode 100644 refs/debug.c
 create mode 100755 t/t0033-debug-refs.sh

diff --git a/Makefile b/Makefile
index 8f33ad899a..700ba10b01 100644
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
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1935967072..bdc792ee3f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -403,7 +403,11 @@ static int add_worktree(const char *path, const char *refname,
 	 * worktree.
 	 */
 	strbuf_reset(&sb);
-	if (get_main_ref_store(the_repository)->be == &refs_be_reftable) {
+
+	/* XXX: check GIT_TEST_REFTABLE because GIT_DEBUG_REFS obscures the
+	 * instance type. */
+	if (get_main_ref_store(the_repository)->be == &refs_be_reftable ||
+	    getenv("GIT_TEST_REFTABLE") != NULL) {
 		/* XXX this is cut & paste from reftable_init_db. */
 		strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
 		write_file(sb.buf, "%s", "ref: refs/heads/.invalid\n");
diff --git a/refs.c b/refs.c
index 577adef4ae..63769a8b81 100644
--- a/refs.c
+++ b/refs.c
@@ -1782,6 +1782,9 @@ struct ref_store *get_main_ref_store(struct repository *r)
 						       r->ref_storage_format :
 						       default_ref_storage(),
 					 REF_STORE_ALL_CAPS);
+	if (getenv("GIT_DEBUG_REFS")) {
+		r->refs_private = debug_wrap(r->gitdir, r->refs_private);
+	}
 	return r->refs_private;
 }
 
diff --git a/refs/debug.c b/refs/debug.c
new file mode 100644
index 0000000000..a2317f1a65
--- /dev/null
+++ b/refs/debug.c
@@ -0,0 +1,416 @@
+
+#include "refs-internal.h"
+
+struct debug_ref_store {
+	struct ref_store base;
+	struct ref_store *refs;
+};
+
+extern struct ref_storage_be refs_be_debug;
+struct ref_store *debug_wrap(const char *gitdir, struct ref_store *store);
+
+struct ref_store *debug_wrap(const char *gitdir, struct ref_store *store)
+{
+	struct debug_ref_store *res = malloc(sizeof(struct debug_ref_store));
+	fprintf(stderr, "ref_store for %s\n", gitdir);
+	res->refs = store;
+	base_ref_store_init((struct ref_store *)res, &refs_be_debug);
+	return (struct ref_store *)res;
+}
+
+static int debug_init_db(struct ref_store *refs, struct strbuf *err)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
+	int res = drefs->refs->be->init_db(drefs->refs, err);
+	fprintf(stderr, "init_db: %d\n", res);
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
+	fprintf(stderr, "transaction_prepare: %d\n", res);
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
+	fprintf(stderr, "%d: %s %s -> %s (F=0x%x, T=0x%x) \"%s\"\n", i, refname,
+		o, n, flags, type, msg);
+}
+
+static void print_transaction(struct ref_transaction *transaction)
+{
+	fprintf(stderr, "transaction {\n");
+	for (int i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = transaction->updates[i];
+		print_update(i, u->refname, &u->old_oid, &u->new_oid, u->flags,
+			     u->type, u->msg);
+	}
+	fprintf(stderr, "}\n");
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
+	fprintf(stderr, "finish: %d\n", res);
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
+	fprintf(stderr, "pack_refs: %d\n", res);
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
+	fprintf(stderr, "create_symref: %s -> %s \"%s\": %d\n", ref_name,
+		target, logmsg, res);
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
+	fprintf(stderr, "rename_ref: %s -> %s \"%s\": %d\n", oldref, newref,
+		logmsg, res);
+	return res;
+}
+
+static int debug_copy_ref(struct ref_store *ref_store, const char *oldref,
+			  const char *newref, const char *logmsg)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res =
+		drefs->refs->be->copy_ref(drefs->refs, oldref, newref, logmsg);
+	fprintf(stderr, "copy_ref: %s -> %s \"%s\": %d\n", oldref, newref,
+		logmsg, res);
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
+	fprintf(stderr, "write_pseudoref: %s, %s => %s, err %s: %d\n",
+		pseudoref, o, n, err->buf, res);
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
+	fprintf(stderr, "delete_pseudoref: %s (%s): %d\n", pseudoref, hex, res);
+	return res;
+}
+
+struct debug_ref_iterator {
+	struct ref_iterator base;
+	struct ref_iterator *iter;
+};
+
+static int debug_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct debug_ref_iterator *diter =
+		(struct debug_ref_iterator *)ref_iterator;
+	int res = diter->iter->vtable->advance(diter->iter);
+	if (res)
+		fprintf(stderr, "iterator_advance: %d\n", res);
+	else
+		fprintf(stderr, "iterator_advance before: %s\n",
+			diter->iter->refname);
+
+	diter->base.ordered = diter->iter->ordered;
+	diter->base.refname = diter->iter->refname;
+	diter->base.oid = diter->iter->oid;
+	diter->base.flags = diter->iter->flags;
+	return res;
+}
+static int debug_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				   struct object_id *peeled)
+{
+	struct debug_ref_iterator *diter =
+		(struct debug_ref_iterator *)ref_iterator;
+	int res = diter->iter->vtable->peel(diter->iter, peeled);
+	fprintf(stderr, "iterator_peel: %s: %d\n", diter->iter->refname, res);
+	return res;
+}
+
+static int debug_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct debug_ref_iterator *diter =
+		(struct debug_ref_iterator *)ref_iterator;
+	int res = diter->iter->vtable->abort(diter->iter);
+	fprintf(stderr, "iterator_abort: %d\n", res);
+	return res;
+}
+
+static struct ref_iterator_vtable debug_ref_iterator_vtable = {
+	debug_ref_iterator_advance, debug_ref_iterator_peel,
+	debug_ref_iterator_abort
+};
+
+static struct ref_iterator *
+debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
+			 unsigned int flags)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	struct ref_iterator *res =
+		drefs->refs->be->iterator_begin(drefs->refs, prefix, flags);
+	struct debug_ref_iterator *diter = xcalloc(1, sizeof(*diter));
+	base_ref_iterator_init(&diter->base, &debug_ref_iterator_vtable, 1);
+	diter->iter = res;
+	fprintf(stderr, "ref_iterator_begin: %s (0x%x)\n", prefix, flags);
+	return &diter->base;
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
+		fprintf(stderr, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
+			refname, oid_to_hex(oid), referent->buf, *type, res);
+	} else {
+		fprintf(stderr, "read_raw_ref: %s err %d\n", refname, res);
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
+	fprintf(stderr, "for_each_reflog_iterator_begin\n");
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
+	fprintf(stderr, "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
+		dbg->refname, ret, o, n, committer, (long int)timestamp, msg);
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
+	fprintf(stderr, "for_each_reflog: %s: %d\n", refname, res);
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
+	fprintf(stderr, "for_each_reflog_reverse: %s: %d\n", refname, res);
+	return res;
+}
+
+static int debug_reflog_exists(struct ref_store *ref_store, const char *refname)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->reflog_exists(drefs->refs, refname);
+	fprintf(stderr, "reflog_exists: %s: %d\n", refname, res);
+	return res;
+}
+
+static int debug_create_reflog(struct ref_store *ref_store, const char *refname,
+			       int force_create, struct strbuf *err)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->create_reflog(drefs->refs, refname,
+						 force_create, err);
+	fprintf(stderr, "create_reflog: %s: %d\n", refname, res);
+	return res;
+}
+
+static int debug_delete_reflog(struct ref_store *ref_store, const char *refname)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->delete_reflog(drefs->refs, refname);
+	fprintf(stderr, "delete_reflog: %s: %d\n", refname, res);
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
+	fprintf(stderr, "reflog_expire: %s: %d\n", refname, res);
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
index 7afe4c2831..b5c9f57af7 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -713,4 +713,10 @@ struct ref_store {
 void base_ref_store_init(struct ref_store *refs,
 			 const struct ref_storage_be *be);
 
+/*
+ * Print out ref operations as they occur. Useful for debugging alternate ref
+ * backends.
+ */
+struct ref_store *debug_wrap(const char *gitdir, struct ref_store *store);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/t/t0033-debug-refs.sh b/t/t0033-debug-refs.sh
new file mode 100755
index 0000000000..ed76c2c84a
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

