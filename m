X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Update documentation to remove incorrect GIT_DIFF_OPTS
 example.
Date: Mon, 27 Nov 2006 14:37:43 -0500
Message-ID: <BAYC1-PASMTP10903FA2C4B5C1F99E1322AEE60@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 19:39:01 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061127143743.67c6a4e9.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Nov 2006 19:41:51.0390 (UTC) FILETIME=[15B62BE0:01C7125C]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GomIY-0001WE-FS for gcvg-git@gmane.org; Mon, 27 Nov
 2006 20:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758524AbWK0Thq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 14:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758537AbWK0Thq
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 14:37:46 -0500
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:42149 "EHLO
 BAYC1-PASMTP10.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1758524AbWK0Thp (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006
 14:37:45 -0500
Received: from linux1.attic.local ([65.93.43.74]) by
 BAYC1-PASMTP10.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Mon, 27 Nov 2006 11:41:51 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GolMM-000778-5y for git@vger.kernel.org; Mon, 27 Nov
 2006 13:37:42 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Git no longer calls an external diff program to generate patches.
Remove the documentation which suggests that you can pass
arbitrary diff options via the GIT_DIFF_OPTS environment variable.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
---
 Documentation/diff-format.txt |   57 ++++------------------------------------
 Documentation/git.txt         |   32 ++++++++++++++++++++---
 2 files changed, 34 insertions(+), 55 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index e4520e2..883c1bb 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -65,62 +65,17 @@ Generating patches with -p
 
 When "git-diff-index", "git-diff-tree", or "git-diff-files" are run
 with a '-p' option, they do not produce the output described above;
-instead they produce a patch file.
+instead they produce a patch file.  You can customize the creation
+of such patches via the GIT_EXTERNAL_DIFF and the GIT_DIFF_OPTS
+environment variables.
 
-The patch generation can be customized at two levels.
-
-1. When the environment variable 'GIT_EXTERNAL_DIFF' is not set,
-   these commands internally invoke "diff" like this:
-
-      diff -L a/<path> -L b/<path> -pu <old> <new>
-+
-For added files, `/dev/null` is used for <old>.  For removed
-files, `/dev/null` is used for <new>
-+
-The "diff" formatting options can be customized via the
-environment variable 'GIT_DIFF_OPTS'.  For example, if you
-prefer context diff:
-
-      GIT_DIFF_OPTS=-c git-diff-index -p HEAD
-
-
-2. When the environment variable 'GIT_EXTERNAL_DIFF' is set, the
-   program named by it is called, instead of the diff invocation
-   described above.
-+
-For a path that is added, removed, or modified,
-'GIT_EXTERNAL_DIFF' is called with 7 parameters:
-
-     path old-file old-hex old-mode new-file new-hex new-mode
-+
-where:
-
-     <old|new>-file:: are files GIT_EXTERNAL_DIFF can use to read the
-		      contents of <old|new>,
-     <old|new>-hex:: are the 40-hexdigit SHA1 hashes,
-     <old|new>-mode:: are the octal representation of the file modes.
-
-+ 
-The file parameters can point at the user's working file
-(e.g. `new-file` in "git-diff-files"), `/dev/null` (e.g. `old-file`
-when a new file is added), or a temporary file (e.g. `old-file` in the
-index).  'GIT_EXTERNAL_DIFF' should not worry about unlinking the
-temporary file --- it is removed when 'GIT_EXTERNAL_DIFF' exits.
-
-For a path that is unmerged, 'GIT_EXTERNAL_DIFF' is called with 1
-parameter, <path>.
-
-
-git specific extension to diff format
--------------------------------------
-
-What -p option produces is slightly different from the
-traditional diff format.
+What the -p option produces is slightly different from the traditional
+diff format.
 
 1.   It is preceded with a "git diff" header, that looks like
      this:
 
-     diff --git a/file1 b/file2
+       diff --git a/file1 b/file2
 +
 The `a/` and `b/` filenames are the same unless rename/copy is
 involved.  Especially, even for a creation or a deletion,
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 619d656..6382ef0 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -639,11 +639,35 @@ git Commits
 git Diffs
 ~~~~~~~~~
 'GIT_DIFF_OPTS'::
+	Only valid setting is "--unified=??" or "-u??" to set the
+	number of context lines shown when a unified diff is created.
+	This takes precedence over any "-U" or "--unified" option
+	value passed on the git diff command line.
+
 'GIT_EXTERNAL_DIFF'::
-	see the "generating patches" section in :
-	gitlink:git-diff-index[1];
-	gitlink:git-diff-files[1];
-	gitlink:git-diff-tree[1]
+	When the environment variable 'GIT_EXTERNAL_DIFF' is set, the
+	program named by it is called, instead of the diff invocation
+	described above.  For a path that is added, removed, or modified,
+        'GIT_EXTERNAL_DIFF' is called with 7 parameters:
+
+	path old-file old-hex old-mode new-file new-hex new-mode
++
+where:
+
+	<old|new>-file:: are files GIT_EXTERNAL_DIFF can use to read the
+                         contents of <old|new>,
+	<old|new>-hex:: are the 40-hexdigit SHA1 hashes,
+	<old|new>-mode:: are the octal representation of the file modes.
+
++
+The file parameters can point at the user's working file
+(e.g. `new-file` in "git-diff-files"), `/dev/null` (e.g. `old-file`
+when a new file is added), or a temporary file (e.g. `old-file` in the
+index).  'GIT_EXTERNAL_DIFF' should not worry about unlinking the
+temporary file --- it is removed when 'GIT_EXTERNAL_DIFF' exits.
++
+For a path that is unmerged, 'GIT_EXTERNAL_DIFF' is called with 1
+parameter, <path>.
 
 other
 ~~~~~
-- 
1.4.4.1
