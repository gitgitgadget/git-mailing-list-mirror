From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 59/94] builtin/apply: move init_apply_state() to apply.c
Date: Wed, 11 May 2016 15:17:10 +0200
Message-ID: <20160511131745.2914-60-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:20:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U4N-00047r-3d
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbcEKNUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35330 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932300AbcEKNU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id e201so9409710wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xRv0X+1/zXE108RukiKu9jD2ej9ZGOEl4nfipShz1g4=;
        b=aA40AQYSc/gDq8/AGjjvDhRI3ibVI4wsLLOugCN6Nb8jS9dbLuNRNyCeRXL3K3DK2T
         150Pnl8iUdh6emQ7JtrIKPYY927V0R4TJvuItHKNtNAl2MWSblWsm8nmZ+yRuJRaR573
         LWHuIzhlfrfDNczpfLdyJWdovuDLVIWmq+BWv8ZDNcXy+03JTPqD+/Mx2SU0iGoDtG6k
         fq975w39qMnYhTgUodajKqgpWKxNFJ9OXh9pSdfdHqDtrfAiHywgWbTFK9XC3W0DzX9E
         AqvaEC/qU3DiTPCZYXvhBDxaehH3KcuH1gK0KrrN8PfMV/DqN3donUkGDlnREjTSI3wW
         LdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xRv0X+1/zXE108RukiKu9jD2ej9ZGOEl4nfipShz1g4=;
        b=X3wwceGI5ci85mXeZOFnhM2NfGpTSaPsumiptRTQdFM9BAzz/xufQMeDCcKr3iMbbB
         mQirFuB4Fc1jq6FrTx5oYybKjO4lVTOwJsomF2S6s2xgfj9A5IJ26cSM47QJH/IdECF8
         6H/5Hj6jyg43kNx69Qqr9ERBW3x86CASyhYN/3bTXd1kNVyTxphFNBJ/4rk7sb/7Kbit
         BvjCN6dA5u6RX5cMEJuR1iX8PwrkDVsl8ll1IjNOBe27P7FaXdhbce8d6so6L6fXOkZL
         jM2ZJbscfH76DPv53+MsvjTPKSKKy9+R1qBB/nNr/pe8BpWKn3EWnhKu/SRYpxsBy1rP
         Z3JA==
X-Gm-Message-State: AOPr4FUpHJU3ShqnIjrzKmM6vvpeeFKNSXcCbuyLbHMIbDuzipQ0ja6nQhyYrZ8gK5Rm/Q==
X-Received: by 10.194.66.137 with SMTP id f9mr3798289wjt.74.1462972827675;
        Wed, 11 May 2016 06:20:27 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:26 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294288>

To libify `git apply` functionality we must make init_apply_state()
usable outside "builtin/apply.c".

Let's do that by moving it into a new "apply.c".

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile        |  1 +
 apply.c         | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 apply.h         |  9 +++++++
 builtin/apply.c | 79 ------------------------------------------------------
 4 files changed, 93 insertions(+), 79 deletions(-)
 create mode 100644 apply.c

diff --git a/Makefile b/Makefile
index 3f03366..b2a7b0c 100644
--- a/Makefile
+++ b/Makefile
@@ -683,6 +683,7 @@ LIB_OBJS += abspath.o
 LIB_OBJS += advice.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
+LIB_OBJS += apply.o
 LIB_OBJS += archive.o
 LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
diff --git a/apply.c b/apply.c
new file mode 100644
index 0000000..508ea64
--- /dev/null
+++ b/apply.c
@@ -0,0 +1,83 @@
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
+	state->lock_file = lock_file ? lock_file : xcalloc(1, sizeof(*lock_file));
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
diff --git a/apply.h b/apply.h
index aa11ea6..0f77f4d 100644
--- a/apply.h
+++ b/apply.h
@@ -112,4 +112,13 @@ struct apply_state {
 	enum ws_ignore ws_ignore_action;
 };
 
+extern int parse_whitespace_option(struct apply_state *state,
+				   const char *option);
+extern int parse_ignorewhitespace_option(struct apply_state *state,
+					 const char *option);
+
+extern void init_apply_state(struct apply_state *state,
+			     const char *prefix,
+			     struct lock_file *lock_file);
+
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index a7ebbbb..805c707 100644
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
@@ -4528,13 +4482,6 @@ end:
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
@@ -4593,32 +4540,6 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static void init_apply_state(struct apply_state *state,
-			     const char *prefix,
-			     struct lock_file *lock_file)
-{
-	memset(state, 0, sizeof(*state));
-	state->prefix = prefix;
-	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
-	state->lock_file = lock_file ? lock_file : xcalloc(1, sizeof(*lock_file));
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
 static void check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
-- 
2.8.2.490.g3dabe57
