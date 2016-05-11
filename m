From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 51/94] builtin/apply: make apply_patch() return -1 instead of die()ing
Date: Wed, 11 May 2016 15:17:02 +0200
Message-ID: <20160511131745.2914-52-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:23:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U6l-0006wl-Sc
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbcEKNXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:23:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36301 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932262AbcEKNUN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id w143so9350976wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rbpi9lC8uUJK3AmJT+hBGdlK9t+QmdM/luyUTX7HYnE=;
        b=a7PWyTko/MOet4zSlzZqf9ALiqxMczafMZVxJhm0sS4H22y9ur6tpbqMXFakmLDLKz
         JE9TXTFFJMxk1/I9dkCq0SlyqNfq3yyX4oCfsVob+5zYJ9MV92alYHPxDvylRr/VFmwd
         xpWn0O+nkjwqtSDENVbP6VARoPvnxDb429ZlB5gwMe0br2GCcmV5VFqWmmv/7foI9kIW
         NDY8yX7a3ttYyZmDZ6m7/y3CbnuzvpBAZbdyQ3EHolywAZpTm5wq01f7tEPUy8VnDk5O
         1n/NMMNt+wUECHNSfbz+7tGK73giHwpWMQ60J1zv2E8Wp87+0w1GgW/0/7xA4C6H1pXo
         EiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rbpi9lC8uUJK3AmJT+hBGdlK9t+QmdM/luyUTX7HYnE=;
        b=Lx/xWqR24GEq+WG724wyPksBe9d4bcK/nrFlL4Ki0e2I3ONZNWopcRyigWStv2gDaV
         yFbCZNymOIAL8Ac21Ys/fyD0Mq28RSbqpNIJBjTLKpVRbTFkgPa5uJ0P033kTSs5kjkj
         RzlZfZb+DVXZToJj87X2X4eWLZ+vAIPZ9+tg32wgiphku3oYgG5SmhFB9pxDa4CvbTXi
         gec+EvhuBbMVplcWbZRHZUatx0I6KU8GaC7oLEYIx2+mxRRY5HDIC/KEWk8kCUPl4FPG
         UM5YxVZlUhLHZ6UveKCq9T8/Nc+c0if4QVobNYL8mQ/LoQJ4LWhSqdK9V729qm4u0CEu
         VauA==
X-Gm-Message-State: AOPr4FUmySh//En4gaQK8nm8sgHE8M4XRMZbdxdnNi3T0IvRpArawRgkVANWpSqkq6LIgw==
X-Received: by 10.28.29.195 with SMTP id d186mr4615181wmd.27.1462972811581;
        Wed, 11 May 2016 06:20:11 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:10 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294323>

To libify `git apply` functionality we have to signal errors
to the caller instead of die()ing.

As a first step in this direction, let's make apply_patch() return
-1 in case of errors instead of dying. For now its only caller
apply_all_patches() will exit(1) when apply_patch() return -1.

In a later patch, apply_all_patches() will return -1 too instead of
exiting.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 54 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ec55768..d95630c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4512,6 +4512,14 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 #define INACCURATE_EOF	(1<<0)
 #define RECOUNT		(1<<1)
 
+/*
+ * Try to apply a patch.
+ *
+ * Returns:
+ *  -1 if an error happened
+ *   0 if the patch applied
+ *   1 if the patch did not apply
+ */
 static int apply_patch(struct apply_state *state,
 		       int fd,
 		       const char *filename,
@@ -4521,6 +4529,7 @@ static int apply_patch(struct apply_state *state,
 	struct strbuf buf = STRBUF_INIT; /* owns the patch text */
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
+	int res = 0;
 
 	state->patch_input_file = filename;
 	read_patch_file(&buf, fd);
@@ -4553,8 +4562,10 @@ static int apply_patch(struct apply_state *state,
 		offset += nr;
 	}
 
-	if (!list && !skipped_patch)
-		die(_("unrecognized input"));
+	if (!list && !skipped_patch) {
+		res = error(_("unrecognized input"));
+		goto end;
+	}
 
 	if (state->whitespace_error && (state->ws_error_action == die_on_ws_error))
 		state->apply = 0;
@@ -4563,21 +4574,22 @@ static int apply_patch(struct apply_state *state,
 	if (state->update_index && state->newfd < 0)
 		state->newfd = hold_locked_index(state->lock_file, 1);
 
-	if (state->check_index) {
-		if (read_cache() < 0)
-			die(_("unable to read index file"));
+	if (state->check_index && read_cache() < 0) {
+		res = error(_("unable to read index file"));
+		goto end;
 	}
 
 	if ((state->check || state->apply) &&
 	    check_patch_list(state, list) < 0 &&
-	    !state->apply_with_reject)
-		exit(1);
+	    !state->apply_with_reject) {
+		res = -1;
+		goto end;
+	}
 
 	if (state->apply && write_out_results(state, list)) {
-		if (state->apply_with_reject)
-			exit(1);
 		/* with --3way, we still need to write the index out */
-		return 1;
+		res = state->apply_with_reject ? -1 : 1;
+		goto end;
 	}
 
 	if (state->fake_ancestor)
@@ -4592,10 +4604,11 @@ static int apply_patch(struct apply_state *state,
 	if (state->summary)
 		summary_patch_list(list);
 
+end:
 	free_patch_list(list);
 	strbuf_release(&buf);
 	string_list_clear(&state->fn_table, 0);
-	return 0;
+	return res;
 }
 
 static void git_apply_config(void)
@@ -4722,6 +4735,7 @@ static int apply_all_patches(struct apply_state *state,
 			     int options)
 {
 	int i;
+	int res;
 	int errs = 0;
 	int read_stdin = 1;
 
@@ -4730,7 +4744,10 @@ static int apply_all_patches(struct apply_state *state,
 		int fd;
 
 		if (!strcmp(arg, "-")) {
-			errs |= apply_patch(state, 0, "<stdin>", options);
+			res = apply_patch(state, 0, "<stdin>", options);
+			if (res < 0)
+				exit(1);
+			errs |= res;
 			read_stdin = 0;
 			continue;
 		} else if (0 < state->prefix_length)
@@ -4743,12 +4760,19 @@ static int apply_all_patches(struct apply_state *state,
 			die_errno(_("can't open patch '%s'"), arg);
 		read_stdin = 0;
 		set_default_whitespace_mode(state);
-		errs |= apply_patch(state, fd, arg, options);
+		res = apply_patch(state, fd, arg, options);
+		if (res < 0)
+			exit(1);
+		errs |= res;
 		close(fd);
 	}
 	set_default_whitespace_mode(state);
-	if (read_stdin)
-		errs |= apply_patch(state, 0, "<stdin>", options);
+	if (read_stdin) {
+		res = apply_patch(state, 0, "<stdin>", options);
+		if (res < 0)
+			exit(1);
+		errs |= res;
+	}
 
 	if (state->whitespace_error) {
 		if (state->squelch_whitespace_errors &&
-- 
2.8.2.490.g3dabe57
