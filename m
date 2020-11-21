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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EC5C5519F
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 18:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D30EE22202
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 18:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqqJ7iGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgKUSbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 13:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgKUSbm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 13:31:42 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419EFC0613CF
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 10:31:42 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id 11so13567728ljf.2
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 10:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZnHzUHnlCjCOTsw1W382RHdrwzaQ8sz3XpGiOYbXZ7M=;
        b=GqqJ7iGZj3Td7tcVQIPhUVLn0QoE4nkFqmTekJ1KY8lCKIoMC5+Sf6h4EYvrdvrNlM
         GJFQbkGVcQGAzHEDtNTb2sX/Y5AZdl0h11NnxvYMDUw5k3AjYN8gXS3VtNWybJw8sQsk
         4cq8UbE2q6K+Dyy0sgbL4W8jhT8qWI5ktfY2WJ/lC4tJC4kxczqftuRGmRNDZ/hAq1TR
         hrgQye3HFuTDkMIn/3XiX+3iQqqtaVe+kwKMqDEbdN0deYewzkm8bwgxZRYglQ1L77nX
         DeHiz8xpvf7C6ayTCOsdTEef/GWtEhtw7N1FYG00R/rzCxiJBwxCcbNyAHuZePACRPAH
         T1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZnHzUHnlCjCOTsw1W382RHdrwzaQ8sz3XpGiOYbXZ7M=;
        b=VZHK7V9TOZQQjC0Cn8rHxRxM9T7jC2zsqDEvK88fhyq44+w8eAirk4Ckeoj2IdqprA
         EA/N17px/61m0B0Qp0AKRyp3FVuyKRhoJUQCInFE8seoDMsk741N/Gdq09BB6pkLNjc8
         ItsByvs/AYXW3fAqO6d+x2DJwGg/mnzQal1dwGUiAUnUPuchlDn62ks6AGZrQSDcZ4X3
         Tqsn1+x0CU5cp4JQIznC7sGyW9h24bXRbl+KGzO+2QLmj+xJic6X5zG0QAYUkUJo6rN1
         e6ypghpNXe/Amzrqk9DMPEvydr1jMdVgY9qVEy1Es/YuWMraZmR8kXVDsxOrKS6meldj
         8I6Q==
X-Gm-Message-State: AOAM532bL+6DJSFAoGi8NLDA671XyBCKBk5MK/c536Zd9NIC2Yw0NE7x
        8R0WMcX+AEi8YYXOwuL1xEMIVY+JqFRxfQ==
X-Google-Smtp-Source: ABdhPJx9EzeygQcLseIngKsTUA1HIuRY3WUAZ0TOTFTZjNjtoQYMsm1JZRaUsUVtetuYqcZo8ZkIgg==
X-Received: by 2002:a2e:8053:: with SMTP id p19mr9741744ljg.321.1605983500437;
        Sat, 21 Nov 2020 10:31:40 -0800 (PST)
Received: from localhost.localdomain (h-79-136-100-70.NA.cust.bahnhof.se. [79.136.100.70])
        by smtp.gmail.com with ESMTPSA id m7sm786531lfj.113.2020.11.21.10.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 10:31:39 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 2/4] grep: use designated initializers for `grep_defaults`
Date:   Sat, 21 Nov 2020 19:31:08 +0100
Message-Id: <5aad7bb31f955a6adf41febfd16f2f483294f939.1605972564.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2
In-Reply-To: <cover.1605972564.git.martin.agren@gmail.com>
References: <cover.1605972564.git.martin.agren@gmail.com>
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
 If we've messed up and our color strings are too large for our buffers,
 we will no longer hit a BUG within `color_set()`, but we should be able
 to rely on the compiler detecting the truncation. We'll probably be
 *better* off than before, since the compiler will know exactly how
 large the buffer is.

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

