From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation/git-submodule.txt: Further clarify the
	description
Date: Thu, 17 Jul 2008 14:29:20 +0200
Message-ID: <20080717122911.32334.73465.stgit@localhost>
References: <20080717121813.GC10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heikki Orsila <shdl@zakalwe.fi>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 17 14:31:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJScy-0007HP-N6
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 14:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242AbYGQM3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 08:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753889AbYGQM3c
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 08:29:32 -0400
Received: from [212.249.11.140] ([212.249.11.140]:48747 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751296AbYGQM3b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 08:29:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id A17512AC73C;
	Thu, 17 Jul 2008 14:29:20 +0200 (CEST)
In-Reply-To: <20080717121813.GC10151@machine.or.cz>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88840>

This patch rewrites the general description yet again, first clarifying
the high-level concept, mentioning the difference to remotes and using
the subtree merge strategy, then getting to the details about tree
entries and .gitmodules file.

The patch also makes few smallar grammar fixups of the rest of the
description and clarifies how does 'init' relate to 'update --init'.

Cc: Heikki Orsila <shdl@zakalwe.fi>
Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-submodule.txt |   39 +++++++++++++++++++++++++++------------
 1 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bb4e6fb..01d0d91 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -18,24 +18,35 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Submodules are a special kind of tree entries which refer to a particular tree
-state in another repository.  The tree entry describes
-the existence of a submodule with the given name and the exact revision that
-should be used, while an entry in `.gitmodules` file gives the location of
-the repository.
-
-When checked out, submodules will maintain their own independent repositories
-within their directories; the only link between the submodule and the "parent
-project" is the tree entry within the parent project mentioned above.
+Submodules allow foreign repositories to be embedded within a dedicated
+subdirectory of the source tree, always pointed at a particular commit.
+They are not to be confused with remotes, which are meant mainly for branches
+of the same project; submodules are meant for different projects you would like
+to make part of your source tree, while the history of the two projects still
+stays completely independent and you cannot modify the contents of the
+submodule from within the main project.  In case you want to merge the project
+histories, possibly make local modifications within the tree, but also do not
+mind that your repository will bulk up with all the contents of the other
+project, consider adding a remote for the other project and using the 'subtree'
+merge strategy instead of setting up a submodule.
+
+Submodules are composed from a special kind of tree entry (so-called `gitlink`)
+in the main repository that refers to a particular commit object within
+the (completely separate) inner repository, and a record in the `.gitmodules`
+file at the root of the source tree, assigning a logical name to the submodule
+and describing the default URL the submodule shall be cloned from. The logical
+name can be used for overriding this URL within your local repository
+configuration (see 'submodule init').
 
 This command will manage the tree entries and contents of the gitmodules file
-for you, as well as inspecting the status of your submodules and updating them.
+for you, as well as inspect the status of your submodules and update them.
 When adding a new submodule to the tree, the 'add' subcommand is to be used.
 However, when pulling a tree containing submodules, these will not be checked
 out by default; the 'init' and 'update' subcommands will maintain submodules
 checked out and at appropriate revision in your working tree. You can inspect
 the current status of your submodules using the 'submodule' subcommand and get
-an overview of changes 'update' would perform using the 'summary' subcommand.
+an overview of the changes 'update' would perform using the 'summary'
+subcommand.
 
 
 COMMANDS
@@ -81,7 +92,11 @@ init::
 	Initialize the submodules, i.e. register in .git/config each submodule
 	name and url found in .gitmodules. The key used in .git/config is
 	`submodule.$name.url`. This command does not alter existing information
-	in .git/config.
+	in .git/config. You can then customize the submodule clone URLs in
+	.git/config for your local setup and proceed to 'git submodule update';
+	you can also just use 'git submodule update --init' without
+	the explicit 'init' step if you do not intend to customize any
+	submodule URLs.
 
 update::
 	Update the registered submodules, i.e. clone missing submodules and
