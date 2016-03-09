From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 32/48] builtin/apply: move 'p_value' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:49:00 +0100
Message-ID: <1457545756-20616-33-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiIz-00006C-8u
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933759AbcCIRxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:49 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34568 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933725AbcCIRx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:28 -0500
Received: by mail-wm0-f52.google.com with SMTP id p65so203139454wmp.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ki8FtJdqj8J+J/cG0n2eEDE6fiA8N9W34fJRod94R0=;
        b=UgHnfVQy8JMMLxeX8Cm4JuvaeoYyoXDYPo+xIBZhrbb61Xszue8aPd3ehA4FwNXfO+
         SEphMLv5ykNyJvKVpFFep80NmsGbRwO8X2F5n4zxmcqdskZ3MyYSo7g35LXjMAH6b6Sp
         DaoqRW7vb/xpPq31DiDlyaD9P0UuIq99Xi9CzmJNdJ+98zqwacn3kav+o+fMcIibAPjK
         ybZN5+IeEn7tZivOQSQ18kAjH7kw38ePaTMBLmVNEO/e7QtpOm2sy866jWzeZKdLZ4G/
         9QAnZRTdzSWs1W2LqaDVFpKvvA69Y4gVU5chpKaIyz6L5rCO8YiqexKw2AB4sy7wrkMQ
         6yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ki8FtJdqj8J+J/cG0n2eEDE6fiA8N9W34fJRod94R0=;
        b=CEJo9X9wyHNw/lggvHVg3Y9CuYDh388JBOBg6O4ANuvqBliS+UrTv2G3EuXVWUvTR7
         vKbkyJ/tiLjQIZTJZzd40R6uGRmOVoOckRjjhKRqXWL6reBpUyWTEa91cjNr7I9yv5Cj
         xcBV66AsmhJfJWjSWvLaI7/EBlUjHqqwuaw3DoI/RVehXWhv+JS4g9Mxuh43RFiUh0Pr
         TrepTcAIlu7xLrxKV7ymEErNSJRhTrMUTjgRl/5mI8OG0Of1YtupvbDV/Rjwiz+7LX6V
         jed5wzxZTRHceAMoOQFdsKZhpvgIklzviOGvL5fl0CbGr/2nCYOucLaMCODdO9I6KKJe
         iMxw==
X-Gm-Message-State: AD7BkJLkHntEcWTP5/CvR0mh+4tDSEoTRzYF9t4NzXREDH7SmPQRrMHUbwUG+HrMsNuPPg==
X-Received: by 10.194.112.98 with SMTP id ip2mr37308577wjb.24.1457546006833;
        Wed, 09 Mar 2016 09:53:26 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:25 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288520>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 151 +++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 99 insertions(+), 52 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index fa2940d..8d4a900 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -66,6 +66,7 @@ struct apply_state {
 
 	int line_termination;
 
+	int p_value;
 	unsigned int p_context;
 
 	struct lock_file lock_file;
@@ -76,7 +77,6 @@ struct apply_state {
 	int has_include;
 };
 
-static int p_value = 1;
 static int p_value_known;
 
 static const char * const apply_usage[] = {
@@ -897,24 +897,24 @@ static void parse_traditional_patch(struct apply_state *state,
 		q = guess_p_value(state, second);
 		if (p < 0) p = q;
 		if (0 <= p && p == q) {
-			p_value = p;
+			state->p_value = p;
 			p_value_known = 1;
 		}
 	}
 	if (is_dev_null(first)) {
 		patch->is_new = 1;
 		patch->is_delete = 0;
-		name = find_name_traditional(second, NULL, p_value);
+		name = find_name_traditional(second, NULL, state->p_value);
 		patch->new_name = name;
 	} else if (is_dev_null(second)) {
 		patch->is_new = 0;
 		patch->is_delete = 1;
-		name = find_name_traditional(first, NULL, p_value);
+		name = find_name_traditional(first, NULL, state->p_value);
 		patch->old_name = name;
 	} else {
 		char *first_name;
-		first_name = find_name_traditional(first, NULL, p_value);
-		name = find_name_traditional(second, first_name, p_value);
+		first_name = find_name_traditional(first, NULL, state->p_value);
+		name = find_name_traditional(second, first_name, state->p_value);
 		free(first_name);
 		if (has_epoch_timestamp(first)) {
 			patch->is_new = 1;
@@ -933,7 +933,9 @@ static void parse_traditional_patch(struct apply_state *state,
 		die(_("unable to find filename in patch at line %d"), linenr);
 }
 
-static int gitdiff_hdrend(const char *line, struct patch *patch)
+static int gitdiff_hdrend(struct apply_state *state,
+			  const char *line,
+			  struct patch *patch)
 {
 	return -1;
 }
@@ -950,10 +952,14 @@ static int gitdiff_hdrend(const char *line, struct patch *patch)
 #define DIFF_OLD_NAME 0
 #define DIFF_NEW_NAME 1
 
-static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name, int side)
+static char *gitdiff_verify_name(struct apply_state *state,
+				 const char *line,
+				 int isnull,
+				 char *orig_name,
+				 int side)
 {
 	if (!orig_name && !isnull)
-		return find_name(line, NULL, p_value, TERM_TAB);
+		return find_name(line, NULL, state->p_value, TERM_TAB);
 
 	if (orig_name) {
 		int len;
@@ -963,7 +969,7 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
 		len = strlen(name);
 		if (isnull)
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"), name, linenr);
-		another = find_name(line, NULL, p_value, TERM_TAB);
+		another = find_name(line, NULL, state->p_value, TERM_TAB);
 		if (!another || memcmp(another, name, len + 1))
 			die((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
@@ -979,87 +985,111 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
 	}
 }
 
-static int gitdiff_oldname(const char *line, struct patch *patch)
+static int gitdiff_oldname(struct apply_state *state,
+			   const char *line,
+			   struct patch *patch)
 {
 	char *orig = patch->old_name;
-	patch->old_name = gitdiff_verify_name(line, patch->is_new, patch->old_name,
+	patch->old_name = gitdiff_verify_name(state, line,
+					      patch->is_new, patch->old_name,
 					      DIFF_OLD_NAME);
 	if (orig != patch->old_name)
 		free(orig);
 	return 0;
 }
 
-static int gitdiff_newname(const char *line, struct patch *patch)
+static int gitdiff_newname(struct apply_state *state,
+			   const char *line,
+			   struct patch *patch)
 {
 	char *orig = patch->new_name;
-	patch->new_name = gitdiff_verify_name(line, patch->is_delete, patch->new_name,
+	patch->new_name = gitdiff_verify_name(state, line,
+					      patch->is_delete, patch->new_name,
 					      DIFF_NEW_NAME);
 	if (orig != patch->new_name)
 		free(orig);
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
-	patch->old_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
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
-	patch->new_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
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
-	patch->old_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
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
-	patch->new_name = find_name(line, NULL, p_value ? p_value - 1 : 0, 0);
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
@@ -1067,7 +1097,9 @@ static int gitdiff_similarity(const char *line, struct patch *patch)
 	return 0;
 }
 
-static int gitdiff_dissimilarity(const char *line, struct patch *patch)
+static int gitdiff_dissimilarity(struct apply_state *state,
+				 const char *line,
+				 struct patch *patch)
 {
 	unsigned long val = strtoul(line, NULL, 10);
 	if (val <= 100)
@@ -1075,7 +1107,9 @@ static int gitdiff_dissimilarity(const char *line, struct patch *patch)
 	return 0;
 }
 
-static int gitdiff_index(const char *line, struct patch *patch)
+static int gitdiff_index(struct apply_state *state,
+			 const char *line,
+			 struct patch *patch)
 {
 	/*
 	 * index line is N hexadecimal, "..", N hexadecimal,
@@ -1112,7 +1146,9 @@ static int gitdiff_index(const char *line, struct patch *patch)
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
@@ -1121,15 +1157,17 @@ static int gitdiff_unrecognized(const char *line, struct patch *patch)
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
 
-	if (!p_value)
+	if (!state->p_value)
 		return (llen && line[0] == '/') ? NULL : line;
 
-	nslash = p_value;
+	nslash = state->p_value;
 	for (i = 0; i < llen; i++) {
 		int ch = line[i];
 		if (ch == '/' && --nslash <= 0)
@@ -1146,7 +1184,9 @@ static const char *skip_tree_prefix(const char *line, int llen)
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
@@ -1164,7 +1204,7 @@ static char *git_header_name(const char *line, int llen)
 			goto free_and_fail1;
 
 		/* strip the a/b prefix including trailing slash */
-		cp = skip_tree_prefix(first.buf, first.len);
+		cp = skip_tree_prefix(state, first.buf, first.len);
 		if (!cp)
 			goto free_and_fail1;
 		strbuf_remove(&first, 0, cp - first.buf);
@@ -1181,7 +1221,7 @@ static char *git_header_name(const char *line, int llen)
 		if (*second == '"') {
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail1;
-			cp = skip_tree_prefix(sp.buf, sp.len);
+			cp = skip_tree_prefix(state, sp.buf, sp.len);
 			if (!cp)
 				goto free_and_fail1;
 			/* They must match, otherwise ignore */
@@ -1192,7 +1232,7 @@ static char *git_header_name(const char *line, int llen)
 		}
 
 		/* unquoted second */
-		cp = skip_tree_prefix(second, line + llen - second);
+		cp = skip_tree_prefix(state, second, line + llen - second);
 		if (!cp)
 			goto free_and_fail1;
 		if (line + llen - cp != first.len ||
@@ -1207,7 +1247,7 @@ static char *git_header_name(const char *line, int llen)
 	}
 
 	/* unquoted first name */
-	name = skip_tree_prefix(line, llen);
+	name = skip_tree_prefix(state, line, llen);
 	if (!name)
 		return NULL;
 
@@ -1223,7 +1263,7 @@ static char *git_header_name(const char *line, int llen)
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail2;
 
-			np = skip_tree_prefix(sp.buf, sp.len);
+			np = skip_tree_prefix(state, sp.buf, sp.len);
 			if (!np)
 				goto free_and_fail2;
 
@@ -1267,7 +1307,7 @@ static char *git_header_name(const char *line, int llen)
 			 */
 			if (!name[len + 1])
 				return NULL; /* no postimage name */
-			second = skip_tree_prefix(name + len + 1,
+			second = skip_tree_prefix(state, name + len + 1,
 						  line_len - (len + 1));
 			if (!second)
 				return NULL;
@@ -1283,7 +1323,11 @@ static char *git_header_name(const char *line, int llen)
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
 
@@ -1297,7 +1341,7 @@ static int parse_git_header(const char *line, int len, unsigned int size, struct
 	 * or removing or adding empty files), so we get
 	 * the default name from the header.
 	 */
-	patch->def_name = git_header_name(line, len);
+	patch->def_name = git_header_name(state, line, len);
 	if (patch->def_name && root.len) {
 		char *s = xstrfmt("%s%s", root.buf, patch->def_name);
 		free(patch->def_name);
@@ -1310,7 +1354,7 @@ static int parse_git_header(const char *line, int len, unsigned int size, struct
 	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, linenr++) {
 		static const struct opentry {
 			const char *str;
-			int (*fn)(const char *, struct patch *);
+			int (*fn)(struct apply_state *, const char *, struct patch *);
 		} optable[] = {
 			{ "@@ -", gitdiff_hdrend },
 			{ "--- ", gitdiff_oldname },
@@ -1340,7 +1384,7 @@ static int parse_git_header(const char *line, int len, unsigned int size, struct
 			int oplen = strlen(p->str);
 			if (len < oplen || memcmp(p->str, line, oplen))
 				continue;
-			if (p->fn(line + oplen, patch) < 0)
+			if (p->fn(state, line + oplen, patch) < 0)
 				return offset;
 			break;
 		}
@@ -1510,7 +1554,7 @@ static int find_header(struct apply_state *state,
 		 * or mode change, so we handle that specially
 		 */
 		if (!memcmp("diff --git ", line, 11)) {
-			int git_hdr_len = parse_git_header(line, len, size, patch);
+			int git_hdr_len = parse_git_header(state, line, len, size, patch);
 			if (git_hdr_len <= len)
 				continue;
 			if (!patch->old_name && !patch->new_name) {
@@ -1519,8 +1563,8 @@ static int find_header(struct apply_state *state,
 					       "%d leading pathname component (line %d)",
 					       "git diff header lacks filename information when removing "
 					       "%d leading pathname components (line %d)",
-					       p_value),
-					    p_value, linenr);
+					       state->p_value),
+					    state->p_value, linenr);
 				patch->old_name = xstrdup(patch->def_name);
 				patch->new_name = xstrdup(patch->def_name);
 			}
@@ -4552,9 +4596,11 @@ static int option_parse_include(const struct option *opt,
 }
 
 static int option_parse_p(const struct option *opt,
-			  const char *arg, int unset)
+			  const char *arg,
+			  int unset)
 {
-	p_value = atoi(arg);
+	struct apply_state *state = opt->value;
+	state->p_value = atoi(arg);
 	p_value_known = 1;
 	return 0;
 }
@@ -4607,7 +4653,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		{ OPTION_CALLBACK, 0, "include", &state, N_("path"),
 			N_("apply changes matching the given path"),
 			0, option_parse_include },
-		{ OPTION_CALLBACK, 'p', NULL, NULL, N_("num"),
+		{ OPTION_CALLBACK, 'p', NULL, &state, N_("num"),
 			N_("remove <num> leading slashes from traditional diff paths"),
 			0, option_parse_p },
 		OPT_BOOL(0, "no-add", &state.no_add,
@@ -4675,6 +4721,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	state.apply = 1;
 	state.newfd = -1;
 	state.line_termination = '\n';
+	state.p_value = 1;
 	state.p_context = UINT_MAX;
 
 	git_apply_config();
-- 
2.8.0.rc1.49.gca61272
