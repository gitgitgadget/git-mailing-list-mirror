From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 20/21] git p4: avoid shell when calling git config
Date: Fri, 28 Sep 2012 08:04:24 -0400
Message-ID: <1348833865-6093-21-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:11:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZPc-0004Yu-5x
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757662Ab2I1MLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:11:11 -0400
Received: from honk.padd.com ([74.3.171.149]:58387 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595Ab2I1MLK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:11:10 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 26B075AF2;
	Fri, 28 Sep 2012 05:11:10 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C284A31413; Fri, 28 Sep 2012 08:11:07 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206578>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c0c738a..007ef6b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -514,13 +514,16 @@ def gitBranchExists(branch):
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
1.7.12.1.403.g28165e1
