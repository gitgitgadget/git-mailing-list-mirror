From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] Fix expr usage for FreeBSD
Date: Tue, 27 Jun 2006 18:54:26 +0200
Message-ID: <20060627165426.G3f0d11f5@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 27 18:54:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvGpp-0003VG-6v
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 18:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161205AbWF0Qyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 12:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWF0Qyd
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 12:54:33 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:32486 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1161205AbWF0Qya (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 12:54:30 -0400
Received: from leonov.stosberg.net (p213.54.84.32.tisdip.tiscali.de [213.54.84.32])
	by ncs.stosberg.net (Postfix) with ESMTP id 1338CAEBA065
	for <git@vger.kernel.org>; Tue, 27 Jun 2006 18:54:20 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 057CA111418; Tue, 27 Jun 2006 18:54:26 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1+sarge2) with LMTP; Tue, 27 Jun 2006 15:36:31 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22743>

Some implementations of "expr" (e.g. FreeBSD's) fail, if an
argument starts with a dash.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
 git-am.sh          |    2 +-
 git-clone.sh       |    2 +-
 git-commit.sh      |   18 +++++++++---------
 git-merge.sh       |    2 +-
 git-pull.sh        |    2 +-
 git-quiltimport.sh |    4 ++--
 git-rebase.sh      |    2 +-
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 4232e27..679045a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -97,7 +97,7 @@ while case "$#" in 0) break;; esac
 do
 	case "$1" in
 	-d=*|--d=*|--do=*|--dot=*|--dote=*|--dotes=*|--dotest=*)
-	dotest=`expr "$1" : '-[^=]*=\(.*\)'`; shift ;;
+	dotest=`expr "z$1" : 'z-[^=]*=\(.*\)'`; shift ;;
 	-d|--d|--do|--dot|--dote|--dotes|--dotest)
 	case "$#" in 1) usage ;; esac; shift
 	dotest="$1"; shift;;
diff --git a/git-clone.sh b/git-clone.sh
index 6fa0daa..6a14b25 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -133,7 +133,7 @@ while
 	*,--reference)
 		shift; reference="$1" ;;
 	*,--reference=*)
-		reference=`expr "$1" : '--reference=\(.*\)'` ;;
+		reference=`expr "z$1" : 'z--reference=\(.*\)'` ;;
 	*,-o|*,--or|*,--ori|*,--orig|*,--origi|*,--origin)
 		case "$2" in
 		'')
diff --git a/git-commit.sh b/git-commit.sh
index d7f3ade..7e50cf3 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -223,13 +223,13 @@ do
   -F*|-f*)
       no_edit=t
       log_given=t$log_given
-      logfile=`expr "$1" : '-[Ff]\(.*\)'`
+      logfile=`expr "z$1" : 'z-[Ff]\(.*\)'`
       shift
       ;;
   --F=*|--f=*|--fi=*|--fil=*|--file=*)
       no_edit=t
       log_given=t$log_given
-      logfile=`expr "$1" : '-[^=]*=\(.*\)'`
+      logfile=`expr "z$1" : 'z-[^=]*=\(.*\)'`
       shift
       ;;
   -a|--a|--al|--all)
@@ -237,7 +237,7 @@ do
       shift
       ;;
   --au=*|--aut=*|--auth=*|--autho=*|--author=*)
-      force_author=`expr "$1" : '-[^=]*=\(.*\)'`
+      force_author=`expr "z$1" : 'z-[^=]*=\(.*\)'`
       shift
       ;;
   --au|--aut|--auth|--autho|--author)
@@ -277,11 +277,11 @@ do
       log_given=m$log_given
       if test "$log_message" = ''
       then
-          log_message=`expr "$1" : '-m\(.*\)'`
+          log_message=`expr "z$1" : 'z-m\(.*\)'`
       else
           log_message="$log_message
 
-`expr "$1" : '-m\(.*\)'`"
+`expr "z$1" : 'z-m\(.*\)'`"
       fi
       no_edit=t
       shift
@@ -290,11 +290,11 @@ do
       log_given=m$log_given
       if test "$log_message" = ''
       then
-          log_message=`expr "$1" : '-[^=]*=\(.*\)'`
+          log_message=`expr "z$1" : 'z-[^=]*=\(.*\)'`
       else
           log_message="$log_message
 
-`expr "$1" : '-[^=]*=\(.*\)'`"
+`expr "z$1" : 'zq-[^=]*=\(.*\)'`"
       fi
       no_edit=t
       shift
@@ -321,7 +321,7 @@ do
   --reedit-me=*|--reedit-mes=*|--reedit-mess=*|--reedit-messa=*|\
   --reedit-messag=*|--reedit-message=*)
       log_given=t$log_given
-      use_commit=`expr "$1" : '-[^=]*=\(.*\)'`
+      use_commit=`expr "z$1" : 'z-[^=]*=\(.*\)'`
       no_edit=
       shift
       ;;
@@ -346,7 +346,7 @@ do
   --reuse-mes=*|--reuse-mess=*|--reuse-messa=*|--reuse-messag=*|\
   --reuse-message=*)
       log_given=t$log_given
-      use_commit=`expr "$1" : '-[^=]*=\(.*\)'`
+      use_commit=`expr "z$1" : 'z-[^=]*=\(.*\)'`
       no_edit=t
       shift
       ;;
diff --git a/git-merge.sh b/git-merge.sh
index fc25f8d..24e3b50 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -103,7 +103,7 @@ do
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
 		case "$#,$1" in
 		*,*=*)
-			strategy=`expr "$1" : '-[^=]*=\(.*\)'` ;;
+			strategy=`expr "z$1" : 'z-[^=]*=\(.*\)'` ;;
 		1,*)
 			usage ;;
 		*)
diff --git a/git-pull.sh b/git-pull.sh
index aa8c208..076785c 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -24,7 +24,7 @@ do
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
 		case "$#,$1" in
 		*,*=*)
-			strategy=`expr "$1" : '-[^=]*=\(.*\)'` ;;
+			strategy=`expr "z$1" : 'z-[^=]*=\(.*\)'` ;;
 		1,*)
 			usage ;;
 		*)
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 12d9d0c..86b51ab 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -9,7 +9,7 @@ while case "$#" in 0) break;; esac
 do
 	case "$1" in
 	--au=*|--aut=*|--auth=*|--autho=*|--author=*)
-		quilt_author=$(expr "$1" : '-[^=]*\(.*\)')
+		quilt_author=$(expr "z$1" : 'z-[^=]*\(.*\)')
 		shift
 		;;
 
@@ -26,7 +26,7 @@ do
 		;;
 
 	--pa=*|--pat=*|--patc=*|--patch=*|--patche=*|--patches=*)
-		QUILT_PATCHES=$(expr "$1" : '-[^=]*\(.*\)')
+		QUILT_PATCHES=$(expr "z$1" : 'z-[^=]*\(.*\)')
 		shift
 		;;
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 9ad1c44..0ac085e 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -179,7 +179,7 @@ do
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
 		case "$#,$1" in
 		*,*=*)
-			strategy=`expr "$1" : '-[^=]*=\(.*\)'` ;;
+			strategy=`expr "z$1" : 'z-[^=]*=\(.*\)'` ;;
 		1,*)
 			usage ;;
 		*)
-- 
1.4.1.rc1.ge6b53
