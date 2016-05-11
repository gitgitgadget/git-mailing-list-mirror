From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 44/94] builtin/apply: move 'fn_table' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:55 +0200
Message-ID: <20160511131745.2914-45-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:20:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3d-0003Hd-Ie
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbcEKNUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36142 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbcEKNT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id w143so9349591wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XMkCjg1XwCfOf9nAudS0pw/5efOK0fHOfDYCHLVmO+w=;
        b=qcq/4tUkouzGNu5khE00kJqFcNAHD+0uWwI+KUpRQNNT1UPDguouNXAQcig/mAPChh
         knMIKAtLBYAuUXfsrI9jdA/jqby54VJK8t0VQPK0WUIjKta3fzYroHRMcQmMoVj3qzHP
         +VE9C44voQYQOEKU5ScS0z/pL+ZnxPbuf/6HEuQTOAmoZ8LXZ47mgf5WWFS6fTgJzA6z
         XHKX0u+6tnDvCfh9PyTOXH9PKY49H3Dqt1LJhksScaT//ng5nFRWlaassAOmCQ7qqHaT
         4YmJCYaDZR084OXkKeV9+Aez73wsKyqIGFri9EiNYkwxBv4Dsma/JMkXHjDtv6Fe3kJA
         t8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XMkCjg1XwCfOf9nAudS0pw/5efOK0fHOfDYCHLVmO+w=;
        b=Yy70sgjODxieLcDiS3w701pCVuv8B1217BxVAqBSq91H0zWbzawb+0Q/Hov02WY/IY
         VaRCaIqrOnpPT9MSVzxdzBtF5uCeJbOvX8Iva3nte4DkY+KJS8dRmyiCEHLhqH6q0Fx5
         2o+MI90KNrJXYpFTsMry9gFrPvSDMz7pvwWfxopmOYaU62mTFzT0DeC/zEhcBaZSffvw
         OQMEHSk/G6PBeVKMP4pWTsIEi1L9L6HCoLzPMiAhkaEB2i2mVtrg2IpbD4t1JGyQQG7V
         FmTFE3NfmgBB1NnPeqrJEh0Ubcih+5cInsRf45rmaSNiCMQDDJbZnhyHQS/Z75K72MEX
         os1A==
X-Gm-Message-State: AOPr4FU7tMSKEC0zcRZaKWGSRwNocgaZHNrywOAr57+sBXVZMaH+gkfyOozZfCZ6FjbBBw==
X-Received: by 10.194.6.65 with SMTP id y1mr3787600wjy.12.1462972797700;
        Wed, 11 May 2016 06:19:57 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:56 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294276>

To libify the apply functionality the 'fn_table' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5c003a1..506e9ec 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -91,6 +91,12 @@ struct apply_state {
 	 */
 	int linenr;
 
+	/*
+	 * Records filenames that have been touched, in order to handle
+	 * the case where more than one patches touch the same file.
+	 */
+	struct string_list fn_table;
+
 	int p_value;
 	int p_value_known;
 	unsigned int p_context;
@@ -282,13 +288,6 @@ struct image {
 	struct line *line;
 };
 
-/*
- * Records filenames that have been touched, in order to handle
- * the case where more than one patches touch the same file.
- */
-
-static struct string_list fn_table;
-
 static uint32_t hash_line(const char *cp, size_t len)
 {
 	size_t i;
@@ -3218,14 +3217,14 @@ static int read_file_or_gitlink(const struct cache_entry *ce, struct strbuf *buf
 	return read_blob_object(buf, ce->sha1, ce->ce_mode);
 }
 
-static struct patch *in_fn_table(const char *name)
+static struct patch *in_fn_table(struct apply_state *state, const char *name)
 {
 	struct string_list_item *item;
 
 	if (name == NULL)
 		return NULL;
 
-	item = string_list_lookup(&fn_table, name);
+	item = string_list_lookup(&state->fn_table, name);
 	if (item != NULL)
 		return (struct patch *)item->util;
 
@@ -3257,7 +3256,7 @@ static int was_deleted(struct patch *patch)
 	return patch == PATH_WAS_DELETED;
 }
 
-static void add_to_fn_table(struct patch *patch)
+static void add_to_fn_table(struct apply_state *state, struct patch *patch)
 {
 	struct string_list_item *item;
 
@@ -3267,7 +3266,7 @@ static void add_to_fn_table(struct patch *patch)
 	 * file creations and copies
 	 */
 	if (patch->new_name != NULL) {
-		item = string_list_insert(&fn_table, patch->new_name);
+		item = string_list_insert(&state->fn_table, patch->new_name);
 		item->util = patch;
 	}
 
@@ -3276,12 +3275,12 @@ static void add_to_fn_table(struct patch *patch)
 	 * later chunks shouldn't patch old names
 	 */
 	if ((patch->new_name == NULL) || (patch->is_rename)) {
-		item = string_list_insert(&fn_table, patch->old_name);
+		item = string_list_insert(&state->fn_table, patch->old_name);
 		item->util = PATH_WAS_DELETED;
 	}
 }
 
-static void prepare_fn_table(struct patch *patch)
+static void prepare_fn_table(struct apply_state *state, struct patch *patch)
 {
 	/*
 	 * store information about incoming file deletion
@@ -3289,7 +3288,7 @@ static void prepare_fn_table(struct patch *patch)
 	while (patch) {
 		if ((patch->new_name == NULL) || (patch->is_rename)) {
 			struct string_list_item *item;
-			item = string_list_insert(&fn_table, patch->old_name);
+			item = string_list_insert(&state->fn_table, patch->old_name);
 			item->util = PATH_TO_BE_DELETED;
 		}
 		patch = patch->next;
@@ -3310,7 +3309,9 @@ static int checkout_target(struct index_state *istate,
 	return 0;
 }
 
-static struct patch *previous_patch(struct patch *patch, int *gone)
+static struct patch *previous_patch(struct apply_state *state,
+				    struct patch *patch,
+				    int *gone)
 {
 	struct patch *previous;
 
@@ -3318,7 +3319,7 @@ static struct patch *previous_patch(struct patch *patch, int *gone)
 	if (patch->is_copy || patch->is_rename)
 		return NULL; /* "git" patches do not depend on the order */
 
-	previous = in_fn_table(patch->old_name);
+	previous = in_fn_table(state, patch->old_name);
 	if (!previous)
 		return NULL;
 
@@ -3387,7 +3388,7 @@ static int load_preimage(struct apply_state *state,
 	struct patch *previous;
 	int status;
 
-	previous = previous_patch(patch, &status);
+	previous = previous_patch(state, patch, &status);
 	if (status)
 		return error(_("path %s has been renamed/deleted"),
 			     patch->old_name);
@@ -3583,7 +3584,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 	}
 	patch->result = image.buf;
 	patch->resultsize = image.len;
-	add_to_fn_table(patch);
+	add_to_fn_table(state, patch);
 	free(image.line_allocated);
 
 	if (0 < patch->is_delete && patch->resultsize)
@@ -3617,7 +3618,7 @@ static int check_preimage(struct apply_state *state,
 		return 0;
 
 	assert(patch->is_new <= 0);
-	previous = previous_patch(patch, &status);
+	previous = previous_patch(state, patch, &status);
 
 	if (status)
 		return error(_("path %s has been renamed/deleted"), old_name);
@@ -3863,7 +3864,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 	 * B and rename from A to B is handled the same way by asking
 	 * was_deleted().
 	 */
-	if ((tpatch = in_fn_table(new_name)) &&
+	if ((tpatch = in_fn_table(state, new_name)) &&
 	    (was_deleted(tpatch) || to_be_deleted(tpatch)))
 		ok_if_exists = 1;
 	else
@@ -3941,7 +3942,7 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 	int err = 0;
 
 	prepare_symlink_changes(patch);
-	prepare_fn_table(patch);
+	prepare_fn_table(state, patch);
 	while (patch) {
 		if (state->apply_verbosely)
 			say_patch_name(stderr,
@@ -4585,7 +4586,7 @@ static int apply_patch(struct apply_state *state,
 
 	free_patch_list(list);
 	strbuf_release(&buf);
-	string_list_clear(&fn_table, 0);
+	string_list_clear(&state->fn_table, 0);
 	return 0;
 }
 
-- 
2.8.2.490.g3dabe57
