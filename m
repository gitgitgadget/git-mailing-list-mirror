From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 40/83] builtin/apply: move 'ws_ignore_action' into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:40 +0200
Message-ID: <1461504863-15946-41-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:37:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKEO-0000hf-UA
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbcDXNfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:51 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35042 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbcDXNfo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:44 -0400
Received: by mail-wm0-f54.google.com with SMTP id e201so60536699wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/OptEvsBEsOBLFT5R/YIqY61vJmIJX4FpxapGxS/pq4=;
        b=o5AHK1IoAjpjd3ttOLKOoDUTI4jFd0Mc0YANxC8XB3JxJPEVDfgoAkAoLEE+BwnSdu
         sIA6OAvku/APhFDR7+OUANQc7D/wP7sftGnERIo+uKIAYT8HsQPf/rfVrGWx+tkEzlWc
         tI51i9qqSEssD0BLoMCothVhcuHvX5ZhOJnPCUAi9X3wX1TAxqeugqfJ4/VumKqpxau7
         6wONjU+3b51/qVuIypLYSWwVSsmbDD1uEBp7SJWZ+LBRnr7wTyh9hL/ehxD/otKbINdK
         yjfnKPIsgaZCu4i2IhrQ9dEQeCOMzVKGdvut3SF7Cy+bjXhcqlfbah92Z5Oyv8MrCWTj
         x0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/OptEvsBEsOBLFT5R/YIqY61vJmIJX4FpxapGxS/pq4=;
        b=TPIPg0xLtKOKUwYQA+mHOwsqQ3nmjc9uHVcYW+P7AtdFndNGsWR+OqL4tTcqhdv39m
         2pFb2bm7jaodhz5w+iQ0nEpvUvbKa0A7VAbaPDY254784LSqnTDidgdAJ2E8dnIloI3K
         WOSmtoJnX4kBG2W74gGVrKoFNv+zjOugzZg634rUcRcTdedVombJ33KL16bfD1c+X+wd
         XK4nwaYxQbJs89qwXyp+0nsZ4xDlIztuIxcatohE6qooospwCF2vDBU6xPBaBD8hDFvY
         R1WT3YskhzYJAXHWyTdJjxCdL+jz60RUAy5StvkI14+4ojEPtAwi2NJwPj7JZeMKnEVP
         /Reg==
X-Gm-Message-State: AOPr4FV3TYQ4+xq/QcCL90Aeq4CUrmSAGaPMvmJE5cY5mVjHDIfHxfaKFMXKJrKqEm1e3A==
X-Received: by 10.194.89.38 with SMTP id bl6mr28505497wjb.44.1461504942848;
        Sun, 24 Apr 2016 06:35:42 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:42 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292377>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 7d91454..fa07b33 100644
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
@@ -89,6 +95,7 @@ struct apply_state {
 	int applied_after_fixing_ws;
 
 	enum ws_error_action ws_error_action;
+	enum ws_ignore ws_ignore_action;
 };
 
 static int newfd = -1;
@@ -98,13 +105,6 @@ static const char * const apply_usage[] = {
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
@@ -135,16 +135,17 @@ static void parse_whitespace_option(struct apply_state *state, const char *optio
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
@@ -2505,7 +2506,7 @@ static int match_fragment(struct apply_state *state,
 	 * fuzzy matching. We collect all the line length information because
 	 * we need it to adjust whitespace if we match.
 	 */
-	if (ws_ignore_action == ignore_ws_change)
+	if (state->ws_ignore_action == ignore_ws_change)
 		return line_by_line_fuzzy_match(img, preimage, postimage,
 						try, try_lno, preimage_limit);
 
@@ -4628,12 +4629,13 @@ static int option_parse_p(const struct option *opt,
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
 
@@ -4708,10 +4710,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
@@ -4744,13 +4746,14 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	state.p_context = UINT_MAX;
 	state.squelch_whitespace_errors = 5;
 	state.ws_error_action = warn_on_ws_error;
+	state.ws_ignore_action = ignore_ws_none;
 	strbuf_init(&state.root, 0);
 
 	git_apply_config();
 	if (apply_default_whitespace)
 		parse_whitespace_option(&state, apply_default_whitespace);
 	if (apply_default_ignorewhitespace)
-		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
+		parse_ignorewhitespace_option(&state, apply_default_ignorewhitespace);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.8.1.300.g5fed0c0
