From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] UI consistency: allow --force for where -f means force
Date: Sat, 29 Aug 2009 11:05:00 +0200
Message-ID: <4A98EF3C.3010100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 29 11:05:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhJsK-0006Dj-I3
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 11:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbZH2JFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2009 05:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbZH2JFH
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 05:05:07 -0400
Received: from india601.server4you.de ([85.25.151.105]:55526 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbZH2JFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2009 05:05:03 -0400
Received: from [10.0.1.101] (p57B7EDE1.dip.t-dialin.net [87.183.237.225])
	by india601.server4you.de (Postfix) with ESMTPSA id 41CD72F80B2;
	Sat, 29 Aug 2009 11:05:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127379>

git branch, checkout, clean, mv and tag all have an option -f to override
certain checks.  This patch makes them accept the long option --force as
a synonym.

While we're at it, document that checkout support --quiet as synonym for
its short option -q.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/git-branch.txt   |    1 +
 Documentation/git-checkout.txt |    2 ++
 Documentation/git-clean.txt    |    1 +
 Documentation/git-mv.txt       |    1 +
 Documentation/git-tag.txt      |    1 +
 builtin-branch.c               |    2 +-
 builtin-checkout.c             |    2 +-
 builtin-clean.c                |    2 +-
 builtin-mv.c                   |    2 +-
 builtin-tag.c                  |    2 +-
 10 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 9998887..aad71dc 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -76,6 +76,7 @@ OPTIONS
 	based sha1 expressions such as "<branchname>@\{yesterday}".
 
 -f::
+--force::
 	Reset <branchname> to <startpoint> if <branchname> exists
 	already. Without `-f` 'git-branch' refuses to change an existing branch.
 
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ad4b31e..b1314b5 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -45,9 +45,11 @@ file can be discarded to recreate the original conflicted merge result.
 OPTIONS
 -------
 -q::
+--quiet::
 	Quiet, suppress feedback messages.
 
 -f::
+--force::
 	When switching branches, proceed even if the index or the
 	working tree differs from HEAD.  This is used to throw away
 	local changes.
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index ae8938b..9d291bd 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -32,6 +32,7 @@ OPTIONS
 	if you really want to remove such a directory.
 
 -f::
+--force::
 	If the git configuration specifies clean.requireForce as true,
 	'git-clean' will refuse to run unless given -f or -n.
 
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index 9c56602..bdcb585 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -28,6 +28,7 @@ committed.
 OPTIONS
 -------
 -f::
+--force::
 	Force renaming or moving of a file even if the target exists
 -k::
         Skip move or rename actions which would lead to an error
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 5113eae..299b04f 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -51,6 +51,7 @@ OPTIONS
 	Make a GPG-signed tag, using the given key
 
 -f::
+--force::
 	Replace an existing tag with the given name (instead of failing)
 
 -d::
diff --git a/builtin-branch.c b/builtin-branch.c
index 1a03d5f..9f57992 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -586,7 +586,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('m', NULL, &rename, "move/rename a branch and its reflog", 1),
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
 		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
-		OPT_BOOLEAN('f', NULL, &force_create, "force creation (when already exists)"),
+		OPT_BOOLEAN('f', "force", &force_create, "force creation (when already exists)"),
 		{
 			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
 			"commit", "print only not merged branches",
diff --git a/builtin-checkout.c b/builtin-checkout.c
index c6d6ac9..36e2116 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -584,7 +584,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			    2),
 		OPT_SET_INT('3', "theirs", &opts.writeout_stage, "stage",
 			    3),
-		OPT_BOOLEAN('f', NULL, &opts.force, "force"),
+		OPT_BOOLEAN('f', "force", &opts.force, "force"),
 		OPT_BOOLEAN('m', "merge", &opts.merge, "merge"),
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
diff --git a/builtin-clean.c b/builtin-clean.c
index 05c763c..28cdcd0 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -41,7 +41,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&quiet),
 		OPT__DRY_RUN(&show_only),
-		OPT_BOOLEAN('f', NULL, &force, "force"),
+		OPT_BOOLEAN('f', "force", &force, "force"),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				"remove whole directories"),
 		OPT_BOOLEAN('x', NULL, &ignored, "remove ignored files, too"),
diff --git a/builtin-mv.c b/builtin-mv.c
index b592c36..1b20028 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -53,7 +53,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
 	struct option builtin_mv_options[] = {
 		OPT__DRY_RUN(&show_only),
-		OPT_BOOLEAN('f', NULL, &force, "force move/rename even if target exists"),
+		OPT_BOOLEAN('f', "force", &force, "force move/rename even if target exists"),
 		OPT_BOOLEAN('k', NULL, &ignore_errors, "skip move/rename errors"),
 		OPT_END(),
 	};
diff --git a/builtin-tag.c b/builtin-tag.c
index a51a6d1..c479018 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -390,7 +390,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('s', NULL, &sign, "annotated and GPG-signed tag"),
 		OPT_STRING('u', NULL, &keyid, "key-id",
 					"use another key to sign the tag"),
-		OPT_BOOLEAN('f', NULL, &force, "replace the tag if exists"),
+		OPT_BOOLEAN('f', "force", &force, "replace the tag if exists"),
 
 		OPT_GROUP("Tag listing options"),
 		{
-- 
1.6.4.1
