Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0538C433F5
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 13:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiAANvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 08:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiAANvX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 08:51:23 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A96C061574
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 05:51:23 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 8so25684275pfo.4
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 05:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5DcCLwX270d0k6rHYX3DZA8+GHP4G0iWpIVSGR+q9Xo=;
        b=EuivUkGxgEyfe60c41P9psO9q21B/YaRWb5yvtZDiir77kSlvrtxLWlVVJ8J9dfW/E
         T1QC4P4QvPusN8mLGmxxXXCNb6CefxAMe1EWuiznVkmA21NZA0Y4zyRT48XpaHVjDCMK
         OVJW+GDlJ6+d3enWi8njlRp8K2uTLcwCj0FmFvuNoINc3vcV/pPT2zso3mx5oMYR5CI3
         VmWfQWzZMJkGnxXmIV52WIWMOg8vAo2rXzvJQ27SAkxpn26EvARFbs7C5OpEBnc5Oq3q
         5Qawq/KUfEKZpxchq3QqifgiFHPfoeCMD0NaHl6DBazfc01lik8kpwM8O4M8s1NhuigB
         93MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5DcCLwX270d0k6rHYX3DZA8+GHP4G0iWpIVSGR+q9Xo=;
        b=XAprimuMgA1sRmQFREAk4Fr1VU1Ei5yS+Z/jQBg/gl9z+6UoDDTQaa+BneuIz0wWoI
         5hoYSkPToyqAnqPdTAzUFu0C8vJ75BLAzZWiiPppUI1pTk/ahTR2H+bPeLcRIaJKpDcn
         2H8CUtFoZHTXFzwmimmAzv8LhQM4onzg1ZUQZGG/e7TLLQtGQ/0DA41vHzfv4fs2UP0I
         ssjLrxApZhgqDRsNrqxGF7N9aF0I/O0aiI6gTF4iOgpSIzuujx7xRkSS8Rny/nQxbGNv
         3dbh3+r5sg6e0yror/OchHt+YuxMqewq9fn/fIr5tFulck9RQzPteWM++b2SWaQs8ooE
         2oFQ==
X-Gm-Message-State: AOAM532zLZLHX27XaJeojwCkQi7FFXOfmCUMHT7Q+f3/GddOPcY/pQ4s
        YOobDdCn+Nl8vJqNHQE6q1g=
X-Google-Smtp-Source: ABdhPJzuu2uifwvDVZ7MwHbuc0xs2s+cHQYl9ZUB7bqw6uZU4dQaursXhvEqaFfhsTLUDshdkSGK4w==
X-Received: by 2002:a63:413:: with SMTP id 19mr34551659pge.382.1641045082492;
        Sat, 01 Jan 2022 05:51:22 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.41])
        by smtp.gmail.com with ESMTPSA id o11sm34022039pfu.150.2022.01.01.05.51.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jan 2022 05:51:22 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 7/8] ls-tree.c: introduce struct "shown_data"
Date:   Sat,  1 Jan 2022 21:50:30 +0800
Message-Id: <296ebacafe4d40ffc5282aebb9fee972866c4ccc.1641043500.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1802.gbb1c3936fb.dirty
In-Reply-To: <cover.1641043500.git.dyroneteng@gmail.com>
References: <cover.1641043500.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"show_data" is a struct that packages the necessary fields for
reusing. This commit is a front-loaded commit for support
"--format" argument and does not affect any existing functionality.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 85ca7358ba..009ffeb15d 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -34,6 +34,14 @@ static unsigned int shown_bits;
 #define SHOW_MODE (1 << 4)
 #define SHOW_DEFAULT 29 /* 11101 size is not shown to output by default */
 
+struct shown_data {
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
@@ -98,17 +106,15 @@ static int show_recursive(const char *base, size_t baselen,
 	return 0;
 }
 
-static int show_default(const struct object_id *oid, enum object_type type,
-			const char *pathname, unsigned mode,
-			struct strbuf *base)
+static int show_default(struct shown_data *data)
 {
-	size_t baselen = base->len;
+	size_t baselen = data->base->len;
 
 	if (shown_bits & SHOW_SIZE) {
 		char size_text[24];
-		if (type == OBJ_BLOB) {
+		if (data->type == OBJ_BLOB) {
 			unsigned long size;
-			if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
+			if (oid_object_info(the_repository, data->oid, &size) == OBJ_BAD)
 				xsnprintf(size_text, sizeof(size_text), "BAD");
 			else
 				xsnprintf(size_text, sizeof(size_text),
@@ -116,18 +122,18 @@ static int show_default(const struct object_id *oid, enum object_type type,
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
 
@@ -154,11 +160,16 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 {
 	int retval = 0;
 	size_t baselen;
-	enum object_type type = OBJ_BLOB;
+	struct shown_data data = {
+		.mode = mode,
+		.type = OBJ_BLOB,
+		.oid = oid,
+		.pathname = pathname,
+		.base = base,
+	};
 
-	if (show_tree_init(&type, base, pathname, mode, &retval))
+	if (show_tree_init(&data.type, base, pathname, mode, &retval))
 		return retval;
-
 	if (!(shown_bits ^ SHOW_OBJECT_NAME)) {
 		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
 		return retval;
@@ -175,7 +186,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 
 	if (!(shown_bits ^ SHOW_DEFAULT) ||
 	    !(shown_bits ^ (SHOW_DEFAULT | SHOW_SIZE)))
-		show_default(oid, type, pathname, mode, base);
+		show_default(&data);
 
 	return retval;
 }
-- 
2.33.0.rc1.1802.gbb1c3936fb.dirty

