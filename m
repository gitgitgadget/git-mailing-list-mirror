From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 41/49] builtin/apply: move 'ws_ignore_action' into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:18 +0200
Message-ID: <20160524081126.16973-42-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:12:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57SM-0000wb-IM
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbcEXIMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34093 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703AbcEXIMo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so3662460wmn.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ug/VFTJNK33CEUNwJ7fK9sm1+GuW3X9hyjxpr1oFvLg=;
        b=XX04CxOy0YMqMjKqXIk0i1mMinpI3R5wy4FV4JlAG0x4BduoLMntQev1vRtSdGnpiY
         +nyrDHUPXtoAoJ9VQbAeGChgtqwKGe0Mq2lpVe+V5VMs2no9IVNUZfSWCxi98ei1A/HR
         MNZGBaLrT9zxG3BEtWharrve/N0EzcXzOhkBN9Bqsax2vAv+aRKSX5RB5ha2aDRG+H/S
         URuPlUB/u6ra8/l+F9/b/0QXSnZC7bkznXH1CYxAOVCCtG8TP17wmnK0Rz774/XU9XOk
         F0X1AKkK0WaIuIlg+kSzeki/vBVYGGwisdm+NB+HcfcRK06uqfRNIUCOyPkXfpXxVWEL
         GBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ug/VFTJNK33CEUNwJ7fK9sm1+GuW3X9hyjxpr1oFvLg=;
        b=JxveWvuaZ08lLf19RaDVx0nbweoJeEga5UIjzD2SRT88OZwu/jzjrz9B4FmVmZn/KL
         ZLHcbVyxHk2ixtijDDcDIjuXM/tAbC5ptFGTjYOyJWlC+qZo2wpdnkLQbj7jkTZyUyvK
         rPH3QEB4a4yqOo4nzaxNPI0grwMElYckLgx1hVyra2qPq2YlaVd+8/6/H15h8V5U2G6y
         l8nse3r985cMumvAMID5/xUrEjE+QTrJSANOX8gDa9uVqqGRhLUB/GjeHKtSL3aPOZq2
         VenDZbZtfjOz5VxfSf6+TceI3WrB2MgAc6CvbIMF3mUSwmSF2cMV0Yo4IOYSIVq8enpO
         3alg==
X-Gm-Message-State: ALyK8tL6W8yqVUzEnm7Mzrl9+7IxUXt9uemHSYbwQ8qz3Pt0LRYox5dUC1SASa0c+pseJA==
X-Received: by 10.194.173.161 with SMTP id bl1mr2811015wjc.11.1464077562846;
        Tue, 24 May 2016 01:12:42 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:42 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295436>

To libify the apply functionality the 'ws_ignore_action' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 61d809a..e5bc9cc 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -28,6 +28,12 @@ enum ws_error_action {
 	correct_ws_error
 };
 
+
+enum ws_ignore {
+	ignore_ws_none,
+	ignore_ws_change
+};
+
 struct apply_state {
 	const char *prefix;
 	int prefix_length;
@@ -69,6 +75,7 @@ struct apply_state {
 
 	/* These control whitespace errors */
 	enum ws_error_action ws_error_action;
+	enum ws_ignore ws_ignore_action;
 	const char *whitespace_option;
 	int whitespace_error;
 	int squelch_whitespace_errors;
@@ -82,13 +89,6 @@ static const char * const apply_usage[] = {
 	NULL
 };
 
-
-static enum ws_ignore {
-	ignore_ws_none,
-	ignore_ws_change
-} ws_ignore_action = ignore_ws_none;
-
-
 static void parse_whitespace_option(struct apply_state *state, const char *option)
 {
 	if (!option) {
@@ -119,16 +119,17 @@ static void parse_whitespace_option(struct apply_state *state, const char *optio
 	die(_("unrecognized whitespace option '%s'"), option);
 }
 
-static void parse_ignorewhitespace_option(const char *option)
+static void parse_ignorewhitespace_option(struct apply_state *state,
+					  const char *option)
 {
 	if (!option || !strcmp(option, "no") ||
 	    !strcmp(option, "false") || !strcmp(option, "never") ||
 	    !strcmp(option, "none")) {
-		ws_ignore_action = ignore_ws_none;
+		state->ws_ignore_action = ignore_ws_none;
 		return;
 	}
 	if (!strcmp(option, "change")) {
-		ws_ignore_action = ignore_ws_change;
+		state->ws_ignore_action = ignore_ws_change;
 		return;
 	}
 	die(_("unrecognized whitespace ignore option '%s'"), option);
@@ -2488,7 +2489,7 @@ static int match_fragment(struct apply_state *state,
 	 * fuzzy matching. We collect all the line length information because
 	 * we need it to adjust whitespace if we match.
 	 */
-	if (ws_ignore_action == ignore_ws_change)
+	if (state->ws_ignore_action == ignore_ws_change)
 		return line_by_line_fuzzy_match(img, preimage, postimage,
 						try, try_lno, preimage_limit);
 
@@ -4611,12 +4612,13 @@ static int option_parse_p(const struct option *opt,
 }
 
 static int option_parse_space_change(const struct option *opt,
-			  const char *arg, int unset)
+				     const char *arg, int unset)
 {
+	struct apply_state *state = opt->value;
 	if (unset)
-		ws_ignore_action = ignore_ws_none;
+		state->ws_ignore_action = ignore_ws_none;
 	else
-		ws_ignore_action = ignore_ws_change;
+		state->ws_ignore_action = ignore_ws_change;
 	return 0;
 }
 
@@ -4650,13 +4652,14 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	state->p_context = UINT_MAX;
 	state->squelch_whitespace_errors = 5;
 	state->ws_error_action = warn_on_ws_error;
+	state->ws_ignore_action = ignore_ws_none;
 	strbuf_init(&state->root, 0);
 
 	git_apply_config();
 	if (apply_default_whitespace)
 		parse_whitespace_option(state, apply_default_whitespace);
 	if (apply_default_ignorewhitespace)
-		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
+		parse_ignorewhitespace_option(state, apply_default_ignorewhitespace);
 }
 
 static void clear_apply_state(struct apply_state *state)
@@ -4717,10 +4720,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "whitespace", &state, N_("action"),
 			N_("detect new or modified lines that have whitespace errors"),
 			0, option_parse_whitespace },
-		{ OPTION_CALLBACK, 0, "ignore-space-change", NULL, NULL,
+		{ OPTION_CALLBACK, 0, "ignore-space-change", &state, NULL,
 			N_("ignore changes in whitespace when finding context"),
 			PARSE_OPT_NOARG, option_parse_space_change },
-		{ OPTION_CALLBACK, 0, "ignore-whitespace", NULL, NULL,
+		{ OPTION_CALLBACK, 0, "ignore-whitespace", &state, NULL,
 			N_("ignore changes in whitespace when finding context"),
 			PARSE_OPT_NOARG, option_parse_space_change },
 		OPT_BOOL('R', "reverse", &state.apply_in_reverse,
-- 
2.8.3.443.gaeee61e
