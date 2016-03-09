From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 13/48] builtin/apply: move 'apply_verbosely' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:41 +0100
Message-ID: <1457545756-20616-14-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHt-0007jf-IH
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933703AbcCIRwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:40 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34779 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933697AbcCIRwg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:36 -0500
Received: by mail-wm0-f44.google.com with SMTP id p65so203109834wmp.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4EItYdQHSEp++oOsPSDXKPyH/TL1/CRUmoaJf0o6HlY=;
        b=zjg8GavHkpLLoJJGViNgfIj5hHCkUlUM9igsTU1R+kN2b3iBTCTrDmBhmc+YxSQR7L
         zbz6MhfdaGaRcjEPSxV7T6/mRuaksoyP95mC6M/ZfS4DYrlKEY+v9Fs+DtykaBFQ14Hl
         pSQ1xiPvgI4a7Vsvvy/hYR1pL6QZEdcmgSSX9RLcZcZRGpm5AV+r8pIc3SfgzNxwomm6
         kja1NWqjC7Z/B5VxUtOMuXk2Jad/KsqbLdJmCKyL8Mk/DcmHmOh+vvQqOK+YZaIVIL70
         Fjunwm3LiSOF/8dtuH70ljZzPRUvLp9SEbG7GBiQ3sNjGvigppqmNyWCKghal+wDz6HR
         IB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4EItYdQHSEp++oOsPSDXKPyH/TL1/CRUmoaJf0o6HlY=;
        b=izsunvS/wGlwJxvtUX24Uanx2+g+93hwbpQU6TYVTB6AY09NlFUd/vCUD/c0+PiYZl
         5wH12eWqeUaki44oItU/siCnkUbE++6E2f0hbpSbnEVc+VnpJyXmr1YXAjDia1cr2WXB
         nzw8JRb1/9K0IKKn9aO30AloeqD9O1nTLvuaN5Tute5U1SEX/mG2uH4KGcY5zEIp31jw
         sOIDgay10Ah7ielsV7x4x1mGWv8EZZiQ5Har+7xSHDkFHUuumC1lrzEweJDCrGk4sx68
         abA/kasXw4IcwxL7yAbdctHWl48dvFBkkezBQjR3ZA/0CPAUyFBGa2WkIpSYg/ZlUA+M
         yxww==
X-Gm-Message-State: AD7BkJIUc/wLmEvIQO2wkfIiaU9JFxa4CqBQxMW/j0A+qOdQeT3kd54tt5h6GBxamwk5zg==
X-Received: by 10.28.129.7 with SMTP id c7mr17111473wmd.11.1457545954450;
        Wed, 09 Mar 2016 09:52:34 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:33 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288504>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index fcb3c14..4e0737c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -28,6 +28,7 @@ struct apply_state {
 
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
@@ -2814,7 +2814,7 @@ static int apply_one_fragment(struct apply_state *state,
 			/* Ignore it, we already handled it */
 			break;
 		default:
-			if (apply_verbosely)
+			if (state->apply_verbosely)
 				error(_("invalid start of line: '%c'"), first);
 			applied_pos = -1;
 			goto out;
@@ -2929,7 +2929,7 @@ static int apply_one_fragment(struct apply_state *state,
 				apply = 0;
 		}
 
-		if (apply_verbosely && applied_pos != pos) {
+		if (state->apply_verbosely && applied_pos != pos) {
 			int offset = applied_pos - pos;
 			if (state->apply_in_reverse)
 				offset = 0 - offset;
@@ -2951,7 +2951,7 @@ static int apply_one_fragment(struct apply_state *state,
 				   leading, trailing, applied_pos+1);
 		update_image(img, applied_pos, &preimage, &postimage);
 	} else {
-		if (apply_verbosely)
+		if (state->apply_verbosely)
 			error(_("while searching for:\n%.*s"),
 			      (int)(old - oldlines), oldlines);
 	}
@@ -3865,7 +3865,7 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 	prepare_symlink_changes(patch);
 	prepare_fn_table(patch);
 	while (patch) {
-		if (apply_verbosely)
+		if (state->apply_verbosely)
 			say_patch_name(stderr,
 				       _("Checking patch %s..."), patch);
 		err |= check_patch(state, patch);
@@ -4296,7 +4296,7 @@ static void write_out_one_result(struct patch *patch, int phase)
 		create_file(patch);
 }
 
-static int write_out_one_reject(struct patch *patch)
+static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 {
 	FILE *rej;
 	char namebuf[PATH_MAX];
@@ -4311,7 +4311,7 @@ static int write_out_one_reject(struct patch *patch)
 	}
 
 	if (!cnt) {
-		if (apply_verbosely)
+		if (state->apply_verbosely)
 			say_patch_name(stderr,
 				       _("Applied patch %s cleanly."), patch);
 		return 0;
@@ -4367,7 +4367,7 @@ static int write_out_one_reject(struct patch *patch)
 	return -1;
 }
 
-static int write_out_results(struct patch *list)
+static int write_out_results(struct apply_state *state, struct patch *list)
 {
 	int phase;
 	int errs = 0;
@@ -4382,7 +4382,7 @@ static int write_out_results(struct patch *list)
 			else {
 				write_out_one_result(l, phase);
 				if (phase == 1) {
-					if (write_out_one_reject(l))
+					if (write_out_one_reject(state, l))
 						errs = 1;
 					if (l->conflicted_threeway) {
 						string_list_append(&cpath, l->new_name);
@@ -4470,7 +4470,7 @@ static int apply_patch(struct apply_state *state,
 	    !state->apply_with_reject)
 		exit(1);
 
-	if (apply && write_out_results(list)) {
+	if (apply && write_out_results(state, list)) {
 		if (state->apply_with_reject)
 			exit(1);
 		/* with --3way, we still need to write the index out */
@@ -4621,7 +4621,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("leave the rejected hunks in corresponding *.rej files")),
 		OPT_BOOL(0, "allow-overlap", &allow_overlap,
 			N_("allow overlapping hunks")),
-		OPT__VERBOSE(&apply_verbosely, N_("be verbose")),
+		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
 			N_("tolerate incorrectly detected missing new-line at the end of file"),
 			INACCURATE_EOF),
@@ -4658,7 +4658,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		state.check_index = 1;
 	}
 	if (state.apply_with_reject)
-		apply = apply_verbosely = 1;
+		apply = state.apply_verbosely = 1;
 	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
-- 
2.8.0.rc1.49.gca61272
