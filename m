From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 44/49] builtin/apply: move 'fn_table' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:21 +0200
Message-ID: <20160524081126.16973-45-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:13:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Sb-00015o-5p
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbcEXIM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34995 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318AbcEXIMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id f75so3658852wmf.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=okHkNSe/OkmqxZwMAojdI2MhF3d/S1YqzK83wiBZijY=;
        b=d462K7JdfA04TrFiJIj3Jc0m1ZY6fAiP8+1im0jALJkqjNsakHgnaAqvNIxvIExvRt
         NHzArnMeefOFqkNlgsgk/rigSQD+VndCS/LxNBe4XUtJEHWigUILFdLZeVizTKQU9gyh
         6B4Zce87ZtbjCu/IHiPTQdYYFLyr/ZXfd/JjKcBMe5bW1mGMkOBUcHdK2YBJINq68ZnC
         vd5P/dsMsckf7NLzjP5GYYHxciInaclJLtPZ2yP9SvEDNwSx+2v+MLuCB+ILcNAAGapT
         0C3UkqJO89MCDq5fsFsSkigW6rJ4CpGgNgwZfxaHOWteSaMZAeRIW5cQ8UTL5wSi9eMQ
         usRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=okHkNSe/OkmqxZwMAojdI2MhF3d/S1YqzK83wiBZijY=;
        b=J9A8p9UEZXwBtAfQB8mm99gooPYGM6RALlXsnLGdxY3exy2T0AcrgmCW2zQ/jTOaNZ
         2HdqFJKJji+ByLIf5qeFuUgdLbsV8pvXGjfNwcj9ot+YjNmQ1VJ9QX/HqMmQceqs72Wx
         dTNg2PMXrtXP7+VbtuLf3BZaZfrwYp/O2e5rZQKYQ7EiaMc3aDMnik0C2ZrG/QbeQZCP
         6hfc6AsJRTolWL3scnPgQDJxpeItMqCQvynVKKUquKPIzaqd42bHNFa+L95+zwPfC4sI
         hneDBw8PXIpsCKey/5u6A1BewYjK9VZADaJUTXCImvuFDxx1a0wFDpZsJHzs2XpNvrzM
         6qYA==
X-Gm-Message-State: ALyK8tKZ31YDGWDKrXJlmLfyNsMFzcYiBVjFF0fABfMg+TlRkJa5N5owjaK9Rbv4r1PopA==
X-Received: by 10.194.173.161 with SMTP id bl1mr2811347wjc.11.1464077567096;
        Tue, 24 May 2016 01:12:47 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:46 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295443>

To libify the apply functionality the 'fn_table' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

As fn_table is cleared at the end of apply_patch(), it is not
necessary to clear it in clear_apply_state().

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index dd56a8e..47622be 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -84,6 +84,12 @@ struct apply_state {
 	int max_change;
 	int max_len;
 
+	/*
+	 * Records filenames that have been touched, in order to handle
+	 * the case where more than one patches touch the same file.
+	 */
+	struct string_list fn_table;
+
 	/* These control whitespace errors */
 	enum ws_error_action ws_error_action;
 	enum ws_ignore ws_ignore_action;
@@ -271,13 +277,6 @@ struct image {
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
@@ -3207,14 +3206,14 @@ static int read_file_or_gitlink(const struct cache_entry *ce, struct strbuf *buf
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
 
@@ -3246,7 +3245,7 @@ static int was_deleted(struct patch *patch)
 	return patch == PATH_WAS_DELETED;
 }
 
-static void add_to_fn_table(struct patch *patch)
+static void add_to_fn_table(struct apply_state *state, struct patch *patch)
 {
 	struct string_list_item *item;
 
@@ -3256,7 +3255,7 @@ static void add_to_fn_table(struct patch *patch)
 	 * file creations and copies
 	 */
 	if (patch->new_name != NULL) {
-		item = string_list_insert(&fn_table, patch->new_name);
+		item = string_list_insert(&state->fn_table, patch->new_name);
 		item->util = patch;
 	}
 
@@ -3265,12 +3264,12 @@ static void add_to_fn_table(struct patch *patch)
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
@@ -3278,7 +3277,7 @@ static void prepare_fn_table(struct patch *patch)
 	while (patch) {
 		if ((patch->new_name == NULL) || (patch->is_rename)) {
 			struct string_list_item *item;
-			item = string_list_insert(&fn_table, patch->old_name);
+			item = string_list_insert(&state->fn_table, patch->old_name);
 			item->util = PATH_TO_BE_DELETED;
 		}
 		patch = patch->next;
@@ -3299,7 +3298,9 @@ static int checkout_target(struct index_state *istate,
 	return 0;
 }
 
-static struct patch *previous_patch(struct patch *patch, int *gone)
+static struct patch *previous_patch(struct apply_state *state,
+				    struct patch *patch,
+				    int *gone)
 {
 	struct patch *previous;
 
@@ -3307,7 +3308,7 @@ static struct patch *previous_patch(struct patch *patch, int *gone)
 	if (patch->is_copy || patch->is_rename)
 		return NULL; /* "git" patches do not depend on the order */
 
-	previous = in_fn_table(patch->old_name);
+	previous = in_fn_table(state, patch->old_name);
 	if (!previous)
 		return NULL;
 
@@ -3376,7 +3377,7 @@ static int load_preimage(struct apply_state *state,
 	struct patch *previous;
 	int status;
 
-	previous = previous_patch(patch, &status);
+	previous = previous_patch(state, patch, &status);
 	if (status)
 		return error(_("path %s has been renamed/deleted"),
 			     patch->old_name);
@@ -3572,7 +3573,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 	}
 	patch->result = image.buf;
 	patch->resultsize = image.len;
-	add_to_fn_table(patch);
+	add_to_fn_table(state, patch);
 	free(image.line_allocated);
 
 	if (0 < patch->is_delete && patch->resultsize)
@@ -3606,7 +3607,7 @@ static int check_preimage(struct apply_state *state,
 		return 0;
 
 	assert(patch->is_new <= 0);
-	previous = previous_patch(patch, &status);
+	previous = previous_patch(state, patch, &status);
 
 	if (status)
 		return error(_("path %s has been renamed/deleted"), old_name);
@@ -3852,7 +3853,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 	 * B and rename from A to B is handled the same way by asking
 	 * was_deleted().
 	 */
-	if ((tpatch = in_fn_table(new_name)) &&
+	if ((tpatch = in_fn_table(state, new_name)) &&
 	    (was_deleted(tpatch) || to_be_deleted(tpatch)))
 		ok_if_exists = 1;
 	else
@@ -3930,7 +3931,7 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 	int err = 0;
 
 	prepare_symlink_changes(patch);
-	prepare_fn_table(patch);
+	prepare_fn_table(state, patch);
 	while (patch) {
 		if (state->apply_verbosely)
 			say_patch_name(stderr,
@@ -4574,7 +4575,7 @@ static int apply_patch(struct apply_state *state,
 
 	free_patch_list(list);
 	strbuf_release(&buf);
-	string_list_clear(&fn_table, 0);
+	string_list_clear(&state->fn_table, 0);
 	return 0;
 }
 
@@ -4668,6 +4669,8 @@ static void clear_apply_state(struct apply_state *state)
 {
 	string_list_clear(&state->limit_by_name, 0);
 	strbuf_release(&state->root);
+
+	/* &state->fn_table is cleared at the end of apply_patch() */
 }
 
 int cmd_apply(int argc, const char **argv, const char *prefix)
-- 
2.8.3.443.gaeee61e
