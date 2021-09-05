Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE137C433FE
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 23:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76EC160F8F
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 23:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhIEXwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 19:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhIEXwq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 19:52:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB517C061757
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 16:51:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z4so7118062wrr.6
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yOrIfMGP2yLVzDzxj+jcvCmTtxUMKfqzq2ZBB86tTBY=;
        b=d4JUNz7yQqsw5M5fBBmc8bqIEKVy2VIrGiIDAyd6/5lwW30rmGCQi0md6bKseaqZFz
         UytzNsLqwLm4uL1VvS7QbQWCVt28AgKY0cfx9qMoBAVBfgeRX2mDFF2E/F7246nmONHr
         J67pTWTDIUdHJ6V+47izLgbX9jOLHG1xthtA+znqTB3m1vWUeieYifQCgch6Vs2WFlIa
         DZSiJKjdi60c1GaApGDzkNfkRYyF54jDIk+Ecz65QpPN8ZHl5glhDcdz0r2mPZKOXzrT
         9Qh/EchV5DejDROEaciX9szjOejMbS/WiTG43LvB3GhWfDx7q4YUTKwGDO7qpEZDywr0
         ZZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yOrIfMGP2yLVzDzxj+jcvCmTtxUMKfqzq2ZBB86tTBY=;
        b=rR2FuahWCDfGbbRyj6KiBC3myqh/2Uxgqhi8LcJ4vU6UAXRWFRleihQM1w9gTBEO3w
         5EPIXPM9SPmkvDcvP1c8eB7xXc6QjxLjHmx60wYXc7bbJjg+RdWfa5TkmoRNokZDHzhm
         KpVp3H2BYQmoT5A9Z0SAwe5ITx3dLYsGPekxDkj3j3YPlc+QZIk4SLwbg3SDVLbkrghS
         ybyCvKt0Pkxtwws0wxhBtUMobida+skMNEQTnonOZvzTaieakhXFniSTK728ixjHq+7o
         SPt257Nt0nSCmWZCJ4eX1W+cieSXDlPTlJJ//dr/TfGW3y7VRLyJ5GXOO6gurI0eVovt
         HeAQ==
X-Gm-Message-State: AOAM532nU4dA1CivcixLmOATbtXlo1k86Fud9VrD9aYbKyYua5oJ45yK
        tN4uq6QvWaPlI9hRR4sTzOgufVfLVXs=
X-Google-Smtp-Source: ABdhPJzJyyJ82orwuDu/7fG7KR06ddGIRtGqSKi8zWxii4ph62Z6OPJU0CP7oYIzjcraDBVB7Mfjjw==
X-Received: by 2002:adf:9e01:: with SMTP id u1mr10460318wre.420.1630885901293;
        Sun, 05 Sep 2021 16:51:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w29sm6168136wra.88.2021.09.05.16.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 16:51:40 -0700 (PDT)
Message-Id: <a5383a68cc024eca9bb95fc3c24dce499efaaa19.1630885899.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
References: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
From:   "Andrew Olsen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 05 Sep 2021 23:51:36 +0000
Subject: [PATCH 1/4] Compile-time extensions for list-object-filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrew Olsen <andrew232@gmail.com>,
        Andrew Olsen <andrew.olsen@koordinates.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrew Olsen <andrew.olsen@koordinates.com>

Adds an extension:<custom-filter> option to list-object-filters,
these are implemented by static libraries that must be compiled into
Git. C code changes only - Makefile changes follow.

Signed-off-by: Andrew Olsen <andrew.olsen@koordinates.com>
---
 .gitignore                                 |   1 +
 generate-list-objects-filter-extensions.sh |  53 ++++++++++
 list-objects-filter-extensions.h           | 107 +++++++++++++++++++++
 list-objects-filter-options.c              |  47 +++++++++
 list-objects-filter-options.h              |   6 ++
 list-objects-filter.c                      |  84 ++++++++++++++++
 6 files changed, 298 insertions(+)
 create mode 100755 generate-list-objects-filter-extensions.sh
 create mode 100644 list-objects-filter-extensions.h

diff --git a/.gitignore b/.gitignore
index 311841f9bed..3564cb01ad7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -190,6 +190,7 @@
 /gitweb/static/gitweb.min.*
 /config-list.h
 /command-list.h
+/list-objects-filter-extensions.c
 *.tar.gz
 *.dsc
 *.deb
diff --git a/generate-list-objects-filter-extensions.sh b/generate-list-objects-filter-extensions.sh
new file mode 100755
index 00000000000..422b1ce837f
--- /dev/null
+++ b/generate-list-objects-filter-extensions.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+
+if [ $# -gt 0 ]; then
+
+	# ARGS has one argument per line
+	ARGS=$(echo "$@" | xargs printf '%s\n')
+
+	# Every argument should be path to a filter extension library.
+	INVALID_ARGS=$(echo "$ARGS" | grep -v '\.a$')
+	if [ -n "$INVALID_ARGS" ] ; then
+		printf "Error: all arguments must be paths to .a files: \n%s\n" \
+			"${INVALID_ARGS}" >&2
+		exit 1
+	fi
+
+	# qux/foo.a -> foo
+	NAMES=$(echo "$ARGS" | sed -e 's!.*/!!' -e 's!.a$!!')
+
+	# Filter extension names must be valid C symbols so they can be linked by name.
+	INVALID_NAMES=$(echo "$NAMES" | grep -v '^[A-Za-z0-9_]\+$')
+	if [ -n "$INVALID_NAMES" ] ; then
+		printf "Error: all library names must also be valid C symbols: \n%s\n" \
+			"${INVALID_NAMES}" >&2
+		exit 1
+	fi
+
+	# foo -> filter_extension_foo
+	EXTS=$(echo "$NAMES" | sed -e 's!^!filter_extension_!')
+
+	# filter_extension_foo -> [\t]filter_extension_foo,
+	DECLARATIONS=$(echo "$EXTS" | sed -e 's!^!\t!' -e 's!$!,!')
+
+	# filter_extension_foo -> [\t]&filter_extension_foo,
+	ARRAY=$(echo "$EXTS" | sed -e 's!^!\t\&!' -e 's!$!,!')
+fi
+
+echo '/* Automatically generated by generate-list-objects-filter-extensions.sh */'
+echo
+echo '#include "git-compat-util.h"'
+echo '#include "list-objects-filter-extensions.h"'
+echo
+
+if [ $# -gt 0 ]; then
+	echo 'extern const struct filter_extension'
+	echo "${DECLARATIONS%?}"
+	echo ';'
+	echo
+fi
+
+echo 'const struct filter_extension *filter_extensions[] = {'
+echo "${ARRAY}"
+echo '	NULL,'
+echo '};'
\ No newline at end of file
diff --git a/list-objects-filter-extensions.h b/list-objects-filter-extensions.h
new file mode 100644
index 00000000000..35ebe1ead31
--- /dev/null
+++ b/list-objects-filter-extensions.h
@@ -0,0 +1,107 @@
+#ifndef GIT_LIST_OBJECTS_FILTER_EXTENSIONS_H
+#define GIT_LIST_OBJECTS_FILTER_EXTENSIONS_H
+
+/**
+ * The List-Objects-Filter Extensions API can be used to develop filter
+ * extensions for git-upload-pack/git-rev-list/etc.
+ *
+ * See contrib/filter-extensions/README.md for more details and examples.
+ *
+ * The API defines three functions to implement a filter operation. Note that
+ * each filter implementing this API must compiled into Git as a static library.
+ * There is some plumbing in the Makefile to help with this via
+ * FILTER_EXTENSIONS.
+ *
+ * 1. You write a filter and compile it into your custom build of git.
+ *    See list_objects_filter_ext_filter_fn.
+ * 2. A filter request is received that specifically names the filter extension
+ *    that you have written, ie: "--filter=extension:<name>[=<arg>]"
+ * 3. Your list_objects_filter_ext_init_fn() is called.
+ * 4. Your list_objects_filter_ext_filter_fn() is called for each object
+ *    at least once.
+ * 5. Your list_objects_filter_ext_free_fn() is called.
+ */
+
+#include "list-objects-filter.h"
+
+
+/* Whether to add or remove a specific object from any current omitset. */
+enum list_objects_filter_omit {
+       LOFO_KEEP = -1,
+       LOFO_IGNORE = 0,
+       LOFO_OMIT = 1,
+};
+
+/*
+ * This is a corollary to `list_objects_filter__init()` and constructs the
+ * filter, parsing and validating any user-provided `filter_arg` (via
+ * `--filter=extension:<name>=<arg>`). Use `context` for any filter-allocated
+ * context data.
+ *
+ * Return 0 on success and non-zero on error.
+ */
+typedef
+int list_objects_filter_ext_init_fn(
+    const struct repository *r,
+    const char* filter_arg,
+    void **context
+);
+
+/*
+ * This is a corollary to `list_objects_filter__free()`, destroying the filter
+ * and any filter-allocated context data.
+ */
+typedef
+void list_objects_filter_ext_free_fn(
+    const struct repository *r,
+    void *context
+);
+
+/*
+ * This is a corollary to `list_objects_filter__filter_object()`, and
+ * decides how to handle the object `obj`.
+ *
+ * omit provides a flag determining whether to explicitly add or remove
+ * the object from any current omitset.
+ */
+typedef
+enum list_objects_filter_result list_objects_filter_ext_filter_fn(
+	const struct repository *r,
+	const enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	enum list_objects_filter_omit *omit,
+	void *context
+);
+
+/*
+ * To implement a filter extension called "mine", you should define
+ * a const struct filter_extension called filter_extension_mine,
+ * in the following manner:
+ *
+ * const struct filter_extension filter_extension_mine = {
+ *     "mine",
+ *     &my_init_fn,
+ *     &my_filter_object_fn,
+ *     &my_free_fn
+ * };
+ *
+ * See contrib/filter-extensions/README.md for more details and examples.
+ */
+
+struct filter_extension {
+    const char *name;
+    list_objects_filter_ext_init_fn* init_fn;
+    list_objects_filter_ext_filter_fn* filter_object_fn;
+    list_objects_filter_ext_free_fn* free_fn;
+};
+
+/*
+ * The filter_extensions array is defined in list_objects_filter_extensions.c
+ * which is generated at compile time from the FILTER_EXTENSIONS variable.
+ */
+extern const struct filter_extension *filter_extensions[];
+
+
+#endif /* GIT_LIST_OBJECTS_FILTER_EXTENSIONS_H */
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index fd8d59f653a..e92499f29c2 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -15,6 +15,11 @@ static int parse_combine_filter(
 	const char *arg,
 	struct strbuf *errbuf);
 
+static int parse_extension_filter(
+	struct list_objects_filter_options *filter_options,
+	const char *arg,
+	struct strbuf *errbuf);
+
 const char *list_object_filter_config_name(enum list_objects_filter_choice c)
 {
 	switch (c) {
@@ -31,6 +36,8 @@ const char *list_object_filter_config_name(enum list_objects_filter_choice c)
 		return "sparse:oid";
 	case LOFC_OBJECT_TYPE:
 		return "object:type";
+	case LOFC_EXTENSION:
+		return "extension";
 	case LOFC_COMBINE:
 		return "combine";
 	case LOFC__COUNT:
@@ -91,6 +98,9 @@ static int gently_parse_list_objects_filter(
 		filter_options->choice = LOFC_SPARSE_OID;
 		return 0;
 
+	} else if (skip_prefix(arg, "extension:", &v0)) {
+		return parse_extension_filter(filter_options, v0, errbuf);
+
 	} else if (skip_prefix(arg, "sparse:path=", &v0)) {
 		if (errbuf) {
 			strbuf_addstr(
@@ -209,6 +219,41 @@ cleanup:
 	return result;
 }
 
+static int parse_extension_filter(
+	struct list_objects_filter_options *filter_options,
+	const char *arg,
+	struct strbuf *errbuf)
+{
+	int result = 0;
+	struct strbuf **params = strbuf_split_str(arg, '=', 2);
+
+	if (!params[0]) {
+		strbuf_addstr(errbuf, _("expected 'extension:<name>[=<parameter>]'"));
+		result = 1;
+		goto cleanup;
+	}
+
+	if (params[1]) {
+		// This extension has a parameter. Remove trailing "=" from the name.
+		size_t last = params[0]->len - 1;
+		assert(params[0]->buf[last] == '=');
+		strbuf_remove(params[0], last, 1);
+
+		filter_options->extension_value = xstrdup(params[1]->buf);
+	}
+
+	filter_options->extension_name = xstrdup(params[0]->buf);
+	filter_options->choice = LOFC_EXTENSION;
+
+cleanup:
+	strbuf_list_free(params);
+	if (result) {
+		list_objects_filter_release(filter_options);
+		memset(filter_options, 0, sizeof(*filter_options));
+	}
+	return result;
+}
+
 static int allow_unencoded(char ch)
 {
 	if (ch <= ' ' || ch == '%' || ch == '+')
@@ -349,6 +394,8 @@ void list_objects_filter_release(
 		return;
 	string_list_clear(&filter_options->filter_spec, /*free_util=*/0);
 	free(filter_options->sparse_oid_name);
+	free(filter_options->extension_name);
+	free(filter_options->extension_value);
 	for (sub = 0; sub < filter_options->sub_nr; sub++)
 		list_objects_filter_release(&filter_options->sub[sub]);
 	free(filter_options->sub);
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index da5b6737e27..df3e360324e 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -15,6 +15,7 @@ enum list_objects_filter_choice {
 	LOFC_TREE_DEPTH,
 	LOFC_SPARSE_OID,
 	LOFC_OBJECT_TYPE,
+	LOFC_EXTENSION,
 	LOFC_COMBINE,
 	LOFC__COUNT /* must be last */
 };
@@ -58,6 +59,11 @@ struct list_objects_filter_options {
 	unsigned long tree_exclude_depth;
 	enum object_type object_type;
 
+	/* LOFC_EXTENSION values */
+
+	char *extension_name;
+	char *extension_value;
+
 	/* LOFC_COMBINE values */
 
 	/* This array contains all the subfilters which this filter combines. */
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 1c1ee3d1bb1..037c674b1c3 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -10,6 +10,7 @@
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
+#include "list-objects-filter-extensions.h"
 #include "oidmap.h"
 #include "oidset.h"
 #include "object-store.h"
@@ -620,6 +621,88 @@ static void filter_object_type__init(
 	filter->free_fn = free;
 }
 
+/*
+ * A filter which passes the objects to a compile-time extension.
+ * The extension needs to implement the filter_extension interface
+ * defined in list-objects-filter-extension.h.
+ * See contrib/filter-extensions/README.md
+ */
+
+struct filter_extension_data {
+	const struct filter_extension *extension;
+	void *context;
+};
+
+static enum list_objects_filter_result filter_extension_filter_object(
+	struct repository *r,
+	enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	struct oidset *omits,
+	void *filter_data)
+{
+	struct filter_extension_data *d = filter_data;
+
+	enum list_objects_filter_omit omit_it = LOFO_IGNORE;
+
+	enum list_objects_filter_result ret =
+		d->extension->filter_object_fn(
+			r,
+			filter_situation,
+			obj,
+			pathname,
+			filename,
+			&omit_it,
+			d->context);
+
+	if (omits) {
+		if (omit_it == LOFO_KEEP)
+			oidset_remove(omits, &obj->oid);
+		else if (omit_it == LOFO_OMIT)
+			oidset_insert(omits, &obj->oid);
+	}
+	return ret;
+}
+
+static void filter_extension_free(void *filter_data)
+{
+	struct filter_extension_data *d = filter_data;
+	d->extension->free_fn(the_repository, d->context);
+	free(d);
+}
+
+static void filter_extension__init(
+	struct list_objects_filter_options *filter_options,
+	struct filter *filter)
+{
+	struct filter_extension_data *d = xcalloc(1, sizeof(*d));
+	int i, r;
+
+	for (i = 0; filter_extensions[i] != NULL; i++) {
+		if (!strcmp(
+			filter_options->extension_name,
+			filter_extensions[i]->name))
+			break;
+	}
+	if (filter_extensions[i] == NULL) {
+		die(_("No filter extension found with name %s"),
+			filter_options->extension_name);
+	}
+	d->extension = filter_extensions[i];
+
+	r = d->extension->init_fn(
+		the_repository, filter_options->extension_value, &d->context);
+	if (r) {
+		die(_("Error initialising filter extension %s: %d"),
+			filter_options->extension_name, r);
+	}
+
+	filter->filter_data = d;
+	filter->filter_object_fn = &filter_extension_filter_object;
+	filter->free_fn = &filter_extension_free;
+}
+
 /* A filter which only shows objects shown by all sub-filters. */
 struct combine_filter_data {
 	struct subfilter *sub;
@@ -767,6 +850,7 @@ static filter_init_fn s_filters[] = {
 	filter_trees_depth__init,
 	filter_sparse_oid__init,
 	filter_object_type__init,
+	filter_extension__init,
 	filter_combine__init,
 };
 
-- 
gitgitgadget

