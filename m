Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14158C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbiCDKoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbiCDKoV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:44:21 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C112A1AC2B2
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:43:29 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 6so2648394pgg.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WgyDVYeY7QQW1zjlibjeDYEwPgOgxdg0ZBsRXJBKTgM=;
        b=bjJBSnpIOTOkIxisxYQ/lVDyf4zCiYlUEzM81OMt8/FveVAB6WuBOxSQ3z/xMiFb7N
         VGHAc9jX3vIqyfdhIIwBBFV98RKglwdng7AUKBmqa6y2zbIZcREeQMwonK3D4474Dgkb
         yfr4I1CDB4yOTR/kEZXKQKt5vUchSLWENLvTxLifqL2BcReVd+t5pHrjsvL2nvhQdXOF
         dOmBxs4N0yKwJjhqac1xe3qDe6clhBRLBRGVmRH8Bb0gBhnGKXyNvVXksNeNzVXcWITj
         8EIg3mYLMjjdcpcwOoHoNmuTbtvPUPA4TvOR0AjdhfzXICBLidA+XqrCG0zu0hhGtzuq
         HBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WgyDVYeY7QQW1zjlibjeDYEwPgOgxdg0ZBsRXJBKTgM=;
        b=o1qv81EvUsyExUAjOaUeRpXB7UR+qUYMly7XOCndnYAnff/JOZKgltcEw/sihxGTzN
         5llYPx4C2rNbsjcvx89q5K8zi1w4ntfx/pe7ZODXss9qdWgvkdH6hWskRy7iDci3seYu
         mqdxZg4d9uY3O6JRZOQs1s0cPAElFei5bVU/BK2biTwD1FurXXSTgcdanoRWm17HPko7
         5E0uolHQAtQ6JFjw7vr2SHKYvNRU37Jr9g1W2dJUBnp3wUBpmgCjvpPnfH2QPf+9jYlA
         +C6kETsW7Ky1wSaO57JefDgr/MAV8z9WF9oyqiKb03xoRSfI5wlvw6AZXcDHoYXyBpEf
         iOhQ==
X-Gm-Message-State: AOAM532iIFJsHqU0Ed9jPRkbYok93540UVsMNrono5snPt3P2NOLM/8U
        mubERprhiNzYlccofenMCw4U8w3uNL3nkTt7
X-Google-Smtp-Source: ABdhPJyS8YWptDRs1bcC2mTKOwAOyoieIMEp2IVbNe3SXvluyL/UOzSEuSLBxJAIpUiEzT64eM8SzA==
X-Received: by 2002:a63:d642:0:b0:378:a4c2:7b94 with SMTP id d2-20020a63d642000000b00378a4c27b94mr20759388pgj.218.1646390609243;
        Fri, 04 Mar 2022 02:43:29 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.53])
        by smtp.gmail.com with ESMTPSA id k7-20020a6555c7000000b0034e101ca75csm4236253pgs.6.2022.03.04.02.43.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 02:43:28 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v12 08/12] ls-tree: slightly refactor `show_tree()`
Date:   Fri,  4 Mar 2022 18:42:34 +0800
Message-Id: <f449146b4d3cbe0b75fc4a4d4638be821db533be.1646390152.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <cover.1646390152.git.dyroneteng@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com>
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
 builtin/ls-tree.c | 124 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 87 insertions(+), 37 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 7be4c13228..c70e31ac3d 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -16,21 +16,51 @@
 
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
 
+static enum mutx_option {
+	MODE_UNSPECIFIED = 0,
+	MODE_NAME_ONLY,
+	MODE_LONG,
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
@@ -61,6 +91,39 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
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
@@ -78,34 +141,19 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
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
 
@@ -123,12 +171,12 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
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
@@ -159,6 +207,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	if (get_oid(argv[0], &oid))
 		die("Not a valid object name %s", argv[0]);
 
+	parse_shown_fields();
+
 	/*
 	 * show_recursive() rolls its own matching code and is
 	 * generally ignorant of 'struct pathspec'. The magic mask
-- 
2.34.1.402.gef0f5bd184

