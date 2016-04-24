From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 11/83] builtin/apply: move 'apply_in_reverse' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:11 +0200
Message-ID: <1461504863-15946-12-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:39:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKFZ-0001Ig-Az
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbcDXNfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:09 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34873 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbcDXNfB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:01 -0400
Received: by mail-wm0-f54.google.com with SMTP id e201so60526211wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iz5O0o8HHZRC+Jw30dHgJEuEDLDUvFHDMNGUhrbJhVk=;
        b=dIj3kx4qt79gvb21rm1TM4YyjshA8VelBgXkaPnIo/jrOAFE3Qe8ppanBJbjOujamu
         qsmbmXrOATSlD0vQ1ZQMFUnG0btluIUD5AKpkUWqDq/6ZZxirrqzSqletyiLDF8wTfFx
         72AjtHTNF3YzbHoGS1L5nox99W/1rCMQOvUL2JZVSmrSTdtGJPXroJhM/zoaekNvQRgj
         BzgSOFhyg6VF8VceKoGKyxSGBpQY37rECPoVfMG9YGENDk79EHQRNo/uZkdttP6YRdDa
         qNqgxobrXkOB38FBrJ8GGnyhtn8QzE/WjruGZEYEBwDhWw7js/Fwu7AnBpcwuvczNWOl
         e8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iz5O0o8HHZRC+Jw30dHgJEuEDLDUvFHDMNGUhrbJhVk=;
        b=G6lUs8y2tb1qzuEY3QBm5RiTtcbXxhBd85Qm01f+9fnHpPeizwEUkYQ4kEprIZUSoO
         tvtUtdcJEE3u0iC81zpSiye5dRavBo8sG9CxOcpSnPWeXKmncMLu9+lLu1a4BUHTb9A7
         e4/DEIbbgNfFyS0MvpL+N/skZbZSjXxVHV2F3KkoubSVcKG46cx7WN4UTQCyz74S1QYI
         vC5QDFVBntFFsM258xFvFHgsFIJu6QQ9DOiHyLso5rDymHMsJw9DkrFovyeSS/kdr/UE
         eEhkux9eNW2KVHURyId7y8V7DgaEIPGx1J574a+sgi/qnohtNktG8n/rpshcK1XI+xTw
         iKxQ==
X-Gm-Message-State: AOPr4FVxxklC5GGq1IBQWKoJtlNA+enHbMWKX1myDLMXoCTpyT7fskwe7562DsZEN6tnAQ==
X-Received: by 10.194.186.242 with SMTP id fn18mr31579647wjc.65.1461504900338;
        Sun, 24 Apr 2016 06:35:00 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:34:59 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292394>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 51 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 3f8671c..755e0e3 100644
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
@@ -1561,8 +1562,11 @@ static void check_whitespace(const char *line, int len, unsigned ws_rule)
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
@@ -1602,12 +1606,12 @@ static int parse_fragment(const char *line, unsigned long size,
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
@@ -1615,7 +1619,7 @@ static int parse_fragment(const char *line, unsigned long size,
 			trailing = 0;
 			break;
 		case '+':
-			if (!apply_in_reverse &&
+			if (!state->apply_in_reverse &&
 			    ws_error_action != nowarn_ws_error)
 				check_whitespace(line, len, patch->ws_rule);
 			added++;
@@ -1671,7 +1675,10 @@ static int parse_fragment(const char *line, unsigned long size,
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
@@ -1683,7 +1690,7 @@ static int parse_single_patch(const char *line, unsigned long size, struct patch
 
 		fragment = xcalloc(1, sizeof(*fragment));
 		fragment->linenr = linenr;
-		len = parse_fragment(line, size, patch, fragment);
+		len = parse_fragment(state, line, size, patch, fragment);
 		if (len <= 0)
 			die(_("corrupt patch at line %d"), linenr);
 		fragment->patch = line;
@@ -2013,8 +2020,10 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
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
@@ -2747,7 +2756,7 @@ static int apply_one_fragment(struct apply_state *state,
 		if (len < size && patch[len] == '\\')
 			plen--;
 		first = *patch;
-		if (apply_in_reverse) {
+		if (state->apply_in_reverse) {
 			if (first == '-')
 				first = '+';
 			else if (first == '+')
@@ -2920,7 +2929,7 @@ static int apply_one_fragment(struct apply_state *state,
 
 		if (apply_verbosely && applied_pos != pos) {
 			int offset = applied_pos - pos;
-			if (apply_in_reverse)
+			if (state->apply_in_reverse)
 				offset = 0 - offset;
 			fprintf_ln(stderr,
 				   Q_("Hunk #%d succeeded at %d (offset %d line).",
@@ -2954,7 +2963,9 @@ out:
 	return (applied_pos < 0);
 }
 
-static int apply_binary_fragment(struct image *img, struct patch *patch)
+static int apply_binary_fragment(struct apply_state *state,
+				 struct image *img,
+				 struct patch *patch)
 {
 	struct fragment *fragment = patch->fragments;
 	unsigned long len;
@@ -2967,7 +2978,7 @@ static int apply_binary_fragment(struct image *img, struct patch *patch)
 			     patch->old_name);
 
 	/* Binary patch is irreversible without the optional second hunk */
-	if (apply_in_reverse) {
+	if (state->apply_in_reverse) {
 		if (!fragment->next)
 			return error("cannot reverse-apply a binary patch "
 				     "without the reverse hunk to '%s'",
@@ -3000,7 +3011,9 @@ static int apply_binary_fragment(struct image *img, struct patch *patch)
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
@@ -3061,7 +3074,7 @@ static int apply_binary(struct image *img, struct patch *patch)
 		 * apply the patch data to it, which is stored
 		 * in the patch->fragments->{patch,size}.
 		 */
-		if (apply_binary_fragment(img, patch))
+		if (apply_binary_fragment(state, img, patch))
 			return error(_("binary patch does not apply to '%s'"),
 				     name);
 
@@ -3084,7 +3097,7 @@ static int apply_fragments(struct apply_state *state, struct image *img, struct
 	int nth = 0;
 
 	if (patch->is_binary)
-		return apply_binary(img, patch);
+		return apply_binary(state, img, patch);
 
 	while (frag) {
 		nth++;
@@ -4423,7 +4436,7 @@ static int apply_patch(struct apply_state *state,
 			free_patch(patch);
 			break;
 		}
-		if (apply_in_reverse)
+		if (state->apply_in_reverse)
 			reverse_patches(patch);
 		if (use_patch(state, patch)) {
 			patch_stats(patch);
@@ -4602,7 +4615,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		{ OPTION_CALLBACK, 0, "ignore-whitespace", NULL, NULL,
 			N_("ignore changes in whitespace when finding context"),
 			PARSE_OPT_NOARG, option_parse_space_change },
-		OPT_BOOL('R', "reverse", &apply_in_reverse,
+		OPT_BOOL('R', "reverse", &state.apply_in_reverse,
 			N_("apply the patch in reverse")),
 		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
 			N_("don't expect at least one line of context")),
-- 
2.8.1.300.g5fed0c0
