From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 29/48] builtin/apply: move 'patch_input_file' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:57 +0100
Message-ID: <1457545756-20616-30-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiIj-0008NP-KY
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933757AbcCIRx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:29 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37099 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933741AbcCIRxU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:20 -0500
Received: by mail-wm0-f41.google.com with SMTP id p65so81822419wmp.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ZjH1xAWi6mK/Pzr+qQN6ZfQWfU3JNANROrLJkr27G0=;
        b=sYYJhUB1yG+k+CHvDJbhKLGyvpbH2IiuVpeyv6ZBixlYcCBX84QOx2nLUM43Ek4TOz
         GwddXcGTZALAy6gfAa4vbTw/+Vj6V5y8NDuv0lbdUJzJDNeBhFx92cXFJK12e/G5SAR7
         2JQjfsKpYc1tg/JDtXxyuJjjpOCGgrWjefJ3CTUSfEO1W1WRV1L6TOkdG4bRMnHzea2G
         jLhrvXVxDjp9a/ISe5VuCtimbzJkYnnHOAErFtQfkNwkSkS+cEHSL1uET8lORVENURLw
         oQ1JTtn5IQ0Bnb6TMjLKI9Cf6pTVm+GqD6qFFAm9m1lOLnX7aum7I9tEaq8bs/vjGnuq
         /5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ZjH1xAWi6mK/Pzr+qQN6ZfQWfU3JNANROrLJkr27G0=;
        b=Tqo/HXVZnsNDnIHndc1wzX6PBt6/WrZo+g5SZcj5+VqDSkn+Lk1B70DhfZEBwaGbvR
         hjZlSFczNDeSg5y3rFyJW07OXy8cBWlSgZkea04ThukQKp2nAQV6L7JdxDkd/WRezNC5
         b5q+U28lgKLOEYwWVi4ZliGTcgfY0ezef0bGwn6KhjfX+MC4hmSVlVWATWZwi128iI86
         DBpt8ewwe3/YjD4MsJoHW3AVm4zMtqmw9INKdfkwe27Y/0L7ObTnmpaKQkOC8UQrYnZk
         pcRLLIXFbeYGmMaTk28xa5K+VUTd78ScFL1v0tWsv73lF/DlDfEUD5RYD5F1FlfejWVe
         B2lw==
X-Gm-Message-State: AD7BkJIKBzLTKYV3/DgoxM/rl7H5c806o1IjJLXVsS0qCfaluDbaBhBHdsqzIqhLVPdTtg==
X-Received: by 10.28.184.148 with SMTP id i142mr442060wmf.22.1457545997919;
        Wed, 09 Mar 2016 09:53:17 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:17 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288517>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 70bb51a..e94594d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -69,6 +69,8 @@ struct apply_state {
 	unsigned int p_context;
 
 	struct lock_file lock_file;
+
+	const char *patch_input_file;
 };
 
 static int p_value = 1;
@@ -95,7 +97,6 @@ static enum ws_ignore {
 } ws_ignore_action = ignore_ws_none;
 
 
-static const char *patch_input_file;
 static struct strbuf root = STRBUF_INIT;
 
 static void parse_whitespace_option(const char *option)
@@ -1550,7 +1551,11 @@ static int find_header(struct apply_state *state,
 	return -1;
 }
 
-static void record_ws_error(unsigned result, const char *line, int len, int l_nr)
+static void record_ws_error(struct apply_state *state,
+			    unsigned result,
+			    const char *line,
+			    int len,
+			    int l_nr)
 {
 	char *err;
 
@@ -1564,15 +1569,18 @@ static void record_ws_error(unsigned result, const char *line, int len, int l_nr
 
 	err = whitespace_error_string(result);
 	fprintf(stderr, "%s:%d: %s.\n%.*s\n",
-		patch_input_file, l_nr, err, len, line);
+		state->patch_input_file, l_nr, err, len, line);
 	free(err);
 }
 
-static void check_whitespace(const char *line, int len, unsigned ws_rule)
+static void check_whitespace(struct apply_state *state,
+			     const char *line,
+			     int len,
+			     unsigned ws_rule)
 {
 	unsigned result = ws_check(line + 1, len - 1, ws_rule);
 
-	record_ws_error(result, line + 1, len - 2, linenr);
+	record_ws_error(state, result, line + 1, len - 2, linenr);
 }
 
 /*
@@ -1627,12 +1635,12 @@ static int parse_fragment(struct apply_state *state,
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
@@ -1640,7 +1648,7 @@ static int parse_fragment(struct apply_state *state,
 		case '+':
 			if (!state->apply_in_reverse &&
 			    ws_error_action != nowarn_ws_error)
-				check_whitespace(line, len, patch->ws_rule);
+				check_whitespace(state, line, len, patch->ws_rule);
 			added++;
 			newlines--;
 			trailing = 0;
@@ -2923,7 +2931,7 @@ static int apply_one_fragment(struct apply_state *state,
 		    preimage.nr + applied_pos >= img->nr &&
 		    (ws_rule & WS_BLANK_AT_EOF) &&
 		    ws_error_action != nowarn_ws_error) {
-			record_ws_error(WS_BLANK_AT_EOF, "+", 1,
+			record_ws_error(state, WS_BLANK_AT_EOF, "+", 1,
 					found_new_blank_lines_at_end);
 			if (ws_error_action == correct_ws_error) {
 				while (new_blank_lines_at_end--)
@@ -4444,7 +4452,7 @@ static int apply_patch(struct apply_state *state,
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
 
-	patch_input_file = filename;
+	state->patch_input_file = filename;
 	read_patch_file(&buf, fd);
 	offset = 0;
 	while (offset < buf.len) {
-- 
2.8.0.rc1.49.gca61272
