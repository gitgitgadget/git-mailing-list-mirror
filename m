From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 51/83] builtin/apply: make apply_patch() return -1 instead of die()ing
Date: Sun, 24 Apr 2016 15:33:51 +0200
Message-ID: <1461504863-15946-52-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCi-0008CN-CL
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbcDXNgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:00 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38528 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbcDXNf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:59 -0400
Received: by mail-wm0-f45.google.com with SMTP id u206so89944071wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gDiNAjYVclG84JfbX+OMeicNtFc+KD2eVsQ1aWfga08=;
        b=wtEIaeiZLJh+AeUrmA1PZdsJ3KpQB9ApVYyV2LAN2W8yIR84nYljFeTlaE5oReLNJF
         sj/vWGCiikdJBbftLK8SJAnmhB43kyiWnz3B+qobxqGU9LyC635Kg07p/i3PoXqlQI2m
         dLaXJ2BojRV/eAWitRwFYVmpg4AnXZr4aPR3gD+4AVwS0e1Qz+rdGlaSBocZrJ6jFqaF
         RiS4eSlalpuhyvoDSZrcozFuBmtxfqnlumka3NnHAPH8apBvHG5hN2flx466GOFHfQms
         r8o6tLrEtS4A1zFBY4zlPOAvdctHROOsWpvj1Utg6+Bo2gVpM890MPX9HLsxzCEoRqLc
         2Qog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gDiNAjYVclG84JfbX+OMeicNtFc+KD2eVsQ1aWfga08=;
        b=LjdSzoeOxFthLnRLaG/0pwlijFxk3meZ/Ua93jFExHcd54OXe5YMrZWjozLnTg1+mk
         vQL64yTnwf7vwn2C0CdHoNVuc8a6X3J6tCqE9HBD4BgTRu4Qihu2ATSAgvno2hiSSv4w
         Z1+QZqKZFcufljLmdkjQCs3a4AvSM6AFDXJ/B6B90y2GWDDzvaWenxBAEyM826BPY9mM
         uhi+56laW9qG6ufo55u/BgcTgaUU70XdVsN9okxbeqXkpiVfG7+FzObOOFiGNSavzTB0
         WJFa8/Vs6FHqLMGLC9f6dojER2DHS9u7D39WFWAsJUJgNH8xIiGmyQ5pFy8vvzEu6t1j
         5Gmg==
X-Gm-Message-State: AOPr4FXMCX+MzCVwAz8LfubuonkG73G63RLx/AXQwm+zOuo7mXZU0uDwKKCnVoqXt2HIyQ==
X-Received: by 10.194.163.229 with SMTP id yl5mr26308018wjb.6.1461504957740;
        Sun, 24 Apr 2016 06:35:57 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:56 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292344>

To libify `git apply` functionality we have to signal errors
to the caller instead of die()ing.

As a first step in this direction, let's make apply_patch() return
-1 in case of errors instead of dying. For now its only caller
apply_all_patches() will exit(1) when apply_patch() return -1.

In a later patch, apply_all_patches() will return -1 too instead of
exiting.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 84ff2da..bc209f5 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4522,6 +4522,14 @@ static int write_out_results(struct apply_state *state, struct patch *list)
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
@@ -4564,7 +4572,7 @@ static int apply_patch(struct apply_state *state,
 	}
 
 	if (!list && !skipped_patch)
-		die(_("unrecognized input"));
+		return error(_("unrecognized input"));
 
 	if (state->whitespace_error && (state->ws_error_action == die_on_ws_error))
 		state->apply = 0;
@@ -4575,19 +4583,17 @@ static int apply_patch(struct apply_state *state,
 		hold_locked_index(state->lock_file, 1);
 	}
 
-	if (state->check_index) {
-		if (read_cache() < 0)
-			die(_("unable to read index file"));
-	}
+	if (state->check_index && read_cache() < 0)
+		return error(_("unable to read index file"));
 
 	if ((state->check || state->apply) &&
 	    check_patch_list(state, list) < 0 &&
 	    !state->apply_with_reject)
-		exit(1);
+		return -1;
 
 	if (state->apply && write_out_results(state, list)) {
 		if (state->apply_with_reject)
-			exit(1);
+			return -1;
 		/* with --3way, we still need to write the index out */
 		return 1;
 	}
@@ -4730,6 +4736,7 @@ static int apply_all_patches(struct apply_state *state,
 			     int options)
 {
 	int i;
+	int res;
 	int errs = 0;
 	int read_stdin = 1;
 
@@ -4738,7 +4745,10 @@ static int apply_all_patches(struct apply_state *state,
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
@@ -4751,12 +4761,19 @@ static int apply_all_patches(struct apply_state *state,
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
2.8.1.300.g5fed0c0
