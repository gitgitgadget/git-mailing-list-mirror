Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58D2EE49AA
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 18:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjHTS4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 14:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjHTSz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 14:55:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE86E7
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:56 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe4cdb727cso25495385e9.0
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692557454; x=1693162254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrOMVlxSS+hsD2nF+STVoNfumEi0IMk1DCzOKFnrsRg=;
        b=JOyvJ8/hNSAnHZMY3v+O5/PT75N/Qo0kmP5O6Fmb3ysfMDIF6Q80EFINkASJ04+QL0
         7UlB6fyIZQI8I12R80Z8mRR14Yzyg8BG7OoeArTz0PzXkpidWDzP9PIdjFyUB7r6sI/c
         oSGCYdtdnN69g21tU9q8ELWOnPkFFbB+ubmDOgF95uifPAIPKjSJAEqRWcV4OGuqp1MV
         dKKuCXeCP3CUtT5dnbsH+wlN538JF+K+HFrfWrPB9qeBLNtUXRwC5eLK+iXRGur8ZSg0
         n3B/sPCWzjHQ6QSpg70kIkBHv+6Kg3M2yTg8cgQeN+6qEsyx0/ehJcSSa0EgHth4hsCm
         o21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692557454; x=1693162254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrOMVlxSS+hsD2nF+STVoNfumEi0IMk1DCzOKFnrsRg=;
        b=KZ2ptT8m6DUZivF9MoSe4CQPKZHTVzbnJQiR77wCvq557HpHv+QENyGwfQLU+vLOh9
         KIQaywxPse6ovSFeyr0kivkSk+EucMECH2vNUbaPpMOTtx/sv2NGxP4n8wLpLF2X1J2X
         ehabQHoPO/Nm8f8paAxehn7rGhY51Pa85yt6LL6W75ASJaSTYBpX2XrrJU7wk0DQLYH2
         9T4W5VqBrcpyV1eUVJAuBHCqk+ViDaCAYnZf3hB4ecuSYZ+OLjW3re6/IIV4fzAy7Ydk
         CcOybqiTQnlNj1UUsQRd0ND+xk10YhD72mGhtFdqPwOmn7P8xOskysr8xtfSJM/VQw7z
         JPLg==
X-Gm-Message-State: AOJu0Yxn4ygYtWCYgKQZLrgSNLSAuQX/HZaRGLXZLgIpjnVshj1RR9SV
        fYzocbySHgppSoeNF6Pi2yyZhTfkecV192zI
X-Google-Smtp-Source: AGHT+IEuKID/MYbukr3rk57uMsVRL2jtRDQz6t1bYQv0T2MKOmU3AHvSLAnGY9anAukF4DOtDmT3vQ==
X-Received: by 2002:a05:600c:21cc:b0:3fb:b530:a4e4 with SMTP id x12-20020a05600c21cc00b003fbb530a4e4mr3856554wmj.8.1692557454370;
        Sun, 20 Aug 2023 11:50:54 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c021a00b003fa95f328afsm13603604wmi.29.2023.08.20.11.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 11:50:54 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v5 3/8] decorate: refactor format_decorations()
Date:   Sun, 20 Aug 2023 19:50:04 +0100
Message-ID: <20230820185009.20095-4-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820185009.20095-1-andy.koppe@gmail.com>
References: <20230820085336.8615-1-andy.koppe@gmail.com>
 <20230820185009.20095-1-andy.koppe@gmail.com>
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
 pretty.c   | 13 ++++++++++---
 3 files changed, 35 insertions(+), 16 deletions(-)

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
index 718530bbab..69b6db3340 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1537,11 +1537,18 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
 		return 1;
 	case 'd':
-		format_decorations(sb, commit, c->auto_color);
+		format_decorations(sb, commit, c->auto_color, NULL);
 		return 1;
 	case 'D':
-		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
-		return 1;
+		{
+			const struct decoration_options opts = {
+				.prefix = "",
+				.suffix = ""
+			};
+
+			format_decorations(sb, commit, c->auto_color, &opts);
+			return 1;
+		}
 	case 'S':		/* tag/branch like --source */
 		if (!(c->pretty_ctx->rev && c->pretty_ctx->rev->sources))
 			return 0;
-- 
2.42.0-rc2

