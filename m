From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 29/94] builtin/apply: move 'patch_input_file' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:40 +0200
Message-ID: <20160511131745.2914-30-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:23:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U7K-0007af-S3
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbcEKNX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:23:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35683 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185AbcEKNT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id e201so9404041wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e06pg9ExdbTsqXk36DJ37JY81CU8AU171oKHOH40Hk4=;
        b=oMdm8T4z3kux7Q1CXLQ0GagjLRBrUgRkCbqUXhLDgyKwJNkIh9JvD/y4ESa1W8/bnz
         OEG0E+OXXXphPABdOgzbvh9FjqKv4deP6+PYbIQ/+8DBS4rPC526yHaUcEj/Cg/FIdej
         3p26iO2QQG1Sbo98AoX5kDnK+v1f4h8NnzsjhWSwTCqFYFADkgdF5S9gCAZSJ2GYEwp/
         6h0xJxFaJATud1/m0ET3UgBYKcMIiCWDsaH2K+jZuBtOWkyLXkwfE5K6GmJU40Zw+uYG
         t8TfSciFaetOUGoSehnXu8wCi7yy7CKG6Fz/imqM52bxCUv5SVYYtHbguv16T2IvIM2W
         bPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e06pg9ExdbTsqXk36DJ37JY81CU8AU171oKHOH40Hk4=;
        b=LbTa0rfRsV72ddf8f7hI6AgZYU/MS7Bd8kRtaNDa08rhnZlC0tnCS5HmRP8zOOxSIT
         VuRgv9esguizMAB2ik3Mql3vv8ajHiQ6f7K3UWLyIG5eaM/EkNmiHaW6djNdtzQjAJH4
         b3VTx+s0dL4Cg7qeL+hVDU6OnEXrpBXLLa0RV3/RmCoAaqInTP7ak0mMy/l74oJ6ftog
         qFKJ+GwmoC7Zjnlz9y6lfAKmAqNtQrjXu3H/jvHw5h84eODOaDYDdkI+Mt0LuEkoC7Yn
         BKeHY5qHIVOLMPebPQ122pneMI7biagOvvjSinXkBafxnjvDMPnJFNNblUUaEPH5RXkk
         uUBw==
X-Gm-Message-State: AOPr4FWLBSdCOeGESqV505a3Q9IEUWnx8IPHdfioMWLIgkk1h/OQ2Yp4N+lp6a4/V0tJnw==
X-Received: by 10.28.29.147 with SMTP id d141mr11252wmd.91.1462972765038;
        Wed, 11 May 2016 06:19:25 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:23 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294328>

To libify the apply functionality the 'patch_input_file' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index a3db284..e43da9c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -44,6 +44,7 @@ struct apply_state {
 	int threeway;
 	int no_add;
 	const char *fake_ancestor;
+	const char *patch_input_file;
 
 	/*
 	 *  --check turns on checking that the working tree matches the
@@ -88,7 +89,6 @@ static enum ws_ignore {
 } ws_ignore_action = ignore_ws_none;
 
 
-static const char *patch_input_file;
 static struct strbuf root = STRBUF_INIT;
 
 static void parse_whitespace_option(const char *option)
@@ -1534,7 +1534,11 @@ static int find_header(struct apply_state *state,
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
 
@@ -1548,15 +1552,18 @@ static void record_ws_error(unsigned result, const char *line, int len, int line
 
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
@@ -1611,12 +1618,12 @@ static int parse_fragment(struct apply_state *state,
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
@@ -1624,7 +1631,7 @@ static int parse_fragment(struct apply_state *state,
 		case '+':
 			if (!state->apply_in_reverse &&
 			    ws_error_action != nowarn_ws_error)
-				check_whitespace(line, len, patch->ws_rule);
+				check_whitespace(state, line, len, patch->ws_rule);
 			added++;
 			newlines--;
 			trailing = 0;
@@ -2913,7 +2920,7 @@ static int apply_one_fragment(struct apply_state *state,
 		    preimage.nr + applied_pos >= img->nr &&
 		    (ws_rule & WS_BLANK_AT_EOF) &&
 		    ws_error_action != nowarn_ws_error) {
-			record_ws_error(WS_BLANK_AT_EOF, "+", 1,
+			record_ws_error(state, WS_BLANK_AT_EOF, "+", 1,
 					found_new_blank_lines_at_end);
 			if (ws_error_action == correct_ws_error) {
 				while (new_blank_lines_at_end--)
@@ -4436,7 +4443,7 @@ static int apply_patch(struct apply_state *state,
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
 
-	patch_input_file = filename;
+	state->patch_input_file = filename;
 	read_patch_file(&buf, fd);
 	offset = 0;
 	while (offset < buf.len) {
-- 
2.8.2.490.g3dabe57
