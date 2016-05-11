From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 47/94] builtin/apply: move applying patches into apply_all_patches()
Date: Wed, 11 May 2016 15:16:58 +0200
Message-ID: <20160511131745.2914-48-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:20:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3p-0003Ol-3H
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbcEKNUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36214 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbcEKNUG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id w143so9350221wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QxwRXSZmL42WgKCBYnB1y9oOE0svVU5jjVGtnZAGm4I=;
        b=WyeiX3wMO+lTwgsSA+yS0DULn7cAFW2sG6uI/1NWTXW5eVlt/97SMa8PEVpfctozV+
         nCufz2yTW95plz1ngrtFIuDKs63sVdet1c/vUr638jJ1ex4Adl3KygK+KoQ6pmNPnze6
         FvgUBNeakCVwZLrf7D0puSG0vWlyPWOwVIpe4PG00p9L0l9HIX6pMIvN7R0vnqEAKr+F
         U9cGN7KIDXkZRCZiwqSUkb7mOGSJaS50PmSNuaE4G6lMlThRRYVFOchMXH0LV/4GxX5H
         JUQVgnZutwiZlC6JCyCg/EWdtKVeuBxn2mSz1pAv27Tq+rh2pxlqd1AtqZbjfXTAliRr
         +V/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QxwRXSZmL42WgKCBYnB1y9oOE0svVU5jjVGtnZAGm4I=;
        b=mDEkhB6BRzGb8M7jtMznoHFqxOW11ZupeuKT2kzOlpTm+cqgpVILP1cfGyKIKxUivY
         JQ7VZ81O96ZnEPWoLYAPs4n4V/MzLIFMfAXM9Qz9icjbYHf53KS57Wi/Yawv9sDZAOjY
         S43x8zDpJu8MTuIXUQRf8h+aiQHVXfZtyR7Yyhd7S4IXkEaJzT37jY1xbXyUm5u5p0/+
         f9HRynLl+38QQzwaBwGH0iQbDxTD/FZnd0D+T2e1r7WjqTqW2Kt31+98I0QLUyolx5Vd
         9Swn1IiqM+iOB5blWJ7abUB8Rxpqa4h1ciXK23UPCiDhap5vwOg2WTnxR6Ho/LE0f/6f
         AhJw==
X-Gm-Message-State: AOPr4FVS+JovHzYiohxqLLpOuZfA19fhj6FOW1Fj3oSIBq7gxt3iAw66z65NQ2W5Ch5tdg==
X-Received: by 10.28.156.195 with SMTP id f186mr4297916wme.74.1462972803958;
        Wed, 11 May 2016 06:20:03 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:02 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294277>

To libify the apply functionality we should provide a function to
apply many patches. Let's move the code to do that into a new
apply_all_patches() function.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 128 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 69 insertions(+), 59 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e5f76d8..67c64a5 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4709,13 +4709,79 @@ static void check_apply_state(struct apply_state *state, int force_apply)
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
@@ -4794,61 +4860,5 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 
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
2.8.2.490.g3dabe57
