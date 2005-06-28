From: Mark Allen <mrallen1@yahoo.com>
Subject: [PATCH] replace sha1sum with sum in t/t1002
Date: Mon, 27 Jun 2005 18:40:31 -0700 (PDT)
Message-ID: <20050628014032.80769.qmail@web41212.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-360799533-1119922831=:80321"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Jun 28 03:34:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn4zc-0002ey-3Z
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 03:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVF1BlQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 21:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVF1BlQ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 21:41:16 -0400
Received: from web41212.mail.yahoo.com ([66.218.93.45]:1681 "HELO
	web41212.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262185AbVF1Bkh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2005 21:40:37 -0400
Received: (qmail 80771 invoked by uid 60001); 28 Jun 2005 01:40:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=UzVODVixD195eP5fGxS8tozdw8dg1iEPgu5b2q3WVpYNIO2KCa+cORWDUV78pnEm5lwosPeGgpdG6YPkY5TfKT77VZ9t4PA7GjK0n5sLtZMW36ilsumDZDArMVCCL/BdQbLDJkU04bHHXz2wpXRPcEI6qtZXicQoCavVfwlhg/c=  ;
Received: from [66.41.38.150] by web41212.mail.yahoo.com via HTTP; Mon, 27 Jun 2005 18:40:31 PDT
To: git@vger.kernel.org, torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--0-360799533-1119922831=:80321
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Linus,

This patch replaces sha1sum(1) with sum(1) in t/t1002. GNU sum(1) runs in "BSD
compatibility" mode by default, and not all systems have GNU coreutils. On any system
without GNU coreutils (or sha1sum) t1002 will fail. This patch should make t1002 complete
successfully everywhere that sum(1) runs.

I've tested this on Darwin and Linux; it works on both platforms.

Signed-off-by: Mark Allen <mrallen1@yahoo.com>


--0-360799533-1119922831=:80321
Content-Type: text/plain; name="test-portability.patch.txt"
Content-Description: 2003972814-test-portability.patch.txt
Content-Disposition: inline; filename="test-portability.patch.txt"

diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -51,7 +51,7 @@ test_expect_success \
      treeM=`git-write-tree` &&
      echo treeM $treeM &&
      git-ls-tree $treeM &&
-     sha1sum bozbar frotz nitfol >M.sha1 &&
+     sum bozbar frotz nitfol >M.sum &&
      git-diff-tree $treeH $treeM'
 
 test_expect_success \
@@ -60,7 +60,8 @@ test_expect_success \
      git-read-tree -m -u $treeH $treeM &&
      git-ls-files --stage >1-3.out &&
      cmp M.out 1-3.out &&
-     sha1sum -c M.sha1 &&
+     sum bozbar frotz nitfol >actual3.sum &&
+     cmp M.sum actual3.sum &&
      check_cache_at bozbar clean &&
      check_cache_at frotz clean &&
      check_cache_at nitfol clean'
@@ -76,7 +77,8 @@ test_expect_success \
      diff --unified=0 M.out 4.out >4diff.out
      compare_change 4diff.out expected &&
      check_cache_at yomin clean &&
-     sha1sum -c M.sha1 &&
+     sum bozbar frotz nitfol >actual4.sum &&
+     cmp M.sum actual4.sum &&
      echo yomin >yomin1 &&
      diff yomin yomin1 &&
      rm -f yomin1'
@@ -92,7 +94,8 @@ test_expect_success \
      diff --unified=0 M.out 5.out >5diff.out
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty &&
-     sha1sum -c M.sha1 &&
+     sum bozbar frotz nitfol >actual5.sum &&
+     cmp M.sum actual5.sum &&
      : dirty index should have prevented -u from checking it out. &&
      echo yomin yomin >yomin1 &&
      diff yomin yomin1 &&
@@ -106,7 +109,8 @@ test_expect_success \
      git-ls-files --stage >6.out &&
      diff --unified=0 M.out 6.out &&
      check_cache_at frotz clean &&
-     sha1sum -c M.sha1 &&
+     sum bozbar frotz nitfol >actual3.sum &&
+     cmp M.sum actual3.sum &&
      echo frotz >frotz1 &&
      diff frotz frotz1 &&
      rm -f frotz1'
@@ -121,7 +125,8 @@ test_expect_success \
      git-ls-files --stage >7.out &&
      diff --unified=0 M.out 7.out &&
      check_cache_at frotz dirty &&
-     if sha1sum -c M.sha1; then false; else :; fi &&
+     sum bozbar frotz nitfol >actual7.sum &&
+     if cmp M.sum actual7.sum; then false; else :; fi &&
      : dirty index should have prevented -u from checking it out. &&
      echo frotz frotz >frotz1 &&
      diff frotz frotz1 &&
@@ -150,7 +155,8 @@ test_expect_success \
      git-read-tree -m -u $treeH $treeM &&
      git-ls-files --stage >10.out &&
      cmp M.out 10.out &&
-     sha1sum -c M.sha1'
+     sum bozbar frotz nitfol >actual10.sum &&
+     cmp M.sum actual10.sum'
 
 test_expect_success \
     '11 - dirty path removed.' \
@@ -189,9 +195,12 @@ test_expect_success \
      git-ls-files --stage >14.out || exit
      diff --unified=0 M.out 14.out >14diff.out
      compare_change 14diff.out expected &&
+     sum bozbar frotz >actual14.sum &&
+     grep -v nitfol M.sum > expected14.sum &&
+     cmp expected14.sum actual14.sum &&
+     sum bozbar frotz nitfol >actual14a.sum &&
+     if cmp M.sum actual14a.sum; then false; else :; fi &&
      check_cache_at nitfol clean &&
-     grep -v nitfol M.sha1 | sha1sum -c &&
-     if sha1sum -c M.sha1; then false; else :; fi &&
      echo nitfol nitfol >nitfol1 &&
      diff nitfol nitfol1 &&
      rm -f nitfol1'
@@ -207,8 +216,11 @@ test_expect_success \
      diff --unified=0 M.out 15.out >15diff.out
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty &&
-     grep -v nitfol M.sha1 | sha1sum -c &&
-     if sha1sum -c M.sha1; then false; else :; fi &&
+     sum bozbar frotz >actual15.sum &&
+     grep -v nitfol M.sum > expected15.sum &&
+     cmp expected15.sum actual15.sum &&
+     sum bozbar frotz nitfol >actual15a.sum &&
+     if cmp M.sum actual15a.sum; then false; else :; fi &&
      echo nitfol nitfol nitfol >nitfol1 &&
      diff nitfol nitfol1 &&
      rm -f nitfol1'
@@ -237,7 +249,8 @@ test_expect_success \
      git-ls-files --stage >18.out &&
      diff --unified=0 M.out 18.out &&
      check_cache_at bozbar clean &&
-     sha1sum -c M.sha1'
+     sum bozbar frotz nitfol >actual18.sum &&
+     cmp M.sum actual18.sum'
 
 test_expect_success \
     '19 - local change already having a good result, further modified.' \
@@ -249,8 +262,11 @@ test_expect_success \
      git-ls-files --stage >19.out &&
      diff --unified=0 M.out 19.out &&
      check_cache_at bozbar dirty &&
-     grep -v bozbar M.sha1 | sha1sum -c &&
-     if sha1sum -c M.sha1; then false; else :; fi &&
+     sum frotz nitfol >actual19.sum &&
+     grep -v bozbar  M.sum > expected19.sum &&
+     cmp expected19.sum actual19.sum &&
+     sum bozbar frotz nitfol >actual19a.sum &&
+     if cmp M.sum actual19a.sum; then false; else :; fi &&
      echo gnusto gnusto >bozbar1 &&
      diff bozbar bozbar1 &&
      rm -f bozbar1'
@@ -264,7 +280,8 @@ test_expect_success \
      git-ls-files --stage >20.out &&
      diff --unified=0 M.out 20.out &&
      check_cache_at bozbar clean &&
-     sha1sum -c M.sha1'
+     sum bozbar frotz nitfol >actual20.sum &&
+     cmp M.sum actual20.sum'
 
 test_expect_success \
     '21 - no local change, dirty cache.' \

--0-360799533-1119922831=:80321--
