From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 47/49] builtin/apply: move applying patches into apply_all_patches()
Date: Tue, 24 May 2016 10:11:24 +0200
Message-ID: <20160524081126.16973-48-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:13:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Sb-00015o-OC
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbcEXINA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:13:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35065 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932322AbcEXIMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id f75so3659315wmf.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wzv7A1cEdcd068vt/sbq5aQhHGj3IMP44fZ+nI/Hxi8=;
        b=Lk/75mNtqOWODg9Cw2y0PXmkghKKIpvQinmw+mqlY4l8f0QbZ+3BZsPkctFv86u85C
         yeUBEdR3DkDPafOVrupanjwcw2uHvxrGSvaoR0Etr1cEkRFvBxvTefK33sn3QyNZs5Fv
         HV5sYxdPFv55gL6cMHk4IKs0Gb0YyDz9StEoUb0NOk/gz4icvGP9sMfcThEAY2gbZ+tq
         5ASqPbhDtD0m3z0OeTjCkZHBKiEORucAE9NQFFi4kf+HtYeCLa5h8LVjEoLHFVT2fBS4
         QX1JT5CSbdTGFG+C2H7li3HRK4detTOHxZvAgMnGuPouWkfdPz5crONH0hnlEnAr/kjL
         HLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wzv7A1cEdcd068vt/sbq5aQhHGj3IMP44fZ+nI/Hxi8=;
        b=eTmAoF0lnJJbQgnYC8NnQYQ7VZjNgFGL8L+brAjreUQU12/v/25EuWc8vfoqO5KkTO
         LjhlOSWEgLNbQQlfM563Z5Gu5Bl4+9CbmosTPT33X9pOTKuHGEAQ+Tl7ZRMtrO6/VI9z
         ytI91MHO/n8D17d7mukSUJLIofURSi08vdGX3iBWv0SJR7DBXZz4peBEGXgzE5PO1Kf+
         WQ1jJAC5izUcNTRejTklQ2C1uOEoc/ONu6PSUsH9RBeRZH9zXOxq4QoFlkbv2BFrEZ2y
         SfVxkGBPNK2veHDuj7J6Tu7EtktTABy+dnzYoABLMhEQAi/1HOjVVKYJOSPUkFgmOIwB
         gW9Q==
X-Gm-Message-State: ALyK8tLIRHQQOrA5JW6g9A8HQPn4IPJ+i7eiClB9/PRcf39m53jtvxXfIZrfVmYbZFb/8Q==
X-Received: by 10.194.205.105 with SMTP id lf9mr2816515wjc.25.1464077570904;
        Tue, 24 May 2016 01:12:50 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:50 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295442>

To libify the apply functionality we should provide a function to
apply many patches. Let's move the code to do that into a new
apply_all_patches() function.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 129 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 71 insertions(+), 58 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8095026..5027f1b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4707,13 +4707,80 @@ static void check_apply_state(struct apply_state *state, int force_apply)
 		state->unsafe_paths = 0;
 }
 
-int cmd_apply(int argc, const char **argv, const char *prefix)
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
+int cmd_apply(int argc, const char **argv, const char *prefix)
+{
 	int force_apply = 0;
 	int options = 0;
-	int read_stdin = 1;
+	int ret;
 	struct apply_state state;
 
 	struct option builtin_apply_options[] = {
@@ -4792,63 +4859,9 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 
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
+	ret = apply_all_patches(&state, argc, argv, options);
 
 	clear_apply_state(&state);
 
-	return !!errs;
+	return ret;
 }
-- 
2.8.3.443.gaeee61e
