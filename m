From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 1/2] cvsimport: update documentation to include separate remotes option
Date: Mon, 04 Jun 2007 10:01:34 +0100
Message-ID: <c0fbfa7f4c4105ab9ef61727688c46cd@pinky>
References: <4663D42A.7090201@shadowen.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 11:27:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv8q8-0000yh-GM
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 11:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbXFDJ0y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 05:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbXFDJ0y
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 05:26:54 -0400
Received: from 85-210-221-102.dsl.pipex.com ([85.210.221.102]:36121 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752478AbXFDJ0x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 05:26:53 -0400
X-Greylist: delayed 1534 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jun 2007 05:26:52 EDT
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by localhost.localdomain with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1Hv8RS-0005Fr-K3
	for git@vger.kernel.org; Mon, 04 Jun 2007 10:01:34 +0100
InReply-To: <4663D42A.7090201@shadowen.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49088>


Document the cvsimport -r <remote> option which switches cvsimport
to using a separate remote for tracking branches.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index e0be856..4e5f1c6 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	      [-A <author-conv-file>] [-p <options-for-cvsps>] [-P <file>]
 	      [-C <git_repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
 	      [-a] [-m] [-M <regex>] [-S <regex>] [-L <commitlimit>]
-	      [<CVS_module>]
+	      [-r <remote>] [<CVS_module>]
 
 
 DESCRIPTION
@@ -25,10 +25,12 @@ Splitting the CVS log into patch sets is done by 'cvsps'.
 At least version 2.1 is required.
 
 You should *never* do any work of your own on the branches that are
-created by git-cvsimport. The initial import will create and populate a
+created by git-cvsimport.  By default initial import will create and populate a
 "master" branch from the CVS repository's main branch which you're free
 to work with; after that, you need to 'git merge' incremental imports, or
-any CVS branches, yourself.
+any CVS branches, yourself.  It is advisable to specify a named remote via
+-r to separate and protect the incoming branches.
+
 
 OPTIONS
 -------
@@ -51,10 +53,19 @@ OPTIONS
         The git repository to import to.  If the directory doesn't
         exist, it will be created.  Default is the current directory.
 
+-r <remote>::
+	The git remote to import this CVS repository into.
+	Moves all CVS branches into remotes/<remote>/<branch>
+	akin to the git-clone --use-separate-remote option.
+
 -o <branch-for-HEAD>::
-	The 'HEAD' branch from CVS is imported to the 'origin' branch within
-	the git repository, as 'HEAD' already has a special meaning for git.
-	Use this option if you want to import into a different branch.
+	When no remote is specified (via -r) the 'HEAD' branch
+	from CVS is imported to the 'origin' branch within the git
+	repository, as 'HEAD' already has a special meaning for git.
+	When a remote is specified the 'HEAD' branch is named
+	remotes/<remote>/master mirroring git-clone behaviour.
+	Use this option if you want to import into a different
+	branch.
 +
 Use '-o master' for continuing an import that was initially done by
 the old cvs2git tool.
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index f16ac3d..7837c7b 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -40,7 +40,7 @@ Usage: ${\basename $0}     # fetch/update GIT from CVS
        [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
        [-p opts-for-cvsps] [-P file] [-C GIT_repository] [-z fuzz] [-i] [-k]
        [-u] [-s subst] [-a] [-m] [-M regex] [-S regex] [-L commitlimit]
-       [CVS_module]
+       [-r remote] [CVS_module]
 END
 	exit(1);
 }
