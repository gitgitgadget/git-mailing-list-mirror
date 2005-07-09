From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 1/3] add -N option to cg-add (resent)
Date: Sat, 9 Jul 2005 06:40:22 -0400
Message-ID: <20050709104011.26763.37732.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 12:40:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrCl8-0005f6-JF
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 12:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVGIKkY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 06:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVGIKkY
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 06:40:24 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:52921 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261240AbVGIKkW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 06:40:22 -0400
Received: (qmail 23223 invoked from network); 9 Jul 2005 10:40:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=V6ELZ/mytkDE4V2lmQghtohMdCyaWlttg79i1ftKUBb9g0VB55GUZrxbt0BVlVNKaRVmjKzEeDh68hGg6VAKkaZZ8YPRLPWPCgrtX177F0VcoYSMIGoIubvdGqaH8wyhLzgoI21+ovwjK2L0L1gUjA6UBNjVDH3DeXLJWjbfdso=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp106.mail.sc5.yahoo.com with SMTP; 9 Jul 2005 10:40:17 -0000
To: bryan.larsen@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(resending cogito patches)

Add the -N option to cg-add.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 cg-add |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/cg-add b/cg-add
--- a/cg-add
+++ b/cg-add
@@ -13,20 +13,35 @@
 # is that 'Cogito' manages content and empty directories have no content.
 # Instead, directories are added automatically when adding files inside
 # them.
+#
+# OPTIONS
+# -------
+# -N::
+#   Only update the cache: do not copy the data into the object database.
+#
 
-USAGE="cg-add FILE..."
+USAGE="cg-add [-N] FILE..."
 
 . ${COGITO_LIB}cg-Xlib
 
 [ "$1" ] || usage
 
+infoonly=
+while optparse; do
+	if optparse -N; then
+		infoonly=--info-only
+	else
+		optfail
+	fi
+done
+
 TMPFILE=$(mktemp -t gitadd.XXXXXX) || exit 1
-find "$@" -type f -print0 > $TMPFILE || {
+find "${ARGS[@]}" -type f -print0 > $TMPFILE || {
 	die "not all files exist, nothing added"
 	rm $TMPFILE
 }
 
 cat $TMPFILE | tr '\0' '\n' | sed 's/^/Adding file /'
-cat $TMPFILE | xargs -0r git-update-cache --add --
+cat $TMPFILE | xargs -0r git-update-cache --add ${infoonly} --
 
 rm $TMPFILE



