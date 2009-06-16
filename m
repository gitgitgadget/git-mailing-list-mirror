From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv4 4/5] submodule, repack: migrate to git-sh-setup's say()
Date: Tue, 16 Jun 2009 15:33:00 -0700
Message-ID: <1245191581-11127-5-git-send-email-bebarino@gmail.com>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
 <1245191581-11127-1-git-send-email-bebarino@gmail.com>
 <1245191581-11127-2-git-send-email-bebarino@gmail.com>
 <1245191581-11127-3-git-send-email-bebarino@gmail.com>
 <1245191581-11127-4-git-send-email-bebarino@gmail.com>
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 00:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGhEP-0001yF-Q1
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 00:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862AbZFPWd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 18:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761307AbZFPWdP
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 18:33:15 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:28763 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760680AbZFPWdL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 18:33:11 -0400
Received: by wa-out-1112.google.com with SMTP id j5so969312wah.21
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 15:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=hGuTRsqd+g+1LH1AUV8XvttAzPr49jNTYUViJjhVCN8=;
        b=b630Khb4o3PEn2QzJZSKtaSBfV1Rhg7MyJ5d6eT+Ju1P+yb6HEa6zmjDZLDhPoaNTU
         Md46nOdklEoS1hNQ7k+qP1OuSdXcIBgYrigcAVE+UQFjiIiWWoN1SBiUrsfsBXunkVml
         5VctV6Jks1BnEykJFbJlItOKXuz2+lqIFV5cQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LatiycKsStVs6GWiOvCc0curDlSJL3jh0p/2v5yBJz+9MIBSrkxUwbStqoNBK3RYci
         aWl1I5z+pO6n2sAFV5k+GSlaEYr7nfx5DLgdOvUpwEThGXDtKDtWuhoHimUZ4m1BIZZ9
         Kt/XjMfg8jhb/ENe22cDYKK/tdR1OrfqWmFZ8=
Received: by 10.115.73.20 with SMTP id a20mr14282260wal.72.1245191594557;
        Tue, 16 Jun 2009 15:33:14 -0700 (PDT)
Received: from earth (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id m6sm9045978wag.49.2009.06.16.15.33.12
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Jun 2009 15:33:14 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 16 Jun 2009 15:33:12 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
In-Reply-To: <1245191581-11127-4-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121719>

Now that there is say() in git-sh-setup, these scripts don't need to use
their own. Migrate them over by setting GIT_QUIET and removing their
custom say() functions.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

This has the style fixups.

 git-repack.sh    |   12 +++++-------
 git-submodule.sh |   24 ++++++------------------
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 0868734..1bf2394 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -24,7 +24,7 @@ SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
 no_update_info= all_into_one= remove_redundant= unpack_unreachable=
-local= quiet= no_reuse= extra=
+local= no_reuse= extra=
 while test $# != 0
 do
 	case "$1" in
@@ -33,7 +33,7 @@ do
 	-A)	all_into_one=t
 		unpack_unreachable=--unpack-unreachable ;;
 	-d)	remove_redundant=t ;;
-	-q)	quiet=-q ;;
+	-q)	GIT_QUIET=t ;;
 	-f)	no_reuse=--no-reuse-object ;;
 	-l)	local=--local ;;
 	--max-pack-size|--window|--window-memory|--depth)
@@ -80,13 +80,11 @@ case ",$all_into_one," in
 	;;
 esac
 
-args="$args $local $quiet $no_reuse$extra"
+args="$args $local ${GIT_QUIET:+-q} $no_reuse$extra"
 names=$(git pack-objects --honor-pack-keep --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
 	exit 1
 if [ -z "$names" ]; then
-	if test -z "$quiet"; then
-		echo Nothing new to pack.
-	fi
+	say Nothing new to pack.
 fi
 
 # Ok we have prepared all new packfiles.
@@ -176,7 +174,7 @@ then
 		  done
 		)
 	fi
-	git prune-packed $quiet
+	git prune-packed ${GIT_QUIET:+-q}
 fi
 
 case "$no_update_info" in
diff --git a/git-submodule.sh b/git-submodule.sh
index 19a3a84..58d2fd2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -14,23 +14,11 @@ require_work_tree
 
 command=
 branch=
-quiet=
 reference=
 cached=
 nofetch=
 update=
 
-#
-# print stuff on stdout unless -q was specified
-#
-say()
-{
-	if test -z "$quiet"
-	then
-		echo "$@"
-	fi
-}
-
 # Resolve relative url by appending to parent's url
 resolve_relative_url ()
 {
@@ -137,7 +125,7 @@ cmd_add()
 			shift
 			;;
 		-q|--quiet)
-			quiet=1
+			GIT_QUIET=1
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
@@ -273,7 +261,7 @@ cmd_init()
 	do
 		case "$1" in
 		-q|--quiet)
-			quiet=1
+			GIT_QUIET=1
 			;;
 		--)
 			shift
@@ -333,7 +321,7 @@ cmd_update()
 		case "$1" in
 		-q|--quiet)
 			shift
-			quiet=1
+			GIT_QUIET=1
 			;;
 		-i|--init)
 			init=1
@@ -650,7 +638,7 @@ cmd_status()
 	do
 		case "$1" in
 		-q|--quiet)
-			quiet=1
+			GIT_QUIET=1
 			;;
 		--cached)
 			cached=1
@@ -704,7 +692,7 @@ cmd_sync()
 	do
 		case "$1" in
 		-q|--quiet)
-			quiet=1
+			GIT_QUIET=1
 			shift
 			;;
 		--)
@@ -759,7 +747,7 @@ do
 		command=$1
 		;;
 	-q|--quiet)
-		quiet=1
+		GIT_QUIET=1
 		;;
 	-b|--branch)
 		case "$2" in
-- 
1.6.3.2.306.g4f4fa
