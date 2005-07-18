From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 1/6 RESEND] cogito: remove use of xargs -r, a non-portable GNU extension
Date: Sun, 17 Jul 2005 23:15:24 -0400
Message-ID: <20050718031519.20230.85196.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 05:16:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuM6e-0001Ie-FX
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 05:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVGRDP0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 23:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVGRDP0
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 23:15:26 -0400
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:58772 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261505AbVGRDPY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 23:15:24 -0400
Received: (qmail 46799 invoked from network); 18 Jul 2005 03:15:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=mb4BrU8g99INR6ubt6jDdEu1WDeA51oPtMUwrvIyTJ+hk/jfjSosNeoY8BFSrTJifnq7122XzGxV8aAD7cRQFVYBJX4i4x2etI5xqcy216KNrrjqtUcIJA5DGqNPDi5fIEWvFMaHChEjGoEb7zsT18PMKw1FIpk10Nd89EhsLHE=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp109.mail.sc5.yahoo.com with SMTP; 18 Jul 2005 03:15:23 -0000
To: bryan.larsen@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Remove usage of xargs -r, a non-portable gnu extension.  

Resent with nasty bug fixed.

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
+	[ "`ls`" ] && find * \( -type f -o -type l \) -print0 | xargs -0 cg-add ${infoonly}
 	cg-commit -C -m"Initial commit" -E ${infoonly}
 fi
 
