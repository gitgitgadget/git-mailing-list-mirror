From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation/git-submodule.txt: Further clarify the
	description
Date: Fri, 18 Jul 2008 15:40:41 +0200
Message-ID: <20080718134008.26901.17348.stgit@localhost>
References: <20080718133644.GQ10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heikki Orsila <shdl@zakalwe.fi>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 18 15:41:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJqDW-0001gP-Qk
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 15:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458AbYGRNkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 09:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755554AbYGRNkt
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 09:40:49 -0400
Received: from [212.249.11.140] ([212.249.11.140]:39687 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754458AbYGRNks (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 09:40:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 30DC82ACC76;
	Fri, 18 Jul 2008 15:40:42 +0200 (CEST)
In-Reply-To: <20080718133644.GQ10151@machine.or.cz>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89041>

This patch rewrites the general description yet again, first clarifying
the high-level concept, mentioning the difference to remotes and using
the subtree merge strategy, then getting to the details about tree
entries and .gitmodules file.

The patch also makes few smallar grammar fixups within the rest of the
description and clarifies how does 'init' relate to 'update --init'.

Cc: Heikki Orsila <shdl@zakalwe.fi>
Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-submodule.txt |   68 ++++++++++++++++++++++++++-------------
 1 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bb4e6fb..755142c 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -18,24 +18,43 @@ SYNOPSIS
 
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
-
-This command will manage the tree entries and contents of the gitmodules file
-for you, as well as inspecting the status of your submodules and updating them.
-When adding a new submodule to the tree, the 'add' subcommand is to be used.
-However, when pulling a tree containing submodules, these will not be checked
-out by default; the 'init' and 'update' subcommands will maintain submodules
-checked out and at appropriate revision in your working tree. You can inspect
-the current status of your submodules using the 'submodule' subcommand and get
-an overview of changes 'update' would perform using the 'summary' subcommand.
+Submodules allow foreign repositories to be embedded within
+a dedicated subdirectory of the source tree, always pointed
+at a particular commit.
+
+They are not to be confused with remotes, which are meant mainly
+for branches of the same project; submodules are meant for
+different projects you would like to make part of your source tree,
+while the history of the two projects still stays completely
+independent and you cannot modify the contents of the submodule
+from within the main project.
+In case you want to merge the project histories, possibly make
+local modifications within the subtree, and considered the fact
+that all users will have to download and check out the subtree,
+you may choose to add a remote for the other project and use
+the 'subtree' merge strategy instead of setting up a submodule.
+
+Submodules are composed from a so-called `gitlink` tree entry
+in the main repository that refers to a particular commit object
+within the (completely separate) inner repository,
+and a record in the `.gitmodules` file at the root of the source
+tree, assigning a logical name to the submodule and describing
+the default URL the submodule shall be cloned from.
+The logical name can be used for overriding this URL within your
+local repository configuration (see 'submodule init').
+
+This command will manage the tree entries and contents of the
+gitmodules file for you, as well as inspect the status of your
+submodules and update them.
+When adding a new submodule to the tree, the 'add' subcommand
+is to be used.  However, when pulling a tree containing submodules,
+these will not be checked out by default;
+the 'init' and 'update' subcommands will maintain submodules
+checked out and at appropriate revision in your working tree.
+You can briefly inspect the up-to-date status of your submodules
+using the 'status' subcommand and get a detailed overview of the
+difference between the index and checkouts using the 'summary'
+subcommand.
 
 
 COMMANDS
@@ -78,10 +97,15 @@ status::
 	repository. This command is the default command for 'git-submodule'.
 
 init::
-	Initialize the submodules, i.e. register in .git/config each submodule
-	name and url found in .gitmodules. The key used in .git/config is
-	`submodule.$name.url`. This command does not alter existing information
-	in .git/config.
+	Initialize the submodules, i.e. register each submodule name
+	and url found in .gitmodules into .git/config.
+	The key used in .git/config is `submodule.$name.url`.
+	This command does not alter existing information in .git/config.
+	You can then customize the submodule clone URLs in .git/config
+	for your local setup and proceed to 'git submodule update';
+	you can also just use 'git submodule update --init' without
+	the explicit 'init' step if you do not intend to customize
+	any submodule locations.
 
 update::
 	Update the registered submodules, i.e. clone missing submodules and
