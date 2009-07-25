From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 3/5] git-p4 stream: show relative path in debug messages
Date: Sat, 25 Jul 2009 10:24:34 -0400
Message-ID: <20090725142434.GD3841@arf.padd.com>
References: <1247301071-9541-1-git-send-email-luke@diamand.org> <20090725142329.GA3841@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 16:33:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUiJk-0007R3-TW
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 16:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbZGYOdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 10:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbZGYOdH
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 10:33:07 -0400
Received: from marge.padd.com ([99.188.165.110]:39108 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbZGYOdE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 10:33:04 -0400
Received: from arf.padd.com (pool-71-111-229-253.rlghnc.dsl-w.verizon.net [71.111.229.253])
	by marge.padd.com (Postfix) with ESMTPSA id 7B972121A7D4;
	Sat, 25 Jul 2009 07:24:37 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8323D3E40FE; Sat, 25 Jul 2009 10:24:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20090725142329.GA3841@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124015>

Not repo path, but the one where git will put the file.  They're
shorter and allows verifying branchPrefixes too.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3a52254..3ab016b 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -954,10 +954,9 @@ class P4Sync(Command):
     # - helper for streamP4Files
 
     def streamOneP4File(self, file, contents):
-        if verbose:
-            sys.stderr.write("%s\n" %  file["depotFile"])
-
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
+        if verbose:
+            sys.stderr.write("%s\n" % relPath)
 
         mode = "644"
         if isP4Exec(file["type"]):
@@ -994,11 +993,9 @@ class P4Sync(Command):
         self.gitStream.write("\n")
 
     def streamOneP4Deletion(self, file):
-        if verbose:
-            sys.stderr.write("delete %s\n" %  file["path"])
-
         relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
-
+        if verbose:
+            sys.stderr.write("delete %s\n" % relPath)
         self.gitStream.write("D %s\n" % relPath)
 
     # Stream directly from "p4 files" into "git fast-import"
-- 
1.6.2.5
