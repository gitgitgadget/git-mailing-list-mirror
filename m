From: John Chapman <thestar@fussycoder.id.au>
Subject: [PATCH 2/2] Cached the git configuration, which is now noticibly faster on windows.
Date: Sat,  8 Nov 2008 14:22:49 +1100
Message-ID: <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au>
References: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au>
Cc: John Chapman <thestar@fussycoder.id.au>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 06:07:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyg2t-00084B-UX
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 06:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbYKHFG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 00:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbYKHFG1
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 00:06:27 -0500
Received: from nskntqsrv01p.mx.bigpond.com ([61.9.168.231]:21031 "EHLO
	nskntqsrv01p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750760AbYKHFGZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2008 00:06:25 -0500
Received: from nskntotgx03p.mx.bigpond.com ([58.173.132.215])
          by nskntmtas03p.mx.bigpond.com with ESMTP
          id <20081108031224.ZTWC5533.nskntmtas03p.mx.bigpond.com@nskntotgx03p.mx.bigpond.com>;
          Sat, 8 Nov 2008 03:12:24 +0000
Received: from localhost.localdomain ([58.173.132.215])
          by nskntotgx03p.mx.bigpond.com with ESMTP
          id <20081108031224.BPNR12257.nskntotgx03p.mx.bigpond.com@localhost.localdomain>;
          Sat, 8 Nov 2008 03:12:24 +0000
X-Mailer: git-send-email 1.6.0.3.643.g233db
In-Reply-To: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au>
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150201.49150398.007A,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100377>


Signed-off-by: John Chapman <thestar@fussycoder.id.au>
---
 contrib/fast-import/git-p4 |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 38d1a17..9f0a5f9 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -316,8 +316,11 @@ def gitBranchExists(branch):
                             stderr=subprocess.PIPE, stdout=subprocess.PIPE);
     return proc.wait() == 0;
 
+_gitConfig = {}
 def gitConfig(key):
-    return read_pipe("git config %s" % key, ignore_error=True).strip()
+    if not _gitConfig.has_key(key):
+        _gitConfig[key] = read_pipe("git config %s" % key, ignore_error=True).strip()
+    return _gitConfig[key]
 
 def p4BranchesInGit(branchesAreInRemotes = True):
     branches = {}
-- 
1.6.0.3.643.g233db
