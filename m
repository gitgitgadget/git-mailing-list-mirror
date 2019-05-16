Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5A11F461
	for <e@80x24.org>; Thu, 16 May 2019 18:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfEPS6E (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 14:58:04 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:53986 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfEPS6D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 14:58:03 -0400
Received: by mail-ot1-f73.google.com with SMTP id f11so2101095otl.20
        for <git@vger.kernel.org>; Thu, 16 May 2019 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2mo4HxWdFo58aub/cF1TsFZo38RBIWJ021anQwPKdd0=;
        b=aLIaPWoPfwQd4FlV8LpoCuAZvnjQh/74fEXbLxx6kmCXp0rw5t+LfAWEYvH0UQ5cS8
         eeCj+d0C9v+sQE5CK0F43ALKthGyYLefnv3mwkV1gvYghDZ0fg7NUZBThs8JGE5yIhSa
         d6h5SCEwaCgL1My4GS60tTRvysT3FDq9PI2A/a5EnFaXm4VFLoO0VYR8+CwD/C38hLH3
         t4rIiammN8TOi9f1jtL7hI2SIRn2+kCrIy6YnawSW8xNueCsuH9MrOco1m+3VnDJ6G80
         zkw77FO0/k60JtYGYogI9n4HP/+/a76cdD850iktdEsCpo9t3zGjPykW9Tdo7NoX60mO
         AEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2mo4HxWdFo58aub/cF1TsFZo38RBIWJ021anQwPKdd0=;
        b=T6ZHD20jgDJsF6gTuY0CLjOOnY2LED6iPxd7QWMnXElRZFjTDBza6oIwPENwJ7WOqw
         uxmJWrHXukxp1RNVT0X0TeIKN+dw2YbfJl/0h9DDVq/eW15yAV3GmJRUYkTjMyXwavFC
         UDmhUojE9l7qd2jsMwYlvokClANUXYfRD1SFUBr2EbDyb6/9vdVr3kSXu+ruYviUW/IH
         gNuU8/JE0iP6t6iNKW76oNiNin3130e4HXtgtMF/hb7mrXQGbaFzG7z6OYF+Wccd6+Rf
         lxTQnWEyZbB08Nq6k5OmA3OoE8rQVsBHrJRcsX9vMhf1o6NgkbcDt37gGeS0BI3Matav
         HZyg==
X-Gm-Message-State: APjAAAX2UCO34yuu+vxHp8cqn2pNic2vHccXJ6AP6RKTwytt6ujPxMqj
        fqAc9JcRiL07ROgRCu61rF85NQ+Mndo=
X-Google-Smtp-Source: APXvYqxvMP2ueHKHRUKph+Mrgr2F32+GKeI6pYQl8xAy5XqQkMeY43PQadZxy0YvgK8nwoiWZSovBxzlHG2k
X-Received: by 2002:aca:a98b:: with SMTP id s133mr10602058oie.146.1558033082373;
 Thu, 16 May 2019 11:58:02 -0700 (PDT)
Date:   Thu, 16 May 2019 11:56:51 -0700
In-Reply-To: <cover.1558030802.git.matvore@google.com>
Message-Id: <02a8c9b017d8df056d7e90aff907d6e0b5506467.1558030802.git.matvore@google.com>
Mime-Version: 1.0
References: <20190514001610.GA136746@google.com> <cover.1558030802.git.matvore@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [RFC PATCH 3/3] list-objects-filter: implement composite filters
From:   Matthew DeVore <matvore@google.com>
To:     jonathantanmy@google.com, jrn@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
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

The current usage requires passing the filter to rev-list, or sending
it over the wire, as:

	combine:<FILTER1>+<FILTER2>

(i.e.: git rev-list --filter=combine:tree:2+blob:limit=32k). This is
potentially awkward because individual filters must be URL-encoded if
they contain + or %. This can potentially be improved by supporting a
repeated flag syntax, e.g.:

	$ git rev-list --filter=tree:2 --filter:blob:limit=32k

Such usage is currently an error, so giving it a meaning is backwards-
compatible.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 Documentation/rev-list-options.txt     |   8 ++
 contrib/completion/git-completion.bash |   2 +-
 list-objects-filter-options.c          | 130 +++++++++++++++++++++++++
 list-objects-filter-options.h          |  14 ++-
 list-objects-filter.c                  | 116 ++++++++++++++++++++++
 t/t6112-rev-list-filters-objects.sh    | 108 +++++++++++++++++++-
 6 files changed, 373 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index ddbc1de43f..a2e14d3753 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -730,20 +730,28 @@ specification contained in <path>.
 +
 The form '--filter=tree:<depth>' omits all blobs and trees whose depth
 from the root tree is >= <depth> (minimum depth if an object is located
 at multiple depths in the commits traversed). <depth>=0 will not include
 any trees or blobs unless included explicitly in the command-line (or
 standard input when --stdin is used). <depth>=1 will include only the
 tree and blobs which are referenced directly by a commit reachable from
 <commit> or an explicitly-given object. <depth>=2 is like <depth>=1
 while also including trees and blobs one more level removed from an
 explicitly-given commit or tree.
++
+The form '--filter=combine:<filter1>+<filter2>+...<filterN>' combines
+several filters. Only objects which are accepted by every filter are
+included. Filters are joined by "+" and individual filters are %-encoded
+(i.e. URL-encoded). Only the "%" and "+" characters must be encoded. For
+instance, 'combine:tree:3+blob:none' and
+'combine:tree%3A2+blob%3Anone' are equivalent, and result in only tree
+objects whose depth from the root is >= 3 being included.
 
 --no-filter::
 	Turn off any previous `--filter=` argument.
 
 --filter-print-omitted::
 	Only useful with `--filter=`; prints a list of the objects omitted
 	by the filter.  Object IDs are prefixed with a ``~'' character.
 
 --missing=<missing-action>::
 	A debug option to help with future "partial clone" development.
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3eefbabdb1..0fd0a10d0c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1529,21 +1529,21 @@ _git_difftool ()
 __git_fetch_recurse_submodules="yes on-demand no"
 
 _git_fetch ()
 {
 	case "$cur" in
 	--recurse-submodules=*)
 		__gitcomp "$__git_fetch_recurse_submodules" "" "${cur##--recurse-submodules=}"
 		return
 		;;
 	--filter=*)
-		__gitcomp "blob:none blob:limit= sparse:oid= sparse:path=" "" "${cur##--filter=}"
+		__gitcomp "blob:none blob:limit= sparse:oid= sparse:path= combine: tree:" "" "${cur##--filter=}"
 		return
 		;;
 	--*)
 		__gitcomp_builtin fetch
 		return
 		;;
 	esac
 	__git_complete_remote_or_refspec
 }
 
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index e46ea467bc..e9d0de17e0 100644
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
@@ -74,33 +79,152 @@ static int gently_parse_list_objects_filter(
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
+		int sub_parse_res = parse_combine_filter(
+			filter_options, v0, errbuf);
+		if (sub_parse_res)
+			return sub_parse_res;
+		return 0;
+
 	}
 	/*
 	 * Please update _git_fetch() in git-completion.bash when you
 	 * add new filters
 	 */
 
 	if (errbuf)
 		strbuf_addf(errbuf, _("invalid filter-spec '%s'"), arg);
 
 	memset(filter_options, 0, sizeof(*filter_options));
 	return 1;
 }
 
+static int digit_value(int c, struct strbuf *errbuf) {
+	if (c >= '0' && c <= '9')
+		return c - '0';
+	if (c >= 'a' && c <= 'f')
+		return c - 'a' + 10;
+	if (c >= 'A' && c <= 'F')
+		return c - 'A' + 10;
+
+	if (!errbuf)
+		return -1;
+
+	strbuf_addf(errbuf, _("error in filter-spec - "));
+	if (c)
+		strbuf_addf(
+			errbuf,
+			_("expect two hex digits after %%, but got: '%c'"),
+			c);
+	else
+		strbuf_addf(
+			errbuf,
+			_("not enough hex digits after %%; expected two"));
+
+	return -1;
+}
+
+static int url_decode(struct strbuf *s, struct strbuf *errbuf) {
+	char *dest = s->buf;
+	char *src = s->buf;
+	while (*src) {
+		int digit_value_0, digit_value_1;
+
+		if (src[0] != '%') {
+			*dest++ = *src++;
+			continue;
+		}
+		src++;
+
+		digit_value_0 = digit_value(*src++, errbuf);
+		if (digit_value_0 < 0)
+			return 1;
+		digit_value_1 = digit_value(*src++, errbuf);
+		if (digit_value_1 < 0)
+			return 1;
+		*dest++ = digit_value_0 * 16 + digit_value_1;
+	}
+	size_t new_len = dest - s->buf;
+	strbuf_remove(s, new_len, s->len - new_len);
+
+	return 0;
+}
+
+static int parse_combine_filter(
+	struct list_objects_filter_options *filter_options,
+	const char *arg,
+	struct strbuf *errbuf)
+{
+	struct strbuf **sub_specs = strbuf_split_str(arg, '+', 2);
+	int result;
+
+	if (!sub_specs[0]) {
+		if (errbuf)
+			strbuf_addf(errbuf,
+				    _("expected something after combine:"));
+		result = 1;
+		goto cleanup;
+	}
+
+	/*
+	 * Only decode the first sub-filter, since the rest will be decoded on
+	 * the recursive call.
+	 */
+	result = url_decode(sub_specs[0], errbuf);
+	if (result)
+		goto cleanup;
+
+	if (!sub_specs[1]) {
+		/*
+		 * There is only one sub-filter, so we don't need the
+		 * combine: - just parse it as a non-composite filter.
+		 */
+		result = gently_parse_list_objects_filter(
+			filter_options, sub_specs[0]->buf, errbuf);
+		goto cleanup;
+	}
+
+	/* Remove trailing "+" so we can parse it. */
+	assert(sub_specs[0]->buf[sub_specs[0]->len - 1] == '+');
+	strbuf_remove(sub_specs[0], sub_specs[0]->len - 1, 1);
+
+	filter_options->choice = LOFC_COMBINE;
+	filter_options->lhs = xcalloc(1, sizeof(*filter_options->lhs));
+	result = gently_parse_list_objects_filter(filter_options->lhs,
+						  sub_specs[0]->buf,
+						  errbuf);
+	if (result)
+		goto cleanup;
+
+	filter_options->rhs = xcalloc(1, sizeof(*filter_options->rhs));
+	result = parse_combine_filter(filter_options->rhs,
+				      sub_specs[1]->buf,
+				      errbuf);
+
+cleanup:
+	strbuf_list_free(sub_specs);
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
 	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
 		die("%s", buf.buf);
 	return 0;
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
@@ -127,23 +251,29 @@ void expand_list_objects_filter_spec(
 	else if (filter->choice == LOFC_TREE_DEPTH)
 		strbuf_addf(expanded_spec, "tree:%lu",
 			    filter->tree_exclude_depth);
 	else
 		strbuf_addstr(expanded_spec, filter->filter_spec);
 }
 
 void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options)
 {
+	if (!filter_options)
+		return;
 	free(filter_options->filter_spec);
 	free(filter_options->sparse_oid_value);
 	free(filter_options->sparse_path_value);
+	list_objects_filter_release(filter_options->lhs);
+	free(filter_options->lhs);
+	list_objects_filter_release(filter_options->rhs);
+	free(filter_options->rhs);
 	memset(filter_options, 0, sizeof(*filter_options));
 }
 
 void partial_clone_register(
 	const char *remote,
 	const struct list_objects_filter_options *filter_options)
 {
 	/*
 	 * Record the name of the partial clone remote in the
 	 * config and in the global variable -- the latter is
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index e3adc78ebf..6c0f0ecd08 100644
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
@@ -32,28 +33,35 @@ struct list_objects_filter_options {
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
+	struct list_objects_filter_options *lhs, *rhs;
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
index 8e8616b9b8..28496f31f7 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -453,34 +453,150 @@ static void filter_sparse_path__init(
 
 	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
 	d->array_frame[d->nr].defval = 0; /* default to include */
 	d->array_frame[d->nr].child_prov_omit = 0;
 
 	ctx->filter_fn = filter_sparse;
 	ctx->free_fn = filter_sparse_free;
 	ctx->data = d;
 }
 
+struct filter_combine_data {
+	/* sub[0] corresponds to lhs, sub[1] to rhs. */
+	struct {
+		struct filter_context ctx;
+		struct oidset seen;
+		struct object_id skip_tree;
+		unsigned is_skipping_tree : 1;
+	} sub[2];
+};
+
+static void filter_combine_free(void *filter_data)
+{
+	struct filter_combine_data *d = filter_data;
+	int i;
+	for (i = 0; i < 2; i++) {
+		list_objects_filter__release(&d->sub[i].ctx);
+		oidset_clear(&d->sub[i].seen);
+	}
+	free(d);
+}
+
+static int should_delegate(enum list_objects_filter_situation filter_situation,
+			   struct object *obj,
+			   struct filter_combine_data *d,
+			   int side)
+{
+	if (!d->sub[side].is_skipping_tree)
+		return 1;
+	if (filter_situation == LOFS_END_TREE &&
+		oideq(&obj->oid, &d->sub[side].skip_tree)) {
+		d->sub[side].is_skipping_tree = 0;
+		return 1;
+	}
+	return 0;
+}
+
+static enum list_objects_filter_result filter_combine(
+	struct repository *r,
+	enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	struct filter_context *ctx)
+{
+	struct filter_combine_data *d = ctx->data;
+	enum list_objects_filter_result lhs_result = LOFR_ZERO;
+	enum list_objects_filter_result rhs_result = LOFR_ZERO;
+	int lhs_already_seen = oidset_contains(&d->sub[0].seen, &obj->oid);
+	int rhs_already_seen = oidset_contains(&d->sub[1].seen, &obj->oid);
+	int delegate_lhs = !lhs_already_seen &&
+		should_delegate(filter_situation, obj, d, 0);
+	int delegate_rhs = !rhs_already_seen &&
+		should_delegate(filter_situation, obj, d, 1);
+	enum list_objects_filter_result combined_result = LOFR_ZERO;
+
+	if (lhs_already_seen && rhs_already_seen)
+		return LOFR_ZERO;
+
+	if (delegate_lhs)
+		lhs_result = d->sub[0].ctx.filter_fn(
+			r, filter_situation, obj, pathname, filename,
+			&d->sub[0].ctx);
+	if (delegate_rhs)
+		rhs_result = d->sub[1].ctx.filter_fn(
+			r, filter_situation, obj, pathname, filename,
+			&d->sub[1].ctx);
+
+	if (lhs_result & LOFR_MARK_SEEN)
+		oidset_insert(&d->sub[0].seen, &obj->oid);
+
+	if (rhs_result & LOFR_MARK_SEEN)
+		oidset_insert(&d->sub[1].seen, &obj->oid);
+
+	if (lhs_result & LOFR_SKIP_TREE) {
+		d->sub[0].is_skipping_tree = 1;
+		d->sub[0].skip_tree = obj->oid;
+	}
+	if (rhs_result & LOFR_SKIP_TREE) {
+		d->sub[1].is_skipping_tree = 1;
+		d->sub[1].skip_tree = obj->oid;
+	}
+
+	if ((lhs_result & LOFR_DO_SHOW) && (rhs_result & LOFR_DO_SHOW))
+		combined_result |= LOFR_DO_SHOW;
+	if (d->sub[0].is_skipping_tree && d->sub[1].is_skipping_tree)
+		combined_result |= LOFR_SKIP_TREE;
+
+	return combined_result;
+}
+
+static void filter_combine__init(
+	struct list_objects_filter_options *filter_options,
+	struct filter_context *ctx)
+{
+	struct filter_combine_data *d = xcalloc(1, sizeof(*d));
+	struct oidset *lhs_omits = NULL;
+	struct oidset *rhs_omits = NULL;
+
+	if (ctx->omits) {
+		lhs_omits = xcalloc(1, sizeof(*lhs_omits));
+		oidset_init(lhs_omits, 16);
+		rhs_omits = xcalloc(1, sizeof(*rhs_omits));
+		oidset_init(rhs_omits, 16);
+	}
+
+	list_objects_filter__init(lhs_omits, filter_options->lhs,
+				  &d->sub[0].ctx);
+	list_objects_filter__init(rhs_omits, filter_options->rhs,
+				  &d->sub[1].ctx);
+
+	ctx->filter_fn = filter_combine;
+	ctx->free_fn = filter_combine_free;
+	ctx->data = d;
+}
+
 typedef void (*filter_init_fn)(
 	struct list_objects_filter_options *filter_options,
 	struct filter_context *ctx);
 
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
 
 void list_objects_filter__init(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
 	struct filter_context *ctx)
 {
 	filter_init_fn init_fn;
 
 	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 9c11427719..63c1524f6f 100755
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
@@ -336,20 +348,114 @@ test_expect_success 'verify tree:3 includes everything expected' '
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
+	test_i18ngrep "$err" actual_stderr && cat actual_stderr >/dev/stderr
+}
+
+test_expect_success 'combine:... while URL-encoding things that should not be' '
+	expect_invalid_filter_spec combine%3Atree:2+blob:none \
+		"invalid filter-spec"
+'
+
+test_expect_success 'combine:... with invalid URL-encoded sequences' '
+	expect_invalid_filter_spec combine:tree:2+blob:non%a \
+		"error in filter-spec - not enough hex digits after %" &&
+	# Edge cases for non-hex chars: "Gg/:@`"
+	expect_invalid_filter_spec combine:tree:2+blob%G5none \
+		"error in filter-spec - expect two hex digits .*: .G." &&
+	expect_invalid_filter_spec combine:tree:2+blob%5/none \
+		"error in filter-spec - expect two hex digits .*: ./." &&
+	expect_invalid_filter_spec combine:%:5tree:2+blob:none \
+		"error in filter-spec - expect two hex digits .*: .:." &&
+	expect_invalid_filter_spec combine:tree:2+blob:none%f@ \
+		"error in filter-spec - expect two hex digits .*: .@." &&
+	expect_invalid_filter_spec combine:tree:2+blob:none%f\` \
+		"error in filter-spec - expect two hex digits .*: .\`."
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
+test_expect_success 'combine:... with more than two sub-filters' '
+	git -C r3 rev-list --objects \
+		--filter=combine:tree:3+blob:limit=40+sparse:path=../pattern1 \
+		HEAD >actual &&
+
+	expect_has HEAD "" &&
+	expect_has HEAD~1 "" &&
+	expect_has HEAD dir1 &&
+	expect_has HEAD dir1/sparse1 &&
+	expect_has HEAD dir1/sparse2 &&
+
+	# Should also have 2 commits
+	test_line_count = 7 actual &&
+
+	# Try again, this time making sure the last sub-filter is only
+	# URL-decoded once.
+	cp pattern1 pattern1+renamed% &&
+	cp actual expect &&
+
+	git -C r3 rev-list --objects \
+		--filter=combine:tree:3+blob:limit=40+sparse:path=../pattern1%2brenamed%25 \
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
 
-- 
2.21.0

