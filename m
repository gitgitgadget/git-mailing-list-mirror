From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 59/83] builtin/apply: move init_apply_state() to apply.c
Date: Sun, 24 Apr 2016 15:33:59 +0200
Message-ID: <1461504863-15946-60-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKD1-0008PW-3U
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbcDXNgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:13 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36679 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbcDXNgK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:10 -0400
Received: by mail-wm0-f43.google.com with SMTP id v188so69574505wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uuMrGS3W4FB+OGb6zbPel3+YAtBAHydxFqaRfd+QgXM=;
        b=DFiKPES5EHCVzbXnmdOEQOKH8Div5LvMzNzss6BVaaJdLmiodgP4x3N4zPnD77u5X7
         f2aLPKn6d6BZ33/LAWbNrAD+dq7EHDAmXLwbXiYMBWQUWPjO1C/IFPrPUQgdNFGhirJC
         rSxrdUx0HRkqa4nyplJUtW8qw318fmB2fOwHGqPRIbkAg+5NQkX268xqi6d9sil2kBoq
         d2i0CLEnP5NXKMtATWqWr8YZmGza94AB4xnernUCUT4n8mrgUhSd+WjKaxygzIsgrwXG
         0Hhr+g5S0eRPk1UCH1YQtjDCk1Nb6rkhtPvEFVvqshNg0PWzZwonkee+/HUhJofjcHiJ
         1C0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uuMrGS3W4FB+OGb6zbPel3+YAtBAHydxFqaRfd+QgXM=;
        b=faaLxgldXISNH4OrIrtjs6072YfkgRqQaejYqouuH2MqcgsUjeIOCTqlgO6AYUbvcI
         4HQmwBfARBoq2kbYDIy6ZAt4+u/vdU0cItNzd9NQOBeOOkPtN664DKC1p4wFBn63TUY6
         8rB9IKzMtebp1P4K1BjhzF7DXni6NEuXNrCkXef8jJ5fWM1Y6UXdZsE2f00BwzByU/JY
         7aJ+fH0kZHJMIZm59jvx0vdMOqaUbeTmqwzvkl3O0CYlYGlvdnHj/G8oSeWWYZR0zMqU
         t6Hg2xY/aUAexqfOKNNa4/QFLOoCiqqXlMjdiMFC3FGgIV1BmLZMX33aEKeW3NuLEs5u
         Y7uA==
X-Gm-Message-State: AOPr4FUxZaYg7Aa0WFb636GrEpqUpbjq/wWLR12jMK2yZHu+SFmAXE4HqVG+5DsxFdlXMg==
X-Received: by 10.195.20.66 with SMTP id ha2mr28941620wjd.76.1461504968754;
        Sun, 24 Apr 2016 06:36:08 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:08 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292353>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile        |  1 +
 apply.c         | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 apply.h         |  8 ++++++
 builtin/apply.c | 75 -----------------------------------------------------
 4 files changed, 89 insertions(+), 75 deletions(-)
 create mode 100644 apply.c

diff --git a/Makefile b/Makefile
index a83e322..a8616fc 100644
--- a/Makefile
+++ b/Makefile
@@ -684,6 +684,7 @@ LIB_OBJS += abspath.o
 LIB_OBJS += advice.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
+LIB_OBJS += apply.o
 LIB_OBJS += archive.o
 LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
diff --git a/apply.c b/apply.c
new file mode 100644
index 0000000..9c5f258
--- /dev/null
+++ b/apply.c
@@ -0,0 +1,80 @@
+#include "cache.h"
+#include "apply.h"
+
+
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
+void init_apply_state(struct apply_state *state, const char *prefix)
+{
+	memset(state, 0, sizeof(*state));
+	state->prefix = prefix;
+	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
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
diff --git a/apply.h b/apply.h
index 98aafc6..70ab658 100644
--- a/apply.h
+++ b/apply.h
@@ -121,4 +121,12 @@ struct apply_state {
 	enum ws_ignore ws_ignore_action;
 };
 
+extern int parse_whitespace_option(struct apply_state *state,
+				   const char *option);
+extern int parse_ignorewhitespace_option(struct apply_state *state,
+					 const char *option);
+
+extern void init_apply_state(struct apply_state *state, const char *prefix);
+
+
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index 2f89922..1d958fa 100644
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
@@ -4522,13 +4476,6 @@ static int apply_patch(struct apply_state *state,
 	return 0;
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
@@ -4587,28 +4534,6 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static void init_apply_state(struct apply_state *state, const char *prefix)
-{
-	memset(state, 0, sizeof(*state));
-	state->prefix = prefix;
-	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
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
 static void check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
-- 
2.8.1.300.g5fed0c0
