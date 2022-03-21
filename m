Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC61C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbiCUHfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344935AbiCUHf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9C55A08B
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:02 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so9673781pjb.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=swDp9j7imjeO4rLpZc4qlEHF1d+pYwuCo05VsVEGN+g=;
        b=PzMzqOEJnIujwxJcPbKTJRxSULJ39zOkIOeOc67UY7Q7Np3qODuWq847BQPvcVE3TO
         azGibveLDcedvN324x5gyU7SnyqrBcEV0bsEQTsqK9fkmyQyeXzBuPXNaxvrLuBFVQzd
         5HDYho/XMn15PwKp7av/iQhyniLFXT3/jmxCIC4XAy2yfWBTyolqQeTSus33waitvOlc
         7Gn02+Hh8/7MfQMRbTDaY7xh0xnr7sVWa0jpSiG+bxp0Ic4X8vCUCDYV2QBu8hhT8DcK
         QZuH9n303CQqzfPlbsI3uDw8ORQiaw7LBl26BQNabpIkpXfhrqayRYFfFj6b2f5P1SPu
         jbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=swDp9j7imjeO4rLpZc4qlEHF1d+pYwuCo05VsVEGN+g=;
        b=5gT1qhPRFg2/fP4RMUIXk5guu9dPdwAB8QVQv0bGLthT4GB7FRRwJiTE301uQKZDuc
         uS/XHaDHub9wrFxcC4Oyr8Dp1W2XJDRO0gfKcF8PLA1HRMcEcLJx6BJyA9fPUkvs11ME
         4tIjsY+6ks7M7C+/0KZCkwAJca8ZsMG0X+OvQVOqhIRmb5PXwS48BbAiuBbjqpxk2bM0
         5l6NQGgnax99ew5shtXuoKOYHtnia0OOrdnX3MJWN7BbQLjuG+0EcaSqWVTPPkPqGSLE
         Xj5QTMa7fT64ZPDiGZcPu+Yd0rodZgRTDvelorn9KG0vjMpfKlr2OxQmQcWgsT024M0o
         L4cg==
X-Gm-Message-State: AOAM5327lLl7Q4luZPyqf/sJ428BOGomTRE83U+eyA9/zAvf1QvdNXWT
        sdD3FnuCIhCS53NL5c7ZpeI=
X-Google-Smtp-Source: ABdhPJxaqR6/PWqxocK06hHbhbzWuUrD4P3gxdRWhrb4xhoMH+PrekL8kUwWKdKxz3ZeHgkC11yRDA==
X-Received: by 2002:a17:90a:7ac2:b0:1bf:3573:179b with SMTP id b2-20020a17090a7ac200b001bf3573179bmr24158294pjl.216.1647848041699;
        Mon, 21 Mar 2022 00:34:01 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.33.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:34:01 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v13 08/16] ls-tree: slightly refactor `show_tree()`
Date:   Mon, 21 Mar 2022 15:33:22 +0800
Message-Id: <55f1e10d7e38d85f15565845c8d29ed733da9f45.1647846935.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.406.g2e0e55130e
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com>
References: <cover.1647846935.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a non-functional change, we use a new int "shown_fields" to mark
which columns to output, and `parse_shown_fields()` to calculate the
value of "shown_fields".

This has the advantage of making the show_tree logic simpler and more
readable, as well as making it easier to extend new options (for example,
if we want to add a "--object-only" option, we just need to add a similar
"if (shown_fields == FIELD_OBJECT_NAME)" short-circuit logic in
"show_tree()").

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 121 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 37 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 7be4c13228..4364416e1c 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -16,21 +16,48 @@
 
 static int line_termination = '\n';
 #define LS_RECURSIVE 1
-#define LS_TREE_ONLY 2
-#define LS_SHOW_TREES 4
-#define LS_NAME_ONLY 8
-#define LS_SHOW_SIZE 16
+#define LS_TREE_ONLY (1 << 1)
+#define LS_SHOW_TREES (1 << 2)
 static int abbrev;
 static int ls_options;
 static struct pathspec pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
+static unsigned int shown_fields;
+#define FIELD_PATH_NAME 1
+#define FIELD_SIZE (1 << 1)
+#define FIELD_OBJECT_NAME (1 << 2)
+#define FIELD_TYPE (1 << 3)
+#define FIELD_MODE (1 << 4)
+#define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default */
+#define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)
 
 static const  char * const ls_tree_usage[] = {
 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
 	NULL
 };
 
+static enum ls_tree_cmdmode {
+	MODE_LONG = 1,
+	MODE_NAME_ONLY,
+} cmdmode;
+
+static int parse_shown_fields(void)
+{
+	if (cmdmode == MODE_NAME_ONLY) {
+		shown_fields = FIELD_PATH_NAME;
+		return 0;
+	}
+
+	if (!ls_options || (ls_options & LS_RECURSIVE)
+	    || (ls_options & LS_SHOW_TREES)
+	    || (ls_options & LS_TREE_ONLY))
+		shown_fields = FIELD_DEFAULT;
+	if (cmdmode == MODE_LONG)
+		shown_fields = FIELD_LONG_DEFAULT;
+	return 1;
+}
+
 static int show_recursive(const char *base, size_t baselen, const char *pathname)
 {
 	int i;
@@ -61,6 +88,39 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 	return 0;
 }
 
+static int show_default(const struct object_id *oid, enum object_type type,
+			const char *pathname, unsigned mode,
+			struct strbuf *base)
+{
+	size_t baselen = base->len;
+
+	if (shown_fields & FIELD_SIZE) {
+		char size_text[24];
+		if (type == OBJ_BLOB) {
+			unsigned long size;
+			if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
+				xsnprintf(size_text, sizeof(size_text), "BAD");
+			else
+				xsnprintf(size_text, sizeof(size_text),
+					  "%" PRIuMAX, (uintmax_t)size);
+		} else {
+			xsnprintf(size_text, sizeof(size_text), "-");
+		}
+		printf("%06o %s %s %7s\t", mode, type_name(type),
+		find_unique_abbrev(oid, abbrev), size_text);
+	} else {
+		printf("%06o %s %s\t", mode, type_name(type),
+		find_unique_abbrev(oid, abbrev));
+	}
+	baselen = base->len;
+	strbuf_addstr(base, pathname);
+	write_name_quoted_relative(base->buf,
+				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
+				   line_termination);
+	strbuf_setlen(base, baselen);
+	return 1;
+}
+
 static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
@@ -78,34 +138,19 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 			return recurse;
 	}
 
-	if (!(ls_options & LS_NAME_ONLY)) {
-		if (ls_options & LS_SHOW_SIZE) {
-			char size_text[24];
-			if (type == OBJ_BLOB) {
-				unsigned long size;
-				if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
-					xsnprintf(size_text, sizeof(size_text),
-						  "BAD");
-				else
-					xsnprintf(size_text, sizeof(size_text),
-						  "%"PRIuMAX, (uintmax_t)size);
-			} else {
-				xsnprintf(size_text, sizeof(size_text), "-");
-			}
-			printf("%06o %s %s %7s\t", mode, type_name(type),
-			       find_unique_abbrev(oid, abbrev),
-			       size_text);
-		} else {
-			printf("%06o %s %s\t", mode, type_name(type),
-			       find_unique_abbrev(oid, abbrev));
-		}
+	if (shown_fields == FIELD_PATH_NAME) {
+		baselen = base->len;
+		strbuf_addstr(base, pathname);
+		write_name_quoted_relative(base->buf,
+					   chomp_prefix ? ls_tree_prefix : NULL,
+					   stdout, line_termination);
+		strbuf_setlen(base, baselen);
+		return recurse;
 	}
-	baselen = base->len;
-	strbuf_addstr(base, pathname);
-	write_name_quoted_relative(base->buf,
-				   chomp_prefix ? ls_tree_prefix : NULL,
-				   stdout, line_termination);
-	strbuf_setlen(base, baselen);
+
+	if (shown_fields >= FIELD_DEFAULT)
+		show_default(oid, type, pathname, mode, base);
+
 	return recurse;
 }
 
@@ -123,12 +168,12 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			LS_SHOW_TREES),
 		OPT_SET_INT('z', NULL, &line_termination,
 			    N_("terminate entries with NUL byte"), 0),
-		OPT_CMDMODE('l', "long", &ls_options, N_("include object size"),
-			    LS_SHOW_SIZE),
-		OPT_CMDMODE(0, "name-only", &ls_options, N_("list only filenames"),
-			    LS_NAME_ONLY),
-		OPT_CMDMODE(0, "name-status", &ls_options, N_("list only filenames"),
-			    LS_NAME_ONLY),
+		OPT_CMDMODE('l', "long", &cmdmode, N_("include object size"),
+			    MODE_LONG),
+		OPT_CMDMODE(0, "name-only", &cmdmode, N_("list only filenames"),
+			    MODE_NAME_ONLY),
+		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
+			    MODE_NAME_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
@@ -159,6 +204,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	if (get_oid(argv[0], &oid))
 		die("Not a valid object name %s", argv[0]);
 
+	parse_shown_fields();
+
 	/*
 	 * show_recursive() rolls its own matching code and is
 	 * generally ignorant of 'struct pathspec'. The magic mask
-- 
2.34.1.406.g2e0e55130e

