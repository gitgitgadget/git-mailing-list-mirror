From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 10/49] builtin/apply: move 'unidiff_zero' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:10:47 +0200
Message-ID: <20160524081126.16973-11-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:16:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57VX-0002Bi-J4
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbcEXIP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:15:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34394 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260AbcEXIMC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so3657482wmn.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rBm51HK7pgwuDsoB8LoPd6wra6+SsIlB3PsnQvNvpv4=;
        b=AuNuyo0N8MSGWDoly6L++xlF0z2sf0Sq1tF285Ac1KFZS4S59+NgQrQVqbCHShVqm0
         6/1rKx0CGmoZ+GYz1cuaMWAeMtSWn7ZlVVqJGkCxXKFzKOjjS13IW0hnSMnNA/iYTCI8
         uoN7pIuajZB4qTlGnhfaFbpowxdyh7/1CXMUXMiJmCjNbJCSf9TkVZN9ssqUDLxFvDVC
         PR3IjtCfWmsWWS5O5kjE5fKCZLxxCYCyeZLatrjHiLF1LgCzAcGUD4Za/0vVVJYAu3Dm
         Nm6a728gDZiBZBqlvhHu588uU0XB19Z7YXOnZcvvE9DVEx5fBV/cpBhOoiIl26RFhBMR
         PbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rBm51HK7pgwuDsoB8LoPd6wra6+SsIlB3PsnQvNvpv4=;
        b=deCYEHJ6gHhbpVgCHYssP42lLXWmMxYIpQkk1/sbh560kX6PzY9HGEFomqUt5bBLwz
         pr/s36lo+oYfbs7YYwHacIbPBmIW1xj4aUasWp9LwbCK3/Ot1964hKNh+b1dFuZzpDbH
         UY2u6+cvnNrWHPkLA2iIWQdXMiT4d4KbP/2mhejG6a0FZ85xid7IzfPDhAArQZwo7kqW
         w6VD3kq6db6vG83VDNjG3fRBbPnvZB1BDZtqATJwwfVLlY5vBde2EY/5bAb9D6mzxrDd
         82mIVptNScWcqBLKrhoOUMhpS3z9HIuPCMq/4S+1TxV5URoghZYzpuYVYRgVFG3P7z4s
         5Etg==
X-Gm-Message-State: AOPr4FWX35l0tPqAxLNRCJhn5YK5bCBzPV2SaBR7um0f0PmgZCwDTPw5SLRotqB94MgBuQ==
X-Received: by 10.28.24.82 with SMTP id 79mr22515120wmy.42.1464077520272;
        Tue, 24 May 2016 01:12:00 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:11:59 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295470>

To libify the apply functionality the 'unidiff_zero' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 52b5d3e..6c36898 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -24,6 +24,9 @@
 struct apply_state {
 	const char *prefix;
 	int prefix_length;
+
+	/* These boolean parameters control how the apply is done */
+	int unidiff_zero;
 };
 
 /*
@@ -37,7 +40,6 @@ struct apply_state {
  */
 static int newfd = -1;
 
-static int unidiff_zero;
 static int state_p_value = 1;
 static int p_value_known;
 static int check_index;
@@ -2694,7 +2696,8 @@ static void update_image(struct image *img,
  * postimage) for the hunk.  Find lines that match "preimage" in "img" and
  * replace the part of "img" with "postimage" text.
  */
-static int apply_one_fragment(struct image *img, struct fragment *frag,
+static int apply_one_fragment(struct apply_state *state,
+			      struct image *img, struct fragment *frag,
 			      int inaccurate_eof, unsigned ws_rule,
 			      int nth_fragment)
 {
@@ -2836,7 +2839,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	 * without leading context must match at the beginning.
 	 */
 	match_beginning = (!frag->oldpos ||
-			   (frag->oldpos == 1 && !unidiff_zero));
+			   (frag->oldpos == 1 && !state->unidiff_zero));
 
 	/*
 	 * A hunk without trailing lines must match at the end.
@@ -2844,7 +2847,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	 * from the lack of trailing lines if the patch was generated
 	 * with unidiff without any context.
 	 */
-	match_end = !unidiff_zero && !trailing;
+	match_end = !state->unidiff_zero && !trailing;
 
 	pos = frag->newpos ? (frag->newpos - 1) : 0;
 	preimage.buf = oldlines;
@@ -3067,7 +3070,7 @@ static int apply_binary(struct image *img, struct patch *patch)
 	return 0;
 }
 
-static int apply_fragments(struct image *img, struct patch *patch)
+static int apply_fragments(struct apply_state *state, struct image *img, struct patch *patch)
 {
 	struct fragment *frag = patch->fragments;
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
@@ -3080,7 +3083,7 @@ static int apply_fragments(struct image *img, struct patch *patch)
 
 	while (frag) {
 		nth++;
-		if (apply_one_fragment(img, frag, inaccurate_eof, ws_rule, nth)) {
+		if (apply_one_fragment(state, img, frag, inaccurate_eof, ws_rule, nth)) {
 			error(_("patch failed: %s:%ld"), name, frag->oldpos);
 			if (!apply_with_reject)
 				return -1;
@@ -3388,8 +3391,11 @@ static int load_current(struct image *image, struct patch *patch)
 	return 0;
 }
 
-static int try_threeway(struct image *image, struct patch *patch,
-			struct stat *st, const struct cache_entry *ce)
+static int try_threeway(struct apply_state *state,
+			struct image *image,
+			struct patch *patch,
+			struct stat *st,
+			const struct cache_entry *ce)
 {
 	unsigned char pre_sha1[20], post_sha1[20], our_sha1[20];
 	struct strbuf buf = STRBUF_INIT;
@@ -3415,7 +3421,7 @@ static int try_threeway(struct image *image, struct patch *patch,
 	img = strbuf_detach(&buf, &len);
 	prepare_image(&tmp_image, img, len, 1);
 	/* Apply the patch to get the post image */
-	if (apply_fragments(&tmp_image, patch) < 0) {
+	if (apply_fragments(state, &tmp_image, patch) < 0) {
 		clear_image(&tmp_image);
 		return -1;
 	}
@@ -3459,7 +3465,8 @@ static int try_threeway(struct image *image, struct patch *patch,
 	return 0;
 }
 
-static int apply_data(struct patch *patch, struct stat *st, const struct cache_entry *ce)
+static int apply_data(struct apply_state *state, struct patch *patch,
+		      struct stat *st, const struct cache_entry *ce)
 {
 	struct image image;
 
@@ -3467,9 +3474,9 @@ static int apply_data(struct patch *patch, struct stat *st, const struct cache_e
 		return -1;
 
 	if (patch->direct_to_threeway ||
-	    apply_fragments(&image, patch) < 0) {
+	    apply_fragments(state, &image, patch) < 0) {
 		/* Note: with --reject, apply_fragments() returns 0 */
-		if (!threeway || try_threeway(&image, patch, st, ce) < 0)
+		if (!threeway || try_threeway(state, &image, patch, st, ce) < 0)
 			return -1;
 	}
 	patch->result = image.buf;
@@ -3717,7 +3724,7 @@ static void die_on_unsafe_path(struct patch *patch)
  * Check and apply the patch in-core; leave the result in patch->result
  * for the caller to write it out to the final destination.
  */
-static int check_patch(struct patch *patch)
+static int check_patch(struct apply_state *state, struct patch *patch)
 {
 	struct stat st;
 	const char *old_name = patch->old_name;
@@ -3816,13 +3823,13 @@ static int check_patch(struct patch *patch)
 		return error(_("affected file '%s' is beyond a symbolic link"),
 			     patch->new_name);
 
-	if (apply_data(patch, &st, ce) < 0)
+	if (apply_data(state, patch, &st, ce) < 0)
 		return error(_("%s: patch does not apply"), name);
 	patch->rejected = 0;
 	return 0;
 }
 
-static int check_patch_list(struct patch *patch)
+static int check_patch_list(struct apply_state *state, struct patch *patch)
 {
 	int err = 0;
 
@@ -3832,7 +3839,7 @@ static int check_patch_list(struct patch *patch)
 		if (apply_verbosely)
 			say_patch_name(stderr,
 				       _("Checking patch %s..."), patch);
-		err |= check_patch(patch);
+		err |= check_patch(state, patch);
 		patch = patch->next;
 	}
 	return err;
@@ -4434,7 +4441,7 @@ static int apply_patch(struct apply_state *state,
 	}
 
 	if ((check || apply) &&
-	    check_patch_list(list) < 0 &&
+	    check_patch_list(state, list) < 0 &&
 	    !apply_with_reject)
 		exit(1);
 
@@ -4602,7 +4609,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG, option_parse_space_change },
 		OPT_BOOL('R', "reverse", &apply_in_reverse,
 			N_("apply the patch in reverse")),
-		OPT_BOOL(0, "unidiff-zero", &unidiff_zero,
+		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
 			N_("don't expect at least one line of context")),
 		OPT_BOOL(0, "reject", &apply_with_reject,
 			N_("leave the rejected hunks in corresponding *.rej files")),
-- 
2.8.3.443.gaeee61e
