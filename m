From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 01/11] test-chmtime: Fix exit code on Windows
Date: Sat,  1 Jun 2013 11:34:20 +0200
Message-ID: <c5913d1a95ed5a9aaa92eece2484274949acc78e.1370076477.git.j6t@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 01 11:34:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiiCu-0001y1-JY
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 11:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519Ab3FAJeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 05:34:36 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:17796 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751669Ab3FAJee (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 05:34:34 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 97BE1CDF8D
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:32 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id C856219F5E0
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:31 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226107>

MinGW's bash does not recognize an exit code -1 as failure. See also
47e3de0e (MinGW: truncate exit()'s argument to lowest 8 bits) and 2488df84
(builtin run_command: do not exit with -1). Exit code 1 is good enough.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 test-chmtime.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test-chmtime.c b/test-chmtime.c
index 94903c4..28b2313 100644
--- a/test-chmtime.c
+++ b/test-chmtime.c
@@ -84,7 +84,7 @@ int main(int argc, char *argv[])
 		if (stat(argv[i], &sb) < 0) {
 			fprintf(stderr, "Failed to stat %s: %s\n",
 			        argv[i], strerror(errno));
-			return -1;
+			return 1;
 		}
 
 #ifdef WIN32
@@ -92,7 +92,7 @@ int main(int argc, char *argv[])
 				chmod(argv[i], sb.st_mode | S_IWUSR)) {
 			fprintf(stderr, "Could not make user-writable %s: %s",
 				argv[i], strerror(errno));
-			return -1;
+			return 1;
 		}
 #endif
 
@@ -107,7 +107,7 @@ int main(int argc, char *argv[])
 		if (utb.modtime != sb.st_mtime && utime(argv[i], &utb) < 0) {
 			fprintf(stderr, "Failed to modify time on %s: %s\n",
 			        argv[i], strerror(errno));
-			return -1;
+			return 1;
 		}
 	}
 
@@ -115,5 +115,5 @@ int main(int argc, char *argv[])
 
 usage:
 	fprintf(stderr, "usage: %s %s\n", argv[0], usage_str);
-	return -1;
+	return 1;
 }
-- 
1.8.3.rc1.32.g8b61cbb
