From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH v2 08/11] Use diff -u instead of diff in t7201
Date: Thu, 7 Feb 2008 11:40:11 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802071133380.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 17:42:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN9oj-0007U1-5v
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 17:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbYBGQkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 11:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755798AbYBGQkT
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 11:40:19 -0500
Received: from iabervon.org ([66.92.72.58]:39490 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755624AbYBGQkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 11:40:16 -0500
Received: (qmail 29803 invoked by uid 1000); 7 Feb 2008 16:40:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Feb 2008 16:40:11 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72972>

If the test failed, it was giving really unclear ed script
output. Instead, give a diff that sort of suggests the problem. Also 
replaces the use of "git diff" for this purpose with "diff -u".

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 t/t7201-co.sh |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index dbf1ace..42cf0ab 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -83,13 +83,13 @@ test_expect_success "checkout with unrelated dirty tree without -m" '
 	fill 0 1 2 3 4 5 6 7 8 >same &&
 	cp same kept
 	git checkout side >messages &&
-	git diff same kept
+	diff -u same kept
 	(cat > messages.expect <<EOF
 M	same
 EOF
 ) &&
 	touch messages.expect &&
-	git diff messages.expect messages
+	diff -u messages.expect messages
 '
 
 test_expect_success "checkout -m with dirty tree" '
@@ -113,19 +113,19 @@ Auto-merged one
 M	one
 EOF
 ) &&
-	git diff expect.messages messages &&
+	diff -u expect.messages messages &&
 
 	fill "M	one" "A	three" "D	two" >expect.master &&
 	git diff --name-status master >current.master &&
-	diff expect.master current.master &&
+	diff -u expect.master current.master &&
 
 	fill "M	one" >expect.side &&
 	git diff --name-status side >current.side &&
-	diff expect.side current.side &&
+	diff -u expect.side current.side &&
 
 	: >expect.index &&
 	git diff --cached >current.index &&
-	diff expect.index current.index
+	diff -u expect.index current.index
 '
 
 test_expect_success "checkout -m with dirty tree, renamed" '
@@ -143,7 +143,7 @@ test_expect_success "checkout -m with dirty tree, renamed" '
 
 	git checkout -m renamer &&
 	fill 1 3 4 5 7 8 >expect &&
-	diff expect uno &&
+	diff -u expect uno &&
 	! test -f one &&
 	git diff --cached >current &&
 	! test -s current
@@ -168,7 +168,7 @@ test_expect_success 'checkout -m with merge conflict' '
 	git diff master:one :3:uno |
 	sed -e "1,/^@@/d" -e "/^ /d" -e "s/^-/d/" -e "s/^+/a/" >current &&
 	fill d2 aT d7 aS >expect &&
-	diff current expect &&
+	diff -u current expect &&
 	git diff --cached two >current &&
 	! test -s current
 '
@@ -185,7 +185,7 @@ If you want to create a new branch from this checkout, you may do so
 HEAD is now at 7329388... Initial A one, A two
 EOF
 ) &&
-	git diff messages.expect messages &&
+	diff -u messages.expect messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
 	test "z$H" = "z$M" &&
-- 
1.5.4
