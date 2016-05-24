From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 15/49] builtin/apply: move 'apply_verbosely' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:10:52 +0200
Message-ID: <20160524081126.16973-16-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:15:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57VD-00022h-KP
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbcEXIMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36083 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273AbcEXIMI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id q62so3636761wmg.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SH1fBb14gEoMaGqCVgSzryDScUGyDrAMqwI0ok4K0y4=;
        b=WfUlo/vgNogRBknTPMwXYujqKvZ22fH7TqzIWqViQS4UzVoSr4hcvKwmxYUHupBz10
         3K6uBZLa7QxOP5Xy+Sq0ZQfXRRa4yp8b7w2csVX0BOh0qPhlfUaU/N/R8YYuthoIpq3d
         y5V3pWmC1wKh4MJ/ulFF5KkVmjXzbe/Me8zhNjQj+kkRKnMWEQJfdopKVRwxsZNX0apo
         vC0NhUH5kE4mfberLvc1YOX0WPeNPX2XSt1IKrXOx3nWzNoBKiTK5zQz56K1/po3MeP/
         z5c5M/AAWgh16/KieSxMyo2RJtlZrX0R4QcelJvgYqjbNjipz0af1IbEBqj/VuHtX/tp
         AhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SH1fBb14gEoMaGqCVgSzryDScUGyDrAMqwI0ok4K0y4=;
        b=YvsdvRD9mfgLjLubUQ1xITIvLEEIHvxam+z6G8Ks4Y+1DU9I+JWtr5mRFq56h/bopr
         70uqIWQ23Z0RMpHCdp2QFkKxVDHxn2FRJp0ZH5he282GsfYItFnOm2+EkhVwAsYjPJ6A
         GSKD7QFW/ZHX+KyNq5wzIY1RNPpuMJVbxyAc3TXoX5hrxNN1ot7++O0amvBfX17PASQy
         KSifXqtYozWEqsXiLQ1paeI0oM0qwlDzzAHLQEqlOC5mYTjkGs778hFjbfAIg3McurPM
         jD06H06gm6hCMkj3kyJ5cX2vvNZ6T8pkIRwegLe25sTgYdmCZ9UstmtdJQnDe77ivHHO
         FApw==
X-Gm-Message-State: AOPr4FV60KiFfGe2KfjXnKiRXS+Sh2llO9YmWTxwnlaoRKLeLMcIyOmrfTntvp+Lp8wAMg==
X-Received: by 10.28.20.144 with SMTP id 138mr21583082wmu.103.1464077527002;
        Tue, 24 May 2016 01:12:07 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:06 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295466>

To libify the apply functionality the 'apply_verbosely' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8692e2f..07dc89d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -32,6 +32,7 @@ struct apply_state {
 	/* These boolean parameters control how the apply is done */
 	int apply_in_reverse;
 	int apply_with_reject;
+	int apply_verbosely;
 	int unidiff_zero;
 };
 
@@ -51,7 +52,6 @@ static int diffstat;
 static int numstat;
 static int summary;
 static int apply = 1;
-static int apply_verbosely;
 static int allow_overlap;
 static int no_add;
 static int threeway;
@@ -2805,7 +2805,7 @@ static int apply_one_fragment(struct apply_state *state,
 			/* Ignore it, we already handled it */
 			break;
 		default:
-			if (apply_verbosely)
+			if (state->apply_verbosely)
 				error(_("invalid start of line: '%c'"), first);
 			applied_pos = -1;
 			goto out;
@@ -2920,7 +2920,7 @@ static int apply_one_fragment(struct apply_state *state,
 				apply = 0;
 		}
 
-		if (apply_verbosely && applied_pos != pos) {
+		if (state->apply_verbosely && applied_pos != pos) {
 			int offset = applied_pos - pos;
 			if (state->apply_in_reverse)
 				offset = 0 - offset;
@@ -2942,7 +2942,7 @@ static int apply_one_fragment(struct apply_state *state,
 				   leading, trailing, applied_pos+1);
 		update_image(img, applied_pos, &preimage, &postimage);
 	} else {
-		if (apply_verbosely)
+		if (state->apply_verbosely)
 			error(_("while searching for:\n%.*s"),
 			      (int)(old - oldlines), oldlines);
 	}
@@ -3856,7 +3856,7 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 	prepare_symlink_changes(patch);
 	prepare_fn_table(patch);
 	while (patch) {
-		if (apply_verbosely)
+		if (state->apply_verbosely)
 			say_patch_name(stderr,
 				       _("Checking patch %s..."), patch);
 		err |= check_patch(state, patch);
@@ -4287,7 +4287,7 @@ static void write_out_one_result(struct patch *patch, int phase)
 		create_file(patch);
 }
 
-static int write_out_one_reject(struct patch *patch)
+static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 {
 	FILE *rej;
 	char namebuf[PATH_MAX];
@@ -4302,7 +4302,7 @@ static int write_out_one_reject(struct patch *patch)
 	}
 
 	if (!cnt) {
-		if (apply_verbosely)
+		if (state->apply_verbosely)
 			say_patch_name(stderr,
 				       _("Applied patch %s cleanly."), patch);
 		return 0;
@@ -4358,7 +4358,7 @@ static int write_out_one_reject(struct patch *patch)
 	return -1;
 }
 
-static int write_out_results(struct patch *list)
+static int write_out_results(struct apply_state *state, struct patch *list)
 {
 	int phase;
 	int errs = 0;
@@ -4373,7 +4373,7 @@ static int write_out_results(struct patch *list)
 			else {
 				write_out_one_result(l, phase);
 				if (phase == 1) {
-					if (write_out_one_reject(l))
+					if (write_out_one_reject(state, l))
 						errs = 1;
 					if (l->conflicted_threeway) {
 						string_list_append(&cpath, l->new_name);
@@ -4437,7 +4437,7 @@ static int apply_patch(struct apply_state *state,
 			listp = &patch->next;
 		}
 		else {
-			if (apply_verbosely)
+			if (state->apply_verbosely)
 				say_patch_name(stderr, _("Skipped patch '%s'."), patch);
 			free_patch(patch);
 			skipped_patch++;
@@ -4465,7 +4465,7 @@ static int apply_patch(struct apply_state *state,
 	    !state->apply_with_reject)
 		exit(1);
 
-	if (apply && write_out_results(list)) {
+	if (apply && write_out_results(state, list)) {
 		if (state->apply_with_reject)
 			exit(1);
 		/* with --3way, we still need to write the index out */
@@ -4635,7 +4635,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			N_("leave the rejected hunks in corresponding *.rej files")),
 		OPT_BOOL(0, "allow-overlap", &allow_overlap,
 			N_("allow overlapping hunks")),
-		OPT__VERBOSE(&apply_verbosely, N_("be verbose")),
+		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
 			N_("tolerate incorrectly detected missing new-line at the end of file"),
 			INACCURATE_EOF),
@@ -4663,7 +4663,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		state.check_index = 1;
 	}
 	if (state.apply_with_reject)
-		apply = apply_verbosely = 1;
+		apply = state.apply_verbosely = 1;
 	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
-- 
2.8.3.443.gaeee61e
