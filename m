Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6017BC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F5E2467E
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB+W1Kew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgA1S06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:26:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34093 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgA1S0y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 13:26:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so17212457wrr.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 10:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ajb6A/XjF+nig/8pWW4JsKbi+gbolc3gWDFeR5Hxuxc=;
        b=YB+W1KewotPpGDahZ5E67kvmBsPMW/vJwDIS5aLiZgYIiuLgXmAs8IAO7thslqXXec
         zHfI0PPilquiikTdopJi/WAaXSyNObKsZj3UoMfUXgWvgTB4NB8Yx1PdcXbknT3FmI+j
         xETaOQ3jKNZF1MmKkiEoi4ilR85IXjyEhniyfaU/st8Coe0JflPQa/V421MaocH1BeB1
         px0DRG3HIrYRTq7pkGM5AosyKcZclXnxJjPp5/M1i2lZPD4escAInZsr2/DI8fR13bWA
         YhPPk6eAEIQMcbthkZSEw9cLv5x6bFNYPySFimB7Uiwnrlxs2t6p3VXbMaLGmCaqyMqu
         dFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ajb6A/XjF+nig/8pWW4JsKbi+gbolc3gWDFeR5Hxuxc=;
        b=GRezsEfIsjF8wBTaqbsmTTUDsL+IH8UmwyZPkIn5qmcn9FBsthbCHFiWtbOOfHZs1r
         vFbpPtJB2jPQot2A05fkSlP49P03U11G1aP2tYMzqQupoGqpaoTAuQEW5KtZL0SBgAur
         BAPXR4cepFrE0dSZZRynsQpKdxuzdM+ZVuRvWXADyOWvgs/iCW1+P3PGZME5wt4caPxB
         FpautpMrt6sH3o8Gm6lrOlseVzjdxzRwyXdeavGuxyUJM0R+hIEoK793EYQBnzaVD8ip
         gmkXKC23RN0c55dSYrqAtFFXfyw60xxWgwQcXNur6foyz2+l440vR9BTmfjeHskl1Nzg
         mvtA==
X-Gm-Message-State: APjAAAWe+O8WAsK4au33pIZ6DkDo1cwUTgakDUQNbiX8XgwMFaRqiT1z
        wj1YLbfsNBa8uwsrP/GLG+vNOs9S
X-Google-Smtp-Source: APXvYqwwicMm9jND+8pImlgMgbCK/f01KXwosbhjBTi/0fQ8tNsIFO9S4hLQTZP/3/Bg8hZIvxylnw==
X-Received: by 2002:a5d:4f90:: with SMTP id d16mr30076048wru.395.1580236012091;
        Tue, 28 Jan 2020 10:26:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s139sm4233810wme.35.2020.01.28.10.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 10:26:51 -0800 (PST)
Message-Id: <e2f9afc70c92c606a9d93660bce0599b7b7ddf6e.1580236003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
        <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jan 2020 18:26:41 +0000
Subject: [PATCH v3 10/12] sparse-checkout: write escaped patterns in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If a user somehow creates a directory with an asterisk (*) or backslash
(\), then the "git sparse-checkout set" command will struggle to provide
the correct pattern in the sparse-checkout file. When not in cone mode,
the provided pattern is written directly into the sparse-checkout file.
However, in cone mode we expect a list of paths to directories and then
we convert those into patterns.

Even more specifically, the goal is to always allow the following from
the root of a repo:

  git ls-tree --name-only -d HEAD | git sparse-checkout set --stdin

The ls-tree command provides directory names with an unescaped asterisk.
It also quotes the directories that contain an escaped backslash. We
must remove these quotes, then keep the escaped backslashes.

However, there is some care needed for the timing of these escapes. The
in-memory pattern list is used to update the working directory before
writing the patterns to disk. Thus, we need the command to have the
unescaped names in the hashsets for the cone comparisons, then escape
the patterns later.

Use unquote_c_style() when parsing lines from stdin. Command-line
arguments will be parsed as-is, assuming the user can do the correct
level of escaping from their environment to match the exact directory
names.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 38 +++++++++++++++++++++++++++---
 t/t1091-sparse-checkout-builtin.sh | 21 +++++++++++++++--
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 3cee8ab46e..61414fef18 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -13,6 +13,7 @@
 #include "resolve-undo.h"
 #include "unpack-trees.h"
 #include "wt-status.h"
+#include "quote.h"
 
 static const char *empty_base = "";
 
@@ -140,6 +141,22 @@ static int update_working_directory(struct pattern_list *pl)
 	return result;
 }
 
+static char *escaped_pattern(char *pattern)
+{
+	char *p = pattern;
+	struct strbuf final = STRBUF_INIT;
+
+	while (*p) {
+		if (*p == '*' || *p == '\\')
+			strbuf_addch(&final, '\\');
+
+		strbuf_addch(&final, *p);
+		p++;
+	}
+
+	return strbuf_detach(&final, NULL);
+}
+
 static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 {
 	int i;
@@ -164,10 +181,11 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 	fprintf(fp, "/*\n!/*/\n");
 
 	for (i = 0; i < sl.nr; i++) {
-		char *pattern = sl.items[i].string;
+		char *pattern = escaped_pattern(sl.items[i].string);
 
 		if (strlen(pattern))
 			fprintf(fp, "%s/\n!%s/*/\n", pattern, pattern);
+		free(pattern);
 	}
 
 	string_list_clear(&sl, 0);
@@ -185,8 +203,9 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 	string_list_remove_duplicates(&sl, 0);
 
 	for (i = 0; i < sl.nr; i++) {
-		char *pattern = sl.items[i].string;
+		char *pattern = escaped_pattern(sl.items[i].string);
 		fprintf(fp, "%s/\n", pattern);
+		free(pattern);
 	}
 }
 
@@ -423,8 +442,21 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 		pl.use_cone_patterns = 1;
 
 		if (set_opts.use_stdin) {
-			while (!strbuf_getline(&line, stdin))
+			struct strbuf unquoted = STRBUF_INIT;
+			while (!strbuf_getline(&line, stdin)) {
+				if (line.buf[0] == '"') {
+					strbuf_setlen(&unquoted, 0);
+					if (unquote_c_style(&unquoted, line.buf, NULL))
+						die(_("unable to unquote C-style string '%s'"),
+						line.buf);
+
+					strbuf_swap(&unquoted, &line);
+				}
+
 				strbuf_to_cone_pattern(&line, &pl);
+			}
+
+			strbuf_release(&unquoted);
 		} else {
 			for (i = 0; i < argc; i++) {
 				strbuf_setlen(&line, 0);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 0a21a5e15d..459715d541 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -309,6 +309,9 @@ check_read_tree_errors () {
 	REPO=$1
 	FILES=$2
 	ERRORS=$3
+	git -C $REPO -c core.sparseCheckoutCone=false read-tree -mu HEAD 2>err &&
+	test_must_be_empty err &&
+	check_files $REPO "$FILES" &&
 	git -C $REPO read-tree -mu HEAD 2>err &&
 	if test -z "$ERRORS"
 	then
@@ -379,14 +382,28 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
 	git -C escaped reset --hard $COMMIT &&
 	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" &&
 	git -C escaped sparse-checkout init --cone &&
-	cat >escaped/.git/info/sparse-checkout <<-\EOF &&
+	git -C escaped sparse-checkout set zbad\\dir "zdoes*not*exist" "zdoes*exist" &&
+	cat >expect <<-\EOF &&
 	/*
 	!/*/
 	/zbad\\dir/
+	/zdoes\*exist/
 	/zdoes\*not\*exist/
+	EOF
+	test_cmp expect escaped/.git/info/sparse-checkout &&
+	check_read_tree_errors escaped "a zbad\\dir zdoes*exist" &&
+	git -C escaped ls-tree -d --name-only HEAD | git -C escaped sparse-checkout set --stdin &&
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/deep/
+	/folder1/
+	/folder2/
+	/zbad\\dir/
 	/zdoes\*exist/
 	EOF
-	check_read_tree_errors escaped "a zbad\\dir zdoes*exist"
+	test_cmp expect escaped/.git/info/sparse-checkout &&
+	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist"
 '
 
 test_done
-- 
gitgitgadget

