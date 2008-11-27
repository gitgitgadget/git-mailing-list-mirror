From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: remove dashed command leftovers
Date: Thu, 27 Nov 2008 14:35:38 +0100
Message-ID: <1227792938-4006-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 27 14:37:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5h3E-0001Dc-Rz
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 14:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbYK0Nfn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Nov 2008 08:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbYK0Nfn
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 08:35:43 -0500
Received: from francis.fzi.de ([141.21.7.5]:54220 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752350AbYK0Nfm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 08:35:42 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 27 Nov 2008 14:35:37 +0100
X-Mailer: git-send-email 1.6.0.4.814.gfe502
X-OriginalArrivalTime: 27 Nov 2008 13:35:37.0998 (UTC) FILETIME=[0883E2E0:01C95095]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101809>

Commit 5a625b07 (bash: remove fetch, push, pull dashed form leftovers,
2008-10-03) did that already, but there were still some git-cmd left
here and there.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   41 ++++++------------------=
-------
 1 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 35e8ff7..0ee071b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -635,21 +635,12 @@ _git_branch ()
=20
 _git_bundle ()
 {
-	local mycword=3D"$COMP_CWORD"
-	case "${COMP_WORDS[0]}" in
-	git)
-		local cmd=3D"${COMP_WORDS[2]}"
-		mycword=3D"$((mycword-1))"
-		;;
-	git-bundle*)
-		local cmd=3D"${COMP_WORDS[1]}"
-		;;
-	esac
-	case "$mycword" in
-	1)
+	local cmd=3D"${COMP_WORDS[2]}"
+	case "$COMP_CWORD" in
+	2)
 		__gitcomp "create list-heads verify unbundle"
 		;;
-	2)
+	3)
 		# looking for a file
 		;;
 	*)
@@ -797,12 +788,7 @@ _git_fetch ()
 			__gitcomp "$(__git_refs)" "$pfx" "${cur#*:}"
 			;;
 		*)
-			local remote
-			case "${COMP_WORDS[0]}" in
-			git-fetch) remote=3D"${COMP_WORDS[1]}" ;;
-			git)       remote=3D"${COMP_WORDS[2]}" ;;
-			esac
-			__gitcomp "$(__git_refs2 "$remote")"
+			__gitcomp "$(__git_refs2 "${COMP_WORDS[2]}")"
 			;;
 		esac
 	fi
@@ -1049,12 +1035,7 @@ _git_pull ()
 	if [ "$COMP_CWORD" =3D 2 ]; then
 		__gitcomp "$(__git_remotes)"
 	else
-		local remote
-		case "${COMP_WORDS[0]}" in
-		git-pull)  remote=3D"${COMP_WORDS[1]}" ;;
-		git)       remote=3D"${COMP_WORDS[2]}" ;;
-		esac
-		__gitcomp "$(__git_refs "$remote")"
+		__gitcomp "$(__git_refs "${COMP_WORDS[2]}")"
 	fi
 }
=20
@@ -1067,19 +1048,13 @@ _git_push ()
 	else
 		case "$cur" in
 		*:*)
-			local remote
-			case "${COMP_WORDS[0]}" in
-			git-push)  remote=3D"${COMP_WORDS[1]}" ;;
-			git)       remote=3D"${COMP_WORDS[2]}" ;;
-			esac
-
 			local pfx=3D""
 			case "$COMP_WORDBREAKS" in
 			*:*) : great ;;
 			*)   pfx=3D"${cur%%:*}:" ;;
 			esac
=20
-			__gitcomp "$(__git_refs "$remote")" "$pfx" "${cur#*:}"
+			__gitcomp "$(__git_refs "${COMP_WORDS[2]}")" "$pfx" "${cur#*:}"
 			;;
 		+*)
 			__gitcomp "$(__git_refs)" + "${cur#+}"
@@ -1584,7 +1559,7 @@ _git_tag ()
 	-m|-F)
 		COMPREPLY=3D()
 		;;
-	-*|tag|git-tag)
+	-*|tag)
 		if [ $f =3D 1 ]; then
 			__gitcomp "$(__git_tags)"
 		else
--=20
1.6.0.4.814.gfe502
