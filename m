From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 32/49] builtin/apply: move 'p_value' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:09 +0200
Message-ID: <20160524081126.16973-33-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:14:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57TZ-0001Ss-OY
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbcEXIMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33883 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669AbcEXIMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id n129so3661075wmn.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iOiRH4RZWX6V4qU/vO+jGeOaDgBXNHMIPXacq6oj1xs=;
        b=ijADGPdqVDvyidBwOAYsLY5hPJsJSdtkcKpBzfX5VHzD2av/hVIQcRQ364nUKd9yvs
         3TUb9bMUeR04Ow/Cdun28Qblnl7sOgn1CtruRRx50Wa8GgQ5lAJ43NVcG1b4JeYvJvIu
         TPeTAPjxxQk1U2qXXJ2inoX1lb+q0iDIirb7IrXQ4oA1coB9Hnelf+AHySuC+n7TZa8X
         x0rTHsvskaPBFDDYBXZElvjQmh7x4aFT5rZgtgA21HpmfGDVIFnoYwkQp3fJoHbpIu9f
         UhFidFwVEvFfyRed6IyvWD3JunuiyIyjJ+Zx7z5XY73cwzoW5wTzkH+wYJlRD1kpYELJ
         01JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iOiRH4RZWX6V4qU/vO+jGeOaDgBXNHMIPXacq6oj1xs=;
        b=baKs2QdmUxIMT6CPsJ/ubOMG3Mi84udp5dPLrfQDtyToSNBSZpcko6VZZ7N6GffJbf
         2X477YpBI+nNCmWRu+XZBg20yc8fLXEiMh/JB7uplX6GxCg7076silLbhVvXyQl7bRwv
         jMEW6BiaWz/0QfVnsdy1BBxjQSdFqWbRiaxmU5CJXsckvzNbviOCUcKKbMgQmMyzxIPB
         ShXU18saQ4bdAQh4D6ShVJYh6VlA6Hss9tiTc4dqYOMOAf84AQ8SRvr1HBMmb+ECuqOU
         9YYQ8ymrRvIlrZYHcQCQr3x6D2Ij/+pyEIO+ZIHOYKvzetF+YYOLuNMxbRZ8ZcGRCG88
         /bvg==
X-Gm-Message-State: ALyK8tLK5zyhKm026tjkkSqjAyvQV7Enn1mKB47AHBlVU4S1+nx2bhxw1G+pcsx+jNigdg==
X-Received: by 10.28.4.79 with SMTP id 76mr10554510wme.41.1464077549392;
        Tue, 24 May 2016 01:12:29 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:28 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295452>

To libify the apply functionality the 'p_value' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 151 +++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 99 insertions(+), 52 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ebbc711..843fafd 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -51,6 +51,7 @@ struct apply_state {
 	const char *fake_ancestor;
 	const char *patch_input_file;
 	int line_termination;
+	int p_value;
 	unsigned int p_context;
 
 	/* Exclude and include path parameters */
@@ -60,7 +61,6 @@ struct apply_state {
 
 static int newfd = -1;
 
-static int state_p_value = 1;
 static int p_value_known;
 
 static const char * const apply_usage[] = {
@@ -881,24 +881,24 @@ static void parse_traditional_patch(struct apply_state *state,
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
@@ -917,7 +917,9 @@ static void parse_traditional_patch(struct apply_state *state,
 		die(_("unable to find filename in patch at line %d"), state_linenr);
 }
 
-static int gitdiff_hdrend(const char *line, struct patch *patch)
+static int gitdiff_hdrend(struct apply_state *state,
+			  const char *line,
+			  struct patch *patch)
 {
 	return -1;
 }
@@ -934,10 +936,14 @@ static int gitdiff_hdrend(const char *line, struct patch *patch)
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
 
@@ -947,7 +953,7 @@ static void gitdiff_verify_name(const char *line, int isnull, char **name, int s
 		if (isnull)
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
 			    *name, state_linenr);
-		another = find_name(line, NULL, state_p_value, TERM_TAB);
+		another = find_name(line, NULL, state->p_value, TERM_TAB);
 		if (!another || memcmp(another, *name, len + 1))
 			die((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
@@ -960,81 +966,105 @@ static void gitdiff_verify_name(const char *line, int isnull, char **name, int s
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
@@ -1042,7 +1072,9 @@ static int gitdiff_similarity(const char *line, struct patch *patch)
 	return 0;
 }
 
-static int gitdiff_dissimilarity(const char *line, struct patch *patch)
+static int gitdiff_dissimilarity(struct apply_state *state,
+				 const char *line,
+				 struct patch *patch)
 {
 	unsigned long val = strtoul(line, NULL, 10);
 	if (val <= 100)
@@ -1050,7 +1082,9 @@ static int gitdiff_dissimilarity(const char *line, struct patch *patch)
 	return 0;
 }
 
-static int gitdiff_index(const char *line, struct patch *patch)
+static int gitdiff_index(struct apply_state *state,
+			 const char *line,
+			 struct patch *patch)
 {
 	/*
 	 * index line is N hexadecimal, "..", N hexadecimal,
@@ -1087,7 +1121,9 @@ static int gitdiff_index(const char *line, struct patch *patch)
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
@@ -1096,15 +1132,17 @@ static int gitdiff_unrecognized(const char *line, struct patch *patch)
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
@@ -1121,7 +1159,9 @@ static const char *skip_tree_prefix(const char *line, int llen)
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
@@ -1139,7 +1179,7 @@ static char *git_header_name(const char *line, int llen)
 			goto free_and_fail1;
 
 		/* strip the a/b prefix including trailing slash */
-		cp = skip_tree_prefix(first.buf, first.len);
+		cp = skip_tree_prefix(state, first.buf, first.len);
 		if (!cp)
 			goto free_and_fail1;
 		strbuf_remove(&first, 0, cp - first.buf);
@@ -1156,7 +1196,7 @@ static char *git_header_name(const char *line, int llen)
 		if (*second == '"') {
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail1;
-			cp = skip_tree_prefix(sp.buf, sp.len);
+			cp = skip_tree_prefix(state, sp.buf, sp.len);
 			if (!cp)
 				goto free_and_fail1;
 			/* They must match, otherwise ignore */
@@ -1167,7 +1207,7 @@ static char *git_header_name(const char *line, int llen)
 		}
 
 		/* unquoted second */
-		cp = skip_tree_prefix(second, line + llen - second);
+		cp = skip_tree_prefix(state, second, line + llen - second);
 		if (!cp)
 			goto free_and_fail1;
 		if (line + llen - cp != first.len ||
@@ -1182,7 +1222,7 @@ static char *git_header_name(const char *line, int llen)
 	}
 
 	/* unquoted first name */
-	name = skip_tree_prefix(line, llen);
+	name = skip_tree_prefix(state, line, llen);
 	if (!name)
 		return NULL;
 
@@ -1198,7 +1238,7 @@ static char *git_header_name(const char *line, int llen)
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail2;
 
-			np = skip_tree_prefix(sp.buf, sp.len);
+			np = skip_tree_prefix(state, sp.buf, sp.len);
 			if (!np)
 				goto free_and_fail2;
 
@@ -1242,7 +1282,7 @@ static char *git_header_name(const char *line, int llen)
 			 */
 			if (!name[len + 1])
 				return NULL; /* no postimage name */
-			second = skip_tree_prefix(name + len + 1,
+			second = skip_tree_prefix(state, name + len + 1,
 						  line_len - (len + 1));
 			if (!second)
 				return NULL;
@@ -1258,7 +1298,11 @@ static char *git_header_name(const char *line, int llen)
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
 
@@ -1272,7 +1316,7 @@ static int parse_git_header(const char *line, int len, unsigned int size, struct
 	 * or removing or adding empty files), so we get
 	 * the default name from the header.
 	 */
-	patch->def_name = git_header_name(line, len);
+	patch->def_name = git_header_name(state, line, len);
 	if (patch->def_name && root.len) {
 		char *s = xstrfmt("%s%s", root.buf, patch->def_name);
 		free(patch->def_name);
@@ -1285,7 +1329,7 @@ static int parse_git_header(const char *line, int len, unsigned int size, struct
 	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, state_linenr++) {
 		static const struct opentry {
 			const char *str;
-			int (*fn)(const char *, struct patch *);
+			int (*fn)(struct apply_state *, const char *, struct patch *);
 		} optable[] = {
 			{ "@@ -", gitdiff_hdrend },
 			{ "--- ", gitdiff_oldname },
@@ -1315,7 +1359,7 @@ static int parse_git_header(const char *line, int len, unsigned int size, struct
 			int oplen = strlen(p->str);
 			if (len < oplen || memcmp(p->str, line, oplen))
 				continue;
-			if (p->fn(line + oplen, patch) < 0)
+			if (p->fn(state, line + oplen, patch) < 0)
 				return offset;
 			break;
 		}
@@ -1485,7 +1529,7 @@ static int find_header(struct apply_state *state,
 		 * or mode change, so we handle that specially
 		 */
 		if (!memcmp("diff --git ", line, 11)) {
-			int git_hdr_len = parse_git_header(line, len, size, patch);
+			int git_hdr_len = parse_git_header(state, line, len, size, patch);
 			if (git_hdr_len <= len)
 				continue;
 			if (!patch->old_name && !patch->new_name) {
@@ -1494,8 +1538,8 @@ static int find_header(struct apply_state *state,
 					       "%d leading pathname component (line %d)",
 					       "git diff header lacks filename information when removing "
 					       "%d leading pathname components (line %d)",
-					       state_p_value),
-					    state_p_value, state_linenr);
+					       state->p_value),
+					    state->p_value, state_linenr);
 				patch->old_name = xstrdup(patch->def_name);
 				patch->new_name = xstrdup(patch->def_name);
 			}
@@ -4539,9 +4583,11 @@ static int option_parse_include(const struct option *opt,
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
@@ -4582,6 +4628,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
 	state->apply = 1;
 	state->line_termination = '\n';
+	state->p_value = 1;
 	state->p_context = UINT_MAX;
 
 	git_apply_config();
@@ -4615,7 +4662,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "include", &state, N_("path"),
 			N_("apply changes matching the given path"),
 			0, option_parse_include },
-		{ OPTION_CALLBACK, 'p', NULL, NULL, N_("num"),
+		{ OPTION_CALLBACK, 'p', NULL, &state, N_("num"),
 			N_("remove <num> leading slashes from traditional diff paths"),
 			0, option_parse_p },
 		OPT_BOOL(0, "no-add", &state.no_add,
-- 
2.8.3.443.gaeee61e
