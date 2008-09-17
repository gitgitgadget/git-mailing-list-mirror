From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH/RFC 2/2] git-gui: Do not automatically stage file after merge tool finishes
Date: Wed, 17 Sep 2008 13:40:52 +0200
Message-ID: <1221651652-3712-3-git-send-email-johannes.sixt@telecom.at>
References: <200808310052.21595.angavrilov@gmail.com>
 <1221651652-3712-1-git-send-email-johannes.sixt@telecom.at>
 <1221651652-3712-2-git-send-email-johannes.sixt@telecom.at>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 13:42:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfvQC-0004PZ-1d
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 13:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbYIQLk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 07:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbYIQLk5
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 07:40:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21879 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbYIQLk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 07:40:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1KfvOw-0002we-38; Wed, 17 Sep 2008 13:40:54 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6CCAAFF51; Wed, 17 Sep 2008 13:40:53 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 1A338FA48; Wed, 17 Sep 2008 13:40:53 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.203.g117c
In-Reply-To: <1221651652-3712-2-git-send-email-johannes.sixt@telecom.at>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96096>

If a merge tool was invoked on a conflicted file and the tool completed,
then the conflicted file was staged automatically. However, the fact that
the user closed the merge tool cannot be understood as the unequivocal
sign that the conflict was completely resolved. For example, the user
could have decided to postpone the resolution of the conflict, or could
have accidentally closed the tool. We better leave the file unstaged and
let the user stage it explicitly.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 lib/mergetool.tcl |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/lib/mergetool.tcl b/lib/mergetool.tcl
index 965cfe4..1a96189 100644
--- a/lib/mergetool.tcl
+++ b/lib/mergetool.tcl
@@ -367,7 +367,5 @@ proc merge_tool_finish {fd} {
 		}
 
 		delete_temp_files $mtool_tmpfiles
-
-		merge_add_resolution $mtool_target
 	}
 }
-- 
1.6.0.1.1210.gb7ffe
