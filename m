From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 28/49] builtin/apply: move 'apply' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:05 +0200
Message-ID: <20160524081126.16973-29-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:14:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57UM-0001gE-7m
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbcEXIOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:14:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34790 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667AbcEXIM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so3660418wmn.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nPnoALvEwv76IAkfGb5oj1T+TxNUGcZOcFVRxscLTP8=;
        b=eF5DLlvrSdEgxF7uDvgSO56USix+nWws5qtEHZzp0maz0RrAFrYC8luFRfkYrqLRu3
         5xeb7vI47Wv08RuZerPzMnqmox4PS4q1h3OgcNzzwLw0TB82f5y72t81kAvLchdVDsK3
         Lem4oBzjn/liVmZoNq6qw5qK309m/20BiLMl3dDDzaD/4Bh3rcMhmDhRGqIRBiohV5Fh
         XdC2GrulaX2W5hfgJe3OUD5nIjVZ22SJtaPPmtYER31y0aw5W2AGDVC4BrM2bfehCFQJ
         G31fDJOgV+I/brnqI5Z8M9oOngET+lV4muk0m3PXUEZqQmqPnoBVB0rYt34qILGP4kna
         RycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nPnoALvEwv76IAkfGb5oj1T+TxNUGcZOcFVRxscLTP8=;
        b=IAaZrLZiLN2gyI1yND37NB0Ys8S+gaXZ5w680DGOiejEbLenYcKLx6ppqr1VvE3y67
         7GL2bTRgt5vfDliSLPimLuDFTsP0oI3QHM0AHiY5Ms/1ak8A2kUM1lfnFfuaM4SjOTsQ
         ooq0dow2oSeM4QKdGwAUsrPbPNak59WzuP2S6qjXiQb9gZ1uPItAw/BJhH6Ybm2ehS56
         J5bxt/SL49DS6Q+62qC962uRj2v6l3weNM3o7ISK6tSfZDhNgzKbbJ/psOddTppxnhH4
         vZlAbiknPhUSQe1zIPVKoiPDt50+D9b9paIg7zQd22Oi8dwumY8OK8ry3SRTb0Iet7A4
         0NZA==
X-Gm-Message-State: ALyK8tKg6bLzrl6VcRSj0FeNo/5zlWgpp5VqcMimjksO7AM8nXyZQFkz4vFUMBIkA62kSw==
X-Received: by 10.194.95.104 with SMTP id dj8mr2769265wjb.138.1464077544033;
        Tue, 24 May 2016 01:12:24 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:23 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295460>

To libify the apply functionality the 'apply' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 3c9f052..c0c18ce 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -26,6 +26,7 @@ struct apply_state {
 	int prefix_length;
 
 	/* These control what gets looked at and modified */
+	int apply; /* this is not a dry-run */
 	int cached; /* apply to the index only */
 	int check; /* preimage must match working tree, don't actually apply */
 	int check_index; /* preimage must match the indexed version */
@@ -56,7 +57,7 @@ static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int apply = 1;
+
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -126,10 +127,11 @@ static void parse_ignorewhitespace_option(const char *option)
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
@@ -2058,7 +2060,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 * without metadata change.  A binary patch appears
 		 * empty to us here.
 		 */
-		if ((apply || state->check) &&
+		if ((state->apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
 			die(_("patch with only garbage at line %d"), state_linenr);
 	}
@@ -2916,7 +2918,7 @@ static int apply_one_fragment(struct apply_state *state,
 			 * apply_data->apply_fragments->apply_one_fragment
 			 */
 			if (ws_error_action == die_on_ws_error)
-				apply = 0;
+				state->apply = 0;
 		}
 
 		if (state->apply_verbosely && applied_pos != pos) {
@@ -4460,9 +4462,9 @@ static int apply_patch(struct apply_state *state,
 		die(_("unrecognized input"));
 
 	if (whitespace_error && (ws_error_action == die_on_ws_error))
-		apply = 0;
+		state->apply = 0;
 
-	state->update_index = state->check_index && apply;
+	state->update_index = state->check_index && state->apply;
 	if (state->update_index && newfd < 0)
 		newfd = hold_locked_index(&lock_file, 1);
 
@@ -4471,12 +4473,12 @@ static int apply_patch(struct apply_state *state,
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
@@ -4565,6 +4567,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
 	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
+	state->apply = 1;
 	state->line_termination = '\n';
 	state->p_context = UINT_MAX;
 
@@ -4676,9 +4679,9 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
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
@@ -4706,11 +4709,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
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
@@ -4728,7 +4731,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			       "%d lines add whitespace errors.",
 			       whitespace_error),
 			    whitespace_error);
-		if (applied_after_fixing_ws && apply)
+		if (applied_after_fixing_ws && state.apply)
 			warning("%d line%s applied after"
 				" fixing whitespace errors.",
 				applied_after_fixing_ws,
-- 
2.8.3.443.gaeee61e
