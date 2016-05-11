From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 10/94] builtin/apply: move 'unidiff_zero' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:21 +0200
Message-ID: <20160511131745.2914-11-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:18:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U2R-0001rb-7w
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbcEKNSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:18:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36268 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbcEKNSr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:18:47 -0400
Received: by mail-wm0-f68.google.com with SMTP id w143so9342763wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NC+rBVhVemn0A9Zl9sVOKVtpyKOBZH06NRvjsb9j3ko=;
        b=RX7VQPBUtonzWtdDAqT/Sw8Co/AS9Ee/a1PFkqEgHHWwgUi4adIPdTn32csWfd2iNr
         45jK/J0SR2GSNN+i9DNH1mWZJLTN6sysCJ+8vrPDnwKcRsdcXc3LG5fspymtDB5ldUSz
         EYZTJlrrvPrqjlbaAR4z3Rx8V87TvKQdZAIC/0saSBU/m1FT0ert13bzX1Nmi8UnJ0r/
         y/K5KsUtstG1s0kZ8omrNsU/7ARzvVmvfUzfRz/AuR8s61Lp81kMEdWVpBNk4jTA9ykg
         dtGZzcwj7pW8ru5oTOd1XyYjsmPOat8ZIOn6CFYiydSG0aCkFxLsUclt01pp89bnmK5f
         tTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NC+rBVhVemn0A9Zl9sVOKVtpyKOBZH06NRvjsb9j3ko=;
        b=ePfHHDaH/JKTbv6W3FHdM3IduNk9tA9JezA89jfbPYuQfLXSdfP3jirz/9h2d7y4oy
         J8qkjQvpYbCVkM9XTmvChMEywVyrm/K9R1o/x9O1XM8g5653HJidybvUUGWptSISdYbK
         TUx3lp9iAuMSJ4nak0FP/Rb7323GKDp8Ok6eI47ppLuTviEjLa31kBC3TmD0fjD1lHvZ
         h/DPq9DoDZVPfjiY7oawmVbRSRNSiT8y2YlIPVcyrFcZMm/0ZBbQSuW+P0XJiwG5TdlG
         AtAxCpUkrAul+fnfLpFi39pNREDhZAjFQAkYk6tyohFGKblw+wfOl8katjQ0N0OFpjC9
         KtwA==
X-Gm-Message-State: AOPr4FUyrQta4r4viVK5z6RNaXpuj25WazEotkeQ9i56idAhTOuJKuY2biKGmpoZMgARoQ==
X-Received: by 10.28.35.201 with SMTP id j192mr87638wmj.18.1462972726236;
        Wed, 11 May 2016 06:18:46 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:45 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294255>

To libify the apply functionality the 'unidiff_zero' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e133033..44ae95d 100644
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
@@ -2694,7 +2695,8 @@ static void update_image(struct image *img,
  * postimage) for the hunk.  Find lines that match "preimage" in "img" and
  * replace the part of "img" with "postimage" text.
  */
-static int apply_one_fragment(struct image *img, struct fragment *frag,
+static int apply_one_fragment(struct apply_state *state,
+			      struct image *img, struct fragment *frag,
 			      int inaccurate_eof, unsigned ws_rule,
 			      int nth_fragment)
 {
@@ -2836,7 +2838,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	 * without leading context must match at the beginning.
 	 */
 	match_beginning = (!frag->oldpos ||
-			   (frag->oldpos == 1 && !unidiff_zero));
+			   (frag->oldpos == 1 && !state->unidiff_zero));
 
 	/*
 	 * A hunk without trailing lines must match at the end.
@@ -2844,7 +2846,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	 * from the lack of trailing lines if the patch was generated
 	 * with unidiff without any context.
 	 */
-	match_end = !unidiff_zero && !trailing;
+	match_end = !state->unidiff_zero && !trailing;
 
 	pos = frag->newpos ? (frag->newpos - 1) : 0;
 	preimage.buf = oldlines;
@@ -3067,7 +3069,7 @@ static int apply_binary(struct image *img, struct patch *patch)
 	return 0;
 }
 
-static int apply_fragments(struct image *img, struct patch *patch)
+static int apply_fragments(struct apply_state *state, struct image *img, struct patch *patch)
 {
 	struct fragment *frag = patch->fragments;
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
@@ -3080,7 +3082,7 @@ static int apply_fragments(struct image *img, struct patch *patch)
 
 	while (frag) {
 		nth++;
-		if (apply_one_fragment(img, frag, inaccurate_eof, ws_rule, nth)) {
+		if (apply_one_fragment(state, img, frag, inaccurate_eof, ws_rule, nth)) {
 			error(_("patch failed: %s:%ld"), name, frag->oldpos);
 			if (!apply_with_reject)
 				return -1;
@@ -3388,8 +3390,11 @@ static int load_current(struct image *image, struct patch *patch)
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
@@ -3415,7 +3420,7 @@ static int try_threeway(struct image *image, struct patch *patch,
 	img = strbuf_detach(&buf, &len);
 	prepare_image(&tmp_image, img, len, 1);
 	/* Apply the patch to get the post image */
-	if (apply_fragments(&tmp_image, patch) < 0) {
+	if (apply_fragments(state, &tmp_image, patch) < 0) {
 		clear_image(&tmp_image);
 		return -1;
 	}
@@ -3459,7 +3464,8 @@ static int try_threeway(struct image *image, struct patch *patch,
 	return 0;
 }
 
-static int apply_data(struct patch *patch, struct stat *st, const struct cache_entry *ce)
+static int apply_data(struct apply_state *state, struct patch *patch,
+		      struct stat *st, const struct cache_entry *ce)
 {
 	struct image image;
 
@@ -3467,9 +3473,9 @@ static int apply_data(struct patch *patch, struct stat *st, const struct cache_e
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
@@ -3717,7 +3723,7 @@ static void die_on_unsafe_path(struct patch *patch)
  * Check and apply the patch in-core; leave the result in patch->result
  * for the caller to write it out to the final destination.
  */
-static int check_patch(struct patch *patch)
+static int check_patch(struct apply_state *state, struct patch *patch)
 {
 	struct stat st;
 	const char *old_name = patch->old_name;
@@ -3816,13 +3822,13 @@ static int check_patch(struct patch *patch)
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
 
@@ -3832,7 +3838,7 @@ static int check_patch_list(struct patch *patch)
 		if (apply_verbosely)
 			say_patch_name(stderr,
 				       _("Checking patch %s..."), patch);
-		err |= check_patch(patch);
+		err |= check_patch(state, patch);
 		patch = patch->next;
 	}
 	return err;
@@ -4434,7 +4440,7 @@ static int apply_patch(struct apply_state *state,
 	}
 
 	if ((check || apply) &&
-	    check_patch_list(list) < 0 &&
+	    check_patch_list(state, list) < 0 &&
 	    !apply_with_reject)
 		exit(1);
 
@@ -4597,7 +4603,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			PARSE_OPT_NOARG, option_parse_space_change },
 		OPT_BOOL('R', "reverse", &apply_in_reverse,
 			N_("apply the patch in reverse")),
-		OPT_BOOL(0, "unidiff-zero", &unidiff_zero,
+		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
 			N_("don't expect at least one line of context")),
 		OPT_BOOL(0, "reject", &apply_with_reject,
 			N_("leave the rejected hunks in corresponding *.rej files")),
-- 
2.8.2.490.g3dabe57
