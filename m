From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 35/44] apply: add 'be_silent' variable to 'struct apply_state'
Date: Fri, 10 Jun 2016 22:11:09 +0200
Message-ID: <20160610201118.13813-36-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnP-0003kw-Pd
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbcFJUMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34570 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbcFJUMk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id n184so1058022wmn.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HQj9h6Dfus04QSjot4rn0GIR9X+2N87431Q2c6WMPx4=;
        b=lP0WTx8rfLt8D+wd4mPnpn4oN4uMtftMtPrFFYuhZXclGUYnWVc1jgyGVayy+8q/GN
         Qip468IN8pq53yujnpxMJchximAeEhz51ifHm7VoIgUdnBlonfBGsz3BarVB86DLbB2N
         b62miDop5m/t8qTGpv70DZX9HGyFWoo5apj2EHgZij+W5gxXSbon2OMk1kWQv/yhBAia
         4Z4I/BtdTFySJfyy7qLgOB6jusuu0nf5tZk8VqCD5nUpQi3PdrkUwfkRLxB9bZqweZAD
         2hD+cJyaAlvtUYORsqy8gJxVjGXF/wB/pNKrsCebaC2ukVTGMrDC+7WaGUOUqyEdbxBi
         si9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HQj9h6Dfus04QSjot4rn0GIR9X+2N87431Q2c6WMPx4=;
        b=fQROdvdZw9sGQdr7lXxLPnO5k9V6NUoIphu3coYtGY4WetyL9tY649v1yarkxCWRn+
         +qUvN0hngLBbLDXZWTamXc1oHBqDUmcjJ4gxIgjQoPkgXdnOrU96NdLOhDG44F09DI9g
         S1zonV9Blchpm7UVSOOsOgYjFQEb2kCSPEX1NqpOf8A1/H+l52qfVXdLmO3c4g4RFArJ
         DGWKkNNsjaCFprrdg/vVycEb2FzUN0r7Abvp9pmq3Pa5sWTwWTPpy4EQLAMS2aGegzkF
         PWEfA0om5zxYGDgVVOkYYC33bVRAAuBSMKKA4EaZRncJ17thOxAJPeMEyDUSIxXuXb0+
         rOeA==
X-Gm-Message-State: ALyK8tL2dSWYeJDA5M2scQ0kBZ3Z2ZPX1rx8+OPTdAHaVEUQKNMsXXcC2tP6u272+W8/uA==
X-Received: by 10.194.146.180 with SMTP id td20mr3566223wjb.86.1465589558923;
        Fri, 10 Jun 2016 13:12:38 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:37 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297043>

This variable should prevent anything to be printed on both stderr
and stdout.

Let's not take care of stdout and apply_verbosely for now though,
as that will be taken care of in following patches.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 43 +++++++++++++++++++++++++++++--------------
 apply.h |  1 +
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/apply.c b/apply.c
index 713d1c0..dbb2515 100644
--- a/apply.c
+++ b/apply.c
@@ -1612,8 +1612,9 @@ static void record_ws_error(struct apply_state *state,
 		return;
 
 	err = whitespace_error_string(result);
-	fprintf(stderr, "%s:%d: %s.\n%.*s\n",
-		state->patch_input_file, linenr, err, len, line);
+	if (!state->be_silent)
+		fprintf(stderr, "%s:%d: %s.\n%.*s\n",
+			state->patch_input_file, linenr, err, len, line);
 	free(err);
 }
 
@@ -1808,7 +1809,7 @@ static int parse_single_patch(struct apply_state *state,
 		return error(_("new file %s depends on old contents"), patch->new_name);
 	if (0 < patch->is_delete && newlines)
 		return error(_("deleted file %s still has contents"), patch->old_name);
-	if (!patch->is_delete && !newlines && context)
+	if (!patch->is_delete && !newlines && context && !state->be_silent)
 		fprintf_ln(stderr,
 			   _("** warning: "
 			     "file %s becomes empty but is not deleted"),
@@ -3031,8 +3032,8 @@ static int apply_one_fragment(struct apply_state *state,
 		 * Warn if it was necessary to reduce the number
 		 * of context lines.
 		 */
-		if ((leading != frag->leading) ||
-		    (trailing != frag->trailing))
+		if ((leading != frag->leading ||
+		     trailing != frag->trailing) && !state->be_silent)
 			fprintf_ln(stderr, _("Context reduced to (%ld/%ld)"
 					     " to apply fragment at %d"),
 				   leading, trailing, applied_pos+1);
@@ -3529,7 +3530,8 @@ static int try_threeway(struct apply_state *state,
 		 read_blob_object(&buf, pre_sha1, patch->old_mode))
 		return error("repository lacks the necessary blob to fall back on 3-way merge.");
 
-	fprintf(stderr, "Falling back to three-way merge...\n");
+	if (!state->be_silent)
+		fprintf(stderr, "Falling back to three-way merge...\n");
 
 	img = strbuf_detach(&buf, &len);
 	prepare_image(&tmp_image, img, len, 1);
@@ -3559,7 +3561,9 @@ static int try_threeway(struct apply_state *state,
 	status = three_way_merge(image, patch->new_name,
 				 pre_sha1, our_sha1, post_sha1);
 	if (status < 0) {
-		fprintf(stderr, "Failed to fall back on three-way merge...\n");
+		if (!state->be_silent)
+			fprintf(stderr,
+				"Failed to fall back on three-way merge...\n");
 		return status;
 	}
 
@@ -3571,9 +3575,15 @@ static int try_threeway(struct apply_state *state,
 			hashcpy(patch->threeway_stage[0].hash, pre_sha1);
 		hashcpy(patch->threeway_stage[1].hash, our_sha1);
 		hashcpy(patch->threeway_stage[2].hash, post_sha1);
-		fprintf(stderr, "Applied patch to '%s' with conflicts.\n", patch->new_name);
+		if (!state->be_silent)
+			fprintf(stderr,
+				"Applied patch to '%s' with conflicts.\n",
+				patch->new_name);
 	} else {
-		fprintf(stderr, "Applied patch to '%s' cleanly.\n", patch->new_name);
+		if (!state->be_silent)
+			fprintf(stderr,
+				"Applied patch to '%s' cleanly.\n",
+				patch->new_name);
 	}
 	return 0;
 }
@@ -4472,7 +4482,8 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 			    "Applying patch %%s with %d rejects...",
 			    cnt),
 		    cnt);
-	say_patch_name(stderr, sb.buf, patch);
+	if (!state->be_silent)
+		say_patch_name(stderr, sb.buf, patch);
 	strbuf_release(&sb);
 
 	cnt = strlen(patch->new_name);
@@ -4499,10 +4510,12 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 	     frag;
 	     cnt++, frag = frag->next) {
 		if (!frag->rejected) {
-			fprintf_ln(stderr, _("Hunk #%d applied cleanly."), cnt);
+			if (!state->be_silent)
+				fprintf_ln(stderr, _("Hunk #%d applied cleanly."), cnt);
 			continue;
 		}
-		fprintf_ln(stderr, _("Rejected hunk #%d."), cnt);
+		if (!state->be_silent)
+			fprintf_ln(stderr, _("Rejected hunk #%d."), cnt);
 		fprintf(rej, "%.*s", frag->size, frag->patch);
 		if (frag->patch[frag->size-1] != '\n')
 			fputc('\n', rej);
@@ -4551,8 +4564,10 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 		struct string_list_item *item;
 
 		string_list_sort(&cpath);
-		for_each_string_list_item(item, &cpath)
-			fprintf(stderr, "U %s\n", item->string);
+		if (!state->be_silent) {
+			for_each_string_list_item(item, &cpath)
+				fprintf(stderr, "U %s\n", item->string);
+		}
 		string_list_clear(&cpath, 0);
 
 		rerere(0);
diff --git a/apply.h b/apply.h
index 89e7982..034541a 100644
--- a/apply.h
+++ b/apply.h
@@ -52,6 +52,7 @@ struct apply_state {
 	int apply_in_reverse;
 	int apply_with_reject;
 	int apply_verbosely;
+	int be_silent;
 	int no_add;
 	int threeway;
 	int unidiff_zero;
-- 
2.9.0.rc2.362.g3cd93d0
