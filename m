From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 38/94] builtin/apply: move 'squelch_whitespace_errors' into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:49 +0200
Message-ID: <20160511131745.2914-39-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:19:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3N-0002jQ-Ad
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbcEKNTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34902 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204AbcEKNTq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id e201so9406053wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wvLohf4jEpOEAlcukgZbEu7GYHUz3zbwfNF/2gxaHMI=;
        b=XyL8t/aAzY6dbS1Clk/BaSZnNqyk/pevy+aWvGsQcerjD8Wm4VpQfABxWYbq+mtEPu
         sDEOPoUI7y1eCbiQmtg46ms2hKUalBiZMLbcNPGDKyhjlB4jOSoMjPseV4RsQg99D+2G
         rdP7yEJr0YhD89mAGL3jdjrCXUXNhS7309ERCH1kluywUMiphbOXti6dG4w2YQTEln9r
         IIIwO1lvBQoGCxnZJF3/6a+rh2q0xYXIg4vKW2CQhsUpP+hKBW2VCd9K5puSk9lvySv4
         DyP0QR0xdxg9c07tRD0m0jkzdegZ3asWAR+sj9E5ljhN8D+UhaQvLAdPQYyAsSTenYIN
         2+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wvLohf4jEpOEAlcukgZbEu7GYHUz3zbwfNF/2gxaHMI=;
        b=IZoUBLIQ9GcicTviGroYcKjmlZZsE0EnLygz6gPuSSnEpHPtioaptfYU3DudKPX3FX
         3bj3eytm2JlSQq4+LJCsQ7uuiiWyjtr/1VACgmRxZg7zOjjUUiWJNCVnXgmo+4Go7kuy
         H9Bj6YmUUbu4RghdnFkePF8TCbiWnVwzKu56uU0Tc6/J6KLgrSCwXqJfxL4wRwRNv6+v
         48AbjxgzsK/ZorjCMkw44jZ6Pw81MUI3KCBklHSJs3SXOl3ZibFS67QiG/BJug9b2oc7
         I4E7AkKALsgOaH0gsztkZji3B2QkmZN/RMPjOkQ3LqiVtnuquKlTleWxRjtEn438Gdz0
         4eaA==
X-Gm-Message-State: AOPr4FXdSOVbZ8FFu0g4PQdWWvVcWVgt8mHKfbfQRY5V6vkZmXJ8uL/lWDIj4bmoBi8G3w==
X-Received: by 10.28.223.86 with SMTP id w83mr4380731wmg.95.1462972785311;
        Wed, 11 May 2016 06:19:45 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:42 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294264>

To libify the apply functionality the 'squelch_whitespace_errors' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ab954b4..f84e301 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -69,6 +69,7 @@ struct apply_state {
 
 	const char *whitespace_option;
 	int whitespace_error;
+	int squelch_whitespace_errors;
 };
 
 static int newfd = -1;
@@ -84,7 +85,6 @@ static enum ws_error_action {
 	die_on_ws_error,
 	correct_ws_error
 } ws_error_action = warn_on_ws_error;
-static int squelch_whitespace_errors = 5;
 static int applied_after_fixing_ws;
 
 static enum ws_ignore {
@@ -93,7 +93,7 @@ static enum ws_ignore {
 } ws_ignore_action = ignore_ws_none;
 
 
-static void parse_whitespace_option(const char *option)
+static void parse_whitespace_option(struct apply_state *state, const char *option)
 {
 	if (!option) {
 		ws_error_action = warn_on_ws_error;
@@ -113,7 +113,7 @@ static void parse_whitespace_option(const char *option)
 	}
 	if (!strcmp(option, "error-all")) {
 		ws_error_action = die_on_ws_error;
-		squelch_whitespace_errors = 0;
+		state->squelch_whitespace_errors = 0;
 		return;
 	}
 	if (!strcmp(option, "strip") || !strcmp(option, "fix")) {
@@ -1605,8 +1605,8 @@ static void record_ws_error(struct apply_state *state,
 		return;
 
 	state->whitespace_error++;
-	if (squelch_whitespace_errors &&
-	    squelch_whitespace_errors < state->whitespace_error)
+	if (state->squelch_whitespace_errors &&
+	    state->squelch_whitespace_errors < state->whitespace_error)
 		return;
 
 	err = whitespace_error_string(result);
@@ -4626,9 +4626,8 @@ static int option_parse_whitespace(const struct option *opt,
 				   const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
-
 	state->whitespace_option = arg;
-	parse_whitespace_option(arg);
+	parse_whitespace_option(state, arg);
 	return 0;
 }
 
@@ -4651,11 +4650,12 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	state->line_termination = '\n';
 	state->p_value = 1;
 	state->p_context = UINT_MAX;
+	state->squelch_whitespace_errors = 5;
 	strbuf_init(&state->root, 0);
 
 	git_apply_config();
 	if (apply_default_whitespace)
-		parse_whitespace_option(apply_default_whitespace);
+		parse_whitespace_option(state, apply_default_whitespace);
 	if (apply_default_ignorewhitespace)
 		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
 }
@@ -4792,10 +4792,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	if (read_stdin)
 		errs |= apply_patch(&state, 0, "<stdin>", options);
 	if (state.whitespace_error) {
-		if (squelch_whitespace_errors &&
-		    squelch_whitespace_errors < state.whitespace_error) {
+		if (state.squelch_whitespace_errors &&
+		    state.squelch_whitespace_errors < state.whitespace_error) {
 			int squelched =
-				state.whitespace_error - squelch_whitespace_errors;
+				state.whitespace_error - state.squelch_whitespace_errors;
 			warning(Q_("squelched %d whitespace error",
 				   "squelched %d whitespace errors",
 				   squelched),
-- 
2.8.2.490.g3dabe57
