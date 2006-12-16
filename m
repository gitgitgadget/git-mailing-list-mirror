X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Document git-merge-file
Date: Sat, 16 Dec 2006 12:22:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612161221071.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <7vejr0i2lw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 16 Dec 2006 11:22:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vejr0i2lw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34606>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvXcX-0001tx-41 for gcvg-git@gmane.org; Sat, 16 Dec
 2006 12:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030878AbWLPLWW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 06:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030882AbWLPLWW
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 06:22:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:34565 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1030878AbWLPLWV
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 06:22:21 -0500
Received: (qmail invoked by alias); 16 Dec 2006 11:22:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp049) with SMTP; 16 Dec 2006 12:22:19 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


Most of this is derived from the documentation of RCS merge.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Sat, 16 Dec 2006, Junio C Hamano wrote:

	> >>  - 'git-merge-file' needs to be documented and linked from
	> >>    git.txt.

 Documentation/git-merge-file.txt |   92 ++++++++++++++++++++++++++++++++++++++
 Documentation/git.txt            |    3 +
 2 files changed, 95 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
new file mode 100644
index 0000000..0b41d66
--- /dev/null
+++ b/Documentation/git-merge-file.txt
@@ -0,0 +1,92 @@
+git-merge-file(1)
+============
+
+NAME
+----
+git-merge-file - threeway file merge
+
+
+SYNOPSIS
+--------
+[verse]
+'git-merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
+	[-p|--stdout] [-q|--quiet] <current-file> <base-file> <other-file>
+
+
+DESCRIPTION
+-----------
+git-file-merge incorporates all changes that lead from the `<base-file>`
+to `<other-file>` into `<current-file>`. The result ordinarily goes into
+`<current-file>`. git-merge-file is useful for combining separate changes
+to an original. Suppose `<base-file>` is the original, and both
+`<current-file>` and `<other-file>` are modifications of `<base-file>`.
+Then git-merge-file combines both changes.
+
+A conflict occurs if both `<current-file>` and `<other-file>` have changes
+in a common segment of lines. If a conflict is found, git-merge-file
+normally outputs a warning and brackets the conflict with <<<<<<< and
+>>>>>>> lines. A typical conflict will look like this:
+
+	<<<<<<< A
+	lines in file A
+	=======
+	lines in file B
+	>>>>>>> B
+
+If there are conflicts, the user should edit the result and delete one of
+the alternatives.
+
+The exit value of this program is negative on error, and the number of
+conflicts otherwise. If the merge was clean, the exit value is 0.
+
+git-merge-file is designed to be a minimal clone of RCS merge, that is, it
+implements all of RCS merge's functionality which is needed by
+gitlink:git[1].
+
+
+OPTIONS
+-------
+
+-L <label>::
+	This option may be given up to three times, and
+	specifies labels to be used in place of the
+	corresponding file names in conflict reports. That is,
+	`git-merge-file -L x -L y -L z a b c` generates output that
+	looks like it came from files x, y and z instead of
+	from files a, b and c.
+
+-p::
+	Send results to standard output instead of overwriting
+	`<current-file>`.
+
+-q::
+	Quiet;  do  not  warn about conflicts.
+
+
+EXAMPLES
+--------
+
+git merge-file README.my README README.upstream::
+
+	combines the changes of README.my and README.upstream since README,
+	tries to merge them and writes the result into README.my.
+
+git merge-file -L a -L b -L c tmp/a123 tmp/b234 tmp/c345::
+
+	merges tmp/a123 and tmp/c345 with the base tmp/b234, but uses labels
+	`a` and `c` instead of `tmp/a123` and `tmp/c345`.
+
+
+Author
+------
+Written by Johannes Schindelin <johannes.schindelin@gmx.de>
+
+
+Documentation
+--------------
+Documentation by Johannes Schindelin and the git-list <git@vger.kernel.org>,
+with parts copied from the original documentation of RCS merge.
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Documentation/git.txt b/Documentation/git.txt
index b9b1e63..b9fc9ae 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -359,6 +359,9 @@ gitlink:git-init-db[1]::
 	Creates an empty git object database, or reinitialize an
 	existing one.
 
+gitlink:git-merge-file[1]::
+	Runs a threeway merge.
+
 gitlink:git-merge-index[1]::
 	Runs a merge for files needing merging.
 
-- 
1.4.4.2.g5dc03
