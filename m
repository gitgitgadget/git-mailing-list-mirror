From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH FYI] t1002-read-tree-m-u-2way.sh: use 'git diff -U0' rather
 than 'diff -U0'
Date: Mon, 18 Aug 2008 19:13:31 -0500
Message-ID: <Fw5U6bbeAwsJt8NPEGhI_KJGqviiUs1rv931TtDgSG2zzNctlxMWYA@cipher.nrlssc.navy.mil>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 02:14:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVErs-0004wx-7T
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 02:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbYHSANd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 20:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbYHSANd
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 20:13:33 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50192 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYHSANd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 20:13:33 -0400
Received: by mail.nrlssc.navy.mil id m7J0DWvk031849; Mon, 18 Aug 2008 19:13:32 -0500
In-Reply-To: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 19 Aug 2008 00:13:31.0880 (UTC) FILETIME=[69CE0E80:01C90190]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92787>

Some old platforms have an old diff which doesn't have the -U option.
'git diff' can be used in its place. Adjust the comparison function to
strip git's additional header lines to make this possible.
---


Same as the one posted in the IRIX thread.


 t/t1002-read-tree-m-u-2way.sh |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index aa9dd58..5e40cec 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -14,6 +14,8 @@ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 compare_change () {
 	sed >current \
+	    -e '1{/^diff --git /d;}' \
+	    -e '2{/^index /d;}' \
 	    -e '/^--- /d; /^+++ /d; /^@@ /d;' \
 	    -e 's/^\(.[0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /' "$1"
 	test_cmp expected current
@@ -75,7 +77,7 @@ test_expect_success \
      git update-index --add yomin &&
      git read-tree -m -u $treeH $treeM &&
      git ls-files --stage >4.out || return 1
-     diff -U0 M.out 4.out >4diff.out
+     git diff -U0 --no-index M.out 4.out >4diff.out
      compare_change 4diff.out expected &&
      check_cache_at yomin clean &&
      sum bozbar frotz nitfol >actual4.sum &&
@@ -94,7 +96,7 @@ test_expect_success \
      echo yomin yomin >yomin &&
      git read-tree -m -u $treeH $treeM &&
      git ls-files --stage >5.out || return 1
-     diff -U0 M.out 5.out >5diff.out
+     git diff -U0 --no-index M.out 5.out >5diff.out
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty &&
      sum bozbar frotz nitfol >actual5.sum &&
@@ -206,7 +208,7 @@ test_expect_success \
      git update-index --add nitfol &&
      git read-tree -m -u $treeH $treeM &&
      git ls-files --stage >14.out || return 1
-     diff -U0 M.out 14.out >14diff.out
+     git diff -U0 --no-index M.out 14.out >14diff.out
      compare_change 14diff.out expected &&
      sum bozbar frotz >actual14.sum &&
      grep -v nitfol M.sum > expected14.sum &&
@@ -227,7 +229,7 @@ test_expect_success \
      echo nitfol nitfol nitfol >nitfol &&
      git read-tree -m -u $treeH $treeM &&
      git ls-files --stage >15.out || return 1
-     diff -U0 M.out 15.out >15diff.out
+     git diff -U0 --no-index M.out 15.out >15diff.out
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty &&
      sum bozbar frotz >actual15.sum &&
-- 
1.6.0.11.gecc7e
