From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 01/10] test-chmtime: Fix exit code on Windows
Date: Fri,  7 Jun 2013 22:53:25 +0200
Message-ID: <ba3c59d26cfb23a8c71c66ef1d49c4dca55fc556.1370636706.git.j6t@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 22:54:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3fi-00075o-10
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756923Ab3FGUxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:53:37 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:33328 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756102Ab3FGUxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:53:37 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D55CB130049;
	Fri,  7 Jun 2013 22:53:34 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7EE3F19F5E7;
	Fri,  7 Jun 2013 22:53:34 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
In-Reply-To: <cover.1370636706.git.j6t@kdbg.org>
References: <cover.1370636706.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226714>

MinGW's bash does not recognize an exit code -1 as failure. See also
47e3de0e (MinGW: truncate exit()'s argument to lowest 8 bits) and 2488df84
(builtin run_command: do not exit with -1). Exit code 1 is good enough.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 test-chmtime.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test-chmtime.c b/test-chmtime.c
index 02b42ba..2e601a8 100644
--- a/test-chmtime.c
+++ b/test-chmtime.c
@@ -84,7 +84,7 @@ int main(int argc, const char *argv[])
 		if (stat(argv[i], &sb) < 0) {
 			fprintf(stderr, "Failed to stat %s: %s\n",
 			        argv[i], strerror(errno));
-			return -1;
+			return 1;
 		}
 
 #ifdef WIN32
@@ -92,7 +92,7 @@ int main(int argc, const char *argv[])
 				chmod(argv[i], sb.st_mode | S_IWUSR)) {
 			fprintf(stderr, "Could not make user-writable %s: %s",
 				argv[i], strerror(errno));
-			return -1;
+			return 1;
 		}
 #endif
 
@@ -107,7 +107,7 @@ int main(int argc, const char *argv[])
 		if (utb.modtime != sb.st_mtime && utime(argv[i], &utb) < 0) {
 			fprintf(stderr, "Failed to modify time on %s: %s\n",
 			        argv[i], strerror(errno));
-			return -1;
+			return 1;
 		}
 	}
 
@@ -115,5 +115,5 @@ int main(int argc, const char *argv[])
 
 usage:
 	fprintf(stderr, "usage: %s %s\n", argv[0], usage_str);
-	return -1;
+	return 1;
 }
-- 
1.8.3.rc1.32.g8b61cbb
