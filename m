From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 45/48] builtin/apply: move 'symlink_changes' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:49:13 +0100
Message-ID: <1457545756-20616-46-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiJi-0000gp-EF
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933792AbcCIRy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:54:29 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34091 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933777AbcCIRyD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:54:03 -0500
Received: by mail-wm0-f45.google.com with SMTP id p65so203159414wmp.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HuSYW3bw2bzdbvNgPZ7rIHuYL9R8voj4OQ3QkQQ45l0=;
        b=vKSdU2rvUfcjIKs0MO/MMqg8+Y8iug16dAF/6bJoyOWglJf3tolQGl5sQpZnllZjVy
         OhIqrKE1PVSfrfxBpSiRlcpTlRQ+amVsPkTBVohMlDjIgZiDtJoN+iJc2eLU7FJDB6Nj
         q8QC1HBf5/4MysT5w6ibOnAn8nLDXv6xqwLinlbwZz9xc1+v7LEjDOlHDX6fZNk20Wcm
         85jy5Djd5hCzO9E4+mzjVzlCNG7jaw4yAKTWwS63rGw9gXqwoCPIr3zNwcKQucnCSwTi
         xF7EYAWCAGgU27fqvuBU96oAjxZ/POjun9uZqxtcitmFKb9nEKYvGRvNiZnWJC4dbQbv
         haZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HuSYW3bw2bzdbvNgPZ7rIHuYL9R8voj4OQ3QkQQ45l0=;
        b=YfABvmD5VkJ4zt20w13FgfS38KuDrJZhXPT98L1vMqVmSX24JkK8VsXmTgL4ZwCgGL
         RlfRX9KBP9KZKCljI2SiBLWNqbLQoj3HyVS9M80E+JME4A5DeTriqYG0fL1//zMaKhqr
         DpmzHk8zpqE8D7bSFqhIClSkqH7PDHhnWcVT1dSwFOyKflfTNktj3jWdTJAxQfC4RtIo
         11llz+Fw0yWk2otNZpsceykjrIzi6YNKcyKP/S44kN8Nf1OyJ/SXX1U7jLsBBNU7FX5X
         egyB9XdsevfSW3G84f9pQl24T0MSr+l/GofjIOaZ91vgj2hH/hpL7ni33+njpM9urhhU
         zHIw==
X-Gm-Message-State: AD7BkJIZe9Mb6ChbR9pgxpvOccT3CKuvZoK8Xl6//sYeR9NO34o4xRPy0/ByrCoBU2dGLg==
X-Received: by 10.28.229.132 with SMTP id c126mr25979554wmh.72.1457546042296;
        Wed, 09 Mar 2016 09:54:02 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:54:01 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288535>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 50 ++++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8fda1bd..66ebc9b 100644
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
@@ -100,6 +114,8 @@ struct apply_state {
 	 */
 	struct string_list fn_table;
 
+	struct string_list symlink_changes;
+
 	int p_value;
 	int p_value_known;
 	unsigned int p_context;
@@ -3726,52 +3742,42 @@ static int check_to_create(struct apply_state *state,
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
 
@@ -3785,7 +3791,7 @@ static int path_is_beyond_symlink_1(struct apply_state *state, struct strbuf *na
 		if (!name->len)
 			break;
 		name->buf[name->len] = '\0';
-		change = check_symlink_changes(name->buf);
+		change = check_symlink_changes(state, name->buf);
 		if (change & SYMLINK_IN_RESULT)
 			return 1;
 		if (change & SYMLINK_GOES_AWAY)
@@ -3954,7 +3960,7 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 {
 	int err = 0;
 
-	prepare_symlink_changes(patch);
+	prepare_symlink_changes(state, patch);
 	prepare_fn_table(state, patch);
 	while (patch) {
 		if (state->apply_verbosely)
-- 
2.8.0.rc1.49.gca61272
