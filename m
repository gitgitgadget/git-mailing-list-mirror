From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation: How to ignore local changes in tracked files
Date: Fri, 18 Jul 2008 16:11:07 +0200
Message-ID: <20080718141038.28693.4887.stgit@localhost>
References: <20080717182619.GG10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 18 16:12:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJqgw-00067C-AD
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 16:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432AbYGROLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 10:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756097AbYGROLO
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 10:11:14 -0400
Received: from [212.249.11.140] ([212.249.11.140]:46611 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754790AbYGROLN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 10:11:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 709292ACC76;
	Fri, 18 Jul 2008 16:11:07 +0200 (CEST)
In-Reply-To: <20080717182619.GG10151@machine.or.cz>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89042>

This patch explains more carefully that `.gitignore` concerns only
untracked files and refers the reader to

	git update-index --assume-unchanged

in the need of ignoring uncommitted changes in already tracked files.
The description of this option is lifted to a more "porcelainish"
level and explains the caveats of this usecase.

Whether feasible or not, I believe adding this functionality to
the porcelain is out of the scope of this patch. (And I personally
think that referring to the plumbing in the case of such a special
usage is fine.)

This is currently probably one of the top FAQs at #git and the
--assume-unchanged switch is not widely known; gitignore(5) is the first
place where people are likely to look for it.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-update-index.txt |   10 ++++++++++
 Documentation/gitignore.txt        |   11 ++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index a91fd21..6b930bc 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -88,6 +88,16 @@ OPTIONS
 	sometimes helpful when working with a big project on a
 	filesystem that has very slow lstat(2) system call
 	(e.g. cifs).
++
+This option can be also used as a coarse file-level mechanism
+to ignore uncommitted changes in tracked files (akin to what
+`.gitignore` does for untracked files).
+You should remember that an explicit 'git add' operation will
+still cause the file to be refreshed from the working tree.
+Git will fail (gracefully) in case it needs to modify this file
+in the index e.g. when merging in a commit;
+thus, in case the assumed-untracked file is changed upstream,
+you will need to handle the situation manually.
 
 -g::
 --again::
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index fc0efd8..59321a2 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -13,9 +13,14 @@ DESCRIPTION
 -----------
 
 A `gitignore` file specifies intentionally untracked files that
-git should ignore.  Each line in a `gitignore` file specifies a
-pattern.
-
+git should ignore.
+Note that all the `gitignore` files really concern only files
+that are not already tracked by git;
+in order to ignore uncommitted changes in already tracked files,
+please refer to the 'git update-index --assume-unchanged'
+documentation.
+
+Each line in a `gitignore` file specifies a pattern.
 When deciding whether to ignore a path, git normally checks
 `gitignore` patterns from multiple sources, with the following
 order of precedence, from highest to lowest (within one level of
