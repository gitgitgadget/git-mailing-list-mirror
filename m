Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5B7F1F462
	for <e@80x24.org>; Sat,  1 Jun 2019 00:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfFAAg0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 20:36:26 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36269 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfFAAg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 20:36:26 -0400
Received: by mail-pf1-f201.google.com with SMTP id d125so8681178pfd.3
        for <git@vger.kernel.org>; Fri, 31 May 2019 17:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9dhVaOCyoakx7Lu2qKrXBfmPmcmSkAN/X4BQfbwySik=;
        b=s/Qyv/T5MJjhN5So4t+FPEqhijcNTSO1omxuQEHHtwEf2+m977GU8oYgGEi0Y+jL31
         fDPkvBv4kobBLhvFFdj4xXX8BwPpLaei9SLVo/cq7CNnfQOmPJ0l6dD8SKyFc6/43maG
         RsDoeDIH5tRoqdLY1LmOIrn+RvfETWZu5i2B/hJmjjO23RnjtMVhJMiGYi45KlPd3RzZ
         YDdfDYQJNJTm6EXI4Yv1jseUSu96u2AeHslFzP1jEoPMuN6yDFBLDHODCWwWxgxU22PA
         5Nff1Ml2O7n5a/Nz3SA+ippyTQ9vaoNFbXr7L3x0+qp1gygsuHVqqtUYrr6+UtQy7Z8B
         imKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9dhVaOCyoakx7Lu2qKrXBfmPmcmSkAN/X4BQfbwySik=;
        b=ptI5Yud99ANb6+2YneLgnV84oIxjBvqc4U6PD3YgEF2oubAkQV1Av0Og/XSodI0yKX
         5L+k6gM0+H7C8mTXCMcpTD0dcgRt0vn37eG5OKeojNvyZgnppVUclOBHEAMo9zpNDr7z
         EXvLxYMGm9eg//YN1MlyqWE+9ncb4TNKHa55AhNqWLjWGKLMTpdHz8OQmwDIHLZiG+rJ
         bS68hmHx1qt4mLT+G6EcnIvcsiJWHtmf775PDoQQHXamfAWjMOk78NDfBdcz7RZPH8PN
         dYHo0yWEAP/epQyyQRtyI0hiD8LsHq8rV/ZU46s9dDgWHGrblfTybnOZFub/tNYsAHVl
         u9RQ==
X-Gm-Message-State: APjAAAW7qyqgQcb2SKiRnxsFPJHi1I64Ug0A0uJT2J8AT8HztQlwd7oB
        Yj9V+1ddNz1b1+KDZ5U/e0DwIwc8g/G9MBW0CccmqlUucLaz062S791oS32L4BJGLqFam/ftC0O
        1pd6XHFzKofvVLpcqldbKxS2bRizOGOFGztG3eLdSvKvWyKB4bKptuQXGSeg=
X-Google-Smtp-Source: APXvYqzFSwl3/ATqpWcT7Ytda6HPXfakK7X3UlhJK22sSjqcsnpx/roGSlVsOS9FZSg2fxB3S9DhgutNr5LO
X-Received: by 2002:a63:5d45:: with SMTP id o5mr12693574pgm.40.1559349385298;
 Fri, 31 May 2019 17:36:25 -0700 (PDT)
Date:   Fri, 31 May 2019 17:35:58 -0700
In-Reply-To: <20190601003603.90794-1-matvore@google.com>
Message-Id: <20190601003603.90794-5-matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v2 4/9] list-objects-filter: implement composite filters
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow combining filters such that only objects accepted by all filters
are shown. The motivation for this is to allow getting directory
listings without also fetching blobs. This can be done by combining
blob:none with tree:<depth>. There are massive repositories that have
larger-than-expected trees - even if you include only a single commit.

The current usage requires passing the filter to rev-list in the
following form:

	--filter=<FILTER1> --filter=<FILTER2> ...

Such usage is currently an error, so giving it a meaning is backwards-
compatible.

The URL-encoding method is being implemented before the repeated flag
logic, and the user-facing documentation for URL-encoding is being
withheld until the repeated flag feature is implemented. The
URL-encoding is in general not meant to be used directly by the user,
and it is better to describe the URL-encoding feature in terms of the
repeated flag.

Helped-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Jeff Hostetler <git@jeffhostetler.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.c       | 135 ++++++++++++++++++++++-
 list-objects-filter-options.h       |  17 ++-
 list-objects-filter.c               | 159 +++++++++++++++++++++++++++
 t/t6112-rev-list-filters-objects.sh | 163 +++++++++++++++++++++++++++-
 4 files changed, 468 insertions(+), 6 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index aef24ddae3..0f1d4181cb 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -1,19 +1,24 @@
 #include "cache.h"
 #include "commit.h"
 #include "config.h"
 #include "revision.h"
 #include "argv-array.h"
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 
+static int parse_combine_filter(
+	struct list_objects_filter_options *filter_options,
+	const char *arg,
+	struct strbuf *errbuf);
+
 /*
  * Parse value of the argument to the "filter" keyword.
  * On the command line this looks like:
  *       --filter=<arg>
  * and in the pack protocol as:
  *       "filter" SP <arg>
  *
  * The filter keyword will be used by many commands.
  * See Documentation/rev-list-options.txt for allowed values for <arg>.
  *
@@ -28,22 +33,20 @@ static int gently_parse_list_objects_filter(
 	struct strbuf *errbuf)
 {
 	const char *v0;
 
 	if (filter_options->choice) {
 		strbuf_addstr(
 			errbuf, _("multiple filter-specs cannot be combined"));
 		return 1;
 	}
 
-	filter_options->filter_spec = strdup(arg);
-
 	if (!strcmp(arg, "blob:none")) {
 		filter_options->choice = LOFC_BLOB_NONE;
 		return 0;
 
 	} else if (skip_prefix(arg, "blob:limit=", &v0)) {
 		if (git_parse_ulong(v0, &filter_options->blob_limit_value)) {
 			filter_options->choice = LOFC_BLOB_LIMIT;
 			return 0;
 		}
 
@@ -67,36 +70,155 @@ static int gently_parse_list_objects_filter(
 		if (!get_oid_with_context(the_repository, v0, GET_OID_BLOB,
 					  &sparse_oid, &oc))
 			filter_options->sparse_oid_value = oiddup(&sparse_oid);
 		filter_options->choice = LOFC_SPARSE_OID;
 		return 0;
 
 	} else if (skip_prefix(arg, "sparse:path=", &v0)) {
 		filter_options->choice = LOFC_SPARSE_PATH;
 		filter_options->sparse_path_value = strdup(v0);
 		return 0;
+
+	} else if (skip_prefix(arg, "combine:", &v0)) {
+		return parse_combine_filter(filter_options, v0, errbuf);
+
 	}
 	/*
 	 * Please update _git_fetch() in git-completion.bash when you
 	 * add new filters
 	 */
 
 	strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
 
 	memset(filter_options, 0, sizeof(*filter_options));
 	return 1;
 }
 
+static int url_decode(struct strbuf *s, struct strbuf *errbuf)
+{
+	char *dest = s->buf;
+	char *src = s->buf;
+	size_t new_len;
+
+	while (*src) {
+		if (src[0] != '%') {
+			*dest++ = *src++;
+			continue;
+		}
+
+		if (hex_to_bytes((unsigned char *)dest, src + 1, 1)) {
+			strbuf_addstr(errbuf,
+				      "error in filter-spec - "
+				      "invalid hex sequence after %");
+			return 1;
+		}
+
+		if (!*dest) {
+			strbuf_addstr(errbuf,
+				      "error in filter-spec - unexpected %00");
+			return 1;
+		}
+
+		src += 3;
+		dest++;
+	}
+	new_len = dest - s->buf;
+	strbuf_remove(s, new_len, s->len - new_len);
+
+	return 0;
+}
+
+static const char *RESERVED_NON_WS = "~`!@#$^&*()[]{}\\;'\",<>?";
+
+static int has_reserved_character(
+	struct strbuf *sub_spec, struct strbuf *errbuf)
+{
+	const char *c = sub_spec->buf;
+	while (*c) {
+		if (*c <= ' ' || strchr(RESERVED_NON_WS, *c)) {
+			strbuf_addf(errbuf,
+				    "must escape char in sub-filter-spec: '%c'",
+				    *c);
+			return 1;
+		}
+		c++;
+	}
+
+	return 0;
+}
+
+static int parse_combine_subfilter(
+	struct list_objects_filter_options *filter_options,
+	struct strbuf *subspec,
+	struct strbuf *errbuf)
+{
+	size_t new_index = filter_options->sub_nr++;
+
+	ALLOC_GROW(filter_options->sub, filter_options->sub_nr,
+		   filter_options->sub_alloc);
+	memset(&filter_options->sub[new_index], 0,
+	       sizeof(*filter_options->sub));
+
+	return has_reserved_character(subspec, errbuf) ||
+		url_decode(subspec, errbuf) ||
+		gently_parse_list_objects_filter(
+			&filter_options->sub[new_index], subspec->buf, errbuf);
+}
+
+static int parse_combine_filter(
+	struct list_objects_filter_options *filter_options,
+	const char *arg,
+	struct strbuf *errbuf)
+{
+	struct strbuf **subspecs = strbuf_split_str(arg, '+', 0);
+	size_t sub;
+	int result;
+
+	if (!subspecs[0]) {
+		strbuf_addf(errbuf,
+			    _("expected something after combine:"));
+		result = 1;
+		goto cleanup;
+	}
+
+	for (sub = 0; subspecs[sub]; sub++) {
+		if (subspecs[sub + 1]) {
+			/*
+			 * This is not the last subspec. Remove trailing "+" so
+			 * we can parse it.
+			 */
+			size_t last = subspecs[sub]->len - 1;
+			assert(subspecs[sub]->buf[last] == '+');
+			strbuf_remove(subspecs[sub], last, 1);
+		}
+		result = parse_combine_subfilter(
+			filter_options, subspecs[sub], errbuf);
+		if (result)
+			goto cleanup;
+	}
+
+	filter_options->choice = LOFC_COMBINE;
+
+cleanup:
+	strbuf_list_free(subspecs);
+	if (result) {
+		list_objects_filter_release(filter_options);
+		memset(filter_options, 0, sizeof(*filter_options));
+	}
+	return result;
+}
+
 int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
 			      const char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
+	filter_options->filter_spec = strdup(arg);
 	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
 		die("%s", buf.buf);
 	return 0;
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset)
 {
 	struct list_objects_filter_options *filter_options = opt->value;
 
@@ -119,23 +241,30 @@ void expand_list_objects_filter_spec(
 	else if (filter->choice == LOFC_TREE_DEPTH)
 		strbuf_addf(expanded_spec, "tree:%lu",
 			    filter->tree_exclude_depth);
 	else
 		strbuf_addstr(expanded_spec, filter->filter_spec);
 }
 
 void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options)
 {
+	size_t sub;
+
+	if (!filter_options)
+		return;
 	free(filter_options->filter_spec);
 	free(filter_options->sparse_oid_value);
 	free(filter_options->sparse_path_value);
+	for (sub = 0; sub < filter_options->sub_nr; sub++)
+		list_objects_filter_release(&filter_options->sub[sub]);
+	free(filter_options->sub);
 	memset(filter_options, 0, sizeof(*filter_options));
 }
 
 void partial_clone_register(
 	const char *remote,
 	const struct list_objects_filter_options *filter_options)
 {
 	/*
 	 * Record the name of the partial clone remote in the
 	 * config and in the global variable -- the latter is
@@ -165,15 +294,17 @@ void partial_clone_register(
 void partial_clone_get_default_filter_spec(
 	struct list_objects_filter_options *filter_options)
 {
 	struct strbuf errbuf = STRBUF_INIT;
 
 	/*
 	 * Parse default value, but silently ignore it if it is invalid.
 	 */
 	if (!core_partial_clone_filter_default)
 		return;
+
+	filter_options->filter_spec = strdup(core_partial_clone_filter_default);
 	gently_parse_list_objects_filter(filter_options,
 					 core_partial_clone_filter_default,
 					 &errbuf);
 	strbuf_release(&errbuf);
 }
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index e3adc78ebf..8f08ed74a1 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -7,20 +7,21 @@
 /*
  * The list of defined filters for list-objects.
  */
 enum list_objects_filter_choice {
 	LOFC_DISABLED = 0,
 	LOFC_BLOB_NONE,
 	LOFC_BLOB_LIMIT,
 	LOFC_TREE_DEPTH,
 	LOFC_SPARSE_OID,
 	LOFC_SPARSE_PATH,
+	LOFC_COMBINE,
 	LOFC__COUNT /* must be last */
 };
 
 struct list_objects_filter_options {
 	/*
 	 * 'filter_spec' is the raw argument value given on the command line
 	 * or protocol request.  (The part after the "--keyword=".)  For
 	 * commands that launch filtering sub-processes, or for communication
 	 * over the network, don't use this value; use the result of
 	 * expand_list_objects_filter_spec() instead.
@@ -32,28 +33,38 @@ struct list_objects_filter_options {
 	 * the filtering algorithm to use.
 	 */
 	enum list_objects_filter_choice choice;
 
 	/*
 	 * Choice is LOFC_DISABLED because "--no-filter" was requested.
 	 */
 	unsigned int no_filter : 1;
 
 	/*
-	 * Parsed values (fields) from within the filter-spec.  These are
-	 * choice-specific; not all values will be defined for any given
-	 * choice.
+	 * BEGIN choice-specific parsed values from within the filter-spec. Only
+	 * some values will be defined for any given choice.
 	 */
+
 	struct object_id *sparse_oid_value;
 	char *sparse_path_value;
 	unsigned long blob_limit_value;
 	unsigned long tree_exclude_depth;
+
+	/* LOFC_COMBINE values */
+
+	/* This array contains all the subfilters which this filter combines. */
+	size_t sub_nr, sub_alloc;
+	struct list_objects_filter_options *sub;
+
+	/*
+	 * END choice-specific parsed values.
+	 */
 };
 
 /* Normalized command line arguments */
 #define CL_ARG__FILTER "filter"
 
 int parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg);
 
 int opt_parse_list_objects_filter(const struct option *opt,
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 57bbf6ec1c..c8a006edf9 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -19,30 +19,45 @@
  * FILTER_SHOWN_BUT_REVISIT -- we set this bit on tree objects
  * that have been shown, but should be revisited if they appear
  * in the traversal (until we mark it SEEN).  This is a way to
  * let us silently de-dup calls to show() in the caller.  This
  * is subtly different from the "revision.h:SHOWN" and the
  * "sha1-name.c:ONELINE_SEEN" bits.  And also different from
  * the non-de-dup usage in pack-bitmap.c
  */
 #define FILTER_SHOWN_BUT_REVISIT (1<<21)
 
+struct subfilter {
+	struct filter *filter;
+	struct oidset seen;
+	struct oidset omits;
+	struct object_id skip_tree;
+	unsigned is_skipping_tree : 1;
+};
+
 struct filter {
 	enum list_objects_filter_result (*filter_object_fn)(
 		struct repository *r,
 		enum list_objects_filter_situation filter_situation,
 		struct object *obj,
 		const char *pathname,
 		const char *filename,
 		struct oidset *omits,
 		void *filter_data);
 
+	/*
+	 * Optional. If this function is supplied and the filter needs to
+	 * collect omits, then this function is called once before free_fn is
+	 * called.
+	 */
+	void (*finalize_omits_fn)(struct oidset *omits, void *filter_data);
+
 	void (*free_fn)(void *filter_data);
 
 	void *filter_data;
 
 	/* If non-NULL, the filter collects a list of the omitted OIDs here. */
 	struct oidset *omits;
 };
 
 static enum list_objects_filter_result filter_blobs_none(
 	struct repository *r,
@@ -482,34 +497,176 @@ static void filter_sparse_path__init(
 
 	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
 	d->array_frame[d->nr].defval = 0; /* default to include */
 	d->array_frame[d->nr].child_prov_omit = 0;
 
 	filter->filter_data = d;
 	filter->filter_object_fn = filter_sparse;
 	filter->free_fn = filter_sparse_free;
 }
 
+/* A filter which only shows objects shown by all sub-filters. */
+struct combine_filter_data {
+	struct subfilter *sub;
+	size_t nr;
+};
+
+static int should_delegate(enum list_objects_filter_situation filter_situation,
+			   struct object *obj,
+			   struct subfilter *sub)
+{
+	if (!sub->is_skipping_tree)
+		return 1;
+	if (filter_situation == LOFS_END_TREE &&
+		oideq(&obj->oid, &sub->skip_tree)) {
+		sub->is_skipping_tree = 0;
+		return 1;
+	}
+	return 0;
+}
+
+static enum list_objects_filter_result process_subfilter(
+	struct repository *r,
+	enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	struct subfilter *sub)
+{
+	enum list_objects_filter_result result;
+
+	/*
+	 * Check should_delegate before oidset_contains so that
+	 * is_skipping_tree gets unset even when the object is marked as seen.
+	 * As of this writing, no filter uses LOFR_MARK_SEEN on trees that also
+	 * uses LOFR_SKIP_TREE, so the ordering is only theoretically
+	 * important. Be cautious if you change the order of the below checks
+	 * and more filters have been added!
+	 */
+	if (!should_delegate(filter_situation, obj, sub))
+		return LOFR_ZERO;
+	if (oidset_contains(&sub->seen, &obj->oid))
+		return LOFR_ZERO;
+
+	result = list_objects_filter__filter_object(
+		r, filter_situation, obj, pathname, filename, sub->filter);
+
+	if (result & LOFR_MARK_SEEN)
+		oidset_insert(&sub->seen, &obj->oid);
+
+	if (result & LOFR_SKIP_TREE) {
+		sub->is_skipping_tree = 1;
+		sub->skip_tree = obj->oid;
+	}
+
+	return result;
+}
+
+static enum list_objects_filter_result filter_combine(
+	struct repository *r,
+	enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	struct oidset *omits,
+	void *filter_data)
+{
+	struct combine_filter_data *d = filter_data;
+	enum list_objects_filter_result combined_result =
+		LOFR_DO_SHOW | LOFR_MARK_SEEN | LOFR_SKIP_TREE;
+	size_t sub;
+
+	for (sub = 0; sub < d->nr; sub++) {
+		enum list_objects_filter_result sub_result = process_subfilter(
+			r, filter_situation, obj, pathname, filename,
+			&d->sub[sub]);
+		if (!(sub_result & LOFR_DO_SHOW))
+			combined_result &= ~LOFR_DO_SHOW;
+		if (!(sub_result & LOFR_MARK_SEEN))
+			combined_result &= ~LOFR_MARK_SEEN;
+		if (!d->sub[sub].is_skipping_tree)
+			combined_result &= ~LOFR_SKIP_TREE;
+	}
+
+	return combined_result;
+}
+
+static void filter_combine__free(void *filter_data)
+{
+	struct combine_filter_data *d = filter_data;
+	size_t sub;
+	for (sub = 0; sub < d->nr; sub++) {
+		list_objects_filter__free(d->sub[sub].filter);
+		oidset_clear(&d->sub[sub].seen);
+		if (d->sub[sub].omits.set.size)
+			BUG("expected oidset to be cleared already");
+	}
+	free(d->sub);
+}
+
+static void add_all(struct oidset *dest, struct oidset *src) {
+	struct oidset_iter iter;
+	struct object_id *src_oid;
+
+	oidset_iter_init(src, &iter);
+	while ((src_oid = oidset_iter_next(&iter)) != NULL)
+		oidset_insert(dest, src_oid);
+}
+
+static void filter_combine__finalize_omits(
+	struct oidset *omits,
+	void *filter_data)
+{
+	struct combine_filter_data *d = filter_data;
+	size_t sub;
+
+	for (sub = 0; sub < d->nr; sub++) {
+		add_all(omits, &d->sub[sub].omits);
+		oidset_clear(&d->sub[sub].omits);
+	}
+}
+
+static void filter_combine__init(
+	struct list_objects_filter_options *filter_options,
+	struct filter* filter)
+{
+	struct combine_filter_data *d = xcalloc(1, sizeof(*d));
+	size_t sub;
+
+	d->nr = filter_options->sub_nr;
+	d->sub = xcalloc(d->nr, sizeof(*d->sub));
+	for (sub = 0; sub < d->nr; sub++)
+		d->sub[sub].filter = list_objects_filter__init(
+			filter->omits ? &d->sub[sub].omits : NULL,
+			&filter_options->sub[sub]);
+
+	filter->filter_data = d;
+	filter->filter_object_fn = filter_combine;
+	filter->free_fn = filter_combine__free;
+	filter->finalize_omits_fn = filter_combine__finalize_omits;
+}
+
 typedef void (*filter_init_fn)(
 	struct list_objects_filter_options *filter_options,
 	struct filter *filter);
 
 /*
  * Must match "enum list_objects_filter_choice".
  */
 static filter_init_fn s_filters[] = {
 	NULL,
 	filter_blobs_none__init,
 	filter_blobs_limit__init,
 	filter_trees_depth__init,
 	filter_sparse_oid__init,
 	filter_sparse_path__init,
+	filter_combine__init,
 };
 
 struct filter *list_objects_filter__init(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options)
 {
 	struct filter *filter;
 	filter_init_fn init_fn;
 
 	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
@@ -547,13 +704,15 @@ enum list_objects_filter_result list_objects_filter__filter_object(
 	 */
 	if (filter_situation == LOFS_END_TREE)
 		return 0;
 	return LOFR_MARK_SEEN | LOFR_DO_SHOW;
 }
 
 void list_objects_filter__free(struct filter *filter)
 {
 	if (!filter)
 		return;
+	if (filter->finalize_omits_fn && filter->omits)
+		filter->finalize_omits_fn(filter->omits, filter->filter_data);
 	filter->free_fn(filter->filter_data);
 	free(filter);
 }
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 9c11427719..c36199457d 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -284,21 +284,33 @@ test_expect_success 'verify tree:0 includes trees in "filtered" output' '
 # Make sure tree:0 does not iterate through any trees.
 
 test_expect_success 'verify skipping tree iteration when not collecting omits' '
 	GIT_TRACE=1 git -C r3 rev-list \
 		--objects --filter=tree:0 HEAD 2>filter_trace &&
 	grep "Skipping contents of tree [.][.][.]" filter_trace >actual &&
 	# One line for each commit traversed.
 	test_line_count = 2 actual &&
 
 	# Make sure no other trees were considered besides the root.
-	! grep "Skipping contents of tree [^.]" filter_trace
+	! grep "Skipping contents of tree [^.]" filter_trace &&
+
+	# Try this again with "combine:". If both sub-filters are skipping
+	# trees, the composite filter should also skip trees. This is not
+	# important unless the user does combine:tree:X+tree:Y or another filter
+	# besides "tree:" is implemented in the future which can skip trees.
+	GIT_TRACE=1 git -C r3 rev-list \
+		--objects --filter=combine:tree:1+tree:3 HEAD 2>filter_trace &&
+
+	# Only skip the dir1/ tree, which is shared between the two commits.
+	grep "Skipping contents of tree " filter_trace >actual &&
+	test_write_lines "Skipping contents of tree dir1/..." >expected &&
+	test_cmp expected actual
 '
 
 # Test tree:# filters.
 
 expect_has () {
 	commit=$1 &&
 	name=$2 &&
 
 	hash=$(git -C r3 rev-parse $commit:$name) &&
 	grep "^$hash $name$" actual
@@ -336,20 +348,138 @@ test_expect_success 'verify tree:3 includes everything expected' '
 	expect_has HEAD dir1/sparse1 &&
 	expect_has HEAD dir1/sparse2 &&
 	expect_has HEAD pattern &&
 	expect_has HEAD sparse1 &&
 	expect_has HEAD sparse2 &&
 
 	# There are also 2 commit objects
 	test_line_count = 10 actual
 '
 
+test_expect_success 'combine:... for a simple combination' '
+	git -C r3 rev-list --objects --filter=combine:tree:2+blob:none HEAD \
+		>actual &&
+
+	expect_has HEAD "" &&
+	expect_has HEAD~1 "" &&
+	expect_has HEAD dir1 &&
+
+	# There are also 2 commit objects
+	test_line_count = 5 actual
+'
+
+test_expect_success 'combine:... with URL encoding' '
+	git -C r3 rev-list --objects \
+		--filter=combine:tree%3a2+blob:%6Eon%65 HEAD >actual &&
+
+	expect_has HEAD "" &&
+	expect_has HEAD~1 "" &&
+	expect_has HEAD dir1 &&
+
+	# There are also 2 commit objects
+	test_line_count = 5 actual
+'
+
+expect_invalid_filter_spec () {
+	spec="$1" &&
+	err="$2" &&
+
+	test_must_fail git -C r3 rev-list --objects --filter="$spec" HEAD \
+		>actual 2>actual_stderr &&
+	test_must_be_empty actual &&
+	test_i18ngrep "$err" actual_stderr
+}
+
+test_expect_success 'combine:... while URL-encoding things that should not be' '
+	expect_invalid_filter_spec combine%3Atree:2+blob:none \
+		"invalid filter-spec"
+'
+
+test_expect_success 'combine: with nothing after the :' '
+	expect_invalid_filter_spec combine: "expected something after combine:"
+'
+
+test_expect_success 'parse error in first sub-filter in combine:' '
+	expect_invalid_filter_spec combine:tree:asdf+blob:none \
+		"expected .tree:<depth>."
+'
+
+test_expect_success 'combine:... with invalid URL-encoded sequences' '
+	# Not enough hex chars
+	expect_invalid_filter_spec combine:tree:2+blob:non%a \
+		"error in filter-spec - invalid hex sequence after %" &&
+	# Non-hex digit after %
+	expect_invalid_filter_spec combine:tree:2+blob%G5none \
+		"error in filter-spec - invalid hex sequence after %" &&
+	# Null byte encoded by %
+	expect_invalid_filter_spec combine:tree:2+blob%00none \
+		"error in filter-spec - unexpected %00"
+'
+
+test_expect_success 'combine:... with non-encoded reserved chars' '
+	expect_invalid_filter_spec combine:tree:2+sparse:@xyz \
+		"must escape char in sub-filter-spec: .@." &&
+	expect_invalid_filter_spec combine:tree:2+sparse:\` \
+		"must escape char in sub-filter-spec: .\`." &&
+	expect_invalid_filter_spec combine:tree:2+sparse:~abc \
+		"must escape char in sub-filter-spec: .\~."
+'
+
+test_expect_success 'validate err msg for "combine:<valid-filter>+"' '
+	expect_invalid_filter_spec combine:tree:2+ "expected .tree:<depth>."
+'
+
+test_expect_success 'combine:... with edge-case hex digits: Ff Aa 0 9' '
+	git -C r3 rev-list --objects --filter="combine:tree:2+bl%6Fb:n%6fne" \
+		HEAD >actual &&
+	test_line_count = 5 actual &&
+	git -C r3 rev-list --objects --filter="combine:tree%3A2+blob%3anone" \
+		HEAD >actual &&
+	test_line_count = 5 actual &&
+	git -C r3 rev-list --objects --filter="combine:tree:%30" HEAD >actual &&
+	test_line_count = 2 actual &&
+	git -C r3 rev-list --objects --filter="combine:tree:%39+blob:none" \
+		HEAD >actual &&
+	test_line_count = 5 actual
+'
+
+test_expect_success 'add a sparse pattern blob whose path has reserved chars' '
+	cp r3/pattern r3/pattern1+renamed% &&
+	git -C r3 add pattern1+renamed% &&
+	git -C r3 commit -m "add sparse pattern file with reserved chars"
+'
+
+test_expect_success 'combine:... with more than two sub-filters' '
+	git -C r3 rev-list --objects \
+		--filter=combine:tree:3+blob:limit=40+sparse:oid=master:pattern \
+		HEAD >actual &&
+
+	expect_has HEAD "" &&
+	expect_has HEAD~1 "" &&
+	expect_has HEAD~2 "" &&
+	expect_has HEAD dir1 &&
+	expect_has HEAD dir1/sparse1 &&
+	expect_has HEAD dir1/sparse2 &&
+
+	# Should also have 3 commits
+	test_line_count = 9 actual &&
+
+	# Try again, this time making sure the last sub-filter is only
+	# URL-decoded once.
+	cp actual expect &&
+
+	git -C r3 rev-list --objects \
+		--filter=combine:tree:3+blob:limit=40+sparse:oid=master:pattern1%2brenamed%25 \
+		HEAD >actual &&
+	test_cmp expect actual
+'
+
 # Test provisional omit collection logic with a repo that has objects appearing
 # at multiple depths - first deeper than the filter's threshold, then shallow.
 
 test_expect_success 'setup r4' '
 	git init r4 &&
 
 	echo foo > r4/foo &&
 	mkdir r4/subdir &&
 	echo bar > r4/subdir/bar &&
 
@@ -379,20 +509,51 @@ test_expect_success 'test tree:# filter provisional omit for blob and tree' '
 
 test_expect_success 'verify skipping tree iteration when collecting omits' '
 	GIT_TRACE=1 git -C r4 rev-list --filter-print-omitted \
 		--objects --filter=tree:0 HEAD 2>filter_trace &&
 	grep "^Skipping contents of tree " filter_trace >actual &&
 
 	echo "Skipping contents of tree subdir/..." >expect &&
 	test_cmp expect actual
 '
 
+test_expect_success 'setup r5' '
+	git init r5 &&
+	mkdir -p r5/subdir &&
+
+	echo 1     >r5/short-root          &&
+	echo 12345 >r5/long-root           &&
+	echo a     >r5/subdir/short-subdir &&
+	echo abcde >r5/subdir/long-subdir  &&
+
+	git -C r5 add short-root long-root subdir &&
+	git -C r5 commit -m "commit msg"
+'
+
+test_expect_success 'verify collecting omits in combined: filter' '
+	# Note that this test guards against the naive implementation of simply
+	# giving both filters the same "omits" set and expecting it to
+	# automatically merge them.
+	git -C r5 rev-list --objects --quiet --filter-print-omitted \
+		--filter=combine:tree:2+blob:limit=3 HEAD >actual &&
+
+	# Expect 0 trees/commits, 3 blobs omitted (all blobs except short-root)
+	omitted_1=$(echo 12345 | git hash-object --stdin) &&
+	omitted_2=$(echo a     | git hash-object --stdin) &&
+	omitted_3=$(echo abcde | git hash-object --stdin) &&
+
+	grep ~$omitted_1 actual &&
+	grep ~$omitted_2 actual &&
+	grep ~$omitted_3 actual &&
+	test_line_count = 3 actual
+'
+
 # Test tree:<depth> where a tree is iterated to twice - once where a subentry is
 # too deep to be included, and again where the blob inside it is shallow enough
 # to be included. This makes sure we don't use LOFR_MARK_SEEN incorrectly (we
 # can't use it because a tree can be iterated over again at a lower depth).
 
 test_expect_success 'tree:<depth> where we iterate over tree at two levels' '
 	git init r5 &&
 
 	mkdir -p r5/a/subdir/b &&
 	echo foo > r5/a/subdir/b/foo &&
-- 
2.17.1

