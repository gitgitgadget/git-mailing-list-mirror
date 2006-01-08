From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 6/7] Add an optional limit to git-formatpatch
Date: Sun, 8 Jan 2006 01:40:59 +0100
Message-ID: <20060108004059.GN1113@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 08 01:38:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvOZm-0007i4-Ee
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 01:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWAHAiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 19:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161105AbWAHAiX
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 19:38:23 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:55176 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161103AbWAHAiV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 19:38:21 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id E7E2E16F24
	for <git@vger.kernel.org>; Sun,  8 Jan 2006 01:38:20 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1EvOcG-0003TK-6r
	for git@vger.kernel.org; Sun, 08 Jan 2006 01:41:00 +0100
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14295>

We may not want to format all patches since the merge base.

Signed-off-by: Yann Dirson <ydirson@altern.org>


---

 git-format-patch.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

a0f52fc065de2bdca4f8e598d4a8a743d183d4d9
diff --git a/git-format-patch.sh b/git-format-patch.sh
index 0948f1f..6a0d331 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -30,6 +30,7 @@ diff_opts=
 LF='
 '
 
+limit=
 outdir=./
 while case "$#" in 0) break;; esac
 do
@@ -45,6 +46,11 @@ do
     -k|--k|--ke|--kee|--keep|--keep-|--keep-s|--keep-su|--keep-sub|\
     --keep-subj|--keep-subje|--keep-subjec|--keep-subject)
     keep_subject=t ;;
+    -l=|--l=|--li=|--lim=|--limi=|--limit=)
+    limit=`expr "$1" : '-[^=]*=\(.*\)'` ;;
+    -l|--l|--li|--lim|--limi|--limit)
+    case "$#" in 1) usage ;; esac; shift
+    limit="$1" ;;
     -n|--n|--nu|--num|--numb|--numbe|--number|--numbere|--numbered)
     numbered=t ;;
     -s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
@@ -136,7 +142,7 @@ do
 		die "Not a valid rev $rev1 ($revpair)"
 	git-rev-parse --verify "$rev2^0" >/dev/null 2>&1 ||
 		die "Not a valid rev $rev2 ($revpair)"
-	git-cherry -v "$rev1" "$rev2" |
+	git-cherry -v "$rev1" "$rev2" $limit |
 	while read sign rev comment
 	do
 		case "$sign" in
-- 
1.0.6-g8ecb

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
