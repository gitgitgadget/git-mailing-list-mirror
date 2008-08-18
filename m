From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t1002-read-tree-m-u-2way.sh: use 'git diff -U0' rather than
 'diff -U0'
Date: Mon, 18 Aug 2008 18:17:53 -0500
Message-ID: <jD7q5MKwWCg8rtaY_HWMMwcScqY6a1Yqn2KlDBchicoLNYubT7tjHg@cipher.nrlssc.navy.mil>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:19:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVE02-0005VE-Cb
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbYHRXRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbYHRXRz
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:17:55 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60924 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbYHRXRy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:17:54 -0400
Received: by mail.nrlssc.navy.mil id m7INHrbj026544; Mon, 18 Aug 2008 18:17:53 -0500
In-Reply-To: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 Aug 2008 23:17:53.0280 (UTC) FILETIME=[A3D82000:01C90188]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92756>

Some old platforms have an old diff which doesn't have the -U option.
'git diff' can be used in its place. Adjust the comparison function to
strip git's additional header lines to make this possible.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
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
1.6.0.13.ge1c8
