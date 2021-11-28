Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C65CC433F5
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 08:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356386AbhK1IEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 03:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356166AbhK1ICH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 03:02:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F33C061748
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 23:58:51 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c4so29206658wrd.9
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 23:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95ueL+o+J4xP799GdklJ58l1cZqmUQRh72GVTLQ9x+g=;
        b=J8mJZIdrx6QdLn37Nzyx+zzmh3QAHBuKe3N4dt5jIEpNlVhM6H/fLD0KspA5KYa9GJ
         ieTPWuY9cBBpyjfv0Rp9jrTiAgfQ/x5NaM0zu54X7dYuhB6sMEPFcReCrROnhC32jLUB
         2wIhFWiAFbz7jco5hi0RJxG90QG3gFNEjM285wNOtGzFmeQA9bwNWU9ssTCrFzYIue04
         PWSuirCJpL3zSjNt7YOfLI8Oiy1DMh+oKurR4g08YSwT9ntCJMILA/mDglIyokGNXbiY
         GjBeDuDJUgtUr6gdmSi3q7k4/VWFvx6tLpAL5rzrYJrSC4D/Ll+Fl632aBQlAV8L6Qya
         +1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95ueL+o+J4xP799GdklJ58l1cZqmUQRh72GVTLQ9x+g=;
        b=Hl+Ua48zug2mOyzL/MJi1MDBHAvPRe0PCgbD5vBUBA+H5/jv1c4VW/g0KwEmojQyJ4
         Bco+gkdZZNk3kGLk+5ZFQZXaEUUov7pvHfrRN8TA6p2CsrucEv9JIXJFlmSHboaPAe7N
         xb2NBtiBQQ0Dg+Uy6XpcasXORx7LpLip+rALz8mCBP4+MftHfgUh0fQlegmaXdqFg/I5
         TAb7pRmmPKkJhglW09arC6gdcpT1kaT4+pbbR7+vzb/83t2M/VtLgWI0MFK8/Swgu+J7
         2lq7N+56S38Ak9fW9BXySZOSPXOKJm4XmIDPzDK4EuCFO8HDqVG61FGjoGDwYdhevi/p
         d7xw==
X-Gm-Message-State: AOAM533NP5bt5+U4BMY6gfed1vyyvOihpPrLlLJDd5wFcyfoRs8t6EwK
        i1Ku69X1WmjLvF3VSAIf9X/eEEaRGCA=
X-Google-Smtp-Source: ABdhPJzUOYRol7hyOZdJwozfYixTFXbSnCQAWLbwd6i45kp5EZrBkLTt0MiT3m6uMKtCsBw9Quuwug==
X-Received: by 2002:adf:c5d1:: with SMTP id v17mr25292466wrg.571.1638086330412;
        Sat, 27 Nov 2021 23:58:50 -0800 (PST)
Received: from lesale.home (194-166-82-161.adsl.highway.telekom.at. [194.166.82.161])
        by smtp.gmail.com with ESMTPSA id d15sm14271725wri.50.2021.11.27.23.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 23:58:49 -0800 (PST)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH tig 2/2] Allow to toggle revision filter
Date:   Sun, 28 Nov 2021 08:58:18 +0100
Message-Id: <20211128075818.981790-3-aclopte@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211128075818.981790-1-aclopte@gmail.com>
References: <20211128075818.981790-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"tig -- <pathspec>" shows only commits that touch files matching
<pathspec>.  The command ":toggle file-filter" (bound to %) can be
used to toggle this filtering dynamically.

"tig <revisions range>" shows only commits in the given range.
This patch adds ":toggle rev-filter" (bound to ^) to quickly toggle
this filter.

There is already ":toggle rev-args" which is meant to disable rev
filtering but that does not work because it fails to redraw the
view. Also it cannot re-enable filtering.
Also ":set rev-args = HEAD" works but doesn't redraw the view either.
We should fix that (should be easy but I didn't check yet), and make
":toggle rev-args" reversible, then both the rev-filter and file-filter
toggles will be obsolete.

This feature is particularly useful with a new feature in Tig 2.5.2:
when pressing m in the blame view, Tig will show the blamed commit
centered in the main view, making it easy to explore adjacent
commits. Note that if there are many commits between the blamed commit
and HEAD, you'll need to wait a bit after pressing m.
---
 doc/manual.adoc                         |  1 +
 include/tig/argv.h                      |  1 +
 include/tig/options.h                   |  1 +
 include/tig/view.h                      | 15 ++++++++-------
 src/argv.c                              |  4 ++--
 src/main.c                              |  2 +-
 src/options.c                           |  2 ++
 src/prompt.c                            |  6 +++---
 src/tig.c                               |  1 +
 src/view.c                              |  2 ++
 test/help/all-keybindings-test          |  2 +-
 test/help/all-keybindings-test.expected |  3 ++-
 test/help/default-test                  |  4 ++--
 test/help/user-command-test             |  2 +-
 tigrc                                   |  3 ++-
 15 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/doc/manual.adoc b/doc/manual.adoc
index 8f456d26..81f06535 100644
--- a/doc/manual.adoc
+++ b/doc/manual.adoc
@@ -470,6 +470,7 @@ Misc
 |X	|Toggle commit ID display on/off
 |%	|Toggle file filtering in order to see the full diff instead of only
 	 the diff concerning the currently selected file.
+|^      |Toggle revision filtering in the main view.
 |$	|Toggle highlighting of commit title overflow.
 |H	|Go to the HEAD commit.
 |:	|Open prompt. This allows you to specify what command to run and also to
diff --git a/include/tig/argv.h b/include/tig/argv.h
index 395ede94..96bb2bd5 100644
--- a/include/tig/argv.h
+++ b/include/tig/argv.h
@@ -72,6 +72,7 @@ extern struct argv_env argv_env;
 enum argv_flag {
 	argv_flag_first = 1 << 0,
 	argv_flag_file_filter = 1 << 1,
+	argv_flag_rev_filter = 1 << 2,
 };
 
 bool argv_format(struct argv_env *argv_env, const char ***dst_argv, const char *src_argv[], int flags);
diff --git a/include/tig/options.h b/include/tig/options.h
index 9fc1eecc..1550dbea 100644
--- a/include/tig/options.h
+++ b/include/tig/options.h
@@ -69,6 +69,7 @@ typedef struct view_column *view_settings;
 	_(refresh_mode,			enum refresh_mode,	VIEW_NO_FLAGS) \
 	_(refs_view,			view_settings,		VIEW_NO_FLAGS) \
 	_(rev_args,			const char **,		VIEW_NO_FLAGS) \
+	_(rev_filter,			bool,			VIEW_LOG_LIKE) \
 	_(send_child_enter,		bool,			VIEW_NO_FLAGS) \
 	_(show_changes,			bool,			VIEW_NO_FLAGS) \
 	_(show_notes,			bool,			VIEW_NO_FLAGS) \
diff --git a/include/tig/view.h b/include/tig/view.h
index a0defaf4..83fc6535 100644
--- a/include/tig/view.h
+++ b/include/tig/view.h
@@ -65,13 +65,14 @@ enum view_flag {
 	VIEW_BLAME_LIKE		= 1 << 8,
 	VIEW_SEND_CHILD_ENTER	= 1 << 9,
 	VIEW_FILE_FILTER	= 1 << 10,
-	VIEW_LOG_LIKE		= 1 << 11,
-	VIEW_STATUS_LIKE	= 1 << 12,
-	VIEW_REFRESH		= 1 << 13,
-	VIEW_GREP_LIKE		= 1 << 14,
-	VIEW_SORTABLE		= 1 << 15,
-	VIEW_FLEX_WIDTH		= 1 << 16,
-	VIEW_RESET_DISPLAY	= 1 << 17,
+	VIEW_REV_FILTER		= 1 << 11,
+	VIEW_LOG_LIKE		= 1 << 12,
+	VIEW_STATUS_LIKE	= 1 << 13,
+	VIEW_REFRESH		= 1 << 14,
+	VIEW_GREP_LIKE		= 1 << 15,
+	VIEW_SORTABLE		= 1 << 16,
+	VIEW_FLEX_WIDTH		= 1 << 17,
+	VIEW_RESET_DISPLAY	= 1 << 18,
 };
 
 #define view_has_flags(view, flag)	((view)->ops->flags & (flag))
diff --git a/src/argv.c b/src/argv.c
index 40e9256e..154c3767 100644
--- a/src/argv.c
+++ b/src/argv.c
@@ -464,7 +464,7 @@ argv_format(struct argv_env *argv_env, const char ***dst_argv, const char *src_a
 
 		} else if (!strcmp(arg, "%(revargs)") ||
 			   ((flags & argv_flag_first) && !strcmp(arg, "%(commit)"))) {
-			if (!argv_append_array(dst_argv, opt_rev_args))
+			if ((flags & argv_flag_rev_filter) && !argv_append_array(dst_argv, opt_rev_args))
 				break;
 
 		} else if (!format_append_arg(&format, dst_argv, arg)) {
@@ -606,7 +606,7 @@ argv_format_arg(struct argv_env *argv_env, const char *src_arg)
 	const char **dst_argv = NULL;
 	char *dst_arg = NULL;
 
-	if (argv_format(argv_env, &dst_argv, src_argv, argv_flag_file_filter))
+	if (argv_format(argv_env, &dst_argv, src_argv, argv_flag_file_filter | argv_flag_rev_filter))
 		dst_arg = (char *) dst_argv[0];
 
 	free(dst_argv);
diff --git a/src/main.c b/src/main.c
index 54ca950c..d6f656be 100644
--- a/src/main.c
+++ b/src/main.c
@@ -629,7 +629,7 @@ main_select(struct view *view, struct line *line)
 static struct view_ops main_ops = {
 	"commit",
 	argv_env.head,
-	VIEW_SEND_CHILD_ENTER | VIEW_FILE_FILTER | VIEW_LOG_LIKE | VIEW_REFRESH,
+	VIEW_SEND_CHILD_ENTER | VIEW_FILE_FILTER | VIEW_REV_FILTER | VIEW_LOG_LIKE | VIEW_REFRESH,
 	sizeof(struct main_state),
 	main_open,
 	main_read,
diff --git a/src/options.c b/src/options.c
index f5ee2bc2..4977da80 100644
--- a/src/options.c
+++ b/src/options.c
@@ -873,6 +873,7 @@ option_bind_command(int argc, const char *argv[])
 			{ "toggle-date",		"date" },
 			{ "toggle-files",		"file-filter" },
 			{ "toggle-file-filter",		"file-filter" },
+			{ "toggle-rev-filter",		"rev-filter" },
 			{ "toggle-file-size",		"file-size" },
 			{ "toggle-filename",		"filename" },
 			{ "toggle-graphic",		"show-graphic" },
@@ -1058,6 +1059,7 @@ load_options(void)
 	char buf[SIZEOF_STR];
 
 	opt_file_filter = true;
+	opt_rev_filter = true;
 	if (!find_option_info_by_value(&opt_diff_context)->seen)
 		opt_diff_context = -3;
 
diff --git a/src/prompt.c b/src/prompt.c
index 961b61d3..b0ed7a45 100644
--- a/src/prompt.c
+++ b/src/prompt.c
@@ -939,7 +939,7 @@ run_prompt_command(struct view *view, const char *argv[])
 
 		/* Trim the leading '!'. */
 		argv[0] = cmd + 1;
-		copied = argv_format(view->env, &next->argv, argv, argv_flag_file_filter);
+		copied = argv_format(view->env, &next->argv, argv, argv_flag_file_filter | argv_flag_rev_filter);
 		argv[0] = cmd;
 
 		if (!copied) {
@@ -967,7 +967,7 @@ run_prompt_command(struct view *view, const char *argv[])
 
 		if (argv[1]
 		    && strlen(argv[1]) > 0
-		    && (!argv_format(view->env, &fmt_argv, &argv[1], argv_flag_file_filter)
+		    && (!argv_format(view->env, &fmt_argv, &argv[1], argv_flag_file_filter | argv_flag_rev_filter)
 			|| !argv_to_string(fmt_argv, text, sizeof(text), " ")
 			)) {
 			report("Failed to format echo string");
@@ -1102,7 +1102,7 @@ exec_run_request(struct view *view, struct run_request *req)
 
 	if (!argv_to_string(req->argv, cmd, sizeof(cmd), " ")
 	    || !argv_from_string_no_quotes(req_argv, &req_argc, cmd)
-	    || !argv_format(view->env, &argv, req_argv, argv_flag_file_filter)
+	    || !argv_format(view->env, &argv, req_argv, argv_flag_file_filter | argv_flag_rev_filter)
 	    || !argv) {
 		report("Failed to format arguments");
 		return REQ_NONE;
diff --git a/src/tig.c b/src/tig.c
index 1c332f52..4546a7cf 100644
--- a/src/tig.c
+++ b/src/tig.c
@@ -104,6 +104,7 @@ view_request(struct view *view, enum request request)
 	_('C', "local change display",		"show-changes"), \
 	_('X', "commit ID display",		"id"), \
 	_('%', "file filtering",		"file-filter"), \
+	_('^', "revision filtering",		"rev-filter"), \
 	_('$', "commit title overflow display",	"commit-title-overflow"), \
 	_('d', "untracked directory info",	"status-show-untracked-dirs"), \
 	_('|', "view split",			"vertical-split"), \
diff --git a/src/view.c b/src/view.c
index 4da10581..f4f3dea9 100644
--- a/src/view.c
+++ b/src/view.c
@@ -580,6 +580,8 @@ begin_update(struct view *view, const char *dir, const char **argv, enum open_fl
 			flags |= argv_flag_first;
 		if (!view_has_flags(view, VIEW_FILE_FILTER) || opt_file_filter)
 			flags |= argv_flag_file_filter;
+		if (!view_has_flags(view, VIEW_REV_FILTER) || opt_rev_filter)
+			flags |= argv_flag_rev_filter;
 
 		view->dir = dir;
 		if (!argv_format(view->env, &view->argv, argv, flags))
diff --git a/test/help/all-keybindings-test b/test/help/all-keybindings-test
index f47b6dcd..1139e4bd 100755
--- a/test/help/all-keybindings-test
+++ b/test/help/all-keybindings-test
@@ -3,7 +3,7 @@
 . libtest.sh
 
 export COLUMNS=90
-export LINES=129
+export LINES=130
 
 steps '
 	:view-help
diff --git a/test/help/all-keybindings-test.expected b/test/help/all-keybindings-test.expected
index f69e1703..ae66028a 100755
--- a/test/help/all-keybindings-test.expected
+++ b/test/help/all-keybindings-test.expected
@@ -68,6 +68,7 @@ Option toggling:
                            X :toggle id
                            $ :toggle commit-title-overflow
                            % :toggle file-filter
+                           ^ :toggle rev-filter
 [-] search bindings
 View manipulation
                     <Ctrl-C> view-close          Close the current view
@@ -125,4 +126,4 @@ External commands:
 [-] pager bindings
 Internal commands:
                            @ :/^@@
-[help] - line 1 of 127                                                                100%
+[help] - line 1 of 128                                                                 100%
diff --git a/test/help/default-test b/test/help/default-test
index f60bcd13..8adb397f 100755
--- a/test/help/default-test
+++ b/test/help/default-test
@@ -51,7 +51,7 @@ View manipulation
                      R, <F5> refresh             Reload and refresh view
                            O maximize            Maximize the current view
                            q view-close          Close the current view
-[help] - line 1 of 127                                                       22%
+[help] - line 1 of 128                                                       21%
 EOF
 
 assert_equals 'help-search.screen' <<EOF
@@ -83,7 +83,7 @@ View manipulation
                      R, <F5> refresh             Reload and refresh view
                            O maximize            Maximize the current view
                            q view-close          Close the current view
-[help] - line 19 of 127                                                      22%
+[help] - line 19 of 128                                                      21%
 EOF
 
 assert_equals 'help-collapsed.screen' <<EOF
diff --git a/test/help/user-command-test b/test/help/user-command-test
index c0218bf5..9de58285 100755
--- a/test/help/user-command-test
+++ b/test/help/user-command-test
@@ -55,5 +55,5 @@ Searching
 [-] main bindings
 Cursor navigation
                               G move-last-line      Move cursor to last line
-[help] - line 80 of 154                                                                          69%
+[help] - line 81 of 155                                                                          69%
 EOF
diff --git a/tigrc b/tigrc
index e2f1f84d..7e671fba 100644
--- a/tigrc
+++ b/tigrc
@@ -309,7 +309,8 @@ bind generic	$	:toggle commit-title-overflow
 # bind generic	???	:toggle status-show-untracked-dirs
 						# Toggle display of file in untracked directories
 # bind generic	???	:toggle vertical-split	# Toggle vertical split
-bind generic	%	:toggle file-filter
+bind generic	%	:toggle file-filter	# Toggle filtering by pathspecs in file-args
+bind generic	^	:toggle rev-filter	# Toggle filtering by revisions in rev-args
 
 # Misc
 bind generic	e	edit			# Open in editor
-- 
2.33.1

