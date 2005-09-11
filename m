From: martin@catalyst.net.nz
Subject: [PATCH 1/5] archimport documentation update
Date: Sun, 11 Sep 2005 21:26:05 +1200
Message-ID: <11264307651299-git-send-email-martin@catalyst.net.nz>
References: <1126430765449-git-send-email-martin@catalyst.net.nz>
Reply-To: martin@catalyst.net.nz
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sun Sep 11 11:26:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEO6N-0005zt-G6
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 11:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVIKJ0Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 05:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbVIKJ0Q
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 05:26:16 -0400
Received: from 202-0-36-112.cable.paradise.net.nz ([202.0.36.112]:8659 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964828AbVIKJ0P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 05:26:15 -0400
Received: from aporo-debian (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with SMTP id 682808A72B;
	Sun, 11 Sep 2005 21:26:05 +1200 (NZST)
In-Reply-To: <1126430765449-git-send-email-martin@catalyst.net.nz>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8284>

Updated and expanded the command description, and added a reference of the
command line options.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 Documentation/git-archimport.txt |   63 +++++++++++++++++++++++++++++++-------
 1 files changed, 51 insertions(+), 12 deletions(-)

b3ee96f94c9ec4378d18a13074d1bbeebb0858b5
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -8,24 +8,63 @@ git-archimport - Import an arch reposito
 
 SYNOPSIS
 --------
-`git-archimport` [--option...] <args>
+`git-archimport` [ -h ] [ -v ] [ -T ] [ -t tempdir ] 
+                 <archive/branch> [ <archive/branch> ]
 
 DESCRIPTION
 -----------
-The script expects you to provide the key roots where it can start the
-import from an 'initial import' or 'tag' type of Arch commit. It will
-then follow all the branching and tagging within the provided roots.
-
-It will die if it sees branches that have different roots.
-
+Imports a project from one or more Arch repositories. It will follow branches
+and repositories within the namespaces defined by the <archive/branch>
+parameters suppplied. If it cannot find the remote branch a merge comes from
+it will just import it as a regular merge. If it can find it, it will perform
+a merge whenever possible. 
+
+The script expects you to provide the key roots where it can start the import 
+from an 'initial import' or 'tag' type of Arch commit. It will follow and import 
+new branches within the provided roots. 
+
+It expects to be dealing with one project only. If it sees 
+branches that have different roots, it will refuse to run. In that case, edit your
+<archive/branch> parameters to define clearly the scope of the import. 
+
+`git-archimport` uses `tla` extensively in the background to access the Arch repository.
+Make sure you have a recent version of `tla` available in the path. `tla` must
+know about the repositories you pass to `git-archimport`. 
+
+For the initial import `git-archimport` expects to find itself in an empty 
+directory. To follow the development of a project that uses Arch, rerun 
+`git-archimport` with the same parameters as the initial import to perform incremental imports.
+of a project using Arch.
+
+Patch merge data from Arch is used to mark merges in GIT as well. GIT 
+does not care much about tracking patches, and only considers a merge when a
+branch incorporates all the commits since the point they forked. The end result
+is that GIT will have a good idea of how far branches have diverged. So the 
+import process does lose some patch-trading metadata.
+
+Fortunately, when you try and merge branches imported from Arch, 
+GIT will find a good merge base, and it has a good chance of identifying 
+patches that have been traded out-of-sequence between the branches. 
 
 OPTIONS
 -------
---option::
-	Some option not yet documented.
 
-<args>...::
-	Some argument not yet documented.
+-h::
+	Display usage.
+
+-v::
+	Verbose output. 
+
+-T::
+	Many tags. Will create a tag for every commit, reflecting the commit 
+	name in the Arch repository.
+
+-t <tmpdir>::
+	Override the default tempdir.
+
+
+<archive/branch>::
+	Archive/branch identifier in a format that `tla log` understands. 
 
 
 Author
@@ -34,7 +73,7 @@ Written by Martin Langhoff <martin@catal
 
 Documentation
 --------------
-Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
+Documentation by Junio C Hamano, Martin Langhoff and the git-list <git@vger.kernel.org>.
 
 GIT
 ---
