From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 08/48] builtin/apply: move 'unidiff_zero' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:36 +0100
Message-ID: <1457545756-20616-9-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHl-0007er-3Q
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933688AbcCIRw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:27 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34577 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933669AbcCIRwW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:22 -0500
Received: by mail-wm0-f49.google.com with SMTP id p65so203101767wmp.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QyxXAkDmuOb94zZ4Pj199q91BZkETV31uCzULpp/RvI=;
        b=QIC0KGCuksM40RbzTpp+8xvBA3jlzYLpDdnI/VH9V5BZWAuChYtGajl7Wp9N4r1opG
         lWpx431Yk2S5WOSqBg4urU0p8tOcaSP9vjWnySO4cICZxGZbnWmbPgXabcp1OSKPc0Cr
         eOBDFUyTNdxlemqVisw9XO7uHIrH3N7UK7+z8N+CKDtmGrQaItMu8XAPJiRU7QSeit8f
         QZwbcPcWQ42ZKfdMFlZwj+Y9x0ngEAzh/DG+3pbYf+C9bpwcQTbCUv7472t0H/ok8yGm
         jHjrL7BWf7h+cl45qzV43r+DhkmncNMANiiHebqx87ZlznQObyIpspWzPgR7gMwd+YzB
         2MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QyxXAkDmuOb94zZ4Pj199q91BZkETV31uCzULpp/RvI=;
        b=BQTGRlw4feOaKHk4HY2Ooom555cHWgt66Ty8LHYVh3gFS1Q1CdJGtvzsdjQ4xO+Cft
         PUEt2CGVxMhWRdnQx0duBgnCK9TANXze5vFvNEe0W5mr/+e/18NAVKLo5eRcHmwFuOuS
         O9BpODxMneyUKkbRCv37Jkk78BfaeaRR4sFr3fafUr8gTQzL0TxHlvZ48s5sSNVPxQKk
         IWbAH7gpDW3lXjenHacmF+RwnST2v+hE2MTdy5bEH/SmNAjQbz346dPhT3moLy1bRNsx
         X4JT+iIMZ3io/hmsJs28oHIiBlV/Sflh26MiFZWmGxTXAxOoxbxknhwnpbUI6AaUydMA
         MHww==
X-Gm-Message-State: AD7BkJKyy/AFzai5tTC1pyDypQwmxMvEK7iTCgPVMjApuhfGx3NDRG/WNasiTHKrettxLw==
X-Received: by 10.194.71.70 with SMTP id s6mr36583567wju.1.1457545940175;
        Wed, 09 Mar 2016 09:52:20 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:19 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288497>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d56dd9f..d5bc30f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -25,6 +25,8 @@ struct apply_state {
 	const char *prefix;
 	int prefix_length;
 	int newfd;
+
+	int unidiff_zero;
 };
 
 /*
@@ -37,7 +39,6 @@ struct apply_state {
  *  --cached updates only the cache without ever touching the working tree.
  */
 
-static int unidiff_zero;
 static int p_value = 1;
 static int p_value_known;
 static int check_index;
@@ -2698,7 +2699,8 @@ static void update_image(struct image *img,
  * postimage) for the hunk.  Find lines that match "preimage" in "img" and
  * replace the part of "img" with "postimage" text.
  */
-static int apply_one_fragment(struct image *img, struct fragment *frag,
+static int apply_one_fragment(struct apply_state *state,
+			      struct image *img, struct fragment *frag,
 			      int inaccurate_eof, unsigned ws_rule,
 			      int nth_fragment)
 {
@@ -2840,7 +2842,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	 * without leading context must match at the beginning.
 	 */
 	match_beginning = (!frag->oldpos ||
-			   (frag->oldpos == 1 && !unidiff_zero));
+			   (frag->oldpos == 1 && !state->unidiff_zero));
 
 	/*
 	 * A hunk without trailing lines must match at the end.
@@ -2848,7 +2850,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	 * from the lack of trailing lines if the patch was generated
 	 * with unidiff without any context.
 	 */
-	match_end = !unidiff_zero && !trailing;
+	match_end = !state->unidiff_zero && !trailing;
 
 	pos = frag->newpos ? (frag->newpos - 1) : 0;
 	preimage.buf = oldlines;
@@ -3071,7 +3073,7 @@ static int apply_binary(struct image *img, struct patch *patch)
 	return 0;
 }
 
-static int apply_fragments(struct image *img, struct patch *patch)
+static int apply_fragments(struct apply_state *state, struct image *img, struct patch *patch)
 {
 	struct fragment *frag = patch->fragments;
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
@@ -3084,7 +3086,7 @@ static int apply_fragments(struct image *img, struct patch *patch)
 
 	while (frag) {
 		nth++;
-		if (apply_one_fragment(img, frag, inaccurate_eof, ws_rule, nth)) {
+		if (apply_one_fragment(state, img, frag, inaccurate_eof, ws_rule, nth)) {
 			error(_("patch failed: %s:%ld"), name, frag->oldpos);
 			if (!apply_with_reject)
 				return -1;
@@ -3392,8 +3394,11 @@ static int load_current(struct image *image, struct patch *patch)
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
@@ -3419,7 +3424,7 @@ static int try_threeway(struct image *image, struct patch *patch,
 	img = strbuf_detach(&buf, &len);
 	prepare_image(&tmp_image, img, len, 1);
 	/* Apply the patch to get the post image */
-	if (apply_fragments(&tmp_image, patch) < 0) {
+	if (apply_fragments(state, &tmp_image, patch) < 0) {
 		clear_image(&tmp_image);
 		return -1;
 	}
@@ -3463,7 +3468,8 @@ static int try_threeway(struct image *image, struct patch *patch,
 	return 0;
 }
 
-static int apply_data(struct patch *patch, struct stat *st, const struct cache_entry *ce)
+static int apply_data(struct apply_state *state, struct patch *patch,
+		      struct stat *st, const struct cache_entry *ce)
 {
 	struct image image;
 
@@ -3471,9 +3477,9 @@ static int apply_data(struct patch *patch, struct stat *st, const struct cache_e
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
@@ -3721,7 +3727,7 @@ static void die_on_unsafe_path(struct patch *patch)
  * Check and apply the patch in-core; leave the result in patch->result
  * for the caller to write it out to the final destination.
  */
-static int check_patch(struct patch *patch)
+static int check_patch(struct apply_state *state, struct patch *patch)
 {
 	struct stat st;
 	const char *old_name = patch->old_name;
@@ -3820,13 +3826,13 @@ static int check_patch(struct patch *patch)
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
 
@@ -3836,7 +3842,7 @@ static int check_patch_list(struct patch *patch)
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
 
@@ -4583,7 +4589,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			PARSE_OPT_NOARG, option_parse_space_change },
 		OPT_BOOL('R', "reverse", &apply_in_reverse,
 			N_("apply the patch in reverse")),
-		OPT_BOOL(0, "unidiff-zero", &unidiff_zero,
+		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
 			N_("don't expect at least one line of context")),
 		OPT_BOOL(0, "reject", &apply_with_reject,
 			N_("leave the rejected hunks in corresponding *.rej files")),
-- 
2.8.0.rc1.49.gca61272
