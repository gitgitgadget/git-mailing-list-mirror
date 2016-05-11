From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 15/94] builtin/apply: move 'apply_verbosely' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:26 +0200
Message-ID: <20160511131745.2914-16-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:26:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U9q-00025r-Lc
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbcEKNTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35396 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbcEKNS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:18:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id e201so9401451wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9/CjSG3u7M+24Jkpy0LTtiTDxLyFo7Qq/AUpsiiXBQg=;
        b=lTiv5egg3JeV3HIEZIvJCq8GsfghMgYl9IKQzGlqAyK31ORbyY0eaNCDfH+FITSPNn
         6QW8BLEj77A+ITBHBa1tzTViG2jB1OpFPb2Qk1yM+zIYtV9PnyReRorzaSDvJsOaINLW
         GpYLp5DzuT7z+JsKr/K7uHg/q9p+amWWackascw8doS3GTxGCc8fNTgQIgdyIKGfp+0m
         VpTCB3YVmOn6lMxS5THYORPWihGa1ohIxLQJVrwUdrm84np0nQk/ZLOW2XHW4ascZzrr
         7NeHPMH59m+TPyZBUiLwGtYrRxUWDm/FI4DSwFh/x/rqH1CSAJh0VaR4Fq76sGHS+BCT
         F3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9/CjSG3u7M+24Jkpy0LTtiTDxLyFo7Qq/AUpsiiXBQg=;
        b=ITFxjoBFdVGv6kzRxuXmKMErLlcgBQq+FDTIHDRqmgmIw+5pm43vTFlMAy+fLG6B9x
         QFqTRY/ClqFqKySlB50SI1foKAUdBEnA0vIPgnNcdlsmV2AVebIi50mBvHHlInnVkApo
         P7XJvxjkPiGz2B0X3AVauu/0UpqF+GByLYcR9UcKQwrmGfovOmYFQ3iUl05gPCesC2J+
         ysqZGPr1KmLA8csHDrEPPH7ApDzilqiq3bzmxMqyIwye60VFRI+apDPcYxEpqdl0R/wv
         ACK49u7jVXlnpiejVcOAolQ6ASJqAcW/U4ShLC3jySMX+H4HYvpGq3FVi0Wv4X408OoN
         oDzQ==
X-Gm-Message-State: AOPr4FWEy6dYw+oz89h8q1JYprc0lFgllORJd0tIDsZ2fGVFyc9eJ7kB79vVcbONNgd7DQ==
X-Received: by 10.194.17.106 with SMTP id n10mr3728086wjd.131.1462972736520;
        Wed, 11 May 2016 06:18:56 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:55 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294340>

To libify the apply functionality the 'apply_verbosely' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 53cc280..97af6ea 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -27,6 +27,7 @@ struct apply_state {
 
 	int apply_in_reverse;
 	int apply_with_reject;
+	int apply_verbosely;
 
 	/*
 	 *  --check turns on checking that the working tree matches the
@@ -56,7 +57,6 @@ static int diffstat;
 static int numstat;
 static int summary;
 static int apply = 1;
-static int apply_verbosely;
 static int allow_overlap;
 static int no_add;
 static int threeway;
@@ -2810,7 +2810,7 @@ static int apply_one_fragment(struct apply_state *state,
 			/* Ignore it, we already handled it */
 			break;
 		default:
-			if (apply_verbosely)
+			if (state->apply_verbosely)
 				error(_("invalid start of line: '%c'"), first);
 			applied_pos = -1;
 			goto out;
@@ -2925,7 +2925,7 @@ static int apply_one_fragment(struct apply_state *state,
 				apply = 0;
 		}
 
-		if (apply_verbosely && applied_pos != pos) {
+		if (state->apply_verbosely && applied_pos != pos) {
 			int offset = applied_pos - pos;
 			if (state->apply_in_reverse)
 				offset = 0 - offset;
@@ -2947,7 +2947,7 @@ static int apply_one_fragment(struct apply_state *state,
 				   leading, trailing, applied_pos+1);
 		update_image(img, applied_pos, &preimage, &postimage);
 	} else {
-		if (apply_verbosely)
+		if (state->apply_verbosely)
 			error(_("while searching for:\n%.*s"),
 			      (int)(old - oldlines), oldlines);
 	}
@@ -3861,7 +3861,7 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 	prepare_symlink_changes(patch);
 	prepare_fn_table(patch);
 	while (patch) {
-		if (apply_verbosely)
+		if (state->apply_verbosely)
 			say_patch_name(stderr,
 				       _("Checking patch %s..."), patch);
 		err |= check_patch(state, patch);
@@ -4292,7 +4292,7 @@ static void write_out_one_result(struct patch *patch, int phase)
 		create_file(patch);
 }
 
-static int write_out_one_reject(struct patch *patch)
+static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 {
 	FILE *rej;
 	char namebuf[PATH_MAX];
@@ -4307,7 +4307,7 @@ static int write_out_one_reject(struct patch *patch)
 	}
 
 	if (!cnt) {
-		if (apply_verbosely)
+		if (state->apply_verbosely)
 			say_patch_name(stderr,
 				       _("Applied patch %s cleanly."), patch);
 		return 0;
@@ -4363,7 +4363,7 @@ static int write_out_one_reject(struct patch *patch)
 	return -1;
 }
 
-static int write_out_results(struct patch *list)
+static int write_out_results(struct apply_state *state, struct patch *list)
 {
 	int phase;
 	int errs = 0;
@@ -4378,7 +4378,7 @@ static int write_out_results(struct patch *list)
 			else {
 				write_out_one_result(l, phase);
 				if (phase == 1) {
-					if (write_out_one_reject(l))
+					if (write_out_one_reject(state, l))
 						errs = 1;
 					if (l->conflicted_threeway) {
 						string_list_append(&cpath, l->new_name);
@@ -4442,7 +4442,7 @@ static int apply_patch(struct apply_state *state,
 			listp = &patch->next;
 		}
 		else {
-			if (apply_verbosely)
+			if (state->apply_verbosely)
 				say_patch_name(stderr, _("Skipped patch '%s'."), patch);
 			free_patch(patch);
 			skipped_patch++;
@@ -4470,7 +4470,7 @@ static int apply_patch(struct apply_state *state,
 	    !state->apply_with_reject)
 		exit(1);
 
-	if (apply && write_out_results(list)) {
+	if (apply && write_out_results(state, list)) {
 		if (state->apply_with_reject)
 			exit(1);
 		/* with --3way, we still need to write the index out */
@@ -4635,7 +4635,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("leave the rejected hunks in corresponding *.rej files")),
 		OPT_BOOL(0, "allow-overlap", &allow_overlap,
 			N_("allow overlapping hunks")),
-		OPT__VERBOSE(&apply_verbosely, N_("be verbose")),
+		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
 			N_("tolerate incorrectly detected missing new-line at the end of file"),
 			INACCURATE_EOF),
@@ -4663,7 +4663,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		state.check_index = 1;
 	}
 	if (state.apply_with_reject)
-		apply = apply_verbosely = 1;
+		apply = state.apply_verbosely = 1;
 	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
-- 
2.8.2.490.g3dabe57
