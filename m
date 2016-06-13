From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 38/40] apply: change error_routine when be_silent is set
Date: Mon, 13 Jun 2016 18:09:40 +0200
Message-ID: <20160613160942.1806-39-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSG-0004Co-CX
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424987AbcFMQLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:11:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34649 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424915AbcFMQLB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:11:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id n184so16055830wmn.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NhdhGaZacXKBrzg7t6R5K30y+AZyTzZgew+l2zWDWYk=;
        b=vTIP1YZ43Dua8TNP9Q8OVBQcz5tERBvePpOqy4ttnM5NdqcExq82yordC6yFRrtKZS
         EkxbOdu9qIOFGUYzmUWWJ4p4BFFF/ROrix+vb2Gnuic07uzBB5XuJDEMQfDZRpzRut4g
         Eagz1S+nCPwvvuwKfk8kFRdUse7KedQSP4O8nyIPpKXny5JCNVDUIWjkJHZy8YfCcV23
         YDxIBBwOFDxoq49nrA71pW/bWGYhgCpm5r3od0+H5mR230CiMJmkmhgIWrLxvm1x3/0C
         z2tgbJBsMmtXvKo9MofX1cDl5py9T/1zKFtyQgRMXSBjdpfdw+RKTnQv2L5yh/9iCxOF
         teVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NhdhGaZacXKBrzg7t6R5K30y+AZyTzZgew+l2zWDWYk=;
        b=NGgch+nIsh3ZHEhY2axc92d7X/1mg+O+9nfyyDspMeM5BUQne2QrvMbt1wa2ofmnLx
         Qbkab/RXwsXXb3O9bx6414DhAvbGYrPYrxLovxYwqobYnKRPakTzGJRSXiD8DtD9arPb
         CCV/0NWODomp3TA29FXnmBz3XP2zokouIiIJDvJnEIBj/+sO59GekqDgY1HctwiWBaI7
         RUbzoFFyjWe9uTsnqStUrtwP74czEQ1jCeTvFeEmD/bdagYWNWvwXCfsJwt271AfnwhK
         aXeUsZIg5olm7ZoxisyZGaUMTmEhtaK8JL665ZM3rpCTPJOPwzRUNlVGRusjTKZA5mIe
         gmfA==
X-Gm-Message-State: ALyK8tL6Zm93yq5XQg2eB/D8ALce8+6DPkd1QiquoJURToV5Ff2MX0OusmrSU2WfhH+KGQ==
X-Received: by 10.194.7.70 with SMTP id h6mr1905309wja.38.1465834259624;
        Mon, 13 Jun 2016 09:10:59 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:58 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297215>

To avoid printing anything when applying with be_silent set,
let's save the existing warn and error routines before
applying and replace them with a routine that does nothing.

Then after applying, let's restore the saved routines.

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
2.9.0.rc2.411.g3e2ca28
