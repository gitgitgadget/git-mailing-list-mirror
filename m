From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 08/83] builtin/apply: move 'unidiff_zero' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:08 +0200
Message-ID: <1461504863-15946-9-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:35:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKBj-0007i7-Lz
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbcDXNfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:00 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34855 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbcDXNe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:34:57 -0400
Received: by mail-wm0-f41.google.com with SMTP id e201so60525121wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V1ZcG5VCUGoDHAtW1qFNewKjR70Ya89OdV+iLuGpLcY=;
        b=0p+SIfFST9tgmUeG2ebSyOjrR/tJcjuvrB152a4oe44mKdI3mFI8aJH0hfG5X+BB5l
         XltK4VAIdl8FFDGxohT5vXnxoA7VPBFbYftERwk9ysHs8CPrZ5LO6p5zBYVjOuwghKDf
         ssnd0P3hASmBa1aIx/BzNbSrUzib3eqExrCbwAO8N7vY9r10/QFwd676GsW+VzdkW4EG
         /YR7hAn1GjJySSmgHLc3L/zX2DdfPglXMOSIXByNByf0LX7/0Pw8SMPX5mTal954WaHq
         JrPj7GKA1dgFGYE0HkqK+e31J+Zgm/s8391fW+/aHbgnDZcmV2oT3VhS3tpWJpjZMduG
         Ba+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V1ZcG5VCUGoDHAtW1qFNewKjR70Ya89OdV+iLuGpLcY=;
        b=C/B2yLhfS1R10to2ixvqp5Ph3O4KNJZ4RCIDFkQ432Fb2Cl6KOhwy30NokZbEx2yLB
         9WDZJSdWFac0O0TO5p+99cmfzuC3hj4cFmYgMihoJbW23VEwkdPDcUyCtfZErLy8eO8g
         P38BSC3j0NcBq0OjnluwFDALlBwZRVib2U/ebjveXmi3KvWVRbZzsz/HjM5ELA4p2mJI
         4M0pMridW79SAQie6KRHXoiQ+y/j9ew0b7zmu+TyPjBJA88uFQ324Q6qE/pT/bnvD6eY
         2Xwa2hOBeX1A1bf8du68PJ6AwfV8IIUIHsSG8DsikzAFXaiC0wRGKygGdhQiYpsw50Tx
         CX/Q==
X-Gm-Message-State: AOPr4FWCzwDpTcyiV1Y3fNyNuJcwGm0YBPGHMVIDY6+ij9RIVGVu+dhKAKfGdyXr3PjxPA==
X-Received: by 10.28.103.2 with SMTP id b2mr7075808wmc.66.1461504895593;
        Sun, 24 Apr 2016 06:34:55 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:34:54 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292328>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 51e6af4..ad81210 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -24,6 +24,8 @@
 struct apply_state {
 	const char *prefix;
 	int prefix_length;
+
+	int unidiff_zero;
 };
 
 /*
@@ -37,7 +39,6 @@ struct apply_state {
  */
 static int newfd = -1;
 
-static int unidiff_zero;
 static int state_p_value = 1;
 static int p_value_known;
 static int check_index;
@@ -2696,7 +2697,8 @@ static void update_image(struct image *img,
  * postimage) for the hunk.  Find lines that match "preimage" in "img" and
  * replace the part of "img" with "postimage" text.
  */
-static int apply_one_fragment(struct image *img, struct fragment *frag,
+static int apply_one_fragment(struct apply_state *state,
+			      struct image *img, struct fragment *frag,
 			      int inaccurate_eof, unsigned ws_rule,
 			      int nth_fragment)
 {
@@ -2838,7 +2840,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	 * without leading context must match at the beginning.
 	 */
 	match_beginning = (!frag->oldpos ||
-			   (frag->oldpos == 1 && !unidiff_zero));
+			   (frag->oldpos == 1 && !state->unidiff_zero));
 
 	/*
 	 * A hunk without trailing lines must match at the end.
@@ -2846,7 +2848,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	 * from the lack of trailing lines if the patch was generated
 	 * with unidiff without any context.
 	 */
-	match_end = !unidiff_zero && !trailing;
+	match_end = !state->unidiff_zero && !trailing;
 
 	pos = frag->newpos ? (frag->newpos - 1) : 0;
 	preimage.buf = oldlines;
@@ -3069,7 +3071,7 @@ static int apply_binary(struct image *img, struct patch *patch)
 	return 0;
 }
 
-static int apply_fragments(struct image *img, struct patch *patch)
+static int apply_fragments(struct apply_state *state, struct image *img, struct patch *patch)
 {
 	struct fragment *frag = patch->fragments;
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
@@ -3082,7 +3084,7 @@ static int apply_fragments(struct image *img, struct patch *patch)
 
 	while (frag) {
 		nth++;
-		if (apply_one_fragment(img, frag, inaccurate_eof, ws_rule, nth)) {
+		if (apply_one_fragment(state, img, frag, inaccurate_eof, ws_rule, nth)) {
 			error(_("patch failed: %s:%ld"), name, frag->oldpos);
 			if (!apply_with_reject)
 				return -1;
@@ -3390,8 +3392,11 @@ static int load_current(struct image *image, struct patch *patch)
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
@@ -3417,7 +3422,7 @@ static int try_threeway(struct image *image, struct patch *patch,
 	img = strbuf_detach(&buf, &len);
 	prepare_image(&tmp_image, img, len, 1);
 	/* Apply the patch to get the post image */
-	if (apply_fragments(&tmp_image, patch) < 0) {
+	if (apply_fragments(state, &tmp_image, patch) < 0) {
 		clear_image(&tmp_image);
 		return -1;
 	}
@@ -3461,7 +3466,8 @@ static int try_threeway(struct image *image, struct patch *patch,
 	return 0;
 }
 
-static int apply_data(struct patch *patch, struct stat *st, const struct cache_entry *ce)
+static int apply_data(struct apply_state *state, struct patch *patch,
+		      struct stat *st, const struct cache_entry *ce)
 {
 	struct image image;
 
@@ -3469,9 +3475,9 @@ static int apply_data(struct patch *patch, struct stat *st, const struct cache_e
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
@@ -3719,7 +3725,7 @@ static void die_on_unsafe_path(struct patch *patch)
  * Check and apply the patch in-core; leave the result in patch->result
  * for the caller to write it out to the final destination.
  */
-static int check_patch(struct patch *patch)
+static int check_patch(struct apply_state *state, struct patch *patch)
 {
 	struct stat st;
 	const char *old_name = patch->old_name;
@@ -3818,13 +3824,13 @@ static int check_patch(struct patch *patch)
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
 
@@ -3834,7 +3840,7 @@ static int check_patch_list(struct patch *patch)
 		if (apply_verbosely)
 			say_patch_name(stderr,
 				       _("Checking patch %s..."), patch);
-		err |= check_patch(patch);
+		err |= check_patch(state, patch);
 		patch = patch->next;
 	}
 	return err;
@@ -4436,7 +4442,7 @@ static int apply_patch(struct apply_state *state,
 	}
 
 	if ((check || apply) &&
-	    check_patch_list(list) < 0 &&
+	    check_patch_list(state, list) < 0 &&
 	    !apply_with_reject)
 		exit(1);
 
@@ -4585,7 +4591,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			PARSE_OPT_NOARG, option_parse_space_change },
 		OPT_BOOL('R', "reverse", &apply_in_reverse,
 			N_("apply the patch in reverse")),
-		OPT_BOOL(0, "unidiff-zero", &unidiff_zero,
+		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
 			N_("don't expect at least one line of context")),
 		OPT_BOOL(0, "reject", &apply_with_reject,
 			N_("leave the rejected hunks in corresponding *.rej files")),
-- 
2.8.1.300.g5fed0c0
