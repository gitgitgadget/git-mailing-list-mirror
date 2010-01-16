From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] t7111: fix bad HEAD in tests with unmerged entries
Date: Sat, 16 Jan 2010 10:20:26 +0100
Message-ID: <20100116092027.4292.89080.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 10:18:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW4nO-0002vN-Fc
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 10:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab0APJSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 04:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358Ab0APJSJ
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 04:18:09 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:40927 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314Ab0APJSI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 04:18:08 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5D90281819C;
	Sat, 16 Jan 2010 10:17:54 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3033D818115;
	Sat, 16 Jan 2010 10:17:50 +0100 (CET)
X-git-sha1: 617de3fbc0ed9096788dba1edcfd053aa844468a 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137211>

When testing what happens on unmerged entries, the HEAD is the
commit we are starting from before the merge that fails and create
the unmerged entries. It is not the commit before.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7111-reset-table.sh |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t7111-reset-table.sh b/t/t7111-reset-table.sh
index 0a362a1..de896c9 100755
--- a/t/t7111-reset-table.sh
+++ b/t/t7111-reset-table.sh
@@ -73,13 +73,13 @@ test_expect_success 'setting up branches to test with unmerged entries' '
     git checkout branch1 &&
     test_commit B1 file1 &&
     git checkout branch2 &&
-    test_commit B2 file1
+    test_commit B file1
 '
 
 while read W1 I1 H1 T opt W2 I2 H2
 do
     test_expect_success "check: $W1 $I1 $H1 $T --$opt $W2 $I2 $H2" '
-	git reset --hard B2 &&
+	git reset --hard B &&
 	test_must_fail git merge branch1 &&
 	cat file1 >X_file1 &&
 	if test "$W2" != "XXXXX"
@@ -100,14 +100,14 @@ do
 	fi
     '
 done <<\EOF
-X U C D soft   XXXXX
-X U C D mixed  X D D
-X U C D hard   D D D
-X U C D merge  D D D
-X U C C soft   XXXXX
-X U C C mixed  X C C
-X U C C hard   C C C
-X U C C merge  C C C
+X U B C soft   XXXXX
+X U B C mixed  X C C
+X U B C hard   C C C
+X U B C merge  C C C
+X U B B soft   XXXXX
+X U B B mixed  X B B
+X U B B hard   B B B
+X U B B merge  B B B
 EOF
 
 test_done
-- 
1.6.6.271.gc8799
