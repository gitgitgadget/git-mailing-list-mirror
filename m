From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 31/83] builtin/apply: move 'p_value' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:31 +0200
Message-ID: <1461504863-15946-32-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:38:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKEs-0000wH-13
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbcDXNiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:38:14 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37675 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbcDXNfa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:30 -0400
Received: by mail-wm0-f46.google.com with SMTP id n3so90208443wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gcTi5zraZYxgthpx6/1GvyXYQ1nX0rC48ABmGFO/vyE=;
        b=uHYwCqg1xHZNG4CwSas40NpM+vNFCLfXxRRoEukgcPyOH6SkRyZwIx5tHb3vOexTDI
         ppGPX1jzGOVHGgPqYlSVocxW3Wao3A/RBRHQnjDAbYV6PEFweHu1ce7nCKktlR84trX3
         nV/UZ/J/ZXnAvTk180DorwW80w/1EJOdKxViVOOJU8jrTwjrHaJlYpXpbgvpQ2Bsyz3P
         5AU5Xb4pMzhqsP9WgOzMsFlaXS0yTFnT6VI76py99g+gvqgs4KS4BAru0R7MDC147JiO
         U4LP3/ZNi03sx6B7EjJjuYsD2+oPBiCIpOdVM70F6IHqkcwXSz3juVRnJqIr16rL2G3z
         zXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gcTi5zraZYxgthpx6/1GvyXYQ1nX0rC48ABmGFO/vyE=;
        b=GC0D16BQQPZVIY9vIGv0DKy2OwjO0Shx4bH3NpyTSXeRN2wbKlttt3qdk+DLQq+SZB
         y03vVk2kBEX/ngpwgZyNpvARdKgAbyjHpBxM7borfO8B8n/4jEL8lU9n95Y4F2p1X0cL
         wYVwm9c1oCxSkqBLSK/ngibkZOoKOlyJ91EdU8uyZckFWm2hqYsfK3QwICjnHBfdH78R
         9cTZY1klDnMoWPDLV9SL41r10umWCqKOaCFwF05ucadYuEgEgtXgkoCzuW23eaNPOVUK
         yD8oeySw++Puc5SpfzaOeKGqP/6GnZeUcbz2ug62f5ifPsUgyUgm8KsRIKoM+G0AtdNz
         n2iw==
X-Gm-Message-State: AOPr4FVwLFhGgrYttnW3Jv4Wgp5ckIvrCUJ95g8cJwtlA3ypTT4N2lsY3xN83105zl64ZQ==
X-Received: by 10.195.20.66 with SMTP id ha2mr28939403wjd.76.1461504928756;
        Sun, 24 Apr 2016 06:35:28 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:28 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292387>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 151 +++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 99 insertions(+), 52 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0717cd2..979849c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -65,6 +65,7 @@ struct apply_state {
 
 	int line_termination;
 
+	int p_value;
 	unsigned int p_context;
 
 	const char *patch_input_file;
@@ -75,7 +76,6 @@ struct apply_state {
 
 static int newfd = -1;
 
-static int state_p_value = 1;
 static int p_value_known;
 
 static const char * const apply_usage[] = {
@@ -896,24 +896,24 @@ static void parse_traditional_patch(struct apply_state *state,
 		q = guess_p_value(state, second);
 		if (p < 0) p = q;
 		if (0 <= p && p == q) {
-			state_p_value = p;
+			state->p_value = p;
 			p_value_known = 1;
 		}
 	}
 	if (is_dev_null(first)) {
 		patch->is_new = 1;
 		patch->is_delete = 0;
-		name = find_name_traditional(second, NULL, state_p_value);
+		name = find_name_traditional(second, NULL, state->p_value);
 		patch->new_name = name;
 	} else if (is_dev_null(second)) {
 		patch->is_new = 0;
 		patch->is_delete = 1;
-		name = find_name_traditional(first, NULL, state_p_value);
+		name = find_name_traditional(first, NULL, state->p_value);
 		patch->old_name = name;
 	} else {
 		char *first_name;
-		first_name = find_name_traditional(first, NULL, state_p_value);
-		name = find_name_traditional(second, first_name, state_p_value);
+		first_name = find_name_traditional(first, NULL, state->p_value);
+		name = find_name_traditional(second, first_name, state->p_value);
 		free(first_name);
 		if (has_epoch_timestamp(first)) {
 			patch->is_new = 1;
@@ -932,7 +932,9 @@ static void parse_traditional_patch(struct apply_state *state,
 		die(_("unable to find filename in patch at line %d"), linenr);
 }
 
-static int gitdiff_hdrend(const char *line, struct patch *patch)
+static int gitdiff_hdrend(struct apply_state *state,
+			  const char *line,
+			  struct patch *patch)
 {
 	return -1;
 }
@@ -949,10 +951,14 @@ static int gitdiff_hdrend(const char *line, struct patch *patch)
 #define DIFF_OLD_NAME 0
 #define DIFF_NEW_NAME 1
 
-static void gitdiff_verify_name(const char *line, int isnull, char **name, int side)
+static void gitdiff_verify_name(struct apply_state *state,
+				const char *line,
+				int isnull,
+				char **name,
+				int side)
 {
 	if (!*name && !isnull) {
-		*name = find_name(line, NULL, state_p_value, TERM_TAB);
+		*name = find_name(line, NULL, state->p_value, TERM_TAB);
 		return;
 	}
 
@@ -962,7 +968,7 @@ static void gitdiff_verify_name(const char *line, int isnull, char **name, int s
 		if (isnull)
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
 			    *name, linenr);
-		another = find_name(line, NULL, state_p_value, TERM_TAB);
+		another = find_name(line, NULL, state->p_value, TERM_TAB);
 		if (!another || memcmp(another, *name, len + 1))
 			die((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
@@ -975,81 +981,105 @@ static void gitdiff_verify_name(const char *line, int isnull, char **name, int s
 	}
 }
 
-static int gitdiff_oldname(const char *line, struct patch *patch)
+static int gitdiff_oldname(struct apply_state *state,
+			   const char *line,
+			   struct patch *patch)
 {
-	gitdiff_verify_name(line, patch->is_new, &patch->old_name,
+	gitdiff_verify_name(state, line,
+			    patch->is_new, &patch->old_name,
 			    DIFF_OLD_NAME);
 	return 0;
 }
 
-static int gitdiff_newname(const char *line, struct patch *patch)
+static int gitdiff_newname(struct apply_state *state,
+			   const char *line,
+			   struct patch *patch)
 {
-	gitdiff_verify_name(line, patch->is_delete, &patch->new_name,
+	gitdiff_verify_name(state, line,
+			    patch->is_delete, &patch->new_name,
 			    DIFF_NEW_NAME);
 	return 0;
 }
 
-static int gitdiff_oldmode(const char *line, struct patch *patch)
+static int gitdiff_oldmode(struct apply_state *state,
+			   const char *line,
+			   struct patch *patch)
 {
 	patch->old_mode = strtoul(line, NULL, 8);
 	return 0;
 }
 
-static int gitdiff_newmode(const char *line, struct patch *patch)
+static int gitdiff_newmode(struct apply_state *state,
+			   const char *line,
+			   struct patch *patch)
 {
 	patch->new_mode = strtoul(line, NULL, 8);
 	return 0;
 }
 
-static int gitdiff_delete(const char *line, struct patch *patch)
+static int gitdiff_delete(struct apply_state *state,
+			  const char *line,
+			  struct patch *patch)
 {
 	patch->is_delete = 1;
 	free(patch->old_name);
 	patch->old_name = xstrdup_or_null(patch->def_name);
-	return gitdiff_oldmode(line, patch);
+	return gitdiff_oldmode(state, line, patch);
 }
 
-static int gitdiff_newfile(const char *line, struct patch *patch)
+static int gitdiff_newfile(struct apply_state *state,
+			   const char *line,
+			   struct patch *patch)
 {
 	patch->is_new = 1;
 	free(patch->new_name);
 	patch->new_name = xstrdup_or_null(patch->def_name);
-	return gitdiff_newmode(line, patch);
+	return gitdiff_newmode(state, line, patch);
 }
 
-static int gitdiff_copysrc(const char *line, struct patch *patch)
+static int gitdiff_copysrc(struct apply_state *state,
+			   const char *line,
+			   struct patch *patch)
 {
 	patch->is_copy = 1;
 	free(patch->old_name);
-	patch->old_name = find_name(line, NULL, state_p_value ? state_p_value - 1 : 0, 0);
+	patch->old_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
-static int gitdiff_copydst(const char *line, struct patch *patch)
+static int gitdiff_copydst(struct apply_state *state,
+			   const char *line,
+			   struct patch *patch)
 {
 	patch->is_copy = 1;
 	free(patch->new_name);
-	patch->new_name = find_name(line, NULL, state_p_value ? state_p_value - 1 : 0, 0);
+	patch->new_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
-static int gitdiff_renamesrc(const char *line, struct patch *patch)
+static int gitdiff_renamesrc(struct apply_state *state,
+			     const char *line,
+			     struct patch *patch)
 {
 	patch->is_rename = 1;
 	free(patch->old_name);
-	patch->old_name = find_name(line, NULL, state_p_value ? state_p_value - 1 : 0, 0);
+	patch->old_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
-static int gitdiff_renamedst(const char *line, struct patch *patch)
+static int gitdiff_renamedst(struct apply_state *state,
+			     const char *line,
+			     struct patch *patch)
 {
 	patch->is_rename = 1;
 	free(patch->new_name);
-	patch->new_name = find_name(line, NULL, state_p_value ? state_p_value - 1 : 0, 0);
+	patch->new_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
-static int gitdiff_similarity(const char *line, struct patch *patch)
+static int gitdiff_similarity(struct apply_state *state,
+			      const char *line,
+			      struct patch *patch)
 {
 	unsigned long val = strtoul(line, NULL, 10);
 	if (val <= 100)
@@ -1057,7 +1087,9 @@ static int gitdiff_similarity(const char *line, struct patch *patch)
 	return 0;
 }
 
-static int gitdiff_dissimilarity(const char *line, struct patch *patch)
+static int gitdiff_dissimilarity(struct apply_state *state,
+				 const char *line,
+				 struct patch *patch)
 {
 	unsigned long val = strtoul(line, NULL, 10);
 	if (val <= 100)
@@ -1065,7 +1097,9 @@ static int gitdiff_dissimilarity(const char *line, struct patch *patch)
 	return 0;
 }
 
-static int gitdiff_index(const char *line, struct patch *patch)
+static int gitdiff_index(struct apply_state *state,
+			 const char *line,
+			 struct patch *patch)
 {
 	/*
 	 * index line is N hexadecimal, "..", N hexadecimal,
@@ -1102,7 +1136,9 @@ static int gitdiff_index(const char *line, struct patch *patch)
  * This is normal for a diff that doesn't change anything: we'll fall through
  * into the next diff. Tell the parser to break out.
  */
-static int gitdiff_unrecognized(const char *line, struct patch *patch)
+static int gitdiff_unrecognized(struct apply_state *state,
+				const char *line,
+				struct patch *patch)
 {
 	return -1;
 }
@@ -1111,15 +1147,17 @@ static int gitdiff_unrecognized(const char *line, struct patch *patch)
  * Skip p_value leading components from "line"; as we do not accept
  * absolute paths, return NULL in that case.
  */
-static const char *skip_tree_prefix(const char *line, int llen)
+static const char *skip_tree_prefix(struct apply_state *state,
+				    const char *line,
+				    int llen)
 {
 	int nslash;
 	int i;
 
-	if (!state_p_value)
+	if (!state->p_value)
 		return (llen && line[0] == '/') ? NULL : line;
 
-	nslash = state_p_value;
+	nslash = state->p_value;
 	for (i = 0; i < llen; i++) {
 		int ch = line[i];
 		if (ch == '/' && --nslash <= 0)
@@ -1136,7 +1174,9 @@ static const char *skip_tree_prefix(const char *line, int llen)
  * creation or deletion of an empty file.  In any of these cases,
  * both sides are the same name under a/ and b/ respectively.
  */
-static char *git_header_name(const char *line, int llen)
+static char *git_header_name(struct apply_state *state,
+			     const char *line,
+			     int llen)
 {
 	const char *name;
 	const char *second = NULL;
@@ -1154,7 +1194,7 @@ static char *git_header_name(const char *line, int llen)
 			goto free_and_fail1;
 
 		/* strip the a/b prefix including trailing slash */
-		cp = skip_tree_prefix(first.buf, first.len);
+		cp = skip_tree_prefix(state, first.buf, first.len);
 		if (!cp)
 			goto free_and_fail1;
 		strbuf_remove(&first, 0, cp - first.buf);
@@ -1171,7 +1211,7 @@ static char *git_header_name(const char *line, int llen)
 		if (*second == '"') {
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail1;
-			cp = skip_tree_prefix(sp.buf, sp.len);
+			cp = skip_tree_prefix(state, sp.buf, sp.len);
 			if (!cp)
 				goto free_and_fail1;
 			/* They must match, otherwise ignore */
@@ -1182,7 +1222,7 @@ static char *git_header_name(const char *line, int llen)
 		}
 
 		/* unquoted second */
-		cp = skip_tree_prefix(second, line + llen - second);
+		cp = skip_tree_prefix(state, second, line + llen - second);
 		if (!cp)
 			goto free_and_fail1;
 		if (line + llen - cp != first.len ||
@@ -1197,7 +1237,7 @@ static char *git_header_name(const char *line, int llen)
 	}
 
 	/* unquoted first name */
-	name = skip_tree_prefix(line, llen);
+	name = skip_tree_prefix(state, line, llen);
 	if (!name)
 		return NULL;
 
@@ -1213,7 +1253,7 @@ static char *git_header_name(const char *line, int llen)
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail2;
 
-			np = skip_tree_prefix(sp.buf, sp.len);
+			np = skip_tree_prefix(state, sp.buf, sp.len);
 			if (!np)
 				goto free_and_fail2;
 
@@ -1257,7 +1297,7 @@ static char *git_header_name(const char *line, int llen)
 			 */
 			if (!name[len + 1])
 				return NULL; /* no postimage name */
-			second = skip_tree_prefix(name + len + 1,
+			second = skip_tree_prefix(state, name + len + 1,
 						  line_len - (len + 1));
 			if (!second)
 				return NULL;
@@ -1273,7 +1313,11 @@ static char *git_header_name(const char *line, int llen)
 }
 
 /* Verify that we recognize the lines following a git header */
-static int parse_git_header(const char *line, int len, unsigned int size, struct patch *patch)
+static int parse_git_header(struct apply_state *state,
+			    const char *line,
+			    int len,
+			    unsigned int size,
+			    struct patch *patch)
 {
 	unsigned long offset;
 
@@ -1287,7 +1331,7 @@ static int parse_git_header(const char *line, int len, unsigned int size, struct
 	 * or removing or adding empty files), so we get
 	 * the default name from the header.
 	 */
-	patch->def_name = git_header_name(line, len);
+	patch->def_name = git_header_name(state, line, len);
 	if (patch->def_name && root.len) {
 		char *s = xstrfmt("%s%s", root.buf, patch->def_name);
 		free(patch->def_name);
@@ -1300,7 +1344,7 @@ static int parse_git_header(const char *line, int len, unsigned int size, struct
 	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, linenr++) {
 		static const struct opentry {
 			const char *str;
-			int (*fn)(const char *, struct patch *);
+			int (*fn)(struct apply_state *, const char *, struct patch *);
 		} optable[] = {
 			{ "@@ -", gitdiff_hdrend },
 			{ "--- ", gitdiff_oldname },
@@ -1330,7 +1374,7 @@ static int parse_git_header(const char *line, int len, unsigned int size, struct
 			int oplen = strlen(p->str);
 			if (len < oplen || memcmp(p->str, line, oplen))
 				continue;
-			if (p->fn(line + oplen, patch) < 0)
+			if (p->fn(state, line + oplen, patch) < 0)
 				return offset;
 			break;
 		}
@@ -1500,7 +1544,7 @@ static int find_header(struct apply_state *state,
 		 * or mode change, so we handle that specially
 		 */
 		if (!memcmp("diff --git ", line, 11)) {
-			int git_hdr_len = parse_git_header(line, len, size, patch);
+			int git_hdr_len = parse_git_header(state, line, len, size, patch);
 			if (git_hdr_len <= len)
 				continue;
 			if (!patch->old_name && !patch->new_name) {
@@ -1509,8 +1553,8 @@ static int find_header(struct apply_state *state,
 					       "%d leading pathname component (line %d)",
 					       "git diff header lacks filename information when removing "
 					       "%d leading pathname components (line %d)",
-					       state_p_value),
-					    state_p_value, linenr);
+					       state->p_value),
+					    state->p_value, linenr);
 				patch->old_name = xstrdup(patch->def_name);
 				patch->new_name = xstrdup(patch->def_name);
 			}
@@ -4555,9 +4599,11 @@ static int option_parse_include(const struct option *opt,
 }
 
 static int option_parse_p(const struct option *opt,
-			  const char *arg, int unset)
+			  const char *arg,
+			  int unset)
 {
-	state_p_value = atoi(arg);
+	struct apply_state *state = opt->value;
+	state->p_value = atoi(arg);
 	p_value_known = 1;
 	return 0;
 }
@@ -4610,7 +4656,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		{ OPTION_CALLBACK, 0, "include", &state, N_("path"),
 			N_("apply changes matching the given path"),
 			0, option_parse_include },
-		{ OPTION_CALLBACK, 'p', NULL, NULL, N_("num"),
+		{ OPTION_CALLBACK, 'p', NULL, &state, N_("num"),
 			N_("remove <num> leading slashes from traditional diff paths"),
 			0, option_parse_p },
 		OPT_BOOL(0, "no-add", &state.no_add,
@@ -4677,6 +4723,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	state.prefix_length = state.prefix ? strlen(state.prefix) : 0;
 	state.apply = 1;
 	state.line_termination = '\n';
+	state.p_value = 1;
 	state.p_context = UINT_MAX;
 
 	git_apply_config();
-- 
2.8.1.300.g5fed0c0
