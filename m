From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 43/49] builtin/apply: move 'state_linenr' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:20 +0200
Message-ID: <20160524081126.16973-44-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:13:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57TF-0001K4-45
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbcEXIM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36675 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbcEXIMr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id q62so3641397wmg.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jepE3/kdE1rzJoJX/XwXgPMloDvaLV50XB+3QxOvGIE=;
        b=zSl8mugh3ki93igHskD6DdjOrXFqlV8jm2lfIc0Gs9TCfhnL1MentPJc3oRhVHflCh
         RJAhW0WQMZmlqNK4xf0OQ7XZLSEX8Ss6JMXzxEz9Jisd2Hnj/U0oT7e8jdIvpMZCVzru
         17LB/aD2vBMJvqWaE1gebUqEcrt0XxLv6kiv5Hwh18V19f2I7lCPFT61uIUZ76q5TMgA
         +6EUBakN88+C912u14Llo6xUtBrreJekvN7FQK7UeOXRdJghn6+6Fg9ferSXHiNM2dam
         N/c2E4MfPKhVhrjv2WtGaylLky+9q+YPWZSrrOsu4u5Y7yRkmMXlPPpzFsj0yQYCGKCM
         K7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jepE3/kdE1rzJoJX/XwXgPMloDvaLV50XB+3QxOvGIE=;
        b=QVlYKuzG6PcZ99qW/tUPI79/li8kaZaUcIkcQ3VYS4XN54S0dI48wRBiGAkUzKJ7G3
         X0NDb0IApV71AH2dBImNwnuW983ZLYUgokRnr8nykNadAYGW6YAPoEfEX/v5aLjmM/9C
         mI5dYlgbg9trN4nUhMdOthmQxn07mecz44InjSHxvoSqUndcbLTou5JRmN4XnZyoJIzP
         EbFMC/7NFdMpGStdzPbG9hK0+ML7YuBjl4J7aUJQhiWoK4rzroMYNto7zCg/9y9Pr+CO
         prLvUNwhniCZ2D4Z9wjSeowvxshTLRxk53fDID0PEIRU90nD2GWmiVyty5g2vOJtRFGw
         EfTg==
X-Gm-Message-State: ALyK8tJYylAoJaKWiqgX7b+2MDzIo8/Cy4pzfe0d5HkySf9vjuYFaswObmVd3+jGsu/X3g==
X-Received: by 10.28.48.196 with SMTP id w187mr16146731wmw.71.1464077565491;
        Tue, 24 May 2016 01:12:45 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:44 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295449>

To libify the apply functionality the 'state_linenr' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 71 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 9e7d181..dd56a8e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -73,6 +73,9 @@ struct apply_state {
 	struct string_list limit_by_name;
 	int has_include;
 
+	/* Various "current state" */
+	int linenr; /* current line number */
+
 	/*
 	 * For "diff-stat" like behaviour, we keep track of the biggest change
 	 * we've seen, and the longest filename. That allows us to do simple
@@ -149,13 +152,6 @@ static void set_default_whitespace_mode(struct apply_state *state)
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
@@ -932,7 +928,7 @@ static void parse_traditional_patch(struct apply_state *state,
 		}
 	}
 	if (!name)
-		die(_("unable to find filename in patch at line %d"), state_linenr);
+		die(_("unable to find filename in patch at line %d"), state->linenr);
 }
 
 static int gitdiff_hdrend(struct apply_state *state,
@@ -970,17 +966,17 @@ static void gitdiff_verify_name(struct apply_state *state,
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
 
@@ -1343,8 +1339,8 @@ static int parse_git_header(struct apply_state *state,
 
 	line += len;
 	size -= len;
-	state_linenr++;
-	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, state_linenr++) {
+	state->linenr++;
+	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, state->linenr++) {
 		static const struct opentry {
 			const char *str;
 			int (*fn)(struct apply_state *, const char *, struct patch *);
@@ -1515,7 +1511,7 @@ static int find_header(struct apply_state *state,
 	patch->is_new = patch->is_delete = -1;
 	patch->old_mode = patch->new_mode = 0;
 	patch->old_name = patch->new_name = NULL;
-	for (offset = 0; size > 0; offset += len, size -= len, line += len, state_linenr++) {
+	for (offset = 0; size > 0; offset += len, size -= len, line += len, state->linenr++) {
 		unsigned long nextlen;
 
 		len = linelen(line, size);
@@ -1536,7 +1532,7 @@ static int find_header(struct apply_state *state,
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
 			die(_("patch fragment without header at line %d: %.*s"),
-			    state_linenr, (int)len-1, line);
+			    state->linenr, (int)len-1, line);
 		}
 
 		if (size < len + 6)
@@ -1557,13 +1553,13 @@ static int find_header(struct apply_state *state,
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
@@ -1585,7 +1581,7 @@ static int find_header(struct apply_state *state,
 		/* Ok, we'll consider it a patch */
 		parse_traditional_patch(state, line, line+len, patch);
 		*hdrsize = len + nextlen;
-		state_linenr += 2;
+		state->linenr += 2;
 		return offset;
 	}
 	return -1;
@@ -1620,7 +1616,7 @@ static void check_whitespace(struct apply_state *state,
 {
 	unsigned result = ws_check(line + 1, len - 1, ws_rule);
 
-	record_ws_error(state, result, line + 1, len - 2, state_linenr);
+	record_ws_error(state, result, line + 1, len - 2, state->linenr);
 }
 
 /*
@@ -1653,11 +1649,11 @@ static int parse_fragment(struct apply_state *state,
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
@@ -1756,10 +1752,10 @@ static int parse_single_patch(struct apply_state *state,
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
@@ -1845,7 +1841,8 @@ static char *inflate_it(const void *data, unsigned long size,
  * points at an allocated memory that the caller must free, so
  * it is marked as "->free_patch = 1".
  */
-static struct fragment *parse_binary_hunk(char **buf_p,
+static struct fragment *parse_binary_hunk(struct apply_state *state,
+					  char **buf_p,
 					  unsigned long *sz_p,
 					  int *status_p,
 					  int *used_p)
@@ -1887,13 +1884,13 @@ static struct fragment *parse_binary_hunk(char **buf_p,
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
@@ -1947,7 +1944,7 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 	free(data);
 	*status_p = -1;
 	error(_("corrupt binary patch at line %d: %.*s"),
-	      state_linenr-1, llen-1, buffer);
+	      state->linenr-1, llen-1, buffer);
 	return NULL;
 }
 
@@ -1956,7 +1953,10 @@ static struct fragment *parse_binary_hunk(char **buf_p,
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
@@ -1977,15 +1977,15 @@ static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
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
@@ -2100,8 +2100,8 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
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
@@ -2121,7 +2121,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 				int len = strlen(binhdr[i]);
 				if (len < size - hd &&
 				    !memcmp(binhdr[i], buffer + hd, len)) {
-					state_linenr++;
+					state->linenr++;
 					patch->is_binary = 1;
 					patchsize = llen;
 					break;
@@ -2135,7 +2135,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 */
 		if ((state->apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
-			die(_("patch with only garbage at line %d"), state_linenr);
+			die(_("patch with only garbage at line %d"), state->linenr);
 	}
 
 	return offset + hdrsize + patchsize;
@@ -4654,6 +4654,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	state->squelch_whitespace_errors = 5;
 	state->ws_error_action = warn_on_ws_error;
 	state->ws_ignore_action = ignore_ws_none;
+	state->linenr = 1;
 	strbuf_init(&state->root, 0);
 
 	git_apply_config();
-- 
2.8.3.443.gaeee61e
