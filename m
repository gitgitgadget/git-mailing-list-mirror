From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 13/83] builtin/apply: move 'apply_verbosely' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:13 +0200
Message-ID: <1461504863-15946-14-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:35:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKBw-0007ok-TJ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbcDXNfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:10 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38223 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbcDXNfF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:05 -0400
Received: by mail-wm0-f42.google.com with SMTP id u206so89924014wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ULxW0qRXgwe/rLAXvVpEGxqltgY4g6WAeP1dV3au+Mk=;
        b=tYxjru1b+MDoqbwLfYiyJBoXmKJCC5DUbMAZz3z6TQmnmJ8x3UhnnFZz6ut2hz4X8j
         Bc6rx0F0jxYUvYjrJ7YoIIVGyQMtfY3tZHTnT9RsiKXfR/O2+1XMuf5SkkwslL/JU7y8
         qub+/DS+lP2hjBifGJOZIzpdYeElSUuqZWQXmvAuZhSMnv7NR8RoejLgZnOC2VrFAaEz
         qIf/vP6PuzeYSjurrHyKr9gwOkDUZRu0kZ9QXFebm9P4g8hdjvfd5/0IVGCHVHF40g4N
         UhvoYn8GDTUTj3+pT/Oc3x3nkix65vKgn/JkCxKFR8vA9/xIasjt313/SIDyozJwnr3C
         nCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ULxW0qRXgwe/rLAXvVpEGxqltgY4g6WAeP1dV3au+Mk=;
        b=RJ1deqQjpyEYzn+0IkUx0CXn0otBpc1CrcFXHxRVsq7qHjyI9RNAdu1ljZizkfv1Pm
         oebPqfhRauTm+VXGLsIYbUmw8jb85J77Wf2R0ycFsFOPiQpV6vAzwES+HqhNH4gZ7df3
         1GBESB125eHBopt5DHfiEOjxF/cq7aU4sa6FaMHxCiq7xM0YeN9vTD0ws6aoX4FpHwP4
         2WcUHFRNtXoEuadMAXO22vuIJOwtQXB1rdVTGZkJ11nZgWu894JmId6Y2yu2yCxgXxDQ
         WXi6j/6ASjjxqZfLYfm9il01Ois0sWe/Ug+LxOnRv6lWF8aHfWT/12P3XtZce9RmBVji
         9eQg==
X-Gm-Message-State: AOPr4FVthXEz0ZrnriLE8LWtCkz85HHW2FtV7Jd55Kwu13Y70VFPoZO4bfFvAVLH2++csA==
X-Received: by 10.28.168.133 with SMTP id r127mr455533wme.9.1461504903369;
        Sun, 24 Apr 2016 06:35:03 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:02 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292334>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 67560e4..154679e 100644
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
@@ -2812,7 +2812,7 @@ static int apply_one_fragment(struct apply_state *state,
 			/* Ignore it, we already handled it */
 			break;
 		default:
-			if (apply_verbosely)
+			if (state->apply_verbosely)
 				error(_("invalid start of line: '%c'"), first);
 			applied_pos = -1;
 			goto out;
@@ -2927,7 +2927,7 @@ static int apply_one_fragment(struct apply_state *state,
 				apply = 0;
 		}
 
-		if (apply_verbosely && applied_pos != pos) {
+		if (state->apply_verbosely && applied_pos != pos) {
 			int offset = applied_pos - pos;
 			if (state->apply_in_reverse)
 				offset = 0 - offset;
@@ -2949,7 +2949,7 @@ static int apply_one_fragment(struct apply_state *state,
 				   leading, trailing, applied_pos+1);
 		update_image(img, applied_pos, &preimage, &postimage);
 	} else {
-		if (apply_verbosely)
+		if (state->apply_verbosely)
 			error(_("while searching for:\n%.*s"),
 			      (int)(old - oldlines), oldlines);
 	}
@@ -3863,7 +3863,7 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 	prepare_symlink_changes(patch);
 	prepare_fn_table(patch);
 	while (patch) {
-		if (apply_verbosely)
+		if (state->apply_verbosely)
 			say_patch_name(stderr,
 				       _("Checking patch %s..."), patch);
 		err |= check_patch(state, patch);
@@ -4294,7 +4294,7 @@ static void write_out_one_result(struct patch *patch, int phase)
 		create_file(patch);
 }
 
-static int write_out_one_reject(struct patch *patch)
+static int write_out_one_reject(struct apply_state *state, struct patch *patch)
 {
 	FILE *rej;
 	char namebuf[PATH_MAX];
@@ -4309,7 +4309,7 @@ static int write_out_one_reject(struct patch *patch)
 	}
 
 	if (!cnt) {
-		if (apply_verbosely)
+		if (state->apply_verbosely)
 			say_patch_name(stderr,
 				       _("Applied patch %s cleanly."), patch);
 		return 0;
@@ -4365,7 +4365,7 @@ static int write_out_one_reject(struct patch *patch)
 	return -1;
 }
 
-static int write_out_results(struct patch *list)
+static int write_out_results(struct apply_state *state, struct patch *list)
 {
 	int phase;
 	int errs = 0;
@@ -4380,7 +4380,7 @@ static int write_out_results(struct patch *list)
 			else {
 				write_out_one_result(l, phase);
 				if (phase == 1) {
-					if (write_out_one_reject(l))
+					if (write_out_one_reject(state, l))
 						errs = 1;
 					if (l->conflicted_threeway) {
 						string_list_append(&cpath, l->new_name);
@@ -4444,7 +4444,7 @@ static int apply_patch(struct apply_state *state,
 			listp = &patch->next;
 		}
 		else {
-			if (apply_verbosely)
+			if (state->apply_verbosely)
 				say_patch_name(stderr, _("Skipped patch '%s'."), patch);
 			free_patch(patch);
 			skipped_patch++;
@@ -4472,7 +4472,7 @@ static int apply_patch(struct apply_state *state,
 	    !state->apply_with_reject)
 		exit(1);
 
-	if (apply && write_out_results(list)) {
+	if (apply && write_out_results(state, list)) {
 		if (state->apply_with_reject)
 			exit(1);
 		/* with --3way, we still need to write the index out */
@@ -4623,7 +4623,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("leave the rejected hunks in corresponding *.rej files")),
 		OPT_BOOL(0, "allow-overlap", &allow_overlap,
 			N_("allow overlapping hunks")),
-		OPT__VERBOSE(&apply_verbosely, N_("be verbose")),
+		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
 			N_("tolerate incorrectly detected missing new-line at the end of file"),
 			INACCURATE_EOF),
@@ -4659,7 +4659,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		state.check_index = 1;
 	}
 	if (state.apply_with_reject)
-		apply = apply_verbosely = 1;
+		apply = state.apply_verbosely = 1;
 	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
-- 
2.8.1.300.g5fed0c0
