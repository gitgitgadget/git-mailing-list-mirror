From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 40/49] builtin/apply: move 'ws_error_action' into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:17 +0200
Message-ID: <20160524081126.16973-41-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:13:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Sn-00018M-01
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbcEXINC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:13:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34910 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbcEXIMn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id f75so3658187wmf.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Uwof7aA6TRfCYfqDIylFAS2uXkDiZ1WmJrM401o6rU=;
        b=M0YNZr92a7jFO0252UIo0BIEHTit9n7qj4vz+/r5K3vDltncADe7q8jsg3x0lLnpnG
         hRLDR1o97rehrmrZwrq0A18ACjNHieXXbkIby/KKUY402hKizP1QqrF2S3bBHExQd0fz
         j0yrzuWIEVHb75wje5N+MJgo9pfQZ/Lu/52yiqDkE0rpeXRFZUXnIyD/4L+hdUZ8ndgf
         9QXuIWaJcEhSi16tybWR8+aTI0OyoB2Jc5VC6Wr+zrB1sQU19odd8fBdWJGQoerx32lc
         ISsitjLuDdCDJwni1CcI4rscEx5IcFa8W4ND/Fd/P14fS8QiDgsC0+y6XaykTyQj32Ju
         uYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Uwof7aA6TRfCYfqDIylFAS2uXkDiZ1WmJrM401o6rU=;
        b=DcTAfyIalNGLgJSYfu76jrzmi2JF7Dqdrd0ilkF30T5Ntqm9hSFE9LHcCpCR4MaKsN
         yKzgK/Ox0vGeq6qtK501yjrqFEOMGH7gHQKxx6zFM3avBVTu5hP4YjbvjdDYfzXG9+g9
         yzz8HiBXcoVjl9QJ2CF5lsicrVDkLsky6VoBKe4taKgfo5dn2/1zzXBw4t9GFPEpkbq5
         FbkjgkKES6LTzgoL3nT56zzlpP0S6EVX3SKwMTncC5GvYQFY9PMAXqdEpt1LtZ21Im1y
         jkHnvWMecACZYPb2XK2n5XL4HKxRbW1BaygyBLOGPoUlTtIorIUt7412R6EX0a3vPRwr
         vrFA==
X-Gm-Message-State: ALyK8tLM52BfzsbS9g+fnuU5Jn0rGw1OcGKLP2OtD/Bz1smbUqgtC1SeG8dJ/T50eGsPtg==
X-Received: by 10.194.240.230 with SMTP id wd6mr2701616wjc.86.1464077561590;
        Tue, 24 May 2016 01:12:41 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:40 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295444>

To libify the apply functionality the 'ws_error_action' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 61 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 91b6283..61d809a 100644
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
@@ -61,6 +68,7 @@ struct apply_state {
 	int has_include;
 
 	/* These control whitespace errors */
+	enum ws_error_action ws_error_action;
 	const char *whitespace_option;
 	int whitespace_error;
 	int squelch_whitespace_errors;
@@ -74,12 +82,6 @@ static const char * const apply_usage[] = {
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
@@ -90,28 +92,28 @@ static enum ws_ignore {
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
@@ -135,7 +137,7 @@ static void parse_ignorewhitespace_option(const char *option)
 static void set_default_whitespace_mode(struct apply_state *state)
 {
 	if (!state->whitespace_option && !apply_default_whitespace)
-		ws_error_action = (state->apply ? warn_on_ws_error : nowarn_ws_error);
+		state->ws_error_action = (state->apply ? warn_on_ws_error : nowarn_ws_error);
 }
 
 /*
@@ -1670,12 +1672,12 @@ static int parse_fragment(struct apply_state *state,
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
@@ -1683,7 +1685,7 @@ static int parse_fragment(struct apply_state *state,
 			break;
 		case '+':
 			if (!state->apply_in_reverse &&
-			    ws_error_action != nowarn_ws_error)
+			    state->ws_error_action != nowarn_ws_error)
 				check_whitespace(state, line, len, patch->ws_rule);
 			added++;
 			newlines--;
@@ -2396,7 +2398,8 @@ static int line_by_line_fuzzy_match(struct image *img,
 	return 1;
 }
 
-static int match_fragment(struct image *img,
+static int match_fragment(struct apply_state *state,
+			  struct image *img,
 			  struct image *preimage,
 			  struct image *postimage,
 			  unsigned long try,
@@ -2417,7 +2420,7 @@ static int match_fragment(struct image *img,
 		preimage_limit = preimage->nr;
 		if (match_end && (preimage->nr + try_lno != img->nr))
 			return 0;
-	} else if (ws_error_action == correct_ws_error &&
+	} else if (state->ws_error_action == correct_ws_error &&
 		   (ws_rule & WS_BLANK_AT_EOF)) {
 		/*
 		 * This hunk extends beyond the end of img, and we are
@@ -2489,7 +2492,7 @@ static int match_fragment(struct image *img,
 		return line_by_line_fuzzy_match(img, preimage, postimage,
 						try, try_lno, preimage_limit);
 
-	if (ws_error_action != correct_ws_error)
+	if (state->ws_error_action != correct_ws_error)
 		return 0;
 
 	/*
@@ -2601,7 +2604,8 @@ static int match_fragment(struct image *img,
 	return 0;
 }
 
-static int find_pos(struct image *img,
+static int find_pos(struct apply_state *state,
+		    struct image *img,
 		    struct image *preimage,
 		    struct image *postimage,
 		    int line,
@@ -2645,7 +2649,7 @@ static int find_pos(struct image *img,
 	try_lno = line;
 
 	for (i = 0; ; i++) {
-		if (match_fragment(img, preimage, postimage,
+		if (match_fragment(state, img, preimage, postimage,
 				   try, try_lno, ws_rule,
 				   match_beginning, match_end))
 			return try_lno;
@@ -2858,7 +2862,7 @@ static int apply_one_fragment(struct apply_state *state,
 			start = newlines.len;
 			if (first != '+' ||
 			    !state->whitespace_error ||
-			    ws_error_action != correct_ws_error) {
+			    state->ws_error_action != correct_ws_error) {
 				strbuf_add(&newlines, patch + 1, plen);
 			}
 			else {
@@ -2936,7 +2940,7 @@ static int apply_one_fragment(struct apply_state *state,
 
 	for (;;) {
 
-		applied_pos = find_pos(img, &preimage, &postimage, pos,
+		applied_pos = find_pos(state, img, &preimage, &postimage, pos,
 				       ws_rule, match_beginning, match_end);
 
 		if (applied_pos >= 0)
@@ -2972,10 +2976,10 @@ static int apply_one_fragment(struct apply_state *state,
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
@@ -2986,7 +2990,7 @@ static int apply_one_fragment(struct apply_state *state,
 			 * apply_patch->check_patch_list->check_patch->
 			 * apply_data->apply_fragments->apply_one_fragment
 			 */
-			if (ws_error_action == die_on_ws_error)
+			if (state->ws_error_action == die_on_ws_error)
 				state->apply = 0;
 		}
 
@@ -4530,7 +4534,7 @@ static int apply_patch(struct apply_state *state,
 	if (!list && !skipped_patch)
 		die(_("unrecognized input"));
 
-	if (state->whitespace_error && (ws_error_action == die_on_ws_error))
+	if (state->whitespace_error && (state->ws_error_action == die_on_ws_error))
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
@@ -4645,6 +4649,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	state->p_value = 1;
 	state->p_context = UINT_MAX;
 	state->squelch_whitespace_errors = 5;
+	state->ws_error_action = warn_on_ws_error;
 	strbuf_init(&state->root, 0);
 
 	git_apply_config();
@@ -4801,7 +4806,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 				   squelched),
 				squelched);
 		}
-		if (ws_error_action == die_on_ws_error)
+		if (state.ws_error_action == die_on_ws_error)
 			die(Q_("%d line adds whitespace errors.",
 			       "%d lines add whitespace errors.",
 			       state.whitespace_error),
-- 
2.8.3.443.gaeee61e
