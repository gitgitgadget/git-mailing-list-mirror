From: Jeff King <peff@peff.net>
Subject: [PATCH] Documentation: quote {non-attributes} for asciidoc
Date: Mon, 2 Jul 2007 01:24:59 -0400
Message-ID: <20070702052459.GA2365@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 07:25:22 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5EPZ-0006Bn-Ql
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 07:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbXGBFZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 01:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbXGBFZE
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 01:25:04 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1660 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbXGBFZB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 01:25:01 -0400
Received: (qmail 11151 invoked from network); 2 Jul 2007 05:25:21 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 2 Jul 2007 05:25:21 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2007 01:24:59 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51345>

Asciidoc treats {foo} as an attribute to be substituted; if
'foo' doesn't exist as an attribute, then the entire line
gets dropped. When the literal {foo} is desired, \{foo} is
required.

The exceptions to this rule are:
  - inside literal blocks
  - if the 'foo' contains non-alphanumeric characters (e.g.,
    {foo|bar} is assumed not to be an attribute)

Signed-off-by: Jeff King <peff@peff.net>
---
I noticed this because one of the dropped lines was causing asciidoc to
generate invalid XML for the git-stash man page. However, you can see it
in action in other pages here:

  http://www.kernel.org/pub/software/scm/git/docs/git-branch.html

Check out the '-l' option.

I think this gets all of them (except for the release notes, which
aren't built). Unfortunately, asciidoc seems to have no mode where it
tells me which lines it has dropped.

I don't know how much we can rely on the "if it doesn't look like an
attribute name, print it literally" behavior. It certainly is the case
with asciidoc 8.2.1, but I didn't try other versions.

Finally, this would all be much simpler if asciidoc treated non-existant
attributes as literal strings. I assume the line-dropping is to allow
them to work as a primitive conditional.

 Documentation/git-branch.txt       |    2 +-
 Documentation/git-checkout.txt     |    2 +-
 Documentation/git-receive-pack.txt |   10 +++++-----
 Documentation/git-rev-list.txt     |    4 ++--
 Documentation/git-stash.txt        |    8 ++++----
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 8d72bb9..9713f90 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -56,7 +56,7 @@ OPTIONS
 -l::
 	Create the branch's ref log.  This activates recording of
 	all changes to made the branch ref, enabling use of date
-	based sha1 expressions such as "<branchname>@{yesterday}".
+	based sha1 expressions such as "<branchname>@\{yesterday}".
 
 -f::
 	Force the creation of a new branch even if it means deleting
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ea26da8..a6571d2 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -64,7 +64,7 @@ OPTIONS
 -l::
 	Create the new branch's ref log.  This activates recording of
 	all changes to made the branch ref, enabling use of date
-	based sha1 expressions such as "<branchname>@{yesterday}".
+	based sha1 expressions such as "<branchname>@\{yesterday}".
 
 -m::
 	If you have local modifications to one or more files that
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 6914aa5..4ef1840 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -48,8 +48,8 @@ standard input of the hook will be one line per ref to be updated:
 The refname value is relative to $GIT_DIR; e.g. for the master
 head this is "refs/heads/master".  The two sha1 values before
 each refname are the object names for the refname before and after
-the update.  Refs to be created will have sha1-old equal to 0{40},
-while refs to be deleted will have sha1-new equal to 0{40}, otherwise
+the update.  Refs to be created will have sha1-old equal to 0\{40},
+while refs to be deleted will have sha1-new equal to 0\{40}, otherwise
 sha1-old and sha1-new should be valid objects in the repository.
 
 This hook is called before any refname is updated and before any
@@ -71,7 +71,7 @@ The refname parameter is relative to $GIT_DIR; e.g. for the master
 head this is "refs/heads/master".  The two sha1 arguments are
 the object names for the refname before and after the update.
 Note that the hook is called before the refname is updated,
-so either sha1-old is 0{40} (meaning there is no such ref yet),
+so either sha1-old is 0\{40} (meaning there is no such ref yet),
 or it should match what is recorded in refname.
 
 The hook should exit with non-zero status if it wants to disallow
@@ -96,8 +96,8 @@ The refname value is relative to $GIT_DIR; e.g. for the master
 head this is "refs/heads/master".  The two sha1 values before
 each refname are the object names for the refname before and after
 the update.  Refs that were created will have sha1-old equal to
-0{40}, while refs that were deleted will have sha1-new equal to
-0{40}, otherwise sha1-old and sha1-new should be valid objects in
+0\{40}, while refs that were deleted will have sha1-new equal to
+0\{40}, otherwise sha1-old and sha1-new should be valid objects in
 the repository.
 
 Using this hook, it is easy to generate mails describing the updates
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 32cb13f..20dcac6 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -284,9 +284,9 @@ excluded from the output.
 +
 With '\--pretty' format other than oneline (for obvious reasons),
 this causes the output to have two extra lines of information
-taken from the reflog.  By default, 'commit@{Nth}' notation is
+taken from the reflog.  By default, 'commit@\{Nth}' notation is
 used in the output.  When the starting commit is specified as
-'commit@{now}', output also uses 'commit@{timestamp}' notation
+'commit@{now}', output also uses 'commit@\{timestamp}' notation
 instead.  Under '\--pretty=oneline', the commit message is
 prefixed with this information on the same line.
 
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 4dc344d..b7d263d 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -26,8 +26,8 @@ list`.
 
 The latest stash you created is stored in `$GIT_DIR/refs/stash`; older
 stashes are found in the reflog of this reference and can be named using
-the usual reflog syntax (e.g. `stash@{1}` is the most recently
-created stash, `stash@{2}` is the one before it, `stash@{2.hours.ago}`
+the usual reflog syntax (e.g. `stash@\{1}` is the most recently
+created stash, `stash@\{2}` is the one before it, `stash@\{2.hours.ago}`
 is also possible).
 
 OPTIONS
@@ -41,7 +41,7 @@ save::
 list::
 
 	List the stashes that you currently have.  Each 'stash' is listed
-	with its name (e.g. `stash@{0}` is the latest stash, `stash@{1} is
+	with its name (e.g. `stash@\{0}` is the latest stash, `stash@\{1} is
 	the one before, etc.), the name of the branch that was current when the
 	stash was made, and a short description of the commit the stash was
 	based on.
@@ -57,7 +57,7 @@ show [<stash>]::
 	stashed state and its original parent. When no `<stash>` is given,
 	shows the latest one. By default, the command shows the diffstat, but
 	it will accept any format known to `git-diff` (e.g., `git-stash show
-	-p stash@{2}` to view the second most recent stash in patch form).
+	-p stash@\{2}` to view the second most recent stash in patch form).
 
 apply [<stash>]::
 
-- 
1.5.2.2.1452.g896f6
