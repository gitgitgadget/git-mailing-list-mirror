From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 35/48] builtin/apply: move 'whitespace_error' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:49:03 +0100
Message-ID: <1457545756-20616-36-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiJ9-0000CS-Ji
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933769AbcCIRx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:57 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35811 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776AbcCIRxl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:41 -0500
Received: by mail-wm0-f54.google.com with SMTP id l68so190244357wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=19iDITaszhXDsNnurmaFK2kpt6lBdmUHP96p6N4fjd8=;
        b=ZzFXK8pZqZ9PPPvn6qnsHEdlMNPpesvwxTZsJiAiBIBeudnD7+g1cOJyGtoe+8SK1k
         Gzn1T3JSrMnI1D7+NHInP8ymVOfoNyeFCe65SEOnmTvIKzzRR7l86Ynf09xuuR6uUz03
         JV5mqfnsZolbzfoG7TvDh4wd7gGbVjJNW8eq4j9Q7VCOiValzVmGfuCKAHgIM7JFZRcl
         Q270YMWRjkqiSkYdqUbcqfuqNlL/yEldCk3FBskXPPT36GFt77FnIJ5HbKqUQ+ZKCdo5
         mq10YblHgOAbuZTQP0XHCFSzOLjZVMsKmLOUgz86hqPO1FmUm49zGCNn94yaSoVao0D+
         Wjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=19iDITaszhXDsNnurmaFK2kpt6lBdmUHP96p6N4fjd8=;
        b=WtqhclHFmHCfQI8iAAuNG6DSmO1YwlgLYANwS+0fgTNzrYD2HuZ3eq4vPBF0zZ0zfp
         DIdtbMK9UTYtYI6k3Wcs5WncHdKEcxI71ovDSMYhJTHgUkr9z0ze7RKZ+eycy6fLFPn2
         ihauFSqgFMEVRvoE1NGg+Hd846TdWApoVxSCO8BH3DcctqqAEz+n1RQBto3eBJ12wxlI
         ih4eH6E57ttP9nvC51y56peKJ9ZTNRu2jLrtXbe7w9RHHvhmA1xOvegFhG32xjdGc7UH
         ydw3PX+r4ZKvKYwphGoMjfkZaKbexNUGMMrbBE8F1XCWodNbvhoaXsPMmCOs00ezXP+x
         J5gQ==
X-Gm-Message-State: AD7BkJLfzqCf3wiM0O0nLVaX+UBeRZQ+CIVSRby3j3G7S+nMNcfyNjUVCGG+cLDQ1tjE+A==
X-Received: by 10.194.87.161 with SMTP id az1mr36704117wjb.163.1457546015207;
        Wed, 09 Mar 2016 09:53:35 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:34 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288525>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8571646..1d665c2 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -78,6 +78,8 @@ struct apply_state {
 	int has_include;
 
 	struct strbuf root;
+
+	int whitespace_error;
 };
 
 static const char * const apply_usage[] = {
@@ -91,7 +93,6 @@ static enum ws_error_action {
 	die_on_ws_error,
 	correct_ws_error
 } ws_error_action = warn_on_ws_error;
-static int whitespace_error;
 static int squelch_whitespace_errors = 5;
 static int applied_after_fixing_ws;
 
@@ -1622,9 +1623,9 @@ static void record_ws_error(struct apply_state *state,
 	if (!result)
 		return;
 
-	whitespace_error++;
+	state->whitespace_error++;
 	if (squelch_whitespace_errors &&
-	    squelch_whitespace_errors < whitespace_error)
+	    squelch_whitespace_errors < state->whitespace_error)
 		return;
 
 	err = whitespace_error_string(result);
@@ -2875,7 +2876,7 @@ static int apply_one_fragment(struct apply_state *state,
 
 			start = newlines.len;
 			if (first != '+' ||
-			    !whitespace_error ||
+			    !state->whitespace_error ||
 			    ws_error_action != correct_ws_error) {
 				strbuf_add(&newlines, patch + 1, plen);
 			}
@@ -4542,7 +4543,7 @@ static int apply_patch(struct apply_state *state,
 	if (!list && !skipped_patch)
 		die(_("unrecognized input"));
 
-	if (whitespace_error && (ws_error_action == die_on_ws_error))
+	if (state->whitespace_error && (ws_error_action == die_on_ws_error))
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
@@ -4795,11 +4796,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
@@ -4808,18 +4809,18 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.0.rc1.49.gca61272
