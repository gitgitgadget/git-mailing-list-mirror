From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 43/48] builtin/apply: move 'linenr' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:49:11 +0100
Message-ID: <1457545756-20616-44-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiJX-0000Ta-7B
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933766AbcCIRyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:54:19 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35171 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933776AbcCIRyD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:54:03 -0500
Received: by mail-wm0-f44.google.com with SMTP id l68so190258473wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d/jq87Fo8zzxzRCmyyqQkc+kXPVL+YWMnCGaHLBQph0=;
        b=Yp3zmKsAujzoq4jP3ivVexJXE5rLh/gqQGWf+G9+CWOyLpjaqBjD6zhAlGg5KrTddX
         HNsK/XYHr7NDFIJUa18wntrgpBABFQB+8wDnuZgiQNrQUTvbFNP6G6zzLttPaCWlnRdA
         M0YIM7v6qOHQBqiZrwRGyXLZqWSm8tQDaY6ahlYiLsMRsKbLcDjw0Kyj78kx28KeA1np
         L53HZP5BSU2SsiE85Dk0fW+rnIv+FF2gsfYa6pn3F+mvppbtJScOcyyx0iN5NnO3U15z
         tb7TvUoM4f3uiRtqjEHwzaGZE8PH5cFzbVGOhv5RYLlxKR4wKlFq++Ayox2sZn4Wk4qf
         DW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d/jq87Fo8zzxzRCmyyqQkc+kXPVL+YWMnCGaHLBQph0=;
        b=YAlNxuGME8DDkWK+4sJNCDv1tYCFqKXOMs3oqx5/+a3Q3EHevNqi0r2bO49AAH4WB+
         RcEKlgibIuK+79tli+DTp5pFzoijMCZ8tY9UA7bmrIfjaMUR4DzW/ZYsOtnAaA0FeEiQ
         j7NbiQ2xt6dgymbjmJjK8/XkMalyOby2qbOVqiO60B4uRtDpCFGZ8PeejPlf1M4zuYOr
         556bPvNBDyIhqFlvp9kfwDmvJQC4a+L3Z4ImRnOJ6J/FdIw0npP4u9Vh0cbMA2E43tiu
         4rJ1Mn7+geUJ7ixgiOOJboNgIqyJ4lZTdBHxxCgy/KZ0KPh0I5m04Hurz3cL5vHAJZci
         nHfQ==
X-Gm-Message-State: AD7BkJISWXJApGCPKg1e61W8tFvup/BOAF7BonXMuz3hFkpB6MYPRq+ZhQ4iYN0GlwfdZw==
X-Received: by 10.28.21.75 with SMTP id 72mr25964485wmv.64.1457546036758;
        Wed, 09 Mar 2016 09:53:56 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:55 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288534>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 75 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 79224fd..3808d60 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -87,6 +87,13 @@ struct apply_state {
 	int max_change;
 	int max_len;
 
+	/*
+	 * Various "current state", notably line numbers and what
+	 * file (and how) we're patching right now.. The "is_xxxx"
+	 * things are flags, where -1 means "don't know yet".
+	 */
+	int linenr;
+
 	int p_value;
 	int p_value_known;
 	unsigned int p_context;
@@ -167,13 +174,6 @@ static void set_default_whitespace_mode(struct apply_state *state)
 }
 
 /*
- * Various "current state", notably line numbers and what
- * file (and how) we're patching right now.. The "is_xxxx"
- * things are flags, where -1 means "don't know yet".
- */
-static int linenr = 1;
-
-/*
  * This represents one "hunk" from a patch, starting with
  * "@@ -oldpos,oldlines +newpos,newlines @@" marker.  The
  * patch text is pointed at by patch, and its byte length
@@ -949,7 +949,7 @@ static void parse_traditional_patch(struct apply_state *state,
 		}
 	}
 	if (!name)
-		die(_("unable to find filename in patch at line %d"), linenr);
+		die(_("unable to find filename in patch at line %d"), state->linenr);
 }
 
 static int gitdiff_hdrend(struct apply_state *state,
@@ -987,19 +987,19 @@ static char *gitdiff_verify_name(struct apply_state *state,
 		name = orig_name;
 		len = strlen(name);
 		if (isnull)
-			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"), name, linenr);
+			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"), name, state->linenr);
 		another = find_name(state, line, NULL, state->p_value, TERM_TAB);
 		if (!another || memcmp(another, name, len + 1))
 			die((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
-			    _("git apply: bad git-diff - inconsistent old filename on line %d"), linenr);
+			    _("git apply: bad git-diff - inconsistent old filename on line %d"), state->linenr);
 		free(another);
 		return orig_name;
 	}
 	else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
-			die(_("git apply: bad git-diff - expected /dev/null on line %d"), linenr);
+			die(_("git apply: bad git-diff - expected /dev/null on line %d"), state->linenr);
 		return NULL;
 	}
 }
@@ -1369,8 +1369,8 @@ static int parse_git_header(struct apply_state *state,
 
 	line += len;
 	size -= len;
-	linenr++;
-	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, linenr++) {
+	state->linenr++;
+	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, state->linenr++) {
 		static const struct opentry {
 			const char *str;
 			int (*fn)(struct apply_state *, const char *, struct patch *);
@@ -1541,7 +1541,7 @@ static int find_header(struct apply_state *state,
 	patch->is_new = patch->is_delete = -1;
 	patch->old_mode = patch->new_mode = 0;
 	patch->old_name = patch->new_name = NULL;
-	for (offset = 0; size > 0; offset += len, size -= len, line += len, linenr++) {
+	for (offset = 0; size > 0; offset += len, size -= len, line += len, state->linenr++) {
 		unsigned long nextlen;
 
 		len = linelen(line, size);
@@ -1562,7 +1562,7 @@ static int find_header(struct apply_state *state,
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
 			die(_("patch fragment without header at line %d: %.*s"),
-			    linenr, (int)len-1, line);
+			    state->linenr, (int)len-1, line);
 		}
 
 		if (size < len + 6)
@@ -1583,13 +1583,13 @@ static int find_header(struct apply_state *state,
 					       "git diff header lacks filename information when removing "
 					       "%d leading pathname components (line %d)",
 					       state->p_value),
-					    state->p_value, linenr);
+					    state->p_value, state->linenr);
 				patch->old_name = xstrdup(patch->def_name);
 				patch->new_name = xstrdup(patch->def_name);
 			}
 			if (!patch->is_delete && !patch->new_name)
 				die("git diff header lacks filename information "
-				    "(line %d)", linenr);
+				    "(line %d)", state->linenr);
 			patch->is_toplevel_relative = 1;
 			*hdrsize = git_hdr_len;
 			return offset;
@@ -1611,7 +1611,7 @@ static int find_header(struct apply_state *state,
 		/* Ok, we'll consider it a patch */
 		parse_traditional_patch(state, line, line+len, patch);
 		*hdrsize = len + nextlen;
-		linenr += 2;
+		state->linenr += 2;
 		return offset;
 	}
 	return -1;
@@ -1646,7 +1646,7 @@ static void check_whitespace(struct apply_state *state,
 {
 	unsigned result = ws_check(line + 1, len - 1, ws_rule);
 
-	record_ws_error(state, result, line + 1, len - 2, linenr);
+	record_ws_error(state, result, line + 1, len - 2, state->linenr);
 }
 
 /*
@@ -1679,11 +1679,11 @@ static int parse_fragment(struct apply_state *state,
 	/* Parse the thing.. */
 	line += len;
 	size -= len;
-	linenr++;
+	state->linenr++;
 	added = deleted = 0;
 	for (offset = len;
 	     0 < size;
-	     offset += len, size -= len, line += len, linenr++) {
+	     offset += len, size -= len, line += len, state->linenr++) {
 		if (!oldlines && !newlines)
 			break;
 		len = linelen(line, size);
@@ -1782,10 +1782,10 @@ static int parse_single_patch(struct apply_state *state,
 		int len;
 
 		fragment = xcalloc(1, sizeof(*fragment));
-		fragment->linenr = linenr;
+		fragment->linenr = state->linenr;
 		len = parse_fragment(state, line, size, patch, fragment);
 		if (len <= 0)
-			die(_("corrupt patch at line %d"), linenr);
+			die(_("corrupt patch at line %d"), state->linenr);
 		fragment->patch = line;
 		fragment->size = len;
 		oldlines += fragment->oldlines;
@@ -1871,7 +1871,8 @@ static char *inflate_it(const void *data, unsigned long size,
  * points at an allocated memory that the caller must free, so
  * it is marked as "->free_patch = 1".
  */
-static struct fragment *parse_binary_hunk(char **buf_p,
+static struct fragment *parse_binary_hunk(struct apply_state *state,
+					  char **buf_p,
 					  unsigned long *sz_p,
 					  int *status_p,
 					  int *used_p)
@@ -1913,13 +1914,13 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 	else
 		return NULL;
 
-	linenr++;
+	state->linenr++;
 	buffer += llen;
 	while (1) {
 		int byte_length, max_byte_length, newsize;
 		llen = linelen(buffer, size);
 		used += llen;
-		linenr++;
+		state->linenr++;
 		if (llen == 1) {
 			/* consume the blank line */
 			buffer++;
@@ -1973,11 +1974,14 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 	free(data);
 	*status_p = -1;
 	error(_("corrupt binary patch at line %d: %.*s"),
-	      linenr-1, llen-1, buffer);
+	      state->linenr-1, llen-1, buffer);
 	return NULL;
 }
 
-static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
+static int parse_binary(struct apply_state *state,
+			char *buffer,
+			unsigned long size,
+			struct patch *patch)
 {
 	/*
 	 * We have read "GIT binary patch\n"; what follows is a line
@@ -1998,15 +2002,15 @@ static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
 	int status;
 	int used, used_1;
 
-	forward = parse_binary_hunk(&buffer, &size, &status, &used);
+	forward = parse_binary_hunk(state, &buffer, &size, &status, &used);
 	if (!forward && !status)
 		/* there has to be one hunk (forward hunk) */
-		return error(_("unrecognized binary patch at line %d"), linenr-1);
+		return error(_("unrecognized binary patch at line %d"), state->linenr-1);
 	if (status)
 		/* otherwise we already gave an error message */
 		return status;
 
-	reverse = parse_binary_hunk(&buffer, &size, &status, &used_1);
+	reverse = parse_binary_hunk(state, &buffer, &size, &status, &used_1);
 	if (reverse)
 		used += used_1;
 	else if (status) {
@@ -2121,8 +2125,8 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		if (llen == sizeof(git_binary) - 1 &&
 		    !memcmp(git_binary, buffer + hd, llen)) {
 			int used;
-			linenr++;
-			used = parse_binary(buffer + hd + llen,
+			state->linenr++;
+			used = parse_binary(state, buffer + hd + llen,
 					    size - hd - llen, patch);
 			if (used)
 				patchsize = used + llen;
@@ -2140,7 +2144,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 				int len = strlen(binhdr[i]);
 				if (len < size - hd &&
 				    !memcmp(binhdr[i], buffer + hd, len)) {
-					linenr++;
+					state->linenr++;
 					patch->is_binary = 1;
 					patchsize = llen;
 					break;
@@ -2154,7 +2158,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 */
 		if ((state->apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
-			die(_("patch with only garbage at line %d"), linenr);
+			die(_("patch with only garbage at line %d"), state->linenr);
 	}
 
 	return offset + hdrsize + patchsize;
@@ -4746,6 +4750,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	state.squelch_whitespace_errors = 5;
 	state.ws_error_action = warn_on_ws_error;
 	state.ws_ignore_action = ignore_ws_none;
+	state.linenr = 1;
 	strbuf_init(&state.root, 0);
 
 	git_apply_config();
-- 
2.8.0.rc1.49.gca61272
