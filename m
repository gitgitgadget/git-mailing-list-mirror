Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15B691F516
	for <e@80x24.org>; Thu, 12 Apr 2018 00:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeDLAVl (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 20:21:41 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45827 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbeDLAVd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 20:21:33 -0400
Received: by mail-pl0-f65.google.com with SMTP id e22-v6so2603174plj.12
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 17:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QIXdjGdAykQIYeXNj5fxECgoXlys2ZnEnloD3wexqkA=;
        b=eE+HOCnLij+sDlPlKFbjsfuQZRrSbiWcCb4qJGdVuRB4orTJX0tvSwDvQgSmjA/5fV
         As3FVSvhs8OBXy2rt8GEig1AU6Xp4Q1m5eAF4PkA4o0mD/FGXn15wpqp1t+3zQkB8KhQ
         eWGvsnU9j5NmsYZ3h9/lg06ucHhrJRwfB6St3lIMS+eqt1cBWDoBEfU/g9knHZww/d19
         fM2cTShC00Ghbcj0DFPIm/6USuflH0hS+U4IKv2mixp6yeFaBl23fWrTBpNZAikiX2VJ
         gZimE1ic0oVWexybfqbySIpvCEO7nJzges3a48nvQLnTenDocJ7tW7Snhp45nwq0DgEV
         N+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QIXdjGdAykQIYeXNj5fxECgoXlys2ZnEnloD3wexqkA=;
        b=UTtLIrF+QTnCc+6s+AuIh0voBCwosxkGGP0lGUe3T6G8AYgcXAhcAffsYLJYZplpce
         jcNF5Gdqwzvtbs6uYgdz3Df/I7d/ERfKp+cf1FKHF5dY1vSytVhYEWSxZoiY4oOrXroU
         E97Kfy5/VRzveAU7Izxwkc8sPq+Nsc7zXmWlkIePg7hTLC4SLdFEsxRA/IbVxSVphXd3
         IgjVZJIMjhJpTeFMQWKEAT5SnCcSDoJ5rxCFhelc/u57mH7arlQT5qCsgC1DWd5BqAvd
         ccPWGX1CRy5tks4EN5+GI2d2oRg0rFJi0LPQA6vdxTUFIB/f3RQZ7BgEO2QyL6rGO6jp
         FpCA==
X-Gm-Message-State: ALQs6tCJekfCOQudaqcx5BDftRASRsMnX8N8T7M0DNawZQilbDdHlPGQ
        RIyfmBGHctj8+JHhy+4u0SIoyQ==
X-Google-Smtp-Source: AIpwx49ZTfJOrKSk/qgVt5KiLiAYA5AnU51q5dgrDujR60TLagGlVDlY/qL+8K5UMm2FJqS3LhXX+A==
X-Received: by 2002:a17:902:c24:: with SMTP id 33-v6mr7429428pls.88.1523492493047;
        Wed, 11 Apr 2018 17:21:33 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id j20sm5322805pfa.149.2018.04.11.17.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 17:21:32 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, l.s.r@web.de,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com, Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/15] refs: add repository argument to get_main_ref_store
Date:   Wed, 11 Apr 2018 17:21:09 -0700
Message-Id: <20180412002118.102976-7-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180412002118.102976-1-sbeller@google.com>
References: <20180409224533.17764-1-sbeller@google.com>
 <20180412002118.102976-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the get_main_ref_store caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/pack-refs.c       |  3 +-
 refs.c                    | 67 ++++++++++++++++++++-------------------
 refs.h                    |  4 ++-
 revision.c                |  5 +--
 t/helper/test-ref-store.c |  3 +-
 5 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index b106a392a4..f3353564f9 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "refs.h"
+#include "repository.h"
 
 static char const * const pack_refs_usage[] = {
 	N_("git pack-refs [<options>]"),
@@ -17,5 +18,5 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 	};
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
-	return refs_pack_refs(get_main_ref_store(), flags);
+	return refs_pack_refs(get_main_ref_store(the_repository), flags);
 }
diff --git a/refs.c b/refs.c
index 8b7a77fe5e..74d4ed97cb 100644
--- a/refs.c
+++ b/refs.c
@@ -13,6 +13,7 @@
 #include "tag.h"
 #include "submodule.h"
 #include "worktree.h"
+#include "repository.h"
 
 /*
  * List of all available backends
@@ -206,7 +207,7 @@ char *refs_resolve_refdup(struct ref_store *refs,
 char *resolve_refdup(const char *refname, int resolve_flags,
 		     struct object_id *oid, int *flags)
 {
-	return refs_resolve_refdup(get_main_ref_store(),
+	return refs_resolve_refdup(get_main_ref_store(the_repository),
 				   refname, resolve_flags,
 				   oid, flags);
 }
@@ -228,7 +229,7 @@ int refs_read_ref_full(struct ref_store *refs, const char *refname,
 
 int read_ref_full(const char *refname, int resolve_flags, struct object_id *oid, int *flags)
 {
-	return refs_read_ref_full(get_main_ref_store(), refname,
+	return refs_read_ref_full(get_main_ref_store(the_repository), refname,
 				  resolve_flags, oid, flags);
 }
 
@@ -375,7 +376,7 @@ int refs_for_each_tag_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 
 int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_tag_ref(get_main_ref_store(), fn, cb_data);
+	return refs_for_each_tag_ref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
 int refs_for_each_branch_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
@@ -385,7 +386,7 @@ int refs_for_each_branch_ref(struct ref_store *refs, each_ref_fn fn, void *cb_da
 
 int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_branch_ref(get_main_ref_store(), fn, cb_data);
+	return refs_for_each_branch_ref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
 int refs_for_each_remote_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
@@ -395,7 +396,7 @@ int refs_for_each_remote_ref(struct ref_store *refs, each_ref_fn fn, void *cb_da
 
 int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_remote_ref(get_main_ref_store(), fn, cb_data);
+	return refs_for_each_remote_ref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
@@ -730,7 +731,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 	struct strbuf err = STRBUF_INIT;
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
-		assert(refs == get_main_ref_store());
+		assert(refs == get_main_ref_store(the_repository));
 		return delete_pseudoref(refname, old_oid);
 	}
 
@@ -752,7 +753,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 int delete_ref(const char *msg, const char *refname,
 	       const struct object_id *old_oid, unsigned int flags)
 {
-	return refs_delete_ref(get_main_ref_store(), msg, refname,
+	return refs_delete_ref(get_main_ref_store(the_repository), msg, refname,
 			       old_oid, flags);
 }
 
@@ -928,7 +929,7 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
-	return ref_store_transaction_begin(get_main_ref_store(), err);
+	return ref_store_transaction_begin(get_main_ref_store(the_repository), err);
 }
 
 void ref_transaction_free(struct ref_transaction *transaction)
@@ -1060,7 +1061,7 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 	int ret = 0;
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
-		assert(refs == get_main_ref_store());
+		assert(refs == get_main_ref_store(the_repository));
 		ret = write_pseudoref(refname, new_oid, old_oid, &err);
 	} else {
 		t = ref_store_transaction_begin(refs, &err);
@@ -1099,7 +1100,7 @@ int update_ref(const char *msg, const char *refname,
 	       const struct object_id *old_oid,
 	       unsigned int flags, enum action_on_err onerr)
 {
-	return refs_update_ref(get_main_ref_store(), msg, refname, new_oid,
+	return refs_update_ref(get_main_ref_store(the_repository), msg, refname, new_oid,
 			       old_oid, flags, onerr);
 }
 
@@ -1320,7 +1321,7 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 
 int head_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_head_ref(get_main_ref_store(), fn, cb_data);
+	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
 struct ref_iterator *refs_ref_iterator_begin(
@@ -1379,7 +1380,7 @@ int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref(get_main_ref_store(), fn, cb_data);
+	return refs_for_each_ref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
@@ -1390,7 +1391,7 @@ int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
 
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref_in(get_main_ref_store(), prefix, fn, cb_data);
+	return refs_for_each_ref_in(get_main_ref_store(the_repository), prefix, fn, cb_data);
 }
 
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
@@ -1399,7 +1400,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsig
 
 	if (broken)
 		flag = DO_FOR_EACH_INCLUDE_BROKEN;
-	return do_for_each_ref(get_main_ref_store(),
+	return do_for_each_ref(get_main_ref_store(the_repository),
 			       prefix, fn, 0, flag, cb_data);
 }
 
@@ -1416,7 +1417,7 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_main_ref_store(),
+	return do_for_each_ref(get_main_ref_store(the_repository),
 			       git_replace_ref_base, fn,
 			       strlen(git_replace_ref_base),
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
@@ -1427,7 +1428,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
-	ret = do_for_each_ref(get_main_ref_store(),
+	ret = do_for_each_ref(get_main_ref_store(the_repository),
 			      buf.buf, fn, 0, 0, cb_data);
 	strbuf_release(&buf);
 	return ret;
@@ -1441,7 +1442,7 @@ int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_rawref(get_main_ref_store(), fn, cb_data);
+	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
 int refs_read_raw_ref(struct ref_store *ref_store,
@@ -1547,7 +1548,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 /* backend functions */
 int refs_init_db(struct strbuf *err)
 {
-	struct ref_store *refs = get_main_ref_store();
+	struct ref_store *refs = get_main_ref_store(the_repository);
 
 	return refs->be->init_db(refs, err);
 }
@@ -1555,7 +1556,7 @@ int refs_init_db(struct strbuf *err)
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       struct object_id *oid, int *flags)
 {
-	return refs_resolve_ref_unsafe(get_main_ref_store(), refname,
+	return refs_resolve_ref_unsafe(get_main_ref_store(the_repository), refname,
 				       resolve_flags, oid, flags);
 }
 
@@ -1651,7 +1652,7 @@ static struct ref_store *ref_store_init(const char *gitdir,
 	return refs;
 }
 
-struct ref_store *get_main_ref_store(void)
+struct ref_store *get_main_ref_store_the_repository(void)
 {
 	if (main_ref_store)
 		return main_ref_store;
@@ -1726,7 +1727,7 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 	const char *id;
 
 	if (wt->is_current)
-		return get_main_ref_store();
+		return get_main_ref_store(the_repository);
 
 	id = wt->id ? wt->id : "/";
 	refs = lookup_ref_store_map(&worktree_ref_stores, id);
@@ -1782,7 +1783,7 @@ int refs_peel_ref(struct ref_store *refs, const char *refname,
 
 int peel_ref(const char *refname, struct object_id *oid)
 {
-	return refs_peel_ref(get_main_ref_store(), refname, oid);
+	return refs_peel_ref(get_main_ref_store(the_repository), refname, oid);
 }
 
 int refs_create_symref(struct ref_store *refs,
@@ -1798,7 +1799,7 @@ int refs_create_symref(struct ref_store *refs,
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-	return refs_create_symref(get_main_ref_store(), ref_target,
+	return refs_create_symref(get_main_ref_store(the_repository), ref_target,
 				  refs_heads_master, logmsg);
 }
 
@@ -2006,7 +2007,7 @@ int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 
 int for_each_reflog(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_reflog(get_main_ref_store(), fn, cb_data);
+	return refs_for_each_reflog(get_main_ref_store(the_repository), fn, cb_data);
 }
 
 int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
@@ -2021,7 +2022,7 @@ int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
 				void *cb_data)
 {
-	return refs_for_each_reflog_ent_reverse(get_main_ref_store(),
+	return refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repository),
 						refname, fn, cb_data);
 }
 
@@ -2034,7 +2035,7 @@ int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn,
 			void *cb_data)
 {
-	return refs_for_each_reflog_ent(get_main_ref_store(), refname,
+	return refs_for_each_reflog_ent(get_main_ref_store(the_repository), refname,
 					fn, cb_data);
 }
 
@@ -2045,7 +2046,7 @@ int refs_reflog_exists(struct ref_store *refs, const char *refname)
 
 int reflog_exists(const char *refname)
 {
-	return refs_reflog_exists(get_main_ref_store(), refname);
+	return refs_reflog_exists(get_main_ref_store(the_repository), refname);
 }
 
 int refs_create_reflog(struct ref_store *refs, const char *refname,
@@ -2057,7 +2058,7 @@ int refs_create_reflog(struct ref_store *refs, const char *refname,
 int safe_create_reflog(const char *refname, int force_create,
 		       struct strbuf *err)
 {
-	return refs_create_reflog(get_main_ref_store(), refname,
+	return refs_create_reflog(get_main_ref_store(the_repository), refname,
 				  force_create, err);
 }
 
@@ -2068,7 +2069,7 @@ int refs_delete_reflog(struct ref_store *refs, const char *refname)
 
 int delete_reflog(const char *refname)
 {
-	return refs_delete_reflog(get_main_ref_store(), refname);
+	return refs_delete_reflog(get_main_ref_store(the_repository), refname);
 }
 
 int refs_reflog_expire(struct ref_store *refs,
@@ -2091,7 +2092,7 @@ int reflog_expire(const char *refname, const struct object_id *oid,
 		  reflog_expiry_cleanup_fn cleanup_fn,
 		  void *policy_cb_data)
 {
-	return refs_reflog_expire(get_main_ref_store(),
+	return refs_reflog_expire(get_main_ref_store(the_repository),
 				  refname, oid, flags,
 				  prepare_fn, should_prune_fn,
 				  cleanup_fn, policy_cb_data);
@@ -2114,7 +2115,7 @@ int refs_delete_refs(struct ref_store *refs, const char *msg,
 int delete_refs(const char *msg, struct string_list *refnames,
 		unsigned int flags)
 {
-	return refs_delete_refs(get_main_ref_store(), msg, refnames, flags);
+	return refs_delete_refs(get_main_ref_store(the_repository), msg, refnames, flags);
 }
 
 int refs_rename_ref(struct ref_store *refs, const char *oldref,
@@ -2125,7 +2126,7 @@ int refs_rename_ref(struct ref_store *refs, const char *oldref,
 
 int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 {
-	return refs_rename_ref(get_main_ref_store(), oldref, newref, logmsg);
+	return refs_rename_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
 }
 
 int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
@@ -2136,5 +2137,5 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 
 int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg)
 {
-	return refs_copy_existing_ref(get_main_ref_store(), oldref, newref, logmsg);
+	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
 }
diff --git a/refs.h b/refs.h
index 01be5ae32f..0d013377ce 100644
--- a/refs.h
+++ b/refs.h
@@ -758,7 +758,9 @@ int reflog_expire(const char *refname, const struct object_id *oid,
 
 int ref_storage_backend_exists(const char *name);
 
-struct ref_store *get_main_ref_store(void);
+#define get_main_ref_store(r) \
+	get_main_ref_store_##r()
+struct ref_store *get_main_ref_store_the_repository(void);
 /*
  * Return the ref_store instance for the specified submodule. For the
  * main repository, use submodule==NULL; such a call cannot fail. For
diff --git a/revision.c b/revision.c
index b42c836d7a..1cff11833e 100644
--- a/revision.c
+++ b/revision.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "refs.h"
 #include "revision.h"
+#include "repository.h"
 #include "graph.h"
 #include "grep.h"
 #include "reflog-walk.h"
@@ -1285,7 +1286,7 @@ void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 
 	cb.all_revs = revs;
 	cb.all_flags = flags;
-	cb.refs = get_main_ref_store();
+	cb.refs = get_main_ref_store(the_repository);
 	for_each_reflog(handle_one_reflog, &cb);
 
 	if (!revs->single_worktree)
@@ -2176,7 +2177,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 			die("BUG: --single-worktree cannot be used together with submodule");
 		refs = get_submodule_ref_store(submodule);
 	} else
-		refs = get_main_ref_store();
+		refs = get_main_ref_store(the_repository);
 
 	/*
 	 * NOTE!
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 7314b5943e..e8c328ec0e 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "worktree.h"
 #include "object-store.h"
+#include "repository.h"
 
 static const char *notnull(const char *arg, const char *name)
 {
@@ -22,7 +23,7 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 	if (!argv[0]) {
 		die("ref store required");
 	} else if (!strcmp(argv[0], "main")) {
-		*refs = get_main_ref_store();
+		*refs = get_main_ref_store(the_repository);
 	} else if (skip_prefix(argv[0], "submodule:", &gitdir)) {
 		struct strbuf sb = STRBUF_INIT;
 		int ret;
-- 
2.17.0.484.g0c8726318c-goog

