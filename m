From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 1/2] add --template=<template_directory> option to git-clone
Date: Sat, 27 May 2006 12:25:38 +0200
Message-ID: <24462.1924161494$1148725552@news.gmane.org>
Reply-To: Matthias Lederhofer <matled@gmx.net>
Cc: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sat May 27 12:25:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjvzR-0006XK-49
	for gcvg-git@gmane.org; Sat, 27 May 2006 12:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWE0KZn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 06:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWE0KZn
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 06:25:43 -0400
Received: from moooo.ath.cx ([85.116.203.178]:20420 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751459AbWE0KZm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 06:25:42 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g40505
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20846>

---

a176a8eae1d0e8e87028c4185ad5500ce2845441
 Documentation/git-clone.txt |    8 ++++++--
 git-clone.sh                |    7 +++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

a176a8eae1d0e8e87028c4185ad5500ce2845441
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index b333f51..881b464 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -9,8 +9,8 @@ git-clone - Clones a repository
 SYNOPSIS
 --------
 [verse]
-'git-clone' [-l [-s]] [-q] [-n] [--bare] [-o <name>] [-u <upload-pack>]
-	  [--reference <repository>]
+'git-clone' [--template=<template_directory>] [-l [-s]] [-q] [-n] [--bare]
+	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
 	  <repository> [<directory>]
 
 DESCRIPTION
@@ -34,6 +34,10 @@ branch you are currently working on.  Re
 
 OPTIONS
 -------
+--template=<template_directory>::
+	Provide the directory from which templates will be used.
+	The default template directory is `/usr/share/git-core/templates`.
+
 --local::
 -l::
 	When the repository to clone from is on a local machine,
diff --git a/git-clone.sh b/git-clone.sh
index d96894d..1c7ae12 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -9,7 +9,7 @@ # See git-sh-setup why.
 unset CDPATH
 
 usage() {
-	echo >&2 "Usage: $0 [--use-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
+	echo >&2 "Usage: $0 [--template=<template_directory>] [--use-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
 	exit 1
 }
 
@@ -102,6 +102,7 @@ quiet=
 local=no
 use_local=no
 local_shared=no
+template=
 no_checkout=
 upload_pack=
 bare=
@@ -120,6 +121,8 @@ while
 	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local) use_local=yes ;;
         *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared) 
           local_shared=yes; use_local=yes ;;
+	*,--template=*)
+	  template="$1" ;;
 	*,-q|*,--quiet) quiet=-q ;;
 	*,--use-separate-remote)
 		use_separate_remote=t ;;
@@ -203,7 +206,7 @@ trap 'err=$?; cd ..; rm -r "$D"; exit $e
 case "$bare" in
 yes) GIT_DIR="$D" ;;
 *) GIT_DIR="$D/.git" ;;
-esac && export GIT_DIR && git-init-db || usage
+esac && export GIT_DIR && git-init-db "$template" || usage
 case "$bare" in
 yes)
 	GIT_DIR="$D" ;;
-- 
1.3.3.g40505
