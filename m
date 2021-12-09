Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB24C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhLIFQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhLIFPz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:55 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFD3C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:22 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id j21so4285064ila.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZSLvVyqlhyLhN2hJhtHaAmNqkZMJh68pgYcAbufdHXQ=;
        b=pcc9KdyitaqxO1QrkWVA8G8t4SaVjE2MAlSnkYbC6sAMkJgzVUFeKfykzz+NzV87NW
         bfUoN1M07kSscgoHpYLSBSG2E5ykqFUKhkuUg6VmSW3mA7CUwCIgxT7KGHf1t8D9WYJf
         aMUngbzs6KfUVq4sqiOLsK1eYmxAilDE/OJHZDbDpegj/8zswfgjvNMpqz8vC0QGQvRb
         uEfpLaHKYvYTaTpCOfHwUL+yUFWMDRycyXOvyhsfnz/VJ4fuVA9+nyWG/nzNYyTyKfHU
         B2pL8YxpfdZ1fXrHY58qzrmJPF/yKtziHc8iuDHq3pgUJhwwjKnbONAz2aA0j0kpdF5w
         Wp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZSLvVyqlhyLhN2hJhtHaAmNqkZMJh68pgYcAbufdHXQ=;
        b=GBlBGjOcWfsNXgkrsibHLX+x7qf6TZCo0OloHuSnFNNR1HcbG3SiZO0Rc/IubI1Ubx
         hBGlCa7sRT7nybKFRpQonhe2Xd85pUljFYsEiY0z1yD9YbRPRgrPRngSBGnsDsEcGZQ4
         H8xGR6Zm6NX2Jd4aD7kwpwGHgLwdFdijx1MaE0gVtv/iu0kpl9vZrlmZh160lW5IcE+V
         GkXJRd46feDZPk9tLQHv4skx9L4L1vTpq8qRSvfs72LnK1fAX6urnbBjgFbcpogZQiMA
         INETKH8eF5tjW60jh1gg3PGY5qJDc3hJLlh1jvKD9k1UfBx3c8sQ2B1mMCtM/wBmq9y+
         QaIA==
X-Gm-Message-State: AOAM533vIpEtW3eyou1R7WYM0w/mHSDOvaMl6G4HTEBxk2oROzGIe4Xg
        ecbz30rI6iNrEwMBZ1Tcu+DKU1skCAYR8g==
X-Google-Smtp-Source: ABdhPJz00ZI9y03ze3mRy0zrL4P0kme7m7zW/GbQgRMEFEOt11xh5I/U7cqVfpZuH+GV01aQLr56dg==
X-Received: by 2002:a05:6e02:110f:: with SMTP id u15mr10442616ilk.17.1639026741462;
        Wed, 08 Dec 2021 21:12:21 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:20 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 18/19] t5000-t5999: detect and signal failure within loop
Date:   Thu,  9 Dec 2021 00:11:14 -0500
Message-Id: <20211209051115.52629-19-sunshine@sunshineco.com>
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
 t/t5000-tar-tree.sh                    |  4 ++--
 t/t5003-archive-zip.sh                 |  2 +-
 t/t5004-archive-corner-cases.sh        |  6 +++---
 t/t5100-mailinfo.sh                    |  2 +-
 t/t5300-pack-object.sh                 |  6 +++---
 t/t5307-pack-missing-commit.sh         |  2 +-
 t/t5310-pack-bitmaps.sh                |  2 +-
 t/t5317-pack-objects-filter-objects.sh | 10 +++++-----
 t/t5318-commit-graph.sh                |  6 +++---
 t/t5319-multi-pack-index.sh            | 10 +++++-----
 t/t5322-pack-objects-sparse.sh         |  4 ++--
 t/t5325-reverse-index.sh               |  2 +-
 t/t5500-fetch-pack.sh                  |  8 ++++----
 t/t5502-quickfetch.sh                  |  2 +-
 t/t5510-fetch.sh                       |  2 +-
 t/t5515-fetch-merge-logic.sh           |  4 ++--
 t/t5552-skipping-fetch-negotiator.sh   | 10 +++++-----
 t/t5571-pre-push-hook.sh               |  2 +-
 t/t5616-partial-clone.sh               | 12 ++++++------
 t/t5702-protocol-v2.sh                 |  4 ++--
 20 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 2c88d1c159..7f8d2ab0a7 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -77,7 +77,7 @@ check_tar() {
 					path=$(get_pax_header $header path) &&
 					if test -n "$path"
 					then
-						mv "$data" "$path"
+						mv "$data" "$path" || exit 1
 					fi
 				fi
 			done
@@ -133,7 +133,7 @@ test_expect_success 'populate workdir' '
 		for depth in 1 2 3 4 5
 		do
 			mkdir $p &&
-			cd $p
+			cd $p || exit 1
 		done &&
 		echo text >file_with_long_path
 	) &&
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 1e6d18b140..d726964307 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -106,7 +106,7 @@ test_expect_success \
      printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
      printf "A not substituted O" >a/substfile2 &&
      (p=long_path_to_a_file && cd a &&
-      for depth in 1 2 3 4 5; do mkdir $p && cd $p; done &&
+      for depth in 1 2 3 4 5; do mkdir $p && cd $p || exit 1; done &&
       echo text >file_with_long_path)
 '
 
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 2d32d0ed12..ae508e2162 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -131,7 +131,7 @@ test_expect_success ZIPINFO 'zip archive with many entries' '
 	do
 		for b in 0 1 2 3 4 5 6 7 8 9 a b c d e f
 		do
-			: >00/$a$b
+			: >00/$a$b || return 1
 		done
 	done &&
 	git add 00 &&
@@ -143,7 +143,7 @@ test_expect_success ZIPINFO 'zip archive with many entries' '
 	do
 		for d in 0 1 2 3 4 5 6 7 8 9 a b c d e f
 		do
-			echo "040000 tree $subtree	$c$d"
+			echo "040000 tree $subtree	$c$d" || return 1
 		done
 	done >tree &&
 	tree=$(git mktree <tree) &&
@@ -171,7 +171,7 @@ test_expect_success EXPENSIVE,UNZIP,UNZIP_ZIP64_SUPPORT \
 	# create tree containing 65500 entries of that blob
 	for i in $(test_seq 1 65500)
 	do
-		echo "100644 blob $blob	$i"
+		echo "100644 blob $blob	$i" || return 1
 	done >tree &&
 	tree=$(git mktree <tree) &&
 
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 141b29f031..cebad1048c 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -122,7 +122,7 @@ test_expect_success 'mailinfo unescapes with --mboxrd' '
 	do
 		git mailinfo mboxrd/msg mboxrd/patch \
 		  <mboxrd/$i >mboxrd/out &&
-		test_cmp "$DATA/${i}mboxrd" mboxrd/msg
+		test_cmp "$DATA/${i}mboxrd" mboxrd/msg || return 1
 	done &&
 	sp=" " &&
 	echo "From " >expect &&
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index f9877d42d7..2fd845187e 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -347,7 +347,7 @@ test_expect_success 'unpacking with --strict' '
 		for i in 0 1 2 3 4 5 6 7 8 9
 		do
 			o=$(echo $j$i | git hash-object -w --stdin) &&
-			echo "100644 $o	0 $j$i"
+			echo "100644 $o	0 $j$i" || return 1
 		done
 	done >LIST &&
 	rm -f .git/index &&
@@ -390,7 +390,7 @@ test_expect_success 'index-pack with --strict' '
 		for i in 0 1 2 3 4 5 6 7 8 9
 		do
 			o=$(echo $j$i | git hash-object -w --stdin) &&
-			echo "100644 $o	0 $j$i"
+			echo "100644 $o	0 $j$i" || return 1
 		done
 	done >LIST &&
 	rm -f .git/index &&
@@ -586,7 +586,7 @@ test_expect_success 'setup for --stdin-packs tests' '
 		for id in A B C
 		do
 			git pack-objects .git/objects/pack/pack-$id \
-				--incremental --revs <<-EOF
+				--incremental --revs <<-EOF || exit 1
 			refs/tags/$id
 			EOF
 		done &&
diff --git a/t/t5307-pack-missing-commit.sh b/t/t5307-pack-missing-commit.sh
index f4338abb78..fa4bc269fe 100755
--- a/t/t5307-pack-missing-commit.sh
+++ b/t/t5307-pack-missing-commit.sh
@@ -11,7 +11,7 @@ test_expect_success setup '
 		git add "file$i" &&
 		test_tick &&
 		git commit -m "$i" &&
-		git tag "tag$i"
+		git tag "tag$i" || return 1
 	done &&
 	obj=$(git rev-parse --verify tag3) &&
 	fanout=$(expr "$obj" : "\(..\)") &&
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index dcf03d324a..783cd96290 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -230,7 +230,7 @@ test_expect_success 'pack reuse respects --honor-pack-keep' '
 	test_when_finished "rm -f .git/objects/pack/*.keep" &&
 	for i in .git/objects/pack/*.pack
 	do
-		>${i%.pack}.keep
+		>${i%.pack}.keep || return 1
 	done &&
 	reusable_pack --honor-pack-keep >empty.pack &&
 	git index-pack empty.pack &&
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 8fb6acae47..33b740ce62 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -18,7 +18,7 @@ test_expect_success 'setup r1' '
 	do
 		echo "This is file: $n" > r1/file.$n &&
 		git -C r1 add file.$n &&
-		git -C r1 commit -m "$n"
+		git -C r1 commit -m "$n" || return 1
 	done
 '
 
@@ -118,7 +118,7 @@ test_expect_success 'setup r2' '
 	do
 		printf "%"$n"s" X > r2/large.$n &&
 		git -C r2 add large.$n &&
-		git -C r2 commit -m "$n"
+		git -C r2 commit -m "$n" || return 1
 	done
 '
 
@@ -281,7 +281,7 @@ test_expect_success 'setup r3' '
 		echo "This is file: $n" > r3/$n &&
 		git -C r3 add $n &&
 		echo "This is file: dir1/$n" > r3/dir1/$n &&
-		git -C r3 add dir1/$n
+		git -C r3 add dir1/$n || return 1
 	done &&
 	git -C r3 commit -m "sparse" &&
 	echo dir1/ >pattern1 &&
@@ -334,7 +334,7 @@ test_expect_success 'setup r4' '
 		echo "This is file: $n" > r4/$n &&
 		git -C r4 add $n &&
 		echo "This is file: dir1/$n" > r4/dir1/$n &&
-		git -C r4 add dir1/$n
+		git -C r4 add dir1/$n || return 1
 	done &&
 	echo dir1/ >r4/pattern &&
 	git -C r4 add pattern &&
@@ -409,7 +409,7 @@ test_expect_success 'setup r1 - delete loose blobs' '
 
 	for id in `cat expected | sed "s|..|&/|"`
 	do
-		rm r1/.git/objects/$id
+		rm r1/.git/objects/$id || return 1
 	done
 '
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index f516fda7cc..edb728f77c 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -64,7 +64,7 @@ test_expect_success 'create commits and repack' '
 	for i in $(test_seq 3)
 	do
 		test_commit $i &&
-		git branch commits/$i
+		git branch commits/$i || return 1
 	done &&
 	git repack
 '
@@ -147,13 +147,13 @@ test_expect_success 'Add more commits' '
 	for i in $(test_seq 4 5)
 	do
 		test_commit $i &&
-		git branch commits/$i
+		git branch commits/$i || return 1
 	done &&
 	git reset --hard commits/2 &&
 	for i in $(test_seq 6 7)
 	do
 		test_commit $i &&
-		git branch commits/$i
+		git branch commits/$i || return 1
 	done &&
 	git reset --hard commits/2 &&
 	git merge commits/4 &&
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 3f69e43178..86b0372dc8 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -93,7 +93,7 @@ test_expect_success 'create objects' '
 	test_commit initial &&
 	for i in $(test_seq 1 5)
 	do
-		generate_objects $i
+		generate_objects $i || return 1
 	done &&
 	commit_and_list_objects
 '
@@ -155,7 +155,7 @@ test_expect_success 'corrupt idx reports errors' '
 test_expect_success 'add more objects' '
 	for i in $(test_seq 6 10)
 	do
-		generate_objects $i
+		generate_objects $i || return 1
 	done &&
 	commit_and_list_objects
 '
@@ -203,7 +203,7 @@ test_expect_success 'add more packs' '
 	do
 		generate_objects $j &&
 		commit_and_list_objects &&
-		git pack-objects --index-version=2 $objdir/pack/test-pack <obj-list
+		git pack-objects --index-version=2 $objdir/pack/test-pack <obj-list || return 1
 	done
 '
 
@@ -594,7 +594,7 @@ test_expect_success 'force some 64-bit offsets with pack-objects' '
 	mkdir objects64/pack &&
 	for i in $(test_seq 1 11)
 	do
-		generate_objects 11
+		generate_objects 11 || return 1
 	done &&
 	commit_and_list_objects &&
 	pack64=$(git pack-objects --index-version=2,0x40 objects64/pack/test-64 <obj-list) &&
@@ -638,7 +638,7 @@ test_expect_success 'setup expire tests' '
 		git update-index --add large_file.txt &&
 		for i in $(test_seq 1 20)
 		do
-			test_commit $i
+			test_commit $i || exit 1
 		done &&
 		git branch A HEAD &&
 		git branch B HEAD~8 &&
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index 61cb907a90..d39958c066 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -14,7 +14,7 @@ test_expect_success 'setup repo' '
 		for j in $(test_seq 1 3)
 		do
 			mkdir f$i/f$j &&
-			echo $j >f$i/f$j/data.txt
+			echo $j >f$i/f$j/data.txt || return 1
 		done
 	done &&
 	git add . &&
@@ -23,7 +23,7 @@ test_expect_success 'setup repo' '
 	do
 		git checkout -b topic$i main &&
 		echo change-$i >f$i/f$i/data.txt &&
-		git commit -a -m "Changed f$i/f$i/data.txt"
+		git commit -a -m "Changed f$i/f$i/data.txt" || return 1
 	done &&
 	cat >packinput.txt <<-EOF &&
 	topic1
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index da453f68d6..d042d26f2b 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -46,7 +46,7 @@ test_expect_success 'index-pack with --[no-]rev-index' '
 		test_path_exists $rev &&
 
 		test_index_pack "$conf" --no-rev-index &&
-		test_path_is_missing $rev
+		test_path_is_missing $rev || return 1
 	done
 '
 
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 8a5d3492c7..f0dc4e6968 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -95,7 +95,7 @@ test_expect_success 'setup' '
 	while [ $cur -le 10 ]; do
 		add A$cur $(eval echo \$A$prev) &&
 		prev=$cur &&
-		cur=$(($cur+1))
+		cur=$(($cur+1)) || return 1
 	done &&
 	add B1 $A1 &&
 	git update-ref refs/heads/A "$ATIP" &&
@@ -112,7 +112,7 @@ test_expect_success 'post 1st pull setup' '
 	while [ $cur -le 65 ]; do
 		add B$cur $(eval echo \$B$prev) &&
 		prev=$cur &&
-		cur=$(($cur+1))
+		cur=$(($cur+1)) || return 1
 	done
 '
 
@@ -464,11 +464,11 @@ test_expect_success 'fetch creating new shallow root' '
 test_expect_success 'setup tests for the --stdin parameter' '
 	for head in C D E F
 	do
-		add $head
+		add $head || return 1
 	done &&
 	for head in A B C D E F
 	do
-		git tag $head $head
+		git tag $head $head || return 1
 	done &&
 	cat >input <<-\EOF &&
 	refs/heads/C
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index 8c05c7715b..b160f8b7fb 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -130,7 +130,7 @@ test_expect_success 'quickfetch should handle ~1000 refs (on Windows)' '
 	for i in 0 1 2 3 4 5 6 7 8 9; do
 		for j in 0 1 2 3 4 5 6 7 8 9; do
 			for k in 0 1 2 3 4 5 6 7 8 9; do
-				echo "$branchprefix$i$j$k" >> .git/packed-refs
+				echo "$branchprefix$i$j$k" >> .git/packed-refs || return 1
 			done
 		done
 	done &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 01468ce6d8..ce18c20acd 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -550,7 +550,7 @@ test_expect_success 'bundle should record HEAD correctly' '
 	git bundle list-heads bundle5 >actual &&
 	for h in HEAD refs/heads/main
 	do
-		echo "$(git rev-parse --verify $h) $h"
+		echo "$(git rev-parse --verify $h) $h" || return 1
 	done >expect &&
 	test_cmp expect actual
 
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index c69cfd5c64..320d26796d 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -133,7 +133,7 @@ test_expect_success setup '
 		git config branch.br-$remote-merge.merge refs/heads/three &&
 		git config branch.br-$remote-octopus.remote $remote &&
 		git config branch.br-$remote-octopus.merge refs/heads/one &&
-		git config --add branch.br-$remote-octopus.merge two
+		git config --add branch.br-$remote-octopus.merge two || return 1
 	done &&
 	build_script sed_script
 '
@@ -199,7 +199,7 @@ do
 				refs/heads refs/remotes/rem refs/tags |
 			while read val type refname
 			do
-				git update-ref -d "$refname" "$val"
+				git update-ref -d "$refname" "$val" || return 1
 			done &&
 			git fetch "$@" >/dev/null &&
 			cat .git/FETCH_HEAD
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 7b9fb4ff02..165427d57e 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -48,7 +48,7 @@ test_expect_success 'commits with no parents are sent regardless of skip distanc
 	git init client &&
 	for i in $(test_seq 7)
 	do
-		test_commit -C client c$i
+		test_commit -C client c$i || return 1
 	done &&
 
 	# We send: "c7" (skip 1) "c5" (skip 2) "c2" (skip 4). After that, since
@@ -68,7 +68,7 @@ test_expect_success 'when two skips collide, favor the larger one' '
 	git init client &&
 	for i in $(test_seq 11)
 	do
-		test_commit -C client c$i
+		test_commit -C client c$i || return 1
 	done &&
 	git -C client checkout c5 &&
 	test_commit -C client c5side &&
@@ -155,14 +155,14 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
 	for i in $(test_seq 8)
 	do
 		git -C client checkout --orphan b$i &&
-		test_commit -C client b$i.c0
+		test_commit -C client b$i.c0 || return 1
 	done &&
 	for j in $(test_seq 19)
 	do
 		for i in $(test_seq 8)
 		do
 			git -C client checkout b$i &&
-			test_commit -C client b$i.c$j
+			test_commit -C client b$i.c$j || return 1
 		done
 	done &&
 
@@ -201,7 +201,7 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
 	# should still send the others (in this test, just check b2).
 	for i in $(test_seq 0 8)
 	do
-		have_not_sent b1.c$i
+		have_not_sent b1.c$i || return 1
 	done &&
 	have_sent b2.c1 b2.c0
 '
diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index 80e86d8284..660f876eec 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -118,7 +118,7 @@ test_expect_success 'set up many-ref tests' '
 		while test $nr -lt 2000
 		do
 			nr=$(( $nr + 1 )) &&
-			echo "create refs/heads/b/$nr $COMMIT3"
+			echo "create refs/heads/b/$nr $COMMIT3" || return 1
 		done
 	} | git update-ref --stdin
 '
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 23c156e399..34469b6ac1 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -19,7 +19,7 @@ test_expect_success 'setup normal src repo' '
 		echo "This is file: $n" > src/file.$n.txt &&
 		git -C src add file.$n.txt &&
 		git -C src commit -m "file $n" &&
-		git -C src ls-files -s file.$n.txt >>temp
+		git -C src ls-files -s file.$n.txt >>temp || return 1
 	done &&
 	awk -f print_2.awk <temp | sort >expect_1.oids &&
 	test_line_count = 4 expect_1.oids
@@ -74,7 +74,7 @@ test_expect_success 'push new commits to server' '
 	do
 		echo "Mod file.1.txt $x" >>src/file.1.txt &&
 		git -C src add file.1.txt &&
-		git -C src commit -m "mod $x"
+		git -C src commit -m "mod $x" || return 1
 	done &&
 	git -C src blame main -- file.1.txt >expect.blame &&
 	git -C src push -u srv main
@@ -116,7 +116,7 @@ test_expect_success 'push new commits to server for file.2.txt' '
 	do
 		echo "Mod file.2.txt $x" >>src/file.2.txt &&
 		git -C src add file.2.txt &&
-		git -C src commit -m "mod $x"
+		git -C src commit -m "mod $x" || return 1
 	done &&
 	git -C src push -u srv main
 '
@@ -137,7 +137,7 @@ test_expect_success 'push new commits to server for file.3.txt' '
 	do
 		echo "Mod file.3.txt $x" >>src/file.3.txt &&
 		git -C src add file.3.txt &&
-		git -C src commit -m "mod $x"
+		git -C src commit -m "mod $x" || return 1
 	done &&
 	git -C src push -u srv main
 '
@@ -385,7 +385,7 @@ setup_triangle () {
 	for i in $(test_seq 1 100)
 	do
 		echo "make the tree big" >server/file$i &&
-		git -C server add file$i
+		git -C server add file$i || return 1
 	done &&
 	git -C server commit -m "initial" &&
 	git clone --bare --filter=tree:0 "file://$(pwd)/server" client &&
@@ -669,7 +669,7 @@ test_expect_success 'tolerate server sending REF_DELTA against missing promisor
 	for i in $(test_seq 10)
 	do
 		echo "this is a line" >>"$SERVER/foo.txt" &&
-		echo "this is another line" >>"$SERVER/have.txt"
+		echo "this is another line" >>"$SERVER/have.txt" || return 1
 	done &&
 	git -C "$SERVER" add foo.txt have.txt &&
 	git -C "$SERVER" commit -m bar &&
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index d527cf6c49..ed8a071961 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -747,7 +747,7 @@ test_expect_success 'clone big repository with http:// using protocol v2' '
 		echo "data 0" &&
 		echo "M 644 inline bla.txt" &&
 		echo "data 4" &&
-		echo "bla"
+		echo "bla" || return 1
 	done | git -C "$HTTPD_DOCUMENT_ROOT_PATH/big" fast-import &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" GIT_TRACE_CURL="$(pwd)/log" git \
@@ -942,7 +942,7 @@ test_expect_success 'part of packfile response provided as URI' '
 			then
 				>h2found
 			fi
-		fi
+		fi || return 1
 	done &&
 	test -f hfound &&
 	test -f h2found &&
-- 
2.34.1.307.g9b7440fafd

