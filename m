From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Remove case-sensitive file in t3030-merge-recursive.
Date: Thu, 19 Apr 2007 00:51:06 -0400
Message-ID: <20070419045106.GA17430@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 06:51:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeOcB-0005as-V0
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 06:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030827AbXDSEvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 00:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031064AbXDSEvN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 00:51:13 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:42685 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030827AbXDSEvM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 00:51:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id D5D771FFC022
	for <git@vger.kernel.org>; Thu, 19 Apr 2007 04:51:09 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44984>

Rename "A" to the unused "c"

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

I know, I know, OS X's default settings for the filesystem are broken.
But they are what they are.  And it's not really that hard to use
something other than "a" and "A"...

This patch allows it to pass everything except 15 and 16 on my system.
Those appear to be unrelated to the case issue.  But I don't know if
it's actual breakage in merge-recursive or a glitch with the test.

> * expecting success: 
> 
> 	rm -fr [abcd] &&
> 	git reset --hard &&
> 	git checkout -f "$c4" &&
> 
> 	git-merge-recursive "$c0" -- "$c4" "$c1"
> 	status=$?
> 	case "$status" in
> 	1)
> 		: happy
> 		;;
> 	*)
> 		echo >&2 "why status $status!!!"
> 		false
> 		;;
> 	esac
> 
> HEAD is now at b7f3e7f... master modifies a and d/e
> HEAD is now at 833bf24... df-2 makes a/c
> fatal: failed to unlink a in preparation to update: Operation not permitted
> Merging 833bf240c9e2636a0e5eb3dd8f735d2a92181f22 with b7f3e7f677ef7001dcb4b810583c9259a210141d
> Merging:
> 833bf24 df-2 makes a/c
> b7f3e7f master modifies a and d/e
> found 1 common ancestor(s):
> 88eeecf initial
> CONFLICT (delete/modify): a deleted in 833bf240c9e2636a0e5eb3dd8f735d2a92181f22 and modified in b7f3e7f677ef7001dcb4b810583c9259a210141d. Version b7f3e7f677ef7001dcb4b810583c9259a210141d of a left in tree.
> why status 128!!!
> * FAIL 15: merge-recursive d/f conflict the other way
> 
> * expecting success: 
> 
> 	git ls-files -s >actual &&
> 	(
> 		echo "100644 $o0 1	a"
> 		echo "100644 $o1 3	a"
> 		echo "100644 $o4 0	a/c"
> 		echo "100644 $o0 0	b"
> 		echo "100644 $o0 0	c"
> 		echo "100644 $o1 0	d/e"
> 	) >expected &&
> 	git diff -u expected actual
> 
> 
> diff --git a/expected b/actual
> index 6934f86..25439ca 100644
> --- a/expected
> +++ b/actual
> @@ -1,6 +1,4 @@
> -100644 ce013625030ba8dba906f756967f9e9ca394464a 1	a
> -100644 317e9677c3bcffd006f9fc84bbb0a54ef1676197 3	a
>  100644 72fb9054a42fd63d9c608b1a98a40614d7215bfb 0	a/c
>  100644 ce013625030ba8dba906f756967f9e9ca394464a 0	b
>  100644 ce013625030ba8dba906f756967f9e9ca394464a 0	c
> -100644 317e9677c3bcffd006f9fc84bbb0a54ef1676197 0	d/e
> +100644 ce013625030ba8dba906f756967f9e9ca394464a 0	d/e
> * FAIL 16: merge-recursive d/f conflict result the other way

 t/t3030-merge-recursive.sh |  104 ++++++++++++++++++++++----------------------
 1 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index aef92b9..86ee2b0 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -9,12 +9,12 @@ test_expect_success 'setup 1' '
 	echo hello >a &&
 	o0=$(git hash-object a) &&
 	cp a b &&
-	cp a A &&
+	cp a c &&
 	mkdir d &&
 	cp a d/e &&
 
 	test_tick &&
-	git add a b A d/e &&
+	git add a b c d/e &&
 	git commit -m initial &&
 	c0=$(git rev-parse --verify HEAD) &&
 	git branch side &&
@@ -34,13 +34,13 @@ test_expect_success 'setup 1' '
 	c1=$(git rev-parse --verify HEAD) &&
 	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	A"
 		echo "100644 blob $o1	a"
 		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
 		echo "100644 blob $o1	d/e"
-		echo "100644 $o0 0	A"
 		echo "100644 $o1 0	a"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	git diff -u expected actual
@@ -48,17 +48,17 @@ test_expect_success 'setup 1' '
 
 test_expect_success 'setup 2' '
 
-	rm -rf [Aabd] &&
+	rm -rf [abcd] &&
 	git checkout side &&
 	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	A"
 		echo "100644 blob $o0	a"
 		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
 		echo "100644 blob $o0	d/e"
-		echo "100644 $o0 0	A"
 		echo "100644 $o0 0	a"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	git diff -u expected actual &&
@@ -73,13 +73,13 @@ test_expect_success 'setup 2' '
 	c2=$(git rev-parse --verify HEAD) &&
 	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	A"
 		echo "100644 blob $o2	a"
 		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
 		echo "100644 blob $o0	d/e"
-		echo "100644 $o0 0	A"
 		echo "100644 $o2 0	a"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	git diff -u expected actual
@@ -87,17 +87,17 @@ test_expect_success 'setup 2' '
 
 test_expect_success 'setup 3' '
 
-	rm -rf [Aabd] &&
+	rm -rf [abcd] &&
 	git checkout df-1 &&
 	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	A"
 		echo "100644 blob $o0	a"
 		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
 		echo "100644 blob $o0	d/e"
-		echo "100644 $o0 0	A"
 		echo "100644 $o0 0	a"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	git diff -u expected actual &&
@@ -110,13 +110,13 @@ test_expect_success 'setup 3' '
 	c3=$(git rev-parse --verify HEAD) &&
 	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	A"
 		echo "100644 blob $o0	a"
 		echo "100644 blob $o3	b/c"
+		echo "100644 blob $o0	c"
 		echo "100644 blob $o0	d/e"
-		echo "100644 $o0 0	A"
 		echo "100644 $o0 0	a"
 		echo "100644 $o3 0	b/c"
+		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	git diff -u expected actual
@@ -124,17 +124,17 @@ test_expect_success 'setup 3' '
 
 test_expect_success 'setup 4' '
 
-	rm -rf [Aabd] &&
+	rm -rf [abcd] &&
 	git checkout df-2 &&
 	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	A"
 		echo "100644 blob $o0	a"
 		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
 		echo "100644 blob $o0	d/e"
-		echo "100644 $o0 0	A"
 		echo "100644 $o0 0	a"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	git diff -u expected actual &&
@@ -147,13 +147,13 @@ test_expect_success 'setup 4' '
 	c4=$(git rev-parse --verify HEAD) &&
 	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	A"
 		echo "100644 blob $o4	a/c"
 		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
 		echo "100644 blob $o0	d/e"
-		echo "100644 $o0 0	A"
 		echo "100644 $o4 0	a/c"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	git diff -u expected actual
@@ -161,17 +161,17 @@ test_expect_success 'setup 4' '
 
 test_expect_success 'setup 5' '
 
-	rm -rf [Aabd] &&
+	rm -rf [abcd] &&
 	git checkout remove &&
 	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	A"
 		echo "100644 blob $o0	a"
 		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
 		echo "100644 blob $o0	d/e"
-		echo "100644 $o0 0	A"
 		echo "100644 $o0 0	a"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	git diff -u expected actual &&
@@ -188,11 +188,11 @@ test_expect_success 'setup 5' '
 	c5=$(git rev-parse --verify HEAD) &&
 	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	A"
 		echo "100644 blob $o5	a"
+		echo "100644 blob $o0	c"
 		echo "100644 blob $o0	d/e"
-		echo "100644 $o0 0	A"
 		echo "100644 $o5 0	a"
+		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	git diff -u expected actual
@@ -201,17 +201,17 @@ test_expect_success 'setup 5' '
 
 test_expect_success 'setup 6' '
 
-	rm -rf [Aabd] &&
+	rm -rf [abcd] &&
 	git checkout df-3 &&
 	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	A"
 		echo "100644 blob $o0	a"
 		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
 		echo "100644 blob $o0	d/e"
-		echo "100644 $o0 0	A"
 		echo "100644 $o0 0	a"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
 	git diff -u expected actual &&
@@ -224,13 +224,13 @@ test_expect_success 'setup 6' '
 	c6=$(git rev-parse --verify HEAD) &&
 	( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
 	(
-		echo "100644 blob $o0	A"
 		echo "100644 blob $o0	a"
 		echo "100644 blob $o0	b"
+		echo "100644 blob $o0	c"
 		echo "100644 blob $o6	d"
-		echo "100644 $o0 0	A"
 		echo "100644 $o0 0	a"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o6 0	d"
 	) >expected &&
 	git diff -u expected actual
@@ -238,7 +238,7 @@ test_expect_success 'setup 6' '
 
 test_expect_success 'merge-recursive simple' '
 
-	rm -fr [Aabd] &&
+	rm -fr [abcd] &&
 	git checkout -f "$c2" &&
 
 	git-merge-recursive "$c0" -- "$c2" "$c1"
@@ -258,11 +258,11 @@ test_expect_success 'merge-recursive result' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 0	A"
 		echo "100644 $o0 1	a"
 		echo "100644 $o2 2	a"
 		echo "100644 $o1 3	a"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	git diff -u expected actual
@@ -271,7 +271,7 @@ test_expect_success 'merge-recursive result' '
 
 test_expect_success 'merge-recursive remove conflict' '
 
-	rm -fr [Aabd] &&
+	rm -fr [abcd] &&
 	git checkout -f "$c1" &&
 
 	git-merge-recursive "$c0" -- "$c1" "$c5"
@@ -291,10 +291,10 @@ test_expect_success 'merge-recursive remove conflict' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 0	A"
 		echo "100644 $o0 1	a"
 		echo "100644 $o1 2	a"
 		echo "100644 $o5 3	a"
+		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	git diff -u expected actual
@@ -302,7 +302,7 @@ test_expect_success 'merge-recursive remove conflict' '
 '
 
 test_expect_success 'merge-recursive d/f simple' '
-	rm -fr [Aabd] &&
+	rm -fr [abcd] &&
 	git reset --hard &&
 	git checkout -f "$c1" &&
 
@@ -313,9 +313,9 @@ test_expect_success 'merge-recursive result' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 0	A"
 		echo "100644 $o1 0	a"
 		echo "100644 $o3 0	b/c"
+		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	git diff -u expected actual
@@ -324,7 +324,7 @@ test_expect_success 'merge-recursive result' '
 
 test_expect_success 'merge-recursive d/f conflict' '
 
-	rm -fr [Aabd] &&
+	rm -fr [abcd] &&
 	git reset --hard &&
 	git checkout -f "$c1" &&
 
@@ -345,11 +345,11 @@ test_expect_success 'merge-recursive d/f conflict result' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 0	A"
 		echo "100644 $o0 1	a"
 		echo "100644 $o1 2	a"
 		echo "100644 $o4 0	a/c"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	git diff -u expected actual
@@ -358,7 +358,7 @@ test_expect_success 'merge-recursive d/f conflict result' '
 
 test_expect_success 'merge-recursive d/f conflict the other way' '
 
-	rm -fr [Aabd] &&
+	rm -fr [abcd] &&
 	git reset --hard &&
 	git checkout -f "$c4" &&
 
@@ -379,11 +379,11 @@ test_expect_success 'merge-recursive d/f conflict result the other way' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 0	A"
 		echo "100644 $o0 1	a"
 		echo "100644 $o1 3	a"
 		echo "100644 $o4 0	a/c"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	git diff -u expected actual
@@ -392,7 +392,7 @@ test_expect_success 'merge-recursive d/f conflict result the other way' '
 
 test_expect_success 'merge-recursive d/f conflict' '
 
-	rm -fr [Aabd] &&
+	rm -fr [abcd] &&
 	git reset --hard &&
 	git checkout -f "$c1" &&
 
@@ -413,9 +413,9 @@ test_expect_success 'merge-recursive d/f conflict result' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 0	A"
 		echo "100644 $o1 0	a"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o6 3	d"
 		echo "100644 $o0 1	d/e"
 		echo "100644 $o1 2	d/e"
@@ -426,7 +426,7 @@ test_expect_success 'merge-recursive d/f conflict result' '
 
 test_expect_success 'merge-recursive d/f conflict' '
 
-	rm -fr [Aabd] &&
+	rm -fr [abcd] &&
 	git reset --hard &&
 	git checkout -f "$c6" &&
 
@@ -447,9 +447,9 @@ test_expect_success 'merge-recursive d/f conflict result' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 0	A"
 		echo "100644 $o1 0	a"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o6 2	d"
 		echo "100644 $o0 1	d/e"
 		echo "100644 $o1 3	d/e"
@@ -471,13 +471,13 @@ test_expect_success 'reset and bind merge' '
 	git read-tree --prefix=M/ master &&
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 0	A"
-		echo "100644 $o0 0	M/A"
 		echo "100644 $o1 0	M/a"
 		echo "100644 $o0 0	M/b"
+		echo "100644 $o0 0	M/c"
 		echo "100644 $o1 0	M/d/e"
 		echo "100644 $o1 0	a"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	git diff -u expected actual &&
@@ -485,17 +485,17 @@ test_expect_success 'reset and bind merge' '
 	git read-tree --prefix=a1/ master &&
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 0	A"
-		echo "100644 $o0 0	M/A"
 		echo "100644 $o1 0	M/a"
 		echo "100644 $o0 0	M/b"
+		echo "100644 $o0 0	M/c"
 		echo "100644 $o1 0	M/d/e"
 		echo "100644 $o1 0	a"
-		echo "100644 $o0 0	a1/A"
 		echo "100644 $o1 0	a1/a"
 		echo "100644 $o0 0	a1/b"
+		echo "100644 $o0 0	a1/c"
 		echo "100644 $o1 0	a1/d/e"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
 	git diff -u expected actual
@@ -503,21 +503,21 @@ test_expect_success 'reset and bind merge' '
 	git read-tree --prefix=z/ master &&
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 0	A"
-		echo "100644 $o0 0	M/A"
 		echo "100644 $o1 0	M/a"
 		echo "100644 $o0 0	M/b"
+		echo "100644 $o0 0	M/c"
 		echo "100644 $o1 0	M/d/e"
 		echo "100644 $o1 0	a"
-		echo "100644 $o0 0	a1/A"
 		echo "100644 $o1 0	a1/a"
 		echo "100644 $o0 0	a1/b"
+		echo "100644 $o0 0	a1/c"
 		echo "100644 $o1 0	a1/d/e"
 		echo "100644 $o0 0	b"
+		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
-		echo "100644 $o0 0	z/A"
 		echo "100644 $o1 0	z/a"
 		echo "100644 $o0 0	z/b"
+		echo "100644 $o0 0	z/c"
 		echo "100644 $o1 0	z/d/e"
 	) >expected &&
 	git diff -u expected actual
-- 
1.5.1.1.107.g7a159
