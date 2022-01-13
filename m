Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FDCC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 03:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiAMDmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiAMDmh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 22:42:37 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D91EC061759
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so16651277pjj.2
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B6UWG0IOiHJhFSmbNoxoi7AFXeUUN0/apGWh9laPaqA=;
        b=oA1bxwiA9+j63tbtw5miwKlx48/U8obk72P//c/D3j9Af3hJqOpguoCPsAKE7bOSAk
         K5jY+gfhYbPJTihxOy3zkj34rE+YDAM2VrDjpIG55DKb7iE9FDonRVxKSO6cRsnIK3mA
         GaGP2FmRW9zgy65d2v0OmY1CLPrUX1boMWU+C5GWtXfx/lPvpu++YmH2+M7raBjp6QMY
         ncoA+sDEpiYfe1/xSOBeqngI6wSfbKQx3F4xlok6tbZ7IYoV2c+tGVgkayOo9x8wLztU
         f0zWkSKQ7r0/S6dquStjf+lbXznKR7+XdRtrMHns19kPFW69Jk76bvHFAQP/+4s0ivzq
         QyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B6UWG0IOiHJhFSmbNoxoi7AFXeUUN0/apGWh9laPaqA=;
        b=FdEA5KvN3lxVa53Z/qri4Tkudt7gqAMPVM0TDhkNbiX3FswNPPP7u+iqaQJQZn0gSa
         rJcCxKXWmMZ3SuNlQnzvy0hPGo/Tg9ev2DOFL8c8eJV0UkfEt1ALpv8BReKI9L9tsLS9
         heeicSVa0OzKEjspemEGESRd6W6wVUkDwDY0WMpOxeuexUzpRZ4XT9iyK+xuGi4qKYZ3
         zQycYr9ppCDxUUsnCcW1qk/8UVfGHvtVicheQDFvsdwcX40wRa0ulumZBo6HmE43V3G7
         DTZ22IZ8oosOuq+lj6kug5K0+EImqahPps6wD/3bAF/vyYvsmyyHPZc54iDaFhDgt8K1
         ccFw==
X-Gm-Message-State: AOAM5323SFsDVhHSaftxesb1Q7T3lxX+1rYGUrm83qMkVGwdKDTGWFTj
        5Q1E2xYEmD3iRMXHg/ptgz0=
X-Google-Smtp-Source: ABdhPJxha/ojLGxPJlVi5mIvo10X3N6L88YhEPrhGP6ORZMSs13NiUwDEcjTzyUj87nq0P/gpWD6ew==
X-Received: by 2002:a63:8543:: with SMTP id u64mr154338pgd.474.1642045356948;
        Wed, 12 Jan 2022 19:42:36 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.48])
        by smtp.gmail.com with ESMTPSA id c20sm879436pgk.75.2022.01.12.19.42.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 19:42:36 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, martin.agren@gmail.com
Subject: [PATCH v10 7/9] ls-tree.c: introduce struct "show_tree_data"
Date:   Thu, 13 Jan 2022 11:42:10 +0800
Message-Id: <3ddffa10278b5814123a5bcd2fd3a531def3ecdc.1641978175.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.390.g2ae0a9cb82.dirty
In-Reply-To: <cover.1641978175.git.dyroneteng@gmail.com>
References: <cover.1641978175.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"show_tree_data" is a struct that packages the necessary fields for
"show_tree()". This commit is a pre-prepared commit for supporting
"--format" option and it does not affect any existing functionality.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index e1a2f8225b..56cc166adb 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -35,6 +35,14 @@ static unsigned int shown_fields;
 #define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default */
 #define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)
 
+struct show_tree_data {
+	unsigned mode;
+	enum object_type type;
+	const struct object_id *oid;
+	const char *pathname;
+	struct strbuf *base;
+};
+
 static const  char * const ls_tree_usage[] = {
 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
 	NULL
@@ -108,17 +116,15 @@ static enum object_type get_type(unsigned int mode)
 	        : OBJ_BLOB);
 }
 
-static int show_default(const struct object_id *oid, enum object_type type,
-			const char *pathname, unsigned mode,
-			struct strbuf *base)
+static int show_default(struct show_tree_data *data)
 {
-	size_t baselen = base->len;
+	size_t baselen = data->base->len;
 
 	if (shown_fields & FIELD_SIZE) {
 		char size_text[24];
-		if (type == OBJ_BLOB) {
+		if (data->type == OBJ_BLOB) {
 			unsigned long size;
-			if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
+			if (oid_object_info(the_repository, data->oid, &size) == OBJ_BAD)
 				xsnprintf(size_text, sizeof(size_text), "BAD");
 			else
 				xsnprintf(size_text, sizeof(size_text),
@@ -126,18 +132,18 @@ static int show_default(const struct object_id *oid, enum object_type type,
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
 
@@ -148,6 +154,14 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	size_t baselen;
 	enum object_type type = get_type(mode);
 
+	struct show_tree_data data = {
+		.mode = mode,
+		.type = type,
+		.oid = oid,
+		.pathname = pathname,
+		.base = base,
+	};
+
 	if (type == OBJ_TREE && show_recursive(base->buf, base->len, pathname))
 		recurse = READ_TREE_RECURSIVE;
 	if (type == OBJ_TREE && recurse && !(ls_options & LS_SHOW_TREES))
@@ -171,7 +185,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	}
 
 	if (shown_fields >= FIELD_DEFAULT)
-		show_default(oid, type, pathname, mode, base);
+		show_default(&data);
 
 	return recurse;
 }
-- 
2.34.1.390.g2ae0a9cb82.dirty

