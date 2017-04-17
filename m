Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46A2A1FA14
	for <e@80x24.org>; Mon, 17 Apr 2017 10:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753381AbdDQKKN (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 06:10:13 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34453 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbdDQKKM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 06:10:12 -0400
Received: by mail-pg0-f68.google.com with SMTP id o123so26182199pga.1
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 03:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zh63UOS7ilzhz5dxfKE0m9GbUJ+0r9iadIJ1yOEtJFU=;
        b=nTlUd4FtsGK+MT26vzcFSegzuoPZ2u82BNoKQtFzq7gASs+kcpnP8KP3CQF2PvXqo+
         MkzQmTXcXXAqvz/iSvdpEeGkroSSCT5y30QzHSLaLeLDQkLUFBCiEC17Ee2GtRHKxSXG
         h6KwZI6RqjdLdfnu37M1MXwLzMvnuEbVrJhJ2lQK+YHTvELjyV6FnKZILgUC9JTgcokJ
         Nd6Pkik4mK5iBhg/EmEs1XdaHcACu5aWApnFnCa6gjXDYm4YhfTKahcyOBwNdxzfASDU
         wRBvjRleYbTo2Lh0fGqAbg97VAiOoS0fPTQjb7WRcggqfOcqknD3z5pzh8Nqc2v9wgMe
         zKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zh63UOS7ilzhz5dxfKE0m9GbUJ+0r9iadIJ1yOEtJFU=;
        b=G7nJjsvsA0adUFk7MIofXU1TB+FDPKwrWeYPV5xaEpoMNNxlLHIM45XrYAdXgKEjLQ
         CN6FYqqcvZ94kK/1W2pEB5EAd1riYLRp6+dl8zWHIxKdJipYf5PmvUkEitKbW/HVKAwL
         VgWexn0wbZOuVbYtjgWsSvT2mFJVNf3pteIu2T2gYxdrCFtGt2x3dxgh8Be0TTBDWhI4
         CL9MC35m7hz2BZ/jU+cIbHyQDZ4vofUxI7fUstbeYMpPafwMe8csFCDlrf6XuteC6cYO
         TGjuJEvLoazVru/WFvrOW0JVHNbALesE71g8qXeYCntcdE6Xc+x5nBhLfu5UFivks3It
         RCVA==
X-Gm-Message-State: AN3rC/5BjIQtINfvc8b/S2yF85yHTYRysmP35GLyM1jg8BMIPgyrOBQm
        00hiMussAIpl7w==
X-Received: by 10.98.194.199 with SMTP id w68mr2754277pfk.192.1492423811503;
        Mon, 17 Apr 2017 03:10:11 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id z5sm5487422pfd.76.2017.04.17.03.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2017 03:10:10 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 17 Apr 2017 17:10:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        bert.wesarg@googlemail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 1/3] config: prepare to pass more info in git_config_with_options()
Date:   Mon, 17 Apr 2017 17:10:00 +0700
Message-Id: <20170417101002.18272-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <CACsJy8D-=3qPbEO-dq2+Mr-WZ+5RrivkSw9NX7_FhEJFy+59zA@mail.gmail.com>
References: <CACsJy8D-=3qPbEO-dq2+Mr-WZ+5RrivkSw9NX7_FhEJFy+59zA@mail.gmail.com>
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
 builtin/config.c | 21 ++++++++++++---------
 cache.h          |  7 ++++++-
 config.c         | 16 +++++++++++-----
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 4f49a0edb9..b937d175a9 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -26,7 +26,8 @@ static int use_global_config, use_system_config, use_local_config;
 static struct git_config_source given_config_source;
 static int actions, types;
 static int end_null;
-static int respect_includes = -1;
+static int respect_includes_opt = -1;
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
index 556468c25b..a6294d2573 100644
--- a/cache.h
+++ b/cache.h
@@ -1885,6 +1885,10 @@ enum config_origin_type {
 	CONFIG_ORIGIN_CMDLINE
 };
 
+struct config_options {
+	unsigned int respect_includes : 1;
+};
+
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
@@ -1898,7 +1902,7 @@ extern void read_early_config(config_fn_t cb, void *data);
 extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
-				   int respect_includes);
+				   const struct config_options *opts);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_parse_maybe_bool(const char *);
 extern int git_config_int(const char *, const char *);
@@ -1950,6 +1954,7 @@ struct config_include_data {
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

