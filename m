From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 45/94] builtin/apply: move 'symlink_changes' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:56 +0200
Message-ID: <20160511131745.2914-46-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:20:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3e-0003Hd-9X
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbcEKNUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33271 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbcEKNUB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id r12so9411810wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DIvaQiTeJEVLi4LguhpowPqF4gdw3EMyjSC14X+M0sc=;
        b=ZPRNCb2KvKmvCD5bqNXp2FK4kWWyOdK1Fyzhkp/HVrWwpjVsr2yok2zGI6tUxl91Y7
         YASfIZt99Nyp6TR8fjikDhVcIbmvLIFJ3GZL5UQy+Qp0ttehB0b2mQkT9Hv/xXaAt757
         DPQGTYG3No8POxRG0RepRS1C6v3trnB/dCLSgQjcatCkAoOaVea82HseLogdIqqjrWwU
         NZFiGnYEpNPZnliOZkqX7MCCSWOqvfs/4zRESiABkgVVYUqWhOIhYFVtWL/GOaKUutOm
         ZckFzgdwcibSGZPfd5HbiPCJLqtmIrXNnREGglJ/4h/X1U1pcLLy3XVmYLewa8fH7Gtr
         H6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DIvaQiTeJEVLi4LguhpowPqF4gdw3EMyjSC14X+M0sc=;
        b=LlX/r2/dcPcrsgIVfb4Db4LhaIH2EBFFLn4P2vQfPDZFghzAWkgior5awFEjcbIlgV
         bpK6lvYmSPi9wsetQQoOHmCjnivWabFZ/1fLAmkityX1HXsbKlLoUNy2327O2ESeV1lR
         FfriHBpQPQNczudLN9YrWN/vBDTxsSb6RAObbiv2tUUQk231MyGntFtjlFbmCiG6zGxP
         FCB/evtIOPvcwmdPsNkYuI7vI/uSW97pNmGtzWYGox0oITrDHfgx6pZeod5pBk5FJ+D+
         khYPbDHa+6tJlTHwJGk7vUaxeO5EmsNZiKx+qRUAxI+0Y5i4vEQD7vCRjACMzQZWMQ64
         nbqw==
X-Gm-Message-State: AOPr4FVLX0zld+7bgWt15Avi2TyBrZbd28UCDjSf07kHb+DjMbW6JqjXamUbAmYCDGMDHA==
X-Received: by 10.28.189.138 with SMTP id n132mr4470959wmf.34.1462972799723;
        Wed, 11 May 2016 06:19:59 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:58 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294274>

To libify the apply functionality the 'symlink_changes' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 506e9ec..14286d2 100644
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
@@ -61,6 +75,7 @@ struct apply_state {
 	struct string_list limit_by_name;
 	int has_include;
 	struct strbuf root;
+	struct string_list symlink_changes;
 
 	/*
 	 *  --check turns on checking that the working tree matches the
@@ -3713,52 +3728,42 @@ static int check_to_create(struct apply_state *state,
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
 
@@ -3772,7 +3777,7 @@ static int path_is_beyond_symlink_1(struct apply_state *state, struct strbuf *na
 		if (!name->len)
 			break;
 		name->buf[name->len] = '\0';
-		change = check_symlink_changes(name->buf);
+		change = check_symlink_changes(state, name->buf);
 		if (change & SYMLINK_IN_RESULT)
 			return 1;
 		if (change & SYMLINK_GOES_AWAY)
@@ -3941,7 +3946,7 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 {
 	int err = 0;
 
-	prepare_symlink_changes(patch);
+	prepare_symlink_changes(state, patch);
 	prepare_fn_table(state, patch);
 	while (patch) {
 		if (state->apply_verbosely)
-- 
2.8.2.490.g3dabe57
