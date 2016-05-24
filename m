From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 35/49] builtin/apply: move 'whitespace_error' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:12 +0200
Message-ID: <20160524081126.16973-36-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:12:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57SK-0000wb-PU
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692AbcEXIMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33936 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbcEXIMe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so3661479wmn.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PJ2ef2L/DZHni6ibE12i9gvjIYzAI5OWgmYIQ3GRuVM=;
        b=vagZT4uCOo+1V1lUZcNqAxI/wWNg+5Rm/lFM3v/TE+wVQWouoqi77Sf4AtGX67EjRM
         f2/G6JtiZsI/C94iNpV/ys2lFAuLCfgwsesbWlVKXkD3ZL2dpyDeNGCogxRdRDMFdV0g
         UX/wTd32RY6r86FBlrTNfLr+F27gxLcPaJVERJccgZ5XukdrIS/HZTUh41Lfljq6xU9G
         DPru6G0yGo+ClkwopmpjxfkUSMM+8XRNSXBA+49fl/9Fbsgps6mA1JqZaeLemI6yBf77
         Nid5d/cMdooLhGXNWdC3Jio0u9CIyGlVwN3LAOHU9ucQvizJCUUR7HcEamDRfqCnrOgL
         Mwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PJ2ef2L/DZHni6ibE12i9gvjIYzAI5OWgmYIQ3GRuVM=;
        b=fA8maxUsR1ZzAMXrcK1/nNLiCMDyGcCMkfZ3o/EnuGbuMhJtHy8FxFQq0C2WMEk36u
         rbexYDJMCJ6p9GhTWYcgNlwy9W/Yc5pNgQFV9X5cyZOoC4rrwhbCYOvxTuaMzTt5qpZq
         GTSXTzCmH8q/sKH8BS/jpGkJxUgTeLZdZcSvJvhpLapczV2YJMA78UDHUdexTbmQDTA6
         NGIdd0F/usSngSajujYxagfwaFiAl/qTwJ/cjYpWNe+pMS1HgprNd3Q8iXBlT8kJq+z5
         jzz9sH7eyawfGpvV8G+A9EiB7EPpC7Zt/6BVZ4bDFH3atfmi6G6zkSmeV1ML7B6Zw8hh
         wZMw==
X-Gm-Message-State: ALyK8tJVViPCXR6avSz7OjIhwaBG0ZdaZDf78mP6UR8YB3W2MsjV++RE/ZGSUEjBxo0cog==
X-Received: by 10.194.0.138 with SMTP id 10mr2774828wje.73.1464077553228;
        Tue, 24 May 2016 01:12:33 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:32 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295440>

To libify the apply functionality the 'whitespace_error' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5dc1d89..44717b2 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -59,6 +59,9 @@ struct apply_state {
 	/* Exclude and include path parameters */
 	struct string_list limit_by_name;
 	int has_include;
+
+	/* These control whitespace errors */
+	int whitespace_error;
 };
 
 static int newfd = -1;
@@ -74,7 +77,6 @@ static enum ws_error_action {
 	die_on_ws_error,
 	correct_ws_error
 } ws_error_action = warn_on_ws_error;
-static int whitespace_error;
 static int squelch_whitespace_errors = 5;
 static int applied_after_fixing_ws;
 
@@ -1596,9 +1598,9 @@ static void record_ws_error(struct apply_state *state,
 	if (!result)
 		return;
 
-	whitespace_error++;
+	state->whitespace_error++;
 	if (squelch_whitespace_errors &&
-	    squelch_whitespace_errors < whitespace_error)
+	    squelch_whitespace_errors < state->whitespace_error)
 		return;
 
 	err = whitespace_error_string(result);
@@ -2855,7 +2857,7 @@ static int apply_one_fragment(struct apply_state *state,
 
 			start = newlines.len;
 			if (first != '+' ||
-			    !whitespace_error ||
+			    !state->whitespace_error ||
 			    ws_error_action != correct_ws_error) {
 				strbuf_add(&newlines, patch + 1, plen);
 			}
@@ -4528,7 +4530,7 @@ static int apply_patch(struct apply_state *state,
 	if (!list && !skipped_patch)
 		die(_("unrecognized input"));
 
-	if (whitespace_error && (ws_error_action == die_on_ws_error))
+	if (state->whitespace_error && (ws_error_action == die_on_ws_error))
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
@@ -4791,11 +4793,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
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
@@ -4804,18 +4806,18 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
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
2.8.3.443.gaeee61e
