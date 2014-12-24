From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/5] t2004: modernize style
Date: Wed, 24 Dec 2014 04:43:12 -0500
Message-ID: <1419414196-58587-2-git-send-email-sunshine@sunshineco.com>
References: <1419414196-58587-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"Shawn O . Pearce" <spearce@spearce.org>
To: git@vger.kernel.org, Russ Cox <rsc@golang.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 10:44:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3iUH-00051e-Gk
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 10:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbaLXJoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 04:44:08 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:50357 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbaLXJoF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2014 04:44:05 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so7924671igi.3
        for <git@vger.kernel.org>; Wed, 24 Dec 2014 01:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MX0f7eOfI7HROTm+cw2UQTbwwF8oC/iR1B+usZ+kLXY=;
        b=Mx5kicwgHodVxVykh8Qt/QlCon+98O5cAURwkWcLCNKgiloH5taVVnnvSLJhhyGsug
         fv745KtuimjqhZ6cvDNaZrlp0jaBOj038LXgylYwrv5oqe/3chs74K8U/gkDgpFJXlcv
         tJ6VJc2anF7oAf/P+KaYGElGiiUpm3+V9lTjEOK0dU7Oi+xb//iwTo2skXvBGjOLWD1u
         wYRse8zF+K/L+6BBkzz3g3t7t3qQ8n6R1DvVGUtGOVJtBzfiBfp9GSNGXtYSsshiiXkc
         FKQ5wVUBaHdD6njHRhTnlDVZa+eNbI405nomGsOIafRql7vKSLC7gB+lTylCkVhVqK/d
         CWOg==
X-Received: by 10.107.156.67 with SMTP id f64mr30718262ioe.9.1419414244889;
        Wed, 24 Dec 2014 01:44:04 -0800 (PST)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id l3sm7575581igj.9.2014.12.24.01.44.04
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Dec 2014 01:44:04 -0800 (PST)
X-Mailer: git-send-email 2.2.1.267.g0ad48de
In-Reply-To: <1419414196-58587-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261795>

In particular:

* indent test body
* place test description on same line as test_expect_*
* place closing quote on its own line
* name output file "actual" rather than "out"
* name setup test "setup" rather than "preparation"

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t2004-checkout-cache-temp.sh | 391 +++++++++++++++++++++--------------------
 1 file changed, 196 insertions(+), 195 deletions(-)

diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index f171a55..28e50d6 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -10,202 +10,203 @@ rather than the tracked path.'
 
 . ./test-lib.sh
 
-test_expect_success \
-'preparation' '
-mkdir asubdir &&
-echo tree1path0 >path0 &&
-echo tree1path1 >path1 &&
-echo tree1path3 >path3 &&
-echo tree1path4 >path4 &&
-echo tree1asubdir/path5 >asubdir/path5 &&
-git update-index --add path0 path1 path3 path4 asubdir/path5 &&
-t1=$(git write-tree) &&
-rm -f path* .merge_* out .git/index &&
-echo tree2path0 >path0 &&
-echo tree2path1 >path1 &&
-echo tree2path2 >path2 &&
-echo tree2path4 >path4 &&
-git update-index --add path0 path1 path2 path4 &&
-t2=$(git write-tree) &&
-rm -f path* .merge_* out .git/index &&
-echo tree2path0 >path0 &&
-echo tree3path1 >path1 &&
-echo tree3path2 >path2 &&
-echo tree3path3 >path3 &&
-git update-index --add path0 path1 path2 path3 &&
-t3=$(git write-tree)'
-
-test_expect_success \
-'checkout one stage 0 to temporary file' '
-rm -f path* .merge_* out .git/index &&
-git read-tree $t1 &&
-git checkout-index --temp -- path1 >out &&
-test_line_count = 1 out &&
-test $(cut "-d	" -f2 out) = path1 &&
-p=$(cut "-d	" -f1 out) &&
-test -f $p &&
-test $(cat $p) = tree1path1'
-
-test_expect_success \
-'checkout all stage 0 to temporary files' '
-rm -f path* .merge_* out .git/index &&
-git read-tree $t1 &&
-git checkout-index -a --temp >out &&
-test_line_count = 5 out &&
-for f in path0 path1 path3 path4 asubdir/path5
-do
-	test $(grep $f out | cut "-d	" -f2) = $f &&
-	p=$(grep $f out | cut "-d	" -f1) &&
+test_expect_success 'setup' '
+	mkdir asubdir &&
+	echo tree1path0 >path0 &&
+	echo tree1path1 >path1 &&
+	echo tree1path3 >path3 &&
+	echo tree1path4 >path4 &&
+	echo tree1asubdir/path5 >asubdir/path5 &&
+	git update-index --add path0 path1 path3 path4 asubdir/path5 &&
+	t1=$(git write-tree) &&
+	rm -f path* .merge_* actual .git/index &&
+	echo tree2path0 >path0 &&
+	echo tree2path1 >path1 &&
+	echo tree2path2 >path2 &&
+	echo tree2path4 >path4 &&
+	git update-index --add path0 path1 path2 path4 &&
+	t2=$(git write-tree) &&
+	rm -f path* .merge_* actual .git/index &&
+	echo tree2path0 >path0 &&
+	echo tree3path1 >path1 &&
+	echo tree3path2 >path2 &&
+	echo tree3path3 >path3 &&
+	git update-index --add path0 path1 path2 path3 &&
+	t3=$(git write-tree)
+'
+
+test_expect_success 'checkout one stage 0 to temporary file' '
+	rm -f path* .merge_* actual .git/index &&
+	git read-tree $t1 &&
+	git checkout-index --temp -- path1 >actual &&
+	test_line_count = 1 actual &&
+	test $(cut "-d	" -f2 actual) = path1 &&
+	p=$(cut "-d	" -f1 actual) &&
 	test -f $p &&
-	test $(cat $p) = tree1$f
-done'
-
-test_expect_success \
-'prepare 3-way merge' '
-rm -f path* .merge_* out .git/index &&
-git read-tree -m $t1 $t2 $t3'
-
-test_expect_success \
-'checkout one stage 2 to temporary file' '
-rm -f path* .merge_* out &&
-git checkout-index --stage=2 --temp -- path1 >out &&
-test_line_count = 1 out &&
-test $(cut "-d	" -f2 out) = path1 &&
-p=$(cut "-d	" -f1 out) &&
-test -f $p &&
-test $(cat $p) = tree2path1'
-
-test_expect_success \
-'checkout all stage 2 to temporary files' '
-rm -f path* .merge_* out &&
-git checkout-index --all --stage=2 --temp >out &&
-test_line_count = 3 out &&
-for f in path1 path2 path4
-do
-	test $(grep $f out | cut "-d	" -f2) = $f &&
-	p=$(grep $f out | cut "-d	" -f1) &&
+	test $(cat $p) = tree1path1
+'
+
+test_expect_success 'checkout all stage 0 to temporary files' '
+	rm -f path* .merge_* actual .git/index &&
+	git read-tree $t1 &&
+	git checkout-index -a --temp >actual &&
+	test_line_count = 5 actual &&
+	for f in path0 path1 path3 path4 asubdir/path5
+	do
+		test $(grep $f actual | cut "-d	" -f2) = $f &&
+		p=$(grep $f actual | cut "-d	" -f1) &&
+		test -f $p &&
+		test $(cat $p) = tree1$f
+	done
+'
+
+test_expect_success 'setup 3-way merge' '
+	rm -f path* .merge_* actual .git/index &&
+	git read-tree -m $t1 $t2 $t3
+'
+
+test_expect_success 'checkout one stage 2 to temporary file' '
+	rm -f path* .merge_* actual &&
+	git checkout-index --stage=2 --temp -- path1 >actual &&
+	test_line_count = 1 actual &&
+	test $(cut "-d	" -f2 actual) = path1 &&
+	p=$(cut "-d	" -f1 actual) &&
 	test -f $p &&
-	test $(cat $p) = tree2$f
-done'
-
-test_expect_success \
-'checkout all stages/one file to nothing' '
-rm -f path* .merge_* out &&
-git checkout-index --stage=all --temp -- path0 >out &&
-test_line_count = 0 out'
-
-test_expect_success \
-'checkout all stages/one file to temporary files' '
-rm -f path* .merge_* out &&
-git checkout-index --stage=all --temp -- path1 >out &&
-test_line_count = 1 out &&
-test $(cut "-d	" -f2 out) = path1 &&
-cut "-d	" -f1 out | (read s1 s2 s3 &&
-test -f $s1 &&
-test -f $s2 &&
-test -f $s3 &&
-test $(cat $s1) = tree1path1 &&
-test $(cat $s2) = tree2path1 &&
-test $(cat $s3) = tree3path1)'
-
-test_expect_success \
-'checkout some stages/one file to temporary files' '
-rm -f path* .merge_* out &&
-git checkout-index --stage=all --temp -- path2 >out &&
-test_line_count = 1 out &&
-test $(cut "-d	" -f2 out) = path2 &&
-cut "-d	" -f1 out | (read s1 s2 s3 &&
-test $s1 = . &&
-test -f $s2 &&
-test -f $s3 &&
-test $(cat $s2) = tree2path2 &&
-test $(cat $s3) = tree3path2)'
-
-test_expect_success \
-'checkout all stages/all files to temporary files' '
-rm -f path* .merge_* out &&
-git checkout-index -a --stage=all --temp >out &&
-test_line_count = 5 out'
-
-test_expect_success \
-'-- path0: no entry' '
-test x$(grep path0 out | cut "-d	" -f2) = x'
-
-test_expect_success \
-'-- path1: all 3 stages' '
-test $(grep path1 out | cut "-d	" -f2) = path1 &&
-grep path1 out | cut "-d	" -f1 | (read s1 s2 s3 &&
-test -f $s1 &&
-test -f $s2 &&
-test -f $s3 &&
-test $(cat $s1) = tree1path1 &&
-test $(cat $s2) = tree2path1 &&
-test $(cat $s3) = tree3path1)'
-
-test_expect_success \
-'-- path2: no stage 1, have stage 2 and 3' '
-test $(grep path2 out | cut "-d	" -f2) = path2 &&
-grep path2 out | cut "-d	" -f1 | (read s1 s2 s3 &&
-test $s1 = . &&
-test -f $s2 &&
-test -f $s3 &&
-test $(cat $s2) = tree2path2 &&
-test $(cat $s3) = tree3path2)'
-
-test_expect_success \
-'-- path3: no stage 2, have stage 1 and 3' '
-test $(grep path3 out | cut "-d	" -f2) = path3 &&
-grep path3 out | cut "-d	" -f1 | (read s1 s2 s3 &&
-test -f $s1 &&
-test $s2 = . &&
-test -f $s3 &&
-test $(cat $s1) = tree1path3 &&
-test $(cat $s3) = tree3path3)'
-
-test_expect_success \
-'-- path4: no stage 3, have stage 1 and 3' '
-test $(grep path4 out | cut "-d	" -f2) = path4 &&
-grep path4 out | cut "-d	" -f1 | (read s1 s2 s3 &&
-test -f $s1 &&
-test -f $s2 &&
-test $s3 = . &&
-test $(cat $s1) = tree1path4 &&
-test $(cat $s2) = tree2path4)'
-
-test_expect_success \
-'-- asubdir/path5: no stage 2 and 3 have stage 1' '
-test $(grep asubdir/path5 out | cut "-d	" -f2) = asubdir/path5 &&
-grep asubdir/path5 out | cut "-d	" -f1 | (read s1 s2 s3 &&
-test -f $s1 &&
-test $s2 = . &&
-test $s3 = . &&
-test $(cat $s1) = tree1asubdir/path5)'
-
-test_expect_success \
-'checkout --temp within subdir' '
-(cd asubdir &&
- git checkout-index -a --stage=all >out &&
- test_line_count = 1 out &&
- test $(grep path5 out | cut "-d	" -f2) = path5 &&
- grep path5 out | cut "-d	" -f1 | (read s1 s2 s3 &&
- test -f ../$s1 &&
- test $s2 = . &&
- test $s3 = . &&
- test $(cat ../$s1) = tree1asubdir/path5)
-)'
-
-test_expect_success \
-'checkout --temp symlink' '
-rm -f path* .merge_* out .git/index &&
-test_ln_s_add b a &&
-t4=$(git write-tree) &&
-rm -f .git/index &&
-git read-tree $t4 &&
-git checkout-index --temp -a >out &&
-test_line_count = 1 out &&
-test $(cut "-d	" -f2 out) = a &&
-p=$(cut "-d	" -f1 out) &&
-test -f $p &&
-test $(cat $p) = b'
+	test $(cat $p) = tree2path1
+'
+
+test_expect_success 'checkout all stage 2 to temporary files' '
+	rm -f path* .merge_* actual &&
+	git checkout-index --all --stage=2 --temp >actual &&
+	test_line_count = 3 actual &&
+	for f in path1 path2 path4
+	do
+		test $(grep $f actual | cut "-d	" -f2) = $f &&
+		p=$(grep $f actual | cut "-d	" -f1) &&
+		test -f $p &&
+		test $(cat $p) = tree2$f
+	done
+'
+
+test_expect_success 'checkout all stages/one file to nothing' '
+	rm -f path* .merge_* actual &&
+	git checkout-index --stage=all --temp -- path0 >actual &&
+	test_line_count = 0 actual
+'
+
+test_expect_success 'checkout all stages/one file to temporary files' '
+	rm -f path* .merge_* actual &&
+	git checkout-index --stage=all --temp -- path1 >actual &&
+	test_line_count = 1 actual &&
+	test $(cut "-d	" -f2 actual) = path1 &&
+	cut "-d	" -f1 actual | (read s1 s2 s3 &&
+	test -f $s1 &&
+	test -f $s2 &&
+	test -f $s3 &&
+	test $(cat $s1) = tree1path1 &&
+	test $(cat $s2) = tree2path1 &&
+	test $(cat $s3) = tree3path1)
+'
+
+test_expect_success 'checkout some stages/one file to temporary files' '
+	rm -f path* .merge_* actual &&
+	git checkout-index --stage=all --temp -- path2 >actual &&
+	test_line_count = 1 actual &&
+	test $(cut "-d	" -f2 actual) = path2 &&
+	cut "-d	" -f1 actual | (read s1 s2 s3 &&
+	test $s1 = . &&
+	test -f $s2 &&
+	test -f $s3 &&
+	test $(cat $s2) = tree2path2 &&
+	test $(cat $s3) = tree3path2)
+'
+
+test_expect_success 'checkout all stages/all files to temporary files' '
+	rm -f path* .merge_* actual &&
+	git checkout-index -a --stage=all --temp >actual &&
+	test_line_count = 5 actual
+'
+
+test_expect_success '-- path0: no entry' '
+	test x$(grep path0 actual | cut "-d	" -f2) = x
+'
+
+test_expect_success '-- path1: all 3 stages' '
+	test $(grep path1 actual | cut "-d	" -f2) = path1 &&
+	grep path1 actual | cut "-d	" -f1 | (read s1 s2 s3 &&
+	test -f $s1 &&
+	test -f $s2 &&
+	test -f $s3 &&
+	test $(cat $s1) = tree1path1 &&
+	test $(cat $s2) = tree2path1 &&
+	test $(cat $s3) = tree3path1)
+'
+
+test_expect_success '-- path2: no stage 1, have stage 2 and 3' '
+	test $(grep path2 actual | cut "-d	" -f2) = path2 &&
+	grep path2 actual | cut "-d	" -f1 | (read s1 s2 s3 &&
+	test $s1 = . &&
+	test -f $s2 &&
+	test -f $s3 &&
+	test $(cat $s2) = tree2path2 &&
+	test $(cat $s3) = tree3path2)
+'
+
+test_expect_success '-- path3: no stage 2, have stage 1 and 3' '
+	test $(grep path3 actual | cut "-d	" -f2) = path3 &&
+	grep path3 actual | cut "-d	" -f1 | (read s1 s2 s3 &&
+	test -f $s1 &&
+	test $s2 = . &&
+	test -f $s3 &&
+	test $(cat $s1) = tree1path3 &&
+	test $(cat $s3) = tree3path3)
+'
+
+test_expect_success '-- path4: no stage 3, have stage 1 and 3' '
+	test $(grep path4 actual | cut "-d	" -f2) = path4 &&
+	grep path4 actual | cut "-d	" -f1 | (read s1 s2 s3 &&
+	test -f $s1 &&
+	test -f $s2 &&
+	test $s3 = . &&
+	test $(cat $s1) = tree1path4 &&
+	test $(cat $s2) = tree2path4)
+'
+
+test_expect_success '-- asubdir/path5: no stage 2 and 3 have stage 1' '
+	test $(grep asubdir/path5 actual | cut "-d	" -f2) = asubdir/path5 &&
+	grep asubdir/path5 actual | cut "-d	" -f1 | (read s1 s2 s3 &&
+	test -f $s1 &&
+	test $s2 = . &&
+	test $s3 = . &&
+	test $(cat $s1) = tree1asubdir/path5)
+'
+
+test_expect_success 'checkout --temp within subdir' '
+	(
+		cd asubdir &&
+		git checkout-index -a --stage=all >actual &&
+		test_line_count = 1 actual &&
+		test $(grep path5 actual | cut "-d	" -f2) = path5 &&
+		grep path5 actual | cut "-d	" -f1 | (read s1 s2 s3 &&
+		test -f ../$s1 &&
+		test $s2 = . &&
+		test $s3 = . &&
+		test $(cat ../$s1) = tree1asubdir/path5)
+	)
+'
+
+test_expect_success 'checkout --temp symlink' '
+	rm -f path* .merge_* actual .git/index &&
+	test_ln_s_add b a &&
+	t4=$(git write-tree) &&
+	rm -f .git/index &&
+	git read-tree $t4 &&
+	git checkout-index --temp -a >actual &&
+	test_line_count = 1 actual &&
+	test $(cut "-d	" -f2 actual) = a &&
+	p=$(cut "-d	" -f1 actual) &&
+	test -f $p &&
+	test $(cat $p) = b
+'
 
 test_done
-- 
2.2.1.267.g0ad48de
