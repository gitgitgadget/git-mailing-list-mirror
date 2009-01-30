From: Geoffrey Thomas <geofft@MIT.EDU>
Subject: [PATCH] utf8: add utf8_strwidth()
Date: Fri, 30 Jan 2009 04:41:28 -0500
Message-ID: <1233308489-2656-1-git-send-email-geofft@mit.edu>
Cc: Geoffrey Thomas <geofft@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 10:45:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSpwQ-00078n-Le
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 10:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbZA3JoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 04:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbZA3JoM
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 04:44:12 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:45036 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751368AbZA3JoL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 04:44:11 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n0U9fUwe003015;
	Fri, 30 Jan 2009 04:41:30 -0500 (EST)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as geofft@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n0U9fTv3005561;
	Fri, 30 Jan 2009 04:41:29 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.255.g2979d
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107785>

From: Geoffrey Thomas <geofft@mit.edu>
I'm about to use this pattern more than once, so make it a common function.

Signed-off-by: Geoffrey Thomas <geofft@mit.edu>
---
 utf8.c |   12 ++++++++++++
 utf8.h |    1 +
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/utf8.c b/utf8.c
index dc37353..a2d888d 100644
--- a/utf8.c
+++ b/utf8.c
@@ -246,6 +246,18 @@ int utf8_width(const char **start, size_t *remainder_p)
 	return git_wcwidth(ch);
 }
 
+/*
+ * Returns the total number of columns required by a null-terminated
+ * string.
+ */
+size_t utf8_strwidth(const char *string)
+{
+	size_t width = 0;
+	while (string && *string)
+		width += utf8_width(&string, NULL);
+	return width;
+}
+
 int is_utf8(const char *text)
 {
 	while (*text) {
diff --git a/utf8.h b/utf8.h
index 98cce1b..1ae3450 100644
--- a/utf8.h
+++ b/utf8.h
@@ -5,6 +5,7 @@ typedef unsigned int ucs_char_t;  /* assuming 32bit int */
 
 ucs_char_t pick_one_utf8_char(const char **start, size_t *remainder_p);
 int utf8_width(const char **start, size_t *remainder_p);
+size_t utf8_strwidth(const char *string);
 int is_utf8(const char *text);
 int is_encoding_utf8(const char *name);
 
-- 
1.5.6.5
