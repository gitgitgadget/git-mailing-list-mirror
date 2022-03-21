Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9D5C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344935AbiCUHfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344955AbiCUHfd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C800AA030
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so9858508pjm.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZWXgBHpEp0Y9fnYXGP77yCUTSo7XHAg8IOANSnuwhHI=;
        b=nl6bBlBn8sOYQXf8T2botIYJVC2uBqmZAL5z6lX8Z3iTU4sP48epZFcJefbi9udBvX
         U43xg+f/3YEF9PFLTFfCqWoEOa5zsacbfslYdWYlhuwbOuuD9IL2qYIJnCJXTgkv9si8
         3/KVZNKP4BsVtOZf0tauILxU+TtdC473CEYxxbx09ydnnTYJcGFZx7Ys287bvcBkp+iu
         dWfSQkCSQP6Oop5OJ6qS8S/pTIotH5fGYn1NHtC9XWHhycCP24JFSDuTnEVuA5kYbZgx
         h2XMls0vKUrYLks9tPtXCSf1aEjZqBPWa3Rpy5SP8sd4en2r/mu3sBtAmpBKxY9jjEb2
         Cxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZWXgBHpEp0Y9fnYXGP77yCUTSo7XHAg8IOANSnuwhHI=;
        b=3yaastUUXMZhAMMkrEOt3UWoR3a+1G6/P+ndhPPx5LMvIwMkO9cqp0k0DMINzJ3roS
         3xYy7lGSXwGouvoaFyn40yIu/Jri+zA/1cohy/DUrnnjUM5jr6o05Qxb17vShzze9RxK
         hWF0ycKAsrSlGBhwam4/nx1mOPP3/Id3kXJlKdGXI0kDhGfff09E1wJaxyTOAp86Am9q
         n/ydjaxPsrYXSCE93+VTkxmZWeu3ZWiiPoKlW2ggyu2uX/H5fiIfwEzd7yKv1mZioZfT
         x2S4PpAZ1eeYpY7AlVL6XnP7JgSn0M+WH1D34zc9GWjRN9/21RrmC5uXfmq+yglURSdu
         lDzQ==
X-Gm-Message-State: AOAM530gg2G7DlfFpcY1b21NcnxTwQVbqS/8qHbV/TImy3EhznxK36XU
        USUwv8sGIGh/00BhoOycjRI=
X-Google-Smtp-Source: ABdhPJwOqaVu8P6ryDrlsXhkZQavaFo5xH9xuDQPg87No53HNm+OQO963FzGjB9b5bojDZzUmFrFEw==
X-Received: by 2002:a17:903:22d1:b0:154:4cfa:2b12 with SMTP id y17-20020a17090322d100b001544cfa2b12mr5317414plg.47.1647848044614;
        Mon, 21 Mar 2022 00:34:04 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.34.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:34:04 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v13 09/16] ls-tree: introduce struct "show_tree_data"
Date:   Mon, 21 Mar 2022 15:33:23 +0800
Message-Id: <85d0b0da1d3b6e8e099a7b78acca57e6a0019a1f.1647846935.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.406.g2e0e55130e
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com>
References: <cover.1647846935.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

"show_tree_data" is a struct that packages the necessary fields for
"show_tree()". This commit is a pre-prepared commit for supporting
"--format" option and it does not affect any existing functionality.

At the same time, we also move global "shown_fields" into "show_tree_data"
, the purpose of this is to avoid use both global variable and pass-around
struct.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 69 +++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 4364416e1c..0491847b43 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -23,7 +23,6 @@ static int ls_options;
 static struct pathspec pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
-static unsigned int shown_fields;
 #define FIELD_PATH_NAME 1
 #define FIELD_SIZE (1 << 1)
 #define FIELD_OBJECT_NAME (1 << 2)
@@ -32,6 +31,15 @@ static unsigned int shown_fields;
 #define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default */
 #define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)
 
+struct show_tree_data {
+	unsigned mode;
+	enum object_type type;
+	const struct object_id *oid;
+	const char *pathname;
+	struct strbuf *base;
+	unsigned int shown_fields;
+};
+
 static const  char * const ls_tree_usage[] = {
 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
 	NULL
@@ -42,19 +50,19 @@ static enum ls_tree_cmdmode {
 	MODE_NAME_ONLY,
 } cmdmode;
 
-static int parse_shown_fields(void)
+static int parse_shown_fields(unsigned int *shown_fields)
 {
 	if (cmdmode == MODE_NAME_ONLY) {
-		shown_fields = FIELD_PATH_NAME;
+		*shown_fields = FIELD_PATH_NAME;
 		return 0;
 	}
 
 	if (!ls_options || (ls_options & LS_RECURSIVE)
 	    || (ls_options & LS_SHOW_TREES)
 	    || (ls_options & LS_TREE_ONLY))
-		shown_fields = FIELD_DEFAULT;
+		*shown_fields = FIELD_DEFAULT;
 	if (cmdmode == MODE_LONG)
-		shown_fields = FIELD_LONG_DEFAULT;
+		*shown_fields = FIELD_LONG_DEFAULT;
 	return 1;
 }
 
@@ -88,17 +96,15 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 	return 0;
 }
 
-static int show_default(const struct object_id *oid, enum object_type type,
-			const char *pathname, unsigned mode,
-			struct strbuf *base)
+static int show_default(struct show_tree_data *data)
 {
-	size_t baselen = base->len;
+	size_t baselen = data->base->len;
 
-	if (shown_fields & FIELD_SIZE) {
+	if (data->shown_fields & FIELD_SIZE) {
 		char size_text[24];
-		if (type == OBJ_BLOB) {
+		if (data->type == OBJ_BLOB) {
 			unsigned long size;
-			if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
+			if (oid_object_info(the_repository, data->oid, &size) == OBJ_BAD)
 				xsnprintf(size_text, sizeof(size_text), "BAD");
 			else
 				xsnprintf(size_text, sizeof(size_text),
@@ -106,18 +112,18 @@ static int show_default(const struct object_id *oid, enum object_type type,
 		} else {
 			xsnprintf(size_text, sizeof(size_text), "-");
 		}
-		printf("%06o %s %s %7s\t", mode, type_name(type),
-		find_unique_abbrev(oid, abbrev), size_text);
+		printf("%06o %s %s %7s\t", data->mode, type_name(data->type),
+		find_unique_abbrev(data->oid, abbrev), size_text);
 	} else {
-		printf("%06o %s %s\t", mode, type_name(type),
-		find_unique_abbrev(oid, abbrev));
+		printf("%06o %s %s\t", data->mode, type_name(data->type),
+		find_unique_abbrev(data->oid, abbrev));
 	}
-	baselen = base->len;
-	strbuf_addstr(base, pathname);
-	write_name_quoted_relative(base->buf,
+	baselen = data->base->len;
+	strbuf_addstr(data->base, data->pathname);
+	write_name_quoted_relative(data->base->buf,
 				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
 				   line_termination);
-	strbuf_setlen(base, baselen);
+	strbuf_setlen(data->base, baselen);
 	return 1;
 }
 
@@ -127,6 +133,15 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	int recurse = 0;
 	size_t baselen;
 	enum object_type type = object_type(mode);
+	unsigned int shown_fields = *(unsigned int *)context;
+	struct show_tree_data data = {
+		.mode = mode,
+		.type = type,
+		.oid = oid,
+		.pathname = pathname,
+		.base = base,
+		.shown_fields = shown_fields,
+	};
 
 	if (type == OBJ_BLOB) {
 		if (ls_options & LS_TREE_ONLY)
@@ -148,8 +163,8 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		return recurse;
 	}
 
-	if (shown_fields >= FIELD_DEFAULT)
-		show_default(oid, type, pathname, mode, base);
+	if (shown_fields>= FIELD_DEFAULT)
+		show_default(&data);
 
 	return recurse;
 }
@@ -159,6 +174,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	struct object_id oid;
 	struct tree *tree;
 	int i, full_tree = 0;
+	unsigned int shown_fields = 0;
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -204,8 +220,6 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	if (get_oid(argv[0], &oid))
 		die("Not a valid object name %s", argv[0]);
 
-	parse_shown_fields();
-
 	/*
 	 * show_recursive() rolls its own matching code and is
 	 * generally ignorant of 'struct pathspec'. The magic mask
@@ -222,6 +236,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	tree = parse_tree_indirect(&oid);
 	if (!tree)
 		die("not a tree object");
-	return !!read_tree(the_repository, tree,
-			   &pathspec, show_tree, NULL);
+
+	parse_shown_fields(&shown_fields);
+
+	return !!read_tree(the_repository, tree, &pathspec, show_tree,
+			   &shown_fields);
 }
-- 
2.34.1.406.g2e0e55130e

