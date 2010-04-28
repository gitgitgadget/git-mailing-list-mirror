From: Alexey Mahotkin <squadette@gmail.com>
Subject: [PATCH] xdiff/xmerge.c: use memset() instead of explicit for-loop
Date: Wed, 28 Apr 2010 15:29:06 +0400
Message-ID: <1272454146-5519-1-git-send-email-squadette@gmail.com>
Cc: gitster@pobox.com, Alexey Mahotkin <squadette@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 28 13:55:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O75rm-0000fK-Ec
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 13:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249Ab0D1Lzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 07:55:40 -0400
Received: from mynd.rinet.ru ([195.54.209.181]:47332 "EHLO mynd.rinet.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312Ab0D1Lzk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 07:55:40 -0400
X-Greylist: delayed 1583 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Apr 2010 07:55:39 EDT
Received: from mynd.rinet.ru (localhost.localdomain [127.0.0.1])
	by mynd.rinet.ru (8.14.3/8.14.3) with ESMTP id o3SBT9xR005744;
	Wed, 28 Apr 2010 15:29:09 +0400
Received: (from alexm@localhost)
	by mynd.rinet.ru (8.14.3/8.14.3/Submit) id o3SBT6vX005706;
	Wed, 28 Apr 2010 15:29:06 +0400
X-Mailer: git-send-email 1.6.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145988>

memset() is heavily optimized, and resulting assembler code
is about 150 lines less for that file.

Signed-off-by: Alexey Mahotkin <squadette@gmail.com>
---
 xdiff/xmerge.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 16dd9ac..6d6fc1b 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -152,7 +152,6 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
 	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
 	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
-	int j;
 
 	if (marker_size <= 0)
 		marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
@@ -164,8 +163,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	if (!dest) {
 		size += marker_size + 1 + marker1_size;
 	} else {
-		for (j = 0; j < marker_size; j++)
-			dest[size++] = '<';
+		memset(dest + size, '<', marker_size);
+		size += marker_size;
 		if (marker1_size) {
 			dest[size] = ' ';
 			memcpy(dest + size + 1, name1, marker1_size - 1);
@@ -183,8 +182,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 		if (!dest) {
 			size += marker_size + 1 + marker3_size;
 		} else {
-			for (j = 0; j < marker_size; j++)
-				dest[size++] = '|';
+			memset(dest + size, '|', marker_size);
+			size += marker_size;
 			if (marker3_size) {
 				dest[size] = ' ';
 				memcpy(dest + size + 1, name3, marker3_size - 1);
@@ -199,8 +198,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	if (!dest) {
 		size += marker_size + 1;
 	} else {
-		for (j = 0; j < marker_size; j++)
-			dest[size++] = '=';
+		memset(dest + size, '=', marker_size);
+		size += marker_size;
 		dest[size++] = '\n';
 	}
 
@@ -210,8 +209,8 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	if (!dest) {
 		size += marker_size + 1 + marker2_size;
 	} else {
-		for (j = 0; j < marker_size; j++)
-			dest[size++] = '>';
+		memset(dest + size, '>', marker_size);
+		size += marker_size;
 		if (marker2_size) {
 			dest[size] = ' ';
 			memcpy(dest + size + 1, name2, marker2_size - 1);
-- 
1.6.2.5
