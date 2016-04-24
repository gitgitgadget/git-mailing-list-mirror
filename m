From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 42/83] builtin/apply: move 'linenr' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:42 +0200
Message-ID: <1461504863-15946-43-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:37:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKEP-0000hf-GG
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbcDXNfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:50 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38466 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbcDXNfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:47 -0400
Received: by mail-wm0-f44.google.com with SMTP id u206so89939861wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DTW6Lt4enHaQbNPcoJT9uPXgZIz7RLcDf+bfGof55NQ=;
        b=YgkVe/0ZIJZf9VNABA3M4RYpjWRWIQhABnWAXxqrHiASo/87shQ3HkH/yAQfajWaLI
         7aYwsCbG4GofI8dWyQaE0EjgnwU8zRo3E/AtfKBodxVYtxrqsk960lvW7UuvDkJDAaiz
         tPWE/+y8iBjfmqkEgjYqLAdw0BeVhX5WmlvqoFrKjpymYBlBCT1MX9+ZaNlJVSjnrxvl
         7drCg0nlLOstt8r9kEU1GlSgJzjzq+FThJq7/NEzGvM8YhBLEOLmQV6aL6WN8ZbPsrUl
         3LvU83m91IMY5NF35J7o+1PqibkgtZUYfX/ZG7Ovmh0T0X2vrhn0eB2RM1Nq+rzEifgJ
         NUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DTW6Lt4enHaQbNPcoJT9uPXgZIz7RLcDf+bfGof55NQ=;
        b=k8ZeQuGUUSOWhpNL19MhxvDzQrBmTB/Po0nsXSHeCbhx2+4HI7RknCyUa4cxAZOYHz
         WizUBEKQvt83Vkws5P4URz7gjbyACtWnRmH/kPLXHVxVxBHF0p3IsZ9gQ3fuZNYQABzM
         sMryi0+6C4tpEHJT/J1QVXi1mtVgYixfugt276UVlFzgOE2d/hS87XFvsYmRSzSxkUd+
         Zj5KCdfb85F9rwoAFCMeWpd5oGdW8TYQ/ItGsotz25lkDdaT+FlHozIGb8IdfAxTeJV4
         FgwXdnd+Y5A0W3XNPJEpklWtSyynuCX6q7xkrw+m2splxVpn7wOct16SICeIuMFBKrq0
         dGRw==
X-Gm-Message-State: AOPr4FVityeUzSCjPWS0S0SrLxu23n8bHe2SwwSd7bvC1t8HYDHsr3Rt5T0cKf181YURyw==
X-Received: by 10.194.186.242 with SMTP id fn18mr31582437wjc.65.1461504945743;
        Sun, 24 Apr 2016 06:35:45 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:45 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292376>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 75 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index bb58174..f387340 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -86,6 +86,13 @@ struct apply_state {
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
@@ -166,13 +173,6 @@ static void set_default_whitespace_mode(struct apply_state *state)
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
@@ -948,7 +948,7 @@ static void parse_traditional_patch(struct apply_state *state,
 		}
 	}
 	if (!name)
-		die(_("unable to find filename in patch at line %d"), linenr);
+		die(_("unable to find filename in patch at line %d"), state->linenr);
 }
 
 static int gitdiff_hdrend(struct apply_state *state,
@@ -986,17 +986,17 @@ static void gitdiff_verify_name(struct apply_state *state,
 		char *another;
 		if (isnull)
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
-			    *name, linenr);
+			    *name, state->linenr);
 		another = find_name(state, line, NULL, state->p_value, TERM_TAB);
 		if (!another || memcmp(another, *name, len + 1))
 			die((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
-			    _("git apply: bad git-diff - inconsistent old filename on line %d"), linenr);
+			    _("git apply: bad git-diff - inconsistent old filename on line %d"), state->linenr);
 		free(another);
 	} else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
-			die(_("git apply: bad git-diff - expected /dev/null on line %d"), linenr);
+			die(_("git apply: bad git-diff - expected /dev/null on line %d"), state->linenr);
 	}
 }
 
@@ -1359,8 +1359,8 @@ static int parse_git_header(struct apply_state *state,
 
 	line += len;
 	size -= len;
-	linenr++;
-	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, linenr++) {
+	state->linenr++;
+	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, state->linenr++) {
 		static const struct opentry {
 			const char *str;
 			int (*fn)(struct apply_state *, const char *, struct patch *);
@@ -1531,7 +1531,7 @@ static int find_header(struct apply_state *state,
 	patch->is_new = patch->is_delete = -1;
 	patch->old_mode = patch->new_mode = 0;
 	patch->old_name = patch->new_name = NULL;
-	for (offset = 0; size > 0; offset += len, size -= len, line += len, linenr++) {
+	for (offset = 0; size > 0; offset += len, size -= len, line += len, state->linenr++) {
 		unsigned long nextlen;
 
 		len = linelen(line, size);
@@ -1552,7 +1552,7 @@ static int find_header(struct apply_state *state,
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
 			die(_("patch fragment without header at line %d: %.*s"),
-			    linenr, (int)len-1, line);
+			    state->linenr, (int)len-1, line);
 		}
 
 		if (size < len + 6)
@@ -1573,13 +1573,13 @@ static int find_header(struct apply_state *state,
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
@@ -1601,7 +1601,7 @@ static int find_header(struct apply_state *state,
 		/* Ok, we'll consider it a patch */
 		parse_traditional_patch(state, line, line+len, patch);
 		*hdrsize = len + nextlen;
-		linenr += 2;
+		state->linenr += 2;
 		return offset;
 	}
 	return -1;
@@ -1636,7 +1636,7 @@ static void check_whitespace(struct apply_state *state,
 {
 	unsigned result = ws_check(line + 1, len - 1, ws_rule);
 
-	record_ws_error(state, result, line + 1, len - 2, linenr);
+	record_ws_error(state, result, line + 1, len - 2, state->linenr);
 }
 
 /*
@@ -1669,11 +1669,11 @@ static int parse_fragment(struct apply_state *state,
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
@@ -1772,10 +1772,10 @@ static int parse_single_patch(struct apply_state *state,
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
@@ -1861,7 +1861,8 @@ static char *inflate_it(const void *data, unsigned long size,
  * points at an allocated memory that the caller must free, so
  * it is marked as "->free_patch = 1".
  */
-static struct fragment *parse_binary_hunk(char **buf_p,
+static struct fragment *parse_binary_hunk(struct apply_state *state,
+					  char **buf_p,
 					  unsigned long *sz_p,
 					  int *status_p,
 					  int *used_p)
@@ -1903,13 +1904,13 @@ static struct fragment *parse_binary_hunk(char **buf_p,
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
@@ -1963,7 +1964,7 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 	free(data);
 	*status_p = -1;
 	error(_("corrupt binary patch at line %d: %.*s"),
-	      linenr-1, llen-1, buffer);
+	      state->linenr-1, llen-1, buffer);
 	return NULL;
 }
 
@@ -1972,7 +1973,10 @@ static struct fragment *parse_binary_hunk(char **buf_p,
  *   -1 in case of error,
  *   the length of the parsed binary patch otherwise
  */
-static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
+static int parse_binary(struct apply_state *state,
+			char *buffer,
+			unsigned long size,
+			struct patch *patch)
 {
 	/*
 	 * We have read "GIT binary patch\n"; what follows is a line
@@ -1993,15 +1997,15 @@ static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
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
@@ -2116,8 +2120,8 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		if (llen == sizeof(git_binary) - 1 &&
 		    !memcmp(git_binary, buffer + hd, llen)) {
 			int used;
-			linenr++;
-			used = parse_binary(buffer + hd + llen,
+			state->linenr++;
+			used = parse_binary(state, buffer + hd + llen,
 					    size - hd - llen, patch);
 			if (used < 0)
 				return -1;
@@ -2137,7 +2141,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 				int len = strlen(binhdr[i]);
 				if (len < size - hd &&
 				    !memcmp(binhdr[i], buffer + hd, len)) {
-					linenr++;
+					state->linenr++;
 					patch->is_binary = 1;
 					patchsize = llen;
 					break;
@@ -2151,7 +2155,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 */
 		if ((state->apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
-			die(_("patch with only garbage at line %d"), linenr);
+			die(_("patch with only garbage at line %d"), state->linenr);
 	}
 
 	return offset + hdrsize + patchsize;
@@ -4748,6 +4752,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	state.squelch_whitespace_errors = 5;
 	state.ws_error_action = warn_on_ws_error;
 	state.ws_ignore_action = ignore_ws_none;
+	state.linenr = 1;
 	strbuf_init(&state.root, 0);
 
 	git_apply_config();
-- 
2.8.1.300.g5fed0c0
