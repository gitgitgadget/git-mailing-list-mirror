Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C15C433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbiCJN6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242605AbiCJN6R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:58:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A36F14E976
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:15 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id x15so8047403wru.13
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BruHHzvqYJfbKEeBZjzxdi06DKTnvSoOL5hUMm4Cglw=;
        b=Rur8soX/SkUIGefcCHzxjhRWILOOfmgasV5dJTh1CJUepy3N2xVz62cjwXn1PUUx7j
         99nPxChB4fELXOGUqauWHG1TyyZGYIBb5Vo+OLlZr6PCf6JsxuGyGW3KfYj6n632C4Jy
         +Qv4WTf7wJtnZw6G2Yr6KXiTiInS6Io39YPDosx4+Ag3IQwdIvYlp6wHo8zO+/j3tB5W
         ZPvfwxNRg69N89F5YMplpDk3ItncZJ9Hy45jLYaQ7XtNQVQt4a4TARNdgGAHZKXLgCbc
         wUFQMKh5dXaDh/2ahkVXWTNobivOKFwR/gJqsLmZpdiRkOdUtpL1bc5pkaNK7UXqs/B4
         hkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BruHHzvqYJfbKEeBZjzxdi06DKTnvSoOL5hUMm4Cglw=;
        b=5cd+KQfB/QTnEuPOMp+8nlA/krK/cHIGayt47ODsD4CQwK2UY9nnyV9a3RV3R1xRS/
         gEQIaIcoG3t+hnuRD5azNnwhxvfFO8eYTXtgealiU0HmtT6KhLzNEEDqC8kBept2SgnD
         i/amo/6Hg5DIi4sCBQJCgD9F37XLBVaycCzu3PNHZYE4cqj/0OyQoezoOZPHxSSxKETx
         vUJHGW8kerlBNvKOOIUUY5PFndo4N311nfIdMhKBP9YeBxYVACqche7Au4IIumllKspB
         0uDoWtcyORajUoXJt0t3+glMizLKFpc0osveZDHBC7pf5NyYGSzl3sqZg6POus5wUVzq
         qUoQ==
X-Gm-Message-State: AOAM530zfgz7VnLDjPwAtuf1n5yRrjjHQTmB1wAKsvPe3MLcDGmFH3tv
        8VFGaDOjawj3ontnu6I5LqlPH4ENptIKQg==
X-Google-Smtp-Source: ABdhPJz8+ogSKJ3k7vYrt+olyGjps2EIy0TmCxdLlwTFjlk40K3Tv0puD2uqWK8mXTY2u9ZqZxYVuw==
X-Received: by 2002:a5d:64c1:0:b0:203:7aa5:9390 with SMTP id f1-20020a5d64c1000000b002037aa59390mr3726339wri.328.1646920633574;
        Thu, 10 Mar 2022 05:57:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm7737162wmc.22.2022.03.10.05.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:57:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>, Johannes.Schindelin@gmx.de,
        congdanhqx@gmail.com, tenglong.tl@alibaba-inc.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/REVIEW 6/7] ls-tree: remove FIELD_*, just use MODE_*
Date:   Thu, 10 Mar 2022 14:57:02 +0100
Message-Id: <patch-6.7-619a77c1b08-20220310T134811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com> <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're picking where we should go in the optimized "show_tree"
path there's no reason for why we need to convert our "cmdmode" of
e.g. MODE_LONG into a FIELD_LONG_DEFAULT. Instead we can simply do
those checks in the show_tree() function itself.

Let's also make this code more future-proof by unrolling the hardcoded
strmp() if/else if chain into something that checks a new "static
struct" providing a bidirectional mapping between optimized formats
and the ls_tree_cmdmode.

A preceding commit removed "MODE_UNSPECIFIED", now there is a use for
such a thing, as we'll need to add this to our mapping so we'll choose
the "show_tree" fast-path here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 98 ++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 52 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 528b4e5b5f6..820baddf9a9 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -23,25 +23,13 @@ static int ls_options;
 static struct pathspec pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
-#define FIELD_PATH_NAME 1
-#define FIELD_SIZE (1 << 1)
-#define FIELD_OBJECT_NAME (1 << 2)
-#define FIELD_TYPE (1 << 3)
-#define FIELD_MODE (1 << 4)
-#define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default */
-#define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)
 static const char *format;
-static const char *default_format = "%(objectmode) %(objecttype) %(objectname)%x09%(path)";
-static const char *long_format = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)";
-static const char *name_only_format = "%(path)";
-static const char *object_only_format = "%(objectname)";
 struct show_tree_data {
 	unsigned mode;
 	enum object_type type;
 	const struct object_id *oid;
 	const char *pathname;
 	struct strbuf *base;
-	unsigned int shown_fields;
 };
 
 static const  char * const ls_tree_usage[] = {
@@ -50,7 +38,8 @@ static const  char * const ls_tree_usage[] = {
 };
 
 static enum ls_tree_cmdmode {
-	MODE_LONG = 1,
+	MODE_DEFAULT = 0,
+	MODE_LONG,
 	MODE_NAME_ONLY,
 	MODE_NAME_STATUS,
 	MODE_OBJECT_ONLY,
@@ -122,25 +111,6 @@ static size_t expand_show_tree(struct strbuf *sb, const char *start,
 	return len;
 }
 
-static int parse_shown_fields(unsigned int *shown_fields)
-{
-	if (cmdmode == MODE_NAME_ONLY) {
-		*shown_fields = FIELD_PATH_NAME;
-		return 0;
-	}
-	if (cmdmode == MODE_OBJECT_ONLY) {
-		*shown_fields = FIELD_OBJECT_NAME;
-		return 0;
-	}
-	if (!ls_options || (ls_options & LS_RECURSIVE)
-	    || (ls_options & LS_SHOW_TREES)
-	    || (ls_options & LS_TREE_ONLY))
-		*shown_fields = FIELD_DEFAULT;
-	if (cmdmode == MODE_LONG)
-		*shown_fields = FIELD_LONG_DEFAULT;
-	return 1;
-}
-
 static int show_recursive(const char *base, size_t baselen, const char *pathname)
 {
 	int i;
@@ -207,7 +177,7 @@ static int show_default(struct show_tree_data *data)
 {
 	size_t baselen = data->base->len;
 
-	if (data->shown_fields & FIELD_SIZE) {
+	if (cmdmode == MODE_LONG) {
 		char size_text[24];
 		if (data->type == OBJ_BLOB) {
 			unsigned long size;
@@ -240,14 +210,12 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	int recurse = 0;
 	size_t baselen;
 	enum object_type type = object_type(mode);
-	unsigned int shown_fields = *(unsigned int *)context;
 	struct show_tree_data data = {
 		.mode = mode,
 		.type = type,
 		.oid = oid,
 		.pathname = pathname,
 		.base = base,
-		.shown_fields = shown_fields,
 	};
 
 	if (type == OBJ_BLOB) {
@@ -260,12 +228,12 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 			return recurse;
 	}
 
-	if (shown_fields == FIELD_OBJECT_NAME) {
+	if (cmdmode == MODE_OBJECT_ONLY) {
 		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
 		return recurse;
 	}
 
-	if (shown_fields == FIELD_PATH_NAME) {
+	if (cmdmode == MODE_NAME_ONLY) {
 		baselen = base->len;
 		strbuf_addstr(base, pathname);
 		write_name_quoted_relative(base->buf,
@@ -275,12 +243,40 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		return recurse;
 	}
 
-	if (shown_fields>= FIELD_DEFAULT)
+	if (cmdmode == MODE_LONG ||
+	    (!ls_options || (ls_options & LS_RECURSIVE)
+	     || (ls_options & LS_SHOW_TREES)
+	     || (ls_options & LS_TREE_ONLY)))
 		show_default(&data);
 
 	return recurse;
 }
 
+struct ls_tree_cmdmode_to_fmt {
+	enum ls_tree_cmdmode mode;
+	const char *const fmt;
+};
+
+static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[] = {
+	{
+		.mode = MODE_DEFAULT,
+		.fmt = "%(objectmode) %(objecttype) %(objectname)%x09%(path)",
+	},
+	{
+		.mode = MODE_LONG,
+		.fmt = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)",
+	},
+	{
+		.mode = MODE_NAME_ONLY, /* And MODE_NAME_STATUS */
+		.fmt = "%(path)",
+	},
+	{
+		.mode = MODE_OBJECT_ONLY,
+		.fmt = "%(objectname)",
+	},
+	{ 0 },
+};
+
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 {
 	struct object_id oid;
@@ -367,25 +363,23 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	if (!tree)
 		die("not a tree object");
 
-	parse_shown_fields(&shown_fields);
-
 	/*
 	 * The generic show_tree_fmt() is slower than show_tree(), so
 	 * take the fast path if possible.
 	 */
-	if (format && (!strcmp(format, default_format))) {
-		fn = show_tree;
-	} else if (format && (!strcmp(format, long_format))) {
-		shown_fields = shown_fields | FIELD_SIZE;
-		fn = show_tree;
-	} else if (format && (!strcmp(format, name_only_format))) {
-		shown_fields = FIELD_PATH_NAME;
-		fn = show_tree;
-	} else if (format && (!strcmp(format, object_only_format))) {
-		shown_fields = FIELD_OBJECT_NAME;
-		fn = show_tree;
-	} else if (format)
+	if (format) {
+		struct ls_tree_cmdmode_to_fmt *m2f;
+
 		fn = show_tree_fmt;
+		for (m2f = ls_tree_cmdmode_format; m2f->fmt; m2f++) {
+			if (strcmp(format, m2f->fmt))
+				continue;
+
+			cmdmode = m2f->mode;
+			fn = show_tree;
+			break;
+		}
+	}
 
 	return !!read_tree(the_repository, tree, &pathspec, fn, &shown_fields);
 }
-- 
2.35.1.1295.g6b025d3e231

