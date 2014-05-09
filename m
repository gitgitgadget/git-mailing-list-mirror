From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 2/2] Remove 'git quiltimport'
Date: Thu,  8 May 2014 20:33:23 -0500
Message-ID: <1399599203-13991-3-git-send-email-felipe.contreras@gmail.com>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:44:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZrV-0006lm-KU
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbaEIBo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:44:26 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:46774 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbaEIBoY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:44:24 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so4043271obc.4
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wj+JHC6R5J82wOzi/qVBqAruqEo+97+77D6TWtQT6gw=;
        b=VBrVScVOIvs/moJH4yKAxkm2hjPzNtT4BgXdMZdR5v5hm6Pqu/kz90TAkyloSTIku8
         ovoD3laGkH31MOsUnMQZV0rFiFbWjenx747p5NMSwK2TdLlpM7qMNu/ujTkJvTr2T+td
         ob333QkSNPIpKwLgAMwoMZkmknKHwrcOtiWtl8t4rXpZI8i4Lkz4H1GgrLrO0jI6hN+V
         yFB+68shHKodlWhiKOpakeBYW/sJ2UAML3s5UzDqNdJ+larDbN4IQwnmiABn3LBm5fX3
         3Wn8JA1Dh0JiyAAelMofEBRWmocHx5hRK9p6NCudyu3HPRa60Z6oobpsgGW22v7/eU5v
         y8cg==
X-Received: by 10.60.76.233 with SMTP id n9mr911221oew.50.1399599863668;
        Thu, 08 May 2014 18:44:23 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id b7sm10868572oed.7.2014.05.08.18.44.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:44:22 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
In-Reply-To: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248493>

No updates since 2009 and no tests.

Foreign SCM tools should live out-of-tree anyway.

Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .gitignore                        |   1 -
 Documentation/git-quiltimport.txt |  54 ---------------
 Makefile                          |   1 -
 command-list.txt                  |   1 -
 git-quiltimport.sh                | 139 --------------------------------------
 5 files changed, 196 deletions(-)
 delete mode 100644 Documentation/git-quiltimport.txt
 delete mode 100755 git-quiltimport.sh

diff --git a/.gitignore b/.gitignore
index 5bce1df..8ce27f5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -108,7 +108,6 @@
 /git-prune-packed
 /git-pull
 /git-push
-/git-quiltimport
 /git-read-tree
 /git-rebase
 /git-rebase--am
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
deleted file mode 100644
index a356196..0000000
--- a/Documentation/git-quiltimport.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-git-quiltimport(1)
-================
-
-NAME
-----
-git-quiltimport - Applies a quilt patchset onto the current branch
-
-
-SYNOPSIS
---------
-[verse]
-'git quiltimport' [--dry-run | -n] [--author <author>] [--patches <dir>]
-
-
-DESCRIPTION
------------
-Applies a quilt patchset onto the current Git branch, preserving
-the patch boundaries, patch order, and patch descriptions present
-in the quilt patchset.
-
-For each patch the code attempts to extract the author from the
-patch description.  If that fails it falls back to the author
-specified with --author.  If the --author flag was not given
-the patch description is displayed and the user is asked to
-interactively enter the author of the patch.
-
-If a subject is not found in the patch description the patch name is
-preserved as the 1 line subject in the Git description.
-
-OPTIONS
--------
-
--n::
---dry-run::
-	Walk through the patches in the series and warn
-	if we cannot find all of the necessary information to commit
-	a patch.  At the time of this writing only missing author
-	information is warned about.
-
---author Author Name <Author Email>::
-	The author name and email address to use when no author
-	information can be found in the patch description.
-
---patches <dir>::
-	The directory to find the quilt patches and the
-	quilt series file.
-+
-The default for the patch directory is patches
-or the value of the $QUILT_PATCHES environment
-variable.
-
-GIT
----
-Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index eed6635..4493a98 100644
--- a/Makefile
+++ b/Makefile
@@ -455,7 +455,6 @@ SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-pull.sh
-SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
 SCRIPT_SH += git-request-pull.sh
diff --git a/command-list.txt b/command-list.txt
index c9a9766f..1ab44ce 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -90,7 +90,6 @@ git-prune                               ancillarymanipulators
 git-prune-packed                        plumbingmanipulators
 git-pull                                mainporcelain common
 git-push                                mainporcelain common
-git-quiltimport                         foreignscminterface
 git-read-tree                           plumbingmanipulators
 git-rebase                              mainporcelain common
 git-receive-pack                        synchelpers
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
deleted file mode 100755
index 167d79f..0000000
--- a/git-quiltimport.sh
+++ /dev/null
@@ -1,139 +0,0 @@
-#!/bin/sh
-OPTIONS_KEEPDASHDASH=
-OPTIONS_STUCKLONG=
-OPTIONS_SPEC="\
-git quiltimport [options]
---
-n,dry-run     dry run
-author=       author name and email address for patches without any
-patches=      path to the quilt series and patches
-"
-SUBDIRECTORY_ON=Yes
-. git-sh-setup
-
-dry_run=""
-quilt_author=""
-while test $# != 0
-do
-	case "$1" in
-	--author)
-		shift
-		quilt_author="$1"
-		;;
-	-n|--dry-run)
-		dry_run=1
-		;;
-	--patches)
-		shift
-		QUILT_PATCHES="$1"
-		;;
-	--)
-		shift
-		break;;
-	*)
-		usage
-		;;
-	esac
-	shift
-done
-
-# Quilt Author
-if [ -n "$quilt_author" ] ; then
-	quilt_author_name=$(expr "z$quilt_author" : 'z\(.*[^ ]\) *<.*') &&
-	quilt_author_email=$(expr "z$quilt_author" : '.*<\([^>]*\)') &&
-	test '' != "$quilt_author_name" &&
-	test '' != "$quilt_author_email" ||
-	die "malformed --author parameter"
-fi
-
-# Quilt patch directory
-: ${QUILT_PATCHES:=patches}
-if ! [ -d "$QUILT_PATCHES" ] ; then
-	echo "The \"$QUILT_PATCHES\" directory does not exist."
-	exit 1
-fi
-
-# Temporary directories
-tmp_dir="$GIT_DIR"/rebase-apply
-tmp_msg="$tmp_dir/msg"
-tmp_patch="$tmp_dir/patch"
-tmp_info="$tmp_dir/info"
-
-
-# Find the initial commit
-commit=$(git rev-parse HEAD)
-
-mkdir $tmp_dir || exit 2
-while read patch_name level garbage <&3
-do
-	case "$patch_name" in ''|'#'*) continue;; esac
-	case "$level" in
-	-p*)	;;
-	''|'#'*)
-		level=;;
-	*)
-		echo "unable to parse patch level, ignoring it."
-		level=;;
-	esac
-	case "$garbage" in
-	''|'#'*);;
-	*)
-		echo "trailing garbage found in series file: $garbage"
-		exit 1;;
-	esac
-	if ! [ -f "$QUILT_PATCHES/$patch_name" ] ; then
-		echo "$patch_name doesn't exist. Skipping."
-		continue
-	fi
-	echo $patch_name
-	git mailinfo "$tmp_msg" "$tmp_patch" \
-		<"$QUILT_PATCHES/$patch_name" >"$tmp_info" || exit 3
-	test -s "$tmp_patch" || {
-		echo "Patch is empty.  Was it split wrong?"
-		exit 1
-	}
-
-	# Parse the author information
-	GIT_AUTHOR_NAME=$(sed -ne 's/Author: //p' "$tmp_info")
-	GIT_AUTHOR_EMAIL=$(sed -ne 's/Email: //p' "$tmp_info")
-	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
-	while test -z "$GIT_AUTHOR_EMAIL" && test -z "$GIT_AUTHOR_NAME" ; do
-		if [ -n "$quilt_author" ] ; then
-			GIT_AUTHOR_NAME="$quilt_author_name";
-			GIT_AUTHOR_EMAIL="$quilt_author_email";
-		elif [ -n "$dry_run" ]; then
-			echo "No author found in $patch_name" >&2;
-			GIT_AUTHOR_NAME="dry-run-not-found";
-			GIT_AUTHOR_EMAIL="dry-run-not-found";
-		else
-			echo "No author found in $patch_name" >&2;
-			echo "---"
-			cat $tmp_msg
-			printf "Author: ";
-			read patch_author
-
-			echo "$patch_author"
-
-			patch_author_name=$(expr "z$patch_author" : 'z\(.*[^ ]\) *<.*') &&
-			patch_author_email=$(expr "z$patch_author" : '.*<\([^>]*\)') &&
-			test '' != "$patch_author_name" &&
-			test '' != "$patch_author_email" &&
-			GIT_AUTHOR_NAME="$patch_author_name" &&
-			GIT_AUTHOR_EMAIL="$patch_author_email"
-		fi
-	done
-	GIT_AUTHOR_DATE=$(sed -ne 's/Date: //p' "$tmp_info")
-	SUBJECT=$(sed -ne 's/Subject: //p' "$tmp_info")
-	export GIT_AUTHOR_DATE SUBJECT
-	if [ -z "$SUBJECT" ] ; then
-		SUBJECT=$(echo $patch_name | sed -e 's/.patch$//')
-	fi
-
-	if [ -z "$dry_run" ] ; then
-		git apply --index -C1 ${level:+"$level"} "$tmp_patch" &&
-		tree=$(git write-tree) &&
-		commit=$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tree $tree -p $commit) &&
-		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
-	fi
-done 3<"$QUILT_PATCHES/series"
-rm -rf $tmp_dir || exit 5
-- 
1.9.2+fc1.27.gbce2056
