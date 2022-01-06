Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325D2C433FE
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 04:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiAFEcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 23:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiAFEcM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 23:32:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5012CC061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 20:32:12 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l16-20020a17090a409000b001b2e9628c9cso1899651pjg.4
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 20:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JcVlap2DybYKMoXTnY18ziEJBU2JBRvgabCnv4g56Ws=;
        b=F6cdDH3QH5HBIirkwDG7GeplK3BXDavUf25e4DEozBYZX5Iu9ZV9VGK5QRHLbnvXCP
         Tg/LLYdrMfE46E6E6Q0ySAouKOJHEWmAEmRNX3VExWHXubnX8OXb7OsxixocQ31RjvkN
         MInk4JlYtKCxG8olJSHYiGh1ijXkQdquU8BGUkiTPFOpgKoZlruLKMReP/0Ofy7b0Kk5
         WBgSVFRMfSRt3iNHe2xHXfMDrwXJS46SobKXgLrr6irlznKC9beVBmzWZ1oBKXMa6pFR
         4z7QKWxDwaDr6fGigGWUDuorDXgaMCGeNSQ2YvtbvnpZlbcZrrpq9k5FENuCstGdksIz
         +zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JcVlap2DybYKMoXTnY18ziEJBU2JBRvgabCnv4g56Ws=;
        b=LRb8f2miX7jxU1hfYxx43+/HZ9PzpSmYj+NfpIDLAi8xGqTSKQ+cU0zKnNofFPOG8J
         1XkAecVsTKg2SHfV0z8MySsyPe3ERKtGdQPBwfGaO/qGiBplBTmtl1wEOpnvE298OP+C
         Vb/HR7y/rkgTA3bF/IgwDRW42nJhGAEoBim8gWWyh+uEDB6N+TDy4t5bqZthEItXO6cc
         rR8+vLgtxy85+0GEmwRbcPcSCH8lUiF3V+I7jW69jwcmRCo4JKJ1hoNR3Bd3TMvv/YTG
         /lltwauYdMkfGmvygPGAHinRuiPcg0EixtfXVVPQfKJP+wYu2inOIOtuqYnJKmnWJZNX
         Ck9Q==
X-Gm-Message-State: AOAM532CNdDY343UucPVkXH4vfmY+fH3wekhuwVIVaui+GWifskuKv/x
        F+kzSkTtX7X5CKP9S5Cor8g=
X-Google-Smtp-Source: ABdhPJz/147/p5pRjMNcfxpuHoZI/rUjniBLf/YtPhzP7c0nCEX8kvelkqDdWrXA405mrI6fwMVbQQ==
X-Received: by 2002:a17:90b:4f82:: with SMTP id qe2mr7891100pjb.128.1641443531869;
        Wed, 05 Jan 2022 20:32:11 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id 13sm636491pfm.161.2022.01.05.20.32.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jan 2022 20:32:11 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH v9 7/9] ls-tree.c: introduce struct "show_tree_data"
Date:   Thu,  6 Jan 2022 12:31:30 +0800
Message-Id: <725c4d01877fe4e03bbe27f50db0b33f07158d63.1641440700.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1794.g2ae0a9cb82
In-Reply-To: <cover.1641440700.git.dyroneteng@gmail.com>
References: <cover.1641440700.git.dyroneteng@gmail.com>
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
 builtin/ls-tree.c | 50 +++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 6b5e3ab9dd..12beb02423 100644
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
@@ -99,17 +107,15 @@ static int show_recursive(const char *base, size_t baselen,
 	return 0;
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
@@ -117,18 +123,18 @@ static int show_default(const struct object_id *oid, enum object_type type,
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
 
@@ -152,14 +158,20 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 {
 	int recursive = 0;
 	size_t baselen;
-	enum object_type type = OBJ_BLOB;
+	struct show_tree_data data = {
+		.mode = mode,
+		.type = OBJ_BLOB,
+		.oid = oid,
+		.pathname = pathname,
+		.base = base,
+	};
 
-	init_type(mode, &type);
+	init_type(mode, &data.type);
 	init_recursive(base, pathname, &recursive);
 
-	if (type == OBJ_TREE && recursive && !(ls_options & LS_SHOW_TREES))
+	if (data.type == OBJ_TREE && recursive && !(ls_options & LS_SHOW_TREES))
 		return recursive;
-	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
+	if (data.type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
 		return !READ_TREE_RECURSIVE;
 
 	if (shown_fields == FIELD_OBJECT_NAME) {
@@ -178,7 +190,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	}
 
 	if (shown_fields >= FIELD_DEFAULT)
-		show_default(oid, type, pathname, mode, base);
+		show_default(&data);
 
 	return recursive;
 }
-- 
2.33.0.rc1.1794.g2ae0a9cb82

