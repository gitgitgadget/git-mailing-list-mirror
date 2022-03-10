Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC810C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbiCJN6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242613AbiCJN6R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:58:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E6014FFE8
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:16 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k24so8100804wrd.7
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G7bL6ceVt6iAEb99wmEoga3LhCUbEOglmpmv1Xai/FA=;
        b=Jl9HOWGKfCRsSnPe1GRKKETGAjCELinDQq0wOVBvsSw4a/RvkAqtMDSTSQnuw1M+DP
         IJA1nM3sHXByQVBb3IDMdhslOBJWB3n5Gax0hR+ZtaXvfX5Eh3EBwYMsUJmxmAFWh3nA
         GKgRB0wl42RO2C88djcNezAwVb/A+vJD+8h4TVNZiD/zwncm0dhLco9eVsxaoSFntapX
         mc+/uEk08RQWNbx/8ImnhIhlpBGy97WNBALGbkRjFgVvegZw2nDwVtmXiwk9Vhy+FAyO
         8JfANpIGw9D8MxkoLRvOct+avgLrQ/WYJumcN9Gcj2vEvDrdPykw9ypsYbFiHCHxSNLu
         PtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7bL6ceVt6iAEb99wmEoga3LhCUbEOglmpmv1Xai/FA=;
        b=qsb8eeIhF/FLcp7hz6R7f1MO2/VEPTu49fAkQMW5UsmYVj81JItZ4XRukB19P/KUUK
         LH0mTJ/05VW6xvNEaw9IoAqEO+NyxVhTPqletoH9ueTfx72+gJ3LuMd4rPVzuzvGdmX+
         QA0HWOj3wkbMPc0/HcVBR2MNcla+2UN6XZ+XXc1hhV/Ims80XNpbYQQR1A3vrR2SaLHV
         Gffm8Sia1ffPRGqRoYuUp8ei7dg77wPwA/2R+QZTGHqZgg47DhsI7Vs2GEypKqN1zb01
         9BIVQqTWtE6OQvrVygWUUfAhc5pxVmbC57xc6zb24bzThR9kYaLyVXe9UVjeDpINNbN6
         vUkg==
X-Gm-Message-State: AOAM533TcpJc+OuqsmgFkn2MKva5u4Y5YcAQrzfa6Ad8knlo/qtczbER
        k5Zi0WqH3Of1wFCnq5vCRzO845qRx8RsUg==
X-Google-Smtp-Source: ABdhPJxcfl9fpA3lFe6lZHtGQ1ivqeLDWOXHExZ9Dxz0wjY0hrQfzOjIPQoZNq2n7OHm5ddFWKNjmA==
X-Received: by 2002:adf:fcd0:0:b0:1ef:31fe:d08e with SMTP id f16-20020adffcd0000000b001ef31fed08emr3559490wrs.667.1646920634517;
        Thu, 10 Mar 2022 05:57:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm7737162wmc.22.2022.03.10.05.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:57:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>, Johannes.Schindelin@gmx.de,
        congdanhqx@gmail.com, tenglong.tl@alibaba-inc.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/REVIEW 7/7] ls-tree: split up "fast path" callbacks
Date:   Thu, 10 Mar 2022 14:57:03 +0100
Message-Id: <patch-7.7-9ce70bae078-20220310T134811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com> <cover-0.7-00000000000-20220310T134811Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the various if/else in the callbacks for the "fast path" a lot
easier to read by just using common functions for the parts that are
common, and have per-format callbacks for those parts that are
different.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 198 +++++++++++++++++++++++++++++-----------------
 1 file changed, 124 insertions(+), 74 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 820baddf9a9..ee69b8c2702 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -173,108 +173,157 @@ static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
 	return recurse;
 }
 
-static int show_default(struct show_tree_data *data)
+static int show_tree_common(struct show_tree_data *data, int *recurse,
+			    const struct object_id *oid, struct strbuf *base,
+			    const char *pathname, unsigned mode)
 {
-	size_t baselen = data->base->len;
-
-	if (cmdmode == MODE_LONG) {
-		char size_text[24];
-		if (data->type == OBJ_BLOB) {
-			unsigned long size;
-			if (oid_object_info(the_repository, data->oid, &size) == OBJ_BAD)
-				xsnprintf(size_text, sizeof(size_text), "BAD");
-			else
-				xsnprintf(size_text, sizeof(size_text),
-					  "%" PRIuMAX, (uintmax_t)size);
-		} else {
-			xsnprintf(size_text, sizeof(size_text), "-");
-		}
-		printf("%06o %s %s %7s\t", data->mode, type_name(data->type),
-		find_unique_abbrev(data->oid, abbrev), size_text);
-	} else {
-		printf("%06o %s %s\t", data->mode, type_name(data->type),
-		find_unique_abbrev(data->oid, abbrev));
-	}
-	baselen = data->base->len;
-	strbuf_addstr(data->base, data->pathname);
-	write_name_quoted_relative(data->base->buf,
-				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
-				   line_termination);
-	strbuf_setlen(data->base, baselen);
-	return 1;
-}
-
-static int show_tree(const struct object_id *oid, struct strbuf *base,
-		const char *pathname, unsigned mode, void *context)
-{
-	int recurse = 0;
-	size_t baselen;
 	enum object_type type = object_type(mode);
-	struct show_tree_data data = {
-		.mode = mode,
-		.type = type,
-		.oid = oid,
-		.pathname = pathname,
-		.base = base,
-	};
+	int ret = -1;
+
+	*recurse = 0;
+	data->mode = mode;
+	data->type = type;
+	data->oid = oid;
+	data->pathname = pathname;
+	data->base = base;
 
 	if (type == OBJ_BLOB) {
 		if (ls_options & LS_TREE_ONLY)
-			return 0;
+			ret = 0;
 	} else if (type == OBJ_TREE &&
 		   show_recursive(base->buf, base->len, pathname)) {
-		recurse = READ_TREE_RECURSIVE;
+		*recurse = READ_TREE_RECURSIVE;
 		if (!(ls_options & LS_SHOW_TREES))
-			return recurse;
+			ret = *recurse;
 	}
 
-	if (cmdmode == MODE_OBJECT_ONLY) {
-		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
-		return recurse;
-	}
+	return ret;
+}
 
-	if (cmdmode == MODE_NAME_ONLY) {
-		baselen = base->len;
-		strbuf_addstr(base, pathname);
-		write_name_quoted_relative(base->buf,
-					   chomp_prefix ? ls_tree_prefix : NULL,
-					   stdout, line_termination);
-		strbuf_setlen(base, baselen);
-		return recurse;
+static void show_tree_common_default_long(struct strbuf *base,
+					  const char *pathname,
+					  const size_t baselen)
+{
+	strbuf_addstr(base, pathname);
+	write_name_quoted_relative(base->buf,
+				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
+				   line_termination);
+	strbuf_setlen(base, baselen);
+}
+
+static int show_tree_default(const struct object_id *oid, struct strbuf *base,
+			     const char *pathname, unsigned mode,
+			     void *context)
+{
+	int early;
+	int recurse;
+	struct show_tree_data data = { 0 };
+
+	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	if (early >= 0)
+		return early;
+
+	printf("%06o %s %s\t", data.mode, type_name(data.type),
+	       find_unique_abbrev(data.oid, abbrev));
+	show_tree_common_default_long(base, pathname, data.base->len);
+	return recurse;
+}
+
+static int show_tree_long(const struct object_id *oid, struct strbuf *base,
+			  const char *pathname, unsigned mode, void *context)
+{
+	int early;
+	int recurse;
+	struct show_tree_data data = { 0 };
+	char size_text[24];
+
+	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	if (early >= 0)
+		return early;
+
+	if (data.type == OBJ_BLOB) {
+		unsigned long size;
+		if (oid_object_info(the_repository, data.oid, &size) == OBJ_BAD)
+			xsnprintf(size_text, sizeof(size_text), "BAD");
+		else
+			xsnprintf(size_text, sizeof(size_text),
+				  "%" PRIuMAX, (uintmax_t)size);
+	} else {
+		xsnprintf(size_text, sizeof(size_text), "-");
 	}
 
-	if (cmdmode == MODE_LONG ||
-	    (!ls_options || (ls_options & LS_RECURSIVE)
-	     || (ls_options & LS_SHOW_TREES)
-	     || (ls_options & LS_TREE_ONLY)))
-		show_default(&data);
+	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
+	       find_unique_abbrev(data.oid, abbrev), size_text);
+	show_tree_common_default_long(base, pathname, data.base->len);
+	return 1;
+}
 
+static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
+			       const char *pathname, unsigned mode, void *context)
+{
+	int early;
+	int recurse;
+	const size_t baselen = base->len;
+	struct show_tree_data data = { 0 };
+
+	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	if (early >= 0)
+		return early;
+
+	strbuf_addstr(base, pathname);
+	write_name_quoted_relative(base->buf,
+				   chomp_prefix ? ls_tree_prefix : NULL,
+				   stdout, line_termination);
+	strbuf_setlen(base, baselen);
+	return recurse;
+}
+
+static int show_tree_object(const struct object_id *oid, struct strbuf *base,
+			    const char *pathname, unsigned mode, void *context)
+{
+	int early;
+	int recurse;
+	struct show_tree_data data = { 0 };
+
+	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	if (early >= 0)
+		return early;
+
+	printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
 	return recurse;
 }
 
 struct ls_tree_cmdmode_to_fmt {
 	enum ls_tree_cmdmode mode;
 	const char *const fmt;
+	read_tree_fn_t fn;
 };
 
 static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[] = {
 	{
 		.mode = MODE_DEFAULT,
 		.fmt = "%(objectmode) %(objecttype) %(objectname)%x09%(path)",
+		.fn = show_tree_default,
 	},
 	{
 		.mode = MODE_LONG,
 		.fmt = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)",
+		.fn = show_tree_long,
 	},
 	{
 		.mode = MODE_NAME_ONLY, /* And MODE_NAME_STATUS */
 		.fmt = "%(path)",
+		.fn = show_tree_name_only,
 	},
 	{
 		.mode = MODE_OBJECT_ONLY,
 		.fmt = "%(objectname)",
+		.fn = show_tree_object
+	},
+	{
+		/* fallback */
+		.fn = show_tree_default,
 	},
-	{ 0 },
 };
 
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
@@ -283,7 +332,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	struct tree *tree;
 	int i, full_tree = 0;
 	unsigned int shown_fields = 0;
-	read_tree_fn_t fn = show_tree;
+	read_tree_fn_t fn = NULL;
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -312,6 +361,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
+	struct ls_tree_cmdmode_to_fmt *m2f = ls_tree_cmdmode_format;
 
 	git_config(git_default_config, NULL);
 	ls_tree_prefix = prefix;
@@ -367,18 +417,18 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	 * The generic show_tree_fmt() is slower than show_tree(), so
 	 * take the fast path if possible.
 	 */
-	if (format) {
-		struct ls_tree_cmdmode_to_fmt *m2f;
-
-		fn = show_tree_fmt;
-		for (m2f = ls_tree_cmdmode_format; m2f->fmt; m2f++) {
-			if (strcmp(format, m2f->fmt))
-				continue;
-
+	while (m2f++) {
+		if (!m2f->fmt) {
+			fn = format ? show_tree_fmt : show_tree_default;
+		} else if (format && !strcmp(format, m2f->fmt)) {
 			cmdmode = m2f->mode;
-			fn = show_tree;
-			break;
+			fn = m2f->fn;
+		} else if (!format && cmdmode == m2f->mode) {
+			fn = m2f->fn;
+		} else {
+			continue;
 		}
+		break;
 	}
 
 	return !!read_tree(the_repository, tree, &pathspec, fn, &shown_fields);
-- 
2.35.1.1295.g6b025d3e231

