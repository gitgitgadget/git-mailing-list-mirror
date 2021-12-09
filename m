Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC7EC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhLIFQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhLIFPy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:54 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A99C0698C6
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:21 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id e128so5347947iof.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9Ba/GcOzO/xeMvgpzSUyA+u0UXIuaw60L6mQGSYuuM=;
        b=mpmDsgHz4jjqMLfpx5NaaH5rRqubEA9uY0T4hdsfyR+3uAfZJfMBHtX1tCYaIgFJfU
         ZUvO9WzAKIKaAx8zS9QCSiCu3bV98qQsb4aW49UlQhsxNL6/VoPxsQgJ0JjC0StAfALG
         hDbKY8FBFTHnH83Ye+2EeEiy41MEjCVtOQiAAdaN9oNDBnAKnsVAqNDqKxqoebhlYcFO
         9OWg89bnvXUKl/lUtcIi2t/MQ/gha3mLBbrST+Z9n5W10e8JDwEV0glVGfR+J+GAJney
         RKyA5w4xjRNcR5lqy81DosJLbQkw+umcC4WgqlljKkg68j6e7sJjYII/l/LFfnqxWKwn
         vWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=K9Ba/GcOzO/xeMvgpzSUyA+u0UXIuaw60L6mQGSYuuM=;
        b=EN4alrlh9+g6DiFtwq2nvebabO89g0MYS5qrevs29wnC9W++Ak2JNkwBFRVBJfE3j2
         tB+cftbpDlbIPxLmSkNIyH8VuqgZJ+gc9Ql0RfTsn4IOUNFjY/kvarBJ6rGamOHzl1M3
         qZZA+JRJOWUMxM4zS+Czf07F18MH2eSj7H7TEylWVJ7TX7Gew89nO42evATSAmtyBPft
         7n0iu4lnQ3ZBVb7+zDeqltJcuds+UJGQBKc24m6fE4hxlyVCoillar/qWNa4lFQmXPHH
         5zdXYqFHSAgy9czOnaWiQqzusyZKkxXcO9P8QfzGteKCt+/pxNp1C4HL/Qd3JCErBWcv
         63fA==
X-Gm-Message-State: AOAM532JdLLd8dc2Gu6LoGuk10vaGBZ6hCaNyZVXkQ8n6jqDyWc9RCW6
        cjeO5sFUM0kX5kvW9Om3cYTSP3xoMQmmzg==
X-Google-Smtp-Source: ABdhPJytJOcXLNYTkdbrBCnWz8bcbgWy1QjWtvj4sn4VEi4JBSRifRor3mPUB22imN2nxUZnOG7Uqg==
X-Received: by 2002:a05:6638:d08:: with SMTP id q8mr6083324jaj.38.1639026740591;
        Wed, 08 Dec 2021 21:12:20 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:20 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 17/19] t4000-t4999: detect and signal failure within loop
Date:   Thu,  9 Dec 2021 00:11:13 -0500
Message-Id: <20211209051115.52629-18-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Failures within `for` and `while` loops can go unnoticed if not detected
and signaled manually since the loop itself does not abort when a
contained command fails, nor will a failure necessarily be detected when
the loop finishes since the loop returns the exit code of the last
command it ran on the final iteration, which may not be the command
which failed. Therefore, detect and signal failures manually within
loops using the idiom `|| return 1` (or `|| exit 1` within subshells).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4001-diff-rename.sh          |  2 +-
 t/t4012-diff-binary.sh          |  2 +-
 t/t4014-format-patch.sh         |  6 +++---
 t/t4015-diff-whitespace.sh      |  4 ++--
 t/t4018-diff-funcname.sh        |  2 +-
 t/t4024-diff-optimize-common.sh |  2 +-
 t/t4038-diff-combined.sh        |  2 +-
 t/t4046-diff-unmerged.sh        |  8 ++++----
 t/t4049-diff-stat-count.sh      |  2 +-
 t/t4052-stat-output.sh          |  2 +-
 t/t4057-diff-combined-paths.sh  | 16 ++++++++--------
 t/t4124-apply-ws-rule.sh        |  4 ++--
 t/t4138-apply-ws-expansion.sh   | 16 ++++++++--------
 t/t4205-log-pretty-formats.sh   |  2 +-
 t/t4211-line-log.sh             |  2 +-
 t/t4216-log-bloom.sh            |  4 ++--
 16 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 68f2ebca58..3dc9047044 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -174,7 +174,7 @@ test_expect_success 'setup for many rename source candidates' '
 	do
 		for j in 0 1 2 3 4 5 6 7 8 9;
 		do
-			echo "$i$j" >"path$i$j"
+			echo "$i$j" >"path$i$j" || return 1
 		done
 	done &&
 	git add "path??" &&
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 33ff588ebc..b0f16ff5c0 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -122,7 +122,7 @@ test_expect_success 'diff --stat with binary files and big change count' '
 	i=0 &&
 	while test $i -lt 10000; do
 		echo $i &&
-		i=$(($i + 1))
+		i=$(($i + 1)) || return 1
 	done >textfile &&
 	git add textfile &&
 	git diff --cached --stat binfile textfile >output &&
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index eefe815fca..7dc5a5c736 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -325,7 +325,7 @@ test_expect_success 'filename length limit' '
 		max=$(
 			for patch in 000[1-9]-*.patch
 			do
-				echo "$patch" | wc -c
+				echo "$patch" | wc -c || exit 1
 			done |
 			sort -nr |
 			head -n 1
@@ -343,7 +343,7 @@ test_expect_success 'filename length limit from config' '
 		max=$(
 			for patch in 000[1-9]-*.patch
 			do
-				echo "$patch" | wc -c
+				echo "$patch" | wc -c || exit 1
 			done |
 			sort -nr |
 			head -n 1
@@ -361,7 +361,7 @@ test_expect_success 'filename limit applies only to basename' '
 		max=$(
 			for patch in patches/000[1-9]-*.patch
 			do
-				echo "${patch#patches/}" | wc -c
+				echo "${patch#patches/}" | wc -c || exit 1
 			done |
 			sort -nr |
 			head -n 1
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 2c13b62d3c..ca5adabe14 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -843,7 +843,7 @@ test_expect_success 'whitespace changes with modification reported (diffstat)' '
 
 test_expect_success 'whitespace-only changes reported across renames (diffstat)' '
 	git reset --hard &&
-	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
+	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i" || return 1; done >x &&
 	git add x &&
 	git commit -m "base" &&
 	sed -e "5s/^/ /" x >z &&
@@ -859,7 +859,7 @@ test_expect_success 'whitespace-only changes reported across renames (diffstat)'
 
 test_expect_success 'whitespace-only changes reported across renames' '
 	git reset --hard HEAD~1 &&
-	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
+	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i" || return 1; done >x &&
 	git add x &&
 	hash_x=$(git hash-object x) &&
 	before=$(git rev-parse --short "$hash_x") &&
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 740696c8f7..42a2b9a13b 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -75,7 +75,7 @@ test_expect_success 'last regexp must not be negated' '
 test_expect_success 'setup hunk header tests' '
 	for i in $diffpatterns
 	do
-		echo "$i-* diff=$i"
+		echo "$i-* diff=$i" || return 1
 	done > .gitattributes &&
 
 	# add all test files to the index
diff --git a/t/t4024-diff-optimize-common.sh b/t/t4024-diff-optimize-common.sh
index 6b44ce1493..b98ac0a0c0 100755
--- a/t/t4024-diff-optimize-common.sh
+++ b/t/t4024-diff-optimize-common.sh
@@ -148,7 +148,7 @@ test_expect_success 'diff -U0' '
 
 	for n in $sample
 	do
-		git diff -U0 file-?$n
+		git diff -U0 file-?$n || return 1
 	done | zc >actual &&
 	test_cmp expect actual
 
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index aeac203c42..9a292bac70 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -100,7 +100,7 @@ test_expect_success 'setup for --cc --raw' '
 	for i in $(test_seq 1 40)
 	do
 		blob=$(echo file$i | git hash-object --stdin -w) &&
-		trees="$trees$(echo "100644 blob $blob	file" | git mktree)$LF"
+		trees="$trees$(echo "100644 blob $blob	file" | git mktree)$LF" || return 1
 	done
 '
 
diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
index 8c3d48e257..1828a72e0b 100755
--- a/t/t4046-diff-unmerged.sh
+++ b/t/t4046-diff-unmerged.sh
@@ -37,7 +37,7 @@ test_expect_success 'diff-files -0' '
 	for path in $paths
 	do
 		>"$path" &&
-		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$path"
+		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$path" || return 1
 	done >diff-files-0.expect &&
 	git diff-files -0 >diff-files-0.actual &&
 	test_cmp diff-files-0.expect diff-files-0.actual
@@ -50,7 +50,7 @@ test_expect_success 'diff-files -1' '
 		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$path" &&
 		case "$path" in
 		x??) echo ":100644 100644 $blob1 $ZERO_OID M	$path"
-		esac
+		esac || return 1
 	done >diff-files-1.expect &&
 	git diff-files -1 >diff-files-1.actual &&
 	test_cmp diff-files-1.expect diff-files-1.actual
@@ -63,7 +63,7 @@ test_expect_success 'diff-files -2' '
 		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$path" &&
 		case "$path" in
 		?x?) echo ":100644 100644 $blob2 $ZERO_OID M	$path"
-		esac
+		esac || return 1
 	done >diff-files-2.expect &&
 	git diff-files -2 >diff-files-2.actual &&
 	test_cmp diff-files-2.expect diff-files-2.actual &&
@@ -78,7 +78,7 @@ test_expect_success 'diff-files -3' '
 		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$path" &&
 		case "$path" in
 		??x) echo ":100644 100644 $blob3 $ZERO_OID M	$path"
-		esac
+		esac || return 1
 	done >diff-files-3.expect &&
 	git diff-files -3 >diff-files-3.actual &&
 	test_cmp diff-files-3.expect diff-files-3.actual
diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index 53061b104e..e74baa0635 100755
--- a/t/t4049-diff-stat-count.sh
+++ b/t/t4049-diff-stat-count.sh
@@ -51,7 +51,7 @@ test_expect_success 'exclude unmerged entries from total file count' '
 	git rm -f d &&
 	for stage in 1 2 3
 	do
-		sed -e "s/ 0	a/ $stage	d/" x
+		sed -e "s/ 0	a/ $stage	d/" x || return 1
 	done |
 	git update-index --index-info &&
 	echo d >d &&
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 9eba436211..b5c281edaa 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -101,7 +101,7 @@ test_expect_success 'preparation for big change tests' '
 	i=0 &&
 	while test $i -lt 1000
 	do
-		echo $i && i=$(($i + 1))
+		echo $i && i=$(($i + 1)) || return 1
 	done >abcd &&
 	git commit -m message abcd
 '
diff --git a/t/t4057-diff-combined-paths.sh b/t/t4057-diff-combined-paths.sh
index 7e5b74f72e..04b8a1542a 100755
--- a/t/t4057-diff-combined-paths.sh
+++ b/t/t4057-diff-combined-paths.sh
@@ -18,13 +18,13 @@ test_expect_success 'trivial merge - combine-diff empty' '
 	for i in $(test_seq 1 9)
 	do
 		echo $i >$i.txt &&
-		git add $i.txt
+		git add $i.txt || return 1
 	done &&
 	git commit -m "init" &&
 	git checkout -b side &&
 	for i in $(test_seq 2 9)
 	do
-		echo $i/2 >>$i.txt
+		echo $i/2 >>$i.txt || return 1
 	done &&
 	git commit -a -m "side 2-9" &&
 	git checkout main &&
@@ -40,14 +40,14 @@ test_expect_success 'only one truly conflicting path' '
 	git checkout side &&
 	for i in $(test_seq 2 9)
 	do
-		echo $i/3 >>$i.txt
+		echo $i/3 >>$i.txt || return 1
 	done &&
 	echo "4side" >>4.txt &&
 	git commit -a -m "side 2-9 +4" &&
 	git checkout main &&
 	for i in $(test_seq 1 9)
 	do
-		echo $i/3 >>$i.txt
+		echo $i/3 >>$i.txt || return 1
 	done &&
 	echo "4main" >>4.txt &&
 	git commit -a -m "main 1-9 +4" &&
@@ -69,13 +69,13 @@ test_expect_success 'merge introduces new file' '
 	git checkout side &&
 	for i in $(test_seq 5 9)
 	do
-		echo $i/4 >>$i.txt
+		echo $i/4 >>$i.txt || return 1
 	done &&
 	git commit -a -m "side 5-9" &&
 	git checkout main &&
 	for i in $(test_seq 1 3)
 	do
-		echo $i/4 >>$i.txt
+		echo $i/4 >>$i.txt || return 1
 	done &&
 	git commit -a -m "main 1-3 +4hello" &&
 	git merge side &&
@@ -90,13 +90,13 @@ test_expect_success 'merge removed a file' '
 	git checkout side &&
 	for i in $(test_seq 5 9)
 	do
-		echo $i/5 >>$i.txt
+		echo $i/5 >>$i.txt || return 1
 	done &&
 	git commit -a -m "side 5-9" &&
 	git checkout main &&
 	for i in $(test_seq 1 3)
 	do
-		echo $i/4 >>$i.txt
+		echo $i/4 >>$i.txt || return 1
 	done &&
 	git commit -a -m "main 1-3" &&
 	git merge side &&
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index ec5c10d2a0..485c7d2d12 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -333,7 +333,7 @@ test_expect_success 'applying beyond EOF requires one non-blank context line' '
 
 test_expect_success 'tons of blanks at EOF should not apply' '
 	for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16; do
-		test_write_lines "" "" "" ""
+		test_write_lines "" "" "" "" || return 1
 	done >one &&
 	git add one &&
 	echo a >>one &&
@@ -396,7 +396,7 @@ test_expect_success 'shrink file with tons of missing blanks at end of file' '
 	test_write_lines a b c >one &&
 	cp one no-blank-lines &&
 	for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16; do
-		test_write_lines "" "" "" ""
+		test_write_lines "" "" "" "" || return 1
 	done >>one &&
 	git add one &&
 	echo a >one &&
diff --git a/t/t4138-apply-ws-expansion.sh b/t/t4138-apply-ws-expansion.sh
index 4ba52bbb61..8bbf8260fa 100755
--- a/t/t4138-apply-ws-expansion.sh
+++ b/t/t4138-apply-ws-expansion.sh
@@ -30,7 +30,7 @@ test_expect_success setup '
 	while test $x -lt $n
 	do
 		printf "%63s%d\n" "" $x >>after &&
-		x=$(( $x + 1 ))
+		x=$(( $x + 1 )) || return 1
 	done &&
 	printf "\t%s\n" d e f >>after &&
 	test_expect_code 1 git diff --no-index before after >patch2.patch.raw &&
@@ -41,7 +41,7 @@ test_expect_success setup '
 	while test $x -lt $n
 	do
 		printf "%63s%d\n" "" $x >>expect-2 &&
-		x=$(( $x + 1 ))
+		x=$(( $x + 1 )) || return 1
 	done &&
 	printf "%64s\n" d e f >>expect-2 &&
 
@@ -53,7 +53,7 @@ test_expect_success setup '
 	while test $x -lt $n
 	do
 		printf "%63s%02d\n" "" $x >>after &&
-		x=$(( $x + 1 ))
+		x=$(( $x + 1 )) || return 1
 	done &&
 	printf "\t%s\n" d e f >>after &&
 	test_expect_code 1 git diff --no-index before after >patch3.patch.raw &&
@@ -64,7 +64,7 @@ test_expect_success setup '
 	while test $x -lt $n
 	do
 		printf "%63s%02d\n" "" $x >>expect-3 &&
-		x=$(( $x + 1 ))
+		x=$(( $x + 1 )) || return 1
 	done &&
 	printf "%64s\n" d e f >>expect-3 &&
 
@@ -74,7 +74,7 @@ test_expect_success setup '
 	while test $x -lt 50
 	do
 		printf "\t%02d\n" $x >>before &&
-		x=$(( $x + 1 ))
+		x=$(( $x + 1 )) || return 1
 	done &&
 	cat before >after &&
 	printf "%64s\n" a b c >>after &&
@@ -82,7 +82,7 @@ test_expect_success setup '
 	do
 		printf "\t%02d\n" $x >>before &&
 		printf "\t%02d\n" $x >>after &&
-		x=$(( $x + 1 ))
+		x=$(( $x + 1 )) || return 1
 	done &&
 	test_expect_code 1 git diff --no-index before after >patch4.patch.raw &&
 	sed -e "s/before/test-4/" -e "s/after/test-4/" patch4.patch.raw >patch4.patch &&
@@ -91,7 +91,7 @@ test_expect_success setup '
 	while test $x -lt 50
 	do
 		printf "%63s%02d\n" "" $x >>test-4 &&
-		x=$(( $x + 1 ))
+		x=$(( $x + 1 )) || return 1
 	done &&
 	cat test-4 >expect-4 &&
 	printf "%64s\n" a b c >>expect-4 &&
@@ -99,7 +99,7 @@ test_expect_success setup '
 	do
 		printf "%63s%02d\n" "" $x >>test-4 &&
 		printf "%63s%02d\n" "" $x >>expect-4 &&
-		x=$(( $x + 1 ))
+		x=$(( $x + 1 )) || return 1
 	done &&
 
 	git config core.whitespace tab-in-indent,tabwidth=63 &&
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 5865daa8f8..f4ce7c59a4 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -976,7 +976,7 @@ test_expect_success '%(describe) vs git describe' '
 		else
 			: >expect-contains-bad
 		fi &&
-		echo "$hash $desc"
+		echo "$hash $desc" || return 1
 	done >expect &&
 	test_path_exists expect-contains-good &&
 	test_path_exists expect-contains-bad &&
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 560127cc07..ac9e4d0928 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -137,7 +137,7 @@ test_expect_success 'range_set_union' '
 	test_seq 1000 > c.c &&
 	git add c.c &&
 	git commit -m "modify many lines" &&
-	git log $(for x in $(test_seq 200); do echo -L $((2*x)),+1:c.c; done)
+	git log $(for x in $(test_seq 200); do echo -L $((2*x)),+1:c.c || return 1; done)
 '
 
 test_expect_success '-s shows only line-log commits' '
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 50f206db55..41355f038b 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -376,7 +376,7 @@ test_expect_success 'Bloom generation backfills empty commits' '
 		cd empty &&
 		for i in $(test_seq 1 6)
 		do
-			git commit --allow-empty -m "$i"
+			git commit --allow-empty -m "$i" || return 1
 		done &&
 
 		# Generate Bloom filters for empty commits 1-6, two at a time.
@@ -389,7 +389,7 @@ test_expect_success 'Bloom generation backfills empty commits' '
 			test_filter_computed 2 trace.event &&
 			test_filter_not_computed 4 trace.event &&
 			test_filter_trunc_empty 2 trace.event &&
-			test_filter_trunc_large 0 trace.event
+			test_filter_trunc_large 0 trace.event || return 1
 		done &&
 
 		# Finally, make sure that once all commits have filters, that
-- 
2.34.1.307.g9b7440fafd

