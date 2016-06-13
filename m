From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 02/40] builtin/apply: make apply_patch() return -1 instead of die()ing
Date: Mon, 13 Jun 2016 18:09:04 +0200
Message-ID: <20160613160942.1806-3-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:12:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUTG-00056B-WA
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425013AbcFMQMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:12:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34046 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424778AbcFMQKG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id n184so16049750wmn.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pjRo7Fp/kvJqFjzaSAN6NGxZ8snJw/9j1iKD3M6ZnX0=;
        b=uhZ6dYxTJBGl2P2FCT+KOUPL/QCp6aqgsXm4xsRaxx2mN7EzjCAdCZePBOpeUzIyZ7
         Dob69i8cqpfAdSpQn0atNewZVyIkRgoIvkxecdhiVXWwGz1H4gi0KsaB9TpklDDnZtBI
         7yw6zVvAXzNk0EyjMRicYnCeCPQFykrO/SuSXAhlHPLxk4yD8bAR5spbbDoGFjtq5WgQ
         V2V1+APPW6IF+OKPwchE+/PHd+oIh0jQmYuHllKaINegiMKLsp/muMhrFDBQULioQPgi
         FXjRQETZrG+kuCZKmX6gUKBbaLH3vvs06zhXW3wEoamOg5OvYv+bYrkk5kfPy0fGhQu0
         YVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pjRo7Fp/kvJqFjzaSAN6NGxZ8snJw/9j1iKD3M6ZnX0=;
        b=koL9hbqHxiYJ7kyhNckbv6Pl2V+OhNWG4gybQpZuZDZmBY0lBaUYVTOyHVqC+5q1ep
         8Qed9QdxS9ljk7kYGgIktMgncngm+Vonld7ox9UXThZJdQRteybTHf6DtRgNrm79Q4uW
         atrrhCcbZC0a6mgYnMxSdAnwAxlCJLzFGkYzsXlJZE2g32K6cjgBetkuS6mXvy0pWm+U
         TPg5cwo0YhJa2BaheF711CtKaa4Zvg27ky3i1ien7ZZ/FHz9w35jIdPZOArJdeMx1Spx
         GhHbP0MNmY0lrRzm+Iy0wvuQqi2U25QwPoKfJaPeAf1qMFs26ohvUnNdvx2CxHTVer5p
         VxAQ==
X-Gm-Message-State: ALyK8tLKjE+ShEN/5C6ShCwYTkBIZK+uB7Civzplc8gjCdAWLYhgwS7jLrv8u8Zdl9eIlQ==
X-Received: by 10.194.179.199 with SMTP id di7mr1940118wjc.26.1465834199869;
        Mon, 13 Jun 2016 09:09:59 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:09:59 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297232>

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
index 3a0c53a..598e479 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4404,6 +4404,14 @@ static struct lock_file lock_file;
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
@@ -4413,6 +4421,7 @@ static int apply_patch(struct apply_state *state,
 	struct strbuf buf = STRBUF_INIT; /* owns the patch text */
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
+	int res = 0;
 
 	state->patch_input_file = filename;
 	read_patch_file(&buf, fd);
@@ -4445,8 +4454,10 @@ static int apply_patch(struct apply_state *state,
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
@@ -4455,21 +4466,22 @@ static int apply_patch(struct apply_state *state,
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
@@ -4484,10 +4496,11 @@ static int apply_patch(struct apply_state *state,
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
@@ -4625,6 +4638,7 @@ static int apply_all_patches(struct apply_state *state,
 			     int options)
 {
 	int i;
+	int res;
 	int errs = 0;
 	int read_stdin = 1;
 
@@ -4633,7 +4647,10 @@ static int apply_all_patches(struct apply_state *state,
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
@@ -4646,12 +4663,19 @@ static int apply_all_patches(struct apply_state *state,
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
2.9.0.rc2.411.g3e2ca28
