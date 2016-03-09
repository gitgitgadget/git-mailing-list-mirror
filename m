From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 48/48] builtin/apply: move applying patches into apply_all_patches()
Date: Wed,  9 Mar 2016 18:49:16 +0100
Message-ID: <1457545756-20616-49-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiJj-0000gp-02
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933794AbcCIRyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:54:32 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36374 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933784AbcCIRyM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:54:12 -0500
Received: by mail-wm0-f52.google.com with SMTP id n186so190646906wmn.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=na4LVs7Az/ZA2JZo/fN1s/1iIemQYadfG8NAT53eYZM=;
        b=PDjYCIYGU4XDuQm5ZUlaep3jCFrEgOsmFuu9hRhP1cVvHbnI/eC7GA/CjyIoi4L/yN
         hgjCHi+Zmoyj+qQ3P5WepO0uDihL3e97yXzmkwyv7abHroM95AZ4W3ozDlsI1eh9k8Aj
         DKgHamlalTWeBW++2zeFWWEHTT3hvciBcdLiU929UmX1eUhDu0IqyLIMZMJMI/sKncih
         n4lnswGhRD7kFR3rEhXnLBYVQeUUZOsZcHiWgA6fRFLW2vPRrjfD7PRM1uUnmdDERygk
         EikwY3lUdN4ygf6gPizNAfSGnk8cHHmZslO7yfRDIRXOgej0Dp65/0xoEUGMzU7d6L3b
         m5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=na4LVs7Az/ZA2JZo/fN1s/1iIemQYadfG8NAT53eYZM=;
        b=Go74xG63YONg86Y7ryvSR/ZleDNBIdQMfjgqwrtbwYCD0RSpi7WPh75lHzj3Mm29ks
         BT0B6TcHE5eCYo7n7vFo1F7txNa7TMFR8RIUImMlXAPV1yVwDW9mlXD9bpUpq/300HcN
         MOczrwJ6loKyydybGkwRMgCoJst2IWWzanaD1NE/TbG1K8lP6WFXduAXtGLWEm6Ogct9
         wMx8JVeiyEz3Dx79RqydUw6rkOsrkVD9bE3Vwxr/VT6eSJooMdIFM+k1U02dr0jZzB5U
         jdpAGGQDcw1IFQg4MIn+O/2XkPhOc0WgLrw59dXxcxp0Bs+b1aKEOxcSMWyqX5EOyKZk
         MpaA==
X-Gm-Message-State: AD7BkJI8/1+8NGLVuf0Wnh6RSslwShEuF5zxITfpAx7BYolCWvnXRsW0xwP7gc/nElPiDw==
X-Received: by 10.194.60.20 with SMTP id d20mr40312204wjr.109.1457546051419;
        Wed, 09 Mar 2016 09:54:11 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:54:10 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288537>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 128 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 69 insertions(+), 59 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 3f76469..9611b1a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4718,13 +4718,79 @@ static void check_apply_state(struct apply_state *state, int force_apply)
 		state->unsafe_paths = 0;
 }
 
-int cmd_apply(int argc, const char **argv, const char *prefix_)
+static int apply_all_patches(struct apply_state *state,
+			     int argc,
+			     const char **argv,
+			     int options)
 {
 	int i;
 	int errs = 0;
+	int read_stdin = 1;
+
+	for (i = 0; i < argc; i++) {
+		const char *arg = argv[i];
+		int fd;
+
+		if (!strcmp(arg, "-")) {
+			errs |= apply_patch(state, 0, "<stdin>", options);
+			read_stdin = 0;
+			continue;
+		} else if (0 < state->prefix_length)
+			arg = prefix_filename(state->prefix,
+					      state->prefix_length,
+					      arg);
+
+		fd = open(arg, O_RDONLY);
+		if (fd < 0)
+			die_errno(_("can't open patch '%s'"), arg);
+		read_stdin = 0;
+		set_default_whitespace_mode(state);
+		errs |= apply_patch(state, fd, arg, options);
+		close(fd);
+	}
+	set_default_whitespace_mode(state);
+	if (read_stdin)
+		errs |= apply_patch(state, 0, "<stdin>", options);
+
+	if (state->whitespace_error) {
+		if (state->squelch_whitespace_errors &&
+		    state->squelch_whitespace_errors < state->whitespace_error) {
+			int squelched =
+				state->whitespace_error - state->squelch_whitespace_errors;
+			warning(Q_("squelched %d whitespace error",
+				   "squelched %d whitespace errors",
+				   squelched),
+				squelched);
+		}
+		if (state->ws_error_action == die_on_ws_error)
+			die(Q_("%d line adds whitespace errors.",
+			       "%d lines add whitespace errors.",
+			       state->whitespace_error),
+			    state->whitespace_error);
+		if (state->applied_after_fixing_ws && state->apply)
+			warning("%d line%s applied after"
+				" fixing whitespace errors.",
+				state->applied_after_fixing_ws,
+				state->applied_after_fixing_ws == 1 ? "" : "s");
+		else if (state->whitespace_error)
+			warning(Q_("%d line adds whitespace errors.",
+				   "%d lines add whitespace errors.",
+				   state->whitespace_error),
+				state->whitespace_error);
+	}
+
+	if (state->update_index) {
+		if (write_locked_index(&the_index, &state->lock_file, COMMIT_LOCK))
+			die(_("Unable to write new index file"));
+	}
+
+	return !!errs;
+}
+
+int cmd_apply(int argc, const char **argv, const char *prefix_)
+{
 	int force_apply = 0;
 	int options = 0;
-	int read_stdin = 1;
 	struct apply_state state;
 
 	struct option builtin_apply_options[] = {
@@ -4803,61 +4869,5 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 
 	check_apply_state(&state, force_apply);
 
-	for (i = 0; i < argc; i++) {
-		const char *arg = argv[i];
-		int fd;
-
-		if (!strcmp(arg, "-")) {
-			errs |= apply_patch(&state, 0, "<stdin>", options);
-			read_stdin = 0;
-			continue;
-		} else if (0 < state.prefix_length)
-			arg = prefix_filename(state.prefix,
-					      state.prefix_length,
-					      arg);
-
-		fd = open(arg, O_RDONLY);
-		if (fd < 0)
-			die_errno(_("can't open patch '%s'"), arg);
-		read_stdin = 0;
-		set_default_whitespace_mode(&state);
-		errs |= apply_patch(&state, fd, arg, options);
-		close(fd);
-	}
-	set_default_whitespace_mode(&state);
-	if (read_stdin)
-		errs |= apply_patch(&state, 0, "<stdin>", options);
-	if (state.whitespace_error) {
-		if (state.squelch_whitespace_errors &&
-		    state.squelch_whitespace_errors < state.whitespace_error) {
-			int squelched =
-				state.whitespace_error - state.squelch_whitespace_errors;
-			warning(Q_("squelched %d whitespace error",
-				   "squelched %d whitespace errors",
-				   squelched),
-				squelched);
-		}
-		if (state.ws_error_action == die_on_ws_error)
-			die(Q_("%d line adds whitespace errors.",
-			       "%d lines add whitespace errors.",
-			       state.whitespace_error),
-			    state.whitespace_error);
-		if (state.applied_after_fixing_ws && state.apply)
-			warning("%d line%s applied after"
-				" fixing whitespace errors.",
-				state.applied_after_fixing_ws,
-				state.applied_after_fixing_ws == 1 ? "" : "s");
-		else if (state.whitespace_error)
-			warning(Q_("%d line adds whitespace errors.",
-				   "%d lines add whitespace errors.",
-				   state.whitespace_error),
-				state.whitespace_error);
-	}
-
-	if (state.update_index) {
-		if (write_locked_index(&the_index, &state.lock_file, COMMIT_LOCK))
-			die(_("Unable to write new index file"));
-	}
-
-	return !!errs;
+	return apply_all_patches(&state, argc, argv, options);
 }
-- 
2.8.0.rc1.49.gca61272
