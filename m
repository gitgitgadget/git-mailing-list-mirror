From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 34/48] builtin/apply: move 'root' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:49:02 +0100
Message-ID: <1457545756-20616-35-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiIy-00006C-Cg
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933604AbcCIRxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:45 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34661 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933759AbcCIRxe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:34 -0500
Received: by mail-wm0-f42.google.com with SMTP id p65so203142713wmp.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0f5qtoR8Xzl4oObhUCjZnCIcdOyDXpvy4CmI21/PWX0=;
        b=F27uud0ygBMXReoL7i06cnh2QEWr7mhJPGmBy6VkVq8B+xLx3zKGlmACVxtdLn0G5d
         RO0iqba1Cjf8E7Fqbz1lT/azqqaj5QRtYJ49blpUbifUO6Gg8y/ZWD/FqUSrMM5kFDA3
         NTJu9JemLwMeWyN6DRpHx5/MutkjJfjqV39cQdy849ZLeTnEkHq0jLC86Kk2v7YAQqfU
         imD4wyG8rUcVrqY+B7tHksslY9d3WmFnqe0qi1HSLzCJzmTRC9eXk3P57rMmOtdwrf4U
         K26UBuCMyN6z2bvE8eWuPTkOeKH50CVARFI7ti3RwT9k5/b450walRQRppwtga1oQkg5
         WXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0f5qtoR8Xzl4oObhUCjZnCIcdOyDXpvy4CmI21/PWX0=;
        b=LUQXpRpfepvYwXPzPg2IHrgqbMKQ12yNd38VU4FGWfymt6X1Viu36v2SiIxT7xq04G
         +vXAZzebxJY7wPmdiAeIyt5SpIejc0cZ52XVN7uXVTXtPpTFRLkGR15gFYNOmR6kqE3T
         YPKO4xf5nJRrJDXhwkRrXiDaHMXFF+L1A2c18NVJk2pcg3wg+Hd5O/hRR08lWuW4TupL
         DRqdMD29vqjdE13Tm5MtXlZSdz30tN3ooTEgZoVT870cMKCE93TpdexNMjQrG7FRSETW
         T5D00htOYZW541Zp7ND3aQ9HQl1DccSJkCYiDW2HJuQRxBWVmFlOC92XPGU8ozvDi5AZ
         Vb7w==
X-Gm-Message-State: AD7BkJIRxcL+bRuDbztydsED3cNElv+N0glIN12oY5k40umbjyrCjKF3t09QhacEvudkhA==
X-Received: by 10.194.5.194 with SMTP id u2mr36554218wju.139.1457546012618;
        Wed, 09 Mar 2016 09:53:32 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:31 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288521>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 82 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index cb995c8..8571646 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -76,6 +76,8 @@ struct apply_state {
 
 	struct string_list limit_by_name;
 	int has_include;
+
+	struct strbuf root;
 };
 
 static const char * const apply_usage[] = {
@@ -99,8 +101,6 @@ static enum ws_ignore {
 } ws_ignore_action = ignore_ws_none;
 
 
-static struct strbuf root = STRBUF_INIT;
-
 static void parse_whitespace_option(const char *option)
 {
 	if (!option) {
@@ -490,7 +490,10 @@ static char *squash_slash(char *name)
 	return name;
 }
 
-static char *find_name_gnu(const char *line, const char *def, int p_v)
+static char *find_name_gnu(struct apply_state *state,
+			   const char *line,
+			   const char *def,
+			   int p_v)
 {
 	struct strbuf name = STRBUF_INIT;
 	char *cp;
@@ -514,8 +517,8 @@ static char *find_name_gnu(const char *line, const char *def, int p_v)
 	}
 
 	strbuf_remove(&name, 0, cp - name.buf);
-	if (root.len)
-		strbuf_insert(&name, 0, root.buf, root.len);
+	if (state->root.len)
+		strbuf_insert(&name, 0, state->root.buf, state->root.len);
 	return squash_slash(strbuf_detach(&name, NULL));
 }
 
@@ -678,8 +681,12 @@ static size_t diff_timestamp_len(const char *line, size_t len)
 	return line + len - end;
 }
 
-static char *find_name_common(const char *line, const char *def,
-			      int p_v, const char *end, int terminate)
+static char *find_name_common(struct apply_state *state,
+			      const char *line,
+			      const char *def,
+			      int p_v,
+			      const char *end,
+			      int terminate)
 {
 	int len;
 	const char *start = NULL;
@@ -717,32 +724,39 @@ static char *find_name_common(const char *line, const char *def,
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
 
-static char *find_name(const char *line, char *def, int p_v, int terminate)
+static char *find_name(struct apply_state *state,
+		       const char *line,
+		       char *def,
+		       int p_v,
+		       int terminate)
 {
 	if (*line == '"') {
-		char *name = find_name_gnu(line, def, p_v);
+		char *name = find_name_gnu(state, line, def, p_v);
 		if (name)
 			return name;
 	}
 
-	return find_name_common(line, def, p_v, NULL, terminate);
+	return find_name_common(state, line, def, p_v, NULL, terminate);
 }
 
-static char *find_name_traditional(const char *line, char *def, int p_v)
+static char *find_name_traditional(struct apply_state *state,
+				   const char *line,
+				   char *def,
+				   int p_v)
 {
 	size_t len;
 	size_t date_len;
 
 	if (*line == '"') {
-		char *name = find_name_gnu(line, def, p_v);
+		char *name = find_name_gnu(state, line, def, p_v);
 		if (name)
 			return name;
 	}
@@ -750,10 +764,10 @@ static char *find_name_traditional(const char *line, char *def, int p_v)
 	len = strchrnul(line, '\n') - line;
 	date_len = diff_timestamp_len(line, len);
 	if (!date_len)
-		return find_name_common(line, def, p_v, NULL, TERM_TAB);
+		return find_name_common(state, line, def, p_v, NULL, TERM_TAB);
 	len -= date_len;
 
-	return find_name_common(line, def, p_v, line + len, 0);
+	return find_name_common(state, line, def, p_v, line + len, 0);
 }
 
 static int count_slashes(const char *cp)
@@ -778,7 +792,7 @@ static int guess_p_value(struct apply_state *state, const char *nameline)
 
 	if (is_dev_null(nameline))
 		return -1;
-	name = find_name_traditional(nameline, NULL, 0);
+	name = find_name_traditional(state, nameline, NULL, 0);
 	if (!name)
 		return -1;
 	cp = strchr(name, '/');
@@ -903,17 +917,17 @@ static void parse_traditional_patch(struct apply_state *state,
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
@@ -958,7 +972,7 @@ static char *gitdiff_verify_name(struct apply_state *state,
 				 int side)
 {
 	if (!orig_name && !isnull)
-		return find_name(line, NULL, state->p_value, TERM_TAB);
+		return find_name(state, line, NULL, state->p_value, TERM_TAB);
 
 	if (orig_name) {
 		int len;
@@ -968,7 +982,7 @@ static char *gitdiff_verify_name(struct apply_state *state,
 		len = strlen(name);
 		if (isnull)
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"), name, linenr);
-		another = find_name(line, NULL, state->p_value, TERM_TAB);
+		another = find_name(state, line, NULL, state->p_value, TERM_TAB);
 		if (!another || memcmp(another, name, len + 1))
 			die((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
@@ -1052,7 +1066,7 @@ static int gitdiff_copysrc(struct apply_state *state,
 {
 	patch->is_copy = 1;
 	free(patch->old_name);
-	patch->old_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->old_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1062,7 +1076,7 @@ static int gitdiff_copydst(struct apply_state *state,
 {
 	patch->is_copy = 1;
 	free(patch->new_name);
-	patch->new_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->new_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1072,7 +1086,7 @@ static int gitdiff_renamesrc(struct apply_state *state,
 {
 	patch->is_rename = 1;
 	free(patch->old_name);
-	patch->old_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->old_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1082,7 +1096,7 @@ static int gitdiff_renamedst(struct apply_state *state,
 {
 	patch->is_rename = 1;
 	free(patch->new_name);
-	patch->new_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->new_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1341,8 +1355,8 @@ static int parse_git_header(struct apply_state *state,
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
@@ -4627,9 +4641,10 @@ static int option_parse_whitespace(const struct option *opt,
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
 
@@ -4708,7 +4723,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		OPT_BIT(0, "recount", &options,
 			N_("do not trust the line counts in the hunk headers"),
 			RECOUNT),
-		{ OPTION_CALLBACK, 0, "directory", NULL, N_("root"),
+		{ OPTION_CALLBACK, 0, "directory", &state, N_("root"),
 			N_("prepend <root> to all filenames"),
 			0, option_parse_directory },
 		OPT_END()
@@ -4722,6 +4737,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	state.line_termination = '\n';
 	state.p_value = 1;
 	state.p_context = UINT_MAX;
+	strbuf_init(&state.root, 0);
 
 	git_apply_config();
 	if (apply_default_whitespace)
-- 
2.8.0.rc1.49.gca61272
