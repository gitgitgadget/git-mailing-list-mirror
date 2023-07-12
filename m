Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8047CEB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 20:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjGLU4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 16:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGLU4h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 16:56:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A167E171D
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 13:56:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-313fb7f0f80so71336f8f.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 13:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689195394; x=1691787394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EUwey2D3q4QP2DkVciZBLfJFO+S979xiJB2DX3tHSw=;
        b=bUK8ZIAcgFOwycDHmfvG4NL22fcZ1EZ3JIdGwWiuvYjO4oTQILkdGj+jEAOuLA6yC2
         4o41vc3PXL8c3z6PgkxvQrUojk6Nn4q47sdOPazpnBO3Ut4Jt+gadTAXsDB90J0YvLSt
         PG/fWCVj8qYlOjhMozUZCp0yiwghS7A+GkDrF06fWD90M3cL8gEhO9eq/3EPqHeP16ZS
         Z9gFB0mrNWrASvX8fdjlIxXua/t3E+HLI9oXaks1BSDpiml/TZYqpoE9Fyqq1Tpai9/v
         FIS2sHcJS9Ch01pQ0MKJekKkbfxpAMfCVWKrZBKAoiB4oQAmxpuwGIr5jYetQTnW3orI
         BD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689195394; x=1691787394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EUwey2D3q4QP2DkVciZBLfJFO+S979xiJB2DX3tHSw=;
        b=SQqbd779CmDgCUn/TAuXWbi/XZsAYYjOVtLnTi8tN4FCH2bvVoY1AQBjZ63taw0Gdq
         hS7kGmaPv7yom+S3PBEKTSki9xHGeKhgJgptB0tEEu06btwkMCap7rHqdpNswQWFGSHE
         llOoL1RO7vds8byjb09aOeKM/C2rP2c1MlCP7HXAwgum8ElTWHumKCFJF9f989G1L+GJ
         wOr0t7IfGsTLRjXO8Pp6UrjXIJ6BSvC5kzBMhXtMCy8CQFvCmmNvURfhf9qeyxCtrAsG
         +sKH8hJfPG6ICI4hB7VwHfQvMK5JNkQOB4lQli6dJKPQPkI36vuUblNqnthpj58BZX2W
         5vjw==
X-Gm-Message-State: ABy/qLYllVCAwIa6Ko39g5TsaVRXDVcFzmY8oiN/xXWYTNMfARldqwv6
        35RUlScOhKwcI/zhFAbNE/uKxauwrAw=
X-Google-Smtp-Source: APBJJlGH7Ft/WtvlUJc7rpJB+IMIIvCTo7+Gbu2vilav7Tgenk5VszlDh1QronCJF56KS1vqJTfY8A==
X-Received: by 2002:a5d:58cf:0:b0:314:77a:c2b2 with SMTP id o15-20020a5d58cf000000b00314077ac2b2mr16667030wrf.32.1689195393856;
        Wed, 12 Jul 2023 13:56:33 -0700 (PDT)
Received: from localhost.localdomain (host-92-6-81-118.as13285.net. [92.6.81.118])
        by smtp.gmail.com with ESMTPSA id cr13-20020a05600004ed00b003143ba62cf4sm6049224wrb.86.2023.07.12.13.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 13:56:33 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v2] pretty: add %r format specifier for showing refs
Date:   Wed, 12 Jul 2023 21:56:08 +0100
Message-Id: <20230712205608.1806-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <CAPig+cT3tWnSfk+ZoRWU=JTGctMiE38fH5V1ebpP7L1bGsfU4Q@mail.gmail.com>
References: <CAPig+cT3tWnSfk+ZoRWU=JTGctMiE38fH5V1ebpP7L1bGsfU4Q@mail.gmail.com>
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

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
CI: https://github.com/ak2/git/actions/runs/5535093717
All passed apart from unrelated errors for MacOS.

 Documentation/pretty-formats.txt |  3 +-
 log-tree.c                       | 53 ++++++++++++++++++++++----------
 log-tree.h                       | 15 ++++-----
 pretty.c                         |  7 +++--
 t/t4202-log.sh                   |  7 ++++-
 t/t4207-log-decoration-colors.sh | 32 +++++++++++--------
 6 files changed, 76 insertions(+), 41 deletions(-)

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
index f4b22a60cc..33dcb31858 100644
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
@@ -329,13 +334,26 @@ void format_decorations_extended(struct strbuf *sb,
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
+
+			if (format != DECO_FMT_BARE &&
+			    decoration->type == DECORATION_REF_TAG) {
+				strbuf_addstr(sb, color);
+				strbuf_addstr(sb, "tag: ");
+				strbuf_addstr(sb, color_reset);
+			}
+			strbuf_addstr(sb, color);
 			show_name(sb, decoration);
 
 			if (current_and_HEAD &&
@@ -346,14 +364,15 @@ void format_decorations_extended(struct strbuf *sb,
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
@@ -368,7 +387,7 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 	}
 	if (!opt->show_decorations)
 		return;
-	format_decorations(&sb, commit, opt->diffopt.use_color);
+	format_decorations(&sb, commit, opt->diffopt.use_color, DECO_FMT_WRAPPED);
 	fputs(sb.buf, opt->diffopt.file);
 	strbuf_release(&sb);
 }
diff --git a/log-tree.h b/log-tree.h
index e7e4641cf8..345d1e80dc 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -13,17 +13,18 @@ struct decoration_filter {
 	struct string_list *exclude_ref_config_pattern;
 };
 
+enum decoration_format {
+	DECO_FMT_BARE = 0,
+	DECO_FMT_UNWRAPPED,
+	DECO_FMT_WRAPPED,
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
index ded33a82e2..3a4eedc494 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -55,13 +55,15 @@ test_expect_success 'commit decorations colored correctly' '
 	cat >expect <<-EOF &&
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
 ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A1${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A1${c_reset}${c_commit}, \
 ${c_reset}${c_remoteBranch}other/main${c_reset}${c_commit})${c_reset} A1
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_stash}refs/stash${c_reset}${c_commit})${c_reset} \
-On main: Changes to A.t
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_stash}refs/stash${c_reset}${c_commit})${c_reset} On main: Changes to A.t
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always --all >actual &&
@@ -78,10 +80,12 @@ test_expect_success 'test coloring with replace-objects' '
 	cat >expect <<-EOF &&
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
 ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: D${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: C${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit})${c_reset} D
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}C${c_reset}${c_commit}, \
 ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
@@ -102,11 +106,13 @@ test_expect_success 'test coloring with grafted commit' '
 	cat >expect <<-EOF &&
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
 ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: D${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit}, \
 ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
+${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
+	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
-- 
2.41.0

