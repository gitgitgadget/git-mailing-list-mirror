Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A81A1F462
	for <e@80x24.org>; Sat, 15 Jun 2019 00:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfFOAmN (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 20:42:13 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:43163 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFOAmN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 20:42:13 -0400
Received: by mail-qk1-f201.google.com with SMTP id v4so3592272qkj.10
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 17:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vpgrkTt2Uty8Z4fTgWNWisCTMHP9a74XD1I+8SC1W9Q=;
        b=BknTBNs/3FWEc6deFxXlBp6DvLCTcmleR1caSE5onNMuMpDOsYVyeZzwNFkhydQ3+V
         k+pRan/w5p9o51R69GAkk2+Bek0ejwroQFp1m3AVZxjHxLCUtg6FiPixCnM5C8IJfDxr
         yPxsLiMTo/NBBiT8cJh4Y7pDkr0U+teV7HX703RvzGKPvnwOjNEzVTWkdopvoViCI4IP
         z+d2nJU27VCSItcaI8szJFQM3iCdilz4OIJFEsLCXlQzAMcYoRVUNrhqe6daY0jwew6o
         VUtqK0I68+IHm/kFLj9zggye+yy25ic2gc1VyRb0FbQpsOmKjQ8sGYKwTUYKVfg1uRH+
         Y/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vpgrkTt2Uty8Z4fTgWNWisCTMHP9a74XD1I+8SC1W9Q=;
        b=WsdToFNu8FIsyTXhnnyXkd5G8KHuG8kLDQQYnIBu3u1pjZocFPKKnwb0g0Rnb5ZpYZ
         bV3OjKPSJdx5S1lLt5hmEHtjVrcSoEkeI2XgRLlhKZE7AOZkH9p6yo318NrFJQmD+RUl
         QuhKebdsR5p61ilEGha7urYACaYd+8wWep924y8qHAs4ZIUcoz5/FP9v9QzjpPS33iJR
         TcWNJrSntyWLJMFwy9R1nWOuQBFt+6IplJpOALhEZe9NxtFT1oN+tHAeV+7M+va7Mzh2
         yR0Ok8sTwpv+uItC+LW2GJJRyzWxTW7zkLtKsj0fvW1LVw3SgFeF+EnfU5FWkBizP0R9
         rsfw==
X-Gm-Message-State: APjAAAWSA7/p82Kt7d9IcLKJwOO6fPerN34pQmVk7Vawg5aRQS8mPhJ3
        DN1prQgbycnGyeiA0j8emoSl9QZozn9FStYZvLpBl3my/jvSsONCw6t2+2gzvSG8/WPrEXOA80f
        gzNSqf1vxgfcgBw+dTPBWniH2j3X0sxt0zDlyxVLDdWJQJYEisSUecVTmalI=
X-Google-Smtp-Source: APXvYqzM9g/QZjxzLdhhbX5WwTc6c8O1OTI4m8UdcLHO4jnaiI923NMBk+sWjCdFqzKSN0DKaH1jm929lWub
X-Received: by 2002:ac8:1c7b:: with SMTP id j56mr62221106qtk.247.1560559331762;
 Fri, 14 Jun 2019 17:42:11 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:40:10 -0700
In-Reply-To: <cover.1560558910.git.matvore@google.com>
Message-Id: <47a2680875e6f68fbf1f2e5a5a2630d263cdf426.1560558910.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1560558910.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 04/10] list-objects-filter: implement composite filters
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
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

The URL-encoding scheme is being introduced before the repeated flag
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
 list-objects-filter-options.c       | 106 ++++++++++++++++++-
 list-objects-filter-options.h       |  17 ++-
 list-objects-filter.c               | 159 ++++++++++++++++++++++++++++
 t/t6112-rev-list-filters-objects.sh | 151 +++++++++++++++++++++++++-
 url.c                               |   6 ++
 url.h                               |   8 ++
 6 files changed, 441 insertions(+), 6 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 8e7b4f96fa..1c402c6059 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -1,18 +1,24 @@
 #include "cache.h"
 #include "commit.h"
 #include "config.h"
 #include "revision.h"
 #include "argv-array.h"
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
+#include "url.h"
+
+static int parse_combine_filter(
+	struct list_objects_filter_options *filter_options,
+	const char *arg,
+	struct strbuf *errbuf);
 
 /*
  * Parse value of the argument to the "filter" keyword.
  * On the command line this looks like:
  *       --filter=<arg>
  * and in the pack protocol as:
  *       "filter" SP <arg>
  *
  * The filter keyword will be used by many commands.
  * See Documentation/rev-list-options.txt for allowed values for <arg>.
@@ -28,22 +34,20 @@ static int gently_parse_list_objects_filter(
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
 
@@ -70,36 +74,125 @@ static int gently_parse_list_objects_filter(
 		filter_options->choice = LOFC_SPARSE_OID;
 		return 0;
 
 	} else if (skip_prefix(arg, "sparse:path=", &v0)) {
 		if (errbuf) {
 			strbuf_addstr(
 				errbuf,
 				_("sparse:path filters support has been dropped"));
 		}
 		return 1;
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
+	char *decoded;
+	int result;
+
+	ALLOC_GROW(filter_options->sub, filter_options->sub_nr,
+		   filter_options->sub_alloc);
+	memset(&filter_options->sub[new_index], 0,
+	       sizeof(*filter_options->sub));
+
+	decoded = url_percent_decode(subspec->buf);
+
+	result = has_reserved_character(subspec, errbuf) ||
+		gently_parse_list_objects_filter(
+			&filter_options->sub[new_index], decoded, errbuf);
+
+	free(decoded);
+	return result;
+}
+
+static int parse_combine_filter(
+	struct list_objects_filter_options *filter_options,
+	const char *arg,
+	struct strbuf *errbuf)
+{
+	struct strbuf **subspecs = strbuf_split_str(arg, '+', 0);
+	size_t sub;
+	int result = 0;
+
+	if (!subspecs[0]) {
+		strbuf_addf(errbuf,
+			    _("expected something after combine:"));
+		result = 1;
+		goto cleanup;
+	}
+
+	for (sub = 0; subspecs[sub] && !result; sub++) {
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
 
@@ -122,22 +215,29 @@ void expand_list_objects_filter_spec(
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
@@ -167,15 +267,17 @@ void partial_clone_register(
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
index c54f0000fb..789faef1e5 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -6,20 +6,21 @@
 
 /*
  * The list of defined filters for list-objects.
  */
 enum list_objects_filter_choice {
 	LOFC_DISABLED = 0,
 	LOFC_BLOB_NONE,
 	LOFC_BLOB_LIMIT,
 	LOFC_TREE_DEPTH,
 	LOFC_SPARSE_OID,
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
@@ -31,27 +32,37 @@ struct list_objects_filter_options {
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
index b259039bd0..8d015bf164 100644
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
@@ -464,33 +479,175 @@ static void filter_sparse_oid__init(
 
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
+	filter_combine__init,
 };
 
 struct filter *list_objects_filter__init(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options)
 {
 	struct filter *filter;
 	filter_init_fn init_fn;
 
 	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
@@ -528,13 +685,15 @@ enum list_objects_filter_result list_objects_filter__filter_object(
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
index acd7f5ab80..05d4f2e9c2 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -271,21 +271,33 @@ test_expect_success 'verify tree:0 includes trees in "filtered" output' '
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
@@ -323,20 +335,126 @@ test_expect_success 'verify tree:3 includes everything expected' '
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
 
@@ -366,20 +484,51 @@ test_expect_success 'test tree:# filter provisional omit for blob and tree' '
 
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
diff --git a/url.c b/url.c
index 25576c390b..bdede647bc 100644
--- a/url.c
+++ b/url.c
@@ -79,20 +79,26 @@ char *url_decode_mem(const char *url, int len)
 
 	/* Skip protocol part if present */
 	if (colon && url < colon) {
 		strbuf_add(&out, url, colon - url);
 		len -= colon - url;
 		url = colon;
 	}
 	return url_decode_internal(&url, len, NULL, &out, 0);
 }
 
+char *url_percent_decode(const char *encoded)
+{
+	struct strbuf out = STRBUF_INIT;
+	return url_decode_internal(&encoded, strlen(encoded), NULL, &out, 0);
+}
+
 char *url_decode_parameter_name(const char **query)
 {
 	struct strbuf out = STRBUF_INIT;
 	return url_decode_internal(query, -1, "&=", &out, 1);
 }
 
 char *url_decode_parameter_value(const char **query)
 {
 	struct strbuf out = STRBUF_INIT;
 	return url_decode_internal(query, -1, "&", &out, 1);
diff --git a/url.h b/url.h
index 00b7d58c33..2a27c34277 100644
--- a/url.h
+++ b/url.h
@@ -1,16 +1,24 @@
 #ifndef URL_H
 #define URL_H
 
 struct strbuf;
 
 int is_url(const char *url);
 int is_urlschemechar(int first_flag, int ch);
 char *url_decode(const char *url);
 char *url_decode_mem(const char *url, int len);
+
+/*
+ * Similar to the url_decode_{,mem} methods above, but doesn't assume there
+ * is a scheme followed by a : at the start of the string. Instead, %-sequences
+ * before any : are also parsed.
+ */
+char *url_percent_decode(const char *encoded);
+
 char *url_decode_parameter_name(const char **query);
 char *url_decode_parameter_value(const char **query);
 
 void end_url_with_slash(struct strbuf *buf, const char *url);
 void str_end_url_with_slash(const char *url, char **dest);
 
 #endif /* URL_H */
-- 
2.21.0

