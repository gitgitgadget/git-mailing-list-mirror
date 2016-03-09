From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 11/48] builtin/apply: move 'apply_in_reverse' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:39 +0100
Message-ID: <1457545756-20616-12-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHn-0007er-OL
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933287AbcCIRwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:36 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37308 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933251AbcCIRwa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:30 -0500
Received: by mail-wm0-f46.google.com with SMTP id p65so81793177wmp.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bIouKwEXLv5VAX+6qOqzO0tbeapkTaQl9Y7+g/JDn+A=;
        b=dZCTac7LpyLQQv1qhL5+tWZJAVmunCrDrd+jodyUZ3TXvOjGotPzYJqGKJIxxZYoY4
         LwcgsC4PEsAekbnVr68KQJ3M7KiTD6beG1+ksSfPyDbSejR0s56qGtLElXwHdnj8Jus1
         9/akCE6iLX/S6PTOFd4bUH1jOBxJGumuqrFbS6BFEgU32y8xxjGq7VjJ3kbMjpI8SfMl
         ARSssBYrmLB0NIyK2HOrC9yfdZgW+FwMAcH+6PmZL2M2Nd/1CW1bjdiusTftU9KuYUjh
         JGn7TtWItjNUhQnumXpkt+at1ynHiDJKaGRtIzVnyHZLmn8eHrXzXNkqQrP53wCEB5tN
         KzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bIouKwEXLv5VAX+6qOqzO0tbeapkTaQl9Y7+g/JDn+A=;
        b=OlcQ/53woFq2gY4VR1PzBxVAYLLyXZAYtHoJBEsI6OXM6My3jHUMnTokTZFNq05ulo
         LjlTzFYZZPX4j5A/KDXQl2DOiRRrc5CSPX9iViMHSOwJHww4u1NSOZD5gXJDURr7DSsG
         QYG2QIx0y698H7uJshZqIyJbVk/xsUucuMJhcxqjfDFOCZgci++LMqnIkKuzy34iIdXt
         DQoeTAQY0f3QkPWIaSFgFZ3HbUD5T1dHCHf2qdVrlcexNcKa2AuXC7V1ri35lpkC8NUJ
         MXIBoSj7RYHfku/LZ5Ln6kvMxaQHa+/qYNLek+hrqfej2wkJRJmi4Od3dpcvLFEXOiMb
         1QYg==
X-Gm-Message-State: AD7BkJIvf9Z4kXtsofnph5yqTFradAy/OedLVod211K48uzn+IGfTh5L7NVop6lFqVqhvQ==
X-Received: by 10.194.90.100 with SMTP id bv4mr25538388wjb.4.1457545949079;
        Wed, 09 Mar 2016 09:52:29 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:28 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288500>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 51 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 9bc01a8..6bf3024 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -26,6 +26,8 @@ struct apply_state {
 	int prefix_length;
 	int newfd;
 
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
@@ -1570,8 +1571,11 @@ static void check_whitespace(const char *line, int len, unsigned ws_rule)
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
@@ -1611,12 +1615,12 @@ static int parse_fragment(const char *line, unsigned long size,
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
@@ -1624,7 +1628,7 @@ static int parse_fragment(const char *line, unsigned long size,
 			trailing = 0;
 			break;
 		case '+':
-			if (!apply_in_reverse &&
+			if (!state->apply_in_reverse &&
 			    ws_error_action != nowarn_ws_error)
 				check_whitespace(line, len, patch->ws_rule);
 			added++;
@@ -1680,7 +1684,10 @@ static int parse_fragment(const char *line, unsigned long size,
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
@@ -1692,7 +1699,7 @@ static int parse_single_patch(const char *line, unsigned long size, struct patch
 
 		fragment = xcalloc(1, sizeof(*fragment));
 		fragment->linenr = linenr;
-		len = parse_fragment(line, size, patch, fragment);
+		len = parse_fragment(state, line, size, patch, fragment);
 		if (len <= 0)
 			die(_("corrupt patch at line %d"), linenr);
 		fragment->patch = line;
@@ -2017,8 +2024,10 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
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
@@ -2749,7 +2758,7 @@ static int apply_one_fragment(struct apply_state *state,
 		if (len < size && patch[len] == '\\')
 			plen--;
 		first = *patch;
-		if (apply_in_reverse) {
+		if (state->apply_in_reverse) {
 			if (first == '-')
 				first = '+';
 			else if (first == '+')
@@ -2922,7 +2931,7 @@ static int apply_one_fragment(struct apply_state *state,
 
 		if (apply_verbosely && applied_pos != pos) {
 			int offset = applied_pos - pos;
-			if (apply_in_reverse)
+			if (state->apply_in_reverse)
 				offset = 0 - offset;
 			fprintf_ln(stderr,
 				   Q_("Hunk #%d succeeded at %d (offset %d line).",
@@ -2956,7 +2965,9 @@ out:
 	return (applied_pos < 0);
 }
 
-static int apply_binary_fragment(struct image *img, struct patch *patch)
+static int apply_binary_fragment(struct apply_state *state,
+				 struct image *img,
+				 struct patch *patch)
 {
 	struct fragment *fragment = patch->fragments;
 	unsigned long len;
@@ -2969,7 +2980,7 @@ static int apply_binary_fragment(struct image *img, struct patch *patch)
 			     patch->old_name);
 
 	/* Binary patch is irreversible without the optional second hunk */
-	if (apply_in_reverse) {
+	if (state->apply_in_reverse) {
 		if (!fragment->next)
 			return error("cannot reverse-apply a binary patch "
 				     "without the reverse hunk to '%s'",
@@ -3002,7 +3013,9 @@ static int apply_binary_fragment(struct image *img, struct patch *patch)
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
@@ -3063,7 +3076,7 @@ static int apply_binary(struct image *img, struct patch *patch)
 		 * apply the patch data to it, which is stored
 		 * in the patch->fragments->{patch,size}.
 		 */
-		if (apply_binary_fragment(img, patch))
+		if (apply_binary_fragment(state, img, patch))
 			return error(_("binary patch does not apply to '%s'"),
 				     name);
 
@@ -3086,7 +3099,7 @@ static int apply_fragments(struct apply_state *state, struct image *img, struct
 	int nth = 0;
 
 	if (patch->is_binary)
-		return apply_binary(img, patch);
+		return apply_binary(state, img, patch);
 
 	while (frag) {
 		nth++;
@@ -4423,7 +4436,7 @@ static int apply_patch(struct apply_state *state,
 		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0)
 			break;
-		if (apply_in_reverse)
+		if (state->apply_in_reverse)
 			reverse_patches(patch);
 		if (use_patch(state, patch)) {
 			patch_stats(patch);
@@ -4600,7 +4613,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		{ OPTION_CALLBACK, 0, "ignore-whitespace", NULL, NULL,
 			N_("ignore changes in whitespace when finding context"),
 			PARSE_OPT_NOARG, option_parse_space_change },
-		OPT_BOOL('R', "reverse", &apply_in_reverse,
+		OPT_BOOL('R', "reverse", &state.apply_in_reverse,
 			N_("apply the patch in reverse")),
 		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
 			N_("don't expect at least one line of context")),
-- 
2.8.0.rc1.49.gca61272
