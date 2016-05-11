From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 91/94] apply: change error_routine when be_silent is set
Date: Wed, 11 May 2016 15:17:42 +0200
Message-ID: <20160511131745.2914-92-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:21:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U5C-00056i-Iv
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbcEKNVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36233 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932402AbcEKNVg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id w143so9358756wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zS8A6ngWPolpBP9R6apFCEJ0lHnDC3kaLaCCCDZ7tsM=;
        b=pMnRrW8Gy5OWKBt2DAEN91/JO0ANuTaJmGyGPc7cF9tdkR/uUwNqXhyHwQlAMzblto
         uscTqNhw04Gr7FVz8JVEwAbwd1ofQmcrH7PMTKxwkmjTjHCuyHFpti0LdEL9qcEGn3AP
         j7OjMJGbcI9cqhur5JvPFmsmSVwszqaog7JlP6zVGA65IWCIqEKgvOOWeaCKhvf7vsWE
         WB5Nnu9UG1CVNn1WpD7ksP02vSXBzUZo1sFfDvnyfcRNNbNTgC0hid01cGQbeHyD+jBd
         T0MXlV3XqQFGSdalqbZK9kaxihM/PhrGlNHQ+qNiNkPg+dV8z1H4U0n1VtUmH3uV7wUs
         GOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zS8A6ngWPolpBP9R6apFCEJ0lHnDC3kaLaCCCDZ7tsM=;
        b=ORyz7Eea/kUGpCG5F653QhRmbWCh7AHpYGgwW+mFsNsSyYGXybIVbuCn8sDbnE93pK
         xFzwBX9rzVGRiUqxunmIBeXkfkMP3cHVTra9K8/ZPUaOFjXytIARYnXHvYPE3DSR0lG+
         6Xx14eIBNa2fKiIcHDqRSIKdlV1iA6FHkmLl3cWrIsLK3OR3mE7Pp/Gm5XPuRrY8PtGB
         6HSwSdyPygqiwqSYN3BHz+wM+2R+K8W4A4klqMpoyHKTu5uMQTeXCEA7dxirZ4PNrdou
         iROTJ57ESVzyc0nUdQs4eBPfSlAXVTKFGDUEzRGzYT/VS2v84FSdHrWVbUGkwuksgVVz
         sEBA==
X-Gm-Message-State: AOPr4FVutykEZ5vQzSSBZCFsNMaTa0UFA2//tq2yM/yf/yONG+mkDNG5wewX8l2W9L/5gg==
X-Received: by 10.28.145.73 with SMTP id t70mr19359wmd.97.1462972895615;
        Wed, 11 May 2016 06:21:35 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:34 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294303>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 29 +++++++++++++++++++++++++----
 apply.h |  3 +++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index e0fdd1d..1dafc82 100644
--- a/apply.c
+++ b/apply.c
@@ -100,6 +100,11 @@ int init_apply_state(struct apply_state *state,
 	return 0;
 }
 
+static void mute_routine(const char *bla, va_list params)
+{
+	/* do nothing */
+}
+
 int check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
@@ -132,6 +137,13 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	if (state->be_silent && state->apply_verbosely)
 		return error(_("incompatible internal 'be_silent' and 'apply_verbosely' flags"));
 
+	if (state->be_silent) {
+		state->saved_error_routine = get_error_routine();
+		state->saved_warn_routine = get_warn_routine();
+		set_error_routine(mute_routine);
+		set_warn_routine(mute_routine);
+	}
+
 	return 0;
 }
 
@@ -4750,6 +4762,7 @@ int apply_all_patches(struct apply_state *state,
 {
 	int i;
 	int res;
+	int retval = -1;
 	int errs = 0;
 	int read_stdin = 1;
 
@@ -4822,17 +4835,25 @@ int apply_all_patches(struct apply_state *state,
 	if (state->update_index) {
 		res = write_locked_index(&the_index, state->lock_file, COMMIT_LOCK);
 		state->newfd = -1;
-		if (res)
-			return error(_("Unable to write new index file"));
+		if (res) {
+			error(_("Unable to write new index file"));
+			goto rollback_end;
+		}
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
index 2dd3706..029b79f 100644
--- a/apply.h
+++ b/apply.h
@@ -46,6 +46,9 @@ struct apply_state {
 	int apply_verbosely;
 	int be_silent;
 
+	void (*saved_error_routine)(const char *err, va_list params);
+	void (*saved_warn_routine)(const char *warn, va_list params);
+
 	/* --cached updates only the cache without ever touching the working tree. */
 	int cached;
 
-- 
2.8.2.490.g3dabe57
