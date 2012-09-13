From: Jeremy White <jwhite@codeweavers.com>
Subject: [PATCH v3] Documentation: describe subject more precisely
Date: Thu, 13 Sep 2012 17:27:09 -0500
Message-ID: <50525DBD.8040802@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 00:27:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCHsV-0008G5-H1
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 00:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758921Ab2IMW1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 18:27:11 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:49134 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938Ab2IMW1K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 18:27:10 -0400
Received: from jwhite.mn.codeweavers.com ([10.69.137.101] ident=jwhite)
	by mail.codeweavers.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <jwhite@codeweavers.com>)
	id 1TCHsL-0002Vz-RC
	for git@vger.kernel.org; Thu, 13 Sep 2012 17:27:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205438>

The discussion of email subject throughout the documentation is
misleading; it indicates that the first line will always become
the subject.  In fact, the subject is generally all lines up until
the first full blank line.

This patch refines that, and makes more use of the concept of a
commit title, with the title being all text up to the first blank line.

Signed-off-by: Jeremy White <jwhite@codeweavers.com>
---
 Documentation/git-commit.txt       |    6 ++++--
 Documentation/git-for-each-ref.txt |    7 ++++---
 Documentation/git-format-patch.txt |   11 +++++++----
 Documentation/git-shortlog.txt     |    3 +--
 Documentation/gitcore-tutorial.txt |    9 ++++-----
 Documentation/gittutorial.txt      |    8 +++++---
 Documentation/user-manual.txt      |    9 ++++++---
 7 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 4622297..9594ac8 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -389,8 +389,10 @@ DISCUSSION
 Though not required, it's a good idea to begin the commit message
 with a single short (less than 50 character) line summarizing the
 change, followed by a blank line and then a more thorough description.
-Tools that turn commits into email, for example, use the first line
-on the Subject: line and the rest of the commit in the body.
+The text up to the first blank line in a commit message is treated
+as the commit title, and that title is used throughout git.
+For example, linkgit:git-format-patch[1] turns a commit into email, and it uses
+the title on the Subject line and the rest of the commit in the body.
 
 include::i18n.txt[]
 
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index c872b88..db55a4e 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -102,9 +102,10 @@ Fields that have name-email-date tuple as its value (`author`,
 and `date` to extract the named component.
 
 The complete message in a commit and tag object is `contents`.
-Its first line is `contents:subject`, the remaining lines
-are `contents:body` and the optional GPG signature
-is `contents:signature`.
+Its first line is `contents:subject`, where subject is the concatenation
+of all lines of the commit message up to the first blank line.  The next
+line is 'contents:body', where body is all of the lines after the first
+blank line.  Finally, the optional GPG signature is `contents:signature`.
 
 For sorting purposes, fields with numeric values sort in numeric
 order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 04c7346..6d43f56 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -58,10 +58,13 @@ output, unless the `--stdout` option is specified.
 If `-o` is specified, output files are created in <dir>.  Otherwise
 they are created in the current working directory.
 
-By default, the subject of a single patch is "[PATCH] First Line" and
-the subject when multiple patches are output is "[PATCH n/m] First
-Line". To force 1/1 to be added for a single patch, use `-n`.  To omit
-patch numbers from the subject, use `-N`.
+By default, the subject of a single patch is "[PATCH] " followed by
+the concatenation of lines from the commit message up to the first blank
+line (see the DISCUSSION section of linkgit:git-commit[1]).
+
+When multiple patches are output, the subject prefix will instead be
+"[PATCH n/m] ".  To force 1/1 to be added for a single patch, use `-n`.
+To omit patch numbers from the subject, use `-N`.
 
 If given `--thread`, `git-format-patch` will generate `In-Reply-To` and
 `References` headers to make the second and subsequent patch mails appear
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 01d8417..afeb4cd 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -14,8 +14,7 @@ git log --pretty=short | 'git shortlog' [-h] [-n] [-s] [-e] [-w]
 DESCRIPTION
 -----------
 Summarizes 'git log' output in a format suitable for inclusion
-in release announcements. Each commit will be grouped by author and
-the first line of the commit message will be shown.
+in release announcements. Each commit will be grouped by author and title.
 
 Additionally, "[PATCH]" will be stripped from the commit description.
 
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 9d89336..5325c5a 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -956,12 +956,11 @@ $ git show-branch --topo-order --more=1 master mybranch
 ------------------------------------------------
 
 The first two lines indicate that it is showing the two branches
-and the first line of the commit log message from their
-top-of-the-tree commits, you are currently on `master` branch
-(notice the asterisk `*` character), and the first column for
-the later output lines is used to show commits contained in the
+with the titles of their top-of-the-tree commits, you are currently on
+`master` branch (notice the asterisk `*` character), and the first
+column for the later output lines is used to show commits contained in the
 `master` branch, and the second column for the `mybranch`
-branch. Three commits are shown along with their log messages.
+branch. Three commits are shown along with their titles.
 All of them have non blank characters in the first column (`*`
 shows an ordinary commit on the current branch, `-` is a merge commit), which
 means they are now part of the `master` branch. Only the "Some
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index dee0505..f1cb6f3 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -139,9 +139,11 @@ them to the index, and commit, all in one step.
 A note on commit messages: Though not required, it's a good idea to
 begin the commit message with a single short (less than 50 character)
 line summarizing the change, followed by a blank line and then a more
-thorough description.  Tools that turn commits into email, for
-example, use the first line on the Subject: line and the rest of the
-commit in the body.
+thorough description. The text up to the first blank line in a commit
+message is treated as the commit title, and that title is used
+throughout git.  For example, linkgit:git-format-patch[1] turns a
+commit into email, and it uses the title on the Subject line and the
+rest of the commit in the body.
 
 Git tracks content not files
 ----------------------------
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 03d95dc..4d29625 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1136,9 +1136,12 @@ Creating good commit messages
 Though not required, it's a good idea to begin the commit message
 with a single short (less than 50 character) line summarizing the
 change, followed by a blank line and then a more thorough
-description.  Tools that turn commits into email, for example, use
-the first line on the Subject line and the rest of the commit in the
-body.
+description.  The text up to the first blank line in a commit
+message is treated as the commit title, and that title is used
+throughout git.  For example, linkgit:git-format-patch[1] turns a
+commit into email, and it uses the title on the Subject line and the
+rest of the commit in the body.
+ 
 
 [[ignoring-files]]
 Ignoring files
-- 
1.7.10.4
