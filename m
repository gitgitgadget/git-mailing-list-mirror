Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601151F437
	for <e@80x24.org>; Sat, 28 Jan 2017 02:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbdA1CDK (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:03:10 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34596 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdA1CCy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:54 -0500
Received: by mail-pg0-f44.google.com with SMTP id 14so85553832pgg.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kdU/5wGrLQtZAGhgfVnPwqBxt4UuECqDOkDzVAC4Who=;
        b=Eoak9CCetLVtN0Mapv5Wf6XNUpmaux9PvZVHwxGtxi+kNBOM2xsqQMYpwXT0EGs7KG
         04Tl5dX0aDX9okeKcLLuF8K1H6SbqXmQuHKrqbG+BSHNRTuxmaRVqZjLwwHi+6AV9X10
         I68tcR2AfsKYL4V+pc3/+GkgnoaUVMHIGfTMfWG/Lg01tVZA8BEg/imOzsTJPWIErYs+
         2RV8ByzOvX//iHml8rrKdaKc8cCYMe6kncCCHZWo2MP1I80DQcUfdZ+ad64D24qhoAGN
         FsCVdo9gBSrijyKobMAJ8l2mX2l/TFnteuMWNIxgZRgEHuZjaGk5G85wdh5DVZmWSuHx
         M4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kdU/5wGrLQtZAGhgfVnPwqBxt4UuECqDOkDzVAC4Who=;
        b=p/FVrBCqwD999pxhaPWn4L2OOW4Q3Vc1Soi5Xf4jTe4lYdgg5UvpGTDuq4V1IAci15
         NL0Ot3vnFJDWuRKYGKDt15M2hBBytP5UbVJFh244pTN5Y4w0ZVKd203gSAf8LVjbJkz7
         erDm3fJ3qEEj2wRaP/oA1R9vrhG8PB8PC4+qHBm83k+F5C8oU/2yjItYdeqMSJp9hm3s
         Gj8tPfN5xasGUrWRvaUHJCowwKowKLWvyJWixUJ5BvflXMYcbdQW9R5qX7VV5kAq3Bj8
         cn7s8mQdMRXhtXqVWKdLl8vgPZ9ngw227U2OhKcb0fu6sII2DSvt516Awzu+pfS7e+jP
         9uUw==
X-Gm-Message-State: AIkVDXIux3UWsgghEsR1/Y1faRX5nbXnbLb3ihu6bp29ADfsTyUjBbqqDvDjVo0pORmAO8Jm
X-Received: by 10.84.142.101 with SMTP id 92mr16362825plw.66.1485568973099;
        Fri, 27 Jan 2017 18:02:53 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:52 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 16/27] attr: convert git_all_attrs() to use "struct attr_check"
Date:   Fri, 27 Jan 2017 18:01:56 -0800
Message-Id: <20170128020207.179015-17-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

This updates the other two ways the attribute check is done via an
array of "struct attr_check_item" elements.  These two niches
appear only in "git check-attr".

 * The caller does not know offhand what attributes it wants to ask
   about and cannot use attr_check_initl() to prepare the
   attr_check structure.

 * The caller may not know what attributes it wants to ask at all,
   and instead wants to learn everything that the given path has.

Such a caller can call attr_check_alloc() to allocate an empty
attr_check, and then call attr_check_append() to add attribute names
one by one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c               | 168 ++++++++++++++++++++++++---------------------------
 attr.h               |   9 +--
 builtin/check-attr.c |  60 +++++++++---------
 3 files changed, 112 insertions(+), 125 deletions(-)

diff --git a/attr.c b/attr.c
index de8bf35a3..40818246f 100644
--- a/attr.c
+++ b/attr.c
@@ -132,75 +132,6 @@ struct git_attr *git_attr(const char *name)
 	return git_attr_internal(name, strlen(name));
 }
 
-struct attr_check *attr_check_alloc(void)
-{
-	return xcalloc(1, sizeof(struct attr_check));
-}
-
-struct attr_check *attr_check_initl(const char *one, ...)
-{
-	struct attr_check *check;
-	int cnt;
-	va_list params;
-	const char *param;
-
-	va_start(params, one);
-	for (cnt = 1; (param = va_arg(params, const char *)) != NULL; cnt++)
-		;
-	va_end(params);
-
-	check = attr_check_alloc();
-	check->nr = cnt;
-	check->alloc = cnt;
-	check->items = xcalloc(cnt, sizeof(struct attr_check_item));
-
-	check->items[0].attr = git_attr(one);
-	va_start(params, one);
-	for (cnt = 1; cnt < check->nr; cnt++) {
-		const struct git_attr *attr;
-		param = va_arg(params, const char *);
-		if (!param)
-			die("BUG: counted %d != ended at %d",
-			    check->nr, cnt);
-		attr = git_attr(param);
-		if (!attr)
-			die("BUG: %s: not a valid attribute name", param);
-		check->items[cnt].attr = attr;
-	}
-	va_end(params);
-	return check;
-}
-
-struct attr_check_item *attr_check_append(struct attr_check *check,
-					  const struct git_attr *attr)
-{
-	struct attr_check_item *item;
-
-	ALLOC_GROW(check->items, check->nr + 1, check->alloc);
-	item = &check->items[check->nr++];
-	item->attr = attr;
-	return item;
-}
-
-void attr_check_reset(struct attr_check *check)
-{
-	check->nr = 0;
-}
-
-void attr_check_clear(struct attr_check *check)
-{
-	free(check->items);
-	check->items = NULL;
-	check->alloc = 0;
-	check->nr = 0;
-}
-
-void attr_check_free(struct attr_check *check)
-{
-	attr_check_clear(check);
-	free(check);
-}
-
 /* What does a matched pattern decide? */
 struct attr_state {
 	struct git_attr *attr;
@@ -439,6 +370,75 @@ static void free_attr_elem(struct attr_stack *e)
 	free(e);
 }
 
+struct attr_check *attr_check_alloc(void)
+{
+	return xcalloc(1, sizeof(struct attr_check));
+}
+
+struct attr_check *attr_check_initl(const char *one, ...)
+{
+	struct attr_check *check;
+	int cnt;
+	va_list params;
+	const char *param;
+
+	va_start(params, one);
+	for (cnt = 1; (param = va_arg(params, const char *)) != NULL; cnt++)
+		;
+	va_end(params);
+
+	check = attr_check_alloc();
+	check->nr = cnt;
+	check->alloc = cnt;
+	check->items = xcalloc(cnt, sizeof(struct attr_check_item));
+
+	check->items[0].attr = git_attr(one);
+	va_start(params, one);
+	for (cnt = 1; cnt < check->nr; cnt++) {
+		const struct git_attr *attr;
+		param = va_arg(params, const char *);
+		if (!param)
+			die("BUG: counted %d != ended at %d",
+			    check->nr, cnt);
+		attr = git_attr(param);
+		if (!attr)
+			die("BUG: %s: not a valid attribute name", param);
+		check->items[cnt].attr = attr;
+	}
+	va_end(params);
+	return check;
+}
+
+struct attr_check_item *attr_check_append(struct attr_check *check,
+					  const struct git_attr *attr)
+{
+	struct attr_check_item *item;
+
+	ALLOC_GROW(check->items, check->nr + 1, check->alloc);
+	item = &check->items[check->nr++];
+	item->attr = attr;
+	return item;
+}
+
+void attr_check_reset(struct attr_check *check)
+{
+	check->nr = 0;
+}
+
+void attr_check_clear(struct attr_check *check)
+{
+	free(check->items);
+	check->items = NULL;
+	check->alloc = 0;
+	check->nr = 0;
+}
+
+void attr_check_free(struct attr_check *check)
+{
+	attr_check_clear(check);
+	free(check);
+}
+
 static const char *builtin_attr[] = {
 	"[attr]binary -diff -merge -text",
 	NULL,
@@ -906,32 +906,22 @@ int git_check_attrs(const char *path, int num, struct attr_check_item *check)
 	return 0;
 }
 
-int git_all_attrs(const char *path, int *num, struct attr_check_item **check)
+void git_all_attrs(const char *path, struct attr_check *check)
 {
-	int i, count, j;
+	int i;
 
-	collect_some_attrs(path, 0, NULL);
+	attr_check_reset(check);
+	collect_some_attrs(path, check->nr, check->items);
 
-	/* Count the number of attributes that are set. */
-	count = 0;
-	for (i = 0; i < attr_nr; i++) {
-		const char *value = check_all_attr[i].value;
-		if (value != ATTR__UNSET && value != ATTR__UNKNOWN)
-			++count;
-	}
-	*num = count;
-	ALLOC_ARRAY(*check, count);
-	j = 0;
 	for (i = 0; i < attr_nr; i++) {
+		const char *name = check_all_attr[i].attr->name;
 		const char *value = check_all_attr[i].value;
-		if (value != ATTR__UNSET && value != ATTR__UNKNOWN) {
-			(*check)[j].attr = check_all_attr[i].attr;
-			(*check)[j].value = value;
-			++j;
-		}
+		struct attr_check_item *item;
+		if (value == ATTR__UNSET || value == ATTR__UNKNOWN)
+			continue;
+		item = attr_check_append(check, git_attr(name));
+		item->value = value;
 	}
-
-	return 0;
 }
 
 int git_check_attr(const char *path, struct attr_check *check)
diff --git a/attr.h b/attr.h
index e611b139a..9f2729842 100644
--- a/attr.h
+++ b/attr.h
@@ -56,13 +56,10 @@ int git_check_attrs(const char *path, int, struct attr_check_item *);
 extern int git_check_attr(const char *path, struct attr_check *check);
 
 /*
- * Retrieve all attributes that apply to the specified path.  *num
- * will be set to the number of attributes on the path; **check will
- * be set to point at a newly-allocated array of git_attr_check
- * objects describing the attributes and their values.  *check must be
- * free()ed by the caller.
+ * Retrieve all attributes that apply to the specified path.
+ * check holds the attributes and their values.
  */
-int git_all_attrs(const char *path, int *num, struct attr_check_item **check);
+extern void git_all_attrs(const char *path, struct attr_check *check);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 889264a5b..40cdff13e 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -24,12 +24,13 @@ static const struct option check_attr_options[] = {
 	OPT_END()
 };
 
-static void output_attr(int cnt, struct attr_check_item *check,
-			const char *file)
+static void output_attr(struct attr_check *check, const char *file)
 {
 	int j;
+	int cnt = check->nr;
+
 	for (j = 0; j < cnt; j++) {
-		const char *value = check[j].value;
+		const char *value = check->items[j].value;
 
 		if (ATTR_TRUE(value))
 			value = "set";
@@ -42,36 +43,38 @@ static void output_attr(int cnt, struct attr_check_item *check,
 			printf("%s%c" /* path */
 			       "%s%c" /* attrname */
 			       "%s%c" /* attrvalue */,
-			       file, 0, git_attr_name(check[j].attr), 0, value, 0);
+			       file, 0,
+			       git_attr_name(check->items[j].attr), 0, value, 0);
 		} else {
 			quote_c_style(file, NULL, stdout, 0);
-			printf(": %s: %s\n", git_attr_name(check[j].attr), value);
+			printf(": %s: %s\n",
+			       git_attr_name(check->items[j].attr), value);
 		}
-
 	}
 }
 
 static void check_attr(const char *prefix,
-		       int cnt, struct attr_check_item *check,
+		       struct attr_check *check,
+		       int collect_all,
 		       const char *file)
 {
 	char *full_path =
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
-	if (check != NULL) {
-		if (git_check_attrs(full_path, cnt, check))
-			die("git_check_attrs died");
-		output_attr(cnt, check, file);
+
+	if (collect_all) {
+		git_all_attrs(full_path, check);
 	} else {
-		if (git_all_attrs(full_path, &cnt, &check))
-			die("git_all_attrs died");
-		output_attr(cnt, check, file);
-		free(check);
+		if (git_check_attr(full_path, check))
+			die("git_check_attr died");
 	}
+	output_attr(check, file);
+
 	free(full_path);
 }
 
 static void check_attr_stdin_paths(const char *prefix,
-				   int cnt, struct attr_check_item *check)
+				   struct attr_check *check,
+				   int collect_all)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
@@ -85,7 +88,7 @@ static void check_attr_stdin_paths(const char *prefix,
 				die("line is badly quoted");
 			strbuf_swap(&buf, &unquoted);
 		}
-		check_attr(prefix, cnt, check, buf.buf);
+		check_attr(prefix, check, collect_all, buf.buf);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 	strbuf_release(&buf);
@@ -100,7 +103,7 @@ static NORETURN void error_with_usage(const char *msg)
 
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
-	struct attr_check_item *check;
+	struct attr_check *check;
 	int cnt, i, doubledash, filei;
 
 	if (!is_bare_repository())
@@ -160,28 +163,25 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 			error_with_usage("No file specified");
 	}
 
-	if (all_attrs) {
-		check = NULL;
-	} else {
-		check = xcalloc(cnt, sizeof(*check));
+	check = attr_check_alloc();
+	if (!all_attrs) {
 		for (i = 0; i < cnt; i++) {
-			const char *name;
-			struct git_attr *a;
-			name = argv[i];
-			a = git_attr(name);
+			struct git_attr *a = git_attr(argv[i]);
 			if (!a)
 				return error("%s: not a valid attribute name",
-					name);
-			check[i].attr = a;
+					     argv[i]);
+			attr_check_append(check, a);
 		}
 	}
 
 	if (stdin_paths)
-		check_attr_stdin_paths(prefix, cnt, check);
+		check_attr_stdin_paths(prefix, check, all_attrs);
 	else {
 		for (i = filei; i < argc; i++)
-			check_attr(prefix, cnt, check, argv[i]);
+			check_attr(prefix, check, all_attrs, argv[i]);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
+
+	attr_check_free(check);
 	return 0;
 }
-- 
2.11.0.483.g087da7b7c-goog

