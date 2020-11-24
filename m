Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E01DC56202
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF36220789
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stTmEDfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgKXVEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 16:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgKXVEx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 16:04:53 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDB0C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 13:04:53 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u19so46130lfr.7
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 13:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PzK9hm8dvXKJc8HITUoZygGpfbAuAchDkA65I3AjRno=;
        b=stTmEDfsVJLLnZgcbqEdRscb+SQnJq9UzGm0+kWRFKtYN2Pras08obzRoHZ7OB8vwM
         FmSz7HixFBzm3AMmrhTKAv3QKT76z4CkwhplHNIvTxgDz1DJQVOGRBoVu4EfqcMKx6BG
         99BdAHhm5k1dwXXPKe7UDD+8To0UMm9+Ml4Qs9fLEv20OdXvBFaFVpfk0+K5MkINixYi
         CJFt1zmPgE0BKntXPi9xNv9QNoHGwH7Wm1OEGr2aFCXhM7j9GRcr6HKESu8KM6lQlT5O
         dHYDtLOcJvNnC3TNO1Wmqxj+wtnb9gwi+YTdrZQNIPdVoB0OpfxMZRn66u/3UAzA2CJe
         ZpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzK9hm8dvXKJc8HITUoZygGpfbAuAchDkA65I3AjRno=;
        b=fFHottXmypGvYO9lXE9TjnHIThZkbOirvaZ4d+/FrCRzaGw+yNXayhL5ckq5ib78no
         ikT3ULx3YUKEoMrnngORIRIhhtEj0isZts2ZCIOKZlQ084j8kadJTtjkI+BVceLtHwXc
         DuUDqatiWlpE3udSAco9RZDtOU/5OGYSLs3PLzMUrIhE8RsLyEeueybeT+jGEzTkdymV
         yqiJ2DN6EKkEIG1n8niZvSdVPtk4dN5/8iR85AWXm51bEkODIQ9r0tZDOB/UPZAy3ES/
         +jnvdfLzGXnJiPE+/6TOgz1W7HsEif6hmcZJaiJQEWCByYSTKcyDnT++3cI9uas0RK/v
         5gFw==
X-Gm-Message-State: AOAM5303wP96LYyzSUwYGrM2QkXCe40gUk3UVImkWSCox/AQ0MtdOrKD
        OBAXDTiv7I8xKBLLb3PQuIl1hrSNgOy+iQ==
X-Google-Smtp-Source: ABdhPJyPvd00mQieffeunii5INIJPykIP9N6zqi5x1LyvvK+KJnMJlSA5OFXpfbKQvMvbtGY6+UnWg==
X-Received: by 2002:a19:ac05:: with SMTP id g5mr2325961lfc.593.1606251891198;
        Tue, 24 Nov 2020 13:04:51 -0800 (PST)
Received: from localhost.localdomain (h-79-136-116-123.NA.cust.bahnhof.se. [79.136.116.123])
        by smtp.gmail.com with ESMTPSA id z20sm22911ljm.138.2020.11.24.13.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:04:50 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 2/4] grep: use designated initializers for `grep_defaults`
Date:   Tue, 24 Nov 2020 22:04:14 +0100
Message-Id: <c33837f0828acad539e7faef4c36768949d1ac56.1606251358.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2
In-Reply-To: <cover.1606251357.git.martin.agren@gmail.com>
References: <cover.1605972564.git.martin.agren@gmail.com> <cover.1606251357.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 15fabd1bbd ("builtin/grep.c: make configuration callback more
reusable", 2012-10-09), we learned to fill a `static struct grep_opt
grep_defaults` which we can use as a blueprint for other such structs.

At the time, we didn't consider designated initializers to be widely
useable, but these days, we do. (See, e.g., cbc0f81d96 ("strbuf: use
designated initializers in STRBUF_INIT", 2017-07-10).)

Use designated initializers to let the compiler set up the struct and so
that we don't need to remember to call `init_grep_defaults()`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/MyFirstObjectWalk.txt | 10 +----
 grep.h                              |  1 -
 builtin/grep.c                      |  1 -
 builtin/log.c                       |  1 -
 grep.c                              | 64 +++++++++++------------------
 revision.c                          |  1 -
 6 files changed, 26 insertions(+), 52 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index 85434d1938..7f4bffc4dd 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -388,17 +388,9 @@ Next, let's try to filter the commits we see based on their author. This is
 equivalent to running `git log --author=<pattern>`. We can add a filter by
 modifying `rev_info.grep_filter`, which is a `struct grep_opt`.
 
-First some setup. Add `init_grep_defaults()` to `init_walken_defaults()` and add
-`grep_config()` to `git_walken_config()`:
+First some setup. Add `grep_config()` to `git_walken_config()`:
 
 ----
-static void init_walken_defaults(void)
-{
-	init_grep_defaults();
-}
-
-...
-
 static int git_walken_config(const char *var, const char *value, void *cb)
 {
 	grep_config(var, value, cb);
diff --git a/grep.h b/grep.h
index 1c5478f381..b5c4e223a8 100644
--- a/grep.h
+++ b/grep.h
@@ -170,7 +170,6 @@ struct grep_opt {
 	void *output_priv;
 };
 
-void init_grep_defaults(void);
 int grep_config(const char *var, const char *value, void *);
 void grep_init(struct grep_opt *, struct repository *repo, const char *prefix);
 void grep_destroy(void);
diff --git a/builtin/grep.c b/builtin/grep.c
index 2b96efa8c2..ca259af441 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -950,7 +950,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	init_grep_defaults();
 	git_config(grep_cmd_config, NULL);
 	grep_init(&opt, the_repository, prefix);
 
diff --git a/builtin/log.c b/builtin/log.c
index eee4beca4d..cf41714fb0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -131,7 +131,6 @@ static int log_line_range_callback(const struct option *option, const char *arg,
 
 static void init_log_defaults(void)
 {
-	init_grep_defaults();
 	init_diff_ui_defaults();
 
 	decoration_style = auto_decoration_style();
diff --git a/grep.c b/grep.c
index b351449f7f..8f2009ec9f 100644
--- a/grep.c
+++ b/grep.c
@@ -14,7 +14,31 @@ static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs,
 				 struct index_state *istate);
 
-static struct grep_opt grep_defaults;
+static void std_output(struct grep_opt *opt, const void *buf, size_t size)
+{
+	fwrite(buf, size, 1, stdout);
+}
+
+static struct grep_opt grep_defaults = {
+	.relative = 1,
+	.pathname = 1,
+	.max_depth = -1,
+	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED,
+	.colors = {
+		[GREP_COLOR_CONTEXT] = "",
+		[GREP_COLOR_FILENAME] = "",
+		[GREP_COLOR_FUNCTION] = "",
+		[GREP_COLOR_LINENO] = "",
+		[GREP_COLOR_COLUMNNO] = "",
+		[GREP_COLOR_MATCH_CONTEXT] = GIT_COLOR_BOLD_RED,
+		[GREP_COLOR_MATCH_SELECTED] = GIT_COLOR_BOLD_RED,
+		[GREP_COLOR_SELECTED] = "",
+		[GREP_COLOR_SEP] = GIT_COLOR_CYAN,
+	},
+	.only_matching = 0,
+	.color = -1,
+	.output = std_output,
+};
 
 #ifdef USE_LIBPCRE2
 static pcre2_general_context *pcre2_global_context;
@@ -42,49 +66,11 @@ static const char *color_grep_slots[] = {
 	[GREP_COLOR_SEP]	    = "separator",
 };
 
-static void std_output(struct grep_opt *opt, const void *buf, size_t size)
-{
-	fwrite(buf, size, 1, stdout);
-}
-
 static void color_set(char *dst, const char *color_bytes)
 {
 	xsnprintf(dst, COLOR_MAXLEN, "%s", color_bytes);
 }
 
-/*
- * Initialize the grep_defaults template with hardcoded defaults.
- * We could let the compiler do this, but without C99 initializers
- * the code gets unwieldy and unreadable, so...
- */
-void init_grep_defaults(void)
-{
-	struct grep_opt *opt = &grep_defaults;
-	static int run_once;
-
-	if (run_once)
-		return;
-	run_once++;
-
-	memset(opt, 0, sizeof(*opt));
-	opt->relative = 1;
-	opt->pathname = 1;
-	opt->max_depth = -1;
-	opt->pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
-	color_set(opt->colors[GREP_COLOR_CONTEXT], "");
-	color_set(opt->colors[GREP_COLOR_FILENAME], "");
-	color_set(opt->colors[GREP_COLOR_FUNCTION], "");
-	color_set(opt->colors[GREP_COLOR_LINENO], "");
-	color_set(opt->colors[GREP_COLOR_COLUMNNO], "");
-	color_set(opt->colors[GREP_COLOR_MATCH_CONTEXT], GIT_COLOR_BOLD_RED);
-	color_set(opt->colors[GREP_COLOR_MATCH_SELECTED], GIT_COLOR_BOLD_RED);
-	color_set(opt->colors[GREP_COLOR_SELECTED], "");
-	color_set(opt->colors[GREP_COLOR_SEP], GIT_COLOR_CYAN);
-	opt->only_matching = 0;
-	opt->color = -1;
-	opt->output = std_output;
-}
-
 static int parse_pattern_type_arg(const char *opt, const char *arg)
 {
 	if (!strcmp(arg, "default"))
diff --git a/revision.c b/revision.c
index f35ea1db11..963868f699 100644
--- a/revision.c
+++ b/revision.c
@@ -1834,7 +1834,6 @@ void repo_init_revisions(struct repository *r,
 	revs->commit_format = CMIT_FMT_DEFAULT;
 	revs->expand_tabs_in_log_default = 8;
 
-	init_grep_defaults();
 	grep_init(&revs->grep_filter, revs->repo, prefix);
 	revs->grep_filter.status_only = 1;
 
-- 
2.29.2.454.gaff20da3a2

