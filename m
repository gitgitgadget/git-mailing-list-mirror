Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9DAC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 13:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244681AbiFCNiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 09:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiFCNh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 09:37:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DDD1274A
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 06:37:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a15so1917262wrh.2
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 06:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C3VeTaSpsyjNjv445FZ5ATeKLyQuS87OAVtCJM+JQzE=;
        b=gwz9fhnrdoKLIUT0oAESv6azER0Z19kGSMr+5boJZslpIgxkPPe+xryMTjdtVu0Lw8
         WJT+2bCl7NxIOf4EM3+YMelv8UhwIhuCCAerNDVD5MlP4n1ejAPD7bztPFshNc2KEvwn
         QNAzHtgmNpm5iIJ+ZhWKbXLOaHgS4e2lSD/e4maBrTHVfi0iFXAAsgdnQFAwVKLH6ipC
         HFJ3ecNVM/dr9HCyRTuI/w/hKHmpCP6HuagA0n0OxklI2rgxjMiLRnzCLKxaHcDy5FBc
         iZqiezvCscYWGKzEHSLDDJzSuq2AFrvDxbMif+ecvyLp8iHsjFOa6kL9YYOW2w4FctZZ
         HcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C3VeTaSpsyjNjv445FZ5ATeKLyQuS87OAVtCJM+JQzE=;
        b=dGD6iqirJlv2A3YU8vnOAN4rbDwv87HPPSkmuDV9ivRNUhqTafGKntl+7gk6qoMnbW
         S73I+GQSScbCEikehcyHnJWG+x5bYVcLy1KpvTeob51FdXxkm87zYLRONW5zx4KwTPO2
         pYWOzoI5iYSinrktgqkMARsZnJrnS659SZ2nAw0Z0vNTfXefrBckbMrXHKfSeX8EDek+
         wEMrm4sQ45KQQP7uhUeAfL49+I8sx5aW5C66oxh/BpIz6SvuDRC0G59X7X63BsjxjxAb
         Pc7wkXNja920c1/0u8yY+zneUNNliC46qwmZow7pujyZWkSXBzAddVvKi/KEiTQFMIuY
         ZCkQ==
X-Gm-Message-State: AOAM530bLj+ORrx7kgJ+PvBSK1XuLggrI0HlBEeVGu8DhMAyNgJmdyK+
        4zNNMGha/WJQ0kNFCgFdGsI+NO3/in+MxkbJ
X-Google-Smtp-Source: ABdhPJw2f2bJrNlqgUr2Q4UNxjuqoKfbNjtYc2uxLt+3zRvQDbbpov4KdPeXK5oDxIPlj1nD3bAOuA==
X-Received: by 2002:adf:fe52:0:b0:210:12ab:76e6 with SMTP id m18-20020adffe52000000b0021012ab76e6mr8402205wrs.120.1654263475466;
        Fri, 03 Jun 2022 06:37:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16-20020a5d4690000000b00213b5fb3798sm3381228wrq.15.2022.06.03.06.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:37:54 -0700 (PDT)
Message-Id: <4f9f34876413927d819313a70fcdefcad5b35689.1654263472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Jun 2022 13:37:49 +0000
Subject: [PATCH 1/4] log-tree: create for_each_decoration()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It can be helpful to iterate through all the decorations on a commit
without necessarily writing them to a stream. Implement
for_each_decoration() and reimplement format_decorations_extended() to
use that iterator.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 log-tree.c | 111 ++++++++++++++++++++++++++++++++++++-----------------
 log-tree.h |   4 ++
 2 files changed, 80 insertions(+), 35 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index d0ac0a6327a..b15a7c9db22 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -282,6 +282,54 @@ static void show_name(struct strbuf *sb, const struct name_decoration *decoratio
 		strbuf_addstr(sb, decoration->name);
 }
 
+struct format_decorations_context {
+	struct strbuf *sb;
+	int use_color;
+	const char *prefix;
+	const char *separator;
+	const char *suffix;
+	const char *color_commit;
+	const char *color_reset;
+	const struct name_decoration *current_and_HEAD;
+};
+
+static int append_decoration(const struct name_decoration *d,
+			     void *data)
+{
+	struct format_decorations_context *ctx = data;
+	/*
+	 * When both current and HEAD are there, only
+	 * show HEAD->current where HEAD would have
+	 * appeared, skipping the entry for current.
+	 */
+	if (d != ctx->current_and_HEAD) {
+		strbuf_addstr(ctx->sb, ctx->color_commit);
+		strbuf_addstr(ctx->sb, ctx->prefix);
+		strbuf_addstr(ctx->sb, ctx->color_reset);
+		strbuf_addstr(ctx->sb, decorate_get_color(ctx->use_color, d->type));
+		if (d->type == DECORATION_REF_TAG)
+			strbuf_addstr(ctx->sb, "tag: ");
+
+		show_name(ctx->sb, d);
+
+		if (ctx->current_and_HEAD &&
+		    d->type == DECORATION_REF_HEAD) {
+			strbuf_addstr(ctx->sb, " -> ");
+			strbuf_addstr(ctx->sb, ctx->color_reset);
+			strbuf_addstr(ctx->sb,
+				      decorate_get_color(
+						ctx->use_color,
+						ctx->current_and_HEAD->type));
+			show_name(ctx->sb, ctx->current_and_HEAD);
+		}
+		strbuf_addstr(ctx->sb, ctx->color_reset);
+
+		ctx->prefix = ctx->separator;
+	}
+
+	return 0;
+}
+
 /*
  * The caller makes sure there is no funny color before calling.
  * format_decorations_extended makes sure the same after return.
@@ -294,49 +342,42 @@ void format_decorations_extended(struct strbuf *sb,
 			const char *suffix)
 {
 	const struct name_decoration *decoration;
-	const struct name_decoration *current_and_HEAD;
-	const char *color_commit =
-		diff_get_color(use_color, DIFF_COMMIT);
-	const char *color_reset =
-		decorate_get_color(use_color, DECORATION_NONE);
+	struct format_decorations_context ctx = {
+		.sb = sb,
+		.use_color = use_color,
+		.prefix = prefix,
+		.separator = separator,
+		.suffix = suffix,
+		.color_commit =	diff_get_color(use_color, DIFF_COMMIT),
+		.color_reset = decorate_get_color(use_color, DECORATION_NONE),
+	};
 
 	decoration = get_name_decoration(&commit->object);
 	if (!decoration)
 		return;
 
-	current_and_HEAD = current_pointed_by_HEAD(decoration);
-	while (decoration) {
-		/*
-		 * When both current and HEAD are there, only
-		 * show HEAD->current where HEAD would have
-		 * appeared, skipping the entry for current.
-		 */
-		if (decoration != current_and_HEAD) {
-			strbuf_addstr(sb, color_commit);
-			strbuf_addstr(sb, prefix);
-			strbuf_addstr(sb, color_reset);
-			strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
-			if (decoration->type == DECORATION_REF_TAG)
-				strbuf_addstr(sb, "tag: ");
-
-			show_name(sb, decoration);
-
-			if (current_and_HEAD &&
-			    decoration->type == DECORATION_REF_HEAD) {
-				strbuf_addstr(sb, " -> ");
-				strbuf_addstr(sb, color_reset);
-				strbuf_addstr(sb, decorate_get_color(use_color, current_and_HEAD->type));
-				show_name(sb, current_and_HEAD);
-			}
-			strbuf_addstr(sb, color_reset);
+	ctx.current_and_HEAD = current_pointed_by_HEAD(decoration);
 
-			prefix = separator;
-		}
+	for_each_decoration(commit, append_decoration, &ctx);
+
+	strbuf_addstr(sb, ctx.color_commit);
+	strbuf_addstr(sb, ctx.suffix);
+	strbuf_addstr(sb, ctx.color_reset);
+}
+
+int for_each_decoration(const struct commit *c, decoration_fn fn, void *data)
+{
+	const struct name_decoration *decoration;
+
+	decoration = get_name_decoration(&c->object);
+	while (decoration) {
+		int res;
+		if ((res = fn(decoration, data)))
+			return res;
 		decoration = decoration->next;
 	}
-	strbuf_addstr(sb, color_commit);
-	strbuf_addstr(sb, suffix);
-	strbuf_addstr(sb, color_reset);
+
+	return 0;
 }
 
 void show_decorations(struct rev_info *opt, struct commit *commit)
diff --git a/log-tree.h b/log-tree.h
index e7e4641cf83..ea07da2625b 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -35,4 +35,8 @@ void fmt_output_commit(struct strbuf *, struct commit *, struct rev_info *);
 void fmt_output_subject(struct strbuf *, const char *subject, struct rev_info *);
 void fmt_output_email_subject(struct strbuf *, struct rev_info *);
 
+typedef int decoration_fn(const struct name_decoration *d,
+			  void *data);
+int for_each_decoration(const struct commit *c, decoration_fn fn, void *data);
+
 #endif
-- 
gitgitgadget

