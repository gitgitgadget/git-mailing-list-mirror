From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH 3/4] git-am: Add configuration am.keepcr and parameter --no-keep-cr to override configuration.
Date: Sat, 27 Feb 2010 15:20:27 +0100
Message-ID: <1267280428-18223-4-git-send-email-stefan.hahn@s-hahn.de>
References: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 15:21:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlNXx-0008PJ-QE
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 15:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968405Ab0B0OVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 09:21:15 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:50380 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968380Ab0B0OVM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 09:21:12 -0500
Received: from scotty.home (port-92-203-94-156.dynamic.qsc.de [92.203.94.156])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MbLW4-1O49NF0lV6-00JVa8; Sat, 27 Feb 2010 15:20:50 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1REKmvh019217;
	Sat, 27 Feb 2010 15:20:48 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1REKmQR019213;
	Sat, 27 Feb 2010 15:20:48 +0100
X-Mailer: git-send-email 1.7.0.98.g42448
In-Reply-To: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX1+X1fu5FhLade0+xIbd0lHMLJ5BzTQVvd6xLbk
 MPPQ9dFf17eZfbyeeCbX56EByi3BKNKOA5PHQLBx1ho17JlH+W
 3660OZiGjOB5gjruY8EwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141216>

This patch adds the configuration `am.keepcr` for git-am. It also adds
`--no-keep-cr` parameter for git-am to give the possibility to
override configuration from command line.

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
---
 Documentation/config.txt |    7 +++++++
 Documentation/git-am.txt |    6 ++++--
 git-am.sh                |   20 +++++++++++++++-----
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 664de6b..403c392 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -555,6 +555,13 @@ it will be treated as a shell command.  For example, defining
 executed from the top-level directory of a repository, which may
 not necessarily be the current directory.
 
+am.keepcr::
+	If true, git-am will call git-mailsplit for patches in mbox format 
+	with parameter '--keep-cr'. In this case git-mailsplit will
+	not remove `\r` from lines ending with `\r\n`. Can be overrriden
+	by giving '--no-keep-cr' from the command line.
+	See linkgit:git-am[1], linkgit:git-mailsplit[1].
+
 apply.ignorewhitespace::
 	When set to 'change', tells 'git apply' to ignore changes in
 	whitespace, in the same way as the '--ignore-space-change'
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index df3c6d6..aef2b86 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -9,7 +9,7 @@ git-am - Apply a series of patches from a mailbox
 SYNOPSIS
 --------
 [verse]
-'git am' [--signoff] [--keep] [--keep-cr] [--utf8 | --no-utf8]
+'git am' [--signoff] [--keep] [--keep-cr | --no-keep-cr] [--utf8 | --no-utf8]
 	 [--3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
@@ -40,9 +40,11 @@ OPTIONS
 	Pass `-k` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
 --keep-cr::
+--no-keep-cr::
 	With `--keep-cr`, call 'git mailsplit' (see linkgit:git-mailsplit[1])
 	with the same option, to prevent it from stripping CR at the end of 
-	lines.
+	lines. `am.keepcr` configuration variable can be used to specify the 
+	default behaviour.  `--no-keep-cr` is useful to override `am.keepcr`.
 
 -c::
 --scissors::
diff --git a/git-am.sh b/git-am.sh
index 7563609..ed42df0 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -16,6 +16,7 @@ s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
 keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
+no-keep-cr      do not pass --keep-cr flag to git-mailsplit independent of am.keepcr
 c,scissors      strip everything before a scissors line
 whitespace=     pass it through git-apply
 ignore-space-change pass it through git-apply
@@ -218,7 +219,7 @@ check_patch_format () {
 split_patches () {
 	case "$patch_format" in
 	mbox)
-		if test -n "$rebasing$keepcr"
+		if test -n "$rebasing" -o "$keepcr" = t
 		then
                     keep_cr=--keep-cr
 		else
@@ -299,6 +300,11 @@ committer_date_is_author_date=
 ignore_date=
 allow_rerere_autoupdate=
 
+if test "$(git config --bool --get am.keepcr)" = true
+then 
+    keepcr=t
+fi
+
 while test $# != 0
 do
 	case "$1" in
@@ -351,6 +357,8 @@ do
 		GIT_QUIET=t ;;
 	--keep-cr)
 		keepcr=t ;;
+	--no-keep-cr)
+		keepcr=f ;;
 	--)
 		shift; break ;;
 	*)
@@ -500,10 +508,12 @@ if test "$(cat "$dotest/keep")" = t
 then
 	keep=-k
 fi
-if test "$(cat "$dotest/keepcr")" = t
-then
-	keepcr=--keep-cr
-fi
+case "$(cat "$dotest/keepcr")" in
+t)
+	keepcr=--keep-cr ;;
+f)
+	keepcr=--no-keep-cr ;;
+esac
 case "$(cat "$dotest/scissors")" in
 t)
 	scissors=--scissors ;;
-- 
1.7.0.98.g42448
