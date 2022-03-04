Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCCDC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiCDKo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbiCDKoW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:44:22 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D8A1ACA3C
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:43:34 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id j1so3311394pfj.5
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mX4JMQhn1M6nXvnDyTKezObtL3dqTWuWcelZGd199Jk=;
        b=CzSbgxw6IIIPf7VmVsPPSIdn9Xp51QNQm5QLJDWEev77zdwH1vYEWPYkPUYxgeCfBX
         CXaBZ8DgrPIVySQCMJJ1DIdvaDZev3odqSiZXPBt75a6rFPw9j7UY+GPZKSxO3rE56qi
         jtZFxLajlqZ9xYJZRd2/O+HN0LIaHTMAIyiHQRFllI930H1HTXm5NrB4lRHc8wGT+i4O
         Erx6vVFz659tId/qVwaxBCUF34mre+VHh9Fy2gSU8eN2ZJg17IUJThlznCm7jwtkeDK1
         Cqv5uz3X/6+4btH1D3e5nuGfaXBG0YW6yR+CJmHs+rA1fRlcJjCA7xxzv2US/0VdYzkG
         P2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mX4JMQhn1M6nXvnDyTKezObtL3dqTWuWcelZGd199Jk=;
        b=V166H3XN/ukOnvi8JqqoXiZWZovtVgXpeOAItXdmhVV23B7gAGC5i5OCUzSLnw025G
         6fMEjv4TPOH0N3nQtflmsjxcb9V7BG+o/69Fi2RTlM92F02Y1ePs+Aw1eypK4MD6HdYU
         bGIRdqN1jI4fpGedPoeAKkxxY7iixeAhuqA15tp4ZNLxx0uBdHcy1Cfol6rwSMuXsiax
         lpjy9ByWu0kTftSuodWXlzZbCsGViH3eOAxD2AOK6q7/sKhR/3IVBe3Ke3GRKdY4ZTDH
         DJ2yHMeBJjQrYlMuVf53kqoLZzF/2HLo3pksyszlWSK0/HtXZpiYoyhAdcDRpMHpC1Ni
         JUdQ==
X-Gm-Message-State: AOAM5311JPVDcbWx/YRmOoMeEE02vD52MDwmeaknivZWNKl0uEN7Y0TH
        omq+vwEnNJjFO9Mr9ZJVWj8=
X-Google-Smtp-Source: ABdhPJyfic+bkrykPqQfnmL/xQ5SHn5xuXNsFrZE0gZJeuf6O8RGtoqgSPm+SXoA1Xp2MLWv06dEtQ==
X-Received: by 2002:a62:7990:0:b0:4e0:5ae8:6c11 with SMTP id u138-20020a627990000000b004e05ae86c11mr43092145pfc.34.1646390613461;
        Fri, 04 Mar 2022 02:43:33 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.53])
        by smtp.gmail.com with ESMTPSA id k7-20020a6555c7000000b0034e101ca75csm4236253pgs.6.2022.03.04.02.43.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 02:43:33 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v12 09/12] ls-tree: introduce struct "show_tree_data"
Date:   Fri,  4 Mar 2022 18:42:35 +0800
Message-Id: <80311adc7c3630cadac275dca70b6168516e6d21.1646390152.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <cover.1646390152.git.dyroneteng@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com>
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
index c70e31ac3d..04aefc6106 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -25,7 +25,6 @@ static int ls_options;
 static struct pathspec pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
-static unsigned int shown_fields;
 #define FIELD_PATH_NAME 1
 #define FIELD_SIZE (1 << 1)
 #define FIELD_OBJECT_NAME (1 << 2)
@@ -34,6 +33,15 @@ static unsigned int shown_fields;
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
@@ -45,19 +53,19 @@ static enum mutx_option {
 	MODE_LONG,
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
 
@@ -91,17 +99,15 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
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
@@ -109,18 +115,18 @@ static int show_default(const struct object_id *oid, enum object_type type,
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
 
@@ -130,6 +136,15 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
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
@@ -151,8 +166,8 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		return recurse;
 	}
 
-	if (shown_fields >= FIELD_DEFAULT)
-		show_default(oid, type, pathname, mode, base);
+	if (shown_fields>= FIELD_DEFAULT)
+		show_default(&data);
 
 	return recurse;
 }
@@ -162,6 +177,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	struct object_id oid;
 	struct tree *tree;
 	int i, full_tree = 0;
+	unsigned int shown_fields = 0;
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -207,8 +223,6 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	if (get_oid(argv[0], &oid))
 		die("Not a valid object name %s", argv[0]);
 
-	parse_shown_fields();
-
 	/*
 	 * show_recursive() rolls its own matching code and is
 	 * generally ignorant of 'struct pathspec'. The magic mask
@@ -225,6 +239,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
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
2.34.1.402.gef0f5bd184

