From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 13/49] builtin/apply: move 'apply_in_reverse' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:10:50 +0200
Message-ID: <20160524081126.16973-14-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:12:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Rx-0000qM-UH
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbcEXIMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34462 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbcEXIMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so3657959wmn.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KJtZkPObbp9nN+8CMNsTUKuTibRDFDCMN3ct5IqfmUI=;
        b=O32wGUsdxycigF/i45hWw7IW8uzboTR5W8cW69p8ZqyAqGswJ1YNiPUS1VtwqLnAZL
         KLpfuEc7co8begrzEcSmcgPwx2u1vUk/Jb6slUHOUgptJAp/9NoHBhhIC7LrdKOPRQ+E
         DbCWu4dc26S0mjegQgEMmcqST89tih3ZpN8mDRhKGq8PTOmgiHQYqPPZjNJSiTfTMjvJ
         VyIMPBklYBeUZidAcdFyY87YElgGzyMEVtenpLUtt53k+JPJ5Fy2DY6cH2V4p9tyjT5r
         fEFLgA2qdys4HimSWQZiCmS/QAgB+/mcESB1S6+fHrpEE709hmWCYTibuURcJXl2gwaX
         T+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KJtZkPObbp9nN+8CMNsTUKuTibRDFDCMN3ct5IqfmUI=;
        b=TWYP7zHEM9MapJh4GTjUUcUBwWzQSW8P9NHgxVFs/HCyPvx+TwblXlXWN4xdHA5b6i
         utTc+Dv2N8V0nYq92wdCJ2krHfThh5yd5grAwt8xEAZL9v28r7j5lwY86U50YPAaddYJ
         iPPFLCRuXEBOO2Xxo0t/njQtTxyHi9LY3DFicFDYdGHX17EFz1QGVMI1ofTroEEuMd8s
         88dnJ+ceeyrsQSmC9NSgDozFCrwSr6EkMqcBdOzJahOS2fchEpOlhi84vzjV6mBELEh3
         TOblNoisGh9LVkOfzDu+s5PQpmjTb6mEiovAQwhzI8wf3GqJNHF+D+Z9kGrTbhrfL8pR
         5KsQ==
X-Gm-Message-State: AOPr4FXJqR/h7EO6+pmfXgESD+2liOGfN6Ypj1ANbuth0m4swtZtAwUBuGaFpO/1+/ueRA==
X-Received: by 10.28.187.85 with SMTP id l82mr22334531wmf.2.1464077524456;
        Tue, 24 May 2016 01:12:04 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:03 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295433>

To libify the apply functionality the 'apply_in_reverse' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 50 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 769383c..796d990 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -30,6 +30,7 @@ struct apply_state {
 	int check_index; /* preimage must match the indexed version */
 
 	/* These boolean parameters control how the apply is done */
+	int apply_in_reverse;
 	int unidiff_zero;
 };
 
@@ -49,7 +50,6 @@ static int diffstat;
 static int numstat;
 static int summary;
 static int apply = 1;
-static int apply_in_reverse;
 static int apply_with_reject;
 static int apply_verbosely;
 static int allow_overlap;
@@ -1556,8 +1556,11 @@ static void check_whitespace(const char *line, int len, unsigned ws_rule)
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
@@ -1597,12 +1600,12 @@ static int parse_fragment(const char *line, unsigned long size,
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
@@ -1610,7 +1613,7 @@ static int parse_fragment(const char *line, unsigned long size,
 			trailing = 0;
 			break;
 		case '+':
-			if (!apply_in_reverse &&
+			if (!state->apply_in_reverse &&
 			    ws_error_action != nowarn_ws_error)
 				check_whitespace(line, len, patch->ws_rule);
 			added++;
@@ -1666,7 +1669,10 @@ static int parse_fragment(const char *line, unsigned long size,
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
@@ -1678,7 +1684,7 @@ static int parse_single_patch(const char *line, unsigned long size, struct patch
 
 		fragment = xcalloc(1, sizeof(*fragment));
 		fragment->linenr = state_linenr;
-		len = parse_fragment(line, size, patch, fragment);
+		len = parse_fragment(state, line, size, patch, fragment);
 		if (len <= 0)
 			die(_("corrupt patch at line %d"), state_linenr);
 		fragment->patch = line;
@@ -2008,8 +2014,10 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
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
@@ -2741,7 +2749,7 @@ static int apply_one_fragment(struct apply_state *state,
 		if (len < size && patch[len] == '\\')
 			plen--;
 		first = *patch;
-		if (apply_in_reverse) {
+		if (state->apply_in_reverse) {
 			if (first == '-')
 				first = '+';
 			else if (first == '+')
@@ -2914,7 +2922,7 @@ static int apply_one_fragment(struct apply_state *state,
 
 		if (apply_verbosely && applied_pos != pos) {
 			int offset = applied_pos - pos;
-			if (apply_in_reverse)
+			if (state->apply_in_reverse)
 				offset = 0 - offset;
 			fprintf_ln(stderr,
 				   Q_("Hunk #%d succeeded at %d (offset %d line).",
@@ -2948,7 +2956,9 @@ out:
 	return (applied_pos < 0);
 }
 
-static int apply_binary_fragment(struct image *img, struct patch *patch)
+static int apply_binary_fragment(struct apply_state *state,
+				 struct image *img,
+				 struct patch *patch)
 {
 	struct fragment *fragment = patch->fragments;
 	unsigned long len;
@@ -2961,7 +2971,7 @@ static int apply_binary_fragment(struct image *img, struct patch *patch)
 			     patch->old_name);
 
 	/* Binary patch is irreversible without the optional second hunk */
-	if (apply_in_reverse) {
+	if (state->apply_in_reverse) {
 		if (!fragment->next)
 			return error("cannot reverse-apply a binary patch "
 				     "without the reverse hunk to '%s'",
@@ -2994,7 +3004,9 @@ static int apply_binary_fragment(struct image *img, struct patch *patch)
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
@@ -3055,7 +3067,7 @@ static int apply_binary(struct image *img, struct patch *patch)
 		 * apply the patch data to it, which is stored
 		 * in the patch->fragments->{patch,size}.
 		 */
-		if (apply_binary_fragment(img, patch))
+		if (apply_binary_fragment(state, img, patch))
 			return error(_("binary patch does not apply to '%s'"),
 				     name);
 
@@ -3078,7 +3090,7 @@ static int apply_fragments(struct apply_state *state, struct image *img, struct
 	int nth = 0;
 
 	if (patch->is_binary)
-		return apply_binary(img, patch);
+		return apply_binary(state, img, patch);
 
 	while (frag) {
 		nth++;
@@ -4417,7 +4429,7 @@ static int apply_patch(struct apply_state *state,
 			free_patch(patch);
 			break;
 		}
-		if (apply_in_reverse)
+		if (state->apply_in_reverse)
 			reverse_patches(patch);
 		if (use_patch(state, patch)) {
 			patch_stats(patch);
@@ -4615,7 +4627,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "ignore-whitespace", NULL, NULL,
 			N_("ignore changes in whitespace when finding context"),
 			PARSE_OPT_NOARG, option_parse_space_change },
-		OPT_BOOL('R', "reverse", &apply_in_reverse,
+		OPT_BOOL('R', "reverse", &state.apply_in_reverse,
 			N_("apply the patch in reverse")),
 		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
 			N_("don't expect at least one line of context")),
-- 
2.8.3.443.gaeee61e
