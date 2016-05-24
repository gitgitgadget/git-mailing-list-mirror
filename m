From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 29/49] builtin/apply: move 'patch_input_file' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:06 +0200
Message-ID: <20160524081126.16973-30-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:14:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57UL-0001gE-LP
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbcEXIOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:14:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36364 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbcEXIM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id q62so3639073wmg.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kjc56ErCiIS4mYa4BOgC74bNzOYpNStfpguWnAoHhcw=;
        b=vEUymlglsKrt41w1Ak9ysti10WCgQwH0VdYnNWmQk2y0/d2JjKZ9MYkhkqw9zhzwqS
         zbM9D+zJvw6Hy9Am8IA86u/onl/s4IfzVicqcCIXcBLMhx+vG0/NZ7MTxj0kvHqRKHBc
         3ykyCCdXcQI6Mw+TEkivi8Y0Zam0L4GySuG5WsSMbL/QDzeLSm48SPnxP1OQRCAmUbIV
         MeGkDwkaZLfsaIa1mbhwm+81H924UYX8/G2wjAxdtcwnHSWc9tiROvIyvZl8T4pS++dX
         1in4RBPGybVyRIsrMlSdf+QKG8axgvTGD8uT7SY4ftd1+SqkTunt3OVlglgQTPM2Hnep
         jiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kjc56ErCiIS4mYa4BOgC74bNzOYpNStfpguWnAoHhcw=;
        b=f062wq26/lJwtdX3XNYYKHZsHL4Hmu6epoiCYfLcCg0Dx5Si1EO+DvNWfLe9U3E9Th
         YhW73xbY9wrsTQPPsmjojdG5XxCCPcFEZHGHXESU/S7YvcqdvacXSGTVSJyRTaATtcTK
         WJjPT7MOAK70F7zD+I92S05gw08AeDQVkX7v5KmLCEyiRCLtzqjSKFVVAs9YmHGumyQq
         4+E04GRAjXqfwMaEEemTcel7BpzNtjdEA8OvlhRmWekdA00tnqiX0HlrBpSl7dgOm0mk
         MHcFJeaRmxeqIF0cUfnW1mSwWELjhycuEDYGE9LgH+U+WZXNZRmtRepCUSxJXCXFemfz
         sTPg==
X-Gm-Message-State: ALyK8tKAEKs1B7tR+BbSzB25Y5TtPbKParFY+LXm+hDmnOGLPhlrg5b1zBfhdErGTofx+A==
X-Received: by 10.194.57.146 with SMTP id i18mr3377878wjq.0.1464077545286;
        Tue, 24 May 2016 01:12:25 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:24 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295461>

To libify the apply functionality the 'patch_input_file' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c0c18ce..fa90028 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -49,6 +49,7 @@ struct apply_state {
 
 	/* Other non boolean parameters */
 	const char *fake_ancestor;
+	const char *patch_input_file;
 	int line_termination;
 	unsigned int p_context;
 };
@@ -79,7 +80,6 @@ static enum ws_ignore {
 } ws_ignore_action = ignore_ws_none;
 
 
-static const char *patch_input_file;
 static struct strbuf root = STRBUF_INIT;
 
 static void parse_whitespace_option(const char *option)
@@ -1525,7 +1525,11 @@ static int find_header(struct apply_state *state,
 	return -1;
 }
 
-static void record_ws_error(unsigned result, const char *line, int len, int linenr)
+static void record_ws_error(struct apply_state *state,
+			    unsigned result,
+			    const char *line,
+			    int len,
+			    int linenr)
 {
 	char *err;
 
@@ -1539,15 +1543,18 @@ static void record_ws_error(unsigned result, const char *line, int len, int line
 
 	err = whitespace_error_string(result);
 	fprintf(stderr, "%s:%d: %s.\n%.*s\n",
-		patch_input_file, linenr, err, len, line);
+		state->patch_input_file, linenr, err, len, line);
 	free(err);
 }
 
-static void check_whitespace(const char *line, int len, unsigned ws_rule)
+static void check_whitespace(struct apply_state *state,
+			     const char *line,
+			     int len,
+			     unsigned ws_rule)
 {
 	unsigned result = ws_check(line + 1, len - 1, ws_rule);
 
-	record_ws_error(result, line + 1, len - 2, state_linenr);
+	record_ws_error(state, result, line + 1, len - 2, state_linenr);
 }
 
 /*
@@ -1602,12 +1609,12 @@ static int parse_fragment(struct apply_state *state,
 			trailing++;
 			if (!state->apply_in_reverse &&
 			    ws_error_action == correct_ws_error)
-				check_whitespace(line, len, patch->ws_rule);
+				check_whitespace(state, line, len, patch->ws_rule);
 			break;
 		case '-':
 			if (state->apply_in_reverse &&
 			    ws_error_action != nowarn_ws_error)
-				check_whitespace(line, len, patch->ws_rule);
+				check_whitespace(state, line, len, patch->ws_rule);
 			deleted++;
 			oldlines--;
 			trailing = 0;
@@ -1615,7 +1622,7 @@ static int parse_fragment(struct apply_state *state,
 		case '+':
 			if (!state->apply_in_reverse &&
 			    ws_error_action != nowarn_ws_error)
-				check_whitespace(line, len, patch->ws_rule);
+				check_whitespace(state, line, len, patch->ws_rule);
 			added++;
 			newlines--;
 			trailing = 0;
@@ -2904,7 +2911,7 @@ static int apply_one_fragment(struct apply_state *state,
 		    preimage.nr + applied_pos >= img->nr &&
 		    (ws_rule & WS_BLANK_AT_EOF) &&
 		    ws_error_action != nowarn_ws_error) {
-			record_ws_error(WS_BLANK_AT_EOF, "+", 1,
+			record_ws_error(state, WS_BLANK_AT_EOF, "+", 1,
 					found_new_blank_lines_at_end);
 			if (ws_error_action == correct_ws_error) {
 				while (new_blank_lines_at_end--)
@@ -4427,7 +4434,7 @@ static int apply_patch(struct apply_state *state,
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
 
-	patch_input_file = filename;
+	state->patch_input_file = filename;
 	read_patch_file(&buf, fd);
 	offset = 0;
 	while (offset < buf.len) {
-- 
2.8.3.443.gaeee61e
