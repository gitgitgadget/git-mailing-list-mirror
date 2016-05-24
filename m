From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 45/49] builtin/apply: move 'symlink_changes' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:22 +0200
Message-ID: <20160524081126.16973-46-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:13:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57SW-00013z-P4
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbcEXIMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35018 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932319AbcEXIMu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id f75so3659062wmf.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eeYsumSYA/buLvyQJpF8qFGvjrW9I9rMDY1E3AGPnEI=;
        b=jxb8mH+Jh0J51JUvjaUBfLxcAYZKgSkZKmEbgR2cZ6C0ud1+LzxuEhygbSVlxX/fIe
         ALg6SAGtGzZa4tELTGgrIzxu+ZmcyY7PK1x9GndxLF6pcTTizhSoeqFc90UeRaRCi5AX
         Ik5xAWaRybqRE2iZW1PHmNi5TdcUPUfcSIdUWVAT5qW2MZcDLcUmTzvIha1aN1wsJJwX
         p3kFmBEEiIon6CM4eZUTqOLakyg/szIG4M5X9KJbUBnq3qzoeFg/iHyCxEgKYxMNNlpq
         Zf/ChtkBH3UwEfvTPTA7k7nMcWUH6lA9Vo8rD/dNUSqvbJnY2TvEBp3W02Uzl4ZA4/u4
         zbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eeYsumSYA/buLvyQJpF8qFGvjrW9I9rMDY1E3AGPnEI=;
        b=BfD560TQh0zlytAEKdFvTJ9v5UEdPHD8kCUKctXKl7/NZMCWD0++5x9o30QQKCmyRz
         DvB2HYU/TH5jAzOE9dZ0i9xEAvSzTNVyuHDIckWfddiQvBHiPfhAlGY5chFFPf4ezd2a
         rEq+gZCM8lDja+btFcGbk64nXdrRWb4QOr7wp1/oi7N4upJYjiv2BRxdhZ/Mz1lytxoC
         ol2liEh9p9wzEJRJNulz02HG60jm9UVj7RRon0DwAbPDki1tQ5O3p3VaJH4JT5WNb4Lc
         GRHtF/nRwg2mLmY+TiHzaxqZbgwUuXlZl5c5nV5tQLbvY56u7DuRLH94vypZXcGQb+dl
         XDLQ==
X-Gm-Message-State: ALyK8tJQZoRjhy+29Sy7Z36ELERbLU3BWGRcfjdOdkLL0wpGLUjHNRCgQEQE6Z5JfZi0IA==
X-Received: by 10.28.150.80 with SMTP id y77mr16516341wmd.62.1464077568367;
        Tue, 24 May 2016 01:12:48 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:47 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295441>

To libify the apply functionality the 'symlink_changes' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 50 ++++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 47622be..980bb34 100644
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
@@ -75,6 +89,7 @@ struct apply_state {
 
 	/* Various "current state" */
 	int linenr; /* current line number */
+	struct string_list symlink_changes; /* we have to track symlinks */
 
 	/*
 	 * For "diff-stat" like behaviour, we keep track of the biggest change
@@ -3702,52 +3717,42 @@ static int check_to_create(struct apply_state *state,
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
 
@@ -3761,7 +3766,7 @@ static int path_is_beyond_symlink_1(struct apply_state *state, struct strbuf *na
 		if (!name->len)
 			break;
 		name->buf[name->len] = '\0';
-		change = check_symlink_changes(name->buf);
+		change = check_symlink_changes(state, name->buf);
 		if (change & SYMLINK_IN_RESULT)
 			return 1;
 		if (change & SYMLINK_GOES_AWAY)
@@ -3930,7 +3935,7 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 {
 	int err = 0;
 
-	prepare_symlink_changes(patch);
+	prepare_symlink_changes(state, patch);
 	prepare_fn_table(state, patch);
 	while (patch) {
 		if (state->apply_verbosely)
@@ -4668,6 +4673,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 static void clear_apply_state(struct apply_state *state)
 {
 	string_list_clear(&state->limit_by_name, 0);
+	string_list_clear(&state->symlink_changes, 0);
 	strbuf_release(&state->root);
 
 	/* &state->fn_table is cleared at the end of apply_patch() */
-- 
2.8.3.443.gaeee61e
