Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F5BC433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EAAA22B40
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg2VgjYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbgGaP2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387496AbgGaP1m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920EDC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so28314608wrj.13
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mNqaoixogEHEeYvRA2Qwel40DNR1KecUWbZqv0lxyhE=;
        b=hg2VgjYK7rg1rORSAT85Z2XBG2aE8sfIxwluMIedSftiF28wMqj1UUibi9h3HBYOYU
         AkKQREJ46LllObcRGJEUrJHaYKtZE7yIK3Ko/CSlYboqMKSOdRBcVLW+NGVWxNgftzb9
         qSzCmRTKNTuhjPPiavZGoN3wWbbPrPQc/V/9hPvjNsLbs3vMpEEUjFmIPdu09qJnPEZN
         poQoR2Rhf1rFljlmfX8xoZfJNlkyQuhEpSOFJ6SEJFokgetrNReN71APsQgHHwkWkS/z
         XaaJPaYFKeB2rk6UsWy2+RHyogRvNWrOUD0OqjWALCHxTCBZ0ei3LQWZc0ERS6FA7HJZ
         aMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mNqaoixogEHEeYvRA2Qwel40DNR1KecUWbZqv0lxyhE=;
        b=h2gQnBa1GXSKlSm4/yqfpUplYTsirlSO1KQVcwtwz6czOp+OztZ9VKu0ak9iRGYrIu
         CXir6+oknalm+JGoDtdWndo3GjRlF1bOI7Z32PBl+/sogBhuNPfcmxt75iV9W5BvzW/R
         Ze+qHKa0/6bXoqiko33/urq6kHWeMHMwhpaDvpJHzTxAaPE0/QQDYawJ45V6NODju0iN
         UL5NFUw8CMFa0vp1gCCj5HetUA3nnd1Q0Fwta21K1jgNHjHMpcnkuaKlRpgSos9Yazec
         NPWlV7CkyDIYXdKQXdTxgmtPZ/OZTrctzKkgqvgYpeLuJifd2qd304PCVoJ8jblDnSmW
         JSVg==
X-Gm-Message-State: AOAM531pzXoSbhiOglDzKvMTTPQuMm6Gjm4ciiHbUag4C26ejyh+I5gu
        zlDbTuIgDhreIJUw6ezELitahkGn
X-Google-Smtp-Source: ABdhPJzsn0360geV2pUB7r7OInOZ4zGEGihNcDe5Az7y3OehL41No9GJ7cS/b/vepZ1hFVcD+aiQvQ==
X-Received: by 2002:adf:80c7:: with SMTP id 65mr3901150wrl.35.1596209259799;
        Fri, 31 Jul 2020 08:27:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 33sm15205537wri.16.2020.07.31.08.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:38 -0700 (PDT)
Message-Id: <679dc37871b1b387666108610c1cc5077485e6ad.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:13 +0000
Subject: [PATCH v20 17/21] Add GIT_DEBUG_REFS debugging mechanism
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
 builtin/worktree.c    |   4 +-
 refs.c                |   8 +
 refs.h                |   1 +
 refs/debug.c          | 387 ++++++++++++++++++++++++++++++++++++++++++
 refs/refs-internal.h  |   6 +
 t/t0033-debug-refs.sh |  18 ++
 7 files changed, 424 insertions(+), 1 deletion(-)
 create mode 100644 refs/debug.c
 create mode 100755 t/t0033-debug-refs.sh

diff --git a/Makefile b/Makefile
index 5e69c16507..0948a3bb00 100644
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
index 1935967072..12d2204239 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -403,7 +403,9 @@ static int add_worktree(const char *path, const char *refname,
 	 * worktree.
 	 */
 	strbuf_reset(&sb);
-	if (get_main_ref_store(the_repository)->be == &refs_be_reftable) {
+
+	if (!strcmp(ref_store_backend_name(get_main_ref_store(the_repository)),
+		    "reftable")) {
 		/* XXX this is cut & paste from reftable_init_db. */
 		strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
 		write_file(sb.buf, "%s", "ref: refs/heads/.invalid\n");
diff --git a/refs.c b/refs.c
index 3789bc1071..b37ccd4c53 100644
--- a/refs.c
+++ b/refs.c
@@ -44,6 +44,11 @@ int ref_storage_backend_exists(const char *name)
 	return find_ref_storage_backend(name) != NULL;
 }
 
+const char *ref_store_backend_name(struct ref_store *refs)
+{
+	return refs->be->name;
+}
+
 /*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
@@ -1758,6 +1763,9 @@ struct ref_store *get_main_ref_store(struct repository *r)
 						 r->ref_storage_format :
 						 default_ref_storage(),
 					 REF_STORE_ALL_CAPS);
+	if (getenv("GIT_DEBUG_REFS")) {
+		r->refs_private = debug_wrap(r->gitdir, r->refs_private);
+	}
 	return r->refs_private;
 }
 
diff --git a/refs.h b/refs.h
index 581ec270dc..f6d619ea4b 100644
--- a/refs.h
+++ b/refs.h
@@ -825,6 +825,7 @@ int reflog_expire(const char *refname, const struct object_id *oid,
 int ref_storage_backend_exists(const char *name);
 
 struct ref_store *get_main_ref_store(struct repository *r);
+const char *ref_store_backend_name(struct ref_store *refs);
 
 /**
  * Submodules
diff --git a/refs/debug.c b/refs/debug.c
new file mode 100644
index 0000000000..865c5ec873
--- /dev/null
+++ b/refs/debug.c
@@ -0,0 +1,387 @@
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
+	struct ref_storage_be *be_copy = malloc(sizeof(*be_copy));
+	*be_copy = refs_be_debug;
+	be_copy->name = ref_store_backend_name(store);
+	fprintf(stderr, "ref_store for %s\n", gitdir);
+	res->refs = store;
+	base_ref_store_init((struct ref_store *)res, be_copy);
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
+	int i = 0;
+	fprintf(stderr, "delete_refs {\n");
+	for (i = 0; i < refnames->nr; i++)
+		fprintf(stderr, "%s\n", refnames->items[i].string);
+	fprintf(stderr, "}: %d\n", res);
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
index b9b5c2e87c..e1da4b3a53 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -695,4 +695,10 @@ int parse_loose_ref_contents(const char *buf, struct object_id *oid,
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

