From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 38/48] builtin/apply: move 'squelch_whitespace_errors' into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:49:06 +0100
Message-ID: <1457545756-20616-39-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiJA-0000CS-6C
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933772AbcCIRx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:59 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:32845 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933298AbcCIRxo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:44 -0500
Received: by mail-wm0-f43.google.com with SMTP id l68so203704809wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NediaJaf2wfG1fNVk/XMOp+5LoDu2tS+FCxL5u7mgsw=;
        b=YeWtkxJl7IyIAgsaMNqoxxKsEbnyiiM/meCpVpQDIs+D4RFJSKAkCOvc/BSH7sDa/J
         G+p20uCShymit9Slq0fV/HOrFv//8wm9ra09K7MBIbeLV/tEdyx3Npydgzt/YENQRoMi
         5Se0xFah9ppngmr6oF3BFGfru+CRkKZqk6qVxcH+hb6wapG/aQwDj6w9vARyuQKIflep
         oKuMnYvj5u+eDfo+AOaUvK4CAVThZBeQV4+vOFtnjkzVdHzK6KSZJXFRDQp4Lmz10H5O
         1kf2MzAeTHqC9PSm9S4+dhCYr4QiWlB9NCp80quprrTynriT2wkgA490SMN2xRfaFOZv
         mrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NediaJaf2wfG1fNVk/XMOp+5LoDu2tS+FCxL5u7mgsw=;
        b=m2WoPHHK3UpRqHvtwgXDM+HAUq6Zd8FS+hj6ammVSImtSElDaqHnaE8id0HMJ3ARj5
         Lc3OOSIU4rYBtzQOR+Q2ZnogFX0kl0q34oOMJ1zqvtPaEkK7IISldq2kjvJzj1Lx2Uai
         tI55ijpokQ7w0aeTtknxdLztFl/f+SxZt5x42l3Tg8+JaC5QV/yHcUIVb4cbiRBoUA4U
         hfdFxRp0w2Xk1K7mck5MVOH3WjdY7YbATgSUSf57Ci9IgOL2UL6giLt3bpuhS36FaM9r
         TzXRa0gWRm6aHPEylHM861a8UuokBSPK7PhR7BOsTAv65a7EXFpXSA2sRg9Ng3WKqHkH
         hHMQ==
X-Gm-Message-State: AD7BkJLk1TMQAUwaDmcnVeiRkKa7fL8sG51tJ9/L9+UN3Kgn/1HvNE+12/43QyaTDgU/Og==
X-Received: by 10.194.174.197 with SMTP id bu5mr39781756wjc.23.1457546022836;
        Wed, 09 Mar 2016 09:53:42 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:41 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288523>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 3c00551..a2e1e51 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -81,6 +81,7 @@ struct apply_state {
 
 	const char *whitespace_option;
 	int whitespace_error;
+	int squelch_whitespace_errors;
 };
 
 static const char * const apply_usage[] = {
@@ -94,7 +95,6 @@ static enum ws_error_action {
 	die_on_ws_error,
 	correct_ws_error
 } ws_error_action = warn_on_ws_error;
-static int squelch_whitespace_errors = 5;
 static int applied_after_fixing_ws;
 
 static enum ws_ignore {
@@ -103,7 +103,7 @@ static enum ws_ignore {
 } ws_ignore_action = ignore_ws_none;
 
 
-static void parse_whitespace_option(const char *option)
+static void parse_whitespace_option(struct apply_state *state, const char *option)
 {
 	if (!option) {
 		ws_error_action = warn_on_ws_error;
@@ -123,7 +123,7 @@ static void parse_whitespace_option(const char *option)
 	}
 	if (!strcmp(option, "error-all")) {
 		ws_error_action = die_on_ws_error;
-		squelch_whitespace_errors = 0;
+		state->squelch_whitespace_errors = 0;
 		return;
 	}
 	if (!strcmp(option, "strip") || !strcmp(option, "fix")) {
@@ -1624,8 +1624,8 @@ static void record_ws_error(struct apply_state *state,
 		return;
 
 	state->whitespace_error++;
-	if (squelch_whitespace_errors &&
-	    squelch_whitespace_errors < state->whitespace_error)
+	if (state->squelch_whitespace_errors &&
+	    state->squelch_whitespace_errors < state->whitespace_error)
 		return;
 
 	err = whitespace_error_string(result);
@@ -4633,9 +4633,8 @@ static int option_parse_whitespace(const struct option *opt,
 				   const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
-
 	state->whitespace_option = arg;
-	parse_whitespace_option(arg);
+	parse_whitespace_option(state, arg);
 	return 0;
 }
 
@@ -4736,11 +4735,12 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	state.line_termination = '\n';
 	state.p_value = 1;
 	state.p_context = UINT_MAX;
+	state.squelch_whitespace_errors = 5;
 	strbuf_init(&state.root, 0);
 
 	git_apply_config();
 	if (apply_default_whitespace)
-		parse_whitespace_option(apply_default_whitespace);
+		parse_whitespace_option(&state, apply_default_whitespace);
 	if (apply_default_ignorewhitespace)
 		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
 
@@ -4795,10 +4795,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	if (read_stdin)
 		errs |= apply_patch(&state, 0, "<stdin>", options);
 	if (state.whitespace_error) {
-		if (squelch_whitespace_errors &&
-		    squelch_whitespace_errors < state.whitespace_error) {
+		if (state.squelch_whitespace_errors &&
+		    state.squelch_whitespace_errors < state.whitespace_error) {
 			int squelched =
-				state.whitespace_error - squelch_whitespace_errors;
+				state.whitespace_error - state.squelch_whitespace_errors;
 			warning(Q_("squelched %d whitespace error",
 				   "squelched %d whitespace errors",
 				   squelched),
-- 
2.8.0.rc1.49.gca61272
