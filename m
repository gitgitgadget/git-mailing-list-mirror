From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] pre-commit.sample: Diff against the empty tree when HEAD
 is invalid
Date: Thu, 5 Nov 2009 11:57:57 +0100
Message-ID: <20091105105757.GA31787@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 11:58:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N602j-0004mt-Tk
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 11:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938AbZKEK6F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 05:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbZKEK6F
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 05:58:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:35451 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753938AbZKEK6E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 05:58:04 -0500
Received: (qmail invoked by alias); 05 Nov 2009 10:58:07 -0000
Received: from i59F56796.versanet.de (EHLO atjola.homenet) [89.245.103.150]
  by mail.gmx.net (mp058) with SMTP; 05 Nov 2009 11:58:07 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/t9b956q3tLcF/1lELJIOUcRsOiyMCNvkIqFIUBf
	9/1uCEiFg4vXFK
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132224>

This was already the case for the old "diff --check" call, but the new
one that checks whether there are any non-ascii file names was missing
it, making that check fail for root commits.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
 templates/hooks--pre-commit.sample |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-=
commit.sample
index 043970a..439eefd 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -7,6 +7,14 @@
 #
 # To enable this hook, rename this file to "pre-commit".
=20
+if git-rev-parse --verify HEAD >/dev/null 2>&1
+then
+	against=3DHEAD
+else
+	# Initial commit: diff against an empty tree object
+	against=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904
+fi
+
 # If you want to allow non-ascii filenames set this variable to true.
 allownonascii=3D$(git config hooks.allownonascii)
=20
@@ -17,7 +25,7 @@ if [ "$allownonascii" !=3D "true" ] &&
 	# Note that the use of brackets around a tr range is ok here, (it's
 	# even required, for portability to Solaris 10's /usr/bin/tr), since
 	# the square bracket bytes happen to fall in the designated range.
-	test "$(git diff --cached --name-only --diff-filter=3DA -z |
+	test "$(git diff --cached --name-only --diff-filter=3DA -z $against |
 	  LC_ALL=3DC tr -d '[ -~]\0')"
 then
 	echo "Error: Attempt to add a non-ascii file name."
@@ -35,12 +43,4 @@ then
 	exit 1
 fi
=20
-if git-rev-parse --verify HEAD >/dev/null 2>&1
-then
-	against=3DHEAD
-else
-	# Initial commit: diff against an empty tree object
-	against=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904
-fi
-
 exec git diff-index --check --cached $against --
--=20
1.6.5.2.143.g8cc62
