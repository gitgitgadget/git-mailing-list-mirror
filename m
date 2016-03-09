From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 44/48] builtin/apply: move 'fn_table' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:49:12 +0100
Message-ID: <1457545756-20616-45-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiJW-0000Ta-Fs
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933625AbcCIRyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:54:16 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36161 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933298AbcCIRyB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:54:01 -0500
Received: by mail-wm0-f49.google.com with SMTP id n186so190639289wmn.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FdsosnsXcb7kMyi5lHnESWi2Ons3i/+Yyu2inolbY1E=;
        b=R6Bi+9f8xIb1Mc7zA47F9AsPKiV0oCbqBP73Gsudb6hrn1Rz3Og47qJZLXVZAKbHhF
         pwMVYmU858KQXoPKt1a2cSboGF6ypRnh/BCpAzsWIq0Eut2/g3yIAMSxHOj1K1U6mdGq
         TdWn7VGyEhEup9lVsSZn+0nI2esySBTgFSm4FXm9RX2nncMfCqg4oi/YV9JxRUehCld9
         vQuQheUdLtcwS4E2mS6uSgTMFApLrIIykIXICsQ3Y2hjgTPsbGBC1vCYNsJn3EspER7K
         2OKrgCwCbvG/Qvx4OeaFqqiXOMmgle9Wqa13gwq5Gy750qaI2UnhA4ovZMzxGEsmfW9D
         mI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FdsosnsXcb7kMyi5lHnESWi2Ons3i/+Yyu2inolbY1E=;
        b=dXNZMDArcFKXtp0aL0MDbKU7WWw0JeKpBFYrLJXUgIyOJA/Mg2gKn34CJWKuGSlrB3
         5kB1EgYVFtgsb+RN9CEYqkThIYYaDooobUNBvws+NujfOwptv5iTMIWlIJGwEM0LEMKR
         rVcNKTyTkkbBY800d8kUJmjXVH5vnEJmSZ+QbZW94KgUzul2QInlT8WQQa+09ekhLNOn
         DjSdvn6Y0vVuw3R8dSBP9a0o5U65hi6CbgXy7whQdfPzaAkEpgk3whNZXDJwRzTRe5I2
         PMzG/wjyr9MWr87EdhcXPSKmlK9NvpFJuP7MTlF5B6G22QHNoK/9OUP7Cig+cNpRAIpj
         LqGg==
X-Gm-Message-State: AD7BkJLpxxqoYMfGcrOOCwcXeyZCHSrfdZN82qzIXeuIFQ/VDxyrjV17Z0IPDN+t+3jkJw==
X-Received: by 10.28.88.15 with SMTP id m15mr26296265wmb.60.1457546039635;
        Wed, 09 Mar 2016 09:53:59 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:58 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288532>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 3808d60..8fda1bd 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -94,6 +94,12 @@ struct apply_state {
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
@@ -292,13 +298,6 @@ struct image {
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
@@ -3231,14 +3230,14 @@ static int read_file_or_gitlink(const struct cache_entry *ce, struct strbuf *buf
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
 
@@ -3270,7 +3269,7 @@ static int was_deleted(struct patch *patch)
 	return patch == PATH_WAS_DELETED;
 }
 
-static void add_to_fn_table(struct patch *patch)
+static void add_to_fn_table(struct apply_state *state, struct patch *patch)
 {
 	struct string_list_item *item;
 
@@ -3280,7 +3279,7 @@ static void add_to_fn_table(struct patch *patch)
 	 * file creations and copies
 	 */
 	if (patch->new_name != NULL) {
-		item = string_list_insert(&fn_table, patch->new_name);
+		item = string_list_insert(&state->fn_table, patch->new_name);
 		item->util = patch;
 	}
 
@@ -3289,12 +3288,12 @@ static void add_to_fn_table(struct patch *patch)
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
@@ -3302,7 +3301,7 @@ static void prepare_fn_table(struct patch *patch)
 	while (patch) {
 		if ((patch->new_name == NULL) || (patch->is_rename)) {
 			struct string_list_item *item;
-			item = string_list_insert(&fn_table, patch->old_name);
+			item = string_list_insert(&state->fn_table, patch->old_name);
 			item->util = PATH_TO_BE_DELETED;
 		}
 		patch = patch->next;
@@ -3323,7 +3322,9 @@ static int checkout_target(struct index_state *istate,
 	return 0;
 }
 
-static struct patch *previous_patch(struct patch *patch, int *gone)
+static struct patch *previous_patch(struct apply_state *state,
+				    struct patch *patch,
+				    int *gone)
 {
 	struct patch *previous;
 
@@ -3331,7 +3332,7 @@ static struct patch *previous_patch(struct patch *patch, int *gone)
 	if (patch->is_copy || patch->is_rename)
 		return NULL; /* "git" patches do not depend on the order */
 
-	previous = in_fn_table(patch->old_name);
+	previous = in_fn_table(state, patch->old_name);
 	if (!previous)
 		return NULL;
 
@@ -3400,7 +3401,7 @@ static int load_preimage(struct apply_state *state,
 	struct patch *previous;
 	int status;
 
-	previous = previous_patch(patch, &status);
+	previous = previous_patch(state, patch, &status);
 	if (status)
 		return error(_("path %s has been renamed/deleted"),
 			     patch->old_name);
@@ -3596,7 +3597,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 	}
 	patch->result = image.buf;
 	patch->resultsize = image.len;
-	add_to_fn_table(patch);
+	add_to_fn_table(state, patch);
 	free(image.line_allocated);
 
 	if (0 < patch->is_delete && patch->resultsize)
@@ -3630,7 +3631,7 @@ static int check_preimage(struct apply_state *state,
 		return 0;
 
 	assert(patch->is_new <= 0);
-	previous = previous_patch(patch, &status);
+	previous = previous_patch(state, patch, &status);
 
 	if (status)
 		return error(_("path %s has been renamed/deleted"), old_name);
@@ -3876,7 +3877,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 	 * B and rename from A to B is handled the same way by asking
 	 * was_deleted().
 	 */
-	if ((tpatch = in_fn_table(new_name)) &&
+	if ((tpatch = in_fn_table(state, new_name)) &&
 	    (was_deleted(tpatch) || to_be_deleted(tpatch)))
 		ok_if_exists = 1;
 	else
@@ -3954,7 +3955,7 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 	int err = 0;
 
 	prepare_symlink_changes(patch);
-	prepare_fn_table(patch);
+	prepare_fn_table(state, patch);
 	while (patch) {
 		if (state->apply_verbosely)
 			say_patch_name(stderr,
@@ -4592,7 +4593,7 @@ static int apply_patch(struct apply_state *state,
 
 	free_patch_list(list);
 	strbuf_release(&buf);
-	string_list_clear(&fn_table, 0);
+	string_list_clear(&state->fn_table, 0);
 	return 0;
 }
 
-- 
2.8.0.rc1.49.gca61272
