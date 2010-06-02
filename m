From: Ian Molton <ian.molton@collabora.co.uk>
Subject: git-quiltimport
Date: Wed, 02 Jun 2010 16:07:37 +0100
Message-ID: <4C0673B9.20801@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050903090405050608090709"
Cc: ebiederm@lnxi.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 17:17:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJpgw-0005uq-TS
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 17:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602Ab0FBPQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 11:16:52 -0400
Received: from bhuna.collabora.co.uk ([93.93.128.226]:41617 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932567Ab0FBPQv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 11:16:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: ian)
	with ESMTPSA id EE177602668
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100515 Icedove/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148260>

This is a multi-part message in MIME format.
--------------050903090405050608090709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I've written a little patch to git-quiltimport that helps it with some stupid
 quilt repos.

Its still no use to me because it cant understand .bz2 compressed patches,
 but I thought this might help some folk out.

Hopefully t-bird wont mangle my patch...


--------------050903090405050608090709
Content-Type: text/x-patch;
 name="0001-Add-a-series-option-to-git-quiltimport.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Add-a-series-option-to-git-quiltimport.patch"

>From 475ce14394d75cadcc5c77ab1060a9a81bceaac4 Mon Sep 17 00:00:00 2001
From: Ian Molton <ian.molton@collabora.co.uk>
Date: Wed, 2 Jun 2010 15:59:25 +0100
Subject: [PATCH] Add a --series option to git-quiltimport

	This allows git-quiltimport to handle quilt patchsets with the
series fil in a nonstandard location.
---
 Documentation/git-quiltimport.txt |    7 +++++++
 git-quiltimport.sh                |   10 ++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index 579e8d2..da509e0 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git quiltimport' [--dry-run | -n] [--author <author>] [--patches <dir>]
+                  [--series <file>]
 
 
 DESCRIPTION
@@ -49,6 +50,12 @@ The default for the patch directory is patches
 or the value of the $QUILT_PATCHES environment
 variable.
 
+--series <file>::
+	The file to read the series information from.
++
+The default location for the series file is a
+file called series in the patch directory.
+
 Author
 ------
 Written by Eric Biederman <ebiederm@lnxi.com>
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 9a6ba2b..85f27b1 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -5,7 +5,8 @@ git quiltimport [options]
 --
 n,dry-run     dry run
 author=       author name and email address for patches without any
-patches=      path to the quilt series and patches
+patches=      path to the quilt patches
+series=       quilt series file (default to $QUILT_PATCHES/series)
 "
 SUBDIRECTORY_ON=Yes
 . git-sh-setup
@@ -26,6 +27,10 @@ do
 		shift
 		QUILT_PATCHES="$1"
 		;;
+        --series)
+		shift
+		QUILT_SERIES="$1"
+		;;
 	--)
 		shift
 		break;;
@@ -47,6 +52,7 @@ fi
 
 # Quilt patch directory
 : ${QUILT_PATCHES:=patches}
+: ${QUILT_SERIES:=$QUILT_PATCHES/series}
 if ! [ -d "$QUILT_PATCHES" ] ; then
 	echo "The \"$QUILT_PATCHES\" directory does not exist."
 	exit 1
@@ -134,5 +140,5 @@ do
 		commit=$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tree $tree -p $commit) &&
 		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
 	fi
-done 3<"$QUILT_PATCHES/series"
+done 3<"$QUILT_SERIES"
 rm -rf $tmp_dir || exit 5
-- 
1.7.1


--------------050903090405050608090709--
