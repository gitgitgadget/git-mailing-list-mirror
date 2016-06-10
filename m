From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 09/44] builtin/apply: move init_apply_state() to apply.c
Date: Fri, 10 Jun 2016 22:10:43 +0200
Message-ID: <20160610201118.13813-10-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSoH-0004Rt-Fp
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbcFJUMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36804 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbcFJULx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:11:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id m124so1033661wme.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eJqz0XNkGk+LNBzfhzKQcVLb86UfSH3Uk6BWPDE5Eiw=;
        b=1IJ2hCy6rwcdM+7WvK+V1TMFG+jcLbHFwlGezYZsi79eGK/hHJuiLsJ2+O7ZRkP8RX
         iN8hdGIj5X9aXmkpv9Gr1lILtvhAJ2GBDE7inV55/m0t9lGU3GTz+AIT1kdqtQf4MT69
         psyb8QkuvSFHRaFC/JlPVKOH3wvFyknrDGfwlq9w4x/2ZLc+6H1Lowrd1i7X31Jh53yo
         09Dg4wem4mLmKP/HxjHwswNkAwFoGR5FP6JMTYG1GBGBBP3I1SJXBz1LJF7ZQWesYzb4
         /1d1/2LqvnoDcUY7CnYRmeWI0pcQe0GCMszrQpluwOa9M4jmOWLmqK4jgIBrdl/GfJ0A
         8vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eJqz0XNkGk+LNBzfhzKQcVLb86UfSH3Uk6BWPDE5Eiw=;
        b=B+RHvV21jo+w8Fo7uoFgxfz5B/Kt/F79hJ2q5wp7RAM9IWQxZ9lurB19ekixO5LgFY
         rz/iKV0wr5Wqtx1vm/Ng9pP0NLZsyQPxvxLPuZR/jA1cyeNmV+BWY7K3i+Hn5mlUhY0/
         bR4StC/6pjfeEFuEkQS3S/fdp5yvZ7znQhSwwR64BcNOyoKUoStCTp5uO7tLXb6T+jZ4
         SqBm56HxlFFFP7xgM88M7jPbMQVpRxPuFxN862wVIPwDsG773EIhNFzlHTQys+WozlOf
         KutH/xSYjxmdXy5UrUys1gD38bBvh4jz4NoqVbDd6zXtiX7OZ4lLalmgUFbQejDopgbT
         b0fw==
X-Gm-Message-State: ALyK8tKsWu8qDYfK3+m8GK8lH8a/lykdtRukZkCytp59DbmEHurBa57GELkeNjI+LU8MoQ==
X-Received: by 10.28.129.197 with SMTP id c188mr705559wmd.46.1465589512233;
        Fri, 10 Jun 2016 13:11:52 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:11:51 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297061>

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
2.9.0.rc2.362.g3cd93d0
