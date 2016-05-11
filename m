From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 40/94] builtin/apply: move 'ws_error_action' into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:51 +0200
Message-ID: <20160511131745.2914-41-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:23:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U74-0007Kt-FM
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbcEKNXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:23:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34951 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204AbcEKNTu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id e201so9406459wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gtOlkfJW4sD39UObjaAeMD5bIhtusi+qn0CjrtSL22I=;
        b=c5jpziNsXav60dksuDf5n+tvNA7Nd5bozQntzv2Pl3fI6RiVRgYIW7tNEqGg6vxtnc
         REFXQKaWEzotqPoFzUSMH2ETAhjq5arMqHXU0bbfT4kdfHJ9ln8KenC/rBijvaxRiId0
         2fA55SkXVjg1mLDQOMlQeGB+x7pnU/YUsPY0xTu3VP/ZkWcOXyzZZRfFTskGVBVg2mMH
         DQd7qqUgxA0TnO320qD/B0t2DNahi1wT8FN9Quj+dKUI8wTDrQ5nc4XgwEMI42aQEZal
         pLwKnnat4cFVB86YSuo87t8uTpCBffRfWQzjAOS5EnlD8AzMKg6x5oesjQ37bBnbvZr0
         JZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gtOlkfJW4sD39UObjaAeMD5bIhtusi+qn0CjrtSL22I=;
        b=b5CUTkPenWgnyvlGqWvBSx38ye4ak30MwBC4tjBYecDH/Wsin7EPMpY7H/BbCc5Mog
         OjVnIh/+xh0DUslMWevANmet7rLldePmDHRnDnY3JdZ4AZ0cXp3N4xqhhnXSA6qjKv2c
         v6v/lhHDmB4aV42nUWqc8R99+IkxXcPKvM2I+0sIyX1y2lQ+3yi0XkEjVo/drLixwEOd
         fkZ+z5W5TRrnEi5jUdUd6Bh50p7F0GuiOR/FTd2oXwAu/S69v2Na5feqzXseBNFmGGs6
         hqwbSwPhIuEZSxqo7gKY5baHTI238JUY4VHZ5zouowhVRRowpsFn7PSMLTF0tgc3wwMs
         0CfQ==
X-Gm-Message-State: AOPr4FUNJ2IdbTyCr1MK7LP0+ev8c9ZLMI0FqD7fpXzb6PocHQvc1qE/4p0lS+7DngqB8g==
X-Received: by 10.28.158.79 with SMTP id h76mr15518wme.79.1462972789586;
        Wed, 11 May 2016 06:19:49 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:48 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294326>

To libify the apply functionality the 'ws_error_action' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 62 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e68fd2c..10d45c7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -21,6 +21,13 @@
 #include "ll-merge.h"
 #include "rerere.h"
 
+enum ws_error_action {
+	nowarn_ws_error,
+	warn_on_ws_error,
+	die_on_ws_error,
+	correct_ws_error
+};
+
 struct apply_state {
 	const char *prefix;
 	int prefix_length;
@@ -71,6 +78,8 @@ struct apply_state {
 	int whitespace_error;
 	int squelch_whitespace_errors;
 	int applied_after_fixing_ws;
+
+	enum ws_error_action ws_error_action;
 };
 
 static int newfd = -1;
@@ -80,12 +89,6 @@ static const char * const apply_usage[] = {
 	NULL
 };
 
-static enum ws_error_action {
-	nowarn_ws_error,
-	warn_on_ws_error,
-	die_on_ws_error,
-	correct_ws_error
-} ws_error_action = warn_on_ws_error;
 
 static enum ws_ignore {
 	ignore_ws_none,
@@ -96,28 +99,28 @@ static enum ws_ignore {
 static void parse_whitespace_option(struct apply_state *state, const char *option)
 {
 	if (!option) {
-		ws_error_action = warn_on_ws_error;
+		state->ws_error_action = warn_on_ws_error;
 		return;
 	}
 	if (!strcmp(option, "warn")) {
-		ws_error_action = warn_on_ws_error;
+		state->ws_error_action = warn_on_ws_error;
 		return;
 	}
 	if (!strcmp(option, "nowarn")) {
-		ws_error_action = nowarn_ws_error;
+		state->ws_error_action = nowarn_ws_error;
 		return;
 	}
 	if (!strcmp(option, "error")) {
-		ws_error_action = die_on_ws_error;
+		state->ws_error_action = die_on_ws_error;
 		return;
 	}
 	if (!strcmp(option, "error-all")) {
-		ws_error_action = die_on_ws_error;
+		state->ws_error_action = die_on_ws_error;
 		state->squelch_whitespace_errors = 0;
 		return;
 	}
 	if (!strcmp(option, "strip") || !strcmp(option, "fix")) {
-		ws_error_action = correct_ws_error;
+		state->ws_error_action = correct_ws_error;
 		return;
 	}
 	die(_("unrecognized whitespace option '%s'"), option);
@@ -141,7 +144,7 @@ static void parse_ignorewhitespace_option(const char *option)
 static void set_default_whitespace_mode(struct apply_state *state)
 {
 	if (!state->whitespace_option && !apply_default_whitespace)
-		ws_error_action = (state->apply ? warn_on_ws_error : nowarn_ws_error);
+		state->ws_error_action = (state->apply ? warn_on_ws_error : nowarn_ws_error);
 }
 
 /*
@@ -1676,12 +1679,12 @@ static int parse_fragment(struct apply_state *state,
 				leading++;
 			trailing++;
 			if (!state->apply_in_reverse &&
-			    ws_error_action == correct_ws_error)
+			    state->ws_error_action == correct_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
 			break;
 		case '-':
 			if (state->apply_in_reverse &&
-			    ws_error_action != nowarn_ws_error)
+			    state->ws_error_action != nowarn_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
 			deleted++;
 			oldlines--;
@@ -1689,7 +1692,7 @@ static int parse_fragment(struct apply_state *state,
 			break;
 		case '+':
 			if (!state->apply_in_reverse &&
-			    ws_error_action != nowarn_ws_error)
+			    state->ws_error_action != nowarn_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
 			added++;
 			newlines--;
@@ -2402,7 +2405,8 @@ static int line_by_line_fuzzy_match(struct image *img,
 	return 1;
 }
 
-static int match_fragment(struct image *img,
+static int match_fragment(struct apply_state *state,
+			  struct image *img,
 			  struct image *preimage,
 			  struct image *postimage,
 			  unsigned long try,
@@ -2423,7 +2427,7 @@ static int match_fragment(struct image *img,
 		preimage_limit = preimage->nr;
 		if (match_end && (preimage->nr + try_lno != img->nr))
 			return 0;
-	} else if (ws_error_action == correct_ws_error &&
+	} else if (state->ws_error_action == correct_ws_error &&
 		   (ws_rule & WS_BLANK_AT_EOF)) {
 		/*
 		 * This hunk extends beyond the end of img, and we are
@@ -2495,7 +2499,7 @@ static int match_fragment(struct image *img,
 		return line_by_line_fuzzy_match(img, preimage, postimage,
 						try, try_lno, preimage_limit);
 
-	if (ws_error_action != correct_ws_error)
+	if (state->ws_error_action != correct_ws_error)
 		return 0;
 
 	/*
@@ -2607,7 +2611,8 @@ static int match_fragment(struct image *img,
 	return 0;
 }
 
-static int find_pos(struct image *img,
+static int find_pos(struct apply_state *state,
+		    struct image *img,
 		    struct image *preimage,
 		    struct image *postimage,
 		    int line,
@@ -2651,7 +2656,7 @@ static int find_pos(struct image *img,
 	try_lno = line;
 
 	for (i = 0; ; i++) {
-		if (match_fragment(img, preimage, postimage,
+		if (match_fragment(state, img, preimage, postimage,
 				   try, try_lno, ws_rule,
 				   match_beginning, match_end))
 			return try_lno;
@@ -2864,7 +2869,7 @@ static int apply_one_fragment(struct apply_state *state,
 			start = newlines.len;
 			if (first != '+' ||
 			    !state->whitespace_error ||
-			    ws_error_action != correct_ws_error) {
+			    state->ws_error_action != correct_ws_error) {
 				strbuf_add(&newlines, patch + 1, plen);
 			}
 			else {
@@ -2942,7 +2947,7 @@ static int apply_one_fragment(struct apply_state *state,
 
 	for (;;) {
 
-		applied_pos = find_pos(img, &preimage, &postimage, pos,
+		applied_pos = find_pos(state, img, &preimage, &postimage, pos,
 				       ws_rule, match_beginning, match_end);
 
 		if (applied_pos >= 0)
@@ -2978,10 +2983,10 @@ static int apply_one_fragment(struct apply_state *state,
 		if (new_blank_lines_at_end &&
 		    preimage.nr + applied_pos >= img->nr &&
 		    (ws_rule & WS_BLANK_AT_EOF) &&
-		    ws_error_action != nowarn_ws_error) {
+		    state->ws_error_action != nowarn_ws_error) {
 			record_ws_error(state, WS_BLANK_AT_EOF, "+", 1,
 					found_new_blank_lines_at_end);
-			if (ws_error_action == correct_ws_error) {
+			if (state->ws_error_action == correct_ws_error) {
 				while (new_blank_lines_at_end--)
 					remove_last_line(&postimage);
 			}
@@ -2992,7 +2997,7 @@ static int apply_one_fragment(struct apply_state *state,
 			 * apply_patch->check_patch_list->check_patch->
 			 * apply_data->apply_fragments->apply_one_fragment
 			 */
-			if (ws_error_action == die_on_ws_error)
+			if (state->ws_error_action == die_on_ws_error)
 				state->apply = 0;
 		}
 
@@ -4536,7 +4541,7 @@ static int apply_patch(struct apply_state *state,
 	if (!list && !skipped_patch)
 		die(_("unrecognized input"));
 
-	if (state->whitespace_error && (ws_error_action == die_on_ws_error))
+	if (state->whitespace_error && (state->ws_error_action == die_on_ws_error))
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
@@ -4651,6 +4656,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	state->p_value = 1;
 	state->p_context = UINT_MAX;
 	state->squelch_whitespace_errors = 5;
+	state->ws_error_action = warn_on_ws_error;
 	strbuf_init(&state->root, 0);
 
 	git_apply_config();
@@ -4801,7 +4807,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 				   squelched),
 				squelched);
 		}
-		if (ws_error_action == die_on_ws_error)
+		if (state.ws_error_action == die_on_ws_error)
 			die(Q_("%d line adds whitespace errors.",
 			       "%d lines add whitespace errors.",
 			       state.whitespace_error),
-- 
2.8.2.490.g3dabe57
