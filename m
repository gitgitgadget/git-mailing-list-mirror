From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 03/14] git p4: add comments to p4BranchesInGit
Date: Mon, 14 Jan 2013 19:46:57 -0500
Message-ID: <1358210828-2369-4-git-send-email-pw@padd.com>
References: <1358210828-2369-1-git-send-email-pw@padd.com>
Cc: Olivier Delalleau <shish@keba.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 01:48:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuuhc-0000se-Ke
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757021Ab3AOAsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:48:12 -0500
Received: from honk.padd.com ([74.3.171.149]:52463 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757008Ab3AOAsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:48:12 -0500
Received: from arf.padd.com (unknown [50.55.148.35])
	by honk.padd.com (Postfix) with ESMTPSA id DA4752F3F;
	Mon, 14 Jan 2013 16:48:11 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 1C61928EC2; Mon, 14 Jan 2013 19:48:09 -0500 (EST)
X-Mailer: git-send-email 1.8.1.427.gd1ed7ef
In-Reply-To: <1358210828-2369-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213554>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 68f7458..03680b0 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -553,27 +553,36 @@ def gitConfigList(key):
         _gitConfig[key] = read_pipe("git config --get-all %s" % key, ignore_error=True).strip().split(os.linesep)
     return _gitConfig[key]
 
-def p4BranchesInGit(branchesAreInRemotes = True):
+def p4BranchesInGit(branchesAreInRemotes=True):
+    """Find all the branches whose names start with "p4/", looking
+       in remotes or heads as specified by the argument.  Return
+       a dictionary of { branch: revision } for each one found.
+       The branch names are the short names, without any
+       "p4/" prefix."""
+
     branches = {}
 
     cmdline = "git rev-parse --symbolic "
     if branchesAreInRemotes:
-        cmdline += " --remotes"
+        cmdline += "--remotes"
     else:
-        cmdline += " --branches"
+        cmdline += "--branches"
 
     for line in read_pipe_lines(cmdline):
         line = line.strip()
 
-        ## only import to p4/
-        if not line.startswith('p4/') or line == "p4/HEAD":
+        # only import to p4/
+        if not line.startswith('p4/'):
+            continue
+        # special symbolic ref to p4/master
+        if line == "p4/HEAD":
             continue
-        branch = line
 
-        # strip off p4
-        branch = re.sub ("^p4/", "", line)
+        # strip off p4/ prefix
+        branch = line[len("p4/"):]
 
         branches[branch] = parseRevision(line)
+
     return branches
 
 def findUpstreamBranchPoint(head = "HEAD"):
-- 
1.8.1.350.gdbf6fd0
