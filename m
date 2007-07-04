From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: [PATCH take 2] filter-branch: Avoid an error message in the map 
 function.
Date: Wed, 04 Jul 2007 14:08:17 +0200
Organization: eudaptics software gmbh
Message-ID: <468B8DB1.9A4CF1E6@eudaptics.com>
References: <11835356473029-git-send-email-johannes.sixt@telecom.at>
	 <Pine.LNX.4.64.0707041205250.4071@racer.site> <468B8852.CB36968@eudaptics.com> <Pine.LNX.4.64.0707041247520.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 14:07:53 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I63e9-0004cF-TX
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 14:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759764AbXGDMHr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 08:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759339AbXGDMHr
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 08:07:47 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24085 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757444AbXGDMHq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 08:07:46 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1I63e3-0005cj-IN; Wed, 04 Jul 2007 14:07:43 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 63B776EF; Wed,  4 Jul 2007 14:07:43 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 1.9 (+)
X-Spam-Report: AWL=-1.708, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51601>

When the map function didn't find the rewritten commit of the passed in
original id, it printed the original id, but it still fell through to
the 'cat', which failed with an error message.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-filter-branch.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 22fb5bf..5fa9b61 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -16,8 +16,12 @@
 map()
 {
 	# if it was not rewritten, take the original
-	test -r "$workdir/../map/$1" || echo "$1"
-	cat "$workdir/../map/$1"
+	if test -r "$workdir/../map/$1"
+	then
+		cat "$workdir/../map/$1"
+	else
+		echo "$1"
+	fi
 }
 
 # When piped a commit, output a script to set the ident of either
-- 
1.5.3.rc0.5.g7cd9
