From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/24] t7600 (merge): modernize style
Date: Tue, 17 Aug 2010 01:53:56 -0500
Message-ID: <20100817065356.GB22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 08:55:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlG5C-0005cv-RQ
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 08:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193Ab0HQGzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 02:55:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42024 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab0HQGzc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 02:55:32 -0400
Received: by yxg6 with SMTP id 6so2282071yxg.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 23:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZYHgf2XCPMlqG9sXoCJOBpBtKKYWHGxhGmTOH9uJ4l0=;
        b=usrkdWMLTaXaRbE/C4TBL7RcvrSbwS93pmJXSjc65Qerln6zWIGU0THAV4ELzjDBQI
         6AkcBEW+HWEtmZCljow/SccYooLkBebHs4pLldyvv/4GJ0PkmRNk3cAB6Usi8+EDs9Kx
         xaLCaEDdSSMnB581/37u5+eS/PwfxdjQqUZcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vHDeOXo0t6QZXl44h0bFCc5RsMtqBhGxlINAxjrhTMzkKrzSx0DQPhi5fpsEYIROB8
         PdusE22BQ0+ThM4TBL7FFrMV5TsZVzqPs6f5Ac7d8zBPuPZIp25t8pyIgUmuCE2j8HCC
         Xn/IR7t+GGnZ7X/wtTE4lfYKIdkE+opCDBchw=
Received: by 10.101.170.11 with SMTP id x11mr7113624ano.81.1282028131278;
        Mon, 16 Aug 2010 23:55:31 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h5sm11743837anb.28.2010.08.16.23.55.30
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 23:55:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153705>

Guard setup commands with test_expect_success, so they are easier
to visually skip over and get to the good part.  While at it:

 - use "printf '%s\n' a b ..." instead of "cat <<EOF" for test
   vectors with short lines;

 - use test_cmp instead of test foo = bar where possible, for
   better output with -v on failure;

 - do not go to extraordinary lengths to print a relevant message
   when test commands fail.  There is a patch in flight that could be
   used to restore the nice error messages in a cleaner way.

Cc: Lars Hjemli <hjemli@gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7600-merge.sh |  282 +++++++++++++++++++-----------------------------------
 1 files changed, 98 insertions(+), 184 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 16e5ba1..48a91ba 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -5,189 +5,103 @@
 
 test_description='git merge
 
-Testing basic merge operations/option parsing.'
+Testing basic merge operations/option parsing.
+
+! [c0] commit 0
+ ! [c1] commit 1
+  ! [c2] commit 2
+   ! [c3] commit 3
+    ! [c4] c4
+     ! [c5] c5
+      ! [c6] c6
+       * [master] Merge commit 'c1'
+--------
+       - [master] Merge commit 'c1'
+ +     * [c1] commit 1
+      +  [c6] c6
+     +   [c5] c5
+    ++   [c4] c4
+   ++++  [c3] commit 3
+  +      [c2] commit 2
++++++++* [c0] commit 0
+'
 
 . ./test-lib.sh
 
-cat >file <<EOF
-1
-2
-3
-4
-5
-6
-7
-8
-9
-EOF
+test_expect_success 'set up test data and helpers' '
+	printf "%s\n" 1 2 3 4 5 6 7 8 9 >file &&
+	printf "%s\n" "1 X" 2 3 4 5 6 7 8 9 >file.1 &&
+	printf "%s\n" 1 2 3 4 "5 X" 6 7 8 9 >file.5 &&
+	printf "%s\n" 1 2 3 4 5 6 7 8 "9 X" >file.9 &&
+	printf "%s\n" "1 X" 2 3 4 5 6 7 8 9 >result.1 &&
+	printf "%s\n" "1 X" 2 3 4 "5 X" 6 7 8 9 >result.1-5 &&
+	printf "%s\n" "1 X" 2 3 4 "5 X" 6 7 8 "9 X" >result.1-5-9 &&
 
-cat >file.1 <<EOF
-1 X
-2
-3
-4
-5
-6
-7
-8
-9
-EOF
+	create_merge_msgs() {
+		echo "Merge commit '\''c2'\''" >msg.1-5 &&
+		echo "Merge commit '\''c2'\''; commit '\''c3'\''" >msg.1-5-9 &&
+		{
+			echo "Squashed commit of the following:" &&
+			echo &&
+			git log --no-merges ^HEAD c1
+		} >squash.1 &&
+		{
+			echo "Squashed commit of the following:" &&
+			echo &&
+			git log --no-merges ^HEAD c2
+		} >squash.1-5 &&
+		{
+			echo "Squashed commit of the following:" &&
+			echo &&
+			git log --no-merges ^HEAD c2 c3
+		} >squash.1-5-9 &&
+		echo >msg.nolog &&
+		{
+			echo "* commit '\''c3'\'':" &&
+			echo "  commit 3" &&
+			echo
+		} >msg.log
+	} &&
 
-cat >file.5 <<EOF
-1
-2
-3
-4
-5 X
-6
-7
-8
-9
-EOF
-
-cat >file.9 <<EOF
-1
-2
-3
-4
-5
-6
-7
-8
-9 X
-EOF
-
-cat  >result.1 <<EOF
-1 X
-2
-3
-4
-5
-6
-7
-8
-9
-EOF
-
-cat >result.1-5 <<EOF
-1 X
-2
-3
-4
-5 X
-6
-7
-8
-9
-EOF
-
-cat >result.1-5-9 <<EOF
-1 X
-2
-3
-4
-5 X
-6
-7
-8
-9 X
-EOF
-
-create_merge_msgs() {
-	echo "Merge commit 'c2'" >msg.1-5 &&
-	echo "Merge commit 'c2'; commit 'c3'" >msg.1-5-9 &&
-	echo "Squashed commit of the following:" >squash.1 &&
-	echo >>squash.1 &&
-	git log --no-merges ^HEAD c1 >>squash.1 &&
-	echo "Squashed commit of the following:" >squash.1-5 &&
-	echo >>squash.1-5 &&
-	git log --no-merges ^HEAD c2 >>squash.1-5 &&
-	echo "Squashed commit of the following:" >squash.1-5-9 &&
-	echo >>squash.1-5-9 &&
-	git log --no-merges ^HEAD c2 c3 >>squash.1-5-9 &&
-	echo > msg.nolog &&
-	echo "* commit 'c3':" >msg.log &&
-	echo "  commit 3" >>msg.log &&
-	echo >>msg.log
-}
-
-verify_diff() {
-	if ! test_cmp "$1" "$2"
-	then
-		echo "$3"
-		false
-	fi
-}
-
-verify_merge() {
-	verify_diff "$2" "$1" "[OOPS] bad merge result" &&
-	if test $(git ls-files -u | wc -l) -gt 0
-	then
-		echo "[OOPS] unmerged files"
-		false
-	fi &&
-	if test_must_fail git diff --exit-code
-	then
-		echo "[OOPS] working tree != index"
-		false
-	fi &&
-	if test -n "$3"
-	then
-		git show -s --pretty=format:%s HEAD >msg.act &&
-		verify_diff "$3" msg.act "[OOPS] bad merge message"
-	fi
-}
-
-verify_head() {
-	if test "$1" != "$(git rev-parse HEAD)"
-	then
-		echo "[OOPS] HEAD != $1"
-		false
-	fi
-}
-
-verify_parents() {
-	i=1
-	while test $# -gt 0
-	do
-		if test "$1" != "$(git rev-parse HEAD^$i)"
+	verify_merge() {
+		test_cmp "$2" "$1" &&
+		git update-index --refresh &&
+		git diff --exit-code &&
+		if test -n "$3"
 		then
-			echo "[OOPS] HEAD^$i != $1"
-			return 1
+			git show -s --pretty=format:%s HEAD >msg.act &&
+			test_cmp "$3" msg.act
 		fi
-		i=$(expr $i + 1)
-		shift
-	done
-}
+	} &&
 
-verify_mergeheads() {
-	i=1
-	if ! test -f .git/MERGE_HEAD
-	then
-		echo "[OOPS] MERGE_HEAD is missing"
-		false
-	fi &&
-	while test $# -gt 0
-	do
-		head=$(head -n $i .git/MERGE_HEAD | sed -ne \$p)
-		if test "$1" != "$head"
-		then
-			echo "[OOPS] MERGE_HEAD $i != $1"
+	verify_head() {
+		echo "$1" >head.expected &&
+		git rev-parse HEAD >head.actual &&
+		test_cmp head.expected head.actual
+	} &&
+
+	verify_parents() {
+		printf "%s\n" "$@" >parents.expected &&
+		>parents.actual &&
+		i=1 &&
+		while test $i -le $#
+		do
+			git rev-parse HEAD^$i >>parents.actual &&
+			i=$(expr $i + 1) ||
 			return 1
-		fi
-		i=$(expr $i + 1)
-		shift
-	done
-}
+		done &&
+		test_cmp parents.expected parents.actual
+	} &&
 
-verify_no_mergehead() {
-	if test -f .git/MERGE_HEAD
-	then
-		echo "[OOPS] MERGE_HEAD exists"
-		false
-	fi
-}
+	verify_mergeheads() {
+		printf "%s\n" "$@" >mergehead.expected &&
+		test_cmp mergehead.expected .git/MERGE_HEAD
+	} &&
 
+	verify_no_mergehead() {
+		! test -e .git/MERGE_HEAD
+	}
+'
 
 test_expect_success 'setup' '
 	git add file &&
@@ -316,7 +230,7 @@ test_expect_success 'merge c0 with c1 (squash)' '
 	verify_merge file result.1 &&
 	verify_head $c0 &&
 	verify_no_mergehead &&
-	verify_diff squash.1 .git/SQUASH_MSG "[OOPS] bad squash message"
+	test_cmp squash.1 .git/SQUASH_MSG
 '
 
 test_debug 'gitk --all'
@@ -327,7 +241,7 @@ test_expect_success 'merge c0 with c1 (squash, ff-only)' '
 	verify_merge file result.1 &&
 	verify_head $c0 &&
 	verify_no_mergehead &&
-	verify_diff squash.1 .git/SQUASH_MSG "[OOPS] bad squash message"
+	test_cmp squash.1 .git/SQUASH_MSG
 '
 
 test_debug 'gitk --all'
@@ -338,7 +252,7 @@ test_expect_success 'merge c1 with c2 (squash)' '
 	verify_merge file result.1-5 &&
 	verify_head $c1 &&
 	verify_no_mergehead &&
-	verify_diff squash.1-5 .git/SQUASH_MSG "[OOPS] bad squash message"
+	test_cmp squash.1-5 .git/SQUASH_MSG
 '
 
 test_debug 'gitk --all'
@@ -356,7 +270,7 @@ test_expect_success 'merge c1 with c2 and c3 (squash)' '
 	verify_merge file result.1-5-9 &&
 	verify_head $c1 &&
 	verify_no_mergehead &&
-	verify_diff squash.1-5-9 .git/SQUASH_MSG "[OOPS] bad squash message"
+	test_cmp squash.1-5-9 .git/SQUASH_MSG
 '
 
 test_debug 'gitk --all'
@@ -379,7 +293,7 @@ test_expect_success 'merge c1 with c2 (squash in config)' '
 	verify_merge file result.1-5 &&
 	verify_head $c1 &&
 	verify_no_mergehead &&
-	verify_diff squash.1-5 .git/SQUASH_MSG "[OOPS] bad squash message"
+	test_cmp squash.1-5 .git/SQUASH_MSG
 '
 
 test_debug 'gitk --all'
@@ -485,17 +399,17 @@ test_expect_success 'merge log message' '
 	git reset --hard c0 &&
 	git merge --no-log c2 &&
 	git show -s --pretty=format:%b HEAD >msg.act &&
-	verify_diff msg.nolog msg.act "[OOPS] bad merge log message" &&
+	test_cmp msg.nolog msg.act &&
 
 	git merge --log c3 &&
 	git show -s --pretty=format:%b HEAD >msg.act &&
-	verify_diff msg.log msg.act "[OOPS] bad merge log message" &&
+	test_cmp msg.log msg.act &&
 
 	git reset --hard HEAD^ &&
 	git config merge.log yes &&
 	git merge c3 &&
 	git show -s --pretty=format:%b HEAD >msg.act &&
-	verify_diff msg.log msg.act "[OOPS] bad merge log message"
+	test_cmp msg.log msg.act
 '
 
 test_debug 'gitk --all'
@@ -545,7 +459,7 @@ test_debug 'gitk --all'
 
 test_expect_success 'in-index merge' '
 	git reset --hard c0 &&
-	git merge --no-ff -s resolve c1 > out &&
+	git merge --no-ff -s resolve c1 >out &&
 	grep "Wonderful." out &&
 	verify_parents $c0 $c1
 '
@@ -567,16 +481,16 @@ EOF
 
 test_expect_success 'merge early part of c2' '
 	git reset --hard c3 &&
-	echo c4 > c4.c &&
+	echo c4 >c4.c &&
 	git add c4.c &&
 	git commit -m c4 &&
 	git tag c4 &&
-	echo c5 > c5.c &&
+	echo c5 >c5.c &&
 	git add c5.c &&
 	git commit -m c5 &&
 	git tag c5 &&
 	git reset --hard c3 &&
-	echo c6 > c6.c &&
+	echo c6 >c6.c &&
 	git add c6.c &&
 	git commit -m c6 &&
 	git tag c6 &&
-- 
1.7.2.1.544.ga752d.dirty
