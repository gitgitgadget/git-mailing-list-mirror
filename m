From: Arjen Laarhoven <arjen@yaph.org>
Subject: [PATCH] Fix "git log --diff-filter" bug
Date: Tue, 25 Dec 2007 12:06:47 +0100
Message-ID: <1198580807-18802-1-git-send-email-arjen@yaph.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 25 12:16:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J77m4-0000LO-Gz
	for gcvg-git-2@gmane.org; Tue, 25 Dec 2007 12:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbXLYLQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Dec 2007 06:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbXLYLQH
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Dec 2007 06:16:07 -0500
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:4524 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbXLYLQH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Dec 2007 06:16:07 -0500
X-Greylist: delayed 531 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Dec 2007 06:16:06 EST
Received: from libellus.local (aragorndsl.demon.nl [82.161.19.32])
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBPB6mXs047569;
	Tue, 25 Dec 2007 12:06:48 +0100 (CET)
	(envelope-from arjen@yaph.org)
Received: by libellus.local (Postfix, from userid 501)
	id 7157E27822D; Tue, 25 Dec 2007 12:06:47 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc1.21.g0e545
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69232>

In commit b7bb760d5ed4881422673d32f869d140221d3564 an optimization
was made to avoid unnecessary diff generation.  This was partly fixed
in 99516e35d096f41e7133cacde8fbed8ee9a3ecd0, but obviously the
'--diff-filter' option also needs the diff machinery in action.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 revision.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 7e2f4f1..6e85aaa 100644
--- a/revision.c
+++ b/revision.c
@@ -1290,8 +1290,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (revs->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT)
 		revs->diff = 1;
 
-	/* Pickaxe and rename following needs diffs */
-	if (revs->diffopt.pickaxe || DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
+	/* Pickaxe, diff-filter and rename following need diffs */
+	if (revs->diffopt.pickaxe ||
+	    revs->diffopt.filter ||
+	    DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
 		revs->diff = 1;
 
 	if (revs->topo_order)
-- 
1.5.4.rc1.21.g0e545
