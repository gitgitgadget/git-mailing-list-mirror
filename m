From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 1/6] cogito: remove use of xargs -r, a non-portable GNU extension
Date: Sun, 17 Jul 2005 22:50:42 -0400
Message-ID: <20050718025036.11198.93735.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050718025024.11198.10556.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 04:51:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuLiY-0008Dm-Kr
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 04:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVGRCuo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 22:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVGRCuo
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 22:50:44 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:9403 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261492AbVGRCum (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 22:50:42 -0400
Received: (qmail 53724 invoked from network); 18 Jul 2005 02:50:40 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=6F4PSy/64Lgg6W/jkpyjrBl8sw5MXPxK/mfkJgkSh3+eCUyApREakg/cSi8QGSCUFYMZEtathCCsUSXt/80XtmOjGIEjaQPGI0Ul0UKNrLQz+K+l6ddd5qs2Ojm516FrXsQj5O3NZNdtmppuh7AEFcip7x0+f7BvmvQbZgsheQk=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp107.mail.sc5.yahoo.com with SMTP; 18 Jul 2005 02:50:40 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050718025024.11198.10556.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Remove usage of xargs -r, a non-portable gnu extension.  

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 cg-add  |    6 +++---
 cg-init |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cg-add b/cg-add
--- a/cg-add
+++ b/cg-add
@@ -25,8 +25,6 @@ USAGE="cg-add [-N] FILE..."
 
 . ${COGITO_LIB}cg-Xlib
 
-[ "$1" ] || usage
-
 infoonly=
 while optparse; do
 	if optparse -N; then
@@ -36,6 +34,8 @@ while optparse; do
 	fi
 done
 
+[ "$ARGS" ] || usage
+
 TMPFILE=$(mktemp -t gitadd.XXXXXX) || exit 1
 find "${ARGS[@]}" -type f -print0 > $TMPFILE || {
 	die "not all files exist, nothing added"
@@ -43,6 +43,6 @@ find "${ARGS[@]}" -type f -print0 > $TMP
 }
 
 cat $TMPFILE | tr '\0' '\n' | sed 's/^/Adding file /'
-cat $TMPFILE | xargs -0r git-update-cache --add ${infoonly} --
+cat $TMPFILE | xargs -0 git-update-cache --add ${infoonly} --
 
 rm $TMPFILE
diff --git a/cg-init b/cg-init
--- a/cg-init
+++ b/cg-init
@@ -55,7 +55,7 @@ if [ "$uri" ]; then
 	echo "Cloned (origin $uri available as branch \"origin\")"
 else
 	git-read-tree # Seed the dircache
-	find * \( -type f -o -type l \) -print0 | xargs -0r cg-add ${infoonly}
+	[ `ls` ] && find * \( -type f -o -type l \) -print0 | xargs -0 cg-add ${infoonly}
 	cg-commit -C -m"Initial commit" -E ${infoonly}
 fi
 
