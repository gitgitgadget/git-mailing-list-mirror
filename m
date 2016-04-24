From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 39/83] builtin/apply: move 'ws_error_action' into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:39 +0200
Message-ID: <1461504863-15946-40-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCg-0008CN-C0
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbcDXNfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:52 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37750 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbcDXNfn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:43 -0400
Received: by mail-wm0-f53.google.com with SMTP id n3so90213177wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rW+byiGDki8fgpnj55t9dSq6CkTo9XJ/ltuw6V61HaE=;
        b=Un/stj7C/uRgdnaVToNpdBCdwDleKxlNeojW/Tob0yLbz2w6voKc7C27fVuHUsXMSY
         r6d2DXbfIRzTBreqZTlcMGDB3UCQDcAa2jG5FdgfZZsb3P5424ez7h8Zhygxnmp8qV/+
         747QPc6o8+36RcJwE5G8XR1dmMGsJHaZcd7z81Cm89qndPn0Hmf/H9HZzt9tVeR2XSDO
         UXZTULMTh7CwQBLsIEXGOZUVeXFV05D1vfn6YDtRpj//AdJobe69ZSotzq7wKaYg6oDR
         VdOGcRehE+EMjt2nu+cdAB/iFt2tGQCJMrO5TgwaTxivnoMw9qZmIgKeb8zt6iTAwqu5
         SfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rW+byiGDki8fgpnj55t9dSq6CkTo9XJ/ltuw6V61HaE=;
        b=klvB+3+b8I5C0kr1J/Al3rM5GtO0szoZUZrz8BzcKa1jIsNLwsd0VcKHBrb9LeSa8a
         z5/RWwTITWcKFOIqZqEhLzRQEMwjqGAqDBHCHDkRLJ2o+KaJVv+ORSPLCDSWthCjKEcC
         71YRxsTYbCB5uM1NY159T5Ewd3NOB3egG4DTFR7AK1WgScti/i4MC8+3Kw950101Ikk9
         KN+j/DlGzfEMSUYpaXjprapEiAq8yl8+DlWo98b6sb5nUnqoNDS3s4syiX8hbjZEEjnI
         JcrDSqDNNnPv6LwJAhRGMA2NdL+k62tO/gOt8kD/2z4FBOA18/lmhf/skiaiSC0peSxc
         H0Wg==
X-Gm-Message-State: AOPr4FURnVfRDmvUqbsnQmVYK26bhdCvLH8afbKCxU/jYtuGry8o5BnLIu0cxKTAyJzYNQ==
X-Received: by 10.194.61.19 with SMTP id l19mr29075924wjr.4.1461504941493;
        Sun, 24 Apr 2016 06:35:41 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:40 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292343>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 62 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 52602af..7d91454 100644
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
@@ -80,6 +87,8 @@ struct apply_state {
 	int whitespace_error;
 	int squelch_whitespace_errors;
 	int applied_after_fixing_ws;
+
+	enum ws_error_action ws_error_action;
 };
 
 static int newfd = -1;
@@ -89,12 +98,6 @@ static const char * const apply_usage[] = {
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
@@ -105,28 +108,28 @@ static enum ws_ignore {
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
@@ -150,7 +153,7 @@ static void parse_ignorewhitespace_option(const char *option)
 static void set_default_whitespace_mode(struct apply_state *state)
 {
 	if (!state->whitespace_option && !apply_default_whitespace)
-		ws_error_action = (state->apply ? warn_on_ws_error : nowarn_ws_error);
+		state->ws_error_action = (state->apply ? warn_on_ws_error : nowarn_ws_error);
 }
 
 /*
@@ -1685,12 +1688,12 @@ static int parse_fragment(struct apply_state *state,
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
@@ -1698,7 +1701,7 @@ static int parse_fragment(struct apply_state *state,
 			break;
 		case '+':
 			if (!state->apply_in_reverse &&
-			    ws_error_action != nowarn_ws_error)
+			    state->ws_error_action != nowarn_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
 			added++;
 			newlines--;
@@ -2411,7 +2414,8 @@ static int line_by_line_fuzzy_match(struct image *img,
 	return 1;
 }
 
-static int match_fragment(struct image *img,
+static int match_fragment(struct apply_state *state,
+			  struct image *img,
 			  struct image *preimage,
 			  struct image *postimage,
 			  unsigned long try,
@@ -2432,7 +2436,7 @@ static int match_fragment(struct image *img,
 		preimage_limit = preimage->nr;
 		if (match_end && (preimage->nr + try_lno != img->nr))
 			return 0;
-	} else if (ws_error_action == correct_ws_error &&
+	} else if (state->ws_error_action == correct_ws_error &&
 		   (ws_rule & WS_BLANK_AT_EOF)) {
 		/*
 		 * This hunk extends beyond the end of img, and we are
@@ -2505,7 +2509,7 @@ static int match_fragment(struct image *img,
 		return line_by_line_fuzzy_match(img, preimage, postimage,
 						try, try_lno, preimage_limit);
 
-	if (ws_error_action != correct_ws_error)
+	if (state->ws_error_action != correct_ws_error)
 		return 0;
 
 	/*
@@ -2617,7 +2621,8 @@ static int match_fragment(struct image *img,
 	return 0;
 }
 
-static int find_pos(struct image *img,
+static int find_pos(struct apply_state *state,
+		    struct image *img,
 		    struct image *preimage,
 		    struct image *postimage,
 		    int line,
@@ -2661,7 +2666,7 @@ static int find_pos(struct image *img,
 	try_lno = line;
 
 	for (i = 0; ; i++) {
-		if (match_fragment(img, preimage, postimage,
+		if (match_fragment(state, img, preimage, postimage,
 				   try, try_lno, ws_rule,
 				   match_beginning, match_end))
 			return try_lno;
@@ -2874,7 +2879,7 @@ static int apply_one_fragment(struct apply_state *state,
 			start = newlines.len;
 			if (first != '+' ||
 			    !state->whitespace_error ||
-			    ws_error_action != correct_ws_error) {
+			    state->ws_error_action != correct_ws_error) {
 				strbuf_add(&newlines, patch + 1, plen);
 			}
 			else {
@@ -2952,7 +2957,7 @@ static int apply_one_fragment(struct apply_state *state,
 
 	for (;;) {
 
-		applied_pos = find_pos(img, &preimage, &postimage, pos,
+		applied_pos = find_pos(state, img, &preimage, &postimage, pos,
 				       ws_rule, match_beginning, match_end);
 
 		if (applied_pos >= 0)
@@ -2988,10 +2993,10 @@ static int apply_one_fragment(struct apply_state *state,
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
@@ -3002,7 +3007,7 @@ static int apply_one_fragment(struct apply_state *state,
 			 * apply_patch->check_patch_list->check_patch->
 			 * apply_data->apply_fragments->apply_one_fragment
 			 */
-			if (ws_error_action == die_on_ws_error)
+			if (state->ws_error_action == die_on_ws_error)
 				state->apply = 0;
 		}
 
@@ -4546,7 +4551,7 @@ static int apply_patch(struct apply_state *state,
 	if (!list && !skipped_patch)
 		die(_("unrecognized input"));
 
-	if (state->whitespace_error && (ws_error_action == die_on_ws_error))
+	if (state->whitespace_error && (state->ws_error_action == die_on_ws_error))
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
@@ -4738,6 +4743,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	state.p_value = 1;
 	state.p_context = UINT_MAX;
 	state.squelch_whitespace_errors = 5;
+	state.ws_error_action = warn_on_ws_error;
 	strbuf_init(&state.root, 0);
 
 	git_apply_config();
@@ -4806,7 +4812,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 				   squelched),
 				squelched);
 		}
-		if (ws_error_action == die_on_ws_error)
+		if (state.ws_error_action == die_on_ws_error)
 			die(Q_("%d line adds whitespace errors.",
 			       "%d lines add whitespace errors.",
 			       state.whitespace_error),
-- 
2.8.1.300.g5fed0c0
