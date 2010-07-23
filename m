From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] Makefile: make hard/symbolic links for non-builtins too
Date: Fri, 23 Jul 2010 12:50:45 -0500
Message-ID: <taBDPvzBKDvxYMKKellyXA806jSWITGITetvHyKi-Fz0wgftlDIrmDQ4JZCa6Wy7AEyhL79CNYA@cipher.nrlssc.navy.mil>
References: <taBDPvzBKDtgdmYKlcbFJ_fQRnY4jBMR74BF1vetbRU3OZRMPpwtU0wTG1SSa0hFgNsCN5k9Qx8@cipher.nrlssc.navy.mil>
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 19:51:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcMP4-0004yp-Sk
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 19:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758571Ab0GWRvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 13:51:05 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55143 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064Ab0GWRvE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 13:51:04 -0400
Received: by mail.nrlssc.navy.mil id o6NHp1xp018617; Fri, 23 Jul 2010 12:51:01 -0500
In-Reply-To: <taBDPvzBKDtgdmYKlcbFJ_fQRnY4jBMR74BF1vetbRU3OZRMPpwtU0wTG1SSa0hFgNsCN5k9Qx8@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 23 Jul 2010 17:51:01.0185 (UTC) FILETIME=[9CEFEB10:01CB2A8F]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151559>

From: Brandon Casey <drafnel@gmail.com>

To conserve space/improve file caching we try to make hard or symbolic links
from each builtin program to the main git executable rather than having
each be a complete duplicate copy of it.  We weren't doing this for the
non-builtin programs though.  So, just because we can, and because it's
easy, and for completeness sake, let's do it.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Makefile |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index d725c15..17c9130 100644
--- a/Makefile
+++ b/Makefile
@@ -2075,10 +2075,13 @@ endif
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
 	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
 	{ test "$$bindir/" = "$$execdir/" || \
-		{ $(RM) "$$execdir/git$X" && \
+	  for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
+		$(RM) "$$execdir/$$p" && \
 		test -z "$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
-		ln "$$bindir/git$X" "$$execdir/git$X" 2>/dev/null || \
-		cp "$$bindir/git$X" "$$execdir/git$X"; } ; } && \
+		ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
+		cp "$$bindir/$$p" "$$execdir/$$p" || exit; \
+	  done; \
+	} && \
 	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
 		$(RM) "$$bindir/$$p" && \
 		ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
-- 
1.7.2
