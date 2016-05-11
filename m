From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 13/94] builtin/apply: move 'apply_in_reverse' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:24 +0200
Message-ID: <20160511131745.2914-14-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:19:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U2a-00021U-2C
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbcEKNS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:18:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35340 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbcEKNSy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:18:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id e201so9401036wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3a3cUsC8xZceUoxEfG/+RpNm9Z9UGr8aImth+iUrfPc=;
        b=amc0NhFx931Pw4hwn0ee7psAbYBYNPiMtaFcD7K9Rl9p5tDNuL/f8vQWS+Bi/Cfqc8
         bwttIWErxEv24neAG5YOQ2jWn3AY2eJ16DQZl3KAtS7ZMzVYshkFaKjDgrHhRFValeU7
         2n0nRUfrJ8oCddbD+VasU+cgmrLJP7HVygOeJFgmJPt/KTxATmP+kDL6nLJ5qH+RCtmh
         R/s4KW/KKOMPZtugmR/hdZYu5cBhn1pyJf5oA4egYXy+1H7pjCVy5vpuGRzBqh/Ihn0z
         WQd5OrLETWkALuNokZ5gOkufhSNBZ0ajXbZlaLkmodUXFgeT6Yqzemmv7SlQUAkcl09E
         OuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3a3cUsC8xZceUoxEfG/+RpNm9Z9UGr8aImth+iUrfPc=;
        b=X/tBykRwB8sCSXIXCY8HeUE6+Oseo+vO3LrbpdtH9KRGcYmKundlWUE3To/cVhF8gb
         5Yweo4APl2V0D70B5mwGLihHbFcJWTa9eIX7xPKCM8XRKO8mwbCfXMv0udxIB7mAmAv+
         c0VnoXe4gA0uWWjnoRS7jGd5z13gnrLKp9+litmFOvb8Acrk8zj2Im2GjzQFXOqdV8SR
         xXXVPhvLcogpPvTPY79L6wthy+8YwVQSAioWgJw+cWhuGWGZamOlm4ZzylgcTSXaMbyf
         UCqdeFXm5mMrkWgESPoO8dNrWH3PwQWnztreaF1blA2PWbl2qoeWQIcS9cbL8dFA7xlP
         kcPg==
X-Gm-Message-State: AOPr4FVfLWErUo3Y6X2IzoK4BjR398TgQvzMqzHbZWe31a2mFZwyE+cc46n5Aym8XaDV0A==
X-Received: by 10.28.48.203 with SMTP id w194mr4517028wmw.67.1462972732578;
        Wed, 11 May 2016 06:18:52 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:51 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294256>

To libify the apply functionality the 'apply_in_reverse' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 51 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5d8f410..73cef9b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -25,6 +25,8 @@ struct apply_state {
 	const char *prefix;
 	int prefix_length;
 
+	int apply_in_reverse;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -53,7 +55,6 @@ static int diffstat;
 static int numstat;
 static int summary;
 static int apply = 1;
-static int apply_in_reverse;
 static int apply_with_reject;
 static int apply_verbosely;
 static int allow_overlap;
@@ -1560,8 +1561,11 @@ static void check_whitespace(const char *line, int len, unsigned ws_rule)
  * between a "---" that is part of a patch, and a "---" that starts
  * the next patch is to look at the line counts..
  */
-static int parse_fragment(const char *line, unsigned long size,
-			  struct patch *patch, struct fragment *fragment)
+static int parse_fragment(struct apply_state *state,
+			  const char *line,
+			  unsigned long size,
+			  struct patch *patch,
+			  struct fragment *fragment)
 {
 	int added, deleted;
 	int len = linelen(line, size), offset;
@@ -1601,12 +1605,12 @@ static int parse_fragment(const char *line, unsigned long size,
 			if (!deleted && !added)
 				leading++;
 			trailing++;
-			if (!apply_in_reverse &&
+			if (!state->apply_in_reverse &&
 			    ws_error_action == correct_ws_error)
 				check_whitespace(line, len, patch->ws_rule);
 			break;
 		case '-':
-			if (apply_in_reverse &&
+			if (state->apply_in_reverse &&
 			    ws_error_action != nowarn_ws_error)
 				check_whitespace(line, len, patch->ws_rule);
 			deleted++;
@@ -1614,7 +1618,7 @@ static int parse_fragment(const char *line, unsigned long size,
 			trailing = 0;
 			break;
 		case '+':
-			if (!apply_in_reverse &&
+			if (!state->apply_in_reverse &&
 			    ws_error_action != nowarn_ws_error)
 				check_whitespace(line, len, patch->ws_rule);
 			added++;
@@ -1670,7 +1674,10 @@ static int parse_fragment(const char *line, unsigned long size,
  * The (fragment->patch, fragment->size) pair points into the memory given
  * by the caller, not a copy, when we return.
  */
-static int parse_single_patch(const char *line, unsigned long size, struct patch *patch)
+static int parse_single_patch(struct apply_state *state,
+			      const char *line,
+			      unsigned long size,
+			      struct patch *patch)
 {
 	unsigned long offset = 0;
 	unsigned long oldlines = 0, newlines = 0, context = 0;
@@ -1682,7 +1689,7 @@ static int parse_single_patch(const char *line, unsigned long size, struct patch
 
 		fragment = xcalloc(1, sizeof(*fragment));
 		fragment->linenr = state_linenr;
-		len = parse_fragment(line, size, patch, fragment);
+		len = parse_fragment(state, line, size, patch, fragment);
 		if (len <= 0)
 			die(_("corrupt patch at line %d"), state_linenr);
 		fragment->patch = line;
@@ -2012,8 +2019,10 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 						 ? patch->new_name
 						 : patch->old_name);
 
-	patchsize = parse_single_patch(buffer + offset + hdrsize,
-				       size - offset - hdrsize, patch);
+	patchsize = parse_single_patch(state,
+				       buffer + offset + hdrsize,
+				       size - offset - hdrsize,
+				       patch);
 
 	if (!patchsize) {
 		static const char git_binary[] = "GIT binary patch\n";
@@ -2745,7 +2754,7 @@ static int apply_one_fragment(struct apply_state *state,
 		if (len < size && patch[len] == '\\')
 			plen--;
 		first = *patch;
-		if (apply_in_reverse) {
+		if (state->apply_in_reverse) {
 			if (first == '-')
 				first = '+';
 			else if (first == '+')
@@ -2918,7 +2927,7 @@ static int apply_one_fragment(struct apply_state *state,
 
 		if (apply_verbosely && applied_pos != pos) {
 			int offset = applied_pos - pos;
-			if (apply_in_reverse)
+			if (state->apply_in_reverse)
 				offset = 0 - offset;
 			fprintf_ln(stderr,
 				   Q_("Hunk #%d succeeded at %d (offset %d line).",
@@ -2952,7 +2961,9 @@ out:
 	return (applied_pos < 0);
 }
 
-static int apply_binary_fragment(struct image *img, struct patch *patch)
+static int apply_binary_fragment(struct apply_state *state,
+				 struct image *img,
+				 struct patch *patch)
 {
 	struct fragment *fragment = patch->fragments;
 	unsigned long len;
@@ -2965,7 +2976,7 @@ static int apply_binary_fragment(struct image *img, struct patch *patch)
 			     patch->old_name);
 
 	/* Binary patch is irreversible without the optional second hunk */
-	if (apply_in_reverse) {
+	if (state->apply_in_reverse) {
 		if (!fragment->next)
 			return error("cannot reverse-apply a binary patch "
 				     "without the reverse hunk to '%s'",
@@ -2998,7 +3009,9 @@ static int apply_binary_fragment(struct image *img, struct patch *patch)
  * but the preimage prepared by the caller in "img" is freed here
  * or in the helper function apply_binary_fragment() this calls.
  */
-static int apply_binary(struct image *img, struct patch *patch)
+static int apply_binary(struct apply_state *state,
+			struct image *img,
+			struct patch *patch)
 {
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
 	unsigned char sha1[20];
@@ -3059,7 +3072,7 @@ static int apply_binary(struct image *img, struct patch *patch)
 		 * apply the patch data to it, which is stored
 		 * in the patch->fragments->{patch,size}.
 		 */
-		if (apply_binary_fragment(img, patch))
+		if (apply_binary_fragment(state, img, patch))
 			return error(_("binary patch does not apply to '%s'"),
 				     name);
 
@@ -3082,7 +3095,7 @@ static int apply_fragments(struct apply_state *state, struct image *img, struct
 	int nth = 0;
 
 	if (patch->is_binary)
-		return apply_binary(img, patch);
+		return apply_binary(state, img, patch);
 
 	while (frag) {
 		nth++;
@@ -4421,7 +4434,7 @@ static int apply_patch(struct apply_state *state,
 			free_patch(patch);
 			break;
 		}
-		if (apply_in_reverse)
+		if (state->apply_in_reverse)
 			reverse_patches(patch);
 		if (use_patch(state, patch)) {
 			patch_stats(patch);
@@ -4614,7 +4627,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		{ OPTION_CALLBACK, 0, "ignore-whitespace", NULL, NULL,
 			N_("ignore changes in whitespace when finding context"),
 			PARSE_OPT_NOARG, option_parse_space_change },
-		OPT_BOOL('R', "reverse", &apply_in_reverse,
+		OPT_BOOL('R', "reverse", &state.apply_in_reverse,
 			N_("apply the patch in reverse")),
 		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
 			N_("don't expect at least one line of context")),
-- 
2.8.2.490.g3dabe57
