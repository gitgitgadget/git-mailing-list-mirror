From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 5/5] t/aggregate-results: accomodate systems with small max argument list length
Date: Tue,  1 Jun 2010 19:13:44 -0500
Message-ID: <Wt_M4qptcPdpY0Q3jqUbfAATps4JfgEDin2dv8LrDHm_Fo4KpNe5saysU1vbzrL2g3gt1PWHFQY@cipher.nrlssc.navy.mil>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 02:15:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJbcE-00083t-Vx
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 02:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757548Ab0FBAPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 20:15:19 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47114 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756488Ab0FBAPS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 20:15:18 -0400
Received: by mail.nrlssc.navy.mil id o520EGR5007928; Tue, 1 Jun 2010 19:14:16 -0500
In-Reply-To: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 02 Jun 2010 00:14:16.0677 (UTC) FILETIME=[89D68950:01CB01E8]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148179>

From: Brandon Casey <drafnel@gmail.com>

IRIX 6.5 has a default maximum argument list length of 20480.  The file
glob that is passed to aggregate-results currently exceeds this length, and
so the script cannot run successfully.  Work around this issue by passing
the file names in via the standard input rather than the argument list.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/Makefile             |    4 +++-
 t/aggregate-results.sh |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 25c559b..cd008a3 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -35,7 +35,9 @@ aggregate-results-and-cleanup: $(T)
 	$(MAKE) clean
 
 aggregate-results:
-	'$(SHELL_PATH_SQ)' ./aggregate-results.sh test-results/t*-*
+	for f in test-results/t*-*; do \
+		echo "$$f"; \
+	done | '$(SHELL_PATH_SQ)' ./aggregate-results.sh
 
 # we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
 full-svn-test:
diff --git a/t/aggregate-results.sh b/t/aggregate-results.sh
index d5bab75..d206b7c 100755
--- a/t/aggregate-results.sh
+++ b/t/aggregate-results.sh
@@ -6,7 +6,7 @@ failed=0
 broken=0
 total=0
 
-for file
+while read file
 do
 	while read type value
 	do
-- 
1.6.6.2
