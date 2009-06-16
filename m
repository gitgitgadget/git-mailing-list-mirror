From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 3/4] submodule, repack: migrate to git-sh-setup's say()
Date: Mon, 15 Jun 2009 19:05:04 -0700
Message-ID: <1245117905-19351-4-git-send-email-bebarino@gmail.com>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
 <1245117905-19351-2-git-send-email-bebarino@gmail.com>
 <1245117905-19351-3-git-send-email-bebarino@gmail.com>
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 04:05:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGO3O-0000LG-Ss
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 04:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbZFPCFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 22:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758219AbZFPCFX
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 22:05:23 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:45866 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbZFPCFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 22:05:16 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1651641wfd.4
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 19:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=jKT4bOKo7jEsht5fJnJWDTnup8zSOJerAd+FKP+DxZ8=;
        b=IZogflr+ILiVicTDSHT5MVwwK6UHZrEwDXqXY6/aGMHYX5v/axls1SsIyZ9r8emCog
         RJPpObkKMLNC6fhFy/PQ9VG5cJ6kGJTXO343EmZAvDQCEffyhx7NcWqUnXDzxEQtPmrU
         T73Id74eq59D34zrWCm63bO2v2dfFFNdBJ+nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uzZDAssOt6lahVPail+7B005JxrJfMFzC/IHi/df0DqUIcQc2anI2XrYNnV2hDT9Gu
         IZ2NWzyMz/OGrFquoD4pn+E5dNcqrljLQiCvP6zu9rFpXDNBJZCgr+m2qC00zVJOzSY8
         bT6QLUxazQdzD1/rbbb398BbvLuXlQDsxcz8Y=
Received: by 10.142.43.7 with SMTP id q7mr3672235wfq.123.1245117919186;
        Mon, 15 Jun 2009 19:05:19 -0700 (PDT)
Received: from earth (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id 29sm157945wfg.8.2009.06.15.19.05.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Jun 2009 19:05:18 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 15 Jun 2009 19:05:15 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
In-Reply-To: <1245117905-19351-3-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121648>

Now that there is say() in git-sh-setup, these scripts don't need to use
their own. Migrate them over by setting GIT_QUIET and removing their
custom say() functions.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 git-repack.sh    |   12 +++++-------
 git-submodule.sh |   24 ++++++------------------
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 0868734..efb527c 100755
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
+	-q)	GIT_QUIET=-q ;;
 	-f)	no_reuse=--no-reuse-object ;;
 	-l)	local=--local ;;
 	--max-pack-size|--window|--window-memory|--depth)
@@ -80,13 +80,11 @@ case ",$all_into_one," in
 	;;
 esac
 
-args="$args $local $quiet $no_reuse$extra"
+args="$args $local $GIT_QUIET $no_reuse$extra"
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
+	git prune-packed $GIT_QUIET
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
