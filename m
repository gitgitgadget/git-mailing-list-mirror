From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 03/49] builtin/apply: avoid parameter shadowing 'linenr' global
Date: Tue, 24 May 2016 10:10:40 +0200
Message-ID: <20160524081126.16973-4-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:16:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Vq-0002IQ-5G
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbcEXIQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:16:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32939 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543AbcEXILw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:11:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id 67so3637620wmg.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U9IwKkbOC+AqmoRYI7yLUsj5z+9X0ZVQg26QZXOMZ+8=;
        b=iQ93a4OvfPKZdgy5NkAsiCxJr1i2l2pTQ+/LoRNUozsCUZD/mqT1ra5cND+zGDTl/8
         F68Cw5B5NAhUpchk3c6kZDPxNQX24gDdCY16SfAp1CdZdd7nqJqsC8rSdJ2aZnK47wlG
         nXxrVijAWtFxF8k0ClrIN0S51b7BfY0Por1xFafnTNGatJKo6/CWV7nne5sQgi4RC2VP
         sCgrJaHsxd+PTYOZTlgWZQTa0kJtiTNFQP98N0EMWF5H6qXyNTtNBhqHYW0B1pWyLo4W
         emsKzQE0mIDmZ/rWcm1QCaAa6MOdphG9K5lpGTFygsjxVssOMaF46ugtKjEERqq5j6s4
         I6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U9IwKkbOC+AqmoRYI7yLUsj5z+9X0ZVQg26QZXOMZ+8=;
        b=RNH4JBRpF/ATSGZz1sM8fzkjq5nUn5qT5R3nHQayf5mvalYc6s9poZu9vLMHXKuD0D
         0r6DfOr1shlaBD39pThChML7Z5/NbDgDdjKw5i3fDvaw7/4fYZVw65HSLncmO/5K0y4V
         sJ6WUmPIhSLqWGyp646JXesPFTwjlus4Lx5j91S7HKTA+g590clgfyL0J8YAGJnQJWqT
         g//+i/7QrQAe+5lwofRzqDeHnWX0e3dUxfZFIgyupsH1mlcGo0NZ3N2UzA07hND1ovfH
         533NZ3Sv491Ahi14VDUIcdXM7+sSvsLcL4B9YsNiWz5uxyjOmsAdd/ev8xOfDOem8B4V
         yYsw==
X-Gm-Message-State: AOPr4FW1daP2tPF+kSgtVlKQXXPv1YIe7Wa89/oyBf9FnS8HYDwRkm93f3G1tLI/TkMPFA==
X-Received: by 10.28.11.143 with SMTP id 137mr20294916wml.92.1464077510411;
        Tue, 24 May 2016 01:11:50 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:11:49 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295475>

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
2.8.3.443.gaeee61e
