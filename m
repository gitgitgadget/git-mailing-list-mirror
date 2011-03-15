From: Tor Arvid Lund <torarvid@gmail.com>
Subject: [PATCH 1/3] git-p4: Teach gitConfig method about arguments.
Date: Tue, 15 Mar 2011 13:08:01 +0100
Message-ID: <1300190883-31833-1-git-send-email-torarvid@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Tor Arvid Lund <torarvid@gmail.com>
To: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 14:08:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzTz5-000151-EK
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 14:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757726Ab1CONIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 09:08:19 -0400
Received: from thalia-smout.broadpark.no ([80.202.8.21]:46124 "EHLO
	thalia-smout.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757595Ab1CONIS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 09:08:18 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Mar 2011 09:08:18 EDT
Received: from terra-smin.broadpark.no ([80.202.8.13])
 by thalia-smout.broadpark.no
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0LI300CRXLPRSID0@thalia-smout.broadpark.no> for
 git@vger.kernel.org; Tue, 15 Mar 2011 13:08:15 +0100 (CET)
Received: from exchange.qsystems.no ([84.49.55.106]) by terra-smin.broadpark.no
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0LI30075FLPQLUK0@terra-smin.broadpark.no> for
 git@vger.kernel.org; Tue, 15 Mar 2011 13:08:15 +0100 (CET)
Received: from pingvin1 ([192.168.223.6]) by exchange.qsystems.no with
 Microsoft SMTPSVC(6.0.3790.4675); Tue, 15 Mar 2011 13:08:14 +0100
Received: by pingvin1 (Postfix, from userid 1000)	id AEB52240910; Tue,
 15 Mar 2011 13:08:14 +0100 (CET)
X-Mailer: git-send-email 1.7.3.1.68.g06779.dirty
X-OriginalArrivalTime: 15 Mar 2011 12:08:14.0812 (UTC)
 FILETIME=[A97FB1C0:01CBE309]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169068>

With this patch, it is possible to call the gitConfig method with an optional
argument string, which will be passed to the "git config" executable. For
instance:

gitConfig("core.ignorecase", "--bool")

will ensure that you get the value "true", and won't have to check the returned
value for [1, true, on, yes].

Signed-off-by: Tor Arvid Lund <torarvid@gmail.com>
---
 contrib/fast-import/git-p4 |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 7cb479c..4425220 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -333,9 +333,13 @@ def gitBranchExists(branch):
     return proc.wait() == 0;
 
 _gitConfig = {}
-def gitConfig(key):
+def gitConfig(key, args = None): # set args to "--bool", for instance
     if not _gitConfig.has_key(key):
-        _gitConfig[key] = read_pipe("git config %s" % key, ignore_error=True).strip()
+        argsFilter = ""
+        if args != None:
+            argsFilter = "%s " % args
+        cmd = "git config %s%s" % (argsFilter, key)
+        _gitConfig[key] = read_pipe(cmd, ignore_error=True).strip()
     return _gitConfig[key]
 
 def p4BranchesInGit(branchesAreInRemotes = True):
-- 
1.7.3.1.68.g06779.dirty
