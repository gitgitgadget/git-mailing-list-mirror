From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/2] diff: avoid some nesting
Date: Mon, 16 Dec 2013 20:23:30 +0100
Message-ID: <1387221810-32374-2-git-send-email-t.gummerer@gmail.com>
References: <xmqqtxe8pu05.fsf@gitster.dls.corp.google.com>
 <1387221810-32374-1-git-send-email-t.gummerer@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 20:24:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsdma-0003fY-3a
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 20:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755118Ab3LPTYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 14:24:42 -0500
Received: from mail-bk0-f49.google.com ([209.85.214.49]:63639 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017Ab3LPTYl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 14:24:41 -0500
Received: by mail-bk0-f49.google.com with SMTP id my13so2479252bkb.36
        for <git@vger.kernel.org>; Mon, 16 Dec 2013 11:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I0rGa05CEi2svuLLVRj85gu3zE7bmkIOaJZfzuNbogE=;
        b=qzVp3ccjGdSexh8t9XpgPmHZi6Ke6DhjufflcAP3ZaVPesX7PQxCOvV4b8A2XPG0Uy
         Hb+siE859mo0jqXxgUiiCoTgrgkMtbjsaF5pj6Qdky3pIRM0Tq1nFGziU1IlVCSVqYfv
         7WPf9Da2T7HmAT/KwhfY26gfYDoH00zvgsna1ZPZaFzCLy6rwXdTS9lkQ6KQ7WtHBEGN
         OTO+zojN3/ys+MkhEq8R8XPOV6n6gzm1aPDCtNXh4j6z3Ss5LfhKjfPkrkEKzqXR97cr
         XmbDyv8Nkne0xb7nUOst3aCVZzD8DQ3Ptyjr0diKrmQjLfTM2BhL7H3tU4QbOyJ9MLMP
         IO7g==
X-Received: by 10.204.228.11 with SMTP id jc11mr808094bkb.135.1387221880558;
        Mon, 16 Dec 2013 11:24:40 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::1b8d])
        by mx.google.com with ESMTPSA id a4sm11342793bko.11.2013.12.16.11.24.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2013 11:24:39 -0800 (PST)
X-Mailer: git-send-email 1.8.5.4.g8639e57
In-Reply-To: <1387221810-32374-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239352>

Avoid some nesting in builtin/diff.c, to make the code easier to
read.  No functional changes.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

This is based on comments by Jonathan on the version that is already
next.

builtin/diff.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index ea1dd65..24d6271 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -319,27 +319,26 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	init_revisions(&rev, prefix);
 
-	if (no_index) {
-		if (argc != i + 2) {
-			if (no_index == DIFF_NO_INDEX_IMPLICIT) {
-				/*
-				 * There was no --no-index and there were not two
-				 * paths. It is possible that the user intended
-				 * to do an inside-repository operation.
-				 */
-				fprintf(stderr, "Not a git repository\n");
-				fprintf(stderr,
-					"To compare two paths outside a working tree:\n");
-			}
-			/* Give the usage message for non-repository usage and exit. */
-			usagef("git diff %s <path> <path>",
-			       no_index == DIFF_NO_INDEX_EXPLICIT ?
-					"--no-index" : "[--no-index]");
-
+	if (no_index && argc != i + 2) {
+		if (no_index == DIFF_NO_INDEX_IMPLICIT) {
+			/*
+			 * There was no --no-index and there were not two
+			 * paths. It is possible that the user intended
+			 * to do an inside-repository operation.
+			 */
+			fprintf(stderr, "Not a git repository\n");
+			fprintf(stderr,
+				"To compare two paths outside a working tree:\n");
 		}
+		/* Give the usage message for non-repository usage and exit. */
+		usagef("git diff %s <path> <path>",
+		       no_index == DIFF_NO_INDEX_EXPLICIT ?
+		       "--no-index" : "[--no-index]");
+
+	}
+	if (no_index)
 		/* If this is a no-index diff, just run it and exit there. */
 		diff_no_index(&rev, argc, argv, prefix);
-	}
 
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
-- 
1.8.5.4.g8639e57
