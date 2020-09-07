Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39525C433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 15:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BF72078E
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 15:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFOOU8ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgIGPZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730183AbgIGPYk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 11:24:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A418CC061573
        for <git@vger.kernel.org>; Mon,  7 Sep 2020 08:24:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v4so14552770wmj.5
        for <git@vger.kernel.org>; Mon, 07 Sep 2020 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MWcB7XTYz23MaQQ8Ua1nm/xA201HLneBhpZ7t1QzB6o=;
        b=ZFOOU8ieAMlWCQyO5GPRRJh04f3yCUtF98fgHIdf2pOwgHtlBAwXrflcMegzoVhYv6
         LkKfMVBVvzOG/Aa7s+XJUat4FR2+EWFT47NMD3DwZy3dD146QOj6nDax6o8b8Cns9gRM
         a1MfKe/PmfPTHAkcEZgP/ZltSTyujaEZ1vC/OJk618gdT6S9NjvRwkpnSbhHSMU9Nv8Y
         TG4NL6V+87594qViLrwFiHfkls4GHVo2AIB/muM4/5eG4gG7qfaAi0uzJMvclHhJCXHd
         dyXHoaKkt3ndEd0B1B65oIIOXvE188TyfzC+XXR1t9lXtQCf4LZ9lPvUHymQ9Z1MpchI
         tdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MWcB7XTYz23MaQQ8Ua1nm/xA201HLneBhpZ7t1QzB6o=;
        b=H3DobMSIDZqgKw9/9nVd06Ak2hQFfzKQvcS49mTesWV6Ey72eqGKbrbFzzG4X058O8
         2lmklQ3aZkVeV2XTxrQPxeXNeBqomLYrAPXu3MX24qZMd7yVRLDcZBfRcJ99htAL59VX
         Oyxfi0/Myni+qs6rUYZJWc5nyCcRb/PAXeNxJmuXFYVjyMwRgdJgWMD3MkDbui+z6B5e
         dx7+g7D6v4nKrEGRWeH1QLOE+7s5jyU3cZnfyj23thKeOcsDEd8RIlyn3quB7osAZGvE
         O/r8wrTO6dXm0hVhyrn4Oww/uRRbOluaq19CpbRO2AbPELu/4l92/zNkgyDEcDtuaomL
         PNsg==
X-Gm-Message-State: AOAM532yz+1lCbu/AH48JaArDRilU7WeaBtsUlFRDs6frNvgwyE0ygsp
        VAMC6Lch/sKCTOoMDnWr2wjA7SoH+hA=
X-Google-Smtp-Source: ABdhPJyqI1WHMMV5OsxRHvBGpT5lGoDs0rm45TOlGWMJAqvXkh79g9TPSF1yXZ/Pu3RndhYxYGriUw==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr20254185wmk.125.1599492276624;
        Mon, 07 Sep 2020 08:24:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d3sm21674352wrr.84.2020.09.07.08.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 08:24:36 -0700 (PDT)
Message-Id: <pull.713.v2.git.1599492274909.gitgitgadget@gmail.com>
In-Reply-To: <pull.713.git.1598628529512.gitgitgadget@gmail.com>
References: <pull.713.git.1598628529512.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Sep 2020 15:24:34 +0000
Subject: [PATCH v2] refs: add GIT_TRACE_REFS debugging mechanism
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-713%2Fhanwen%2Fdebug-refs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-713/hanwen/debug-refs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/713

Range-diff vs v1:

 1:  4d045e35be ! 1:  19330e894c RFC: refs: add GIT_DEBUG_REFS debugging mechanism
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    RFC: refs: add GIT_DEBUG_REFS debugging mechanism
     +    refs: add GIT_TRACE_REFS debugging mechanism
      
     -    When set in the environment, GIT_DEBUG_REFS makes git print operations and
     +    When set in the environment, GIT_TRACE_REFS makes git print operations and
          results as they flow through the ref storage backend. This helps debug
          discrepancies between different ref backends.
      
     -    This should be integrated with the trace2 sub-system, and I would appreciate
     -    pointers on how to start.
     -
          Example:
      
     -        $ GIT_DEBUG_REFS=1 ./git branch
     -        ref_store for .git
     -        read_raw_ref: HEAD: 0000000000000000000000000000000000000000 (=> refs/heads/ref-debug) type 1: 0
     -        read_raw_ref: refs/heads/ref-debug: b0728cf8cb9dfd395bea41c646f48108c99230c0 (=> refs/heads/ref-debug) type 0: 0
     -        ref_iterator_begin: refs/heads/ (0x1)
     -        iterator_advance before: refs/heads/b4
     -        iterator_advance before: refs/heads/bla
     -        ...
     +        $ GIT_TRACE_REFS="1" ./git branch
     +        15:42:09.769631 refs/debug.c:26         ref_store for .git
     +        15:42:09.769681 refs/debug.c:249        read_raw_ref: HEAD: 0000000000000000000000000000000000000000 (=> refs/heads/ref-debug) type 1: 0
     +        15:42:09.769695 refs/debug.c:249        read_raw_ref: refs/heads/ref-debug: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a (=> refs/heads/ref-debug) type 0: 0
     +        15:42:09.770282 refs/debug.c:233        ref_iterator_begin: refs/heads/ (0x1)
     +        15:42:09.770290 refs/debug.c:189        iterator_advance: refs/heads/b4 (0)
     +        15:42:09.770295 refs/debug.c:189        iterator_advance: refs/heads/branch3 (0)
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     + ## Documentation/git.txt ##
     +@@ Documentation/git.txt: of clones and fetches.
     + 	time of each Git command.
     + 	See `GIT_TRACE` for available trace output options.
     + 
     ++`GIT_TRACE_REFS`::
     ++	Enables trace messages for operations on the ref database.
     ++	See `GIT_TRACE` for available trace output options.
     ++
     + `GIT_TRACE_SETUP`::
     + 	Enables trace messages printing the .git, working tree and current
     + 	working directory after Git has completed its setup phase.
     +
       ## Makefile ##
      @@ Makefile: LIB_OBJS += rebase.o
       LIB_OBJS += ref-filter.o
     @@ refs.c: struct ref_store *get_main_ref_store(struct repository *r)
       		BUG("attempting to get main_ref_store outside of repository");
       
       	r->refs_private = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
     -+	if (getenv("GIT_DEBUG_REFS")) {
     -+		// XXX - how to hook this up with the trace2 framework?
     -+		r->refs_private = debug_wrap(r->gitdir, r->refs_private);
     -+	}
     ++	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
       	return r->refs_private;
       }
       
     @@ refs/debug.c (new)
      @@
      +
      +#include "refs-internal.h"
     ++#include "trace.h"
     ++
     ++static struct trace_key trace_refs = TRACE_KEY_INIT(REFS);
      +
      +struct debug_ref_store {
      +	struct ref_store base;
     @@ refs/debug.c (new)
      +};
      +
      +extern struct ref_storage_be refs_be_debug;
     -+struct ref_store *debug_wrap(const char *gitdir, struct ref_store *store);
      +
     -+struct ref_store *debug_wrap(const char *gitdir, struct ref_store *store)
     ++struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store)
      +{
     -+	struct debug_ref_store *res = malloc(sizeof(struct debug_ref_store));
     -+	struct ref_storage_be *be_copy = malloc(sizeof(*be_copy));
     ++	struct debug_ref_store *res;
     ++	struct ref_storage_be *be_copy;
     ++
     ++	if (!trace_want(&trace_refs)) {
     ++		return store;
     ++	}
     ++	res = malloc(sizeof(struct debug_ref_store));
     ++	be_copy = malloc(sizeof(*be_copy));
      +	*be_copy = refs_be_debug;
      +	be_copy->name = store->be->name;
     -+	fprintf(stderr, "ref_store for %s\n", gitdir);
     ++	trace_printf_key(&trace_refs, "ref_store for %s\n", gitdir);
      +	res->refs = store;
      +	base_ref_store_init((struct ref_store *)res, be_copy);
      +	return (struct ref_store *)res;
     @@ refs/debug.c (new)
      +{
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
      +	int res = drefs->refs->be->init_db(drefs->refs, err);
     -+	fprintf(stderr, "init_db: %d\n", res);
     ++	trace_printf_key(&trace_refs, "init_db: %d\n", res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	transaction->ref_store = drefs->refs;
      +	res = drefs->refs->be->transaction_prepare(drefs->refs, transaction,
      +						   err);
     -+	fprintf(stderr, "transaction_prepare: %d\n", res);
     ++	trace_printf_key(&trace_refs, "transaction_prepare: %d\n", res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +
      +	type &= 0xf; /* see refs.h REF_* */
      +	flags &= REF_HAVE_NEW | REF_HAVE_OLD | REF_NO_DEREF |
     -+		REF_FORCE_CREATE_REFLOG; // XXX: LOG_ONLY
     -+	fprintf(stderr, "%d: %s %s -> %s (F=0x%x, T=0x%x) \"%s\"\n", i, refname,
     ++		REF_FORCE_CREATE_REFLOG;
     ++	trace_printf_key(&trace_refs, "%d: %s %s -> %s (F=0x%x, T=0x%x) \"%s\"\n", i, refname,
      +		o, n, flags, type, msg);
      +}
      +
      +static void print_transaction(struct ref_transaction *transaction)
      +{
     -+	fprintf(stderr, "transaction {\n");
     ++	trace_printf_key(&trace_refs, "transaction {\n");
      +	for (int i = 0; i < transaction->nr; i++) {
      +		struct ref_update *u = transaction->updates[i];
      +		print_update(i, u->refname, &u->old_oid, &u->new_oid, u->flags,
      +			     u->type, u->msg);
      +	}
     -+	fprintf(stderr, "}\n");
     ++	trace_printf_key(&trace_refs, "}\n");
      +}
      +
      +static int debug_transaction_finish(struct ref_store *refs,
     @@ refs/debug.c (new)
      +	res = drefs->refs->be->transaction_finish(drefs->refs, transaction,
      +						  err);
      +	print_transaction(transaction);
     -+	fprintf(stderr, "finish: %d\n", res);
     ++	trace_printf_key(&trace_refs, "finish: %d\n", res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +{
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res = drefs->refs->be->pack_refs(drefs->refs, flags);
     -+	fprintf(stderr, "pack_refs: %d\n", res);
     ++	trace_printf_key(&trace_refs, "pack_refs: %d\n", res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res = drefs->refs->be->create_symref(drefs->refs, ref_name, target,
      +						 logmsg);
     -+	fprintf(stderr, "create_symref: %s -> %s \"%s\": %d\n", ref_name,
     ++	trace_printf_key(&trace_refs, "create_symref: %s -> %s \"%s\": %d\n", ref_name,
      +		target, logmsg, res);
      +	return res;
      +}
     @@ refs/debug.c (new)
      +	int res =
      +		drefs->refs->be->delete_refs(drefs->refs, msg, refnames, flags);
      +	int i = 0;
     -+	fprintf(stderr, "delete_refs {\n");
     ++	trace_printf_key(&trace_refs, "delete_refs {\n");
      +	for (i = 0; i < refnames->nr; i++)
     -+		fprintf(stderr, "%s\n", refnames->items[i].string);
     -+	fprintf(stderr, "}: %d\n", res);
     ++		trace_printf_key(&trace_refs, "%s\n", refnames->items[i].string);
     ++	trace_printf_key(&trace_refs, "}: %d\n", res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res = drefs->refs->be->rename_ref(drefs->refs, oldref, newref,
      +					      logmsg);
     -+	fprintf(stderr, "rename_ref: %s -> %s \"%s\": %d\n", oldref, newref,
     ++	trace_printf_key(&trace_refs, "rename_ref: %s -> %s \"%s\": %d\n", oldref, newref,
      +		logmsg, res);
      +	return res;
      +}
     @@ refs/debug.c (new)
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res =
      +		drefs->refs->be->copy_ref(drefs->refs, oldref, newref, logmsg);
     -+	fprintf(stderr, "copy_ref: %s -> %s \"%s\": %d\n", oldref, newref,
     ++	trace_printf_key(&trace_refs, "copy_ref: %s -> %s \"%s\": %d\n", oldref, newref,
      +		logmsg, res);
      +	return res;
      +}
     @@ refs/debug.c (new)
      +		(struct debug_ref_iterator *)ref_iterator;
      +	int res = diter->iter->vtable->advance(diter->iter);
      +	if (res)
     -+		fprintf(stderr, "iterator_advance: %d\n", res);
     ++		trace_printf_key(&trace_refs, "iterator_advance: (%d)\n", res);
      +	else
     -+		fprintf(stderr, "iterator_advance before: %s\n",
     ++		trace_printf_key(&trace_refs, "iterator_advance: %s (0)\n",
      +			diter->iter->refname);
      +
      +	diter->base.ordered = diter->iter->ordered;
     @@ refs/debug.c (new)
      +	diter->base.flags = diter->iter->flags;
      +	return res;
      +}
     ++
      +static int debug_ref_iterator_peel(struct ref_iterator *ref_iterator,
      +				   struct object_id *peeled)
      +{
      +	struct debug_ref_iterator *diter =
      +		(struct debug_ref_iterator *)ref_iterator;
      +	int res = diter->iter->vtable->peel(diter->iter, peeled);
     -+	fprintf(stderr, "iterator_peel: %s: %d\n", diter->iter->refname, res);
     ++	trace_printf_key(&trace_refs, "iterator_peel: %s: %d\n", diter->iter->refname, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	struct debug_ref_iterator *diter =
      +		(struct debug_ref_iterator *)ref_iterator;
      +	int res = diter->iter->vtable->abort(diter->iter);
     -+	fprintf(stderr, "iterator_abort: %d\n", res);
     ++	trace_printf_key(&trace_refs, "iterator_abort: %d\n", res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	struct debug_ref_iterator *diter = xcalloc(1, sizeof(*diter));
      +	base_ref_iterator_init(&diter->base, &debug_ref_iterator_vtable, 1);
      +	diter->iter = res;
     -+	fprintf(stderr, "ref_iterator_begin: %s (0x%x)\n", prefix, flags);
     ++	trace_printf_key(&trace_refs, "ref_iterator_begin: %s (0x%x)\n", prefix, flags);
      +	return &diter->base;
      +}
      +
     @@ refs/debug.c (new)
      +					    type);
      +
      +	if (res == 0) {
     -+		fprintf(stderr, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
     ++		trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
      +			refname, oid_to_hex(oid), referent->buf, *type, res);
      +	} else {
     -+		fprintf(stderr, "read_raw_ref: %s err %d\n", refname, res);
     ++		trace_printf_key(&trace_refs, "read_raw_ref: %s: %d\n", refname, res);
      +	}
      +	return res;
      +}
     @@ refs/debug.c (new)
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	struct ref_iterator *res =
      +		drefs->refs->be->reflog_iterator_begin(drefs->refs);
     -+	fprintf(stderr, "for_each_reflog_iterator_begin\n");
     ++	trace_printf_key(&trace_refs, "for_each_reflog_iterator_begin\n");
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +
      +	ret = dbg->fn(old_oid, new_oid, committer, timestamp, tz, msg,
      +		      dbg->cb_data);
     -+	fprintf(stderr, "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
     ++	trace_printf_key(&trace_refs, "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
      +		dbg->refname, ret, o, n, committer, (long int)timestamp, msg);
      +	return ret;
      +}
     @@ refs/debug.c (new)
      +
      +	int res = drefs->refs->be->for_each_reflog_ent(
      +		drefs->refs, refname, &debug_print_reflog_ent, &dbg);
     -+	fprintf(stderr, "for_each_reflog: %s: %d\n", refname, res);
     ++	trace_printf_key(&trace_refs, "for_each_reflog: %s: %d\n", refname, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	};
      +	int res = drefs->refs->be->for_each_reflog_ent_reverse(
      +		drefs->refs, refname, &debug_print_reflog_ent, &dbg);
     -+	fprintf(stderr, "for_each_reflog_reverse: %s: %d\n", refname, res);
     ++	trace_printf_key(&trace_refs, "for_each_reflog_reverse: %s: %d\n", refname, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +{
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res = drefs->refs->be->reflog_exists(drefs->refs, refname);
     -+	fprintf(stderr, "reflog_exists: %s: %d\n", refname, res);
     ++	trace_printf_key(&trace_refs, "reflog_exists: %s: %d\n", refname, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res = drefs->refs->be->create_reflog(drefs->refs, refname,
      +						 force_create, err);
     -+	fprintf(stderr, "create_reflog: %s: %d\n", refname, res);
     ++	trace_printf_key(&trace_refs, "create_reflog: %s: %d\n", refname, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +{
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res = drefs->refs->be->delete_reflog(drefs->refs, refname);
     -+	fprintf(stderr, "delete_reflog: %s: %d\n", refname, res);
     ++	trace_printf_key(&trace_refs, "delete_reflog: %s: %d\n", refname, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +						 flags, prepare_fn,
      +						 should_prune_fn, cleanup_fn,
      +						 policy_cb_data);
     -+	fprintf(stderr, "reflog_expire: %s: %d\n", refname, res);
     ++	trace_printf_key(&trace_refs, "reflog_expire: %s: %d\n", refname, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +};
      
       ## refs/refs-internal.h ##
     -@@ refs/refs-internal.h: struct ref_store {
     +@@ refs/refs-internal.h: int parse_loose_ref_contents(const char *buf, struct object_id *oid,
       void base_ref_store_init(struct ref_store *refs,
       			 const struct ref_storage_be *be);
       
      +/*
     -+ * Print out ref operations as they occur. Useful for debugging alternate ref
     -+ * backends.
     ++ * Support GIT_TRACE_REFS by optionally wrapping the given ref_store instance.
      + */
     -+struct ref_store *debug_wrap(const char *gitdir, struct ref_store *store);
     ++struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store);
      +
       #endif /* REFS_REFS_INTERNAL_H */


 Documentation/git.txt |   4 +
 Makefile              |   1 +
 refs.c                |   1 +
 refs/debug.c          | 396 ++++++++++++++++++++++++++++++++++++++++++
 refs/refs-internal.h  |   5 +
 5 files changed, 407 insertions(+)
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
index 0000000000..68ae531b45
--- /dev/null
+++ b/refs/debug.c
@@ -0,0 +1,396 @@
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
+	res = malloc(sizeof(struct debug_ref_store));
+	be_copy = malloc(sizeof(*be_copy));
+	*be_copy = refs_be_debug;
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
+	char o[200] = "null";
+	char n[200] = "null";
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
+	trace_printf_key(&trace_refs, "transaction {\n");
+	for (int i = 0; i < transaction->nr; i++) {
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
+	int i = 0;
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
+	char o[100] = "null";
+	char n[100] = "null";
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
