Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB573C001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjHJVRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjHJVRE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:17:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E018273D
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:17:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso12822095e9.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702222; x=1692307022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cqgnUnHxpyEoIsWq8VCsc0YDDVEWbhJtt64G58uiVk=;
        b=mPt/mvPL6tEgV/uO+jU7kPrPixnCT+lJy58UUR4KJJrm+K3fGIBkuy8/2VxtANIxOJ
         TJ4/7jvqYKKvraKnAJDsEt/ksRnNj6NqVJuOllKT750QDS8sbLf6VTJMnZFvLSCQ/bO2
         g+8NnNJfbo9x5Sdh6aT1tlapOM88dm+lke0gcRiCCi1vZiqjNDgYY5tNC7ig2M2/sDfQ
         CnJhSkG9XzopGnIXOBJeuaufe/zwpW90wiZWak1WJDddPXpks/GW0nnnMBJbV+u6UIyz
         tQkgAmp5JRSVJpA8cpSHGsRSjhBihWAqZpAfyp35GImme0NEun78/SU0Enx/ilyP6+nM
         pVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702222; x=1692307022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cqgnUnHxpyEoIsWq8VCsc0YDDVEWbhJtt64G58uiVk=;
        b=NMgWCxRkjxpAgJwcKS5LDQVp8OgCa1uQR6Ip9y9WulEMKy7compZ1f9iJXcRFjLq1l
         sZe76w0ivLVtofe7FO+v+Z1CuLRYMTYbSV9JFtZiFpfTBDiwif8f7VDRR/l+DmMF0ePb
         hlTmvdGbM0QP4ncD6CEky69ky6pfPaRxEh6y0jN7wJdhty/yh25whxUBe+i34PlPZipA
         qaI+6+IvLy/T9xztuF8640bVupDHMFrK71vEmNohun5jlId7lD2KTYxf96UAt9I3Sgzd
         GtfxymEATcbsURzcDoFlaQem9ZePifkDv/QisFWRnu6f+eXMq3KyOsjh+FHWWU+IVmLc
         1PjA==
X-Gm-Message-State: AOJu0YwySKQrjDTaToavUVa64mG3JmAjt8s/9ZLCfmQvOz4sGhZl3h1D
        ERK9W0GqxdPIprvepChVf2V+l5NEU14W1w==
X-Google-Smtp-Source: AGHT+IGDeALhN901pCsIilOEh7zfh52YnDrgzbosbWRVVf9wlpgVTaPq5TAhWYsZZbXIDlebhAWAKg==
X-Received: by 2002:a1c:f702:0:b0:3fb:403d:90c5 with SMTP id v2-20020a1cf702000000b003fb403d90c5mr37807wmh.39.1691702221636;
        Thu, 10 Aug 2023 14:17:01 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c229300b003fe24da493dsm3169864wmf.41.2023.08.10.14.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:17:01 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 3/7] decorate: refactor format_decorations()
Date:   Thu, 10 Aug 2023 22:16:15 +0100
Message-ID: <20230810211619.19055-3-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230810211619.19055-1-andy.koppe@gmail.com>
References: <20230715160730.4046-1-andy.koppe@gmail.com>
 <20230810211619.19055-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the format_decorations_extended function to format_decorations
and drop the format_decorations wrapper macro. Pass the prefix, suffix
and separator strings as a single 'struct format_decorations' pointer
argument instead of separate arguments. Use default values defined in
the function when either the struct pointer or any of the struct fields
are NULL. This is to ease extension with additional options.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 log-tree.c | 23 +++++++++++++++++------
 log-tree.h | 15 ++++++++-------
 pretty.c   |  6 ++++--
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 208c69cbb7..cd12c26c29 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -303,14 +303,12 @@ static void show_name(struct strbuf *sb, const struct name_decoration *decoratio
 
 /*
  * The caller makes sure there is no funny color before calling.
- * format_decorations_extended makes sure the same after return.
+ * format_decorations ensures the same after return.
  */
-void format_decorations_extended(struct strbuf *sb,
+void format_decorations(struct strbuf *sb,
 			const struct commit *commit,
 			int use_color,
-			const char *prefix,
-			const char *separator,
-			const char *suffix)
+			const struct decoration_options *opts)
 {
 	const struct name_decoration *decoration;
 	const struct name_decoration *current_and_HEAD;
@@ -319,10 +317,23 @@ void format_decorations_extended(struct strbuf *sb,
 	const char *color_reset =
 		decorate_get_color(use_color, DECORATION_NONE);
 
+	const char *prefix = " (";
+	const char *suffix = ")";
+	const char *separator = ", ";
+
 	decoration = get_name_decoration(&commit->object);
 	if (!decoration)
 		return;
 
+	if (opts) {
+		if (opts->prefix)
+			prefix = opts->prefix;
+		if (opts->suffix)
+			suffix = opts->suffix;
+		if (opts->separator)
+			separator = opts->separator;
+	}
+
 	current_and_HEAD = current_pointed_by_HEAD(decoration);
 	while (decoration) {
 		/*
@@ -370,7 +381,7 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 	}
 	if (!opt->show_decorations)
 		return;
-	format_decorations(&sb, commit, opt->diffopt.use_color);
+	format_decorations(&sb, commit, opt->diffopt.use_color, NULL);
 	fputs(sb.buf, opt->diffopt.file);
 	strbuf_release(&sb);
 }
diff --git a/log-tree.h b/log-tree.h
index bdb6432815..14898de8ac 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -13,17 +13,18 @@ struct decoration_filter {
 	struct string_list *exclude_ref_config_pattern;
 };
 
+struct decoration_options {
+	char *prefix;
+	char *suffix;
+	char *separator;
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
+			int use_color, const struct decoration_options *opts);
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **extra_headers_p,
diff --git a/pretty.c b/pretty.c
index 718530bbab..24fb82a5a2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1537,10 +1537,12 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		format_decorations(sb, commit, c->auto_color);
+		format_decorations(sb, commit, c->auto_color, NULL);
 		return 1;
 	case 'D':
-		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
+		format_decorations(sb, commit, c->auto_color,
+			&(struct decoration_options){.prefix = "",
+						     .suffix = ""});
 		return 1;
 	case 'S':		/* tag/branch like --source */
 		if (!(c->pretty_ctx->rev && c->pretty_ctx->rev->sources))
-- 
2.42.0-rc1

