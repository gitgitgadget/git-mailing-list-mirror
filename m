X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Chris Riddoch <chris@syntacticsugar.org>
Subject: [PATCH] Move --pretty options into Documentation/pretty-formats.txt
Date: Tue, 21 Nov 2006 16:49:15 -0700
Message-ID: <11641529553903-git-send-email-chris@syntacticsugar.org>
NNTP-Posting-Date: Tue, 21 Nov 2006 23:53:03 +0000 (UTC)
Cc: Chris Riddoch <chris@syntacticsugar.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32058>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmfPt-0002gB-3q for gcvg-git@gmane.org; Wed, 22 Nov
 2006 00:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031308AbWKUXwa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 18:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031362AbWKUXwa
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 18:52:30 -0500
Received: from hinegardner.org ([216.17.180.14]:65098 "EHLO
 planchet.hinegardner.org") by vger.kernel.org with ESMTP id S1031299AbWKUXw3
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 18:52:29 -0500
Received: from localhost.localdomain (localhost [127.0.0.1]) by
 planchet.hinegardner.org (Postfix) with ESMTP id 8E63E1599EE7; Tue, 21 Nov
 2006 16:53:07 -0700 (MST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Asciidoc-include it into the manuals for programs that use the
--pretty command-line option, for consistency among the docs.

This describes all the pretty-formats currently listed in the cmit_fmt
enum in commit.h, and also briefly describes the presence and format
of the 'Merge: ' line in some pretty formats.

There's a hedge that limiting your view of history can affect what
goes in the Merge: line, and that --abbrev/--no-abbrev do nothing to
the 'raw' format.

Signed-off-by: Chris Riddoch <chris@syntacticsugar.org>
---
 Documentation/git-diff-tree.txt  |    5 +--
 Documentation/git-log.txt        |    4 +-
 Documentation/git-rev-list.txt   |    6 +---
 Documentation/git-show.txt       |    5 +--
 Documentation/pretty-formats.txt |   60 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index f7e8ff2..5d6e9dc 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -73,10 +73,7 @@ separated with a single space are given.
 	This flag causes "git-diff-tree --stdin" to also show
 	the commit message before the differences.
 
---pretty[=(raw|medium|short)]::
-	This is used to control "pretty printing" format of the
-	commit message.  Without "=<style>", it defaults to
-	medium.
+include::pretty-formats.txt[]
 
 --no-commit-id::
 	git-diff-tree outputs a line with the commit ID when
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index c9ffff7..79643ac 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -24,8 +24,8 @@ This manual page describes only the most
 
 OPTIONS
 -------
---pretty=<format>::
-	Controls the way the commit log is formatted.
+
+include::pretty-formats.txt[]
 
 --max-count=<n>::
 	Limits the number of commits to show.
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 00a95e2..ec43c0b 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -79,11 +79,7 @@ Using these options, gitlink:git-rev-lis
 more specialized family of commit log tools: gitlink:git-log[1],
 gitlink:git-show[1], and gitlink:git-whatchanged[1]
 
---pretty[='<format>']::
-
-	Pretty print the contents of the commit logs in a given format,
-	where '<format>' can be one of 'raw', 'medium', 'short', 'full',
-	and 'oneline'. When left out the format default to 'medium'.
+include::pretty-formats.txt[]
 
 --relative-date::
 
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 2b4df3f..4c880a8 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -26,10 +26,7 @@ OPTIONS
 <commitid>::
 	ID of the commit to show.
 
---pretty=<format>::
-	Controls the output format for the commit logs.
-	<format> can be one of 'raw', 'medium', 'short', 'full',
-	and 'oneline'.
+include::pretty-formats.txt[]
 
 Author
 ------
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
new file mode 100644
index 0000000..4496c87
--- /dev/null
+++ b/Documentation/pretty-formats.txt
@@ -0,0 +1,60 @@
+--pretty[='<format>']::
+
+        Pretty-prints the details of a commit.  The default format is
+        'medium'.  If the commit is a merge, and if the pretty-format
+        is not 'oneline', 'email' or 'raw', an additional line is
+        inserted before the 'Author:' line.  This line begins with
+        "Merge: " and the sha1s of ancestral commits are printed,
+        separated by spaces.  Note that the listed commits may not
+        necessarily be the list of the *direct* parent commits if you
+        have limited your view of history: for example, if you are
+        only interested in changes related to a certain directory or
+        file.
+
+        * 'oneline'
+
+            <sha1> <title line>
+
+        * 'short'
+
+            commit <sha1>
+            Author: <author>
+            <title line>
+
+        * 'medium'
+
+            commit <sha1>
+            Author: <author>
+            Date: <date>
+            <full commit message>
+
+        * 'full'
+
+            commit <sha1>
+            Author: <author>
+            Commit: <committer>
+            <full commit message>
+
+        * 'fuller'
+
+           commit <sha1>
+           Author: <author>
+           AuthorDate: <date & time>
+           Commit: <committer>
+           CommitDate: <date & time>
+           <full commit message>
+
+        * 'email'
+
+           from <sha1> <date>
+           From: <author>
+           Date: <date & time>
+           Subject: [PATCH] <title line>
+
+          <full commit message>
+
+        * 'raw'
+
+           The entire commit exactly as stored in the commit object
+           The SHA1s are displayed in full, regardless of whether
+           --abbrev or --no-abbrev are used.
-- 
1.4.4
