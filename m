From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH di/fast-import-deltified-tree] Windows: define S_ISUID properly
Date: Wed, 21 Sep 2011 08:33:28 +0200
Message-ID: <4E798538.7070106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 08:33:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6GNI-0004Gp-US
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 08:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab1IUGdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 02:33:36 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:63065 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751821Ab1IUGdf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 02:33:35 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R6GN7-0005Kl-4G; Wed, 21 Sep 2011 08:33:29 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D4A1D1660F;
	Wed, 21 Sep 2011 08:33:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.22) Gecko/20110902 Thunderbird/3.1.14
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181817>

From: Johannes Sixt <j6t@kdbg.org>

8fb3ad76 (fast-import: prevent producing bad delta) introduced the first
use of S_ISUID. Since before this commit the value was irrelevant, we had
only a dummy definition in mingw.h. But beginning with this commit the
macro must expand to a reasonable value. Make it so.

We do not change S_ISGID from the value 0 because it is used in path.c
(via FORCE_DIR_SET_GID) to set the mode on directories in a manner that
is not supported on Windows, and 0 is the right value in this case.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 547568b..e2c89d6 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -22,7 +22,7 @@ typedef int socklen_t;
 #define S_IWOTH 0
 #define S_IXOTH 0
 #define S_IRWXO (S_IROTH | S_IWOTH | S_IXOTH)
-#define S_ISUID 0
+#define S_ISUID 04000
 #define S_ISGID 0
 #define S_ISVTX 0

-- 
1.7.7.rc2.1135.gf321f
