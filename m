Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5930BC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243205AbiCWJQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243094AbiCWJPc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:15:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB3775E56
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:14:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id j13so937138plj.8
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q/biLvqSFiqH9pmRg3/K8Zbz+ot4nD0sdObZwmVy9hE=;
        b=YZ13tXng5T00ifGKVVrcU8mhY6GfmEJ2HggNTTu58DC67/YaudkRw1jTse+F9awmdY
         /v2QVO9yprsv0LZajMfXVqf2kjQgOlLRbFhB/nSaXRBlsmbM+95F3o78/3hkOpYY79uo
         F7XjJwe8byHFG4vdR9SGt7dsXcoHCLGE4WfzL982UrMgdggVUI/l1tJ/yMF9KhCx4er4
         vhlbN3zbYlRqvWAhWRfgLh7Rw7lMzLB2TCZRMtERjdaxr8yihSvNM+6uqATuHSXzyF8b
         w0g33GNWMRRoj56wltnm/fi75Sfy9x4QrqIFW2Va3jX1LQ6GGQRi4HWl4EkabSW1PWe4
         KVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q/biLvqSFiqH9pmRg3/K8Zbz+ot4nD0sdObZwmVy9hE=;
        b=qDNKHOXaAyhHAWv9j4H3eqpHBnj0/MaJL7ZSN5MtOiauF9ZK1sAhD7eP/bdYX6UEmT
         ARVjrUsLkbv1NdOivHiOYkdyLdHqtUBwVLs9ea8KokbR7owiHqI6/8aB8u89o6MUw0nS
         z0iZcBEn9Qt8xCrSjW0BmcHRnkwV/lQP737/wKuZqNioKj3QMYtCS0jMUsgVsfui9xN5
         YgA/TZqKGD8xpacO3+blI9M9oETLRp5mdiblD1KtTRMDU/JzVDWndQZB6ez/34FY1ceo
         m7sI3FWX4b96r7+/9pyGy/LtbAMb4ZVqXh77rAEM+xlgQH8VnV9fvNfGQzlBSR446LmV
         ITBw==
X-Gm-Message-State: AOAM531LLuF9fzWcxB+2mZ1nQsfWDVwxxIMrBHtTl+R9ZyrqFZTSfz3P
        K8dYRmJRuCttQZFS9Ex90aI=
X-Google-Smtp-Source: ABdhPJzfclOozFltQ0uQ+E7n5JBdGwdyF7q7VZ0cE/LEN3q/NOMI/PT/5wGE3kU2RtsOvaNZVAytzQ==
X-Received: by 2002:a17:902:70cc:b0:154:1cc8:9df8 with SMTP id l12-20020a17090270cc00b001541cc89df8mr22934034plt.32.1648026842093;
        Wed, 23 Mar 2022 02:14:02 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:14:01 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v14 15/15] ls-tree: split up "fast path" callbacks
Date:   Wed, 23 Mar 2022 17:13:15 +0800
Message-Id: <55a96e933b0949bbf3f33153b8e370af6c6299bb.1648026472.git.dyroneteng@gmail.com>
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

Make the various if/else in the callbacks for the "fast path" a lot
easier to read by just using common functions for the parts that are
common, and have per-format callbacks for those parts that are
different.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 199 +++++++++++++++++++++++++++++-----------------
 1 file changed, 125 insertions(+), 74 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 6550f27dfe..44a91cf9d0 100644
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
-		(!ls_options || (ls_options & LS_RECURSIVE)
-		 || (ls_options & LS_SHOW_TREES)
-		 || (ls_options & LS_TREE_ONLY)))
-			 show_default(&data);
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
@@ -282,7 +331,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	struct object_id oid;
 	struct tree *tree;
 	int i, full_tree = 0;
-	read_tree_fn_t fn = show_tree;
+	read_tree_fn_t fn = NULL;
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -311,6 +360,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
+	struct ls_tree_cmdmode_to_fmt *m2f = ls_tree_cmdmode_format;
 
 	git_config(git_default_config, NULL);
 	ls_tree_prefix = prefix;
@@ -365,18 +415,19 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
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
+	while (m2f) {
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
+			m2f++;
+			continue;
 		}
+		break;
 	}
 
 	return !!read_tree(the_repository, tree, &pathspec, fn, NULL);
-- 
2.34.1.404.g92931a4a2c.dirty

