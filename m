Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D993C7EE24
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245172AbjEOTYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245090AbjEOTXk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:23:40 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B54A13C13
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:30 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-55a00da4e53so229279327b3.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684178609; x=1686770609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wS48wvbbRfXB939krCs+yQJyZfXgo+SlEjUh5RmMaz0=;
        b=fIDO6DZTwCt4s9sXJAGKjT61uMj8SOop82I8ukpk7a0fgQ7Cs6oX9fVS/QQ9htWJmH
         oTg+mDRHPLkrfwF04L5ETLn2ihDhW7NPXIJCdElyLiRQB6kZajVly2l3ahdIIEQiL4mE
         PWOq/j7P6sYMB/IIoSxYaMv/Zaami2PBa2z7pWnoCmBgA6vU1/m4y7QwfJnZ1Wi0rYFU
         CWKHshDCaW+ZHBA6bUUL4+2HmFKfth00WfM8CP4kEPVuZsGzkSaNWG8LyEa4XLOeAhJx
         rDy4uMpFYfWmU/DXrYYQpch2AHYbtqV//v7nmdYdmJ6tPbfj9KcZOMqxqakG8iPzX91R
         fBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178609; x=1686770609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS48wvbbRfXB939krCs+yQJyZfXgo+SlEjUh5RmMaz0=;
        b=Cx+4whG8qxN5HocFW98RqQ/4Igh9AEmXS4eYLFwJSdPjnNMygc7TnKQxTwuF5Lm2sS
         LrZ4gvgzIk8b4FttIgl26BZampCza4+7E2/WvkoKssoocD/17AQHP2ffTHUozUANlx1n
         c/QiJwNpOB7A0W3lsUJ0pv8NS6hvp1khXy1/G1nFFhyj6t+CoI4RejwdkYFCNfS+woKz
         VhOAgGBLNdK1AK9HUCREClvQaNkTaREzqapIAU1idRB4shwDyx5MFPsPV/t+c8K1ZGjA
         py9EnpqI2MLsJtwgVe3fS24ADTDu8dOYLvW/T2vu6cnGeW6/lPsxwzdu1A3fIabaAnmZ
         IrTw==
X-Gm-Message-State: AC+VfDw+4w625QNnYwH6wIWhqt5qiFfVctXnurQSEHvW5biegdg7nqDV
        YV5LGHH5Qs5c8ALp3zgTJzZEmpbVsNRJbxrhKIeZ4g==
X-Google-Smtp-Source: ACHHUZ4FhCAK3x6WIHoORDiSLQwJ4UxrWIU99hqKayaBVO5cOZKFoWg2OMRR956rwujzP4kk+CvG2Q==
X-Received: by 2002:a81:df12:0:b0:561:4bc2:1587 with SMTP id c18-20020a81df12000000b005614bc21587mr6162020ywn.39.1684178609555;
        Mon, 15 May 2023 12:23:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i22-20020a0ddf16000000b0055aad7d3f34sm4600ywe.142.2023.05.15.12.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:23:29 -0700 (PDT)
Date:   Mon, 15 May 2023 15:23:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 07/16] refs: plumb `exclude_patterns` argument throughout
Message-ID: <aa05549b6ee6b2d3be01e66b8f49fb9ed4813575.1684178576.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1684178576.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subsequent patch will want to access an optional `excluded_patterns`
array within `refs/packed-backend.c` that will cull out certain
references matching any of the given patterns on a best-effort basis.

To do so, the refs subsystem needs to be updated to pass this value
across a number of different locations.

Prepare for a future patch by introducing this plumbing now, passing
NULLs at top-level APIs in order to make that patch less noisy and more
easily readable.

Signed-off-by: Taylor Blau <me@ttaylorr.co>
---
 ls-refs.c             |  2 +-
 ref-filter.c          |  5 +++--
 refs.c                | 32 +++++++++++++++++++-------------
 refs.h                |  8 +++++++-
 refs/debug.c          |  5 +++--
 refs/files-backend.c  |  5 +++--
 refs/packed-backend.c |  5 +++--
 refs/refs-internal.h  |  7 ++++---
 revision.c            |  2 +-
 9 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index f385938b64..6f490b2d9c 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -193,7 +193,7 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 		strvec_push(&data.prefixes, "");
 	refs_for_each_fullref_in_prefixes(get_main_ref_store(r),
 					  get_git_namespace(), data.prefixes.v,
-					  send_ref, &data);
+					  NULL, send_ref, &data);
 	packet_fflush(stdout);
 	strvec_clear(&data.prefixes);
 	strbuf_release(&data.buf);
diff --git a/ref-filter.c b/ref-filter.c
index d44418efb7..717c3c4bcf 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2209,12 +2209,13 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 
 	if (!filter->name_patterns[0]) {
 		/* no patterns; we have to look at everything */
-		return for_each_fullref_in("", cb, cb_data);
+		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
+						 "", NULL, cb, cb_data);
 	}
 
 	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_repository),
 						 NULL, filter->name_patterns,
-						 cb, cb_data);
+						 NULL, cb, cb_data);
 }
 
 /*
diff --git a/refs.c b/refs.c
index b9b77d2eff..538bde644e 100644
--- a/refs.c
+++ b/refs.c
@@ -1526,7 +1526,9 @@ int head_ref(each_ref_fn fn, void *cb_data)
 
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
-		const char *prefix, int trim,
+		const char *prefix,
+		const char **exclude_patterns,
+		int trim,
 		enum do_for_each_ref_flags flags)
 {
 	struct ref_iterator *iter;
@@ -1542,8 +1544,7 @@ struct ref_iterator *refs_ref_iterator_begin(
 		}
 	}
 
-	iter = refs->be->iterator_begin(refs, prefix, flags);
-
+	iter = refs->be->iterator_begin(refs, prefix, exclude_patterns, flags);
 	/*
 	 * `iterator_begin()` already takes care of prefix, but we
 	 * might need to do some trimming:
@@ -1577,7 +1578,7 @@ static int do_for_each_repo_ref(struct repository *r, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = refs_ref_iterator_begin(refs, prefix, trim, flags);
+	iter = refs_ref_iterator_begin(refs, prefix, NULL, trim, flags);
 
 	return do_for_each_repo_ref_iterator(r, iter, fn, cb_data);
 }
@@ -1599,6 +1600,7 @@ static int do_for_each_ref_helper(struct repository *r,
 }
 
 static int do_for_each_ref(struct ref_store *refs, const char *prefix,
+			   const char **exclude_patterns,
 			   each_ref_fn fn, int trim,
 			   enum do_for_each_ref_flags flags, void *cb_data)
 {
@@ -1608,7 +1610,8 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = refs_ref_iterator_begin(refs, prefix, trim, flags);
+	iter = refs_ref_iterator_begin(refs, prefix, exclude_patterns, trim,
+				       flags);
 
 	return do_for_each_repo_ref_iterator(the_repository, iter,
 					do_for_each_ref_helper, &hp);
@@ -1616,7 +1619,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, "", NULL, fn, 0, 0, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
@@ -1627,7 +1630,7 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
 			 each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(refs, prefix, NULL, fn, strlen(prefix), 0, cb_data);
 }
 
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
@@ -1638,13 +1641,14 @@ int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(get_main_ref_store(the_repository),
-			       prefix, fn, 0, 0, cb_data);
+			       prefix, NULL, fn, 0, 0, cb_data);
 }
 
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
+			     const char **exclude_patterns,
 			     each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, prefix, fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, prefix, exclude_patterns, fn, 0, 0, cb_data);
 }
 
 int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
@@ -1661,14 +1665,14 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
 	ret = do_for_each_ref(get_main_ref_store(the_repository),
-			      buf.buf, fn, 0, 0, cb_data);
+			      buf.buf, NULL, fn, 0, 0, cb_data);
 	strbuf_release(&buf);
 	return ret;
 }
 
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0,
+	return do_for_each_ref(refs, "", NULL, fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
@@ -1738,6 +1742,7 @@ static void find_longest_prefixes(struct string_list *out,
 int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
 				      const char *namespace,
 				      const char **patterns,
+				      const char **exclude_patterns,
 				      each_ref_fn fn, void *cb_data)
 {
 	struct string_list prefixes = STRING_LIST_INIT_DUP;
@@ -1753,7 +1758,8 @@ int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
 
 	for_each_string_list_item(prefix, &prefixes) {
 		strbuf_addstr(&buf, prefix->string);
-		ret = refs_for_each_fullref_in(ref_store, buf.buf, fn, cb_data);
+		ret = refs_for_each_fullref_in(ref_store, buf.buf,
+					       exclude_patterns, fn, cb_data);
 		if (ret)
 			break;
 		strbuf_setlen(&buf, namespace_len);
@@ -2408,7 +2414,7 @@ int refs_verify_refname_available(struct ref_store *refs,
 	strbuf_addstr(&dirname, refname + dirname.len);
 	strbuf_addch(&dirname, '/');
 
-	iter = refs_ref_iterator_begin(refs, dirname.buf, 0,
+	iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
 				       DO_FOR_EACH_INCLUDE_BROKEN);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		if (skip &&
diff --git a/refs.h b/refs.h
index 123cfa4424..d672d636cf 100644
--- a/refs.h
+++ b/refs.h
@@ -338,6 +338,7 @@ int for_each_ref(each_ref_fn fn, void *cb_data);
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
 
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
+			     const char **exclude_patterns,
 			     each_ref_fn fn, void *cb_data);
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data);
 
@@ -345,10 +346,15 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data);
  * iterate all refs in "patterns" by partitioning patterns into disjoint sets
  * and iterating the longest-common prefix of each set.
  *
+ * references matching any pattern in "exclude_patterns" are omitted from the
+ * result set on a best-effort basis.
+ *
  * callers should be prepared to ignore references that they did not ask for.
  */
 int refs_for_each_fullref_in_prefixes(struct ref_store *refs,
-				      const char *namespace, const char **patterns,
+				      const char *namespace,
+				      const char **patterns,
+				      const char **exclude_patterns,
 				      each_ref_fn fn, void *cb_data);
 
 /**
diff --git a/refs/debug.c b/refs/debug.c
index 6f11e6de46..328f894177 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -229,11 +229,12 @@ static struct ref_iterator_vtable debug_ref_iterator_vtable = {
 
 static struct ref_iterator *
 debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
-			 unsigned int flags)
+			 const char **exclude_patterns, unsigned int flags)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	struct ref_iterator *res =
-		drefs->refs->be->iterator_begin(drefs->refs, prefix, flags);
+		drefs->refs->be->iterator_begin(drefs->refs, prefix,
+						exclude_patterns, flags);
 	struct debug_ref_iterator *diter = xcalloc(1, sizeof(*diter));
 	base_ref_iterator_init(&diter->base, &debug_ref_iterator_vtable, 1);
 	diter->iter = res;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bca7b851c5..3bc3c57c05 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -829,7 +829,8 @@ static struct ref_iterator_vtable files_ref_iterator_vtable = {
 
 static struct ref_iterator *files_ref_iterator_begin(
 		struct ref_store *ref_store,
-		const char *prefix, unsigned int flags)
+		const char *prefix, const char **exclude_patterns,
+		unsigned int flags)
 {
 	struct files_ref_store *refs;
 	struct ref_iterator *loose_iter, *packed_iter, *overlay_iter;
@@ -874,7 +875,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 * the packed and loose references.
 	 */
 	packed_iter = refs_ref_iterator_begin(
-			refs->packed_ref_store, prefix, 0,
+			refs->packed_ref_store, prefix, exclude_patterns, 0,
 			DO_FOR_EACH_INCLUDE_BROKEN);
 
 	overlay_iter = overlay_ref_iterator_begin(loose_iter, packed_iter);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 5b412a133b..176bd3905b 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -924,7 +924,8 @@ static struct ref_iterator_vtable packed_ref_iterator_vtable = {
 
 static struct ref_iterator *packed_ref_iterator_begin(
 		struct ref_store *ref_store,
-		const char *prefix, unsigned int flags)
+		const char *prefix, const char **exclude_patterns,
+		unsigned int flags)
 {
 	struct packed_ref_store *refs;
 	struct snapshot *snapshot;
@@ -1149,7 +1150,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 	 * list of refs is exhausted, set iter to NULL. When the list
 	 * of updates is exhausted, leave i set to updates->nr.
 	 */
-	iter = packed_ref_iterator_begin(&refs->base, "",
+	iter = packed_ref_iterator_begin(&refs->base, "", NULL,
 					 DO_FOR_EACH_INCLUDE_BROKEN);
 	if ((ok = ref_iterator_advance(iter)) != ITER_OK)
 		iter = NULL;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index a85d113123..28a11b9d61 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -367,8 +367,8 @@ int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
  */
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
-		const char *prefix, int trim,
-		enum do_for_each_ref_flags flags);
+		const char *prefix, const char **exclude_patterns,
+		int trim, enum do_for_each_ref_flags flags);
 
 /*
  * A callback function used to instruct merge_ref_iterator how to
@@ -570,7 +570,8 @@ typedef int copy_ref_fn(struct ref_store *ref_store,
  */
 typedef struct ref_iterator *ref_iterator_begin_fn(
 		struct ref_store *ref_store,
-		const char *prefix, unsigned int flags);
+		const char *prefix, const char **exclude_patterns,
+		unsigned int flags);
 
 /* reflog functions */
 
diff --git a/revision.c b/revision.c
index b33cc1d106..89953592f9 100644
--- a/revision.c
+++ b/revision.c
@@ -2670,7 +2670,7 @@ static int for_each_bisect_ref(struct ref_store *refs, each_ref_fn fn,
 	struct strbuf bisect_refs = STRBUF_INIT;
 	int status;
 	strbuf_addf(&bisect_refs, "refs/bisect/%s", term);
-	status = refs_for_each_fullref_in(refs, bisect_refs.buf, fn, cb_data);
+	status = refs_for_each_fullref_in(refs, bisect_refs.buf, NULL, fn, cb_data);
 	strbuf_release(&bisect_refs);
 	return status;
 }
-- 
2.40.1.572.g5c4ab523ef

