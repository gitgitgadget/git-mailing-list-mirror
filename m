From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH take 2] git-tag: add flag to verify a tag
Date: Thu, 04 Jan 2007 00:17:49 +0100
Message-ID: <87tzz7zoma.fsf@gmail.com>
References: <877iw4tgff.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Jan 04 00:16:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2FLu-00036z-6m
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 00:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbXACXQz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 3 Jan 2007 18:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbXACXQz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 18:16:55 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:33646 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932165AbXACXQy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 18:16:54 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l03NGpl25480
	for <git@vger.kernel.org>; Thu, 4 Jan 2007 00:16:52 +0100
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <877iw4tgff.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Wed, 03 Jan
	2007 13:59:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35898>


This way "git tag -v $tag" is the UI for git-verify-tag.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Hi *,

 But maybe the -v flag should give a similar output as:

 $ git branch -v

 Then this flag could be -c for check?

 This version has a syntax fix (sorry) and a typo fix.

 Documentation/git-tag.txt |    7 ++++++-
 generate-cmdlist.sh       |    1 -
 git-tag.sh                |   11 ++++++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 48b82b8..5cf114d 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -9,7 +9,7 @@ git-tag - Create a tag object signed with GPG
 SYNOPSIS
 --------
 [verse]
-'git-tag' [-a | -s | -u <key-id>] [-f | -d] [-m <msg> | -F <file>]
+'git-tag' [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg> | -F <file>=
]
 	 <name> [<head>]
 'git-tag' -l [<pattern>]
=20
@@ -35,6 +35,8 @@ GnuPG key for signing.
=20
 `-d <tag>` deletes the tag.
=20
+`-v <tag>` verifies the gpg signature of the tag.
+
 `-l <pattern>` lists tags that match the given pattern (or all
 if no pattern is given).
=20
@@ -55,6 +57,9 @@ OPTIONS
 -d::
 	Delete an existing tag with the given name
=20
+-v::
+	Verify the gpg signature of the given tag
+
 -l <pattern>::
 	List tags that match the given pattern (or all if no pattern is given=
).
=20
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 06c42b0..1de14ea 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -37,7 +37,6 @@ show
 show-branch
 status
 tag
-verify-tag
 EOF
 while read cmd
 do
diff --git a/git-tag.sh b/git-tag.sh
index e1bfa82..c3e4e15 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2005 Linus Torvalds
=20
-USAGE=3D'-l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d] [-m <msg>]=
 <tagname> [<head>]'
+USAGE=3D'-l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <=
msg>] <tagname> [<head>]'
 SUBDIRECTORY_OK=3D'Yes'
 . git-sh-setup
=20
@@ -69,6 +69,14 @@ do
 		echo "Deleted tag $tag_name."
 	exit $?
 	;;
+    -v)
+	shift
+	tag_name=3D"$1"
+	tag=3D$(git-show-ref --verify --hash -- "refs/tags/$tag_name") ||
+		die "Seriously, what tag are you talking about?"
+	git-verify-tag -v "$tag"
+	exit $?
+	;;
     -*)
         usage
 	;;
--=20
1.5.0.rc0.g1eb3
