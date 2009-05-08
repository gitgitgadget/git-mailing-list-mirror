From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Disallow '\' in ref names
Date: Fri,  8 May 2009 07:32:37 +0200
Message-ID: <1241760757-26068-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, spearce@spearce.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 08 07:33:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Ihm-00014M-Jc
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 07:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbZEHFcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 01:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbZEHFcs
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 01:32:48 -0400
Received: from mail.dewire.com ([83.140.172.130]:26538 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbZEHFcr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 01:32:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8AD311444152;
	Fri,  8 May 2009 07:32:40 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LwFVwwB453YR; Fri,  8 May 2009 07:32:38 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id 8C49D1444151;
	Fri,  8 May 2009 07:32:38 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118563>

This is asking for trouble since '\' is a directory separator in
Windows and thus may produce unpredictable results.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 Documentation/git-check-ref-format.txt |    2 ++
 refs.c                                 |    3 ++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index c1ce268..4884520 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -38,6 +38,8 @@ imposes the following rules on how references are named:
 
 . They cannot contain a sequence `@{`.
 
+- They cannot contain a `\\`
+
 These rules make it easy for shell script based tools to parse
 reference names, pathname expansion by the shell when a reference name is used
 unquoted (by mistake), and also avoids ambiguities in certain
diff --git a/refs.c b/refs.c
index e65a3b4..fc33bc6 100644
--- a/refs.c
+++ b/refs.c
@@ -682,12 +682,13 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
  * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
  * - it ends with a "/".
  * - it ends with ".lock"
+ * - it contains a "\" (backslash)
  */
 
 static inline int bad_ref_char(int ch)
 {
 	if (((unsigned) ch) <= ' ' ||
-	    ch == '~' || ch == '^' || ch == ':')
+	    ch == '~' || ch == '^' || ch == ':' || ch == '\\')
 		return 1;
 	/* 2.13 Pattern Matching Notation */
 	if (ch == '?' || ch == '[') /* Unsupported */
-- 
1.6.3.dirty
