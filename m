From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 86/94] apply: add 'be_silent' variable to 'struct apply_state'
Date: Wed, 11 May 2016 15:17:37 +0200
Message-ID: <20160511131745.2914-87-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:21:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U51-0004sl-Ne
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbcEKNVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34179 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932369AbcEKNV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so9424624wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7DBc9Md4dcIfJ8fzDbDz0N8hqctCFurEdD8UukAEhp4=;
        b=rI4SFG69LuuhO4d175hD4I1hRh9+V5TVWVqWuQWZfh67fitAcB0FXufQeKC2fwqiB5
         MYrF+2OxJnrmIVnIOUoY/YXF11vknLBRZIIxp1U8WMyC3UWy6rezUgNh/aU1wJVcyVGC
         4PU2kCLIN9NBnM5PhepxM1mScUR3grbHf2oh+Jq1FG9DZw0ULH2zuIctJxFBVzFWOpM9
         ZPNKdz8dgmpGBp/aP0CnZHuEc6DNLYP+qwDfGX77bvAMSHEwo0PYAefJZuT5pQv2bhvU
         KBeMwsKjBlwO4FJLGFnlg7aJgKO9qzRsFTpKOpu+yHl4qmbdJ42693RPZbEi+wTmMHXC
         HacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7DBc9Md4dcIfJ8fzDbDz0N8hqctCFurEdD8UukAEhp4=;
        b=gIKrRcSbu/qX0qsi4JXAn77r4buU7udlvw9IUCG6oBRPKKhWbIIPTgVAHLJhkE4Umz
         7aZr4Rf6kJpINMLirUaepzQKRaxtRhG7SPK8W711IL/ekRy2JrMbPtbarVBJhZY5i+XS
         LGMN2yQU7CS40BITy1Rce2ILxBROyOHhISMLmSjyqeFZX/K2HbRRhE3TEyJH+fOll79/
         OsAxUAsq5D8WwdLgcoF0BRWsbLr/2a8DmCTpTmmfBkac42wGdJG9vddvZ0gxn+UH6aap
         Y1PZZ2LCpm2fbrLh6XVzeGKv/nvJ3pPs2TjBsunw4cG8/OTTBNdQt8gn8y7r1us3Apmv
         gg0g==
X-Gm-Message-State: AOPr4FWXA2fH8p6yk4mpqiuk62s1YfsSA17IwDnprkwb5/haWLmoMZO/v0EB9Q6rEMSkIA==
X-Received: by 10.28.229.68 with SMTP id c65mr29926wmh.77.1462972884958;
        Wed, 11 May 2016 06:21:24 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:23 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294300>

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
index 7480ae8..f69a61a 100644
--- a/apply.c
+++ b/apply.c
@@ -1600,8 +1600,9 @@ static void record_ws_error(struct apply_state *state,
 		return;
 
 	err = whitespace_error_string(result);
-	fprintf(stderr, "%s:%d: %s.\n%.*s\n",
-		state->patch_input_file, linenr, err, len, line);
+	if (!state->be_silent)
+		fprintf(stderr, "%s:%d: %s.\n%.*s\n",
+			state->patch_input_file, linenr, err, len, line);
 	free(err);
 }
 
@@ -1796,7 +1797,7 @@ static int parse_single_patch(struct apply_state *state,
 		return error(_("new file %s depends on old contents"), patch->new_name);
 	if (0 < patch->is_delete && newlines)
 		return error(_("deleted file %s still has contents"), patch->old_name);
-	if (!patch->is_delete && !newlines && context)
+	if (!patch->is_delete && !newlines && context && !state->be_silent)
 		fprintf_ln(stderr,
 			   _("** warning: "
 			     "file %s becomes empty but is not deleted"),
@@ -3020,8 +3021,8 @@ static int apply_one_fragment(struct apply_state *state,
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
@@ -3518,7 +3519,8 @@ static int try_threeway(struct apply_state *state,
 		 read_blob_object(&buf, pre_sha1, patch->old_mode))
 		return error("repository lacks the necessary blob to fall back on 3-way merge.");
 
-	fprintf(stderr, "Falling back to three-way merge...\n");
+	if (!state->be_silent)
+		fprintf(stderr, "Falling back to three-way merge...\n");
 
 	img = strbuf_detach(&buf, &len);
 	prepare_image(&tmp_image, img, len, 1);
@@ -3548,7 +3550,9 @@ static int try_threeway(struct apply_state *state,
 	status = three_way_merge(image, patch->new_name,
 				 pre_sha1, our_sha1, post_sha1);
 	if (status < 0) {
-		fprintf(stderr, "Failed to fall back on three-way merge...\n");
+		if (!state->be_silent)
+			fprintf(stderr,
+				"Failed to fall back on three-way merge...\n");
 		return status;
 	}
 
@@ -3560,9 +3564,15 @@ static int try_threeway(struct apply_state *state,
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
@@ -4461,7 +4471,8 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 			    "Applying patch %%s with %d rejects...",
 			    cnt),
 		    cnt);
-	say_patch_name(stderr, sb.buf, patch);
+	if (!state->be_silent)
+		say_patch_name(stderr, sb.buf, patch);
 	strbuf_release(&sb);
 
 	cnt = strlen(patch->new_name);
@@ -4488,10 +4499,12 @@ static int write_out_one_reject(struct apply_state *state, struct patch *patch)
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
@@ -4540,8 +4553,10 @@ static int write_out_results(struct apply_state *state, struct patch *list)
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
index 27b26a2..2dd3706 100644
--- a/apply.h
+++ b/apply.h
@@ -44,6 +44,7 @@ struct apply_state {
 	int apply_in_reverse;
 	int apply_with_reject;
 	int apply_verbosely;
+	int be_silent;
 
 	/* --cached updates only the cache without ever touching the working tree. */
 	int cached;
-- 
2.8.2.490.g3dabe57
