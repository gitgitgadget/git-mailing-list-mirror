From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 43/94] builtin/apply: move 'state_linenr' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:54 +0200
Message-ID: <20160511131745.2914-44-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:23:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U6y-0007Dw-US
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbcEKNXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:23:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33224 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235AbcEKNT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id r12so9411511wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NkbmDeWDq/eaO9OSWQfyucfsTq7UkeduFUJJ3kDzZB4=;
        b=VhmcGhGyRxJD+mdSBoetgOUMqGPRMF0tG9lHG1seF//14VwAU14BKvvwjKbpyWxgpv
         gFtjoqDOw70elMHOis4rSxKV9ITniE/IrGdYps5UnD7vtu8YrBjseldJWcGqGcfWg0GD
         aM86ZD5h7VEq6VOoJlQmELSmdwfNkigsj15mRgK1pOrwxTBLlWWUPuINd+ghYuy7TCqi
         DyumKasjVz0ty+NbekZPsZ9kMfdTbhQPM/XTrvk1FInnu1ugpbpkweoynMc84HcFnQXW
         7Lxnd8qfVnZ4KUs6yvXTB1r7l/1Km65ydgnjwCO/U7lKmsSkThwnmhwl1jrBehL5WMR8
         +/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NkbmDeWDq/eaO9OSWQfyucfsTq7UkeduFUJJ3kDzZB4=;
        b=Efz5A6GTqpiGhni92VBhudNRhv3MnrVv8mP5t1nYdxy721ope0sG/A0eBTPCK0NcO/
         HjHD0hmlkX2pBI63W0mePVFszz/inooTA7ELJ4lFgDEaF0LW0mPU/BdgoEYl8W5VT11q
         4qHrNn1feggh+jkTXfRJJFSlP/XI2YUxbxAWOrG4IKlEfcu1WDzq7LdrxAzcoqpyCEQi
         gLzUjvrqSvW75ExSDsAm0PsRnBD4ul4Jj489LrWnVkzmLcKfFEblQpcOZOulbhl+QmGG
         T5RaHWdHEtH4emoMRMz8WC5rglz7qTCm94trBV9QpMkPaXYuOoAReiDOQZS7hRP0C00G
         kSGQ==
X-Gm-Message-State: AOPr4FUqJmHewRPV345qj0f1kC5MB25IY2/3FuRdT8fmg1uYhC9+6z0NKyt+04M02UqYGw==
X-Received: by 10.28.140.17 with SMTP id o17mr4221156wmd.18.1462972795628;
        Wed, 11 May 2016 06:19:55 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:54 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294324>

To libify the apply functionality the 'state_linenr' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 75 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index deba14c..5c003a1 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -84,6 +84,13 @@ struct apply_state {
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
@@ -156,13 +163,6 @@ static void set_default_whitespace_mode(struct apply_state *state)
 		state->ws_error_action = (state->apply ? warn_on_ws_error : nowarn_ws_error);
 }
 
-/*
- * Various "current state", notably line numbers and what
- * file (and how) we're patching right now.. The "is_xxxx"
- * things are flags, where -1 means "don't know yet".
- */
-static int state_linenr = 1;
-
 /*
  * This represents one "hunk" from a patch, starting with
  * "@@ -oldpos,oldlines +newpos,newlines @@" marker.  The
@@ -939,7 +939,7 @@ static void parse_traditional_patch(struct apply_state *state,
 		}
 	}
 	if (!name)
-		die(_("unable to find filename in patch at line %d"), state_linenr);
+		die(_("unable to find filename in patch at line %d"), state->linenr);
 }
 
 static int gitdiff_hdrend(struct apply_state *state,
@@ -977,17 +977,17 @@ static void gitdiff_verify_name(struct apply_state *state,
 		char *another;
 		if (isnull)
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
-			    *name, state_linenr);
+			    *name, state->linenr);
 		another = find_name(state, line, NULL, state->p_value, TERM_TAB);
 		if (!another || memcmp(another, *name, len + 1))
 			die((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
-			    _("git apply: bad git-diff - inconsistent old filename on line %d"), state_linenr);
+			    _("git apply: bad git-diff - inconsistent old filename on line %d"), state->linenr);
 		free(another);
 	} else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
-			die(_("git apply: bad git-diff - expected /dev/null on line %d"), state_linenr);
+			die(_("git apply: bad git-diff - expected /dev/null on line %d"), state->linenr);
 	}
 }
 
@@ -1350,8 +1350,8 @@ static int parse_git_header(struct apply_state *state,
 
 	line += len;
 	size -= len;
-	state_linenr++;
-	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, state_linenr++) {
+	state->linenr++;
+	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, state->linenr++) {
 		static const struct opentry {
 			const char *str;
 			int (*fn)(struct apply_state *, const char *, struct patch *);
@@ -1522,7 +1522,7 @@ static int find_header(struct apply_state *state,
 	patch->is_new = patch->is_delete = -1;
 	patch->old_mode = patch->new_mode = 0;
 	patch->old_name = patch->new_name = NULL;
-	for (offset = 0; size > 0; offset += len, size -= len, line += len, state_linenr++) {
+	for (offset = 0; size > 0; offset += len, size -= len, line += len, state->linenr++) {
 		unsigned long nextlen;
 
 		len = linelen(line, size);
@@ -1543,7 +1543,7 @@ static int find_header(struct apply_state *state,
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
 			die(_("patch fragment without header at line %d: %.*s"),
-			    state_linenr, (int)len-1, line);
+			    state->linenr, (int)len-1, line);
 		}
 
 		if (size < len + 6)
@@ -1564,13 +1564,13 @@ static int find_header(struct apply_state *state,
 					       "git diff header lacks filename information when removing "
 					       "%d leading pathname components (line %d)",
 					       state->p_value),
-					    state->p_value, state_linenr);
+					    state->p_value, state->linenr);
 				patch->old_name = xstrdup(patch->def_name);
 				patch->new_name = xstrdup(patch->def_name);
 			}
 			if (!patch->is_delete && !patch->new_name)
 				die("git diff header lacks filename information "
-				    "(line %d)", state_linenr);
+				    "(line %d)", state->linenr);
 			patch->is_toplevel_relative = 1;
 			*hdrsize = git_hdr_len;
 			return offset;
@@ -1592,7 +1592,7 @@ static int find_header(struct apply_state *state,
 		/* Ok, we'll consider it a patch */
 		parse_traditional_patch(state, line, line+len, patch);
 		*hdrsize = len + nextlen;
-		state_linenr += 2;
+		state->linenr += 2;
 		return offset;
 	}
 	return -1;
@@ -1627,7 +1627,7 @@ static void check_whitespace(struct apply_state *state,
 {
 	unsigned result = ws_check(line + 1, len - 1, ws_rule);
 
-	record_ws_error(state, result, line + 1, len - 2, state_linenr);
+	record_ws_error(state, result, line + 1, len - 2, state->linenr);
 }
 
 /*
@@ -1660,11 +1660,11 @@ static int parse_fragment(struct apply_state *state,
 	/* Parse the thing.. */
 	line += len;
 	size -= len;
-	state_linenr++;
+	state->linenr++;
 	added = deleted = 0;
 	for (offset = len;
 	     0 < size;
-	     offset += len, size -= len, line += len, state_linenr++) {
+	     offset += len, size -= len, line += len, state->linenr++) {
 		if (!oldlines && !newlines)
 			break;
 		len = linelen(line, size);
@@ -1763,10 +1763,10 @@ static int parse_single_patch(struct apply_state *state,
 		int len;
 
 		fragment = xcalloc(1, sizeof(*fragment));
-		fragment->linenr = state_linenr;
+		fragment->linenr = state->linenr;
 		len = parse_fragment(state, line, size, patch, fragment);
 		if (len <= 0)
-			die(_("corrupt patch at line %d"), state_linenr);
+			die(_("corrupt patch at line %d"), state->linenr);
 		fragment->patch = line;
 		fragment->size = len;
 		oldlines += fragment->oldlines;
@@ -1852,7 +1852,8 @@ static char *inflate_it(const void *data, unsigned long size,
  * points at an allocated memory that the caller must free, so
  * it is marked as "->free_patch = 1".
  */
-static struct fragment *parse_binary_hunk(char **buf_p,
+static struct fragment *parse_binary_hunk(struct apply_state *state,
+					  char **buf_p,
 					  unsigned long *sz_p,
 					  int *status_p,
 					  int *used_p)
@@ -1894,13 +1895,13 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 	else
 		return NULL;
 
-	state_linenr++;
+	state->linenr++;
 	buffer += llen;
 	while (1) {
 		int byte_length, max_byte_length, newsize;
 		llen = linelen(buffer, size);
 		used += llen;
-		state_linenr++;
+		state->linenr++;
 		if (llen == 1) {
 			/* consume the blank line */
 			buffer++;
@@ -1954,7 +1955,7 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 	free(data);
 	*status_p = -1;
 	error(_("corrupt binary patch at line %d: %.*s"),
-	      state_linenr-1, llen-1, buffer);
+	      state->linenr-1, llen-1, buffer);
 	return NULL;
 }
 
@@ -1963,7 +1964,10 @@ static struct fragment *parse_binary_hunk(char **buf_p,
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
@@ -1984,15 +1988,15 @@ static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
 	int status;
 	int used, used_1;
 
-	forward = parse_binary_hunk(&buffer, &size, &status, &used);
+	forward = parse_binary_hunk(state, &buffer, &size, &status, &used);
 	if (!forward && !status)
 		/* there has to be one hunk (forward hunk) */
-		return error(_("unrecognized binary patch at line %d"), state_linenr-1);
+		return error(_("unrecognized binary patch at line %d"), state->linenr-1);
 	if (status)
 		/* otherwise we already gave an error message */
 		return status;
 
-	reverse = parse_binary_hunk(&buffer, &size, &status, &used_1);
+	reverse = parse_binary_hunk(state, &buffer, &size, &status, &used_1);
 	if (reverse)
 		used += used_1;
 	else if (status) {
@@ -2107,8 +2111,8 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		if (llen == sizeof(git_binary) - 1 &&
 		    !memcmp(git_binary, buffer + hd, llen)) {
 			int used;
-			state_linenr++;
-			used = parse_binary(buffer + hd + llen,
+			state->linenr++;
+			used = parse_binary(state, buffer + hd + llen,
 					    size - hd - llen, patch);
 			if (used < 0)
 				return -1;
@@ -2128,7 +2132,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 				int len = strlen(binhdr[i]);
 				if (len < size - hd &&
 				    !memcmp(binhdr[i], buffer + hd, len)) {
-					state_linenr++;
+					state->linenr++;
 					patch->is_binary = 1;
 					patchsize = llen;
 					break;
@@ -2142,7 +2146,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 */
 		if ((state->apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
-			die(_("patch with only garbage at line %d"), state_linenr);
+			die(_("patch with only garbage at line %d"), state->linenr);
 	}
 
 	return offset + hdrsize + patchsize;
@@ -4661,6 +4665,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	state->squelch_whitespace_errors = 5;
 	state->ws_error_action = warn_on_ws_error;
 	state->ws_ignore_action = ignore_ws_none;
+	state->linenr = 1;
 	strbuf_init(&state->root, 0);
 
 	git_apply_config();
-- 
2.8.2.490.g3dabe57
