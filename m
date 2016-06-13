From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 09/40] builtin/apply: move init_apply_state() to apply.c
Date: Mon, 13 Jun 2016 18:09:11 +0200
Message-ID: <20160613160942.1806-10-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:10:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCURU-0003aP-Ot
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424894AbcFMQKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34987 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424605AbcFMQKL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id k184so16026385wme.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1mHJb1uJog9JipAB2kQt33B9FlkBgWDkr6jyScW5Uok=;
        b=x/b9hawMW1AuknV928MOZhPjBbTlsaYCwvUUyPuMMbbGyRjNVSnjh0oo+0KhXrih1l
         hU9veVMoXwgCefRxNdHjyLHpe2aFMP5d1aI9d9Iztruu/uiS1JPOoq7HaZYJx0CWO4QE
         U/n1W0lYpPENtrzupuwSjXUv9gvusnj8Ndt6ZfBp5rnzVIY3S/QZcv1yJ4tsscgJSxu+
         aHp544hm3G3lHSujo3VZ0DhanB5AeO7u9efy6MIWLiW2SFa9yBaePTjmdmp320N9fmmV
         RleoOCU9GnUvFwpZH1tBWI83clBSVkhvLnOl6VXK1q3nk0XjEwDta6XAOanHbG+E/xqO
         PgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1mHJb1uJog9JipAB2kQt33B9FlkBgWDkr6jyScW5Uok=;
        b=G+vJtrrc0SVCPUxqbBFRmo4LHtrogJguqFAAykvp+Xu5IKRH2uoW6Px2iyuhRwYSWH
         XI+ckMLqOEI5ARmonTe67PyLe4lX8aTFxNCi6vWIFtVezm9DyZ2FY9Cg0Kq+J51MDrkc
         v5OElkz5lnKW7JJHOz8nlnnjLypF4RbwPDscZetT+wGVLiC44HMLFP1yfDxXfNWgCdz7
         eQb5LFzPTjTwrwjE9sLCGbn9PBtH14bMbZ4MWqSWxrwshILK3289ALslvWy7utQowZs7
         ntok3j+72RlveKXVMDWr2wb9pzjGsINp6iIMOQubNUNqMA/aFbvftDqd+/gbvdNTwwtb
         rbxw==
X-Gm-Message-State: ALyK8tJ3AXIEjDkiWvRkV5h9CotGjlRRcTazBhv/aqjY5oALZ+Lwzs17fMtBuVEnY3+LyA==
X-Received: by 10.28.178.135 with SMTP id b129mr361273wmf.60.1465834209429;
        Mon, 13 Jun 2016 09:10:09 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:08 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297197>

To libify `git apply` functionality we must make init_apply_state()
usable outside "builtin/apply.c".

Let's do that by moving it into a new "apply.c".

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile        |  1 +
 apply.c         | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 apply.h         | 10 +++++++
 builtin/apply.c | 88 -------------------------------------------------------
 4 files changed, 102 insertions(+), 88 deletions(-)
 create mode 100644 apply.c

diff --git a/Makefile b/Makefile
index 6b05249..6da1209 100644
--- a/Makefile
+++ b/Makefile
@@ -680,6 +680,7 @@ LIB_OBJS += abspath.o
 LIB_OBJS += advice.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
+LIB_OBJS += apply.o
 LIB_OBJS += archive.o
 LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
diff --git a/apply.c b/apply.c
new file mode 100644
index 0000000..1f31bb4
--- /dev/null
+++ b/apply.c
@@ -0,0 +1,91 @@
+#include "cache.h"
+#include "lockfile.h"
+#include "apply.h"
+
+static void git_apply_config(void)
+{
+	git_config_get_string_const("apply.whitespace", &apply_default_whitespace);
+	git_config_get_string_const("apply.ignorewhitespace", &apply_default_ignorewhitespace);
+	git_config(git_default_config, NULL);
+}
+
+int parse_whitespace_option(struct apply_state *state, const char *option)
+{
+	if (!option) {
+		state->ws_error_action = warn_on_ws_error;
+		return 0;
+	}
+	if (!strcmp(option, "warn")) {
+		state->ws_error_action = warn_on_ws_error;
+		return 0;
+	}
+	if (!strcmp(option, "nowarn")) {
+		state->ws_error_action = nowarn_ws_error;
+		return 0;
+	}
+	if (!strcmp(option, "error")) {
+		state->ws_error_action = die_on_ws_error;
+		return 0;
+	}
+	if (!strcmp(option, "error-all")) {
+		state->ws_error_action = die_on_ws_error;
+		state->squelch_whitespace_errors = 0;
+		return 0;
+	}
+	if (!strcmp(option, "strip") || !strcmp(option, "fix")) {
+		state->ws_error_action = correct_ws_error;
+		return 0;
+	}
+	return error(_("unrecognized whitespace option '%s'"), option);
+}
+
+int parse_ignorewhitespace_option(struct apply_state *state,
+				  const char *option)
+{
+	if (!option || !strcmp(option, "no") ||
+	    !strcmp(option, "false") || !strcmp(option, "never") ||
+	    !strcmp(option, "none")) {
+		state->ws_ignore_action = ignore_ws_none;
+		return 0;
+	}
+	if (!strcmp(option, "change")) {
+		state->ws_ignore_action = ignore_ws_change;
+		return 0;
+	}
+	return error(_("unrecognized whitespace ignore option '%s'"), option);
+}
+
+void init_apply_state(struct apply_state *state,
+		      const char *prefix,
+		      struct lock_file *lock_file)
+{
+	memset(state, 0, sizeof(*state));
+	state->prefix = prefix;
+	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
+	state->lock_file = lock_file;
+	state->newfd = -1;
+	state->apply = 1;
+	state->line_termination = '\n';
+	state->p_value = 1;
+	state->p_context = UINT_MAX;
+	state->squelch_whitespace_errors = 5;
+	state->ws_error_action = warn_on_ws_error;
+	state->ws_ignore_action = ignore_ws_none;
+	state->linenr = 1;
+	strbuf_init(&state->root, 0);
+
+	git_apply_config();
+	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
+		exit(1);
+	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
+		exit(1);
+}
+
+void clear_apply_state(struct apply_state *state)
+{
+	string_list_clear(&state->limit_by_name, 0);
+	string_list_clear(&state->symlink_changes, 0);
+	strbuf_release(&state->root);
+
+	/* &state->fn_table is cleared at the end of apply_patch() */
+}
diff --git a/apply.h b/apply.h
index 9a98eae..77502be 100644
--- a/apply.h
+++ b/apply.h
@@ -97,4 +97,14 @@ struct apply_state {
 	int applied_after_fixing_ws;
 };
 
+extern int parse_whitespace_option(struct apply_state *state,
+				   const char *option);
+extern int parse_ignorewhitespace_option(struct apply_state *state,
+					 const char *option);
+
+extern void init_apply_state(struct apply_state *state,
+			     const char *prefix,
+			     struct lock_file *lock_file);
+extern void clear_apply_state(struct apply_state *state);
+
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index e2f970d..bc15545 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -27,52 +27,6 @@ static const char * const apply_usage[] = {
 	NULL
 };
 
-static int parse_whitespace_option(struct apply_state *state, const char *option)
-{
-	if (!option) {
-		state->ws_error_action = warn_on_ws_error;
-		return 0;
-	}
-	if (!strcmp(option, "warn")) {
-		state->ws_error_action = warn_on_ws_error;
-		return 0;
-	}
-	if (!strcmp(option, "nowarn")) {
-		state->ws_error_action = nowarn_ws_error;
-		return 0;
-	}
-	if (!strcmp(option, "error")) {
-		state->ws_error_action = die_on_ws_error;
-		return 0;
-	}
-	if (!strcmp(option, "error-all")) {
-		state->ws_error_action = die_on_ws_error;
-		state->squelch_whitespace_errors = 0;
-		return 0;
-	}
-	if (!strcmp(option, "strip") || !strcmp(option, "fix")) {
-		state->ws_error_action = correct_ws_error;
-		return 0;
-	}
-	return error(_("unrecognized whitespace option '%s'"), option);
-}
-
-static int parse_ignorewhitespace_option(struct apply_state *state,
-					 const char *option)
-{
-	if (!option || !strcmp(option, "no") ||
-	    !strcmp(option, "false") || !strcmp(option, "never") ||
-	    !strcmp(option, "none")) {
-		state->ws_ignore_action = ignore_ws_none;
-		return 0;
-	}
-	if (!strcmp(option, "change")) {
-		state->ws_ignore_action = ignore_ws_change;
-		return 0;
-	}
-	return error(_("unrecognized whitespace ignore option '%s'"), option);
-}
-
 static void set_default_whitespace_mode(struct apply_state *state)
 {
 	if (!state->whitespace_option && !apply_default_whitespace)
@@ -4529,13 +4483,6 @@ end:
 	return res;
 }
 
-static void git_apply_config(void)
-{
-	git_config_get_string_const("apply.whitespace", &apply_default_whitespace);
-	git_config_get_string_const("apply.ignorewhitespace", &apply_default_ignorewhitespace);
-	git_config(git_default_config, NULL);
-}
-
 static int option_parse_exclude(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -4594,41 +4541,6 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static void init_apply_state(struct apply_state *state,
-			     const char *prefix,
-			     struct lock_file *lock_file)
-{
-	memset(state, 0, sizeof(*state));
-	state->prefix = prefix;
-	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
-	state->lock_file = lock_file;
-	state->newfd = -1;
-	state->apply = 1;
-	state->line_termination = '\n';
-	state->p_value = 1;
-	state->p_context = UINT_MAX;
-	state->squelch_whitespace_errors = 5;
-	state->ws_error_action = warn_on_ws_error;
-	state->ws_ignore_action = ignore_ws_none;
-	state->linenr = 1;
-	strbuf_init(&state->root, 0);
-
-	git_apply_config();
-	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
-		exit(1);
-	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
-		exit(1);
-}
-
-static void clear_apply_state(struct apply_state *state)
-{
-	string_list_clear(&state->limit_by_name, 0);
-	string_list_clear(&state->symlink_changes, 0);
-	strbuf_release(&state->root);
-
-	/* &state->fn_table is cleared at the end of apply_patch() */
-}
-
 static void check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
-- 
2.9.0.rc2.411.g3e2ca28
