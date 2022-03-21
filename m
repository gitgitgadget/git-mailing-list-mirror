Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA559C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344975AbiCUHfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344968AbiCUHft (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3DFAD10F
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p5so8598638pfo.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xt4DXtThObflsr/SrL/svQNyy+x2Tjz5S/vXMdKxLsk=;
        b=XJ9iUbO6iwXcNaTYccJYcJz30s1Ew7CotQNU0xbMcW+LmwzraQjjbgy2cDKj6WwCvA
         DhAKFrW4udU40pNIjEbiEn4fMTPywXxkncnIMpySVvCoXqHF255tGjE01djNKKUVAnfS
         ZTLw9zzwBF0NUFY7OBPTcutgIu/oWOiH7iViy2ldRjK+fviS0WhCfQe2RICYPx6xh2gF
         0hRzdTVTR/6lX4u4cLKa44t5i0ZuToIKuU2/9jk5DZnhkGi/zDw5feOruFidaSjdvr4t
         rB6oz1/LLz5ZzhloYWLUq045DOq6vVsFV2HYpOoESpaNMN1kiRCpxZ7Ano6bZgHPmWNX
         l4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xt4DXtThObflsr/SrL/svQNyy+x2Tjz5S/vXMdKxLsk=;
        b=np4C/IOSL9DXBRz+4rlwz+Tu34jKvioAduy89U3h4e2go3or2uS3Dah2O0HfELK1Lb
         DlTlhOfdDEeSyMoNXRzHn2v+nr0KLn/FEHEHhYedokzGzoOWurbbS0WwMtDDQARyWzGH
         fS4UkdOH2Q3mPpsadADoUee3eNNltlt6aY5S+VuFmWDFS0cPjHphMd+s4m64aBN8M+pJ
         xKhATgAaRzD8pHalDn0qO44/r2DR2jjIzsyynIryxOkVHt85aYKVvtFGi6lp/P30oBYg
         jgSiUfhPHkAOHoF/Mg2rPUZ013lpNnF/rHyiru0VAsyECJkcXxW7qrWGe3uTqEEOwkFk
         aANQ==
X-Gm-Message-State: AOAM5304nvATgHWdqTCNgHFsvwzwp0wdbvj+MnoWF1Jqj84nXb/PREQb
        rnP8iIhj/Y3u/UW0pgJalUA=
X-Google-Smtp-Source: ABdhPJx3P3Be1s1GYeso3FAVwkgsu6ERmakiPkh9bsWrw9jlDLKldl41/bsOX/2g10/b0vwgUCXEKg==
X-Received: by 2002:a65:45cb:0:b0:380:cf1d:6b7a with SMTP id m11-20020a6545cb000000b00380cf1d6b7amr17312108pgr.495.1647848062646;
        Mon, 21 Mar 2022 00:34:22 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.34.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:34:22 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v13 15/16] ls-tree: remove FIELD_*, just use MODE_*
Date:   Mon, 21 Mar 2022 15:33:29 +0800
Message-Id: <b8afca193ad7edd64612595742929f245cc340f3.1647846935.git.dyroneteng@gmail.com>
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

When we're picking where we should go in the optimized "show_tree"
path there's no reason for why we need to convert our "cmdmode" of
e.g. MODE_LONG into a FIELD_LONG_DEFAULT. Instead we can simply do
those checks in the show_tree() function itself.

Let's also make this code more future-proof by unrolling the hardcoded
strmp() if/else if chain into something that checks a new "static
struct" providing a bidirectional mapping between optimized formats
and the ls_tree_cmdmode.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 98 ++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 52 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index a271941540..3e756b5eee 100644
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
2.34.1.406.g2e0e55130e

