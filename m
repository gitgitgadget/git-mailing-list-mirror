Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB2C51F597
	for <e@80x24.org>; Fri, 27 Jul 2018 00:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbeG0B4g (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 21:56:36 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:54431 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731922AbeG0B4g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 21:56:36 -0400
Received: by mail-io0-f202.google.com with SMTP id d11-v6so2405956iok.21
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 17:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZgcIesslwot5BjBVjQdQh4XcZcSP03VE5JdkxxvnpR0=;
        b=sDwUmpb9YwHI/BBggDUVLhnyyRRt1jNG+0CZXaSmb1BnKqmaJjpNVNh0db/Y9lFxUX
         AtfRav+3vaK7rwy7czblK/WRww3CI+Fk3u4F9oo/dZkkapR7MPagVZs7H6uWIfOpz58t
         e4TrBeTq8Jq7WrN4pbZerXZZM/Vb3ER2ZQ/fN9NN0jnS8weLbl9lZ3ytoog+aECr3SA3
         blXzd1XRGw8Q1avJF0eyizR2DZwQjy5FnO5gSGZnQEXGoi/Vi/D1wpQH4xS70p3aBxtM
         0T3o3NiIdMt5RDWKu7abOM070Af4PS7IHpfb8gmf4pucpuWCMOKqeKG69q0qDzNvxIts
         BKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZgcIesslwot5BjBVjQdQh4XcZcSP03VE5JdkxxvnpR0=;
        b=o91hf54SDI8i873pedzR/e8Uxy3GwqwVDZWEC1/Iv+s53ERpY0ler544asIwe6EN/S
         btwo1FaAciZRkrASh5YS72iYe5ppaUC+VDhxD4jaT4vC4bHWnMTmg3pj1zxDq9GMqTjx
         Fimb5UdSjzux0ZqRXvkdDG5Q5JSMzApb1aFptu2W9OQqSKBdz4Le9xw4ej4KrE9qXB/P
         bjYf6ztkG7gsgXuEO17P58KOil/YzqXCWCuJyl3Wb27oIo6alvc/pTiIlsTpHYbLXhwp
         DXCuh8VFlD3gKVpVPKJzpAHEVCq/rWolByhNsQZym+/ddFRu07NOxm5wqfQN6Nj6iRr+
         ftZQ==
X-Gm-Message-State: AOUpUlFUu0hC5oaRrN2QGDGol2YRp+PuHcAwfrD4XZWmseuQn7k+IRE6
        EkXqqVg6LK7x+xQ2bhc0LUfUunm/nCoO5bsKhikh95WM825EmEjAQ6anesJyL6b31UYc0B5DOZP
        2R3/5LLDfiHGogVfo04G9mpvza0SDcipChJELmeneznkfPbSzlOB5wOaM1b61
X-Google-Smtp-Source: AAOMgpdcbO25FRWmuBSEkb5eWUZDt4yz/C6dbZgtoJsMixVdd1vjko+cZH0XubxQhfZ0wR4RbpHxDRlEH/Ud
X-Received: by 2002:a6b:7e07:: with SMTP id i7-v6mr1648513iom.55.1532651839975;
 Thu, 26 Jul 2018 17:37:19 -0700 (PDT)
Date:   Thu, 26 Jul 2018 17:36:39 -0700
In-Reply-To: <20180727003640.16659-1-sbeller@google.com>
Message-Id: <20180727003640.16659-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180727003640.16659-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 2/3] refs: introduce new API, wrap old API shallowly around
 new API
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     mhagger@alum.mit.edu, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the refs API takes a 'ref_store' as an argument to specify
which ref store to iterate over; however it is more useful to specify
the repository instead (or later a specific worktree of a repository).

Introduce a new API, that takes a repository struct instead of a ref store;
the repository argument is also passed through to the callback, which is
of type 'each_repo_ref_fn' that is introduced in a previous patch and is
an extension of the 'each_ref_fn' type with the additional repository
argument.

We wrap the old API as in a very shallow way around the new API,
by wrapping the callback and the callback data into a new callback
to translate between the 'each_ref_fn' and 'each_repo_ref_fn' type.

The wrapping implementation could be done either in refs.c or as presented
in this patch as a 'static inline' in the header file itself. This has the
advantage that the line of the old API is changed (and not just its
implementation in refs.c), such that it will show up in git-blame.

The new API is not perfect yet, as some of them take both a 'repository'
and 'ref_store' argument. This is done for an easy migration:
If the ref_store argument is non-NULL, prefer it over the repository
to compute which refs to iterate over. That way we can ensure that this
step of API migration doesn't confuse which ref store to work on.

Once all callers have migrated to this newly introduced API, we can
get rid of the old API; a second migration step in the future will remove
the then useless ref_store argument

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 158 +++++++++++++++-----------
 refs.h | 352 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 407 insertions(+), 103 deletions(-)

diff --git a/refs.c b/refs.c
index 2513f77acb3..27e3772fca9 100644
--- a/refs.c
+++ b/refs.c
@@ -217,7 +217,7 @@ char *resolve_refdup(const char *refname, int resolve_flags,
 /* The argument to filter_refs */
 struct ref_filter {
 	const char *pattern;
-	each_ref_fn *fn;
+	each_repo_ref_fn *fn;
 	void *cb_data;
 };
 
@@ -289,14 +289,15 @@ int ref_filter_match(const char *refname,
 	return 1;
 }
 
-static int filter_refs(const char *refname, const struct object_id *oid,
-			   int flags, void *data)
+static int filter_refs(struct repository *r,
+		       const char *refname, const struct object_id *oid,
+		       int flags, void *data)
 {
 	struct ref_filter *filter = (struct ref_filter *)data;
 
 	if (wildmatch(filter->pattern, refname, 0))
 		return 0;
-	return filter->fn(refname, oid, flags, filter->cb_data);
+	return filter->fn(r, refname, oid, flags, filter->cb_data);
 }
 
 enum peel_status peel_object(const struct object_id *name, struct object_id *oid)
@@ -371,46 +372,50 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_li
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
-int refs_for_each_tag_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_tag_repo_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref_in(refs, "refs/tags/", fn, cb_data);
+	return refs_for_each_repo_ref_in(r, NULL, "refs/tags/", fn, cb_data);
 }
 
-int for_each_tag_ref(each_ref_fn fn, void *cb_data)
+int for_each_tag_repo_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_tag_ref(get_main_ref_store(the_repository), fn, cb_data);
+	return refs_for_each_tag_repo_ref(r, fn, cb_data);
 }
 
-int refs_for_each_branch_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_branch_repo_ref(struct repository *r, struct ref_store *refs,
+				  each_repo_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref_in(refs, "refs/heads/", fn, cb_data);
+	return refs_for_each_repo_ref_in(r, refs, "refs/heads/", fn, cb_data);
 }
 
-int for_each_branch_ref(each_ref_fn fn, void *cb_data)
+int for_each_branch_repo_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_branch_ref(get_main_ref_store(the_repository), fn, cb_data);
+	return refs_for_each_branch_repo_ref(r, NULL, fn, cb_data);
 }
 
-int refs_for_each_remote_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_remote_repo_ref(struct repository *r, struct ref_store *refs,
+				  each_repo_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref_in(refs, "refs/remotes/", fn, cb_data);
+	return refs_for_each_repo_ref_in(r, refs, "refs/remotes/", fn, cb_data);
 }
 
-int for_each_remote_ref(each_ref_fn fn, void *cb_data)
+int for_each_remote_repo_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_remote_ref(get_main_ref_store(the_repository), fn, cb_data);
+	return refs_for_each_remote_repo_ref(the_repository, NULL, fn, cb_data);
 }
 
-int head_ref_namespaced(each_ref_fn fn, void *cb_data)
+int head_repo_ref_namespaced(struct repository *r, each_repo_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret = 0;
 	struct object_id oid;
 	int flag;
+	struct ref_store *refs = get_main_ref_store(r);
 
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, &oid, &flag))
-		ret = fn(buf.buf, &oid, flag, cb_data);
+
+	if (!refs_read_ref_full(refs, buf.buf, RESOLVE_REF_READING, &oid, &flag))
+		ret = fn(r, buf.buf, &oid, flag, cb_data);
 	strbuf_release(&buf);
 
 	return ret;
@@ -437,8 +442,8 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 	strbuf_release(&normalized_pattern);
 }
 
-int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
-	const char *prefix, void *cb_data)
+int for_each_glob_repo_ref_in(struct repository *r, each_repo_ref_fn fn,
+	const char *pattern, const char *prefix, void *cb_data)
 {
 	struct strbuf real_pattern = STRBUF_INIT;
 	struct ref_filter filter;
@@ -460,15 +465,16 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 	filter.pattern = real_pattern.buf;
 	filter.fn = fn;
 	filter.cb_data = cb_data;
-	ret = for_each_ref(filter_refs, &filter);
+	ret = for_each_repo_ref(r, filter_refs, &filter);
 
 	strbuf_release(&real_pattern);
 	return ret;
 }
 
-int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
+int for_each_glob_repo_ref(struct repository *r, each_repo_ref_fn fn,
+			   const char *pattern, void *cb_data)
 {
-	return for_each_glob_ref_in(fn, pattern, NULL, cb_data);
+	return for_each_glob_repo_ref_in(r, fn, pattern, NULL, cb_data);
 }
 
 const char *prettify_refname(const char *name)
@@ -1337,21 +1343,25 @@ int refs_rename_ref_available(struct ref_store *refs,
 	return ok;
 }
 
-int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_head_repo_ref(struct repository *r, struct ref_store *refs,
+		       each_repo_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
 	int flag;
 
+	if (!refs)
+		refs = get_main_ref_store(r);
+
 	if (!refs_read_ref_full(refs, "HEAD", RESOLVE_REF_READING,
 				&oid, &flag))
-		return fn("HEAD", &oid, flag, cb_data);
+		return fn(r, "HEAD", &oid, flag, cb_data);
 
 	return 0;
 }
 
-int head_ref(each_ref_fn fn, void *cb_data)
+int head_repo_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
 {
-	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
+	return refs_head_repo_ref(r, NULL, fn, cb_data);
 }
 
 struct ref_iterator *refs_ref_iterator_begin(
@@ -1390,12 +1400,15 @@ struct ref_iterator *refs_ref_iterator_begin(
  * non-zero value, stop the iteration and return that value;
  * otherwise, return 0.
  */
-static int do_for_each_repo_ref(struct repository *r, const char *prefix,
+static int do_for_each_repo_ref(struct repository *r, struct ref_store *refs,
+				const char *prefix,
 				each_repo_ref_fn fn, int trim, int flags,
 				void *cb_data)
 {
 	struct ref_iterator *iter;
-	struct ref_store *refs = get_main_ref_store(r);
+
+	if (!refs)
+		refs = get_main_ref_store(r);
 
 	if (!refs)
 		return 0;
@@ -1405,6 +1418,15 @@ static int do_for_each_repo_ref(struct repository *r, const char *prefix,
 	return do_for_each_repo_ref_iterator(r, iter, fn, cb_data);
 }
 
+int each_ref_fn_repository_wrapped(struct repository *r,
+				   const char *refname,
+				   const struct object_id *oid,
+				   int flags, void *cb_data)
+{
+	struct each_ref_fn_repository_wrapper *cb = cb_data;
+	return cb->fn(refname, oid, flags, cb->cb);
+}
+
 struct do_for_each_ref_help {
 	each_ref_fn *fn;
 	void *cb_data;
@@ -1436,76 +1458,78 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 					do_for_each_ref_helper, &hp);
 }
 
-int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_repo_ref(struct repository *r, struct ref_store *refs,
+			   each_repo_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+	return do_for_each_repo_ref(r, refs, "", fn, 0, 0, cb_data);
 }
 
-int for_each_ref(each_ref_fn fn, void *cb_data)
+int for_each_repo_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref(get_main_ref_store(the_repository), fn, cb_data);
+	return refs_for_each_repo_ref(r, NULL, fn, cb_data);
 }
 
-int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
-			 each_ref_fn fn, void *cb_data)
+int refs_for_each_repo_ref_in(struct repository *r, struct ref_store *refs,
+			      const char *prefix, each_repo_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_repo_ref(r, refs, prefix, fn, strlen(prefix), 0, cb_data);
 }
 
-int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
+int for_each_repo_ref_in(struct repository *r, const char *prefix, each_repo_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref_in(get_main_ref_store(the_repository), prefix, fn, cb_data);
+	return refs_for_each_repo_ref_in(r, NULL, prefix, fn, cb_data);
 }
 
-int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
+int refs_for_each_full_repo_ref_in(struct repository *r, struct ref_store *refs,
+				   const char *prefix,
+				   each_repo_ref_fn fn, void *cb_data,
+				   unsigned int broken)
 {
 	unsigned int flag = 0;
 
 	if (broken)
 		flag = DO_FOR_EACH_INCLUDE_BROKEN;
-	return do_for_each_ref(get_main_ref_store(the_repository),
-			       prefix, fn, 0, flag, cb_data);
+	return do_for_each_repo_ref(r, refs, prefix, fn, 0, flag, cb_data);
 }
 
-int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
-			     each_ref_fn fn, void *cb_data,
-			     unsigned int broken)
+int for_each_full_repo_ref_in(struct repository *r, const char *prefix,
+			      each_repo_ref_fn fn, void *cb_data,
+			      unsigned int broken)
 {
 	unsigned int flag = 0;
 
 	if (broken)
 		flag = DO_FOR_EACH_INCLUDE_BROKEN;
-	return do_for_each_ref(refs, prefix, fn, 0, flag, cb_data);
+	return do_for_each_repo_ref(r, NULL, prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data)
+int for_each_replace_repo_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_main_ref_store(r),
-			       git_replace_ref_base, fn,
-			       strlen(git_replace_ref_base),
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+	return do_for_each_repo_ref(r, NULL, git_replace_ref_base, fn,
+				    strlen(git_replace_ref_base),
+				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+int for_each_namespaced_repo_ref(struct repository *r,
+				 each_repo_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
-	ret = do_for_each_ref(get_main_ref_store(the_repository),
-			      buf.buf, fn, 0, 0, cb_data);
+	ret = do_for_each_repo_ref(r, NULL, buf.buf, fn, 0, 0, cb_data);
 	strbuf_release(&buf);
 	return ret;
 }
 
-int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_raw_repo_ref(struct repository *r, struct ref_store *refs, each_repo_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0,
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+	return do_for_each_repo_ref(r, refs, "", fn, 0,
+				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-int for_each_rawref(each_ref_fn fn, void *cb_data)
+int for_each_raw_repo_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, cb_data);
+	return refs_for_each_raw_repo_ref(r, NULL, fn, cb_data);
 }
 
 int refs_read_raw_ref(struct ref_store *ref_store,
@@ -2059,20 +2083,18 @@ int refs_verify_refname_available(struct ref_store *refs,
 	return ret;
 }
 
-int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_repo_reflog(struct repository *r, struct ref_store *refs,
+			      each_repo_ref_fn fn, void *cb_data)
 {
 	struct ref_iterator *iter;
-	struct do_for_each_ref_help hp = { fn, cb_data };
 
-	iter = refs->be->reflog_iterator_begin(refs);
+	if (!refs)
+		refs = get_main_ref_store(r);
 
-	return do_for_each_repo_ref_iterator(the_repository, iter,
-					     do_for_each_ref_helper, &hp);
-}
+	iter = refs->be->reflog_iterator_begin(refs);
 
-int for_each_reflog(each_ref_fn fn, void *cb_data)
-{
-	return refs_for_each_reflog(get_main_ref_store(the_repository), fn, cb_data);
+	return do_for_each_repo_ref_iterator(r, iter,
+					     fn, cb_data);
 }
 
 int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
diff --git a/refs.h b/refs.h
index 80eec8bbc68..ba50fb9152d 100644
--- a/refs.h
+++ b/refs.h
@@ -284,6 +284,16 @@ typedef int each_repo_ref_fn(struct repository *r,
 			     int flags,
 			     void *cb_data);
 
+struct each_ref_fn_repository_wrapper {
+	each_ref_fn *fn;
+	void *cb;
+};
+
+int each_ref_fn_repository_wrapped(struct repository *r,
+				   const char *refname,
+				   const struct object_id *oid,
+				   int flags, void *cb_data);
+
 /*
  * The following functions invoke the specified callback function for
  * each reference indicated.  If the function ever returns a nonzero
@@ -293,41 +303,292 @@ typedef int each_repo_ref_fn(struct repository *r,
  * modifies the reference also returns a nonzero value to immediately
  * stop the iteration. Returned references are sorted.
  */
-int refs_head_ref(struct ref_store *refs,
-		  each_ref_fn fn, void *cb_data);
-int refs_for_each_ref(struct ref_store *refs,
-		      each_ref_fn fn, void *cb_data);
-int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
-			 each_ref_fn fn, void *cb_data);
-int refs_for_each_tag_ref(struct ref_store *refs,
-			  each_ref_fn fn, void *cb_data);
-int refs_for_each_branch_ref(struct ref_store *refs,
-			     each_ref_fn fn, void *cb_data);
-int refs_for_each_remote_ref(struct ref_store *refs,
-			     each_ref_fn fn, void *cb_data);
-
-int head_ref(each_ref_fn fn, void *cb_data);
-int for_each_ref(each_ref_fn fn, void *cb_data);
-int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
-int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
-			     each_ref_fn fn, void *cb_data,
-			     unsigned int broken);
-int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
-			unsigned int broken);
-int for_each_tag_ref(each_ref_fn fn, void *cb_data);
-int for_each_branch_ref(each_ref_fn fn, void *cb_data);
-int for_each_remote_ref(each_ref_fn fn, void *cb_data);
-int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data);
-int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
-int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
-			 const char *prefix, void *cb_data);
-
-int head_ref_namespaced(each_ref_fn fn, void *cb_data);
-int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
+int refs_head_repo_ref(struct repository *r, struct ref_store *refs,
+		       each_repo_ref_fn fn, void *cb_data);
+static inline int refs_head_ref(struct ref_store *refs,
+		  each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return refs_head_repo_ref(the_repository, refs,
+				  each_ref_fn_repository_wrapped, &cb);
+}
+
+int refs_for_each_repo_ref(struct repository *r, struct ref_store *refs,
+		      each_repo_ref_fn fn, void *cb_data);
+static inline int refs_for_each_ref(struct ref_store *refs,
+		      each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return refs_for_each_repo_ref(the_repository, refs,
+				      each_ref_fn_repository_wrapped, &cb);
+}
+
+int refs_for_each_repo_ref_in(struct repository *r, struct ref_store *refs,
+			 const char *prefix, each_repo_ref_fn fn, void *cb_data);
+static inline int refs_for_each_ref_in(struct ref_store *refs,
+				       const char *prefix,
+				       each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return refs_for_each_repo_ref_in(the_repository, refs, prefix,
+					 each_ref_fn_repository_wrapped, &cb);
+}
+
+int refs_for_each_tag_repo_ref(struct repository *r,
+			       each_repo_ref_fn fn, void *cb_data);
+static inline int refs_for_each_tag_ref(struct ref_store *refs,
+				 each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return refs_for_each_tag_repo_ref(the_repository,
+					  each_ref_fn_repository_wrapped, &cb);
+}
+
+int refs_for_each_branch_repo_ref(struct repository *r, struct ref_store *refs,
+				  each_repo_ref_fn fn,
+				  void *cb_data);
+static inline int refs_for_each_branch_ref(struct ref_store *refs,
+					   each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return refs_for_each_branch_repo_ref(the_repository, refs,
+					     each_ref_fn_repository_wrapped, &cb);
+}
+
+int refs_for_each_remote_repo_ref(struct repository *r, struct ref_store *refs,
+				  each_repo_ref_fn fn,
+				  void *cb_data);
+static inline int refs_for_each_remote_ref(struct ref_store *refs,
+					   each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return refs_for_each_remote_repo_ref(the_repository, refs,
+					     each_ref_fn_repository_wrapped, &cb);
+}
+
+int head_repo_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data);
+static inline int head_ref(each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return head_repo_ref(the_repository,
+			     each_ref_fn_repository_wrapped, &cb);
+}
+
+int for_each_repo_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data);
+static inline int for_each_ref(each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return for_each_repo_ref(the_repository,
+				 each_ref_fn_repository_wrapped, &cb);
+}
+
+int for_each_repo_ref_in(struct repository *r, const char *prefix,
+			 each_repo_ref_fn fn, void *cb_data);
+static inline int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return for_each_repo_ref_in(the_repository, prefix,
+				    each_ref_fn_repository_wrapped, &cb);
+}
+
+int refs_for_each_full_repo_ref_in(struct repository *r, struct ref_store *refs,
+				   const char *prefix,
+				   each_repo_ref_fn fn, void *cb_data,
+				   unsigned int broken);
+static inline int refs_for_each_fullref_in(struct ref_store *refs,
+					   const char *prefix, each_ref_fn fn,
+					   void *cb_data, unsigned int broken)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return refs_for_each_full_repo_ref_in(the_repository, refs, prefix,
+					      each_ref_fn_repository_wrapped,
+					      &cb, broken);
+}
+
+int for_each_full_repo_ref_in(struct repository *r, const char *prefix,
+			      each_repo_ref_fn fn, void *cb_data,
+			      unsigned int broken);
+static inline int for_each_fullref_in(const char *prefix, each_ref_fn fn,
+				      void *cb_data, unsigned int broken)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return for_each_full_repo_ref_in(the_repository, prefix,
+					      each_ref_fn_repository_wrapped,
+					      &cb, broken);
+}
+
+int for_each_tag_repo_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data);
+static inline int for_each_tag_ref(each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return for_each_tag_repo_ref(the_repository,
+				     each_ref_fn_repository_wrapped, &cb);
+}
+
+int for_each_branch_repo_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data);
+static inline int for_each_branch_ref(each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return for_each_branch_repo_ref(the_repository,
+			each_ref_fn_repository_wrapped, &cb);
+}
+
+int for_each_remote_repo_ref(struct repository *r, each_repo_ref_fn fn, void *cb);
+static inline int for_each_remote_ref(each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return for_each_remote_repo_ref(the_repository,
+					each_ref_fn_repository_wrapped, &cb);
+}
+
+int for_each_replace_repo_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data);
+static inline int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return for_each_replace_repo_ref(r, each_ref_fn_repository_wrapped, &cb);
+}
+
+int for_each_glob_repo_ref(struct repository *r, each_repo_ref_fn fn,
+			   const char *pattern, void *cb_data);
+static inline int for_each_glob_ref(each_ref_fn fn, const char *pattern,
+				    void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return for_each_glob_repo_ref(the_repository,
+				      each_ref_fn_repository_wrapped,
+				      pattern, &cb);
+}
+
+int for_each_glob_repo_ref_in(struct repository *r,
+			      each_repo_ref_fn fn, const char *pattern,
+			      const char *prefix, void *cb_data);
+static inline int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
+			 const char *prefix, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return for_each_glob_repo_ref_in(the_repository,
+					 each_ref_fn_repository_wrapped,
+					 pattern, prefix, &cb);
+}
+
+int head_repo_ref_namespaced(struct repository *r, each_repo_ref_fn fn, void *cb_data);
+static inline int head_ref_namespaced(each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return head_repo_ref_namespaced(the_repository,
+					each_ref_fn_repository_wrapped, &cb);
+}
+
+int for_each_namespaced_repo_ref(struct repository *r, each_repo_ref_fn fn,
+				 void *cb_data);
+static inline int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return for_each_namespaced_repo_ref(the_repository,
+					    each_ref_fn_repository_wrapped, &cb);
+}
 
 /* can be used to learn about broken ref and symref */
-int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
-int for_each_rawref(each_ref_fn fn, void *cb_data);
+int refs_for_each_raw_repo_ref(struct repository *r, struct ref_store *refs,
+			       each_repo_ref_fn fn, void *cb_data);
+static inline int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return refs_for_each_raw_repo_ref(the_repository, refs,
+					  each_ref_fn_repository_wrapped, &cb);
+}
+
+int for_each_raw_repo_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data);
+static inline int for_each_rawref(each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return for_each_raw_repo_ref(the_repository,
+				     each_ref_fn_repository_wrapped, &cb);
+}
 
 /*
  * Normalizes partial refs to their fully qualified form.
@@ -442,8 +703,29 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
  * Calls the specified function for each reflog file until it returns nonzero,
  * and returns the value. Reflog file order is unspecified.
  */
-int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_data);
-int for_each_reflog(each_ref_fn fn, void *cb_data);
+int refs_for_each_repo_reflog(struct repository *r, struct ref_store *refs,
+			 each_repo_ref_fn fn, void *cb_data);
+static inline int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn,
+				       void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return refs_for_each_repo_reflog(the_repository, refs,
+					 each_ref_fn_repository_wrapped, &cb);
+}
+static inline int for_each_reflog(each_ref_fn fn, void *cb_data)
+{
+	/*
+	 * NEEDSWORK: remove this function when there are no
+	 * series in flight using this function.
+	 */
+	struct each_ref_fn_repository_wrapper cb = {fn, cb_data};
+	return refs_for_each_repo_reflog(the_repository, NULL,
+					 each_ref_fn_repository_wrapped, &cb);
+}
 
 #define REFNAME_ALLOW_ONELEVEL 1
 #define REFNAME_REFSPEC_PATTERN 2
-- 
2.18.0.345.g5c9ce644c3-goog

