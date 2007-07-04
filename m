From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] filter-branch: Avoid an error message in the map function.
Date: Wed,  4 Jul 2007 09:54:07 +0200
Message-ID: <11835356473029-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	j.sixt@eudaptics.com, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 04 09:54:14 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5zgj-0008GF-U7
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 09:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195AbXGDHyL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 03:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755205AbXGDHyL
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 03:54:11 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8367 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839AbXGDHyL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 03:54:11 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1I5zgd-00077L-Ve; Wed, 04 Jul 2007 09:54:08 +0200
Received: from srv.linz.eudaptics (srv.linz.eudaptics [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9EFDE6EF; Wed,  4 Jul 2007 09:54:07 +0200 (CEST)
Received: by srv.linz.eudaptics (Postfix, from userid 503)
	id 6E284103; Wed,  4 Jul 2007 09:54:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc0.5.g7cd9
X-Spam-Score: 3.6 (+++)
X-Spam-Report: BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51577>

When the map function didn't find the rewritten commit of the passed in
original id, it printed the original id, but it still fell through to
the 'cat', which failed with an error message.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
Is the sequence of && and || ok, or do you prefer if-then-else-fi?

-- Hannes

 git-filter-branch.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 22fb5bf..ff1cbcf 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -16,8 +16,9 @@ USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]"
 map()
 {
 	# if it was not rewritten, take the original
-	test -r "$workdir/../map/$1" || echo "$1"
-	cat "$workdir/../map/$1"
+	test -r "$workdir/../map/$1" &&
+	cat "$workdir/../map/$1" ||
+	echo "$1"
 }
 
 # When piped a commit, output a script to set the ident of either
-- 
1.5.3.rc0.5.g7cd9
