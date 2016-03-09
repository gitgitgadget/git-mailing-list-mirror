From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 40/48] builtin/apply: move 'ws_error_action' into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:49:08 +0100
Message-ID: <1457545756-20616-41-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiJF-0000Is-Ca
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933780AbcCIRyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:54:06 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35966 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933761AbcCIRxt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:49 -0500
Received: by mail-wm0-f42.google.com with SMTP id n186so190632023wmn.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=esB7bsX+mgdNBlYwOOJ/CKL+T64Q8hws4UXKbnbJnf4=;
        b=PottDRCqLy5Ky1eJSWx+OGwFsO/qXJc/jApDrXU3byUqhxxrb91E9YVDlzdWmpMKmB
         tuicVQC9mdF2Wo9aPQ+9BkMAO9Nzz/QcAGYTQNa6wzCby9br1R8wYQDfwET3esqBSN5T
         3qMULe2S6KEnCWCAyOL5mQtr1F100YnLasRddUnpAkKkvxMq2WC4XCykUK8GSw7lxDqd
         FEG7LiJo4yvZV9OTL9MNozBQPS0niwrhAHwKmA7dK8+1m208hn5eXVKPT3seH32YaTAM
         70wZGJs6/WW+5js4yAxX0OYFkKFqgsJFnzkh0tB3BNBxt9H/b+deNWL3U7s22r4I0DCZ
         X5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=esB7bsX+mgdNBlYwOOJ/CKL+T64Q8hws4UXKbnbJnf4=;
        b=BerEVxpH3xsxtWvL3OMtLzG2FNndzM+Z8fIgGjnqLPanYpH7DjElw+cA2igMPBuHFG
         4I/jyAvSRov7x09hDPXHtMEtmTI1yD/OUTAgHW+GgAY6zv24WLKRTyeax+GQzmZ0/Vw3
         rwY9jVyDcGxbRt6NfnM/JHO8wql75An0lWV1JaZeEdfzNoSoHonUjF8Yerbu/jfGcs4k
         iQrhHxdUUMJ/D1yGDg32FxdBxgm9OE4+UfwvuKs60K3csuRR2E8QUzHF7WgUz4X8Ijrv
         UGYvYm8z6IcbhP75J4Xo0ThgQYaBw0JaD6iMfm8eJkvXlP6sLxgTMwCxZikRXlTd8fIz
         nvsA==
X-Gm-Message-State: AD7BkJJ7aBwwJ6CRK+57iGUo3V3otJjfNvBxx6HZQ81qC5p9wOs4y4mGDTkOJtmmj376fw==
X-Received: by 10.194.202.195 with SMTP id kk3mr8045458wjc.159.1457546028237;
        Wed, 09 Mar 2016 09:53:48 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:47 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288531>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 62 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 9a2b8af..d427c3c 100644
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
@@ -83,6 +90,8 @@ struct apply_state {
 	int whitespace_error;
 	int squelch_whitespace_errors;
 	int applied_after_fixing_ws;
+
+	enum ws_error_action ws_error_action;
 };
 
 static const char * const apply_usage[] = {
@@ -90,12 +99,6 @@ static const char * const apply_usage[] = {
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
@@ -106,28 +109,28 @@ static enum ws_ignore {
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
@@ -151,7 +154,7 @@ static void parse_ignorewhitespace_option(const char *option)
 static void set_default_whitespace_mode(struct apply_state *state)
 {
 	if (!state->whitespace_option && !apply_default_whitespace)
-		ws_error_action = (state->apply ? warn_on_ws_error : nowarn_ws_error);
+		state->ws_error_action = (state->apply ? warn_on_ws_error : nowarn_ws_error);
 }
 
 /*
@@ -1695,12 +1698,12 @@ static int parse_fragment(struct apply_state *state,
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
@@ -1708,7 +1711,7 @@ static int parse_fragment(struct apply_state *state,
 			break;
 		case '+':
 			if (!state->apply_in_reverse &&
-			    ws_error_action != nowarn_ws_error)
+			    state->ws_error_action != nowarn_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
 			added++;
 			newlines--;
@@ -2414,7 +2417,8 @@ static int line_by_line_fuzzy_match(struct image *img,
 	return 1;
 }
 
-static int match_fragment(struct image *img,
+static int match_fragment(struct apply_state *state,
+			  struct image *img,
 			  struct image *preimage,
 			  struct image *postimage,
 			  unsigned long try,
@@ -2435,7 +2439,7 @@ static int match_fragment(struct image *img,
 		preimage_limit = preimage->nr;
 		if (match_end && (preimage->nr + try_lno != img->nr))
 			return 0;
-	} else if (ws_error_action == correct_ws_error &&
+	} else if (state->ws_error_action == correct_ws_error &&
 		   (ws_rule & WS_BLANK_AT_EOF)) {
 		/*
 		 * This hunk extends beyond the end of img, and we are
@@ -2508,7 +2512,7 @@ static int match_fragment(struct image *img,
 		return line_by_line_fuzzy_match(img, preimage, postimage, try, try_lno, preimage_limit);
 	}
 
-	if (ws_error_action != correct_ws_error)
+	if (state->ws_error_action != correct_ws_error)
 		return 0;
 
 	/*
@@ -2620,7 +2624,8 @@ static int match_fragment(struct image *img,
 	return 0;
 }
 
-static int find_pos(struct image *img,
+static int find_pos(struct apply_state *state,
+		    struct image *img,
 		    struct image *preimage,
 		    struct image *postimage,
 		    int line,
@@ -2664,7 +2669,7 @@ static int find_pos(struct image *img,
 	try_lno = line;
 
 	for (i = 0; ; i++) {
-		if (match_fragment(img, preimage, postimage,
+		if (match_fragment(state, img, preimage, postimage,
 				   try, try_lno, ws_rule,
 				   match_beginning, match_end))
 			return try_lno;
@@ -2877,7 +2882,7 @@ static int apply_one_fragment(struct apply_state *state,
 			start = newlines.len;
 			if (first != '+' ||
 			    !state->whitespace_error ||
-			    ws_error_action != correct_ws_error) {
+			    state->ws_error_action != correct_ws_error) {
 				strbuf_add(&newlines, patch + 1, plen);
 			}
 			else {
@@ -2955,7 +2960,7 @@ static int apply_one_fragment(struct apply_state *state,
 
 	for (;;) {
 
-		applied_pos = find_pos(img, &preimage, &postimage, pos,
+		applied_pos = find_pos(state, img, &preimage, &postimage, pos,
 				       ws_rule, match_beginning, match_end);
 
 		if (applied_pos >= 0)
@@ -2991,10 +2996,10 @@ static int apply_one_fragment(struct apply_state *state,
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
@@ -3005,7 +3010,7 @@ static int apply_one_fragment(struct apply_state *state,
 			 * apply_patch->check_patch_list->check_patch->
 			 * apply_data->apply_fragments->apply_one_fragment
 			 */
-			if (ws_error_action == die_on_ws_error)
+			if (state->ws_error_action == die_on_ws_error)
 				state->apply = 0;
 		}
 
@@ -4543,7 +4548,7 @@ static int apply_patch(struct apply_state *state,
 	if (!list && !skipped_patch)
 		die(_("unrecognized input"));
 
-	if (state->whitespace_error && (ws_error_action == die_on_ws_error))
+	if (state->whitespace_error && (state->ws_error_action == die_on_ws_error))
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
@@ -4736,6 +4741,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	state.p_value = 1;
 	state.p_context = UINT_MAX;
 	state.squelch_whitespace_errors = 5;
+	state.ws_error_action = warn_on_ws_error;
 	strbuf_init(&state.root, 0);
 
 	git_apply_config();
@@ -4804,7 +4810,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 				   squelched),
 				squelched);
 		}
-		if (ws_error_action == die_on_ws_error)
+		if (state.ws_error_action == die_on_ws_error)
 			die(Q_("%d line adds whitespace errors.",
 			       "%d lines add whitespace errors.",
 			       state.whitespace_error),
-- 
2.8.0.rc1.49.gca61272
