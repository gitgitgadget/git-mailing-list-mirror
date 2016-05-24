From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 34/49] builtin/apply: move 'root' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:11 +0200
Message-ID: <20160524081126.16973-35-chriscool@tuxfamily.org>
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
	id 1b57Ta-0001Ss-G9
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740AbcEXIN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:13:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36474 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683AbcEXIMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id q62so3639928wmg.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UY6eTfJAWOdEJAS+dsnJYU2D7UwtRvvONN4yF/iDfgw=;
        b=gDgfeh5fmO0ckAL588PakTZpJQ+sXderA25K6PeoHlLMyjyh6FwbIVNtqYI26U1z6O
         43krzTWA22Vyv5fHBqmCWlteNGftJ1cyiTuKv4U5RZs8lv80PEGZA/X8dFJThOAxlZr6
         pfHVNDflfTJKIY+EOgACHFKFNTCzkD4rf0/HWxDDflt16dDpBnLibjHx7j/tShJFNaSm
         fM3D4sjL9o16Fl8png2DPo77w+tOTULZdQBmHkT9eKTibQ3qOg5tqhIRb2I3+EPiKpCU
         Vjaw0azF0SvINNklbM7Rt0DS1EVf1Q1+0LJgfNmWi749mIA3EHSYtD8YN+OQP2ruvjOw
         fR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UY6eTfJAWOdEJAS+dsnJYU2D7UwtRvvONN4yF/iDfgw=;
        b=A+zB2Uo6XA0UUu3TC0UnT9lXcIziUoTQFWEYZEelF6sn2Y3XXvBf2XdAj6TcXAq71k
         VRY/98KYJNk80FcoZNkWqdW7iKWwJ0RTs4hxnoy+MuuX5sjedVHIrUHE1rYsZN11Mudy
         PUwrWA2A2Z532KEOhfUidmfiOM64kJFmcZGR+Cv6IHKhB+53o0LStuvxfYexgUJCuXkj
         6NAh5Me+z3vcACwk//cMaM8u/YmbxSMxV3Lj/t4Gu6PKm0qYOJYxxP3ApcqpYjGTbG+j
         Ucib5S9exp4g/8NbXWrC7Xm0B2jEnP8Mi/Se488mhvEYTn1A08o+Aco+ebX1zl4w6X3m
         YApg==
X-Gm-Message-State: ALyK8tIglj/bNVc7wZ2TXXimhtabpeVm1m1QX+gvpuguoioSgyAOdHkKEHNJqZHqW3/G4Q==
X-Received: by 10.194.242.65 with SMTP id wo1mr2808481wjc.54.1464077551994;
        Tue, 24 May 2016 01:12:31 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:31 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295454>

To libify the apply functionality the 'root' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 82 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e1b68d4..5dc1d89 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -51,6 +51,7 @@ struct apply_state {
 	const char *fake_ancestor;
 	const char *patch_input_file;
 	int line_termination;
+	struct strbuf root;
 	int p_value;
 	int p_value_known;
 	unsigned int p_context;
@@ -83,8 +84,6 @@ static enum ws_ignore {
 } ws_ignore_action = ignore_ws_none;
 
 
-static struct strbuf root = STRBUF_INIT;
-
 static void parse_whitespace_option(const char *option)
 {
 	if (!option) {
@@ -474,7 +473,10 @@ static char *squash_slash(char *name)
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
@@ -498,8 +500,8 @@ static char *find_name_gnu(const char *line, const char *def, int p_value)
 	}
 
 	strbuf_remove(&name, 0, cp - name.buf);
-	if (root.len)
-		strbuf_insert(&name, 0, root.buf, root.len);
+	if (state->root.len)
+		strbuf_insert(&name, 0, state->root.buf, state->root.len);
 	return squash_slash(strbuf_detach(&name, NULL));
 }
 
@@ -662,8 +664,12 @@ static size_t diff_timestamp_len(const char *line, size_t len)
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
@@ -701,32 +707,39 @@ static char *find_name_common(const char *line, const char *def,
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
@@ -734,10 +747,10 @@ static char *find_name_traditional(const char *line, char *def, int p_value)
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
@@ -762,7 +775,7 @@ static int guess_p_value(struct apply_state *state, const char *nameline)
 
 	if (is_dev_null(nameline))
 		return -1;
-	name = find_name_traditional(nameline, NULL, 0);
+	name = find_name_traditional(state, nameline, NULL, 0);
 	if (!name)
 		return -1;
 	cp = strchr(name, '/');
@@ -887,17 +900,17 @@ static void parse_traditional_patch(struct apply_state *state,
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
@@ -942,7 +955,7 @@ static void gitdiff_verify_name(struct apply_state *state,
 				int side)
 {
 	if (!*name && !isnull) {
-		*name = find_name(line, NULL, state->p_value, TERM_TAB);
+		*name = find_name(state, line, NULL, state->p_value, TERM_TAB);
 		return;
 	}
 
@@ -952,7 +965,7 @@ static void gitdiff_verify_name(struct apply_state *state,
 		if (isnull)
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
 			    *name, state_linenr);
-		another = find_name(line, NULL, state->p_value, TERM_TAB);
+		another = find_name(state, line, NULL, state->p_value, TERM_TAB);
 		if (!another || memcmp(another, *name, len + 1))
 			die((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
@@ -1027,7 +1040,7 @@ static int gitdiff_copysrc(struct apply_state *state,
 {
 	patch->is_copy = 1;
 	free(patch->old_name);
-	patch->old_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->old_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1037,7 +1050,7 @@ static int gitdiff_copydst(struct apply_state *state,
 {
 	patch->is_copy = 1;
 	free(patch->new_name);
-	patch->new_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->new_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1047,7 +1060,7 @@ static int gitdiff_renamesrc(struct apply_state *state,
 {
 	patch->is_rename = 1;
 	free(patch->old_name);
-	patch->old_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->old_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1057,7 +1070,7 @@ static int gitdiff_renamedst(struct apply_state *state,
 {
 	patch->is_rename = 1;
 	free(patch->new_name);
-	patch->new_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
+	patch->new_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
 	return 0;
 }
 
@@ -1316,8 +1329,8 @@ static int parse_git_header(struct apply_state *state,
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
@@ -4614,9 +4627,10 @@ static int option_parse_whitespace(const struct option *opt,
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
 
@@ -4629,6 +4643,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	state->line_termination = '\n';
 	state->p_value = 1;
 	state->p_context = UINT_MAX;
+	strbuf_init(&state->root, 0);
 
 	git_apply_config();
 	if (apply_default_whitespace)
@@ -4640,6 +4655,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 static void clear_apply_state(struct apply_state *state)
 {
 	string_list_clear(&state->limit_by_name, 0);
+	strbuf_release(&state->root);
 }
 
 int cmd_apply(int argc, const char **argv, const char *prefix)
@@ -4717,7 +4733,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "recount", &options,
 			N_("do not trust the line counts in the hunk headers"),
 			RECOUNT),
-		{ OPTION_CALLBACK, 0, "directory", NULL, N_("root"),
+		{ OPTION_CALLBACK, 0, "directory", &state, N_("root"),
 			N_("prepend <root> to all filenames"),
 			0, option_parse_directory },
 		OPT_END()
-- 
2.8.3.443.gaeee61e
