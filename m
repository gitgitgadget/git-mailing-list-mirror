X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: EGIT unpackedreadr problem
Date: Sun, 3 Dec 2006 02:00:13 +0100
Message-ID: <200612030200.13857.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 00:58:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33072>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqfgB-0006lR-RF for gcvg-git@gmane.org; Sun, 03 Dec
 2006 01:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936604AbWLCA56 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 19:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936605AbWLCA56
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 19:57:58 -0500
Received: from [83.140.172.130] ([83.140.172.130]:46445 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S936604AbWLCA55 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 19:57:57 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id D026F80281C; Sun,  3 Dec 2006 01:54:09 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 08533-06; Sun,  3 Dec
 2006 01:54:09 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 29A838003E1; Sun,  3 Dec 2006 01:54:09 +0100 (CET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Subject: [PATCH] Utility to show a log.

This program shows commit information for a commit.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

The main reason for this patch is not the program itself. The new code to
read really fast but doesn't always work.

Try the supplied program. I get no parents and the treeid 
is wrong. An interesting thing is that if you look in the debugger the author 
and commit messag is actually correct. Only the tree id and parent are wrong. 
Not sure what's going on. The  UnpackedReader "looks" like it does
the equivalent of what it did before,but apparently it isn't. 

Reading commits from packs works fine. It's the unpacked reader that's bad.

-- robin
 
# java -Xmx100m -cp /home/me/SW/EGIT/org.spearce.jgit/bin org.spearce.jgit.pgm.Log c1ad80df56ff5f9d945eac8ac905b8009de30081
commit c1ad80df56ff5f9d945eac8ac905b8009de30081
tree 7ba4b782c23bb35b0cb7dbc46cfc09a6e887e19d
author PersonIdent[Shawn O. Pearce, spearce@spearce.org, Wed Nov 29 21:02:45 CET 2006]

Misc. code formatting cleanups.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

# git cat-file -p c1ad80df56ff5f9d945eac8ac905b8009de30081
tree a7ba4b7f1824763f182b6d45288e52fceece3c65b
parent 82c23bb35b0cb7dbc46cfc09a6e887e19dfb20f9
author Shawn O. Pearce <spearce@spearce.org> 1164830576 -0500
committer Shawn O. Pearce <spearce@spearce.org> 1164830576 -0500

Misc. code formatting cleanups.
[...]

 org.spearce.jgit/src/org/spearce/jgit/pgm/Log.java |   23 ++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/Log.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/Log.java
new file mode 100644
index 0000000..9598792
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/Log.java
@@ -0,0 +1,23 @@
+    package org.spearce.jgit.pgm;
+    
+    import java.io.File;
+    import java.io.IOException;
+import java.util.Iterator;
+
+import org.spearce.jgit.lib.Commit;
+import org.spearce.jgit.lib.Repository;
+    
+    public class Log {
+        public static void main(String[] args) throws IOException {
+            Repository db = new Repository(new File(".git"));	
+            Commit commit = db.mapCommit(args[0]);
+            System.out.println("commit "+commit.getCommitId());
+            System.out.println("tree "+commit.getTreeId());
+            for (Iterator ci=commit.getParentIds().iterator(); ci.hasNext(); ) {
+                System.out.println("parent "+ci.next());
+            }
+            System.out.println("author "+commit.getAuthor());
+            System.out.println();
+            System.out.println(commit.getMessage());
+        }
+    }
-- 
1.4.4.gf05d
