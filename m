From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Really honour NO_PYTHON
Date: Sun, 19 Feb 2006 21:13:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602192111490.20806@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Feb 19 21:14:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAuwL-0004hH-47
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 21:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWBSUNu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 15:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWBSUNu
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 15:13:50 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:15765 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750984AbWBSUNt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 15:13:49 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D808813F0E3; Sun, 19 Feb 2006 21:13:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id CA5006B4F;
	Sun, 19 Feb 2006 21:13:48 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A1293140994; Sun, 19 Feb 2006 21:13:48 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16449>


Do not even test for subprocess (trying to execute python).

Signed-off-by: Johannes E. Schindelin <Johannes.Schindelin@gmx.de>

---

	In my setup, gmake output would not say "/usr/bin/python: not found",
	but instead "08;"... :-)

 Makefile |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

9fe05fa9b21ed71ccfde30aa0d87ed031b923d40
diff --git a/Makefile b/Makefile
index 58291f3..a2cb70c 100644
--- a/Makefile
+++ b/Makefile
@@ -300,8 +300,10 @@ endif
 ifdef WITH_OWN_SUBPROCESS_PY
 	PYMODULES += compat/subprocess.py
 else
-	ifneq ($(shell $(PYTHON_PATH) -c 'import subprocess;print"OK"' 2>/dev/null),OK)
-		PYMODULES += compat/subprocess.py
+	ifeq ($(NO_PYTHON),)
+		ifneq ($(shell $(PYTHON_PATH) -c 'import subprocess;print"OK"' 2>/dev/null),OK)
+			PYMODULES += compat/subprocess.py
+		endif
 	endif
 endif
 
-- 
1.2.1.gb7c4-dirty
