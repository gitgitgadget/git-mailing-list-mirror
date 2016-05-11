From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 41/94] builtin/apply: move 'ws_ignore_action' into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:52 +0200
Message-ID: <20160511131745.2914-42-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:20:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3V-00036O-5Y
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbcEKNT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33183 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbcEKNTx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id r12so9411231wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xN6dHPkxlnkR2bpWIvHo2AcHsJH6ygJuyIYXCI7rmCY=;
        b=wVHKXvYiwVI/TXSyjQrg1a46rjbh1twt9kjbPvFO4wtHB7PTiOkR5Qr8gZJe1I2Nlb
         /WZSWw3f2CQRciCqaoII209IYR7KZhRsmc84FEJOq3XnTFctZFIjh+TDF0eDWwQC+VV4
         WUNYWBWdx2hwh7u2sROuaGk0ktjRiugs877qxDl8DJk4/ILB2a/N/LpYrxP0d0geYA1N
         GskENAfCw3v3+IeqAf4K29TEdo9x/eZ3cJOxrJPdHYPHq+kI1LmO5VpfhGMlZe1vEIBK
         sjaA9ERMkMJgZnm8IrbpNRZMNOEEb1iVhUyIFIsLI5Wf8Z6mRyu40HqTD32LAWbSz/3v
         Nulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xN6dHPkxlnkR2bpWIvHo2AcHsJH6ygJuyIYXCI7rmCY=;
        b=K+U1axYtl2M9YP82atcZAxqqDnK4HYXfBTApqKBLokPfFSkljXyHSVEIMil5rwCw5U
         M2uU80KfouHfI9xw79T5nAmC3o6Is7c/kD0xgOcg3x6J9e4MwWdPm0G1iKPWdOinBJY1
         AqqcVMdYxARCxoNRExXk+f581WcJ54XQEbAdXSvrsVf4Mt58ZdEdRCE5YZGi4vX+eAJq
         Z85K2rnlce2sdv5oeFxASd8cs6f1EXOxiSIE5G5aA0pPlzX1LfMx0y6QwxOvnukL0g5v
         ScRJzWm2C5WWN6ZmoJh+IvgiW60G3ogmUJOIFJZLukePw6NfC+EOmb6J2OKrdB2y5gSH
         3X/w==
X-Gm-Message-State: AOPr4FUgmLg4ah5EqQNiirLaysrK1xSAZSNCqKCka7LcY9099LhFttmWcR2wJq+I40GIzA==
X-Received: by 10.28.236.88 with SMTP id k85mr30826wmh.53.1462972791673;
        Wed, 11 May 2016 06:19:51 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:50 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294273>

To libify the apply functionality the 'ws_ignore_action' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 10d45c7..f8c3677 100644
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
@@ -80,6 +86,7 @@ struct apply_state {
 	int applied_after_fixing_ws;
 
 	enum ws_error_action ws_error_action;
+	enum ws_ignore ws_ignore_action;
 };
 
 static int newfd = -1;
@@ -89,13 +96,6 @@ static const char * const apply_usage[] = {
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
@@ -126,16 +126,17 @@ static void parse_whitespace_option(struct apply_state *state, const char *optio
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
@@ -2495,7 +2496,7 @@ static int match_fragment(struct apply_state *state,
 	 * fuzzy matching. We collect all the line length information because
 	 * we need it to adjust whitespace if we match.
 	 */
-	if (ws_ignore_action == ignore_ws_change)
+	if (state->ws_ignore_action == ignore_ws_change)
 		return line_by_line_fuzzy_match(img, preimage, postimage,
 						try, try_lno, preimage_limit);
 
@@ -4618,12 +4619,13 @@ static int option_parse_p(const struct option *opt,
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
 
@@ -4657,13 +4659,14 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
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
 
 int cmd_apply(int argc, const char **argv, const char *prefix_)
@@ -4718,10 +4721,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.2.490.g3dabe57
