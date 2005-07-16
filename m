From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 1/5] cogito: remove use of xargs -r, a non-portable GNU extension
Date: Sat, 16 Jul 2005 19:23:25 -0400
Message-ID: <20050716232319.7317.23031.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050716232308.7317.56890.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 01:24:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtw18-0007X0-Q0
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 01:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVGPXYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 19:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVGPXX5
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 19:23:57 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:41841 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261889AbVGPXXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 19:23:25 -0400
Received: (qmail 68508 invoked from network); 16 Jul 2005 23:23:24 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=5gRspV1TQFasK5whb+4vC5jWRR95eqX8xZXRTKEZPc/u0zEpZ4JZTgVu1BENtcmTBTUrnPyNU5X5k0VNObdJaQbB5UHEDF8ENf5a6UhKsU6+N4NnSq+GMGiZbgL0nH/pXChBiwQgEAqe+hlmFt3OMvcMq+MTLPw4G/8hiAkm2Xo=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@65.93.75.85 with plain)
  by smtp011.mail.yahoo.com with SMTP; 16 Jul 2005 23:23:24 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050716232308.7317.56890.sendpatchset@bryan-larsens-ibook-g4.local>
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
 
