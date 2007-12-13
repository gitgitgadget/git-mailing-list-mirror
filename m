From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] git-gui - Unconditionally use absolute paths with Cygwin
Date: Thu, 13 Dec 2007 09:02:26 -0500
Message-ID: <1197554546-2260-1-git-send-email-mdl123@verizon.net>
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Dec 13 15:03:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2oec-0007dj-Od
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 15:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbXLMOCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 09:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753744AbXLMOCr
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 09:02:47 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:64609 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729AbXLMOCq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 09:02:46 -0500
Received: from localhost.localdomain ([72.83.157.159])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JSZ006KDR04AL92@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 13 Dec 2007 08:02:29 -0600 (CST)
X-Mailer: git-send-email 1.5.3.7.1167.g12f9a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68155>

The mapping of Windows vs Cygwin/Posix paths is arbitrary and not knowable
from the Posix side, so logic to determine whether to use relative paths
to locate the git-gui library just does not work on Cygwin. Fix this to
unconditionally use absolute path on Cygwin. (This fixes a regression
from 1.5.4).

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 git-gui/Makefile |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index 26ac4b6..c109eab 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -117,14 +117,12 @@ GITGUI_SCRIPT   := $$0
 GITGUI_RELATIVE :=
 GITGUI_MACOSXAPP :=
 
-ifeq ($(exedir),$(gg_libdir))
-	GITGUI_RELATIVE := 1
-endif
-
 ifeq ($(uname_O),Cygwin)
 	GITGUI_SCRIPT := `cygpath --windows --absolute "$(GITGUI_SCRIPT)"`
-	ifeq ($(GITGUI_RELATIVE),)
-		gg_libdir := $(shell cygpath --windows --absolute "$(gg_libdir)")
+	gg_libdir := $(shell cygpath --windows --absolute "$(gg_libdir)")
+else
+	ifeq ($(exedir),$(gg_libdir))
+		GITGUI_RELATIVE := 1
 	endif
 endif
 ifeq ($(uname_S),Darwin)
-- 
1.5.3.7.1167.g12f9a
