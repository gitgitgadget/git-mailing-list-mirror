From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 26/48] builtin/apply: move 'apply' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:54 +0100
Message-ID: <1457545756-20616-27-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiIY-0008Ga-O4
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933745AbcCIRxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:21 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36286 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933731AbcCIRxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:09 -0500
Received: by mail-wm0-f42.google.com with SMTP id n186so190606624wmn.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yd4SufabSga28+N78sP2t6Qu0ICLoI6OvwdSwu5LogQ=;
        b=y69ZK9odamnDgjWsp/Faa1L5fQ4ASx2p3ow7fd+Ao9Zeq5IGPsyryby6iYWDiXnuRG
         MxV1rI3a3mUez7D1wNbj+x3GVIxvZDhwN7FasN6zsj3nkkhfbtlPnjmIbXXKTGwVfLLG
         m0CGlfxuT0Kd1AyV9HxJdnGE31U8DQZsqk3IylN81pLaC8EmD4VW5cUjIZ2goqZv3SSV
         9LkdH2E14XePxCsfoR7ajqJ7RZY+/BZHb0NZzDrLHu1FR7GXV+MaCHdLV8/sSiL8SGp6
         m17ucHfwQjbVJlaGrYFs7dJ5bNzgjwlHBCjBwJnmd862judfN7bzQDuUSEtypdknXsbu
         +RGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yd4SufabSga28+N78sP2t6Qu0ICLoI6OvwdSwu5LogQ=;
        b=AJuh4PnUoort2hU2dbQafZCS79dvRYm0Fevrsp4UKOhYPw36pleIU/6ICCx8plNpuF
         y0zeuK0+lEeTilJNH3u2CpfNkTGIQcU+zIALDX09Zb25G7UJhh4fGRo74kySw4UipXfA
         xoXViIEFLDeLbtVt5E5Yxt7R46iGTl1DT9gii2RiFbCLZKFDLXyPAf8LX1tecLRXLvVu
         /O0LhtmPBEU2BCkej1MGbMedg4ImnCC1lUXYlhWeVQe/ukg2lLLc5fR9J9fPHYzTsZW+
         qg3oxhB2a0ksK1ywyiyFy8FzGYmjboqjgeRH1l93g8yfU0RQpNqQUSrWpsF2gipFH2uf
         cO0A==
X-Gm-Message-State: AD7BkJJHML47Pnfg8ioJ7lHGSbDpKsBzZmoREcClQcuh1W6TIS6AkpPPZlB1aeBRGjgqjQ==
X-Received: by 10.28.132.17 with SMTP id g17mr28425442wmd.63.1457545988218;
        Wed, 09 Mar 2016 09:53:08 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:07 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288516>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6e347e2..6342b61 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -26,6 +26,7 @@ struct apply_state {
 	int prefix_length;
 	int newfd;
 
+	int apply;
 	int allow_overlap;
 	int apply_in_reverse;
 	int apply_with_reject;
@@ -70,7 +71,7 @@ struct apply_state {
 
 static int p_value = 1;
 static int p_value_known;
-static int apply = 1;
+
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -141,10 +142,11 @@ static void parse_ignorewhitespace_option(const char *option)
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
@@ -2075,7 +2077,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 * without metadata change.  A binary patch appears
 		 * empty to us here.
 		 */
-		if ((apply || state->check) &&
+		if ((state->apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
 			die(_("patch with only garbage at line %d"), linenr);
 	}
@@ -2934,7 +2936,7 @@ static int apply_one_fragment(struct apply_state *state,
 			 * apply_data->apply_fragments->apply_one_fragment
 			 */
 			if (ws_error_action == die_on_ws_error)
-				apply = 0;
+				state->apply = 0;
 		}
 
 		if (state->apply_verbosely && applied_pos != pos) {
@@ -4474,9 +4476,9 @@ static int apply_patch(struct apply_state *state,
 		die(_("unrecognized input"));
 
 	if (whitespace_error && (ws_error_action == die_on_ws_error))
-		apply = 0;
+		state->apply = 0;
 
-	state->update_index = state->check_index && apply;
+	state->update_index = state->check_index && state->apply;
 	if (state->update_index && state->newfd < 0)
 		state->newfd = hold_locked_index(&lock_file, 1);
 
@@ -4485,12 +4487,12 @@ static int apply_patch(struct apply_state *state,
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
@@ -4657,6 +4659,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	memset(&state, 0, sizeof(state));
 	state.prefix = prefix_;
 	state.prefix_length = state.prefix ? strlen(state.prefix) : 0;
+	state.apply = 1;
 	state.newfd = -1;
 	state.line_termination = '\n';
 	state.p_context = UINT_MAX;
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
2.8.0.rc1.49.gca61272
