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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBE2C64E7C
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 19:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A93620757
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 19:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzJVk1tJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgK2Txh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 14:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgK2Txe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 14:53:34 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00C7C0613D3
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 11:52:53 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y10so13643533ljc.7
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 11:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFypa8gsyoCo66VLOtmqADXPSpAdCBed4UcBTQLz4nQ=;
        b=ZzJVk1tJM9QIVk2Q4PlE7UpiYDMjIQmqPJzz6EBFauv444rPGwGqrWfNQ4aXAJRcyo
         +S5/2r/9C5NMOIP90lrzsskSkoNAlInRtjPujfRBtGE8yjEh3dw0K3kPMzmkjBylxgR1
         f4u3jsLdqb2nuohIYsIP80TJgkAX9q/l7O9VFnmgjDxsvgB77EuS3XldJjWwd4Tby0x9
         vabE48kvTMj0lVspRkmDFnPsJDGJHhJIg/b6fChMRidp+RrDdO0VKGmV3QLzPJJDWWqa
         m4ZzJZyQ/0+LHDscvgOogmDFG1mqPbu/OoXcw9k0YNF9EjEkME40tzbuQo3EZOZQjOv/
         vCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFypa8gsyoCo66VLOtmqADXPSpAdCBed4UcBTQLz4nQ=;
        b=nKE3KDA47my9JcKLOq1l8MtsaE/ztlmzBMw3YGf32bMQNrJnFMn0pp8WMzR4Jo9IWn
         jwX/EI62oMY6Yn/MJR+17JpJ9/oQjrPem4a7PzrShg5CNjwcxwpUUcVQDb3cvvylrIrU
         sTEh0NH6DG7TnZegXWTm3dWFupQKFeA1Xl3HCzwUjk0fgSD1uEasnKMmkM5f0Dtcaaj/
         nqTBKvFRCB9N4PPmqLj6VGtCZ0mlZPqK6qocQU+O4hM6kpyOk3oWf/Xslhf2HQ+1V3lI
         nQJSD69JM8FeXz+03fznTY1SK4l9DdHmHDFb4h/UUfG3dX/Ii8UyoriimK7xjkUt6lha
         24wg==
X-Gm-Message-State: AOAM531z+VwyAFaJHb8fi31aeXBQ2nGmlAHBGTdfr5hNSoHqhK1BSKwM
        QnHDVuYhRC6sWi/Tt6Mb4pPi6RBjrIg=
X-Google-Smtp-Source: ABdhPJwjp2ucDpXXS57kuhnzmjRIpwkbdHoM79o1h5L5Ss7C1BQeRT1OEe3go5FGKloJlWZRbcysAg==
X-Received: by 2002:a2e:6e14:: with SMTP id j20mr8037593ljc.372.1606679571800;
        Sun, 29 Nov 2020 11:52:51 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id w72sm1808707lff.89.2020.11.29.11.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 11:52:51 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 2/4] grep: use designated initializers for `grep_defaults`
Date:   Sun, 29 Nov 2020 20:52:20 +0100
Message-Id: <96313423a75fa8d88b6ecd5a15c21a7fbaf9e9be.1606679312.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2
In-Reply-To: <cover.1606679312.git.martin.agren@gmail.com>
References: <cover.1606251357.git.martin.agren@gmail.com> <cover.1606679312.git.martin.agren@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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

