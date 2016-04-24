From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 26/83] builtin/apply: move 'apply' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:26 +0200
Message-ID: <1461504863-15946-27-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:38:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKFD-00017X-E3
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbcDXNf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:27 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37636 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbcDXNfX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:23 -0400
Received: by mail-wm0-f52.google.com with SMTP id n3so90205798wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lZT/9pSEu8Ne3E5W+GTEkAsb4TU3PA1m2liWEA+xwZQ=;
        b=lIVVmoVoKiz3bA9H/aRbn5DtVqJuiHzu5zum2d3RlF701mXG9ReptJGWaQasX/T68b
         XbeOYf0Uog863w3BdUOdX/zwf/UL5nB+Owu3X601+RyEfPpFVV8MnNjtZd5lLKI2qZes
         LjYo9p0V1VyPlKzCctfBFpVjgTdGU+vl8jKSlU9MZ0Cj0eX2SvCsY4fxwNDAf5m755MA
         gIr+e2U2yA5dqjkanaUl3mGh9QX9EtREKSkA666tSHJVhtefRTwIyyddI/yhmF6UMfvj
         nce03iMoVH8mT7erfgeOth2KSSy8HTRKmjlkL/fSJUtQb600oqM67gZczP0yJcV13ecQ
         2GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lZT/9pSEu8Ne3E5W+GTEkAsb4TU3PA1m2liWEA+xwZQ=;
        b=U81CMhSM0qVKj0xB3u6WFjfiBboURx8UVLSVZEANdLR/mhE5JkP10wNfTT06nvS0Ds
         N0ampBEzJ5rgrLQ6/6C/KTImNC+SiA8EUMdq0DjnCiLZbklOCJZ5iZwgj2El+U3Bo2aS
         k5AvNbN5a3WmZhjPLEoYtCgvJS7DoTv8m2M3w+29JAnSUMmehX3T7udVuY5+J1vwQlUK
         5ziBljrZD/FVjaFiLyPL1jbdaArA4Kf7vZhYs+PMIZDhnT6N8up2JlDBbqIoRc3rFxQX
         7Aajk5TEa/UjPNd9+b84nhxK2XDkU1+M2kqSKgUL4yJP4Rs0R1vTBqr81u250l9bG47I
         td5w==
X-Gm-Message-State: AOPr4FVZpKwT4PyCu/YgYXFfp+7gZr0jYZNl02mFZy5rAxZMIQ3tigMbG9zaIhLzIAQZrQ==
X-Received: by 10.194.170.5 with SMTP id ai5mr29693688wjc.75.1461504921614;
        Sun, 24 Apr 2016 06:35:21 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:20 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292388>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b6d2343..699cabf 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -25,6 +25,7 @@ struct apply_state {
 	const char *prefix;
 	int prefix_length;
 
+	int apply;
 	int allow_overlap;
 	int apply_in_reverse;
 	int apply_with_reject;
@@ -71,7 +72,7 @@ static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int apply = 1;
+
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -142,10 +143,11 @@ static void parse_ignorewhitespace_option(const char *option)
 	die(_("unrecognized whitespace ignore option '%s'"), option);
 }
 
-static void set_default_whitespace_mode(const char *whitespace_option)
+static void set_default_whitespace_mode(struct apply_state *state,
+					const char *whitespace_option)
 {
 	if (!whitespace_option && !apply_default_whitespace)
-		ws_error_action = (apply ? warn_on_ws_error : nowarn_ws_error);
+		ws_error_action = (state->apply ? warn_on_ws_error : nowarn_ws_error);
 }
 
 /*
@@ -2074,7 +2076,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 * without metadata change.  A binary patch appears
 		 * empty to us here.
 		 */
-		if ((apply || state->check) &&
+		if ((state->apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
 			die(_("patch with only garbage at line %d"), linenr);
 	}
@@ -2933,7 +2935,7 @@ static int apply_one_fragment(struct apply_state *state,
 			 * apply_data->apply_fragments->apply_one_fragment
 			 */
 			if (ws_error_action == die_on_ws_error)
-				apply = 0;
+				state->apply = 0;
 		}
 
 		if (state->apply_verbosely && applied_pos != pos) {
@@ -4477,9 +4479,9 @@ static int apply_patch(struct apply_state *state,
 		die(_("unrecognized input"));
 
 	if (whitespace_error && (ws_error_action == die_on_ws_error))
-		apply = 0;
+		state->apply = 0;
 
-	state->update_index = state->check_index && apply;
+	state->update_index = state->check_index && state->apply;
 	if (state->update_index && newfd < 0)
 		newfd = hold_locked_index(&lock_file, 1);
 
@@ -4488,12 +4490,12 @@ static int apply_patch(struct apply_state *state,
 			die(_("unable to read index file"));
 	}
 
-	if ((state->check || apply) &&
+	if ((state->check || state->apply) &&
 	    check_patch_list(state, list) < 0 &&
 	    !state->apply_with_reject)
 		exit(1);
 
-	if (apply && write_out_results(state, list)) {
+	if (state->apply && write_out_results(state, list)) {
 		if (state->apply_with_reject)
 			exit(1);
 		/* with --3way, we still need to write the index out */
@@ -4660,6 +4662,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	memset(&state, 0, sizeof(state));
 	state.prefix = prefix_;
 	state.prefix_length = state.prefix ? strlen(state.prefix) : 0;
+	state.apply = 1;
 	state.line_termination = '\n';
 	state.p_context = UINT_MAX;
 
@@ -4682,9 +4685,9 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		state.check_index = 1;
 	}
 	if (state.apply_with_reject)
-		apply = state.apply_verbosely = 1;
+		state.apply = state.apply_verbosely = 1;
 	if (!force_apply && (state.diffstat || state.numstat || state.summary || state.check || state.fake_ancestor))
-		apply = 0;
+		state.apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
 	if (state.cached) {
@@ -4712,11 +4715,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		if (fd < 0)
 			die_errno(_("can't open patch '%s'"), arg);
 		read_stdin = 0;
-		set_default_whitespace_mode(whitespace_option);
+		set_default_whitespace_mode(&state, whitespace_option);
 		errs |= apply_patch(&state, fd, arg, options);
 		close(fd);
 	}
-	set_default_whitespace_mode(whitespace_option);
+	set_default_whitespace_mode(&state, whitespace_option);
 	if (read_stdin)
 		errs |= apply_patch(&state, 0, "<stdin>", options);
 	if (whitespace_error) {
@@ -4734,7 +4737,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			       "%d lines add whitespace errors.",
 			       whitespace_error),
 			    whitespace_error);
-		if (applied_after_fixing_ws && apply)
+		if (applied_after_fixing_ws && state.apply)
 			warning("%d line%s applied after"
 				" fixing whitespace errors.",
 				applied_after_fixing_ws,
-- 
2.8.1.300.g5fed0c0
