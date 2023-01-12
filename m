Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C439C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 09:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbjALJUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 04:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240314AbjALJTy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 04:19:54 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D608E55665
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:11:55 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i65so9875237pfc.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 01:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJp6tC+Xif0aSR9Zczbm75OWJSTLCCvZNGx+/VKW72I=;
        b=fTPVOQujzIpcFdUx1CFh49e72E85WBbAdIY57JGz3oC1jii7UAoTjSnAY2gNZ6kBFW
         Iz2bonaJY7xbHZhPZQqyYKM/UmUTZug+uOqHE575pAwMjaju/1Wy0n6B3gex29fwJj9j
         nbGF917pmJB3vAMZud5zPekv/TzYqlwvIzhLzJDnWcGPHkTWTLJFOeQHrvfMzyTwIUuD
         Qi5koJRGLsxzStr67bAwrXtF1gMr0cBXm8GSpdFyEjcXL0oQAdEqF5dezBIdl8+oOCbk
         NBPfDPXRpU2dHBnKFZMNcwtPhLyvUDvS/zrjV+DjH2nI3IpZoWO6w8XFO/N6LwLepoZw
         +gAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJp6tC+Xif0aSR9Zczbm75OWJSTLCCvZNGx+/VKW72I=;
        b=bPoup54IYwFUv4giTKpnZGM0x2ibaHm7m5D/jP1HUUGwiMDYdWqs1kxTkdYe8wuZ/Z
         xYb8ubhNJWHZmyewqW5KEZBMYf1i0RlU3qu0OmhNhzuvx/wnFEE+NWYKk91Q1xxiSyH+
         /2cw8DCWYx/CzsqTE4eaq5JhV+55v2DrJ1eNV1V0D/aQmBU9y8bHIOztfLS6jEDYwwE0
         nM3NR7G5+2LHsZvQYRIZzT952ObxTnWN0fZsrpLVVo8/uH8MWKNN6QM6XkMefzC8Gs8j
         U0674FE84rv8kIzcit+NLhbowEMJOZhAHZNSYfR8csNRpyOVl/y1nKkkGLRovk9yJqEF
         zICA==
X-Gm-Message-State: AFqh2koZxNmcXiAwVO8/aVKvSOfXEmz9ec4jdhE4wVCE0nDpxhP9smCb
        Mf6bP3RVG/gbAWNL6y10N7/xzkaQnIvgf9Vf
X-Google-Smtp-Source: AMrXdXscSVK+Hc//1K7RMvKHaFb5A6g1yHkyLx1tp9j6+mTYsYSrKGUHHA66zk6VU94maINu4ID/RQ==
X-Received: by 2002:a62:1b58:0:b0:581:4ab0:abcd with SMTP id b85-20020a621b58000000b005814ab0abcdmr5491574pfb.14.1673514715018;
        Thu, 12 Jan 2023 01:11:55 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id d126-20020a623684000000b0058426d9db66sm11257069pfa.218.2023.01.12.01.11.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2023 01:11:54 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dyroneteng@gmail.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH 4/6] ls-tree: make "line_termination" less generic
Date:   Thu, 12 Jan 2023 17:11:33 +0800
Message-Id: <20230112091135.20050-5-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.98.g174eaa53973.dirty
In-Reply-To: <20230112091135.20050-1-tenglong.tl@alibaba-inc.com>
References: <20230112091135.20050-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The "ls-tree" command isn't capable of ending "lines" with anything
except '\n' or '\0', and in the latter case we can avoid calling
write_name_quoted_relative() entirely. Let's do that, less for
optimization and more for clarity, the write_name_quoted_relative()
API itself does much the same thing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 58 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index da664eecfb9..a743959f2b3 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -39,7 +39,7 @@ static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
 }
 
 struct ls_tree_options {
-	int line_termination;
+	unsigned null_termination:1;
 	int abbrev;
 	enum ls_tree_path_options {
 		LS_RECURSIVE = 1 << 0,
@@ -166,7 +166,7 @@ static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
 
 	baselen = base->len;
 	strbuf_expand(&sb, options->format, expand_show_tree, &cb_data);
-	strbuf_addch(&sb, options->line_termination);
+	strbuf_addch(&sb, options->null_termination ? '\0' : '\n');
 	fwrite(sb.buf, sb.len, 1, stdout);
 	strbuf_release(&sb);
 	strbuf_setlen(base, baselen);
@@ -198,10 +198,22 @@ static void show_tree_common_default_long(struct ls_tree_options *options,
 					  const char *pathname,
 					  const size_t baselen)
 {
+	const char *prefix = options->chomp_prefix ? options->ls_tree_prefix : NULL;
+
 	strbuf_addstr(base, pathname);
-	write_name_quoted_relative(base->buf,
-				   options->chomp_prefix ? options->ls_tree_prefix : NULL, stdout,
-				   options->line_termination);
+
+	if (options->null_termination) {
+		struct strbuf sb = STRBUF_INIT;
+		const char *name = relative_path(base->buf, prefix, &sb);
+
+		fputs(name, stdout);
+		fputc('\0', stdout);
+
+		strbuf_release(&sb);
+	} else {
+		write_name_quoted_relative(base->buf, prefix, stdout, '\n');
+	}
+
 	strbuf_setlen(base, baselen);
 }
 
@@ -264,15 +276,25 @@ static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
 	int recurse;
 	const size_t baselen = base->len;
 	enum object_type type = object_type(mode);
+	const char *prefix;
 
 	early = show_tree_common(options, &recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
+	prefix = options->chomp_prefix ? options->ls_tree_prefix : NULL;
 	strbuf_addstr(base, pathname);
-	write_name_quoted_relative(base->buf,
-				   options->chomp_prefix ? options->ls_tree_prefix : NULL,
-				   stdout, options->line_termination);
+	if (options->null_termination) {
+		struct strbuf sb = STRBUF_INIT;
+		const char *name = relative_path(base->buf, prefix, &sb);
+
+		fputs(name, stdout);
+		fputc('\0', stdout);
+
+		strbuf_release(&sb);
+	} else {
+		write_name_quoted_relative(base->buf, prefix, stdout, '\n');
+	}
 	strbuf_setlen(base, baselen);
 	return recurse;
 }
@@ -285,12 +307,19 @@ static int show_tree_object(const struct object_id *oid, struct strbuf *base,
 	int early;
 	int recurse;
 	enum object_type type = object_type(mode);
+	const char *str;
 
 	early = show_tree_common(options, &recurse, base, pathname, type);
 	if (early >= 0)
 		return early;
 
-	printf("%s%c", find_unique_abbrev(oid, options->abbrev), options->line_termination);
+	str = find_unique_abbrev(oid, options->abbrev);
+	if (options->null_termination) {
+		fputs(str, stdout);
+		fputc('\0', stdout);
+	} else  {
+		puts(str);
+	}
 	return recurse;
 }
 
@@ -342,9 +371,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	int i, full_tree = 0;
 	read_tree_fn_t fn = NULL;
 	enum ls_tree_cmdmode cmdmode = MODE_DEFAULT;
-	struct ls_tree_options options = {
-		.line_termination = '\n',
-	};
+	int null_termination = 0;
+	struct ls_tree_options options = { 0 };
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &options.ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -352,8 +380,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			LS_RECURSIVE),
 		OPT_BIT('t', NULL, &options.ls_options, N_("show trees when recursing"),
 			LS_SHOW_TREES),
-		OPT_SET_INT('z', NULL, &options.line_termination,
-			    N_("terminate entries with NUL byte"), 0),
+		OPT_BOOL('z', NULL, &null_termination,
+			 N_("terminate entries with NUL byte")),
 		OPT_CMDMODE('l', "long", &cmdmode, N_("include object size"),
 			    MODE_LONG),
 		OPT_CMDMODE(0, "name-only", &cmdmode, N_("list only filenames"),
@@ -383,6 +411,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, ls_tree_options,
 			     ls_tree_usage, 0);
+	options.null_termination = null_termination;
+
 	if (full_tree) {
 		options.ls_tree_prefix = prefix = NULL;
 		options.chomp_prefix = 0;
-- 
2.39.0.98.g174eaa53973.dirty

