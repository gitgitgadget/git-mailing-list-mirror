From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 20/21] git p4: avoid shell when calling git config
Date: Sat, 26 Jan 2013 22:11:23 -0500
Message-ID: <1359256284-5660-21-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:18:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIlK-0007MZ-M2
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600Ab3A0DSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:18:09 -0500
Received: from honk.padd.com ([74.3.171.149]:44486 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755593Ab3A0DSI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:18:08 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id B89B52F3F;
	Sat, 26 Jan 2013 19:18:07 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 1A2C522838; Sat, 26 Jan 2013 22:18:05 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214671>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 7efa9a8..ff3e8c9 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -560,13 +560,16 @@ def gitBranchExists(branch):
     return proc.wait() == 0;
 
 _gitConfig = {}
-def gitConfig(key, args = None): # set args to "--bool", for instance
+
+def gitConfig(key, args=None): # set args to "--bool", for instance
     if not _gitConfig.has_key(key):
-        argsFilter = ""
-        if args != None:
-            argsFilter = "%s " % args
-        cmd = "git config %s%s" % (argsFilter, key)
-        _gitConfig[key] = read_pipe(cmd, ignore_error=True).strip()
+        cmd = [ "git", "config" ]
+        if args:
+            assert(args == "--bool")
+            cmd.append(args)
+        cmd.append(key)
+        s = read_pipe(cmd, ignore_error=True)
+        _gitConfig[key] = s.strip()
     return _gitConfig[key]
 
 def gitConfigList(key):
-- 
1.8.1.1.460.g6fa8886
