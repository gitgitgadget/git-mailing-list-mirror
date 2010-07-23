From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] Makefile: link builtins residing in bin directory to main git binary too
Date: Fri, 23 Jul 2010 12:50:44 -0500
Message-ID: <taBDPvzBKDsn4R3mVCPIS8b7DATXdlBe-WqMByA8COCjNJVZsuTq4cKE-C0wPs_pTG1B23aAVpU@cipher.nrlssc.navy.mil>
References: <taBDPvzBKDtgdmYKlcbFJ_fQRnY4jBMR74BF1vetbRU3OZRMPpwtU0wTG1SSa0hFgNsCN5k9Qx8@cipher.nrlssc.navy.mil>
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 19:51:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcMPO-0005EN-9B
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 19:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757591Ab0GWRvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 13:51:04 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55139 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab0GWRvB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 13:51:01 -0400
Received: by mail.nrlssc.navy.mil id o6NHp0PT018610; Fri, 23 Jul 2010 12:51:00 -0500
In-Reply-To: <taBDPvzBKDtgdmYKlcbFJ_fQRnY4jBMR74BF1vetbRU3OZRMPpwtU0wTG1SSa0hFgNsCN5k9Qx8@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 23 Jul 2010 17:51:00.0310 (UTC) FILETIME=[9C6A6760:01CB2A8F]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151560>

From: Brandon Casey <drafnel@gmail.com>

To conserve space/improve file caching we try to make hard or symbolic links
from each builtin program to the main git executable rather than having
each be a complete duplicate copy of it.  We weren't doing this for the
builtin programs residing in the bin directory though.  So, let's do so.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Makefile |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index bc3c570..d725c15 100644
--- a/Makefile
+++ b/Makefile
@@ -2079,6 +2079,12 @@ endif
 		test -z "$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
 		ln "$$bindir/git$X" "$$execdir/git$X" 2>/dev/null || \
 		cp "$$bindir/git$X" "$$execdir/git$X"; } ; } && \
+	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
+		$(RM) "$$bindir/$$p" && \
+		ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
+		ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
+		cp "$$bindir/git$X" "$$bindir/$$p" || exit; \
+	done && \
 	for p in $(BUILT_INS); do \
 		$(RM) "$$execdir/$$p" && \
 		ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
-- 
1.7.2
