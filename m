From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH 08/12]  If the user has configured various parameters, use them.
Date: Sun, 10 Aug 2008 19:26:31 +0100
Message-ID: <1218392795-4084-9-git-send-email-wildfire@progsoc.org>
References: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-2-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-3-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-4-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-5-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-6-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-7-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-8-git-send-email-wildfire@progsoc.org>
Cc: simon@lst.de, Anand Kumria <wildfire@progsoc.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 20:37:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSFnY-0003Yx-Hn
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 20:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbYHJSgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 14:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbYHJSgq
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 14:36:46 -0400
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:47879 "EHLO
	giskard.kumria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbYHJSgq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 14:36:46 -0400
Received: from caliban.kumria.com ([203.7.227.146] helo=eve.kumria.com)
	by giskard.kumria.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFmV-00022z-Dm; Mon, 11 Aug 2008 04:36:44 +1000
Received: from anand by eve.kumria.com with local (Exim 4.69)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFch-00015G-Pf; Sun, 10 Aug 2008 19:26:35 +0100
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1218392795-4084-8-git-send-email-wildfire@progsoc.org>
X-Spam-Score: -2.2
X-Spam-Score-Int: -21
X-Spam-Bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91862>

 Some repositories require authentication and access to certain
 hosts. Allow git-p4 to pull this information from the configuration

Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 contrib/fast-import/git-p4 |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2b6ea74..a927e50 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -24,7 +24,29 @@ def p4_build_cmd(cmd):
     location. It means that hooking into the environment, or other configuration
     can be done more easily.
     """
-    real_cmd = "%s %s" % ("p4", cmd)
+    real_cmd = "%s " % "p4"
+
+    user = gitConfig("git-p4.user")
+    if len(user) > 0:
+        real_cmd += "-u %s " % user
+
+    password = gitConfig("git-p4.password")
+    if len(password) > 0:
+        real_cmd += "-P %s " % password
+
+    port = gitConfig("git-p4.port")
+    if len(port) > 0:
+        real_cmd += "-p %s " % port
+
+    host = gitConfig("git-p4.host")
+    if len(host) > 0:
+        real_cmd += "-h %s " % host
+
+    client = gitConfig("git-p4.client")
+    if len(client) > 0:
+        real_cmd += "-c %s " % client
+
+    real_cmd += "%s" % (cmd)
     if verbose:
         print real_cmd
     return real_cmd
-- 
1.5.6.3
