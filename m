Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65D8EB64D9
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 11:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjGLLHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 07:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGLLHt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 07:07:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4581E94
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 04:07:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3142ee41fd2so6861940f8f.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 04:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689160066; x=1691752066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1amlZAD676RuBm8/Xt+LYkd/Dls55Txw4Sbv6LfZ8xs=;
        b=XLVumPfCw4IF5Cx9JVprsPGvbkXJ1Unx2NNdld4/uTQQ44QSDz/6vGnhbNMRjI+/Zj
         YiI65tPpQAyB06SO86/kqwWUvoh/GKCvjekXYG2tUTivbR4/v9Hu/cnlH6HjYRAxSDAR
         XUMXwXkLhVEPgiQsGLkxn3zGCif1qaUMxyNDU4Y3EEH/EWNbR34Ye2cW/9PQ3FRrhL7D
         38TLMjxqMVhXQTTkxeNPXcoA50VXLRp8mMceLt6D5cgjycVb0wsuwe5O71hvit2X/RGI
         dj8y17QmWkp4dDpMNfYSnn+MBn4rLDA3kkXFJWWvWDlS5xdX+0tZnzIo0/nTpz+gdbgD
         04mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689160066; x=1691752066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1amlZAD676RuBm8/Xt+LYkd/Dls55Txw4Sbv6LfZ8xs=;
        b=evH8hC4/X5AifoE/bP0zzeTeZsdaONm9o6w7MZFojYZlmo256MHAutNETE48CU8vOV
         rO+a7Iacf78NVs2jS/QjPCO0DhYwsNtqRMZ1gBE5cnyfAoL9uAp+ucuVnJMJHzh9sLdN
         FJbRd0kRbhcTuGfVJGxEGqfSjBWRt0fVA/qOtEuM06PxP8nRKBzi+Y2/v/gW9h+TqVps
         ARe6hB7QO3D2J6QWhrXsYFK7opImIGxY54DrJoI10GBLMURwp/JmITx5SVxqZ4DBucFD
         7PxA1fS3QxkCzbIPdT5WhrsLfGIUBAKqz2zfqa0Osp25SOtxdnOsc8wOY4mGZXwRUzJL
         UX7g==
X-Gm-Message-State: ABy/qLaf4OSjXOLxnMxkrLkjt8R/ji/Kyda/1hG+uwhEJtqvtOoPLsPe
        Qr98Rc8YXwwbv0KZNcrA7KT95H+FotQ=
X-Google-Smtp-Source: APBJJlE5vdpRvKqRGHya2ZF5YkqEIZvWavFdrMCY10T6odNOE/5CWVTbH8WXLxqAPx9R6+rxleIQbw==
X-Received: by 2002:a05:6000:150:b0:306:46c4:d313 with SMTP id r16-20020a056000015000b0030646c4d313mr15910132wrx.28.1689160065412;
        Wed, 12 Jul 2023 04:07:45 -0700 (PDT)
Received: from localhost.localdomain (host-92-6-81-118.as13285.net. [92.6.81.118])
        by smtp.gmail.com with ESMTPSA id k4-20020a056000004400b00314326c91e2sm4825278wrx.28.2023.07.12.04.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:07:44 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH] pretty: add %r format specifier for showing refs
Date:   Wed, 12 Jul 2023 12:07:32 +0100
Message-ID: <20230712110732.8274-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This lists refs similarly to the %D decoration format, but separates
the refs with spaces only and omits "tag:" annotations. It's intended
primarily for color output, where tags are already distinguished by
color.

Refactor format_decorations() to take an enum decoration_format argument
that determines the prefix, separator and suffix as well as the tag
annotation.

For %d and %D, wrap the "tag:" annotation and the actual tag in separate
color controls, because otherwise the tag ends up uncolored when %w
width formatting breaks a line between the annotation and tag.

Amend t4207-log-decoration-colors.sh to reflect the added color
controls, and t4202-log.sh to test the %r format.
---
 Documentation/pretty-formats.txt |  3 +-
 log-tree.c                       | 52 +++++++++++++++++++++-----------
 log-tree.h                       | 15 ++++-----
 pretty.c                         |  7 +++--
 t/t4202-log.sh                   |  7 ++++-
 t/t4207-log-decoration-colors.sh | 22 +++++++-------
 6 files changed, 67 insertions(+), 39 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 3b71334459..d2ae898c79 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -221,7 +221,8 @@ The placeholders are:
 '%ch':: committer date, human style (like the `--date=human` option of
 	linkgit:git-rev-list[1])
 '%d':: ref names, like the --decorate option of linkgit:git-log[1]
-'%D':: ref names without the " (", ")" wrapping.
+'%D':: ref names without the " (", ")" wrapping
+'%r':: ref names only, separated by spaces
 '%(describe[:options])':: human-readable name, like
 			  linkgit:git-describe[1]; empty string for
 			  undescribable commits.  The `describe` string
diff --git a/log-tree.c b/log-tree.c
index f4b22a60cc..80850b3a03 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -301,14 +301,12 @@ static void show_name(struct strbuf *sb, const struct name_decoration *decoratio
 
 /*
  * The caller makes sure there is no funny color before calling.
- * format_decorations_extended makes sure the same after return.
+ * format_decorations makes sure the same after return.
  */
-void format_decorations_extended(struct strbuf *sb,
+void format_decorations(struct strbuf *sb,
 			const struct commit *commit,
 			int use_color,
-			const char *prefix,
-			const char *separator,
-			const char *suffix)
+			enum decoration_format format)
 {
 	const struct name_decoration *decoration;
 	const struct name_decoration *current_and_HEAD;
@@ -316,11 +314,18 @@ void format_decorations_extended(struct strbuf *sb,
 		diff_get_color(use_color, DIFF_COMMIT);
 	const char *color_reset =
 		decorate_get_color(use_color, DECORATION_NONE);
+	int first = 1;
 
 	decoration = get_name_decoration(&commit->object);
 	if (!decoration)
 		return;
 
+	if (format == DECO_FMT_WRAPPED) {
+		strbuf_addstr(sb, color_commit);
+		strbuf_addstr(sb, " (");
+		strbuf_addstr(sb, color_reset);
+	}
+
 	current_and_HEAD = current_pointed_by_HEAD(decoration);
 	while (decoration) {
 		/*
@@ -329,13 +334,25 @@ void format_decorations_extended(struct strbuf *sb,
 		 * appeared, skipping the entry for current.
 		 */
 		if (decoration != current_and_HEAD) {
-			strbuf_addstr(sb, color_commit);
-			strbuf_addstr(sb, prefix);
-			strbuf_addstr(sb, color_reset);
-			strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
-			if (decoration->type == DECORATION_REF_TAG)
-				strbuf_addstr(sb, "tag: ");
+			const char *color = decorate_get_color(use_color, decoration->type);
+			if (!first) {
+				if (format == DECO_FMT_BARE)
+					strbuf_addstr(sb, " ");
+				else {
+					strbuf_addstr(sb, color_commit);
+					strbuf_addstr(sb, ", ");
+					strbuf_addstr(sb, color_reset);
+				}
+			}
+			first = 0;
 
+			if (format != DECO_FMT_BARE &&
+			    decoration->type == DECORATION_REF_TAG) {
+				strbuf_addstr(sb, color);
+				strbuf_addstr(sb, "tag: ");
+				strbuf_addstr(sb, color_reset);
+			}
+			strbuf_addstr(sb, color);
 			show_name(sb, decoration);
 
 			if (current_and_HEAD &&
@@ -346,14 +363,15 @@ void format_decorations_extended(struct strbuf *sb,
 				show_name(sb, current_and_HEAD);
 			}
 			strbuf_addstr(sb, color_reset);
-
-			prefix = separator;
 		}
 		decoration = decoration->next;
 	}
-	strbuf_addstr(sb, color_commit);
-	strbuf_addstr(sb, suffix);
-	strbuf_addstr(sb, color_reset);
+
+	if (format == DECO_FMT_WRAPPED) {
+		strbuf_addstr(sb, color_commit);
+		strbuf_addstr(sb, ")");
+		strbuf_addstr(sb, color_reset);
+	}
 }
 
 void show_decorations(struct rev_info *opt, struct commit *commit)
@@ -368,7 +386,7 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 	}
 	if (!opt->show_decorations)
 		return;
-	format_decorations(&sb, commit, opt->diffopt.use_color);
+	format_decorations(&sb, commit, opt->diffopt.use_color, DECO_FMT_WRAPPED);
 	fputs(sb.buf, opt->diffopt.file);
 	strbuf_release(&sb);
 }
diff --git a/log-tree.h b/log-tree.h
index e7e4641cf8..5aa8908c65 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -13,17 +13,18 @@ struct decoration_filter {
 	struct string_list *exclude_ref_config_pattern;
 };
 
+enum decoration_format {
+  DECO_FMT_BARE = 0,
+  DECO_FMT_UNWRAPPED,
+  DECO_FMT_WRAPPED,
+};
+
 int parse_decorate_color_config(const char *var, const char *slot_name, const char *value);
 int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
 void show_log(struct rev_info *opt);
-void format_decorations_extended(struct strbuf *sb, const struct commit *commit,
-			     int use_color,
-			     const char *prefix,
-			     const char *separator,
-			     const char *suffix);
-#define format_decorations(strbuf, commit, color) \
-			     format_decorations_extended((strbuf), (commit), (color), " (", ", ", ")")
+void format_decorations(struct strbuf *sb, const struct commit *commit,
+			int use_color, enum decoration_format format);
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **extra_headers_p,
diff --git a/pretty.c b/pretty.c
index 0bb938021b..88b041df85 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1526,10 +1526,13 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		format_decorations(sb, commit, c->auto_color);
+		format_decorations(sb, commit, c->auto_color, DECO_FMT_WRAPPED);
 		return 1;
 	case 'D':
-		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
+		format_decorations(sb, commit, c->auto_color, DECO_FMT_UNWRAPPED);
+		return 1;
+	case 'r':
+		format_decorations(sb, commit, c->auto_color, DECO_FMT_BARE);
 		return 1;
 	case 'S':		/* tag/branch like --source */
 		if (!(c->pretty_ctx->rev && c->pretty_ctx->rev->sources))
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index ae73aef922..9e0871df24 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -2325,7 +2325,12 @@ test_expect_success 'log --decorate includes all levels of tag annotated tags' '
 	HEAD -> branch, tag: lightweight, tag: double-1, tag: double-0, tag: annotated
 	EOF
 	git log -1 --format="%D" >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	cat >expect2 <<-\EOF &&
+	HEAD -> branch lightweight double-1 double-0 annotated
+	EOF
+	git log -1 --format="%r" >actual2 &&
+	test_cmp expect2 actual2
 '
 
 test_expect_success 'log --decorate does not include things outside filter' '
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index ded33a82e2..7effc0813f 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -55,13 +55,13 @@ test_expect_success 'commit decorations colored correctly' '
 	cat >expect <<-EOF &&
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
 ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A1${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: ${c_reset}${c_tag}A1${c_reset}${c_commit}, \
 ${c_reset}${c_remoteBranch}other/main${c_reset}${c_commit})${c_reset} A1
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_stash}refs/stash${c_reset}${c_commit})${c_reset} \
 On main: Changes to A.t
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always --all >actual &&
@@ -78,10 +78,10 @@ test_expect_success 'test coloring with replace-objects' '
 	cat >expect <<-EOF &&
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
 ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: D${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: C${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit})${c_reset} D
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: ${c_reset}${c_tag}C${c_reset}${c_commit}, \
 ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
@@ -102,11 +102,11 @@ test_expect_success 'test coloring with grafted commit' '
 	cat >expect <<-EOF &&
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
 ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: D${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit}, \
 ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
-- 
2.41.0

