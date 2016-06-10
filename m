From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 40/44] apply: change error_routine when be_silent is set
Date: Fri, 10 Jun 2016 22:11:14 +0200
Message-ID: <20160610201118.13813-41-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnq-000460-P7
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbcFJUNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:13:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33760 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932658AbcFJUMq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id r5so1071597wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=571gO7SQLNiG7nITmwBsXEqT4/taESEfqQMzWLX8vVc=;
        b=r6iAqHNejPpjsfvuSC1kO0K6IOyd59qjly8yY3izaFto51AlM/3tAj0Dpgh07VSlv/
         ef9/ZY1cEM1ldpue1raQAXPx7Z4Wfuygi4oFfXolIgUPlpRDIms944yhoHyWrm104Mk4
         zItXuRK7Sk1n5CFkGKjAaHD4HEKzF1UJ9uEb2uoybTgvvP7Hni0MrY5b4ioX42Z/Ge4n
         BcWoPrDqPB1IQZKeywQZK8264Go8DDc0RY9Lo+Z2SDbQ2iAiSebkbpH87NydO5lbOuqA
         nsp0WpA0hTDGb1CiMsdd4QxLam9lHgjxEP2g/1ig9PdHzd6gEGOdBTvcRGydJbN34pt4
         Zsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=571gO7SQLNiG7nITmwBsXEqT4/taESEfqQMzWLX8vVc=;
        b=m51qtpPRSbW4VY43H5VLmpL8mTGJC247PhgLCJHROYRtXudHQRJGzRtDDQpMisLdTI
         s7tGWEh0SGVcv+bLyuDHd/Fjh66pZjL3lnXfASwRZcisnO8qFFHEssOnAOzhk29o8Mx0
         B+lg4KAt+rFMC5GZidjsbj7XRBR/scQH/s9hU/Uo+l9nFsDhOdfxPY7ur30zjBeipk0n
         ZO7Bv/jUGO86Sx1AfhHWj/14NvuzBbReAJyZfD/rfn/E+jMQuc1ts9lfkd1tXOPd1Mn8
         B7jDxDE2e0oZF+2dK+f4vZVx1zEM8m2jQLOB9uM6s1HSQ/5nZJprWs29Z2g0Hy6f6WzQ
         oypw==
X-Gm-Message-State: ALyK8tLBXjUx5WZNUDoYlXhnXLQsWlbBllDRo3QWkd6RYAxS9GAz+bnm/wAnxs3ebp91Sw==
X-Received: by 10.28.94.194 with SMTP id s185mr702080wmb.62.1465589565407;
        Fri, 10 Jun 2016 13:12:45 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:44 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297052>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 23 +++++++++++++++++++++--
 apply.h |  4 ++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 2529534..ef49709 100644
--- a/apply.c
+++ b/apply.c
@@ -109,6 +109,11 @@ void clear_apply_state(struct apply_state *state)
 	/* &state->fn_table is cleared at the end of apply_patch() */
 }
 
+static void mute_routine(const char *bla, va_list params)
+{
+	/* do nothing */
+}
+
 int check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
@@ -143,6 +148,13 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	if (!state->lock_file)
 		return error("BUG: state->lock_file should not be NULL");
 
+	if (state->be_silent) {
+		state->saved_error_routine = get_error_routine();
+		state->saved_warn_routine = get_warn_routine();
+		set_error_routine(mute_routine);
+		set_warn_routine(mute_routine);
+	}
+
 	return 0;
 }
 
@@ -4760,6 +4772,7 @@ int apply_all_patches(struct apply_state *state,
 {
 	int i;
 	int res;
+	int retval = -1;
 	int errs = 0;
 	int read_stdin = 1;
 
@@ -4838,12 +4851,18 @@ int apply_all_patches(struct apply_state *state,
 		state->newfd = -1;
 	}
 
-	return !!errs;
+	retval = !!errs;
 
 rollback_end:
 	if (state->newfd >= 0) {
 		rollback_lock_file(state->lock_file);
 		state->newfd = -1;
 	}
-	return -1;
+
+	if (state->be_silent) {
+		set_error_routine(state->saved_error_routine);
+		set_warn_routine(state->saved_warn_routine);
+	}
+
+	return retval;
 }
diff --git a/apply.h b/apply.h
index 034541a..c6cf33d 100644
--- a/apply.h
+++ b/apply.h
@@ -89,6 +89,10 @@ struct apply_state {
 	 */
 	struct string_list fn_table;
 
+	/* This is to save some reporting routines */
+	void (*saved_error_routine)(const char *err, va_list params);
+	void (*saved_warn_routine)(const char *warn, va_list params);
+
 	/* These control whitespace errors */
 	enum ws_error_action ws_error_action;
 	enum ws_ignore ws_ignore_action;
-- 
2.9.0.rc2.362.g3cd93d0
