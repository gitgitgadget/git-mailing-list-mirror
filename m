From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 43/83] builtin/apply: move 'fn_table' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:43 +0200
Message-ID: <1461504863-15946-44-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:38:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKEh-0000rZ-VH
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbcDXNh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:37:57 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37780 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbcDXNfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:48 -0400
Received: by mail-wm0-f43.google.com with SMTP id n3so90215176wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Sb4dvniAEWtObhNyBgMvcEPqgxSdxsviTnod5+oI+A=;
        b=NJo7DDdxqDO23edgibgfR3S0T6b3bWN+2J38HenYv7QMyUyXj6NR8QXO0+aLqAHLuY
         2e4N5kU4lT4FfgZkRWumlN64X7PFFJB5bVaDn+SLCYv0cSWm9TtCZOVHlXg4+Z+XCqi9
         7uCkndBAHqUV/2KgGIxjt4YREF/Ud8rStWHh+K+c2Gni1MuwaTkpCNj2gxIk1tVZYLgC
         WQxzSpNn/eb4A6ibeDVeJPylZjnQx9868qQc5nMHIHbV+YJp7W0fjvJMPGjYFDCYGuI+
         gcIHpL/3VVhxBvfuWw+3txRh3YFQEuXKR5hQg2uCc2a/7RfdYoMi36Pv50m8fKzr1CX9
         TRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Sb4dvniAEWtObhNyBgMvcEPqgxSdxsviTnod5+oI+A=;
        b=B+ukVJvPVHe16M3PopjzI7I8ugybZ4zKIvnRrqTCHB/l81olGRRixz9r5GZT8joiyx
         xojmEsJ47cYw8j1k5+0nMEsQRkkoUkk35ze3FLAzS9aw/6RNswY2M09jFqX6DoQOAxXN
         j7I4Xgp6HzimMXZzSy4zYcTVWWuAYw0MdOh+bUPhvAh/jaexijM1WbykU3VW0Wag7Ntr
         pQ5s7oZOq++wXPkb5pnzyQOHIcaW/iKtgfa6NJX9DRGUTXEGQ//G2XNSH3bm+BGEXAqh
         dvqMSgrgEgswFCapehMGHFqwgKQpUxkmkCr2Ok66tKoulUC56nIX2+LousLGmXXuOB5c
         xkfw==
X-Gm-Message-State: AOPr4FVZiHLDyZSy7otycRsmrbbxhsVCDtl+zVn5AsPdZOpwrNLejYaw7whArg/9ThAfXw==
X-Received: by 10.194.62.145 with SMTP id y17mr31688160wjr.109.1461504947288;
        Sun, 24 Apr 2016 06:35:47 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:46 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292382>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index f387340..b4c2bd8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -93,6 +93,12 @@ struct apply_state {
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
@@ -291,13 +297,6 @@ struct image {
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
@@ -3228,14 +3227,14 @@ static int read_file_or_gitlink(const struct cache_entry *ce, struct strbuf *buf
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
 
@@ -3267,7 +3266,7 @@ static int was_deleted(struct patch *patch)
 	return patch == PATH_WAS_DELETED;
 }
 
-static void add_to_fn_table(struct patch *patch)
+static void add_to_fn_table(struct apply_state *state, struct patch *patch)
 {
 	struct string_list_item *item;
 
@@ -3277,7 +3276,7 @@ static void add_to_fn_table(struct patch *patch)
 	 * file creations and copies
 	 */
 	if (patch->new_name != NULL) {
-		item = string_list_insert(&fn_table, patch->new_name);
+		item = string_list_insert(&state->fn_table, patch->new_name);
 		item->util = patch;
 	}
 
@@ -3286,12 +3285,12 @@ static void add_to_fn_table(struct patch *patch)
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
@@ -3299,7 +3298,7 @@ static void prepare_fn_table(struct patch *patch)
 	while (patch) {
 		if ((patch->new_name == NULL) || (patch->is_rename)) {
 			struct string_list_item *item;
-			item = string_list_insert(&fn_table, patch->old_name);
+			item = string_list_insert(&state->fn_table, patch->old_name);
 			item->util = PATH_TO_BE_DELETED;
 		}
 		patch = patch->next;
@@ -3320,7 +3319,9 @@ static int checkout_target(struct index_state *istate,
 	return 0;
 }
 
-static struct patch *previous_patch(struct patch *patch, int *gone)
+static struct patch *previous_patch(struct apply_state *state,
+				    struct patch *patch,
+				    int *gone)
 {
 	struct patch *previous;
 
@@ -3328,7 +3329,7 @@ static struct patch *previous_patch(struct patch *patch, int *gone)
 	if (patch->is_copy || patch->is_rename)
 		return NULL; /* "git" patches do not depend on the order */
 
-	previous = in_fn_table(patch->old_name);
+	previous = in_fn_table(state, patch->old_name);
 	if (!previous)
 		return NULL;
 
@@ -3397,7 +3398,7 @@ static int load_preimage(struct apply_state *state,
 	struct patch *previous;
 	int status;
 
-	previous = previous_patch(patch, &status);
+	previous = previous_patch(state, patch, &status);
 	if (status)
 		return error(_("path %s has been renamed/deleted"),
 			     patch->old_name);
@@ -3593,7 +3594,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 	}
 	patch->result = image.buf;
 	patch->resultsize = image.len;
-	add_to_fn_table(patch);
+	add_to_fn_table(state, patch);
 	free(image.line_allocated);
 
 	if (0 < patch->is_delete && patch->resultsize)
@@ -3627,7 +3628,7 @@ static int check_preimage(struct apply_state *state,
 		return 0;
 
 	assert(patch->is_new <= 0);
-	previous = previous_patch(patch, &status);
+	previous = previous_patch(state, patch, &status);
 
 	if (status)
 		return error(_("path %s has been renamed/deleted"), old_name);
@@ -3873,7 +3874,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 	 * B and rename from A to B is handled the same way by asking
 	 * was_deleted().
 	 */
-	if ((tpatch = in_fn_table(new_name)) &&
+	if ((tpatch = in_fn_table(state, new_name)) &&
 	    (was_deleted(tpatch) || to_be_deleted(tpatch)))
 		ok_if_exists = 1;
 	else
@@ -3951,7 +3952,7 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 	int err = 0;
 
 	prepare_symlink_changes(patch);
-	prepare_fn_table(patch);
+	prepare_fn_table(state, patch);
 	while (patch) {
 		if (state->apply_verbosely)
 			say_patch_name(stderr,
@@ -4595,7 +4596,7 @@ static int apply_patch(struct apply_state *state,
 
 	free_patch_list(list);
 	strbuf_release(&buf);
-	string_list_clear(&fn_table, 0);
+	string_list_clear(&state->fn_table, 0);
 	return 0;
 }
 
-- 
2.8.1.300.g5fed0c0
