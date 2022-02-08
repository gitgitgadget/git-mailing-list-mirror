Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAE5C4167E
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376968AbiBHNOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350290AbiBHMPI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 07:15:08 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3107C03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 04:15:06 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id j4so1391336plj.8
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 04:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IC6fX02N8mHHRgpZPEjR8TynJIG+AZT0/xAKQJgQdXg=;
        b=RbVuP/8j2xWy9P0/xR/5EE1VArVO3wupfoh2uXe1mGNxF67/W8wuHQTj12/zdDzJ/o
         fcCfxIyez5fcEATkhKlm25hs1v7zhYuj7P6Gqvd3WBhAMwWBAPvvTc9T7rVKcCm5H8r/
         Dq1u+102kg01ZetNFd/NysrAi1/E2zH5dxbUXBtZn7Nw6lo/7nl0vnexoV1ameFuzjHg
         UUAlagCPEeSM1LcttjJeYCVA0ciXmJPKavmoC4jnIJzmKv1COYXFccjFD4GAD3+QXNyQ
         8fz2Wg717T3xVwedoDw/dAY9QKDOeP3+qoRAALVeiD1eFMvimMmsjb7XaqlVFauIAtN9
         jqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IC6fX02N8mHHRgpZPEjR8TynJIG+AZT0/xAKQJgQdXg=;
        b=Ml9kguebRJpAHkQHE6bGymr/q0g6A902AhkSnYDgq9ktnNNPpxNf94Gp4ytQ4+zH4L
         sBxH1d01ysskV4DWgHMb7KDBF1pwPZl6asdpepuP3i9lofjJXPeKM90CFrj4m5+RUX+J
         0BqnITzqlh7n8/Xl53bwiAg+8IhG9TnwhYSFzPt+7enWgzmsZJDXhKLF5csge8OamYdD
         TKkBZoCWYKFP1l5hKy/34mVvNYbFu/ViS9tqCyV+ZiH9JIJS1FaqumnYC9klaOdoZ/0Q
         D66he9zx2YsStmWYVXh3w0OAFfdiiWV8wldZj6ve/lRke/Liobxrk9isJCWGauPMThnB
         AXXQ==
X-Gm-Message-State: AOAM533F8lG2JsnPgYgpLtCuH2Pd0WnQZeq4zwpdYEdMSNop1MRIAsxg
        8RCqbQ2m25FPIsgSRfvaXSQ=
X-Google-Smtp-Source: ABdhPJypQsONJMLWLngX/wVdTpNwfYdNpAAgsxVdEekdDhR5ENxA8XHVfg55uvrnDXUMWm13oijqUw==
X-Received: by 2002:a17:902:7c84:: with SMTP id y4mr3948291pll.149.1644322506430;
        Tue, 08 Feb 2022 04:15:06 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id t3sm16973344pfg.28.2022.02.08.04.15.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:15:06 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v11 08/13] ls-tree: slightly refactor `show_tree()`
Date:   Tue,  8 Feb 2022 20:14:33 +0800
Message-Id: <41e8ed50476a5afd6009db1a69c7a39b04e038b0.1644319434.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.403.gb35f2687cf.dirty
In-Reply-To: <cover.1644319434.git.dyroneteng@gmail.com>
References: <cover.1644319434.git.dyroneteng@gmail.com>
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
 builtin/ls-tree.c | 126 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 89 insertions(+), 37 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 32147e75e6..8baab7c83e 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -16,21 +16,53 @@
 
 static int line_termination = '\n';
 #define LS_RECURSIVE 1
-#define LS_TREE_ONLY 2
-#define LS_SHOW_TREES 4
-#define LS_NAME_ONLY 8
-#define LS_SHOW_SIZE 16
+#define LS_TREE_ONLY (1 << 1)
+#define LS_SHOW_TREES (1 << 2)
+#define LS_NAME_ONLY (1 << 3)
+#define LS_SHOW_SIZE (1 << 4)
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
 
+enum {
+	MODE_UNSPECIFIED = 0,
+	MODE_NAME_ONLY,
+	MODE_LONG,
+};
+
+static int cmdmode = MODE_UNSPECIFIED;
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
@@ -61,6 +93,39 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
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
@@ -75,34 +140,19 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
 		return 0;
 
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
 
@@ -120,12 +170,12 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
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
@@ -156,6 +206,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	if (get_oid(argv[0], &oid))
 		die("Not a valid object name %s", argv[0]);
 
+	parse_shown_fields();
+
 	/*
 	 * show_recursive() rolls its own matching code and is
 	 * generally ignorant of 'struct pathspec'. The magic mask
-- 
2.34.1.403.gb35f2687cf.dirty

