Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B69C46467
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350549AbiBHNOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350292AbiBHMPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 07:15:09 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1C6C03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 04:15:09 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x65so4023213pfx.12
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 04:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qoJ3meIlcealGFNuBKdJlsA7z7DtO3lQHLko6cPEYgw=;
        b=aaEtO/WQTCbLar4PTACn6dtI0SqPr0qosuiiGarSHbfNUIK1s9mp3pQgzEYGzyXxK3
         7QLEq+jTErwM1bm6HTsE+bgHQcvTrm+25Y7VGPqVVKFPPhPpQM2n0u7nM4G5ELl0Gidv
         mPzlYkKXbkOEiyZOcbI7K6ybPLtbfdl/3zHz6ODqF3c3wn3fUDYiaC7dR9NK2Fop8Zw8
         FEoO8uQYT35nuvF7pVrD/cNMAy8T9VbsARTsPmkYUGF5BD6gQPkFtenLnbZ5Ey/cQ2QU
         5zGdRjjabkjBz7EUAHw4sIjyHjGujCVGrdBilcFAjaF076CKx02+fBtI9dzJghTRChkI
         T8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qoJ3meIlcealGFNuBKdJlsA7z7DtO3lQHLko6cPEYgw=;
        b=P1s8EcprIYU5zpL5zOxek0L+QQvSMIDKYEpobhkeKfT5+E/nyR5T2Cb0CdalKGLdPq
         qCSDjgHT91C9KgAE+7mDWhyW0XtfQ1mjSYONbgwGbjGc+9+rG8MltWdSdEhPUFS2uxzL
         Dyu0PQpV9q0ECZJ72y6sB4xxLfxmnTwarsTOcT+mn+Acg+dc9zyDr96sau/N2QSCDDwz
         gBpwToXoJJlpDHN78rfCeVln/Ghsyxw/f51DOYt8vsnXFXAvUU/2CczaDZ/atcGd7c7L
         1NcqS+7en+WeR/lY5T2ctmLKVAv1ccZS0X3hpE8xEptTqQ00Dm9/4uEg/wi9G1KLeVYx
         DIwA==
X-Gm-Message-State: AOAM531oOQaBegPYB0cvaDg1yISaoPTz8/CN1erdlWU+eTbMuzUODeSx
        9eTgAb89BfXrTRaKzPu/CnE=
X-Google-Smtp-Source: ABdhPJyHpGqTNPlJuEEqt76vac5Rr8KaqiWW4Z5MfJMc4HpMT046f9E3KhMcGibwHA/lKRu6V0ddhw==
X-Received: by 2002:a63:69c1:: with SMTP id e184mr3237479pgc.495.1644322508921;
        Tue, 08 Feb 2022 04:15:08 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id t3sm16973344pfg.28.2022.02.08.04.15.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:15:08 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v11 09/13] ls-tree: introduce struct "show_tree_data"
Date:   Tue,  8 Feb 2022 20:14:34 +0800
Message-Id: <46e10a5392ace1b1caef1eb8f7dfc4b60779ff55.1644319434.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.403.gb35f2687cf.dirty
In-Reply-To: <cover.1644319434.git.dyroneteng@gmail.com>
References: <cover.1644319434.git.dyroneteng@gmail.com>
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
 builtin/ls-tree.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 8baab7c83e..293b8f9dfb 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -34,6 +34,14 @@ static unsigned int shown_fields;
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
@@ -93,17 +101,15 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
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
@@ -111,18 +117,18 @@ static int show_default(const struct object_id *oid, enum object_type type,
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
 
@@ -132,6 +138,13 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
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
 
 	if (type == OBJ_TREE && show_recursive(base->buf, base->len, pathname))
 		recurse = READ_TREE_RECURSIVE;
@@ -151,7 +164,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	}
 
 	if (shown_fields >= FIELD_DEFAULT)
-		show_default(oid, type, pathname, mode, base);
+		show_default(&data);
 
 	return recurse;
 }
-- 
2.34.1.403.gb35f2687cf.dirty

