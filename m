Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0980920A04
	for <e@80x24.org>; Sun, 16 Apr 2017 10:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755051AbdDPKlg (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 06:41:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35496 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754900AbdDPKle (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 06:41:34 -0400
Received: by mail-pf0-f193.google.com with SMTP id a188so20703877pfa.2
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 03:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9f6e4hVqJlP23FGh7ybQkIOCUSq/X9j9HEcNtazvlvs=;
        b=UJMesa7i/SWneddmWG9q64/m6Ai5cFkDoUlMHki32Dfc/dSGMcV3IFkZAvhoM61UHP
         iHTxovcUGkBVN22HEgRSlwYmwxH4s5GGE6jRRKtC28YNKEbvoaJ4X0W/Axb5AN6MzGze
         sVcuv/rM69SXaIDXnXBy8HGuzeCDF9thM3COipuNOc4GaUPdgLfTH2ZstvfIjnUejbvG
         cB/jVrm1FX7xPB/KUATGpCbLs4BcZ6W4BTn0NA8kQ0Vo/0Uc0+09kl+EyY2J+E8hasMi
         ezefawPKQntDiGSHqcuV3OGn9Gmkzq/Qg0lF2aXVQj+tHNznKKggpHxmZ2hAutWD1Iat
         Kbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9f6e4hVqJlP23FGh7ybQkIOCUSq/X9j9HEcNtazvlvs=;
        b=m6jt2DB6hHQ5gTZCCixTrMgLueycBshJy8m6lpiktlMJtc1p7gePaH7fRcHnb/in2r
         HpSE1CfZd5JkSIst5zqLfr0AMiAJlAT48W18/gae+5CydXRzAF6J4RRDHZ+pXgS40Mw+
         8SBI3PAFYY06H2HYt9HSDXMApMMaN3XIEKa9kgnniMWp7F5MLvxWQiXw4WU1+pI3eNV+
         UlHnfwHOZ6QXe446++gBTZfhlX6BtqDvVIViaNE7Yfcneqplv5BArZvtifhV6BKlzZil
         RIgKmFhAzk6Odhzo52BSCG5EbqlycTuUGee7JaZb7OWERqL4nqmPxvbPyZh9p44in0Co
         SdFg==
X-Gm-Message-State: AN3rC/50vm1USLE/P8/7oeVZ/XTdKaqoStfCwB+0ym9B9WJRJ6123puX
        0hYJ2qF/dUQe5g==
X-Received: by 10.99.188.2 with SMTP id q2mr6631219pge.72.1492339293413;
        Sun, 16 Apr 2017 03:41:33 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id w14sm12119176pfi.66.2017.04.16.03.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 03:41:32 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 16 Apr 2017 17:41:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        bert.wesarg@googlemail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] config: prepare to pass more info in git_config_with_options()
Date:   Sun, 16 Apr 2017 17:41:24 +0700
Message-Id: <20170416104125.15300-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170416045004.2ghhiv7jzgroejgw@sigill.intra.peff.net>
References: <20170416045004.2ghhiv7jzgroejgw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So far we can only pass one flag, respect_includes, to thie function. We
need to pass some more (non-flag even), so let's make it accept a struct
instead of an integer.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Prep patch for the bug fix in 2/2.

 builtin/config.c | 21 ++++++++++++---------
 cache.h          |  7 ++++++-
 config.c         | 16 +++++++++++-----
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 4f49a0edb9..5de4a36146 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -26,7 +26,8 @@ static int use_global_config, use_system_config, use_local_config;
 static struct git_config_source given_config_source;
 static int actions, types;
 static int end_null;
-static int respect_includes = -1;
+static int respect_includes_opt;
+static struct config_options config_options;
 static int show_origin;
 
 #define ACTION_GET (1<<0)
@@ -81,7 +82,7 @@ static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
-	OPT_BOOL(0, "includes", &respect_includes, N_("respect include directives on lookup")),
+	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
 	OPT_END(),
 };
@@ -242,7 +243,7 @@ static int get_value(const char *key_, const char *regex_)
 	}
 
 	git_config_with_options(collect_config, &values,
-				&given_config_source, respect_includes);
+				&given_config_source, &config_options);
 
 	ret = !values.nr;
 
@@ -320,7 +321,7 @@ static void get_color(const char *var, const char *def_color)
 	get_color_found = 0;
 	parsed_color[0] = '\0';
 	git_config_with_options(git_get_color_config, NULL,
-				&given_config_source, respect_includes);
+				&given_config_source, &config_options);
 
 	if (!get_color_found && def_color) {
 		if (color_parse(def_color, parsed_color) < 0)
@@ -352,7 +353,7 @@ static int get_colorbool(const char *var, int print)
 	get_diff_color_found = -1;
 	get_color_ui_found = -1;
 	git_config_with_options(git_get_colorbool_config, NULL,
-				&given_config_source, respect_includes);
+				&given_config_source, &config_options);
 
 	if (get_colorbool_found < 0) {
 		if (!strcmp(get_colorbool_slot, "color.diff"))
@@ -441,7 +442,7 @@ static int get_urlmatch(const char *var, const char *url)
 	}
 
 	git_config_with_options(urlmatch_config_entry, &config,
-				&given_config_source, respect_includes);
+				&given_config_source, &config_options);
 
 	ret = !values.nr;
 
@@ -530,8 +531,10 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 				prefix_filename(prefix, given_config_source.file);
 	}
 
-	if (respect_includes == -1)
-		respect_includes = !given_config_source.file;
+	if (respect_includes_opt == -1)
+		config_options.respect_includes = !given_config_source.file;
+	else
+		config_options.respect_includes = respect_includes_opt;
 
 	if (end_null) {
 		term = '\0';
@@ -578,7 +581,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 0, 0);
 		if (git_config_with_options(show_all_config, NULL,
 					    &given_config_source,
-					    respect_includes) < 0) {
+					    &config_options) < 0) {
 			if (given_config_source.file)
 				die_errno("unable to read config file '%s'",
 					  given_config_source.file);
diff --git a/cache.h b/cache.h
index 5c8078291c..e29a093839 100644
--- a/cache.h
+++ b/cache.h
@@ -1882,6 +1882,10 @@ enum config_origin_type {
 	CONFIG_ORIGIN_CMDLINE
 };
 
+struct config_options {
+	unsigned int respect_includes : 1;
+};
+
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
@@ -1895,7 +1899,7 @@ extern void read_early_config(config_fn_t cb, void *data);
 extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
-				   int respect_includes);
+				   const struct config_options *opts);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_parse_maybe_bool(const char *);
 extern int git_config_int(const char *, const char *);
@@ -1947,6 +1951,7 @@ struct config_include_data {
 	int depth;
 	config_fn_t fn;
 	void *data;
+	const struct config_options *opts;
 };
 #define CONFIG_INCLUDE_INIT { 0 }
 extern int git_config_include(const char *name, const char *value, void *data);
diff --git a/config.c b/config.c
index 1a4d85537b..042321a3a0 100644
--- a/config.c
+++ b/config.c
@@ -1530,13 +1530,14 @@ static int do_git_config_sequence(config_fn_t fn, void *data)
 
 int git_config_with_options(config_fn_t fn, void *data,
 			    struct git_config_source *config_source,
-			    int respect_includes)
+			    const struct config_options *opts)
 {
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
 
-	if (respect_includes) {
+	if (opts->respect_includes) {
 		inc.fn = fn;
 		inc.data = data;
+		inc.opts = opts;
 		fn = git_config_include;
 		data = &inc;
 	}
@@ -1557,7 +1558,10 @@ int git_config_with_options(config_fn_t fn, void *data,
 
 static void git_config_raw(config_fn_t fn, void *data)
 {
-	if (git_config_with_options(fn, data, NULL, 1) < 0)
+	struct config_options opts = {0};
+
+	opts.respect_includes = 1;
+	if (git_config_with_options(fn, data, NULL, &opts) < 0)
 		/*
 		 * git_config_with_options() normally returns only
 		 * zero, as most errors are fatal, and
@@ -1597,9 +1601,11 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 
 void read_early_config(config_fn_t cb, void *data)
 {
+	struct config_options opts = {0};
 	struct strbuf buf = STRBUF_INIT;
 
-	git_config_with_options(cb, data, NULL, 1);
+	opts.respect_includes = 1;
+	git_config_with_options(cb, data, NULL, &opts);
 
 	/*
 	 * When setup_git_directory() was not yet asked to discover the
@@ -1615,7 +1621,7 @@ void read_early_config(config_fn_t cb, void *data)
 		memset(&repo_config, 0, sizeof(repo_config));
 		strbuf_addstr(&buf, "/config");
 		repo_config.file = buf.buf;
-		git_config_with_options(cb, data, &repo_config, 1);
+		git_config_with_options(cb, data, &repo_config, &opts);
 	}
 	strbuf_release(&buf);
 }
-- 
2.11.0.157.gd943d85

