From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 28/94] builtin/apply: move 'apply' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:39 +0200
Message-ID: <20160511131745.2914-29-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:24:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U7o-0008Ae-Ha
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbcEKNYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:24:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32849 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932148AbcEKNTY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so9408461wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KO5DJUma18AhPzpPWrmkwHw5U1es8EGsNBhFJRqHflg=;
        b=diiieyNbyjZ6GSDJ8xhlK04hXF7u6gmxXM6EARB3NtocwIq6fUE7DHOPU85U7d+neA
         rH0qw1xNpJHwVeFRxhFqaxckPRfgVN8Niq/UdPMDTeCrPYP+/l2Pn/5WYnnvGaBHXT5F
         dkK8drXlzCTeAZO7k68iSty9tDt8y9SKdGugBo/GU/xBBv6ZJTzpuPWNZCKATAX4JlIC
         bNcz8Bv+xYzL2f+jZM782b9J8Vq+1pIMcylX5uJikTff2tQNOWy/pBAAFISGeULV0jmp
         OypgcnbfdJyP7j44geL6cvtPRqGHgzmHznmBP1aGw+horJxUn7Q/WrgoYtYqGpz6bKO3
         yv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KO5DJUma18AhPzpPWrmkwHw5U1es8EGsNBhFJRqHflg=;
        b=E/Bhl/AQXtroPKZ5XAs13W7wIpD4+0hk4RfSxr1Aj7Z6MrEF2G8F8iYDAMgIAoVHLS
         IJI44kC7paPG0WQPV+dcQ2hUC4S6RkbmPh9pRai5Dk8QcZZzDg/uWodxkN8wF39HKKZ8
         6DGrOVmEhm6QsstXTXlwx5ItcENiSIEHKpx14xhKaDLgbEOeEoNhIlQr+tyvle2CcCQG
         ZKzfQKZXMYBX3Q1iQXqszlm4AHF1jaW/OBpJv+3Q1INtyQmDsc7WE0lt9vpANHBcz/8G
         Wyeht29OJk5tLv5wgGUc/WhgytDwUquAGa0FHTOpgG4ZOaxtWOl2Ru3bmwAtYoR5w8UN
         QNNg==
X-Gm-Message-State: AOPr4FXCTCSGcXRo6LV3vhVXnf+O/hM+Vp8lHA9d5chBx4K35IP8yo30UqhcjyQAv56Nhg==
X-Received: by 10.28.127.81 with SMTP id a78mr82523wmd.34.1462972762743;
        Wed, 11 May 2016 06:19:22 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:21 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294330>

To libify the apply functionality the 'apply' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 2ba2b21..a3db284 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -25,6 +25,7 @@ struct apply_state {
 	const char *prefix;
 	int prefix_length;
 
+	int apply;
 	int allow_overlap;
 	int apply_in_reverse;
 	int apply_with_reject;
@@ -65,7 +66,7 @@ static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int apply = 1;
+
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -135,10 +136,11 @@ static void parse_ignorewhitespace_option(const char *option)
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
@@ -2067,7 +2069,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 * without metadata change.  A binary patch appears
 		 * empty to us here.
 		 */
-		if ((apply || state->check) &&
+		if ((state->apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
 			die(_("patch with only garbage at line %d"), state_linenr);
 	}
@@ -2925,7 +2927,7 @@ static int apply_one_fragment(struct apply_state *state,
 			 * apply_data->apply_fragments->apply_one_fragment
 			 */
 			if (ws_error_action == die_on_ws_error)
-				apply = 0;
+				state->apply = 0;
 		}
 
 		if (state->apply_verbosely && applied_pos != pos) {
@@ -4469,9 +4471,9 @@ static int apply_patch(struct apply_state *state,
 		die(_("unrecognized input"));
 
 	if (whitespace_error && (ws_error_action == die_on_ws_error))
-		apply = 0;
+		state->apply = 0;
 
-	state->update_index = state->check_index && apply;
+	state->update_index = state->check_index && state->apply;
 	if (state->update_index && newfd < 0)
 		newfd = hold_locked_index(&lock_file, 1);
 
@@ -4480,12 +4482,12 @@ static int apply_patch(struct apply_state *state,
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
@@ -4574,6 +4576,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
 	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
+	state->apply = 1;
 	state->line_termination = '\n';
 	state->p_context = UINT_MAX;
 
@@ -4680,9 +4683,9 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
@@ -4710,11 +4713,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
@@ -4732,7 +4735,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			       "%d lines add whitespace errors.",
 			       whitespace_error),
 			    whitespace_error);
-		if (applied_after_fixing_ws && apply)
+		if (applied_after_fixing_ws && state.apply)
 			warning("%d line%s applied after"
 				" fixing whitespace errors.",
 				applied_after_fixing_ws,
-- 
2.8.2.490.g3dabe57
