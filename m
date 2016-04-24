From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 28/83] builtin/apply: move 'patch_input_file' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:28 +0200
Message-ID: <1461504863-15946-29-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:35:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCH-0007z6-3A
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbcDXNfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:31 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36493 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbcDXNfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:25 -0400
Received: by mail-wm0-f45.google.com with SMTP id v188so69562537wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XL7WqZDmSFWUpu9nJfJX75UDYQUI56a+mi6xyhrF8zg=;
        b=JxTLRPOPrNpFPsRYahPJfxQnO1tuRRZ48yqW/+8jt9Occ+X8fH7mgbPvi7GxhrsNlw
         ZI24GC3uerQtiLfV2I4DgU4eCzYU4s8I4MxSpu3YIuC/EM0SoROeTGL9m3lZRTo1YaHk
         AIdazcvPnUwgR/3z1BDev2iBksgQVEoy0sLAFYX8MsKvU3rTDBggEx+8klholkAjM16o
         coEi4h4kYRGYuK20bSIbz9pRkarr8a0QOVQOsB36ZJnmv3iQI4D0ZS1J43sRRFwYdaTV
         W03169oG2RlSOsKEP4lJpiP3SzNrY51bsDXp/ZDw/oe3oDbtDk5ey0voP7hffHgmsTHg
         WHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XL7WqZDmSFWUpu9nJfJX75UDYQUI56a+mi6xyhrF8zg=;
        b=OWBenJ4rXeOy70ddHuCmFLNF8IF3j57vBDCkjl60PETnfyfir832Sf7DVahFPyduEE
         HIuJRLIf59A6/k3hUGeU55EpRp59aKlI0O0s38tCldqa81cNHYM8yvzElGWoaJC+sWYL
         ysSX8Rbd8rxCI1t9UhSkJozyPqzH2rQDH/tebCK8PAMrSP3c93cquZnBJua2OedZUgU6
         vsAZ154P8Sgw63AYFJOgY00QflC92z+7fHFWAzQOCpKKWdckuUEr3rHkqPFL/K2H0Ug8
         bOiBcZpEdoF4acayoEPOsabfK4PeWGfe+zwgSFARFmltApVcWQUEui+46/XkzqTyjTPt
         qc6w==
X-Gm-Message-State: AOPr4FUeiwxTmcvvOVe//GyrmV+BNCq97fz7JS7JH0b8Z3pmhbP5R2gU7aYtEsEUAu15MQ==
X-Received: by 10.194.107.6 with SMTP id gy6mr11957150wjb.20.1461504924279;
        Sun, 24 Apr 2016 06:35:24 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:23 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292337>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index be237d1..ab311c1 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -66,6 +66,8 @@ struct apply_state {
 	int line_termination;
 
 	unsigned int p_context;
+
+	const char *patch_input_file;
 };
 
 static int newfd = -1;
@@ -94,7 +96,6 @@ static enum ws_ignore {
 } ws_ignore_action = ignore_ws_none;
 
 
-static const char *patch_input_file;
 static struct strbuf root = STRBUF_INIT;
 
 static void parse_whitespace_option(const char *option)
@@ -1540,7 +1541,11 @@ static int find_header(struct apply_state *state,
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
 
@@ -1554,15 +1559,18 @@ static void record_ws_error(unsigned result, const char *line, int len, int l_nr
 
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
@@ -1617,12 +1625,12 @@ static int parse_fragment(struct apply_state *state,
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
@@ -1630,7 +1638,7 @@ static int parse_fragment(struct apply_state *state,
 		case '+':
 			if (!state->apply_in_reverse &&
 			    ws_error_action != nowarn_ws_error)
-				check_whitespace(line, len, patch->ws_rule);
+				check_whitespace(state, line, len, patch->ws_rule);
 			added++;
 			newlines--;
 			trailing = 0;
@@ -2920,7 +2928,7 @@ static int apply_one_fragment(struct apply_state *state,
 		    preimage.nr + applied_pos >= img->nr &&
 		    (ws_rule & WS_BLANK_AT_EOF) &&
 		    ws_error_action != nowarn_ws_error) {
-			record_ws_error(WS_BLANK_AT_EOF, "+", 1,
+			record_ws_error(state, WS_BLANK_AT_EOF, "+", 1,
 					found_new_blank_lines_at_end);
 			if (ws_error_action == correct_ws_error) {
 				while (new_blank_lines_at_end--)
@@ -4443,7 +4451,7 @@ static int apply_patch(struct apply_state *state,
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
 
-	patch_input_file = filename;
+	state->patch_input_file = filename;
 	read_patch_file(&buf, fd);
 	offset = 0;
 	while (offset < buf.len) {
-- 
2.8.1.300.g5fed0c0
