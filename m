From: Michael Smith <msmith@cbnco.com>
Subject: [PATCH] user-manual: Explain what submodules are good for.
Date: Tue, 25 Sep 2007 08:44:38 -0400
Message-ID: <1190724278-8586-1-git-send-email-msmith@cbnco.com>
References: <Pine.LNX.4.64.0709250841410.6203@juice.ott.cti.com>
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Michael Smith <msmith@cbnco.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 14:44:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia9mS-0003zj-T0
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 14:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbXIYMom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 08:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbXIYMom
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 08:44:42 -0400
Received: from smtp107.rog.mail.re2.yahoo.com ([68.142.225.205]:45906 "HELO
	smtp107.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752473AbXIYMol (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Sep 2007 08:44:41 -0400
Received: (qmail 7495 invoked from network); 25 Sep 2007 12:44:39 -0000
Received: from unknown (HELO pentagram.it.hurts.ca) (mtsmith@rogers.com@74.122.211.221 with login)
  by smtp107.rog.mail.re2.yahoo.com with SMTP; 25 Sep 2007 12:44:39 -0000
X-YMail-OSG: 1jo6hRIVM1kSWYjArZ_4whfGmhf2DE88zbxitK0eGhds3a_r0ta9hWzmUrIRiMDSqg--
Received: from localhost.localdomain (thrush.it.hurts.ca [10.42.42.42])
	by pentagram.it.hurts.ca (Postfix) with ESMTP id 9C9241AE02D;
	Tue, 25 Sep 2007 08:44:38 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.2.102.ge6eb7
In-Reply-To: <Pine.LNX.4.64.0709250841410.6203@juice.ott.cti.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59117>

Rework the introduction to the Submodules section to explain why
someone would use them, and fix up submodule references from the
tree-object and todo sections.

Signed-off-by: Michael Smith <msmith@cbnco.com>
---
 Documentation/user-manual.txt |   54 +++++++++++++++++++++++++++++++---------
 1 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index a085ca1..c7fdf25 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2856,8 +2856,7 @@ between two related tree objects, since it can ignore any entries with
 identical object names.
 
 (Note: in the presence of submodules, trees may also have commits as
-entries.   See gitlink:git-submodule[1] and gitlink:gitmodules.txt[1]
-for partial documentation.)
+entries.  See <<submodules>> for documentation.)
 
 Note that the files all have mode 644 or 755: git actually only pays
 attention to the executable bit.
@@ -3163,12 +3162,45 @@ information as long as you have the name of the tree that it described.
 Submodules
 ==========
 
-This tutorial explains how to create and publish a repository with submodules
-using the gitlink:git-submodule[1] command.
-
-Submodules maintain their own identity; the submodule support just stores the
-submodule repository location and commit ID, so other developers who clone the
-superproject can easily clone all the submodules at the same revision.
+Large projects are often composed of smaller, self-contained modules.  For
+example, an embedded Linux distribution's source tree would include every
+piece of software in the distribution with some local modifications; a movie
+player might need to build against a specific, known-working version of a
+decompression library; several independent programs might all share the same
+build scripts.
+
+With centralized revision control systems this is often accomplished by
+including every module in one single repository.  Developers can check out
+all modules or only the modules they need to work with.  They can even modify
+files across several modules in a single commit while moving things around
+or updating APIs and translations.
+
+Git does not allow partial checkouts, so duplicating this approach in Git
+would force developers to keep a local copy of modules they are not
+interested in touching.  Commits in an enormous checkout would be slower
+than you'd expect as Git would have to scan every directory for changes.
+If modules have a lot of local history, clones would take forever.
+
+On the plus side, distributed revision control systems can much better
+integrate with external sources.  In a centralized model, a single arbitrary
+snapshot of the external project is exported from its own revision control
+and then imported into the local revision control on a vendor branch.  All
+the history is hidden.  With distributed revision control you can clone the
+entire external history and much more easily follow development and re-merge
+local changes.
+
+Git's submodule support allows a repository to contain, as a subdirectory, a
+checkout of an external project.  Submodules maintain their own identity;
+the submodule support just stores the submodule repository location and
+commit ID, so other developers who clone the containing project
+("superproject") can easily clone all the submodules at the same revision.
+Partial checkouts of the superproject are possible: you can tell Git to
+clone none, some or all of the submodules.
+
+The gitlink:git-submodule[1] command is available since Git 1.5.3.  Users
+with Git 1.5.2 can look up the submodule commits in the repository and
+manually check them out; earlier versions won't recognize the submodules at
+all.
 
 To see how submodule support works, create (for example) four example
 repositories that can be used later as a submodule:
@@ -3213,8 +3245,8 @@ The `git submodule add` command does a couple of things:
 
 - It clones the submodule under the current directory and by default checks out
   the master branch.
-- It adds the submodule's clone path to the `.gitmodules` file and adds this
-  file to the index, ready to be committed.
+- It adds the submodule's clone path to the gitlink:gitmodules[5] file and
+  adds this file to the index, ready to be committed.
 - It adds the submodule's current commit ID to the index, ready to be
   committed.
 
@@ -4277,5 +4309,3 @@ Write a chapter on using plumbing and writing scripts.
 Alternates, clone -reference, etc.
 
 git unpack-objects -r for recovery
-
-submodules
-- 
1.5.3
