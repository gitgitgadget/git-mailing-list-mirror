Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC7EC43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 10:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AD521D7D
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 10:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3X9L1Y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIIKPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgIIKPN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 06:15:13 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B755C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 03:15:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so1760250wmj.5
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 03:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1yRrCxKjhuqIeIx4jqJmqJfThLJi2n0izM16RrxwF+c=;
        b=F3X9L1Y8QxtAzp5kKo8Y2bVbeeZL3Qanq8cD55vysMm00vJHbMNTZV2j50NXBH7BPA
         11zdsYW8JSFcREs+DPPrx3uVGMR4L1lN8VwmI13BfpCnc0b6taWuMIUaQPlmE0ut4/qe
         7elMJNBAu19VgWp4635gsukqbk9/gEOqiVymfld6IQMp6FQy0uAXKMXsuPuq4KlU5HxM
         61jhlj5wkbDYCBayvGJq7eaTOngvHK7XLQQJpW2trB4ePuNCLmW51rgqF0/mKcOSuyXT
         1xM2V1UMRZCs0FZ8OFi0pJqZQkx3WLcjIAgSg5hUydWHSqZQt240t+g8X/MbsYfPEMih
         wBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1yRrCxKjhuqIeIx4jqJmqJfThLJi2n0izM16RrxwF+c=;
        b=GV5EvWVTIOa4RVGHp86HtrWj15qdgJR4N0DZmNUHhMLaWuM5Rl4OnScrzgb+dnBVlI
         MoMlvC1w8sMEqB1m245ivDi0TgK6BmBiU5FRFppRwwJNGi/aY1K+NHtCbRt9hiFD/A7k
         p6JZc+7eUGOew9M3YEJhHv4B8cQGhqyQxR4iOPxSDlsPj6zaxyZD3OtApGIvyNKqBb3T
         wDmx2MFMwmy66RZiAbdFJPZAS40qOQqlMQzyQukLnmuK0q3ivRJfcSLmpJ8i4EByize2
         XtobEG90oK7aXYIeqkZmOxGLvH9LTUuWIS17syXghdcpYT+rJsUVEhFhk+WUXDRxxcn5
         mExQ==
X-Gm-Message-State: AOAM532IeOeVWJ2+Na46iQ3ZExmZuUulfwOFVE8axVCgQIk2SorWGuHE
        y9lfknmVc7iKO6UURv33JqElc4W0rP4=
X-Google-Smtp-Source: ABdhPJxQUIs6ZJM4s/zAgQ6HWIGRxb0PJ0Qy0c5b0C6l49Bs6vZtzz+V/YSj7h7sR4nLdw2fjba1GQ==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr2730155wmi.173.1599646510709;
        Wed, 09 Sep 2020 03:15:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t4sm3344327wrr.26.2020.09.09.03.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 03:15:09 -0700 (PDT)
Message-Id: <pull.713.v3.git.1599646508673.gitgitgadget@gmail.com>
In-Reply-To: <pull.713.v2.git.1599492274909.gitgitgadget@gmail.com>
References: <pull.713.v2.git.1599492274909.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Sep 2020 10:15:08 +0000
Subject: [PATCH v3] refs: add GIT_TRACE_REFS debugging mechanism
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

When set in the environment, GIT_TRACE_REFS makes git print operations and
results as they flow through the ref storage backend. This helps debug
discrepancies between different ref backends.

Example:

    $ GIT_TRACE_REFS="1" ./git branch
    15:42:09.769631 refs/debug.c:26         ref_store for .git
    15:42:09.769681 refs/debug.c:249        read_raw_ref: HEAD: 0000000000000000000000000000000000000000 (=> refs/heads/ref-debug) type 1: 0
    15:42:09.769695 refs/debug.c:249        read_raw_ref: refs/heads/ref-debug: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a (=> refs/heads/ref-debug) type 0: 0
    15:42:09.770282 refs/debug.c:233        ref_iterator_begin: refs/heads/ (0x1)
    15:42:09.770290 refs/debug.c:189        iterator_advance: refs/heads/b4 (0)
    15:42:09.770295 refs/debug.c:189        iterator_advance: refs/heads/branch3 (0)

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    refs: add GIT_TRACE_REFS debugging mechanism
    
    When set in the environment, GIT_TRACE_REFS makes git print operations
    and results as they flow through the ref storage backend. This helps
    debug discrepancies between different ref backends.
    
    Example:
    
        $ GIT_TRACE_REFS="1" ./git branch
        15:42:09.769631 refs/debug.c:26         ref_store for .git
        15:42:09.769681 refs/debug.c:249        read_raw_ref: HEAD: 0000000000000000000000000000000000000000 (=> refs/heads/ref-debug) type 1: 0
        15:42:09.769695 refs/debug.c:249        read_raw_ref: refs/heads/ref-debug: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a (=> refs/heads/ref-debug) type 0: 0
        15:42:09.770282 refs/debug.c:233        ref_iterator_begin: refs/heads/ (0x1)
        15:42:09.770290 refs/debug.c:189        iterator_advance: refs/heads/b4 (0)
        15:42:09.770295 refs/debug.c:189        iterator_advance: refs/heads/branch3 (0)
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com [hanwen@google.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-713%2Fhanwen%2Fdebug-refs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-713/hanwen/debug-refs-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/713

Range-diff vs v2:

 1:  19330e894c ! 1:  e19e2a3433 refs: add GIT_TRACE_REFS debugging mechanism
     @@ refs/debug.c (new)
      +	if (!trace_want(&trace_refs)) {
      +		return store;
      +	}
     -+	res = malloc(sizeof(struct debug_ref_store));
     -+	be_copy = malloc(sizeof(*be_copy));
     ++	res = xmalloc(sizeof(struct debug_ref_store));
     ++	be_copy = xmalloc(sizeof(*be_copy));
      +	*be_copy = refs_be_debug;
     ++	/* we never deallocate backends, so safe to copy the pointer. */
      +	be_copy->name = store->be->name;
      +	trace_printf_key(&trace_refs, "ref_store for %s\n", gitdir);
      +	res->refs = store;
     @@ refs/debug.c (new)
      +			 const struct object_id *new_oid, unsigned int flags,
      +			 unsigned int type, const char *msg)
      +{
     -+	char o[200] = "null";
     -+	char n[200] = "null";
     ++	char o[GIT_MAX_HEXSZ + 1] = "null";
     ++	char n[GIT_MAX_HEXSZ + 1] = "null";
      +	if (old_oid)
      +		oid_to_hex_r(o, old_oid);
      +	if (new_oid)
     @@ refs/debug.c (new)
      +
      +static void print_transaction(struct ref_transaction *transaction)
      +{
     ++	int i;
      +	trace_printf_key(&trace_refs, "transaction {\n");
     -+	for (int i = 0; i < transaction->nr; i++) {
     ++	for (i = 0; i < transaction->nr; i++) {
      +		struct ref_update *u = transaction->updates[i];
      +		print_update(i, u->refname, &u->old_oid, &u->new_oid, u->flags,
      +			     u->type, u->msg);
     @@ refs/debug.c (new)
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res =
      +		drefs->refs->be->delete_refs(drefs->refs, msg, refnames, flags);
     -+	int i = 0;
     ++	int i;
      +	trace_printf_key(&trace_refs, "delete_refs {\n");
      +	for (i = 0; i < refnames->nr; i++)
      +		trace_printf_key(&trace_refs, "%s\n", refnames->items[i].string);
     @@ refs/debug.c (new)
      +{
      +	struct debug_reflog *dbg = (struct debug_reflog *)cb_data;
      +	int ret;
     -+	char o[100] = "null";
     -+	char n[100] = "null";
     ++	char o[GIT_MAX_HEXSZ + 1] = "null";
     ++	char n[GIT_MAX_HEXSZ + 1] = "null";
      +	if (old_oid)
      +		oid_to_hex_r(o, old_oid);
      +	if (new_oid)


 Documentation/git.txt |   4 +
 Makefile              |   1 +
 refs.c                |   1 +
 refs/debug.c          | 398 ++++++++++++++++++++++++++++++++++++++++++
 refs/refs-internal.h  |   5 +
 5 files changed, 409 insertions(+)
 create mode 100644 refs/debug.c

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2f72b10224..c463b937a8 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -722,6 +722,10 @@ of clones and fetches.
 	time of each Git command.
 	See `GIT_TRACE` for available trace output options.
 
+`GIT_TRACE_REFS`::
+	Enables trace messages for operations on the ref database.
+	See `GIT_TRACE` for available trace output options.
+
 `GIT_TRACE_SETUP`::
 	Enables trace messages printing the .git, working tree and current
 	working directory after Git has completed its setup phase.
diff --git a/Makefile b/Makefile
index 86e5411f39..583b8c526e 100644
--- a/Makefile
+++ b/Makefile
@@ -950,6 +950,7 @@ LIB_OBJS += rebase.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
+LIB_OBJS += refs/debug.o
 LIB_OBJS += refs/files-backend.o
 LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
diff --git a/refs.c b/refs.c
index 156fdcd459..5febfe2281 100644
--- a/refs.c
+++ b/refs.c
@@ -1774,6 +1774,7 @@ struct ref_store *get_main_ref_store(struct repository *r)
 		BUG("attempting to get main_ref_store outside of repository");
 
 	r->refs_private = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
+	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
 	return r->refs_private;
 }
 
diff --git a/refs/debug.c b/refs/debug.c
new file mode 100644
index 0000000000..922e64fa6a
--- /dev/null
+++ b/refs/debug.c
@@ -0,0 +1,398 @@
+
+#include "refs-internal.h"
+#include "trace.h"
+
+static struct trace_key trace_refs = TRACE_KEY_INIT(REFS);
+
+struct debug_ref_store {
+	struct ref_store base;
+	struct ref_store *refs;
+};
+
+extern struct ref_storage_be refs_be_debug;
+
+struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store)
+{
+	struct debug_ref_store *res;
+	struct ref_storage_be *be_copy;
+
+	if (!trace_want(&trace_refs)) {
+		return store;
+	}
+	res = xmalloc(sizeof(struct debug_ref_store));
+	be_copy = xmalloc(sizeof(*be_copy));
+	*be_copy = refs_be_debug;
+	/* we never deallocate backends, so safe to copy the pointer. */
+	be_copy->name = store->be->name;
+	trace_printf_key(&trace_refs, "ref_store for %s\n", gitdir);
+	res->refs = store;
+	base_ref_store_init((struct ref_store *)res, be_copy);
+	return (struct ref_store *)res;
+}
+
+static int debug_init_db(struct ref_store *refs, struct strbuf *err)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
+	int res = drefs->refs->be->init_db(drefs->refs, err);
+	trace_printf_key(&trace_refs, "init_db: %d\n", res);
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
+	trace_printf_key(&trace_refs, "transaction_prepare: %d\n", res);
+	return res;
+}
+
+static void print_update(int i, const char *refname,
+			 const struct object_id *old_oid,
+			 const struct object_id *new_oid, unsigned int flags,
+			 unsigned int type, const char *msg)
+{
+	char o[GIT_MAX_HEXSZ + 1] = "null";
+	char n[GIT_MAX_HEXSZ + 1] = "null";
+	if (old_oid)
+		oid_to_hex_r(o, old_oid);
+	if (new_oid)
+		oid_to_hex_r(n, new_oid);
+
+	type &= 0xf; /* see refs.h REF_* */
+	flags &= REF_HAVE_NEW | REF_HAVE_OLD | REF_NO_DEREF |
+		REF_FORCE_CREATE_REFLOG;
+	trace_printf_key(&trace_refs, "%d: %s %s -> %s (F=0x%x, T=0x%x) \"%s\"\n", i, refname,
+		o, n, flags, type, msg);
+}
+
+static void print_transaction(struct ref_transaction *transaction)
+{
+	int i;
+	trace_printf_key(&trace_refs, "transaction {\n");
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *u = transaction->updates[i];
+		print_update(i, u->refname, &u->old_oid, &u->new_oid, u->flags,
+			     u->type, u->msg);
+	}
+	trace_printf_key(&trace_refs, "}\n");
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
+	trace_printf_key(&trace_refs, "finish: %d\n", res);
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
+	trace_printf_key(&trace_refs, "pack_refs: %d\n", res);
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
+	trace_printf_key(&trace_refs, "create_symref: %s -> %s \"%s\": %d\n", ref_name,
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
+	int i;
+	trace_printf_key(&trace_refs, "delete_refs {\n");
+	for (i = 0; i < refnames->nr; i++)
+		trace_printf_key(&trace_refs, "%s\n", refnames->items[i].string);
+	trace_printf_key(&trace_refs, "}: %d\n", res);
+	return res;
+}
+
+static int debug_rename_ref(struct ref_store *ref_store, const char *oldref,
+			    const char *newref, const char *logmsg)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->rename_ref(drefs->refs, oldref, newref,
+					      logmsg);
+	trace_printf_key(&trace_refs, "rename_ref: %s -> %s \"%s\": %d\n", oldref, newref,
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
+	trace_printf_key(&trace_refs, "copy_ref: %s -> %s \"%s\": %d\n", oldref, newref,
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
+		trace_printf_key(&trace_refs, "iterator_advance: (%d)\n", res);
+	else
+		trace_printf_key(&trace_refs, "iterator_advance: %s (0)\n",
+			diter->iter->refname);
+
+	diter->base.ordered = diter->iter->ordered;
+	diter->base.refname = diter->iter->refname;
+	diter->base.oid = diter->iter->oid;
+	diter->base.flags = diter->iter->flags;
+	return res;
+}
+
+static int debug_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				   struct object_id *peeled)
+{
+	struct debug_ref_iterator *diter =
+		(struct debug_ref_iterator *)ref_iterator;
+	int res = diter->iter->vtable->peel(diter->iter, peeled);
+	trace_printf_key(&trace_refs, "iterator_peel: %s: %d\n", diter->iter->refname, res);
+	return res;
+}
+
+static int debug_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct debug_ref_iterator *diter =
+		(struct debug_ref_iterator *)ref_iterator;
+	int res = diter->iter->vtable->abort(diter->iter);
+	trace_printf_key(&trace_refs, "iterator_abort: %d\n", res);
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
+	trace_printf_key(&trace_refs, "ref_iterator_begin: %s (0x%x)\n", prefix, flags);
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
+		trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
+			refname, oid_to_hex(oid), referent->buf, *type, res);
+	} else {
+		trace_printf_key(&trace_refs, "read_raw_ref: %s: %d\n", refname, res);
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
+	trace_printf_key(&trace_refs, "for_each_reflog_iterator_begin\n");
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
+	char o[GIT_MAX_HEXSZ + 1] = "null";
+	char n[GIT_MAX_HEXSZ + 1] = "null";
+	if (old_oid)
+		oid_to_hex_r(o, old_oid);
+	if (new_oid)
+		oid_to_hex_r(n, new_oid);
+
+	ret = dbg->fn(old_oid, new_oid, committer, timestamp, tz, msg,
+		      dbg->cb_data);
+	trace_printf_key(&trace_refs, "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
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
+	trace_printf_key(&trace_refs, "for_each_reflog: %s: %d\n", refname, res);
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
+	trace_printf_key(&trace_refs, "for_each_reflog_reverse: %s: %d\n", refname, res);
+	return res;
+}
+
+static int debug_reflog_exists(struct ref_store *ref_store, const char *refname)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->reflog_exists(drefs->refs, refname);
+	trace_printf_key(&trace_refs, "reflog_exists: %s: %d\n", refname, res);
+	return res;
+}
+
+static int debug_create_reflog(struct ref_store *ref_store, const char *refname,
+			       int force_create, struct strbuf *err)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->create_reflog(drefs->refs, refname,
+						 force_create, err);
+	trace_printf_key(&trace_refs, "create_reflog: %s: %d\n", refname, res);
+	return res;
+}
+
+static int debug_delete_reflog(struct ref_store *ref_store, const char *refname)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->delete_reflog(drefs->refs, refname);
+	trace_printf_key(&trace_refs, "delete_reflog: %s: %d\n", refname, res);
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
+	trace_printf_key(&trace_refs, "reflog_expire: %s: %d\n", refname, res);
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
index 527b0a6e2e..fecde40baf 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -690,4 +690,9 @@ int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 void base_ref_store_init(struct ref_store *refs,
 			 const struct ref_storage_be *be);
 
+/*
+ * Support GIT_TRACE_REFS by optionally wrapping the given ref_store instance.
+ */
+struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store);
+
 #endif /* REFS_REFS_INTERNAL_H */

base-commit: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a
-- 
gitgitgadget
