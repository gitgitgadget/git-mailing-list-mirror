From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 34/94] builtin/apply: move 'root' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:45 +0200
Message-ID: <20160511131745.2914-35-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:19:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3K-0002jQ-L2
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbcEKNTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33024 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbcEKNTg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id r12so9409804wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cWkTBIDjS7mOdx3ENBLfxbr8Y68hPW0eNk1TDhz/bEo=;
        b=ZYexEBJyqi18maPOWEGrHMZFtL7Y4fTecSVKX0rPkCyfhpkshHA1dqNIOEKmCRzVNA
         kDsNT3Kmc35QSDL04AkDrqGBQjIONr2Qi7kZuuY1qcuLJ1RN91dnHRtohUUgYpF0UOxh
         ulYhlujA0QsGRIFiU5ZXgLjL4RKPGtEdNCW6pj/jTu7F35J+XTalT9ZdV5o2s9F7y+Hw
         58PetvRc2qHmJZfClCdl48c+/PYB1nKUKM7vK/qSrQBC90uVgI8m5Bcur+bAEsPd9C27
         SMkf+uENaikAf9Nh9XiwNo53TA+w26tS6J9gaYUHJZ9n0X6LFbwu9BDefa9UCNIlRAG9
         ixBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cWkTBIDjS7mOdx3ENBLfxbr8Y68hPW0eNk1TDhz/bEo=;
        b=R1LuQakc/MvUxqwHAHxt5o3pmSw8HeVTr9xQHaa5tR750LXe5n+J9EGEniJkgt7/mo
         NmZgSBrFv+80lyWYspWUxkvwI41f7ThOjiwyYIOOQZ2aVXhBUwmrEwIGvRnP5tOc2Krv
         9ZGNbhsIGIj0gDcIbuiXOI867mUq0/QYK8P2ptp/6yvGsvEUxMsYejmWR5cVsiNEyViY
         bPZD5lugMCa5FfWAS964aIuQWO1QoWg0Fwk+XZ+N0zl+CpWMto8t9vrYz65pOrdEe7l2
         QxbkXIy5YcQBXFyn1KhSL2VjlQsf6j9WEV2rPgkZT33HNXKkqqvX3mhXpekbnKat32GW
         OSHw==
X-Gm-Message-State: AOPr4FUQEWYrMmK1Z398UDQYM14+94slBNaSmkW548z/gpEaZqcBN2lvwuoBSy8ZIZ1rPQ==
X-Received: by 10.28.172.132 with SMTP id v126mr4444242wme.28.1462972775607;
        Wed, 11 May 2016 06:19:35 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:34 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294268>

To libify the apply functionality the 'root' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 81 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 33 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 30eea9c..6b3540f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -47,6 +47,7 @@ struct apply_state {
 	const char *patch_input_file;
 	struct string_list limit_by_name;
 	int has_include;
+	struct strbuf root;
 
 	/*
 	 *  --check turns on checking that the working tree matches the
@@ -90,8 +91,6 @@ static enum ws_ignore {
 } ws_ignore_action = ignore_ws_none;
 
 
-static struct strbuf root = STRBUF_INIT;
-
 static void parse_whitespace_option(const char *option)
 {
 	if (!option) {
@@ -481,7 +480,10 @@ static char *squash_slash(char *name)
 	return name;
 }
 
-static char *find_name_gnu(const char *line, const char *def, int p_value)
+static char *find_name_gnu(struct apply_state *state,
+			   const char *line,
+			   const char *def,
+			   int p_value)
 {
 	struct strbuf name = STRBUF_INIT;
 	char *cp;
@@ -505,8 +507,8 @@ static char *find_name_gnu(const char *line, const char *def, int p_value)
 	}
 
 	strbuf_remove(&name, 0, cp - name.buf);
-	if (root.len)
-		strbuf_insert(&name, 0, root.buf, root.len);
+	if (state->root.len)
+		strbuf_insert(&name, 0, state->root.buf, state->root.len);
 	return squash_slash(strbuf_detach(&name, NULL));
 }
 
@@ -669,8 +671,12 @@ static size_t diff_timestamp_len(const char *line, size_t len)
 	return line + len - end;
 }
 
-static char *find_name_common(const char *line, const char *def,
-			      int p_value, const char *end, int terminate)
+static char *find_name_common(struct apply_state *state,
+			      const char *line,
+			      const char *def,
+			      int p_value,
+			      const char *end,
+			      int terminate)
 {
 	int len;
 	const char *start = NULL;
@@ -708,32 +714,39 @@ static char *find_name_common(const char *line, const char *def,
 			return squash_slash(xstrdup(def));
 	}
 
-	if (root.len) {
-		char *ret = xstrfmt("%s%.*s", root.buf, len, start);
+	if (state->root.len) {
+		char *ret = xstrfmt("%s%.*s", state->root.buf, len, start);
 		return squash_slash(ret);
 	}
 
 	return squash_slash(xmemdupz(start, len));
 }
 
-static char *find_name(const char *line, char *def, int p_value, int terminate)
+static char *find_name(struct apply_state *state,
+		       const char *line,
+		       char *def,
+		       int p_value,
+		       int terminate)
 {
 	if (*line == '"') {
-		char *name = find_name_gnu(line, def, p_value);
+		char *name = find_name_gnu(state, line, def, p_value);
 		if (name)
 			return name;
 	}
 
-	return find_name_common(line, def, p_value, NULL, terminate);
+	return find_name_common(state, line, def, p_value, NULL, terminate);
 }
 
-static char *find_name_traditional(const char *line, char *def, int p_value)
+static char *find_name_traditional(struct apply_state *state,
+				   const char *line,
+				   char *def,
+				   int p_value)
 {
 	size_t len;
 	size_t date_len;
 
 	if (*line == '"') {
-		char *name = find_name_gnu(line, def, p_value);
+		char *name = find_name_gnu(state, line, def, p_value);
 		if (name)
 			return name;
 	}
@@ -741,10 +754,10 @@ static char *find_name_traditional(const char *line, char *def, int p_value)
 	len = strchrnul(line, '\n') - line;
 	date_len = diff_timestamp_len(line, len);
 	if (!date_len)
-		return find_name_common(line, def, p_value, NULL, TERM_TAB);
+		return find_name_common(state, line, def, p_value, NULL, TERM_TAB);
 	len -= date_len;
 
-	return find_name_common(line, def, p_value, line + len, 0);
+	return find_name_common(state, line, def, p_value, line + len, 0);
 }
 
 static int count_slashes(const char *cp)
@@ -769,7 +782,7 @@ static int guess_p_value(struct apply_state *state, const char *nameline)
 
 	if (is_dev_null(nameline))
 		return -1;
-	name = find_name_traditional(nameline, NULL, 0);
+	name = find_name_traditional(state, nameline, NULL, 0);
 	if (!name)
 		return -1;
 	cp = strchr(name, '/');
@@ -894,17 +907,17 @@ static void parse_traditional_patch(struct apply_state *state,
 	if (is_dev_null(first)) {
 		patch->is_new = 1;
 		patch->is_delete = 0;
-		name = find_name_traditional(second, NULL, state->p_value);
+		name = find_name_traditional(state, second, NULL, state->p_value);
 		patch->new_name = name;
 	} else if (is_dev_null(second)) {
 		patch->is_new = 0;
 		patch->is_delete = 1;
-		name = find_name_traditional(first, NULL, state->p_value);
+		name = find_name_traditional(state, first, NULL, state->p_value);
 		patch->old_name = name;
 	} else {
 		char *first_name;
-		first_name = find_name_traditional(first, NULL, state->p_value);
-		name = find_name_traditional(second, first_name, state->p_value);
+		first_name = find_name_traditional(state, first, NULL, state->p_value);
+		name = find_name_traditional(state, second, first_name, state->p_value);
 		free(first_name);
 		if (has_epoch_timestamp(first)) {
 			patch->is_new = 1;
@@ -949,7 +962,7 @@ static void gitdiff_verify_name(struct apply_state *state,
 				int side)
 {
 	if (!*name && !isnull) {
-		*name = find_name(line, NULL, state->p_value, TERM_TAB);
+		*name = find_name(state, line, NULL, state->p_value, TERM_TAB);
 		return;
 	}
 
@@ -959,7 +972,7 @@ static void gitdiff_verify_name(struct apply_state *state,
 		if (isnull)
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
 			    *name, state_linenr);
-		another = find_name(line, NULL, state->p_value, TERM_TAB);
+		another = find_name(state, line, NULL, state->p_value, TERM_TAB);
 		if (!another || memcmp(another, *name, len + 1))
 			die((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
@@ -1034,7 +1047,7 @@ static int gitdiff_copysrc(struct apply_state *state,
 {
 	patch->is_copy = 1;
 	free(patch->old_name);
-	patch->old_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->old_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1044,7 +1057,7 @@ static int gitdiff_copydst(struct apply_state *state,
 {
 	patch->is_copy = 1;
 	free(patch->new_name);
-	patch->new_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->new_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1054,7 +1067,7 @@ static int gitdiff_renamesrc(struct apply_state *state,
 {
 	patch->is_rename = 1;
 	free(patch->old_name);
-	patch->old_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->old_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1064,7 +1077,7 @@ static int gitdiff_renamedst(struct apply_state *state,
 {
 	patch->is_rename = 1;
 	free(patch->new_name);
-	patch->new_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->new_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1323,8 +1336,8 @@ static int parse_git_header(struct apply_state *state,
 	 * the default name from the header.
 	 */
 	patch->def_name = git_header_name(state, line, len);
-	if (patch->def_name && root.len) {
-		char *s = xstrfmt("%s%s", root.buf, patch->def_name);
+	if (patch->def_name && state->root.len) {
+		char *s = xstrfmt("%s%s", state->root.buf, patch->def_name);
 		free(patch->def_name);
 		patch->def_name = s;
 	}
@@ -4621,9 +4634,10 @@ static int option_parse_whitespace(const struct option *opt,
 static int option_parse_directory(const struct option *opt,
 				  const char *arg, int unset)
 {
-	strbuf_reset(&root);
-	strbuf_addstr(&root, arg);
-	strbuf_complete(&root, '/');
+	struct apply_state *state = opt->value;
+	strbuf_reset(&state->root);
+	strbuf_addstr(&state->root, arg);
+	strbuf_complete(&state->root, '/');
 	return 0;
 }
 
@@ -4636,6 +4650,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	state->line_termination = '\n';
 	state->p_value = 1;
 	state->p_context = UINT_MAX;
+	strbuf_init(&state->root, 0);
 
 	git_apply_config();
 	if (apply_default_whitespace)
@@ -4719,7 +4734,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		OPT_BIT(0, "recount", &options,
 			N_("do not trust the line counts in the hunk headers"),
 			RECOUNT),
-		{ OPTION_CALLBACK, 0, "directory", NULL, N_("root"),
+		{ OPTION_CALLBACK, 0, "directory", &state, N_("root"),
 			N_("prepend <root> to all filenames"),
 			0, option_parse_directory },
 		OPT_END()
-- 
2.8.2.490.g3dabe57
