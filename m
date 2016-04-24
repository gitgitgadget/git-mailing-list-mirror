From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 47/83] builtin/apply: move applying patches into apply_all_patches()
Date: Sun, 24 Apr 2016 15:33:47 +0200
Message-ID: <1461504863-15946-48-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCh-0008CN-Qs
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbcDXNf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:58 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35077 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbcDXNfx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:53 -0400
Received: by mail-wm0-f54.google.com with SMTP id e201so60539146wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B31jPVdJo3pq4O8kaouLCSFyt3Qz/PW705HlBa/vFJw=;
        b=myvHAGc4P0ZtvUbcTBb8b8K4NfBNlniBzn3mQ52neLLo1pHNKsMEKyMmzbTn8pLOQb
         1EhaUAmlFXHunlI0bIJ2kEe0RMrpbKR12qkBfPajDt7TwTVrYFdvYBeJ3gKCZA5Y1q8d
         vHxppD1WwyfVXtnk0ckKDt/HRmll4VkHW092o2Vtf+Zg/aUdbXjRvZHuoU26zDoBjHiU
         S9cWsyAK18lHkvdBEHt6VwPn3ZZRPBcRLBO1W2QPulmZq4ryn1N4ye1Kh0Lfwpy8OAUN
         tAqCHJW+8hZL/Czt2IiAySaNKlLi2RjWCierr/rqvxjJd64UAPUc4+GTzmwHo98z/IKS
         /3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B31jPVdJo3pq4O8kaouLCSFyt3Qz/PW705HlBa/vFJw=;
        b=EZZKhGTyWOQzRy5Hk9XrF9idEutrCwXMIyqC3QsQpTYfv3K9YEnQRQ8svFDru5p3gM
         mB1FGlHjUMfKdnZegBwarXTfS7wlMFz0ypSyMjN0mu6lO25r/99a17snONK9tr78IaGu
         lv40JuDffMZJxa/mx2ziNb+CrUCCkVuP/tf4k8deZTzsKsedQCr1CSVqmJc2SVOLojld
         29wjMP+J6dJUeZ/dYqnHOen/XU4iGCy0WWZvN7Gu0nf2svEIF6PBoEy9cUYImnLJXIA4
         CSIswwlPr3dRwRJ8IfZtVIESOyLgdsMaDgon1maYgLxfJJKgdJcd+L75lbgdawbGl2rx
         FJpA==
X-Gm-Message-State: AOPr4FWj8Z9x3VNKTT49X81AwB7vmubE0aOFlEj+r/mhDq8eO2jApdYXVsheG8nse4mmbw==
X-Received: by 10.194.61.19 with SMTP id l19mr29076563wjr.4.1461504952518;
        Sun, 24 Apr 2016 06:35:52 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:51 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292346>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 128 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 69 insertions(+), 59 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 94bf120..787426f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4720,13 +4720,79 @@ static void check_apply_state(struct apply_state *state, int force_apply)
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
+		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
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
@@ -4805,61 +4871,5 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 
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
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-			die(_("Unable to write new index file"));
-	}
-
-	return !!errs;
+	return apply_all_patches(&state, argc, argv, options);
 }
-- 
2.8.1.300.g5fed0c0
