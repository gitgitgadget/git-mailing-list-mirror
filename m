From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 34/83] builtin/apply: move 'whitespace_error' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:34 +0200
Message-ID: <1461504863-15946-35-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:38:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKEm-0000sg-6g
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbcDXNiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:38:07 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36527 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbcDXNfe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:34 -0400
Received: by mail-wm0-f44.google.com with SMTP id v188so69564823wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BFDU9PfDRJKze3AjpPA/tiRF3ozgAiGbLaef1KxZXI8=;
        b=pzq0SvcPf3StOkrr9T7sE4zrSXdrVKpfezHBRCC1vW4xAIomfnW72onjou+yE471lX
         /5H361UY+3yRBEhrqwwEUwnJW+Bs5L0OWnOQtbIB7PeHpmqplPv7E6nigQDGVCNNy+Bx
         wwRE53Iebw+ylRMvymdjnaeyE3sdUihZ/gv22YPQ/3oF3shlRVredpa/dOFp9smATrhn
         PSpqm3c6ylSi8mbUMAgDQdOqpaslBmrkzBdYDbuVxIRIKLEJcHCbmgqmu4wjy0pwqQL0
         nglIK7dGQQYkGmHYpectbZSxDZxaJvrDs8jUmN/g7GcBxjACfejPymhd4e8xxmc8xD5u
         URQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BFDU9PfDRJKze3AjpPA/tiRF3ozgAiGbLaef1KxZXI8=;
        b=I1KJBU4+fg+Fn9vh0v4E00IfEgxIwHq0/UuTTfmik7VVIlyK2DyzgEtmDM1Sik6SSt
         dDGOVv2LGyM6f23zW1bapqx6ph/A8mCcCTEA/aRNFOGy68mvTuTjyY9RQlTVu+dHeJAI
         GJQmwBIGODr49TC97yWZEMnU1WquudEMQ/cTNMPFegTw6zqpQTaxm28YcCZtYjWItVhC
         OLSkOHvndhS4SjMc6AAfntDbZSiaXJYP5anrIwupRt2v2YX4IsMeOXA3kIAGrPjc+fKt
         sBqrGmnVvMkGe2V2HPFontQnbp9wnrNWPzFUIJZgI6K9yGOb3eZzyxk8vqfH8AC7Skzx
         gWCw==
X-Gm-Message-State: AOPr4FVCsAP9prBtBZQtLCkRosZH8Px5FYZJtIHkUTHuZNdS8WWpXmvrc4DlhPvmN8IWVw==
X-Received: by 10.28.87.18 with SMTP id l18mr6625504wmb.38.1461504933339;
        Sun, 24 Apr 2016 06:35:33 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:32 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292384>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 209a1b4..9c4f67f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -75,6 +75,8 @@ struct apply_state {
 	int has_include;
 
 	struct strbuf root;
+
+	int whitespace_error;
 };
 
 static int newfd = -1;
@@ -90,7 +92,6 @@ static enum ws_error_action {
 	die_on_ws_error,
 	correct_ws_error
 } ws_error_action = warn_on_ws_error;
-static int whitespace_error;
 static int squelch_whitespace_errors = 5;
 static int applied_after_fixing_ws;
 
@@ -1612,9 +1613,9 @@ static void record_ws_error(struct apply_state *state,
 	if (!result)
 		return;
 
-	whitespace_error++;
+	state->whitespace_error++;
 	if (squelch_whitespace_errors &&
-	    squelch_whitespace_errors < whitespace_error)
+	    squelch_whitespace_errors < state->whitespace_error)
 		return;
 
 	err = whitespace_error_string(result);
@@ -2872,7 +2873,7 @@ static int apply_one_fragment(struct apply_state *state,
 
 			start = newlines.len;
 			if (first != '+' ||
-			    !whitespace_error ||
+			    !state->whitespace_error ||
 			    ws_error_action != correct_ws_error) {
 				strbuf_add(&newlines, patch + 1, plen);
 			}
@@ -4545,7 +4546,7 @@ static int apply_patch(struct apply_state *state,
 	if (!list && !skipped_patch)
 		die(_("unrecognized input"));
 
-	if (whitespace_error && (ws_error_action == die_on_ws_error))
+	if (state->whitespace_error && (ws_error_action == die_on_ws_error))
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
@@ -4797,11 +4798,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	set_default_whitespace_mode(&state, whitespace_option);
 	if (read_stdin)
 		errs |= apply_patch(&state, 0, "<stdin>", options);
-	if (whitespace_error) {
+	if (state.whitespace_error) {
 		if (squelch_whitespace_errors &&
-		    squelch_whitespace_errors < whitespace_error) {
+		    squelch_whitespace_errors < state.whitespace_error) {
 			int squelched =
-				whitespace_error - squelch_whitespace_errors;
+				state.whitespace_error - squelch_whitespace_errors;
 			warning(Q_("squelched %d whitespace error",
 				   "squelched %d whitespace errors",
 				   squelched),
@@ -4810,18 +4811,18 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		if (ws_error_action == die_on_ws_error)
 			die(Q_("%d line adds whitespace errors.",
 			       "%d lines add whitespace errors.",
-			       whitespace_error),
-			    whitespace_error);
+			       state.whitespace_error),
+			    state.whitespace_error);
 		if (applied_after_fixing_ws && state.apply)
 			warning("%d line%s applied after"
 				" fixing whitespace errors.",
 				applied_after_fixing_ws,
 				applied_after_fixing_ws == 1 ? "" : "s");
-		else if (whitespace_error)
+		else if (state.whitespace_error)
 			warning(Q_("%d line adds whitespace errors.",
 				   "%d lines add whitespace errors.",
-				   whitespace_error),
-				whitespace_error);
+				   state.whitespace_error),
+				state.whitespace_error);
 	}
 
 	if (state.update_index) {
-- 
2.8.1.300.g5fed0c0
