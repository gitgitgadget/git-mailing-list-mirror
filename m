From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 65/83] builtin/apply: make gitdiff_verify_name() return -1 on error
Date: Sun, 24 Apr 2016 15:34:05 +0200
Message-ID: <1461504863-15946-66-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:37:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKDt-0000Sh-Py
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbcDXNhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:37:11 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33673 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbcDXNgS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:18 -0400
Received: by mail-wm0-f45.google.com with SMTP id 127so17919406wmz.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fkfI1G/yDxfihxMqGaBEc3FiP7QfKN4RIBs9vvdAx1k=;
        b=LJTap7/rgShx71FrOmAA2Lj211wqbfQqUGpc1e2AnWFUTGZjoGjLltVUVhsZWJE/6i
         g6k2mwWzHM6EfxAsBSCyUQMgaQGXocTssceTcNqxVZUCrF+UFK98D4oBRXUUGFVDXie1
         LoRBnUe1hxFucPzsMDvgepqy+DKOoyQstc6m4pSUYlVhHgJjrQFftajPF+Gi3e34oJTh
         V7F0UTPLeAsjKOlz2QKHpQKZMao4jleIQSHUa1r5av3PvQZX+0Wkj1TVM/Tn0erAVqK9
         i5/aFZx34P3c+Xw+fa+p8ri+7MehemlbQ5jZ4rDnWxaHS18roH6eWkkm840FC5ntyOMU
         6SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fkfI1G/yDxfihxMqGaBEc3FiP7QfKN4RIBs9vvdAx1k=;
        b=L8DPvQjWYDB67GvbmlB2BibjXu8vsDKvd8BwmXAKcNbRdjfMa5IbPOOYiUqkDUuogh
         CvuPpStmF6qb/b2ff9wfOyTJelEMz6WzzsfZz0YYp5h6UbySBYaWasUaTyZIecwVpLiR
         94IBwz7EGxLw4NleJdkoJPdiQlreoKxkjcSkwgDu/DjLPnlfk84RxMyhyuKUC4j0gKm9
         0sKTnweifeiFtgH/ySRjnk5rksEycTgLNmeLOgrtPjArIFWH6GKcLPpMeUowwXLrQEsI
         6PmNYud8sSJMErcTqJD10/TXIXUHw8IreDanufYfYg4TLvat77k8TUGWzqWA9mmjNv3A
         fs+g==
X-Gm-Message-State: AOPr4FVQVKttfqlKqiNbus8KrV/zMFsauryX9xQhEnxtG6LvTCk1FKlmIbN5t6OHf+lsaQ==
X-Received: by 10.194.48.7 with SMTP id h7mr32852795wjn.81.1461504977076;
        Sun, 24 Apr 2016 06:36:17 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:16 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292370>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6b8ba2a..268356b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -812,7 +812,7 @@ static int gitdiff_hdrend(struct apply_state *state,
 			  const char *line,
 			  struct patch *patch)
 {
-	return -1;
+	return 1;
 }
 
 /*
@@ -827,54 +827,56 @@ static int gitdiff_hdrend(struct apply_state *state,
 #define DIFF_OLD_NAME 0
 #define DIFF_NEW_NAME 1
 
-static void gitdiff_verify_name(struct apply_state *state,
-				const char *line,
-				int isnull,
-				char **name,
-				int side)
+static int gitdiff_verify_name(struct apply_state *state,
+			       const char *line,
+			       int isnull,
+			       char **name,
+			       int side)
 {
 	if (!*name && !isnull) {
 		*name = find_name(state, line, NULL, state->p_value, TERM_TAB);
-		return;
+		return 0;
 	}
 
 	if (*name) {
 		int len = strlen(*name);
 		char *another;
 		if (isnull)
-			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
-			    *name, state->linenr);
+			return error(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
+				     *name, state->linenr);
 		another = find_name(state, line, NULL, state->p_value, TERM_TAB);
-		if (!another || memcmp(another, *name, len + 1))
-			die((side == DIFF_NEW_NAME) ?
+		if (!another || memcmp(another, *name, len + 1)) {
+			free(another);
+			return error((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
 			    _("git apply: bad git-diff - inconsistent old filename on line %d"), state->linenr);
+		}
 		free(another);
 	} else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
-			die(_("git apply: bad git-diff - expected /dev/null on line %d"), state->linenr);
+			return error(_("git apply: bad git-diff - expected /dev/null on line %d"), state->linenr);
 	}
+
+	return 0;
 }
 
 static int gitdiff_oldname(struct apply_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	gitdiff_verify_name(state, line,
-			    patch->is_new, &patch->old_name,
-			    DIFF_OLD_NAME);
-	return 0;
+	return gitdiff_verify_name(state, line,
+				   patch->is_new, &patch->old_name,
+				   DIFF_OLD_NAME);
 }
 
 static int gitdiff_newname(struct apply_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	gitdiff_verify_name(state, line,
-			    patch->is_delete, &patch->new_name,
-			    DIFF_NEW_NAME);
-	return 0;
+	return gitdiff_verify_name(state, line,
+				   patch->is_delete, &patch->new_name,
+				   DIFF_NEW_NAME);
 }
 
 static int gitdiff_oldmode(struct apply_state *state,
@@ -1016,7 +1018,7 @@ static int gitdiff_unrecognized(struct apply_state *state,
 				const char *line,
 				struct patch *patch)
 {
-	return -1;
+	return 1;
 }
 
 /*
@@ -1248,9 +1250,13 @@ static int parse_git_header(struct apply_state *state,
 		for (i = 0; i < ARRAY_SIZE(optable); i++) {
 			const struct opentry *p = optable + i;
 			int oplen = strlen(p->str);
+			int res;
 			if (len < oplen || memcmp(p->str, line, oplen))
 				continue;
-			if (p->fn(state, line + oplen, patch) < 0)
+			res = p->fn(state, line + oplen, patch);
+			if (res < 0)
+				return -1;
+			if (res > 0)
 				return offset;
 			break;
 		}
@@ -1429,6 +1435,8 @@ static int find_header(struct apply_state *state,
 		 */
 		if (!memcmp("diff --git ", line, 11)) {
 			int git_hdr_len = parse_git_header(state, line, len, size, patch);
+			if (git_hdr_len < 0)
+				return -1;
 			if (git_hdr_len <= len)
 				continue;
 			if (!patch->old_name && !patch->new_name) {
-- 
2.8.1.300.g5fed0c0
