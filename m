From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 37/83] builtin/apply: move 'squelch_whitespace_errors' into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:37 +0200
Message-ID: <1461504863-15946-38-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:35:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCU-00086B-Gg
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbcDXNfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:42 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36547 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbcDXNfk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:40 -0400
Received: by mail-wm0-f54.google.com with SMTP id v188so69566215wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TU3cln61yKYTynNKIbpXoAF1sFKs9ieuhM+QLGtOpOk=;
        b=lBPkLctnUkTX9lWzDDrmIjQCXfIYhyOWY+pqnJjNEPIEhIw31dH8FuFi5ITztIPm1N
         S/KYmIGbsDynfTQxv2drMsIVVWl9LZnIdqMh+Tw5zjf3tnu27Bk5VHcMnwfOj2qloujT
         q9QZOxdIHPsjtIwzJTyxScy+l+C0F45DnLzqbNl8pTE2uMNawxWvrxahoV84SKMvpuak
         mMja2L6vh9CsA3/W5G4RTtH9R9uvvkhsDEMM8FF687/D19g5IvtcA8KK82gtKK8RVz3Q
         pcJWAWw+i3bV7rz4cfd0ywOL/Pdvj58tQBkQO0cNowfvT2FibIBe+TYf3CtL4hqA2oJv
         0Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TU3cln61yKYTynNKIbpXoAF1sFKs9ieuhM+QLGtOpOk=;
        b=C8z8nvxXTNE9+Lo07wYa2gv2Efx/pCNDMaltCd/WrrJ40CAESo+o+RwB/5bXPMk/0p
         sLJB6spAr7Adk/6sKfA94/G1cR9NaB31DQ0BQuttERq2xE93wXcqQF9vaka8acEDlPQy
         pJsQqjvYqYcR58fKpjhgev0vOhMA11k1vei+Ol5sSj/pLB2pwzXyTiTt5VP2Y3gcISIy
         qs22ap7o0UeUQcz+yrgyYlsBOPVEliWlACB4cWWpF7pnzv0XtFdxdwhjtlrY6s2S7sZx
         pLoIwUwNFk9vC7twAbL9Iioa2Rnh11nLq+SQQi6RaE9aefh7ROJk7mzM0+biEnBbRarU
         fmsg==
X-Gm-Message-State: AOPr4FUKEruBDi9r0JPuNdrUoJor9QGUotTkdWdJuA5kADdi65O5VDp5l0Z4BjCSXDsDUA==
X-Received: by 10.195.17.166 with SMTP id gf6mr29137392wjd.124.1461504938457;
        Sun, 24 Apr 2016 06:35:38 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:37 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292341>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 401e111..259f256 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -78,6 +78,7 @@ struct apply_state {
 
 	const char *whitespace_option;
 	int whitespace_error;
+	int squelch_whitespace_errors;
 };
 
 static int newfd = -1;
@@ -93,7 +94,6 @@ static enum ws_error_action {
 	die_on_ws_error,
 	correct_ws_error
 } ws_error_action = warn_on_ws_error;
-static int squelch_whitespace_errors = 5;
 static int applied_after_fixing_ws;
 
 static enum ws_ignore {
@@ -102,7 +102,7 @@ static enum ws_ignore {
 } ws_ignore_action = ignore_ws_none;
 
 
-static void parse_whitespace_option(const char *option)
+static void parse_whitespace_option(struct apply_state *state, const char *option)
 {
 	if (!option) {
 		ws_error_action = warn_on_ws_error;
@@ -122,7 +122,7 @@ static void parse_whitespace_option(const char *option)
 	}
 	if (!strcmp(option, "error-all")) {
 		ws_error_action = die_on_ws_error;
-		squelch_whitespace_errors = 0;
+		state->squelch_whitespace_errors = 0;
 		return;
 	}
 	if (!strcmp(option, "strip") || !strcmp(option, "fix")) {
@@ -1614,8 +1614,8 @@ static void record_ws_error(struct apply_state *state,
 		return;
 
 	state->whitespace_error++;
-	if (squelch_whitespace_errors &&
-	    squelch_whitespace_errors < state->whitespace_error)
+	if (state->squelch_whitespace_errors &&
+	    state->squelch_whitespace_errors < state->whitespace_error)
 		return;
 
 	err = whitespace_error_string(result);
@@ -4636,9 +4636,8 @@ static int option_parse_whitespace(const struct option *opt,
 				   const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
-
 	state->whitespace_option = arg;
-	parse_whitespace_option(arg);
+	parse_whitespace_option(state, arg);
 	return 0;
 }
 
@@ -4738,11 +4737,12 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
 
@@ -4797,10 +4797,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.1.300.g5fed0c0
