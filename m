Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB2C220A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbdAWUgG (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:36:06 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36555 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbdAWUgC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:36:02 -0500
Received: by mail-pg0-f47.google.com with SMTP id t6so47713108pgt.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YxpPMgbZkB6JvZTasNO75ChAoElo6k5CzhZ6E5+2U9k=;
        b=n8rEw17Ucq07KM06fIIlk6K/twz7OEPV7giLJpC++x4XSKAUofQpvovSSS7SrrIWXe
         oz1owZg5Nxt+IwYzmrnWEWbhIlK+8WTBArqyZiQrqsONnpbXJtse6G6FUhy9HrVsAgDS
         cNIUKmOaeLhJ1UMZG5+FF7IChporS9+A43yvbPLcMSjmdrJjqZY9gtmANH2DjFovPeO4
         JMj0u5p8Kkvt7goILdC6OCSemhbrTNBH9gs7Rh1lpd2/44pPcGWKRaIWN1QG6CDDNVt/
         18fPMVCR7RPH+WYu1akUTNJjOk9GEHpnbPeM2SC03IuJP9cTopkyTkBxhWx8TGigeAyI
         kBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YxpPMgbZkB6JvZTasNO75ChAoElo6k5CzhZ6E5+2U9k=;
        b=JoBvILOiSMMzaayUw7CsNgCiFOWAmg5z4eBpLWz3f5GHebRNqLy9YVMk0U2TKNZ5Nk
         9sHeNZLpS+jCquiPCWee9wPpFdeEd+Saes3Ya2PYpZDUYUS1vrnzit9LMfyV5ctpAbbK
         w+/kZjE//DxshG4zPsoAaOX8/3hqusHR2kSEiVQ33twIGv20Fccn/EyI4X1hlr2ZsyYj
         sVT5YRqnlK4ofmA18Jmdh9YSxvTySQm72AlfJHzS36IymiBn3t8hOQGJTX0EQ50aFb9L
         syhU4LH6llVj8J1nMJAO2FYqFP7L9NRY56QxXXAkoorxfggaANFjRGidBa0m/IZXtCLb
         7uQA==
X-Gm-Message-State: AIkVDXIte19zF5vrCvjJwR1WpMmsN1zdcLaVF2o/yB1YAZ+CZcHU+AiZTtMDQsYk037EndvQ
X-Received: by 10.99.53.195 with SMTP id c186mr34583681pga.24.1485203761236;
        Mon, 23 Jan 2017 12:36:01 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:36:00 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 16/27] attr: convert git_all_attrs() to use "struct attr_check"
Date:   Mon, 23 Jan 2017 12:35:14 -0800
Message-Id: <20170123203525.185058-17-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
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
 attr.c               | 38 ++++++++++++---------------------
 attr.h               |  9 +++-----
 builtin/check-attr.c | 60 ++++++++++++++++++++++++++--------------------------
 3 files changed, 47 insertions(+), 60 deletions(-)

diff --git a/attr.c b/attr.c
index be9e398e9..d2eaa0410 100644
--- a/attr.c
+++ b/attr.c
@@ -837,42 +837,32 @@ int git_check_attrs(const char *path, int num, struct attr_check_item *check)
 	return 0;
 }
 
-int git_all_attrs(const char *path, int *num, struct attr_check_item **check)
+void git_all_attrs(const char *path, struct attr_check *check)
 {
-	int i, count, j;
+	int i;
 
-	collect_some_attrs(path, 0, NULL);
+	attr_check_reset(check);
+	collect_some_attrs(path, check->check_nr, check->check);
 
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
 
-struct attr_check *attr_check_alloc(void)
+int git_check_attr(const char *path, struct attr_check *check)
 {
-	return xcalloc(1, sizeof(struct attr_check));
+	return git_check_attrs(path, check->check_nr, check->check);
 }
 
-int git_check_attr(const char *path, struct attr_check *check)
+struct attr_check *attr_check_alloc(void)
 {
-	return git_check_attrs(path, check->check_nr, check->check);
+	return xcalloc(1, sizeof(struct attr_check));
 }
 
 struct attr_check *attr_check_initl(const char *one, ...)
diff --git a/attr.h b/attr.h
index 459347f4b..971bb9a38 100644
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
+void git_all_attrs(const char *path, struct attr_check *check);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 889264a5b..3d4704be5 100644
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
+	int cnt = check->check_nr;
+
 	for (j = 0; j < cnt; j++) {
-		const char *value = check[j].value;
+		const char *value = check->check[j].value;
 
 		if (ATTR_TRUE(value))
 			value = "set";
@@ -42,36 +43,38 @@ static void output_attr(int cnt, struct attr_check_item *check,
 			printf("%s%c" /* path */
 			       "%s%c" /* attrname */
 			       "%s%c" /* attrvalue */,
-			       file, 0, git_attr_name(check[j].attr), 0, value, 0);
+			       file, 0,
+			       git_attr_name(check->check[j].attr), 0, value, 0);
 		} else {
 			quote_c_style(file, NULL, stdout, 0);
-			printf(": %s: %s\n", git_attr_name(check[j].attr), value);
+			printf(": %s: %s\n",
+			       git_attr_name(check->check[j].attr), value);
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

