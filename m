From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 44/83] builtin/apply: move 'symlink_changes' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:44 +0200
Message-ID: <1461504863-15946-45-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:37:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKEX-0000kl-FA
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139AbcDXNhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:37:51 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35064 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbcDXNfu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:50 -0400
Received: by mail-wm0-f44.google.com with SMTP id e201so60538252wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sKaZk7NHVSG5t58gT4oJZL7TGgniqUUr1o/ymFSbD70=;
        b=OpSTyoS9jhto77jwhVjBTYSthmuBvdLA/0nM/tGpguG6VtGyXwfW1za3dFYcVlE9Gg
         BWFle6ptuQPhLg/zOdOOtXQ07tC3IXQmKH0V2xq8PmBj1iKCSQGQiN9V6Zuai50bN9nK
         fohLqtyRsmvUBZT1DC+l/FZAZq1Bo/zdoWzT0k+r8ONhMX+1kfyvuniGdlsFjLnTMFHG
         fO7RAKKSU1m78n453sW/0sVTmB4ZQoJYMM1CU8IVD1MzTyEVyl0r5LdtygPP/Rcc0ce0
         Di0eR/xT6AOx+WkgzzPPmp/Hvq2/55FDHomK+IQgZoEqBQuHViG1TkIfui0Ij6sFf90j
         FcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sKaZk7NHVSG5t58gT4oJZL7TGgniqUUr1o/ymFSbD70=;
        b=HpUV9OH0EGZhDMn7+XoSN60+fsqM8MxwzWuZ4Xs3v8b0SLA8/gG868HFFVXhupmcWY
         Q+AGgevx+xlUqmqPyKQllrxxXYyUGnSzCUUdP/YcV+Y6dS8dmebtscM7IjwdEanrV5vZ
         EHqkkk7TVQsYQOGpOulKNoUKCTula+L9d6Nmf699x5PvJ50XFm5TojPryKQSun8wSan1
         0BFrwZQLn3cvWm6Uqn7GSs0QdWpknNQS71ShFsFFx+pCT+Q8VdkvDsvEHmzhCWy8kFIL
         mcPFIT8QMX/6WM34ALyYYpPz/uAZmnZ2dx4Kv91dBsWJwrMHFdRiOhCUIUgMl8+uauYG
         Zlew==
X-Gm-Message-State: AOPr4FWFLCjF0/eqXrktX7B4vaqIDw5xAaohpURZT7Rt40SarJGSN13nXo7Iklj20WT3LA==
X-Received: by 10.194.125.201 with SMTP id ms9mr29386775wjb.71.1461504948804;
        Sun, 24 Apr 2016 06:35:48 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:47 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292380>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 50 ++++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b4c2bd8..8508607 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -34,6 +34,20 @@ enum ws_ignore {
 	ignore_ws_change
 };
 
+/*
+ * We need to keep track of how symlinks in the preimage are
+ * manipulated by the patches.  A patch to add a/b/c where a/b
+ * is a symlink should not be allowed to affect the directory
+ * the symlink points at, but if the same patch removes a/b,
+ * it is perfectly fine, as the patch removes a/b to make room
+ * to create a directory a/b so that a/b/c can be created.
+ *
+ * See also "struct string_list symlink_changes" in "struct
+ * apply_state".
+ */
+#define SYMLINK_GOES_AWAY 01
+#define SYMLINK_IN_RESULT 02
+
 struct apply_state {
 	const char *prefix;
 	int prefix_length;
@@ -99,6 +113,8 @@ struct apply_state {
 	 */
 	struct string_list fn_table;
 
+	struct string_list symlink_changes;
+
 	int p_value;
 	int p_value_known;
 	unsigned int p_context;
@@ -3723,52 +3739,42 @@ static int check_to_create(struct apply_state *state,
 	return 0;
 }
 
-/*
- * We need to keep track of how symlinks in the preimage are
- * manipulated by the patches.  A patch to add a/b/c where a/b
- * is a symlink should not be allowed to affect the directory
- * the symlink points at, but if the same patch removes a/b,
- * it is perfectly fine, as the patch removes a/b to make room
- * to create a directory a/b so that a/b/c can be created.
- */
-static struct string_list symlink_changes;
-#define SYMLINK_GOES_AWAY 01
-#define SYMLINK_IN_RESULT 02
-
-static uintptr_t register_symlink_changes(const char *path, uintptr_t what)
+static uintptr_t register_symlink_changes(struct apply_state *state,
+					  const char *path,
+					  uintptr_t what)
 {
 	struct string_list_item *ent;
 
-	ent = string_list_lookup(&symlink_changes, path);
+	ent = string_list_lookup(&state->symlink_changes, path);
 	if (!ent) {
-		ent = string_list_insert(&symlink_changes, path);
+		ent = string_list_insert(&state->symlink_changes, path);
 		ent->util = (void *)0;
 	}
 	ent->util = (void *)(what | ((uintptr_t)ent->util));
 	return (uintptr_t)ent->util;
 }
 
-static uintptr_t check_symlink_changes(const char *path)
+static uintptr_t check_symlink_changes(struct apply_state *state, const char *path)
 {
 	struct string_list_item *ent;
 
-	ent = string_list_lookup(&symlink_changes, path);
+	ent = string_list_lookup(&state->symlink_changes, path);
 	if (!ent)
 		return 0;
 	return (uintptr_t)ent->util;
 }
 
-static void prepare_symlink_changes(struct patch *patch)
+static void prepare_symlink_changes(struct apply_state *state, struct patch *patch)
 {
 	for ( ; patch; patch = patch->next) {
 		if ((patch->old_name && S_ISLNK(patch->old_mode)) &&
 		    (patch->is_rename || patch->is_delete))
 			/* the symlink at patch->old_name is removed */
-			register_symlink_changes(patch->old_name, SYMLINK_GOES_AWAY);
+			register_symlink_changes(state, patch->old_name, SYMLINK_GOES_AWAY);
 
 		if (patch->new_name && S_ISLNK(patch->new_mode))
 			/* the symlink at patch->new_name is created or remains */
-			register_symlink_changes(patch->new_name, SYMLINK_IN_RESULT);
+			register_symlink_changes(state, patch->new_name, SYMLINK_IN_RESULT);
 	}
 }
 
@@ -3782,7 +3788,7 @@ static int path_is_beyond_symlink_1(struct apply_state *state, struct strbuf *na
 		if (!name->len)
 			break;
 		name->buf[name->len] = '\0';
-		change = check_symlink_changes(name->buf);
+		change = check_symlink_changes(state, name->buf);
 		if (change & SYMLINK_IN_RESULT)
 			return 1;
 		if (change & SYMLINK_GOES_AWAY)
@@ -3951,7 +3957,7 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 {
 	int err = 0;
 
-	prepare_symlink_changes(patch);
+	prepare_symlink_changes(state, patch);
 	prepare_fn_table(state, patch);
 	while (patch) {
 		if (state->apply_verbosely)
-- 
2.8.1.300.g5fed0c0
