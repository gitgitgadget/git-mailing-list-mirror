From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Don't use the pager when running "git diff --check"
Date: Thu, 13 Dec 2007 20:45:38 +0100
Message-ID: <1197575138-58070-1-git-send-email-win@wincent.com>
References: <1197552751-53480-2-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 20:47:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2u1u-0006Bs-JY
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 20:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452AbXLMTrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 14:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758746AbXLMTrM
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 14:47:12 -0500
Received: from wincent.com ([72.3.236.74]:48338 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754286AbXLMTrL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 14:47:11 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBDJjdVI030807;
	Thu, 13 Dec 2007 13:45:40 -0600
X-Mailer: git-send-email 1.5.4.rc0.5.gd201-dirty
In-Reply-To: <1197552751-53480-2-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68186>

In 89d07f75 "git diff" learnt to not run the pager if the user passes
the --exit-code switch. This commit does the same for the --check
switch for the same reason: we want the user to get the exit status
from "git diff", not the pager.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---

This really should have been part of my original patch,
([PATCH 1/5] "diff --check" should affect exit status"), but I only
just discovered this now.

 builtin-diff.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 86d01a3..ed2d218 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -247,7 +247,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	/* If the user asked for our exit code then don't start a
 	 * pager or we would end up reporting its exit code instead.
 	 */
-	if (!DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS))
+	if (!DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS) &&
+	    (!&rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF))
 		setup_pager();
 
 	/* Do we have --cached and not have a pending object, then
-- 
1.5.4.rc0.5.gd201-dirty
