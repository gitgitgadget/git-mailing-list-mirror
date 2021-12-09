Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6F6C4332F
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhLIFP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhLIFPu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:50 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6B8C061353
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:16 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id c3so5334446iob.6
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=homWpia5JvysB5UTNfiNFnYeN1Yh5dSJgxQGW1Pdzbw=;
        b=cwqXnAXTyiCcuChftEcWhunIsK5/OP5zz6OEQdYb4Nk2pWyZeaueavmRGVkNKySQkH
         rJRlV2+WwBHZmWEf0jLyiPsl997k65SwCmKPdJhFN6bg9qyVKUrJUx5QePE2OxtFFgWn
         sfEeGZ3AbQ0G0GEcH0KGkKRMI5gFLZBItSyL/WKIBTFz8yv+1rnhxmD3TgLBgn/LT1Tv
         XOJYa4CgQBaYxHtPgtzYhgYn6989PtDojtlAG8wG1WDpocb4fJQDtA7XvXTuAbZkl5+n
         rAUB8p45RtTVz5AhgmY3ChiGCxE9pg0roZ/LC8SvixsChtMo/r7afCtRoYIKt65q2/3u
         PndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=homWpia5JvysB5UTNfiNFnYeN1Yh5dSJgxQGW1Pdzbw=;
        b=EgtVyuwuD29dZ0EbwNSTTM3a3IMqCcx5RxwvTYBF65Hh2/W5rPT0LaRWF4jmSTummn
         8NayZpulPfouRnlBR6T588qA8g+cMmB9Ec/lFv1GOM+bO6RsQSQg1qaNnD6QCuormjPL
         hfaRrnjspfQLv29u+I1Xt7nSj2AsQZscKi4OhnFafC3c4/Dc/63Mu4EPorGDoifnatWX
         hWtGrUXmqUN67/oG/HT8XBnbKh2TdPa6qsvnnsqAptYWzncZ4FXUa++JMYd5DLNApUcL
         3uMTQlZl0n2qgVjaGsa1yDDsQESW2CFsB8MJqVi1kEUM2jjK03RAXzJGoZmREs1slhCD
         Wywg==
X-Gm-Message-State: AOAM530zaPqfUKs+6CHcZP9ztkt+qGl/U0nLCZEO+UzFRtdhjK43gUB1
        SBxt2ssh9GSwreiDEWJBpRmBF1HSPNwNRg==
X-Google-Smtp-Source: ABdhPJxbs/tVVD4oK5onLNjkzdSKuniAbYYbzoOiCr2cBbSAD44Gh1PEYCULjsxGwlAExvAJ08EatQ==
X-Received: by 2002:a05:6638:2656:: with SMTP id n22mr5914542jat.35.1639026735703;
        Wed, 08 Dec 2021 21:12:15 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:15 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 10/19] tests: fix broken &&-chains in compound statements
Date:   Thu,  9 Dec 2021 00:11:06 -0500
Message-Id: <20211209051115.52629-11-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The top-level &&-chain checker built into t/test-lib.sh causes tests to
magically exit with code 117 if the &&-chain is broken. However, it has
the shortcoming that the magic does not work within `{...}` groups,
`(...)` subshells, `$(...)` substitutions, or within bodies of compound
statements, such as `if`, `for`, `while`, `case`, etc. `chainlint.sed`
partly fills in the gap by catching broken &&-chains in `(...)`
subshells, but bugs can still lurk behind broken &&-chains in the other
cases.

Fix broken &&-chains in compound statements in order to reduce the
number of possible lurking bugs.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/perf/p0005-status.sh                 | 12 ++++++------
 t/perf/p0006-read-tree-checkout.sh     | 20 ++++++++++----------
 t/perf/p0007-write-cache.sh            |  4 ++--
 t/perf/p5302-pack-index.sh             |  2 +-
 t/perf/p5303-many-packs.sh             |  8 ++++----
 t/t1050-large.sh                       |  4 ++--
 t/t1300-config.sh                      |  2 +-
 t/t1700-split-index.sh                 |  4 ++--
 t/t2200-add-update.sh                  |  4 ++--
 t/t3070-wildmatch.sh                   |  2 +-
 t/t3700-add.sh                         |  4 ++--
 t/t4046-diff-unmerged.sh               |  2 +-
 t/t4123-apply-shrink.sh                |  4 ++--
 t/t4138-apply-ws-expansion.sh          | 20 ++++++++++----------
 t/t5302-pack-index.sh                  |  2 +-
 t/t5317-pack-objects-filter-objects.sh | 20 ++++++++++----------
 t/t5571-pre-push-hook.sh               |  2 +-
 t/t5616-partial-clone.sh               | 18 +++++++++---------
 t/t6005-rev-list-count.sh              |  8 ++++----
 t/t6009-rev-list-parent.sh             |  2 +-
 t/t6112-rev-list-filters-objects.sh    | 14 +++++++-------
 t/t6120-describe.sh                    |  7 +++++--
 t/t6407-merge-binary.sh                |  4 ++--
 t/t6412-merge-large-rename.sh          |  2 +-
 t/t7004-tag.sh                         |  7 +++++--
 t/t7519-status-fsmonitor.sh            |  2 +-
 t/t7602-merge-octopus-many.sh          |  2 +-
 t/t9130-git-svn-authors-file.sh        |  2 +-
 28 files changed, 95 insertions(+), 89 deletions(-)

diff --git a/t/perf/p0005-status.sh b/t/perf/p0005-status.sh
index 0b0aa9858f..ca58d6c9b5 100755
--- a/t/perf/p0005-status.sh
+++ b/t/perf/p0005-status.sh
@@ -24,17 +24,17 @@ test_perf_default_repo
 test_expect_success "setup repo" '
 	if git rev-parse --verify refs/heads/p0006-ballast^{commit}
 	then
-		echo Assuming synthetic repo from many-files.sh
-		git branch br_base            master
-		git branch br_ballast         p0006-ballast
-		git config --local core.sparsecheckout 1
+		echo Assuming synthetic repo from many-files.sh &&
+		git branch br_base            master &&
+		git branch br_ballast         p0006-ballast &&
+		git config --local core.sparsecheckout 1 &&
 		cat >.git/info/sparse-checkout <<-EOF
 		/*
 		!ballast/*
 		EOF
 	else
-		echo Assuming non-synthetic repo...
-		git branch br_base            $(git rev-list HEAD | tail -n 1)
+		echo Assuming non-synthetic repo... &&
+		git branch br_base            $(git rev-list HEAD | tail -n 1) &&
 		git branch br_ballast         HEAD
 	fi &&
 	git checkout -q br_ballast &&
diff --git a/t/perf/p0006-read-tree-checkout.sh b/t/perf/p0006-read-tree-checkout.sh
index 78cc23fe2f..900b385c4b 100755
--- a/t/perf/p0006-read-tree-checkout.sh
+++ b/t/perf/p0006-read-tree-checkout.sh
@@ -24,21 +24,21 @@ test_perf_default_repo
 test_expect_success "setup repo" '
 	if git rev-parse --verify refs/heads/p0006-ballast^{commit}
 	then
-		echo Assuming synthetic repo from many-files.sh
-		git branch br_base            master
-		git branch br_ballast         p0006-ballast^
-		git branch br_ballast_alias   p0006-ballast^
-		git branch br_ballast_plus_1  p0006-ballast
-		git config --local core.sparsecheckout 1
+		echo Assuming synthetic repo from many-files.sh &&
+		git branch br_base            master &&
+		git branch br_ballast         p0006-ballast^ &&
+		git branch br_ballast_alias   p0006-ballast^ &&
+		git branch br_ballast_plus_1  p0006-ballast &&
+		git config --local core.sparsecheckout 1 &&
 		cat >.git/info/sparse-checkout <<-EOF
 		/*
 		!ballast/*
 		EOF
 	else
-		echo Assuming non-synthetic repo...
-		git branch br_base            $(git rev-list HEAD | tail -n 1)
-		git branch br_ballast         HEAD^ || error "no ancestor commit from current head"
-		git branch br_ballast_alias   HEAD^
+		echo Assuming non-synthetic repo... &&
+		git branch br_base            $(git rev-list HEAD | tail -n 1) &&
+		git branch br_ballast         HEAD^ || error "no ancestor commit from current head" &&
+		git branch br_ballast_alias   HEAD^ &&
 		git branch br_ballast_plus_1  HEAD
 	fi &&
 	git checkout -q br_ballast &&
diff --git a/t/perf/p0007-write-cache.sh b/t/perf/p0007-write-cache.sh
index 09595264f0..25d8ff7443 100755
--- a/t/perf/p0007-write-cache.sh
+++ b/t/perf/p0007-write-cache.sh
@@ -9,8 +9,8 @@ test_perf_default_repo
 test_expect_success "setup repo" '
 	if git rev-parse --verify refs/heads/p0006-ballast^{commit}
 	then
-		echo Assuming synthetic repo from many-files.sh
-		git config --local core.sparsecheckout 1
+		echo Assuming synthetic repo from many-files.sh &&
+		git config --local core.sparsecheckout 1 &&
 		cat >.git/info/sparse-checkout <<-EOF
 		/*
 		!ballast/*
diff --git a/t/perf/p5302-pack-index.sh b/t/perf/p5302-pack-index.sh
index 228593d9ad..654cd9c86e 100755
--- a/t/perf/p5302-pack-index.sh
+++ b/t/perf/p5302-pack-index.sh
@@ -21,7 +21,7 @@ test_expect_success 'set up thread-counting tests' '
 	threads= &&
 	while test $t -gt 0
 	do
-		threads="$t $threads"
+		threads="$t $threads" &&
 		t=$((t / 2))
 	done
 '
diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
index 35c0cbdf49..58213fe171 100755
--- a/t/perf/p5303-many-packs.sh
+++ b/t/perf/p5303-many-packs.sh
@@ -126,10 +126,10 @@ done
 # Measure pack loading with 10,000 packs.
 test_expect_success 'generate lots of packs' '
 	for i in $(test_seq 10000); do
-		echo "blob"
-		echo "data <<EOF"
-		echo "blob $i"
-		echo "EOF"
+		echo "blob" &&
+		echo "data <<EOF" &&
+		echo "blob $i" &&
+		echo "EOF" &&
 		echo "checkpoint"
 	done |
 	git -c fastimport.unpackLimit=0 fast-import
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 6bc1d76fb1..99ff2866b7 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -54,7 +54,7 @@ test_expect_success 'add a large file or two' '
 	bad= count=0 idx= &&
 	for p in .git/objects/pack/pack-*.pack
 	do
-		count=$(( $count + 1 ))
+		count=$(( $count + 1 )) &&
 		if test_path_is_file "$p" &&
 		   idx=${p%.pack}.idx && test_path_is_file "$idx"
 		then
@@ -78,7 +78,7 @@ test_expect_success 'add a large file or two' '
 	bad= count=0 &&
 	for p in .git/objects/pack/pack-*.pack
 	do
-		count=$(( $count + 1 ))
+		count=$(( $count + 1 )) &&
 		if test_path_is_file "$p" &&
 		   idx=${p%.pack}.idx && test_path_is_file "$idx"
 		then
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9ff46f3b04..9571649c42 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -717,7 +717,7 @@ test_expect_success bool '
 	rm -f result &&
 	for i in 1 2 3 4
 	do
-	    git config --bool --get bool.true$i >>result
+	    git config --bool --get bool.true$i >>result &&
 	    git config --bool --get bool.false$i >>result
 	done &&
 	test_cmp expect result'
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index decd2527ed..b4ab166369 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -48,10 +48,10 @@ test_expect_success 'enable split index' '
 	# NEEDSWORK: Stop hard-coding checksums.
 	if test "$indexversion" = "4"
 	then
-		own=$(test_oid own_v4)
+		own=$(test_oid own_v4) &&
 		base=$(test_oid base_v4)
 	else
-		own=$(test_oid own_v3)
+		own=$(test_oid own_v3) &&
 		base=$(test_oid base_v3)
 	fi &&
 
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 94c4cb0672..67b9cc752f 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -150,8 +150,8 @@ test_expect_success 'add -u resolves unmerged paths' '
 	{
 		for path in path1 path2
 		do
-			echo "100644 $one 1	$path"
-			echo "100644 $two 2	$path"
+			echo "100644 $one 1	$path" &&
+			echo "100644 $two 2	$path" &&
 			echo "100644 $three 3	$path"
 		done
 		echo "100644 $one 1	path3"
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 72d5b014d8..f9539968e4 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -193,7 +193,7 @@ match() {
 		file=$(cat .git/expected_test_file) &&
 		if should_create_test_file "$file"
 		then
-			dirs=${file%/*}
+			dirs=${file%/*} &&
 			if test "$file" != "$dirs"
 			then
 				mkdir -p -- "$dirs" &&
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 283a66955d..23c3c214c5 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -141,8 +141,8 @@ test_expect_success 'check correct prefix detection' '
 test_expect_success 'git add with filemode=0, symlinks=0, and unmerged entries' '
 	for s in 1 2 3
 	do
-		echo $s > stage$s
-		echo "100755 $(git hash-object -w stage$s) $s	file"
+		echo $s > stage$s &&
+		echo "100755 $(git hash-object -w stage$s) $s	file" &&
 		echo "120000 $(printf $s | git hash-object -w -t blob --stdin) $s	symlink"
 	done | git update-index --index-info &&
 	git config core.filemode 0 &&
diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
index ff7cfd884a..8c3d48e257 100755
--- a/t/t4046-diff-unmerged.sh
+++ b/t/t4046-diff-unmerged.sh
@@ -18,7 +18,7 @@ test_expect_success setup '
 			for t in o x
 			do
 				path="$b$o$t" &&
-				case "$path" in ooo) continue ;; esac
+				case "$path" in ooo) continue ;; esac &&
 				paths="$paths$path " &&
 				p="	$path" &&
 				case "$b" in x) echo "$m1$p" ;; esac &&
diff --git a/t/t4123-apply-shrink.sh b/t/t4123-apply-shrink.sh
index 984157f03b..51e69cf79e 100755
--- a/t/t4123-apply-shrink.sh
+++ b/t/t4123-apply-shrink.sh
@@ -45,8 +45,8 @@ test_expect_success 'apply should fail gracefully' '
 		echo Oops, should not have succeeded
 		false
 	else
-		status=$?
-		echo "Status was $status"
+		status=$? &&
+		echo "Status was $status" &&
 		if test -f .git/index.lock
 		then
 			echo Oops, should not have crashed
diff --git a/t/t4138-apply-ws-expansion.sh b/t/t4138-apply-ws-expansion.sh
index b19faeb67a..4ba52bbb61 100755
--- a/t/t4138-apply-ws-expansion.sh
+++ b/t/t4138-apply-ws-expansion.sh
@@ -29,7 +29,7 @@ test_expect_success setup '
 	x=1 &&
 	while test $x -lt $n
 	do
-		printf "%63s%d\n" "" $x >>after
+		printf "%63s%d\n" "" $x >>after &&
 		x=$(( $x + 1 ))
 	done &&
 	printf "\t%s\n" d e f >>after &&
@@ -40,7 +40,7 @@ test_expect_success setup '
 	x=1 &&
 	while test $x -lt $n
 	do
-		printf "%63s%d\n" "" $x >>expect-2
+		printf "%63s%d\n" "" $x >>expect-2 &&
 		x=$(( $x + 1 ))
 	done &&
 	printf "%64s\n" d e f >>expect-2 &&
@@ -52,7 +52,7 @@ test_expect_success setup '
 	x=0 &&
 	while test $x -lt $n
 	do
-		printf "%63s%02d\n" "" $x >>after
+		printf "%63s%02d\n" "" $x >>after &&
 		x=$(( $x + 1 ))
 	done &&
 	printf "\t%s\n" d e f >>after &&
@@ -63,7 +63,7 @@ test_expect_success setup '
 	x=0 &&
 	while test $x -lt $n
 	do
-		printf "%63s%02d\n" "" $x >>expect-3
+		printf "%63s%02d\n" "" $x >>expect-3 &&
 		x=$(( $x + 1 ))
 	done &&
 	printf "%64s\n" d e f >>expect-3 &&
@@ -73,15 +73,15 @@ test_expect_success setup '
 	x=0 &&
 	while test $x -lt 50
 	do
-		printf "\t%02d\n" $x >>before
+		printf "\t%02d\n" $x >>before &&
 		x=$(( $x + 1 ))
 	done &&
 	cat before >after &&
 	printf "%64s\n" a b c >>after &&
 	while test $x -lt 100
 	do
-		printf "\t%02d\n" $x >>before
-		printf "\t%02d\n" $x >>after
+		printf "\t%02d\n" $x >>before &&
+		printf "\t%02d\n" $x >>after &&
 		x=$(( $x + 1 ))
 	done &&
 	test_expect_code 1 git diff --no-index before after >patch4.patch.raw &&
@@ -90,15 +90,15 @@ test_expect_success setup '
 	x=0 &&
 	while test $x -lt 50
 	do
-		printf "%63s%02d\n" "" $x >>test-4
+		printf "%63s%02d\n" "" $x >>test-4 &&
 		x=$(( $x + 1 ))
 	done &&
 	cat test-4 >expect-4 &&
 	printf "%64s\n" a b c >>expect-4 &&
 	while test $x -lt 100
 	do
-		printf "%63s%02d\n" "" $x >>test-4
-		printf "%63s%02d\n" "" $x >>expect-4
+		printf "%63s%02d\n" "" $x >>test-4 &&
+		printf "%63s%02d\n" "" $x >>expect-4 &&
 		x=$(( $x + 1 ))
 	done &&
 
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 7c9d687367..8ee67df38f 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -14,7 +14,7 @@ test_expect_success 'setup' '
 	i=1 &&
 	while test $i -le 100
 	do
-		iii=$(printf "%03i" $i)
+		iii=$(printf "%03i" $i) &&
 		test-tool genrandom "bar" 200 > wide_delta_$iii &&
 		test-tool genrandom "baz $iii" 50 >> wide_delta_$iii &&
 		test-tool genrandom "foo"$i 100 > deep_delta_$iii &&
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 13ed3eb136..8fb6acae47 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -16,8 +16,8 @@ test_expect_success 'setup r1' '
 	git init r1 &&
 	for n in 1 2 3 4 5
 	do
-		echo "This is file: $n" > r1/file.$n
-		git -C r1 add file.$n
+		echo "This is file: $n" > r1/file.$n &&
+		git -C r1 add file.$n &&
 		git -C r1 commit -m "$n"
 	done
 '
@@ -116,8 +116,8 @@ test_expect_success 'setup r2' '
 	git init r2 &&
 	for n in 1000 10000
 	do
-		printf "%"$n"s" X > r2/large.$n
-		git -C r2 add large.$n
+		printf "%"$n"s" X > r2/large.$n &&
+		git -C r2 add large.$n &&
 		git -C r2 commit -m "$n"
 	done
 '
@@ -278,9 +278,9 @@ test_expect_success 'setup r3' '
 	mkdir r3/dir1 &&
 	for n in sparse1 sparse2
 	do
-		echo "This is file: $n" > r3/$n
-		git -C r3 add $n
-		echo "This is file: dir1/$n" > r3/dir1/$n
+		echo "This is file: $n" > r3/$n &&
+		git -C r3 add $n &&
+		echo "This is file: dir1/$n" > r3/dir1/$n &&
 		git -C r3 add dir1/$n
 	done &&
 	git -C r3 commit -m "sparse" &&
@@ -331,9 +331,9 @@ test_expect_success 'setup r4' '
 	mkdir r4/dir1 &&
 	for n in sparse1 sparse2
 	do
-		echo "This is file: $n" > r4/$n
-		git -C r4 add $n
-		echo "This is file: dir1/$n" > r4/dir1/$n
+		echo "This is file: $n" > r4/$n &&
+		git -C r4 add $n &&
+		echo "This is file: dir1/$n" > r4/dir1/$n &&
 		git -C r4 add dir1/$n
 	done &&
 	echo dir1/ >r4/pattern &&
diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index ad8d5804f7..b043a279f1 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -117,7 +117,7 @@ test_expect_success 'set up many-ref tests' '
 		nr=1000
 		while test $nr -lt 2000
 		do
-			nr=$(( $nr + 1 ))
+			nr=$(( $nr + 1 )) &&
 			echo "create refs/heads/b/$nr $COMMIT3"
 		done
 	} | git update-ref --stdin
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index cf3e82bdf5..23c156e399 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -16,9 +16,9 @@ test_expect_success 'setup normal src repo' '
 	git init src &&
 	for n in 1 2 3 4
 	do
-		echo "This is file: $n" > src/file.$n.txt
-		git -C src add file.$n.txt
-		git -C src commit -m "file $n"
+		echo "This is file: $n" > src/file.$n.txt &&
+		git -C src add file.$n.txt &&
+		git -C src commit -m "file $n" &&
 		git -C src ls-files -s file.$n.txt >>temp
 	done &&
 	awk -f print_2.awk <temp | sort >expect_1.oids &&
@@ -72,8 +72,8 @@ test_expect_success 'push new commits to server' '
 	git -C src remote add srv "file://$(pwd)/srv.bare" &&
 	for x in a b c d e
 	do
-		echo "Mod file.1.txt $x" >>src/file.1.txt
-		git -C src add file.1.txt
+		echo "Mod file.1.txt $x" >>src/file.1.txt &&
+		git -C src add file.1.txt &&
 		git -C src commit -m "mod $x"
 	done &&
 	git -C src blame main -- file.1.txt >expect.blame &&
@@ -114,8 +114,8 @@ test_expect_success 'verify blame causes dynamic object fetch' '
 test_expect_success 'push new commits to server for file.2.txt' '
 	for x in a b c d e f
 	do
-		echo "Mod file.2.txt $x" >>src/file.2.txt
-		git -C src add file.2.txt
+		echo "Mod file.2.txt $x" >>src/file.2.txt &&
+		git -C src add file.2.txt &&
 		git -C src commit -m "mod $x"
 	done &&
 	git -C src push -u srv main
@@ -135,8 +135,8 @@ test_expect_success 'override inherited filter-spec using --no-filter' '
 test_expect_success 'push new commits to server for file.3.txt' '
 	for x in a b c d e f
 	do
-		echo "Mod file.3.txt $x" >>src/file.3.txt
-		git -C src add file.3.txt
+		echo "Mod file.3.txt $x" >>src/file.3.txt &&
+		git -C src add file.3.txt &&
 		git -C src commit -m "mod $x"
 	done &&
 	git -C src push -u srv main
diff --git a/t/t6005-rev-list-count.sh b/t/t6005-rev-list-count.sh
index 0b64822bf6..32b152095a 100755
--- a/t/t6005-rev-list-count.sh
+++ b/t/t6005-rev-list-count.sh
@@ -5,10 +5,10 @@ test_description='git rev-list --max-count and --skip test'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-    for n in 1 2 3 4 5 ; do \
-        echo $n > a ; \
-        git add a ; \
-        git commit -m "$n" ; \
+    for n in 1 2 3 4 5 ; do
+        echo $n > a &&
+        git add a &&
+        git commit -m "$n"
     done
 '
 
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index 63fa7c8313..dc8160aa45 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -142,7 +142,7 @@ test_expect_success 'ancestors with the same commit time' '
 
 	test_tick_keep=$test_tick &&
 	for i in 1 2 3 4 5 6 7 8; do
-		test_tick=$test_tick_keep
+		test_tick=$test_tick_keep &&
 		test_commit t$i
 	done &&
 	git rev-list t1^! --not t$i >result &&
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 4ade105db3..9848425192 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -16,8 +16,8 @@ test_expect_success 'setup r1' '
 	git init r1 &&
 	for n in 1 2 3 4 5
 	do
-		echo "This is file: $n" > r1/file.$n
-		git -C r1 add file.$n
+		echo "This is file: $n" > r1/file.$n &&
+		git -C r1 add file.$n &&
 		git -C r1 commit -m "$n"
 	done
 '
@@ -73,8 +73,8 @@ test_expect_success 'setup r2' '
 	git init r2 &&
 	for n in 1000 10000
 	do
-		printf "%"$n"s" X > r2/large.$n
-		git -C r2 add large.$n
+		printf "%"$n"s" X > r2/large.$n &&
+		git -C r2 add large.$n &&
 		git -C r2 commit -m "$n"
 	done
 '
@@ -245,9 +245,9 @@ test_expect_success 'setup r3' '
 	mkdir r3/dir1 &&
 	for n in sparse1 sparse2
 	do
-		echo "This is file: $n" > r3/$n
-		git -C r3 add $n
-		echo "This is file: dir1/$n" > r3/dir1/$n
+		echo "This is file: $n" > r3/$n &&
+		git -C r3 add $n &&
+		echo "This is file: dir1/$n" > r3/dir1/$n &&
 		git -C r3 add dir1/$n
 	done &&
 	git -C r3 commit -m "sparse" &&
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index bae2419150..9b2cc066f7 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -390,8 +390,11 @@ test_expect_success ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
 committer A U Thor <author@example.com> $((1000000000 + $i * 100)) +0200
 data <<EOF
 commit #$i
-EOF"
-		test $i = 1 && echo "from refs/heads/main^0"
+EOF" &&
+		if test $i = 1
+		then
+			echo "from refs/heads/main^0"
+		fi &&
 		i=$(($i + 1))
 	done | git fast-import &&
 	git checkout main &&
diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
index d4273f2575..4c4f690588 100755
--- a/t/t6407-merge-binary.sh
+++ b/t/t6407-merge-binary.sh
@@ -47,7 +47,7 @@ test_expect_success resolve '
 		echo Oops, should not have succeeded
 		false
 	else
-		git ls-files -s >current
+		git ls-files -s >current &&
 		test_cmp expect current
 	fi
 '
@@ -62,7 +62,7 @@ test_expect_success recursive '
 		echo Oops, should not have succeeded
 		false
 	else
-		git ls-files -s >current
+		git ls-files -s >current &&
 		test_cmp expect current
 	fi
 '
diff --git a/t/t6412-merge-large-rename.sh b/t/t6412-merge-large-rename.sh
index c50d315722..ed40801380 100755
--- a/t/t6412-merge-large-rename.sh
+++ b/t/t6412-merge-large-rename.sh
@@ -47,7 +47,7 @@ test_rename() {
 	git commit -a -m change=$n &&
 	git checkout -b test$n HEAD^ &&
 	for i in $(count $n); do
-		git rm $i
+		git rm $i &&
 		make_text $i initial changed >$i.moved
 	done &&
 	git add . &&
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 082be85dff..660cde5a63 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1976,8 +1976,11 @@ test_expect_success ULIMIT_STACK_SIZE '--contains and --no-contains work in a de
 committer A U Thor <author@example.com> $((1000000000 + $i * 100)) +0200
 data <<EOF
 commit #$i
-EOF"
-		test $i = 1 && echo "from refs/heads/main^0"
+EOF" &&
+		if test $i = 1
+		then
+			echo "from refs/heads/main^0"
+		fi &&
 		i=$(($i + 1))
 	done | git fast-import &&
 	git checkout main &&
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index f488d930df..1b4160dc53 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -248,7 +248,7 @@ do
 		git config core.preloadIndex $preload_val &&
 		if test $preload_val = true
 		then
-			GIT_TEST_PRELOAD_INDEX=$preload_val; export GIT_TEST_PRELOAD_INDEX
+			GIT_TEST_PRELOAD_INDEX=$preload_val && export GIT_TEST_PRELOAD_INDEX
 		else
 			sane_unset GIT_TEST_PRELOAD_INDEX
 		fi
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index a9c816b47f..ddf64dc5f7 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -29,7 +29,7 @@ test_expect_success 'merge c1 with c2, c3, c4, ... c29' '
 	refs="" &&
 	while test $i -le 30
 	do
-		refs="$refs c$i"
+		refs="$refs c$i" &&
 		i=$(expr $i + 1)
 	done &&
 	git merge $refs &&
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index cb764bcadc..b4081fefba 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -59,7 +59,7 @@ test_expect_success 'authors-file against globs' '
 	git svn clone --authors-file=svn-authors -s "$svnrepo"/aa aa-work &&
 	for i in bb ee cc
 	do
-		branch="aa/branches/$i"
+		branch="aa/branches/$i" &&
 		svn_cmd mkdir -m "$branch" --username $i "$svnrepo/$branch"
 	done
 	'
-- 
2.34.1.307.g9b7440fafd

