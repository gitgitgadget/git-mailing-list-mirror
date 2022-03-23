Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2720C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242497AbiCWJPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243119AbiCWJPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:15:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A5F7629A
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w8so932158pll.10
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i66FOR8tkiHOUzGM260kwQJtPAurnrmyRZzWJuY22hE=;
        b=PGtYA3JuDXTNMYNi21abHtrQFY0bnbMJ95hfJFaffNBRLaCMmhVz/4rIbCj8dBQXy5
         dub2NbKOHkBqMKFWtagGmiUmZL/9ud/IyknG3uYfp7z/6TqD3yz6TkTj9e9v9SJBi4QQ
         tBVELU0AzVWl+daRW4upxmTKtyyiV1csZqg+d0S1PBmBYeloYWYx2UoT3Ognx2ZwlS+r
         /hcPfgGt8RqPYjrvndORP1Xc4BwSQzfMfWmB+YvuX6Zj6D8Vhfv+OkuR/aEWv9PpVML6
         BF+OZRdv8L8q6r+KfmtHsW9nZg+tBTneK+TSSOFGTeD8qU20aMH4KNVea6cYeOpVsU4k
         HzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i66FOR8tkiHOUzGM260kwQJtPAurnrmyRZzWJuY22hE=;
        b=hDRihHC97oc4YvMyFFvvUVHTjHwq0UPDAikSFjYbuTCph0u2aIO3KRG3vxTA6olkAz
         x5LvNYrYg3jM8sqLX6RsHo2fsNbVwzNPe1C9z2VhyvG0EV4Ox6fv58IIH+0Cu/Bij+n6
         Q60R6OkSA/Gi/yZgP7ER/8hDwbUl4dehMJ0yuAD1jTR/duYc9bMo1DejI5LbXkO1nmJv
         90I+T9sDRZvFCzxD9CdID0wRZy4IhIcOkSVxPk0zg3RZzP3uxKj2/W0LNT0o4GaFCbsj
         PAPail2PAoFwkEunlzpyMlwKhwbenl9tMFfKuOhZ7Hh/wccXtxbd9Rnh5lH7HW8C8e9D
         EbCg==
X-Gm-Message-State: AOAM533vXsfv1lPyJiUL/4IOgqq1zHVZp7b05t9odHjp4oLFZXdJiWqL
        6JKsmMT9oz0auqBf3KT+y3o=
X-Google-Smtp-Source: ABdhPJy+HGoz5lJFS+llotzfr60WxM2Qp2uk62wHWz2dYzYvHz5kV3NHRJ3KYJrsfseBGccnfFe4NQ==
X-Received: by 2002:a17:902:7141:b0:154:28e0:9720 with SMTP id u1-20020a170902714100b0015428e09720mr21692702plm.116.1648026828693;
        Wed, 23 Mar 2022 02:13:48 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:13:48 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v14 10/15] ls-tree: introduce struct "show_tree_data"
Date:   Wed, 23 Mar 2022 17:13:10 +0800
Message-Id: <5131c0dcff7407220d43e1ea507047053f65be39.1648026472.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.404.g92931a4a2c.dirty
In-Reply-To: <cover.1648026472.git.dyroneteng@gmail.com>
References: <cover.1648026472.git.dyroneteng@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 173a534e92..edc8bf53a6 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -23,6 +23,13 @@ static int ls_options;
 static struct pathspec pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
+struct show_tree_data {
+	unsigned mode;
+	enum object_type type;
+	const struct object_id *oid;
+	const char *pathname;
+	struct strbuf *base;
+};
 
 static const  char * const ls_tree_usage[] = {
 	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
@@ -64,17 +71,15 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 	return 0;
 }
 
-static int show_default(const struct object_id *oid, enum object_type type,
-			const char *pathname, unsigned mode,
-			struct strbuf *base)
+static int show_default(struct show_tree_data *data)
 {
-	size_t baselen = base->len;
+	size_t baselen = data->base->len;
 
 	if (cmdmode == MODE_LONG) {
 		char size_text[24];
-		if (type == OBJ_BLOB) {
+		if (data->type == OBJ_BLOB) {
 			unsigned long size;
-			if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
+			if (oid_object_info(the_repository, data->oid, &size) == OBJ_BAD)
 				xsnprintf(size_text, sizeof(size_text), "BAD");
 			else
 				xsnprintf(size_text, sizeof(size_text),
@@ -82,18 +87,18 @@ static int show_default(const struct object_id *oid, enum object_type type,
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
 
@@ -103,6 +108,13 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	int recurse = 0;
 	size_t baselen;
 	enum object_type type = object_type(mode);
+	struct show_tree_data data = {
+		.mode = mode,
+		.type = type,
+		.oid = oid,
+		.pathname = pathname,
+		.base = base,
+	};
 
 	if (type == OBJ_BLOB) {
 		if (ls_options & LS_TREE_ONLY)
@@ -128,7 +140,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		(!ls_options || (ls_options & LS_RECURSIVE)
 		 || (ls_options & LS_SHOW_TREES)
 		 || (ls_options & LS_TREE_ONLY)))
-			 show_default(oid, type, pathname, mode, base);
+			 show_default(&data);
 
 	return recurse;
 }
-- 
2.34.1.404.g92931a4a2c.dirty

