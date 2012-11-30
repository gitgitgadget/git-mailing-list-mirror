From: Sebastian Leske <Sebastian.Leske@sleske.name>
Subject: [PATCH v3 2/4] git-svn: Recommend use of structure options.
Date: Fri, 30 Nov 2012 08:16:30 +0100
Message-ID: <c279ecd649a24b276a47e764664d57eff4032d91.1354693001.git.Sebastian.Leske@sleske.name>
References: <cover.1354693001.git.Sebastian.Leske@sleske.name>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 13:51:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgERc-0000Ur-5a
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 13:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab2LEMvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 07:51:03 -0500
Received: from serv28.loswebos.de ([213.187.93.221]:42937 "EHLO
	serv28.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab2LEMvC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 07:51:02 -0500
Received: from iota.localnet (unknown [46.115.102.110])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by serv28.loswebos.de (Postfix) with ESMTPSA id 4F9FE1F5459D;
	Wed,  5 Dec 2012 13:50:24 +0100 (CET)
Received: from sleske by iota.localnet with local (Exim 4.69)
	(envelope-from <sebastian.leske@sleske.name>)
	id 1Tg9Yo-0001AB-V8; Wed, 05 Dec 2012 08:38:26 +0100
In-Reply-To: <cover.1354693001.git.Sebastian.Leske@sleske.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211120>

Document that when using git svn, one should usually either use the
directory structure options to import branches as branches, or only
import one subdirectory. The default behaviour of cloning all branches
and tags as subdirectories in the working copy is usually not what the
user wants.

Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
---
 Documentation/git-svn.txt |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 55bed53..d8e5082 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -739,7 +739,8 @@ for rewriteRoot and rewriteUUID which can be used together.
 BASIC EXAMPLES
 --------------
 
-Tracking and contributing to the trunk of a Subversion-managed project:
+Tracking and contributing to the trunk of a Subversion-managed project
+(ignoring tags and branches):
 
 ------------------------------------------------------------------------
 # Clone a repo (like git clone):
@@ -764,8 +765,10 @@ Tracking and contributing to an entire Subversion-managed project
 (complete with a trunk, tags and branches):
 
 ------------------------------------------------------------------------
-# Clone a repo (like git clone):
-	git svn clone http://svn.example.com/project -T trunk -b branches -t tags
+# Clone a repo with standard SVN directory layout (like git clone):
+	git svn clone http://svn.example.com/project --stdlayout
+# Or, if the repo uses a non-standard directory layout:
+	git svn clone http://svn.example.com/project -T tr -b branch -t tag
 # View all branches and tags you have cloned:
 	git branch -r
 # Create a new branch in SVN
@@ -918,6 +921,21 @@ already dcommitted.  It is considered bad practice to --amend commits
 you've already pushed to a remote repository for other users, and
 dcommit with SVN is analogous to that.
 
+When cloning an SVN repository, if none of the options for describing
+the repository layout is used (--trunk, --tags, --branches,
+--stdlayout), 'git svn clone' will create a git repository with
+completely linear history, where branches and tags appear as separate
+directories in the working copy.  While this is the easiest way to get a
+copy of a complete repository, for projects with many branches it will
+lead to a working copy many times larger than just the trunk. Thus for
+projects using the standard directory structure (trunk/branches/tags),
+it is recommended to clone with option '--stdlayout'. If the project
+uses a non-standard structure, and/or if branches and tags are not
+required, it is easiest to only clone one directory (typically trunk),
+without giving any repository layout options.  If the full history with
+branches and tags is required, the options '--trunk' / '--branches' /
+'--tags' must be used.
+
 When using multiple --branches or --tags, 'git svn' does not automatically
 handle name collisions (for example, if two branches from different paths have
 the same name, or if a branch and a tag have the same name).  In these cases,
-- 
1.7.10.4
