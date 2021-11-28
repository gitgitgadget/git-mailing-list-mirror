Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D6BC433F5
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 08:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356121AbhK1ID7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 03:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356160AbhK1IB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 03:01:59 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E00C061746
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 23:58:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s13so29282859wrb.3
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 23:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OdtLRwHCQikPA5pU9bHeW5G3cAhq/A9PizlP8Wlch9I=;
        b=LTq+HKll7G1J4n7xxlgV76n4uKnSJop9nNb3WLaYCLPngy3VP3VV1lIOJB+gF8GgWo
         5jT5JGt7FTpH6ajji7fTZspLqHytKH2oRO+dRI9qZktesgxvYkxIv1hWTr0nSI1gXJ67
         6MraJXAFBzgIIF+2Jj9dwBrULegoj/j+ed1As78+6aAp0YugIXqV8Y4+7YU+JGOwx7LF
         xHxV90K7rhmXvdJq6jF2VTcpiAUxYN+1OcxMnuus/FD9A3JBhlNE67rUUc1/HbiDRsh9
         Dbc4Lmg3+LsiROiuvKO3hM/3kWk7/DcLxctgbykUlVoUoug2rCrR6uJqwBwcAtm9C6rh
         N7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OdtLRwHCQikPA5pU9bHeW5G3cAhq/A9PizlP8Wlch9I=;
        b=U+hyZwCJvFIEAIzSHjXO/j2Dz4g9c1Oje5Q+y15Bm1E4sEflv//bGNmeS5ZvxFriCu
         q1B0m6Ll2SVs0n+lSDMvuRgrEO+e6hWW0iswgsyqhG7MgdoLOzIpeEz4YWIfJBQk+Wye
         8ktlWcOsMfkVseNkoQE8sZ8rPOTHYCX9DwF/nPtC7SZAT+0uAHajCA4TPpXLPTbkf+kM
         Qa0Tkury7A8hkVlQcJy7M1vPGc+Z87v/vxXWU5VzMS+HiCOHp4L3tBNE+PEC47RmvSc/
         st2xuCWBePsg1ef1mjcH4/HQmncLJj1d40JpEANd2zTdWgu2dl/1OICRyU46rJnu+tDd
         Fm9Q==
X-Gm-Message-State: AOAM533cOft8L3Khx+yDn7rvqTuQu6nFVdS8JDa4i1bZg/0Da1LUk5wq
        +YyUFr6rELVhUylp90krYvON8U2vKZ8=
X-Google-Smtp-Source: ABdhPJyCShZBqJ3pYUMgEyfzUvKU7C6vTkGuAOHQpzuJVX9S+JCJ8wjGhnH1jBfB/bFD+HyzMHyWWQ==
X-Received: by 2002:a05:6000:1010:: with SMTP id a16mr25568221wrx.155.1638086321948;
        Sat, 27 Nov 2021 23:58:41 -0800 (PST)
Received: from lesale.home (194-166-82-161.adsl.highway.telekom.at. [194.166.82.161])
        by smtp.gmail.com with ESMTPSA id d15sm14271725wri.50.2021.11.27.23.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 23:58:41 -0800 (PST)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH tig 1/2] argv_format(): extract bool params into bitfield
Date:   Sun, 28 Nov 2021 08:58:17 +0100
Message-Id: <20211128075818.981790-2-aclopte@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211128075818.981790-1-aclopte@gmail.com>
References: <20211128075818.981790-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

argv_format() takes two boolean parameters, and the next patch wants
to add another one.

Add the same bitfield to struct format_context, instead of just the
file-filter bit.  This is not strictly needed -- we don't read the
extra bits -- but this forces us to consistently access it with "&
argv_flag_file_filter", also in callees of argv_format().
---
 include/tig/argv.h |  7 ++++++-
 src/argv.c         | 14 +++++++-------
 src/prompt.c       |  6 +++---
 src/reflog.c       |  2 +-
 src/refs.c         |  2 +-
 src/stash.c        |  2 +-
 src/status.c       |  2 +-
 src/view.c         |  8 ++++++--
 8 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/include/tig/argv.h b/include/tig/argv.h
index cc8a5691..395ede94 100644
--- a/include/tig/argv.h
+++ b/include/tig/argv.h
@@ -69,7 +69,12 @@ struct argv_env {
 
 extern struct argv_env argv_env;
 
-bool argv_format(struct argv_env *argv_env, const char ***dst_argv, const char *src_argv[], bool first, bool file_filter);
+enum argv_flag {
+	argv_flag_first = 1 << 0,
+	argv_flag_file_filter = 1 << 1,
+};
+
+bool argv_format(struct argv_env *argv_env, const char ***dst_argv, const char *src_argv[], int flags);
 char *argv_format_arg(struct argv_env *argv_env, const char *src_arg);
 
 struct rev_flags {
diff --git a/src/argv.c b/src/argv.c
index 5ba7fc17..40e9256e 100644
--- a/src/argv.c
+++ b/src/argv.c
@@ -277,7 +277,7 @@ struct format_context {
 	size_t vars_size;
 	char buf[SIZEOF_MED_STR];
 	size_t bufpos;
-	bool file_filter;
+	int argv_flags;
 };
 
 #define ARGV_ENV_INIT(type, name, ifempty, initval)	initval,
@@ -318,7 +318,7 @@ format_expand_arg(struct format_context *format, const char *name, const char *e
 		if (string_enum_compare(name, vars[i].name, vars[i].namelen))
 			continue;
 
-		if (vars[i].value_ref == &argv_env.file && !format->file_filter)
+		if (vars[i].value_ref == &argv_env.file && !(format->argv_flags & argv_flag_file_filter))
 			return true;
 
 		return vars[i].formatter(format, &vars[i]);
@@ -420,7 +420,7 @@ repo_rev_formatter(struct format_context *format, struct format_var *var)
 }
 
 bool
-argv_format(struct argv_env *argv_env, const char ***dst_argv, const char *src_argv[], bool first, bool file_filter)
+argv_format(struct argv_env *argv_env, const char ***dst_argv, const char *src_argv[], int flags)
 {
 	struct format_var vars[] = {
 #define FORMAT_VAR(type, name, ifempty, initval) \
@@ -430,7 +430,7 @@ argv_format(struct argv_env *argv_env, const char ***dst_argv, const char *src_a
 	{ "%(repo:" #name ")", STRING_SIZE("%(repo:" #name ")"), type ## _formatter, &repo.name, "" },
 		REPO_INFO(FORMAT_REPO_VAR)
 	};
-	struct format_context format = { vars, ARRAY_SIZE(vars), "", 0, file_filter };
+	struct format_context format = { vars, ARRAY_SIZE(vars), "", 0, flags };
 	int argc;
 
 	argv_free(*dst_argv);
@@ -439,7 +439,7 @@ argv_format(struct argv_env *argv_env, const char ***dst_argv, const char *src_a
 		const char *arg = src_argv[argc];
 
 		if (!strcmp(arg, "%(fileargs)")) {
-			if (file_filter && !argv_append_array(dst_argv, opt_file_args))
+			if ((flags & argv_flag_file_filter) && !argv_append_array(dst_argv, opt_file_args))
 				break;
 
 		} else if (!strcmp(arg, DIFF_ARGS)) {
@@ -463,7 +463,7 @@ argv_format(struct argv_env *argv_env, const char ***dst_argv, const char *src_a
 				break;
 
 		} else if (!strcmp(arg, "%(revargs)") ||
-			   (first && !strcmp(arg, "%(commit)"))) {
+			   ((flags & argv_flag_first) && !strcmp(arg, "%(commit)"))) {
 			if (!argv_append_array(dst_argv, opt_rev_args))
 				break;
 
@@ -606,7 +606,7 @@ argv_format_arg(struct argv_env *argv_env, const char *src_arg)
 	const char **dst_argv = NULL;
 	char *dst_arg = NULL;
 
-	if (argv_format(argv_env, &dst_argv, src_argv, false, true))
+	if (argv_format(argv_env, &dst_argv, src_argv, argv_flag_file_filter))
 		dst_arg = (char *) dst_argv[0];
 
 	free(dst_argv);
diff --git a/src/prompt.c b/src/prompt.c
index bc037a95..961b61d3 100644
--- a/src/prompt.c
+++ b/src/prompt.c
@@ -939,7 +939,7 @@ run_prompt_command(struct view *view, const char *argv[])
 
 		/* Trim the leading '!'. */
 		argv[0] = cmd + 1;
-		copied = argv_format(view->env, &next->argv, argv, false, true);
+		copied = argv_format(view->env, &next->argv, argv, argv_flag_file_filter);
 		argv[0] = cmd;
 
 		if (!copied) {
@@ -967,7 +967,7 @@ run_prompt_command(struct view *view, const char *argv[])
 
 		if (argv[1]
 		    && strlen(argv[1]) > 0
-		    && (!argv_format(view->env, &fmt_argv, &argv[1], false, true)
+		    && (!argv_format(view->env, &fmt_argv, &argv[1], argv_flag_file_filter)
 			|| !argv_to_string(fmt_argv, text, sizeof(text), " ")
 			)) {
 			report("Failed to format echo string");
@@ -1102,7 +1102,7 @@ exec_run_request(struct view *view, struct run_request *req)
 
 	if (!argv_to_string(req->argv, cmd, sizeof(cmd), " ")
 	    || !argv_from_string_no_quotes(req_argv, &req_argc, cmd)
-	    || !argv_format(view->env, &argv, req_argv, false, true)
+	    || !argv_format(view->env, &argv, req_argv, argv_flag_file_filter)
 	    || !argv) {
 		report("Failed to format arguments");
 		return REQ_NONE;
diff --git a/src/reflog.c b/src/reflog.c
index 67a10694..0f5dd0eb 100644
--- a/src/reflog.c
+++ b/src/reflog.c
@@ -48,7 +48,7 @@ reflog_request(struct view *view, enum request request, struct line *line)
 		};
 		enum open_flags flags = view_is_displayed(view) ? OPEN_SPLIT : OPEN_DEFAULT;
 
-		if (!argv_format(main_view.env, &main_view.argv, main_argv, false, false))
+		if (!argv_format(main_view.env, &main_view.argv, main_argv, 0))
 			report("Failed to format argument");
 		else
 			open_main_view(view, flags | OPEN_PREPARED);
diff --git a/src/refs.c b/src/refs.c
index 86ff4032..49b12726 100644
--- a/src/refs.c
+++ b/src/refs.c
@@ -81,7 +81,7 @@ refs_request(struct view *view, enum request request, struct line *line)
 		};
 		enum open_flags flags = view_is_displayed(view) ? OPEN_SPLIT : OPEN_DEFAULT;
 
-		if (!argv_format(main_view.env, &main_view.argv, all_references_argv, false, false))
+		if (!argv_format(main_view.env, &main_view.argv, all_references_argv, 0))
 			report("Failed to format argument");
 		else
 			open_main_view(view, flags | OPEN_PREPARED);
diff --git a/src/stash.c b/src/stash.c
index c32bcab7..255c8052 100644
--- a/src/stash.c
+++ b/src/stash.c
@@ -87,7 +87,7 @@ stash_request(struct view *view, enum request request, struct line *line)
 					"--no-color", "%(stash)", NULL
 			};
 
-			if (!argv_format(diff_view.env, &diff_view.argv, diff_argv, false, false))
+			if (!argv_format(diff_view.env, &diff_view.argv, diff_argv, 0))
 				report("Failed to format argument");
 			else
 				open_diff_view(view, flags | OPEN_PREPARED);
diff --git a/src/status.c b/src/status.c
index 6e3953b5..c3f1e262 100644
--- a/src/status.c
+++ b/src/status.c
@@ -91,7 +91,7 @@ status_run(struct view *view, const char *argv[], char status, enum line_type ty
 	struct buffer buf;
 	struct io io;
 	const char **status_argv = NULL;
-	bool ok = argv_format(view->env, &status_argv, argv, false, false) &&
+	bool ok = argv_format(view->env, &status_argv, argv, 0) &&
 		  io_run(&io, IO_RD, repo.exec_dir, NULL, status_argv);
 
 	argv_free(status_argv);
diff --git a/src/view.c b/src/view.c
index 52c808d1..4da10581 100644
--- a/src/view.c
+++ b/src/view.c
@@ -575,10 +575,14 @@ begin_update(struct view *view, const char *dir, const char **argv, enum open_fl
 	view->unrefreshable = open_in_pager_mode(flags);
 
 	if (!refresh && argv) {
-		bool file_filter = !view_has_flags(view, VIEW_FILE_FILTER) || opt_file_filter;
+		int flags = 0;
+		if (!view->prev)
+			flags |= argv_flag_first;
+		if (!view_has_flags(view, VIEW_FILE_FILTER) || opt_file_filter)
+			flags |= argv_flag_file_filter;
 
 		view->dir = dir;
-		if (!argv_format(view->env, &view->argv, argv, !view->prev, file_filter))
+		if (!argv_format(view->env, &view->argv, argv, flags))
 			return error("Failed to format %s arguments", view->name);
 	}
 
-- 
2.33.1

