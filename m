From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 03/94] builtin/apply: avoid parameter shadowing 'linenr' global
Date: Wed, 11 May 2016 15:16:14 +0200
Message-ID: <20160511131745.2914-4-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:18:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U2G-0001gv-9d
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbcEKNSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:18:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35032 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbcEKNSe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:18:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so9398999wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZxlkWGWr8tAUwMQQqmSzrrrU5YnmtepjikRaxGFkqkg=;
        b=eqGkrZVmKfgtuNaXDF47F6J8/mWxLGURQ+mYXYFN5FZNIZIjlO0XBfRxBBkvmCp/06
         VcaaZPI5fTgbNawezw4L6PTgvRfpef2Gust+j59OttQ5C/4Y9g/BJptiVjAuaV4YKSaJ
         nXpNP9bmZm1ZKFr/K35Xou7cKIPkgs+lvefFi0dt6Gwzfclv4CO5057l673t8T+6xvX7
         agq8t1lNuQHPmD+sxSl87KUD9UaEE2wb2Ih1br+AgPTtII6r4q21ah+Jdi7z8acuM4Pq
         Iykedq6rcolUIXwMqt2VxIz7vh88CN2JjjAkBKF/lOHpOlIjqGVxn33QO+CIVLm+YfAL
         eknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZxlkWGWr8tAUwMQQqmSzrrrU5YnmtepjikRaxGFkqkg=;
        b=lT1Le9F1ZG/k2tI9WMaR9HPy7XqElPyjRtuPgO018Iv64D+3HeK8ULtpxg29GSlZXd
         g7+NZKbf+Ot7Xg5QGzdg2nPVEWAOq19UmfmQ7aBrhxJpn8kAFLxkx5mguiiyp4h9f9zv
         urD4PxjOciMoC349BgJwtV0u46Suhe4w8u2AXIBJTc/CM0wISg69uOO3uuSkAFE/7eL9
         MhnVw25at31SgWhAjD5Nhj/g47D/eYq64oDC7fQE+qHjQ19MFz7Dn5/az2n7pyB+7YKz
         II4M8xTpsd8TwnqDfRBC1nQIXDUS3IZan1T5ZGczz9uyR9OeeP7LPMhYEZgA/uaRMG6k
         iEjw==
X-Gm-Message-State: AOPr4FXvt/EMFg+wSOj2VwoscKTBugBzLpTWVyZcSrA5rxPT4QBZLyI2SfoBwMIzrngWXQ==
X-Received: by 10.28.90.65 with SMTP id o62mr86314wmb.16.1462972712513;
        Wed, 11 May 2016 06:18:32 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:31 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294249>

Let's just rename the global 'state_linenr' as it will become
'state->linenr' in a following patch.

This also avoid errors when compiling with -Wshadow and makes
it safer to later move global variables into a "state" struct.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e133b38..705a9c8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -144,7 +144,7 @@ static int max_change, max_len;
  * file (and how) we're patching right now.. The "is_xxxx"
  * things are flags, where -1 means "don't know yet".
  */
-static int linenr = 1;
+static int state_linenr = 1;
 
 /*
  * This represents one "hunk" from a patch, starting with
@@ -905,7 +905,7 @@ static void parse_traditional_patch(const char *first, const char *second, struc
 		}
 	}
 	if (!name)
-		die(_("unable to find filename in patch at line %d"), linenr);
+		die(_("unable to find filename in patch at line %d"), state_linenr);
 }
 
 static int gitdiff_hdrend(const char *line, struct patch *patch)
@@ -937,17 +937,17 @@ static void gitdiff_verify_name(const char *line, int isnull, char **name, int s
 		char *another;
 		if (isnull)
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
-			    *name, linenr);
+			    *name, state_linenr);
 		another = find_name(line, NULL, state_p_value, TERM_TAB);
 		if (!another || memcmp(another, *name, len + 1))
 			die((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
-			    _("git apply: bad git-diff - inconsistent old filename on line %d"), linenr);
+			    _("git apply: bad git-diff - inconsistent old filename on line %d"), state_linenr);
 		free(another);
 	} else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
-			die(_("git apply: bad git-diff - expected /dev/null on line %d"), linenr);
+			die(_("git apply: bad git-diff - expected /dev/null on line %d"), state_linenr);
 	}
 }
 
@@ -1272,8 +1272,8 @@ static int parse_git_header(const char *line, int len, unsigned int size, struct
 
 	line += len;
 	size -= len;
-	linenr++;
-	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, linenr++) {
+	state_linenr++;
+	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, state_linenr++) {
 		static const struct opentry {
 			const char *str;
 			int (*fn)(const char *, struct patch *);
@@ -1440,7 +1440,7 @@ static int find_header(const char *line, unsigned long size, int *hdrsize, struc
 	patch->is_new = patch->is_delete = -1;
 	patch->old_mode = patch->new_mode = 0;
 	patch->old_name = patch->new_name = NULL;
-	for (offset = 0; size > 0; offset += len, size -= len, line += len, linenr++) {
+	for (offset = 0; size > 0; offset += len, size -= len, line += len, state_linenr++) {
 		unsigned long nextlen;
 
 		len = linelen(line, size);
@@ -1461,7 +1461,7 @@ static int find_header(const char *line, unsigned long size, int *hdrsize, struc
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
 			die(_("patch fragment without header at line %d: %.*s"),
-			    linenr, (int)len-1, line);
+			    state_linenr, (int)len-1, line);
 		}
 
 		if (size < len + 6)
@@ -1482,13 +1482,13 @@ static int find_header(const char *line, unsigned long size, int *hdrsize, struc
 					       "git diff header lacks filename information when removing "
 					       "%d leading pathname components (line %d)",
 					       state_p_value),
-					    state_p_value, linenr);
+					    state_p_value, state_linenr);
 				patch->old_name = xstrdup(patch->def_name);
 				patch->new_name = xstrdup(patch->def_name);
 			}
 			if (!patch->is_delete && !patch->new_name)
 				die("git diff header lacks filename information "
-				    "(line %d)", linenr);
+				    "(line %d)", state_linenr);
 			patch->is_toplevel_relative = 1;
 			*hdrsize = git_hdr_len;
 			return offset;
@@ -1510,7 +1510,7 @@ static int find_header(const char *line, unsigned long size, int *hdrsize, struc
 		/* Ok, we'll consider it a patch */
 		parse_traditional_patch(line, line+len, patch);
 		*hdrsize = len + nextlen;
-		linenr += 2;
+		state_linenr += 2;
 		return offset;
 	}
 	return -1;
@@ -1538,7 +1538,7 @@ static void check_whitespace(const char *line, int len, unsigned ws_rule)
 {
 	unsigned result = ws_check(line + 1, len - 1, ws_rule);
 
-	record_ws_error(result, line + 1, len - 2, linenr);
+	record_ws_error(result, line + 1, len - 2, state_linenr);
 }
 
 /*
@@ -1568,11 +1568,11 @@ static int parse_fragment(const char *line, unsigned long size,
 	/* Parse the thing.. */
 	line += len;
 	size -= len;
-	linenr++;
+	state_linenr++;
 	added = deleted = 0;
 	for (offset = len;
 	     0 < size;
-	     offset += len, size -= len, line += len, linenr++) {
+	     offset += len, size -= len, line += len, state_linenr++) {
 		if (!oldlines && !newlines)
 			break;
 		len = linelen(line, size);
@@ -1668,10 +1668,10 @@ static int parse_single_patch(const char *line, unsigned long size, struct patch
 		int len;
 
 		fragment = xcalloc(1, sizeof(*fragment));
-		fragment->linenr = linenr;
+		fragment->linenr = state_linenr;
 		len = parse_fragment(line, size, patch, fragment);
 		if (len <= 0)
-			die(_("corrupt patch at line %d"), linenr);
+			die(_("corrupt patch at line %d"), state_linenr);
 		fragment->patch = line;
 		fragment->size = len;
 		oldlines += fragment->oldlines;
@@ -1799,13 +1799,13 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 	else
 		return NULL;
 
-	linenr++;
+	state_linenr++;
 	buffer += llen;
 	while (1) {
 		int byte_length, max_byte_length, newsize;
 		llen = linelen(buffer, size);
 		used += llen;
-		linenr++;
+		state_linenr++;
 		if (llen == 1) {
 			/* consume the blank line */
 			buffer++;
@@ -1859,7 +1859,7 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 	free(data);
 	*status_p = -1;
 	error(_("corrupt binary patch at line %d: %.*s"),
-	      linenr-1, llen-1, buffer);
+	      state_linenr-1, llen-1, buffer);
 	return NULL;
 }
 
@@ -1892,7 +1892,7 @@ static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
 	forward = parse_binary_hunk(&buffer, &size, &status, &used);
 	if (!forward && !status)
 		/* there has to be one hunk (forward hunk) */
-		return error(_("unrecognized binary patch at line %d"), linenr-1);
+		return error(_("unrecognized binary patch at line %d"), state_linenr-1);
 	if (status)
 		/* otherwise we already gave an error message */
 		return status;
@@ -2010,7 +2010,7 @@ static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 		if (llen == sizeof(git_binary) - 1 &&
 		    !memcmp(git_binary, buffer + hd, llen)) {
 			int used;
-			linenr++;
+			state_linenr++;
 			used = parse_binary(buffer + hd + llen,
 					    size - hd - llen, patch);
 			if (used < 0)
@@ -2031,7 +2031,7 @@ static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 				int len = strlen(binhdr[i]);
 				if (len < size - hd &&
 				    !memcmp(binhdr[i], buffer + hd, len)) {
-					linenr++;
+					state_linenr++;
 					patch->is_binary = 1;
 					patchsize = llen;
 					break;
@@ -2045,7 +2045,7 @@ static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 		 */
 		if ((apply || check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
-			die(_("patch with only garbage at line %d"), linenr);
+			die(_("patch with only garbage at line %d"), state_linenr);
 	}
 
 	return offset + hdrsize + patchsize;
-- 
2.8.2.490.g3dabe57
