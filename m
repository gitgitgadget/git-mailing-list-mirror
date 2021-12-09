Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D90C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhLIFQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhLIFPy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:54 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C96C061D76
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:21 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id d14so1896528ila.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hq597vRPqhmuD87p5bigSbp23Womz6EJwUkGsp/pTWQ=;
        b=ESTI28o0KyN05zV+dcD/2rSguAWyFEN7ym+UwHd2jSmSNdQ4Mz36jrNBhHXyhPzzJl
         qt8j+bCvHA73uo/C1lqcXwWEjbioURMGw2YiEHL8p0XxI1lXAhxfPAqM9dnbO+aVtt2O
         qWknW6HYM6y+sY7W4pw6HA/0Xl71zKVFzA4NiwBIjQNGlJ51Z6ZmEjcypap1iYBMA4rg
         k48vi0CtOwZdTjVXOW5xrNAIiwpynZGl8emVTTt9bH6JdwmctagLjPGwY7CCekOpbzBs
         MkK2S7HqjcS0IVmIUg7bsQxXXGoYJamy31PTHeo7VeDUrAjNpPMIeo9umkF9jFvc3JY5
         c+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Hq597vRPqhmuD87p5bigSbp23Womz6EJwUkGsp/pTWQ=;
        b=XEhTCPwBvQY85AtMq+7xX6qziHtRVGoJyxf3B3DJQxT9WB9RM8dh4f/DVn8KWFLozf
         YbWwFe3PCYjig5AW52qRLw3lsVpMg64y57WqiR4HP1TExNCi4q7dtTKwLVQTrcSk9Ngf
         wpMVDg/6KxYsNhF9qX0AvNsQGbQYRzyJu9aWZAoc12D88fYFsU0XhjTE4yi/xZlmgp2P
         zH66FhlbwvKPcUcczaCXPbGyOSOZhFhn3XoEd4Itno++gmv8GFFsDXFe5rWNvJ9pjLhT
         7lw9CcaWwb6cUab8yvrcpVhUxWI1SwMp6y8hsIq+rNCoNyH+mZniJI+x9m0xhyxrAeT7
         llQg==
X-Gm-Message-State: AOAM531O5BE6XvHIEOIiYU032OJJqahl1XPGST5XCOzqiprj0xvpPayM
        uV7jN8qqnRVieMEPvFD7voCYIBYcSMhZ8w==
X-Google-Smtp-Source: ABdhPJxrwjNWn4MhL3mP9loROFWGLYWpy9NCbIfyJQ4Jfck7dskEp9M54R0W0HhoAwnJhOd2Q23tug==
X-Received: by 2002:a05:6e02:1b09:: with SMTP id i9mr13359390ilv.156.1639026739989;
        Wed, 08 Dec 2021 21:12:19 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:19 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 16/19] t0000-t3999: detect and signal failure within loop
Date:   Thu,  9 Dec 2021 00:11:12 -0500
Message-Id: <20211209051115.52629-17-sunshine@sunshineco.com>
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
 t/perf/p0100-globbing.sh            | 4 ++--
 t/perf/p1400-update-ref.sh          | 4 ++--
 t/perf/p1451-fsck-skip-list.sh      | 2 +-
 t/perf/p3400-rebase.sh              | 2 +-
 t/perf/p5302-pack-index.sh          | 2 +-
 t/perf/p5303-many-packs.sh          | 2 +-
 t/perf/p7519-fsmonitor.sh           | 8 ++++----
 t/t0008-ignores.sh                  | 2 +-
 t/t0011-hashmap.sh                  | 4 ++--
 t/t0021-conversion.sh               | 8 ++++----
 t/t0095-bloom.sh                    | 4 ++--
 t/t0410-partial-clone.sh            | 2 +-
 t/t1050-large.sh                    | 4 ++--
 t/t1091-sparse-checkout-builtin.sh  | 2 +-
 t/t1300-config.sh                   | 2 +-
 t/t1400-update-ref.sh               | 4 ++--
 t/t1403-show-ref.sh                 | 4 ++--
 t/t1410-reflog.sh                   | 4 ++--
 t/t1512-rev-parse-disambiguation.sh | 2 +-
 t/t2004-checkout-cache-temp.sh      | 4 ++--
 t/t2012-checkout-last.sh            | 4 ++--
 t/t2200-add-update.sh               | 2 +-
 t/t2203-add-intent.sh               | 2 +-
 t/t3202-show-branch.sh              | 8 ++++----
 t/t3303-notes-subtrees.sh           | 6 +++---
 t/t3305-notes-fanout.sh             | 4 ++--
 t/t3404-rebase-interactive.sh       | 4 ++--
 t/t3501-revert-cherry-pick.sh       | 2 +-
 t/t3508-cherry-pick-many-commits.sh | 2 +-
 t/t3700-add.sh                      | 2 +-
 t/t3920-crlf-messages.sh            | 4 ++--
 31 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/t/perf/p0100-globbing.sh b/t/perf/p0100-globbing.sh
index dd18a9ce2b..439e9c8e3c 100755
--- a/t/perf/p0100-globbing.sh
+++ b/t/perf/p0100-globbing.sh
@@ -19,9 +19,9 @@ test_expect_success 'setup' '
 		printf "a" >>refname &&
 		for j in $(test_seq 1 $i)
 		do
-			printf "a*" >>refglob.$i
+			printf "a*" >>refglob.$i || return 1
 		done &&
-		echo b >>refglob.$i
+		echo b >>refglob.$i || return 1
 	done &&
 	test_commit test $(cat refname).t "" $(cat refname).t
 '
diff --git a/t/perf/p1400-update-ref.sh b/t/perf/p1400-update-ref.sh
index dda8a74866..a75969cbb1 100755
--- a/t/perf/p1400-update-ref.sh
+++ b/t/perf/p1400-update-ref.sh
@@ -13,7 +13,7 @@ test_expect_success "setup" '
 	do
 		printf "start\ncreate refs/heads/%d PRE\ncommit\n" $i &&
 		printf "start\nupdate refs/heads/%d POST PRE\ncommit\n" $i &&
-		printf "start\ndelete refs/heads/%d POST\ncommit\n" $i
+		printf "start\ndelete refs/heads/%d POST\ncommit\n" $i || return 1
 	done >instructions
 '
 
@@ -22,7 +22,7 @@ test_perf "update-ref" '
 	do
 		git update-ref refs/heads/branch PRE &&
 		git update-ref refs/heads/branch POST PRE &&
-		git update-ref -d refs/heads/branch
+		git update-ref -d refs/heads/branch || return 1
 	done
 '
 
diff --git a/t/perf/p1451-fsck-skip-list.sh b/t/perf/p1451-fsck-skip-list.sh
index c2b97d2487..f767d834f2 100755
--- a/t/perf/p1451-fsck-skip-list.sh
+++ b/t/perf/p1451-fsck-skip-list.sh
@@ -15,7 +15,7 @@ test_expect_success "setup $n bad commits" '
 		echo "committer C <c@example.com> 1234567890 +0000" &&
 		echo "data <<EOF" &&
 		echo "$i.Q." &&
-		echo "EOF"
+		echo "EOF" || return 1
 	done | q_to_nul | git fast-import
 '
 
diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
index 43d5a34e8c..e6b0277729 100755
--- a/t/perf/p3400-rebase.sh
+++ b/t/perf/p3400-rebase.sh
@@ -22,7 +22,7 @@ test_expect_success 'setup rebasing on top of a lot of changes' '
 		git add unrelated-file$i &&
 		test_tick &&
 		git commit -m commit$i-reverse unrelated-file$i ||
-		break
+		return 1
 	done &&
 	git checkout to-rebase &&
 	test_commit our-patch interesting-file
diff --git a/t/perf/p5302-pack-index.sh b/t/perf/p5302-pack-index.sh
index 654cd9c86e..c16f6a3ff6 100755
--- a/t/perf/p5302-pack-index.sh
+++ b/t/perf/p5302-pack-index.sh
@@ -22,7 +22,7 @@ test_expect_success 'set up thread-counting tests' '
 	while test $t -gt 0
 	do
 		threads="$t $threads" &&
-		t=$((t / 2))
+		t=$((t / 2)) || return 1
 	done
 '
 
diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
index 58213fe171..af173a7b73 100755
--- a/t/perf/p5303-many-packs.sh
+++ b/t/perf/p5303-many-packs.sh
@@ -130,7 +130,7 @@ test_expect_success 'generate lots of packs' '
 		echo "data <<EOF" &&
 		echo "blob $i" &&
 		echo "EOF" &&
-		echo "checkpoint"
+		echo "checkpoint" || return 1
 	done |
 	git -c fastimport.unpackLimit=0 fast-import
 '
diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 5eb5044a10..c8be58f3c7 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -119,10 +119,10 @@ test_expect_success "one time repo setup" '
 	fi &&
 
 	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
-	for i in $(test_seq 1 10); do touch 10_files/$i; done &&
-	for i in $(test_seq 1 100); do touch 100_files/$i; done &&
-	for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
-	for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
+	for i in $(test_seq 1 10); do touch 10_files/$i || return 1; done &&
+	for i in $(test_seq 1 100); do touch 100_files/$i || return 1; done &&
+	for i in $(test_seq 1 1000); do touch 1000_files/$i || return 1; done &&
+	for i in $(test_seq 1 10000); do touch 10000_files/$i || return 1; done &&
 	git add 1_file 10_files 100_files 1000_files 10000_files &&
 	git commit -qm "Add files" &&
 
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 42d2314804..5575dade8e 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -200,7 +200,7 @@ test_expect_success 'setup' '
 	do
 		: >$dir/not-ignored &&
 		: >$dir/ignored-and-untracked &&
-		: >$dir/ignored-but-in-index
+		: >$dir/ignored-but-in-index || return 1
 	done &&
 	git add -f ignored-but-in-index a/ignored-but-in-index &&
 	cat <<-\EOF >a/.gitignore &&
diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
index e094975b13..1cb6aa6824 100755
--- a/t/t0011-hashmap.sh
+++ b/t/t0011-hashmap.sh
@@ -220,7 +220,7 @@ test_expect_success 'grow / shrink' '
 	for n in $(test_seq 51)
 	do
 		echo put key$n value$n >> in &&
-		echo NULL >> expect
+		echo NULL >> expect || return 1
 	done &&
 	echo size >> in &&
 	echo 64 51 >> expect &&
@@ -231,7 +231,7 @@ test_expect_success 'grow / shrink' '
 	for n in $(test_seq 12)
 	do
 		echo remove key$n >> in &&
-		echo value$n >> expect
+		echo value$n >> expect || return 1
 	done &&
 	echo size >> in &&
 	echo 256 40 >> expect &&
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index bb3de2701a..bad37abad2 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -285,7 +285,7 @@ test_expect_success 'required filter with absent smudge field' '
 test_expect_success 'filtering large input to small output should use little memory' '
 	test_config filter.devnull.clean "cat >/dev/null" &&
 	test_config filter.devnull.required true &&
-	for i in $(test_seq 1 30); do printf "%1048576d" 1; done >30MB &&
+	for i in $(test_seq 1 30); do printf "%1048576d" 1 || return 1; done >30MB &&
 	echo "30MB filter=devnull" >.gitattributes &&
 	GIT_MMAP_LIMIT=1m GIT_ALLOC_LIMIT=1m git add 30MB
 '
@@ -303,7 +303,7 @@ test_expect_success 'filter that does not read is fine' '
 test_expect_success EXPENSIVE 'filter large file' '
 	test_config filter.largefile.smudge cat &&
 	test_config filter.largefile.clean cat &&
-	for i in $(test_seq 1 2048); do printf "%1048576d" 1; done >2GB &&
+	for i in $(test_seq 1 2048); do printf "%1048576d" 1 || return 1; done >2GB &&
 	echo "2GB filter=largefile" >.gitattributes &&
 	git add 2GB 2>err &&
 	test_must_be_empty err &&
@@ -643,7 +643,7 @@ test_expect_success PERL 'required process filter should process multiple packet
 		for FILE in "$TEST_ROOT"/*.file
 		do
 			cp "$FILE" . &&
-			rot13.sh <"$FILE" >"$FILE.rot13"
+			rot13.sh <"$FILE" >"$FILE.rot13" || return 1
 		done &&
 
 		echo "*.file filter=protocol" >.gitattributes &&
@@ -682,7 +682,7 @@ test_expect_success PERL 'required process filter should process multiple packet
 
 		for FILE in *.file
 		do
-			test_cmp_committed_rot13 "$TEST_ROOT/$FILE" $FILE
+			test_cmp_committed_rot13 "$TEST_ROOT/$FILE" $FILE || return 1
 		done
 	)
 '
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index 7e4ab1795f..5945973552 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -84,7 +84,7 @@ test_expect_success 'get bloom filter for commit with 10 changes' '
 	mkdir smallDir &&
 	for i in $(test_seq 0 9)
 	do
-		echo $i >smallDir/$i
+		echo $i >smallDir/$i || return 1
 	done &&
 	git add smallDir &&
 	git commit -m "commit with 10 changes" &&
@@ -102,7 +102,7 @@ test_expect_success EXPENSIVE 'get bloom filter for commit with 513 changes' '
 	mkdir bigDir &&
 	for i in $(test_seq 0 511)
 	do
-		echo $i >bigDir/$i
+		echo $i >bigDir/$i || return 1
 	done &&
 	git add bigDir &&
 	git commit -m "commit with 513 changes" &&
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index c76485b1b6..f17abd298c 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -469,7 +469,7 @@ test_expect_success 'rev-list dies for missing objects on cmd line' '
 		git -C repo rev-list --ignore-missing --objects \
 			--exclude-promisor-objects "$OBJ" &&
 		git -C repo rev-list --ignore-missing --objects-edge-aggressive \
-			--exclude-promisor-objects "$OBJ"
+			--exclude-promisor-objects "$OBJ" || return 1
 	done
 '
 
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 0e4267c723..4f3aa17c99 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -105,7 +105,7 @@ test_expect_success 'packsize limit' '
 		count=0 &&
 		for pi in .git/objects/pack/pack-*.idx
 		do
-			test_path_is_file "$pi" && count=$(( $count + 1 ))
+			test_path_is_file "$pi" && count=$(( $count + 1 )) || return 1
 		done &&
 		test $count = 2 &&
 
@@ -118,7 +118,7 @@ test_expect_success 'packsize limit' '
 
 		for pi in .git/objects/pack/pack-*.idx
 		do
-			git show-index <"$pi"
+			git show-index <"$pi" || return 1
 		done |
 		sed -e "s/^[0-9]* \([0-9a-f]*\) .*/\1/" |
 		sort >actual &&
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 272ba1b566..5d53dbfbde 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -586,7 +586,7 @@ test_expect_success 'pattern-checks: contained glob characters' '
 		!/*/
 		something$c-else/
 		EOF
-		check_read_tree_errors repo "a" "disabling cone pattern matching"
+		check_read_tree_errors repo "a" "disabling cone pattern matching" || return 1
 	done
 '
 
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 516dd8bfa8..50ee5dc828 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -718,7 +718,7 @@ test_expect_success bool '
 	for i in 1 2 3 4
 	do
 	    git config --bool --get bool.true$i >>result &&
-	    git config --bool --get bool.false$i >>result
+	    git config --bool --get bool.false$i >>result || return 1
 	done &&
 	test_cmp expect result'
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 0d4f73acaa..bd58c6c897 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1368,7 +1368,7 @@ test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches
 (
 	for i in $(test_seq 33)
 	do
-		echo "create refs/heads/$i HEAD"
+		echo "create refs/heads/$i HEAD" || exit 1
 	done >large_input &&
 	run_with_limited_open_files git update-ref --stdin <large_input &&
 	git rev-parse --verify -q refs/heads/33
@@ -1379,7 +1379,7 @@ test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches
 (
 	for i in $(test_seq 33)
 	do
-		echo "delete refs/heads/$i HEAD"
+		echo "delete refs/heads/$i HEAD" || exit 1
 	done >large_input &&
 	run_with_limited_open_files git update-ref --stdin <large_input &&
 	test_must_fail git rev-parse --verify -q refs/heads/33
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index bbc01aae34..405da58b75 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -123,14 +123,14 @@ test_expect_success 'show-ref -d' '
 test_expect_success 'show-ref --heads, --tags, --head, pattern' '
 	for branch in B main side
 	do
-		echo $(git rev-parse refs/heads/$branch) refs/heads/$branch
+		echo $(git rev-parse refs/heads/$branch) refs/heads/$branch || return 1
 	done >expect.heads &&
 	git show-ref --heads >actual &&
 	test_cmp expect.heads actual &&
 
 	for tag in A B C
 	do
-		echo $(git rev-parse refs/tags/$tag) refs/tags/$tag
+		echo $(git rev-parse refs/tags/$tag) refs/tags/$tag || return 1
 	done >expect.tags &&
 	git show-ref --tags >actual &&
 	test_cmp expect.tags actual &&
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index d42f067ff8..d7ddf7612d 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -349,12 +349,12 @@ test_expect_success SHA1 'parsing reverse reflogs at BUFSIZ boundaries' '
 		printf "$zf%02d $zf%02d %s\t" $i $(($i+1)) "$ident" &&
 		if test $i = 75; then
 			for j in $(test_seq 1 89); do
-				printf X
+				printf X || return 1
 			done
 		else
 			printf X
 		fi &&
-		printf "\n"
+		printf "\n" || return 1
 	done >.git/logs/refs/heads/reflogskip &&
 	git rev-parse reflogskip@{73} >actual &&
 	echo ${zf}03 >expect &&
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 15188a408b..b0119bf8bc 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -381,7 +381,7 @@ test_expect_success 'ambiguous commits are printed by type first, then hash orde
 	do
 		grep $type objects >$type.objects &&
 		sort $type.objects >$type.objects.sorted &&
-		test_cmp $type.objects.sorted $type.objects
+		test_cmp $type.objects.sorted $type.objects || return 1
 	done
 '
 
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index 9bb503a975..b16d69ca4a 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -57,7 +57,7 @@ test_expect_success 'checkout all stage 0 to temporary files' '
 		test $(grep $f actual | cut "-d	" -f2) = $f &&
 		p=$(grep $f actual | cut "-d	" -f1) &&
 		test -f $p &&
-		test $(cat $p) = tree1$f
+		test $(cat $p) = tree1$f || return 1
 	done
 '
 
@@ -85,7 +85,7 @@ test_expect_success 'checkout all stage 2 to temporary files' '
 		test $(grep $f actual | cut "-d	" -f2) = $f &&
 		p=$(grep $f actual | cut "-d	" -f1) &&
 		test -f $p &&
-		test $(cat $p) = tree2$f
+		test $(cat $p) = tree2$f || return 1
 	done
 '
 
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index 0e7d47ab31..42601d5a31 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -49,14 +49,14 @@ test_expect_success '"checkout -" detaches again' '
 test_expect_success 'more switches' '
 	for i in 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1
 	do
-		git checkout -b branch$i
+		git checkout -b branch$i || return 1
 	done
 '
 
 more_switches () {
 	for i in 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1
 	do
-		git checkout branch$i
+		git checkout branch$i || return 1
 	done
 }
 
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index d2ef0041f9..6993fcbe7a 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -152,7 +152,7 @@ test_expect_success 'add -u resolves unmerged paths' '
 		do
 			echo "100644 $one 1	$path" &&
 			echo "100644 $two 2	$path" &&
-			echo "100644 $three 3	$path"
+			echo "100644 $three 3	$path" || return 1
 		done &&
 		echo "100644 $one 1	path3" &&
 		echo "100644 $one 1	path4" &&
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index cf0175ad6e..db7ca55998 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -116,7 +116,7 @@ test_expect_success 'cache-tree does not ignore dir that has i-t-a entries' '
 		mkdir 2 &&
 		for f in 1 2/1 2/2 3
 		do
-			echo "$f" >"$f"
+			echo "$f" >"$f" || return 1
 		done &&
 		git add 1 2/2 3 &&
 		git add -N 2/1 &&
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index ad9902a06b..1e54a33103 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -9,7 +9,7 @@ test_expect_success 'setup' '
 	for i in $(test_seq 1 10)
 	do
 		git checkout -b branch$i initial &&
-		test_commit --no-tag branch$i
+		test_commit --no-tag branch$i || return 1
 	done &&
 	git for-each-ref \
 		--sort=version:refname \
@@ -49,7 +49,7 @@ test_expect_success 'show-branch with more than 8 branches' '
 test_expect_success 'show-branch with showbranch.default' '
 	for branch in $(cat branches.sorted)
 	do
-		test_config showbranch.default $branch --add
+		test_config showbranch.default $branch --add || return 1
 	done &&
 	git show-branch >actual &&
 	test_cmp expect actual
@@ -124,7 +124,7 @@ test_expect_success 'show branch --merge-base with one argument' '
 	do
 		git rev-parse $branch >expect &&
 		git show-branch --merge-base $branch >actual &&
-		test_cmp expect actual
+		test_cmp expect actual || return 1
 	done
 '
 
@@ -133,7 +133,7 @@ test_expect_success 'show branch --merge-base with two arguments' '
 	do
 		git rev-parse initial >expect &&
 		git show-branch --merge-base initial $branch >actual &&
-		test_cmp expect actual
+		test_cmp expect actual || return 1
 	done
 '
 
diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index d47ce00f69..7ce056e617 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -30,7 +30,7 @@ verify_notes () {
 	while [ $i -gt 0 ]; do
 		echo "    commit #$i" &&
 		echo "    note for commit #$i" &&
-		i=$(($i-1));
+		i=$(($i-1)) || return 1
 	done > expect &&
 	test_cmp expect output
 }
@@ -42,7 +42,7 @@ test_expect_success "setup: create $number_of_commits commits" '
 		while [ $nr -lt $number_of_commits ]; do
 			nr=$(($nr+1)) &&
 			test_tick &&
-			cat <<INPUT_END
+			cat <<INPUT_END || return 1
 commit refs/heads/main
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
@@ -178,7 +178,7 @@ verify_concatenated_notes () {
 		echo "    first note for commit #$i" &&
 		echo "    " &&
 		echo "    second note for commit #$i" &&
-		i=$(($i-1));
+		i=$(($i-1)) || return 1
 	done > expect &&
 	test_cmp expect output
 }
diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 94c1b02251..836b6f22bf 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -57,7 +57,7 @@ test_expect_success 'many notes created correctly with git-notes' '
 	do
 		echo "    commit #$i" &&
 		echo "    note #$i" &&
-		i=$(($i - 1));
+		i=$(($i - 1)) || return 1
 	done > expect &&
 	test_cmp expect output
 '
@@ -106,7 +106,7 @@ test_expect_success 'most notes deleted correctly with git-notes' '
 	do
 		echo "    commit #$i" &&
 		echo "    note #$i" &&
-		i=$(($i - 1));
+		i=$(($i - 1)) || return 1
 	done > expect &&
 	test_cmp expect output
 '
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 12eb226957..f6a9890d66 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -826,7 +826,7 @@ test_expect_success 'always cherry-pick with --no-ff' '
 	do
 		test ! $(git rev-parse HEAD~$p) = $(git rev-parse original-no-ff-branch~$p) &&
 		git diff HEAD~$p original-no-ff-branch~$p > out &&
-		test_must_be_empty out
+		test_must_be_empty out || return 1
 	done &&
 	test_cmp_rev HEAD~3 original-no-ff-branch~3 &&
 	git diff HEAD~3 original-no-ff-branch~3 > out &&
@@ -1341,7 +1341,7 @@ test_expect_success 'rebase --continue removes CHERRY_PICK_HEAD' '
 		test_seq 5 | sed "s/$double/&&/" >seq &&
 		git add seq &&
 		test_tick &&
-		git commit -m seq-$double
+		git commit -m seq-$double || return 1
 	done &&
 	git tag seq-onto &&
 	git reset --hard HEAD~2 &&
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 4b5b607673..8617efaaf1 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -19,7 +19,7 @@ test_expect_success setup '
 
 	for l in a b c d e f g h i j k l m n o
 	do
-		echo $l$l$l$l$l$l$l$l$l
+		echo $l$l$l$l$l$l$l$l$l || return 1
 	done >oops &&
 
 	test_tick &&
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index e8375d1c97..2d53ce754c 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -29,7 +29,7 @@ test_expect_success setup '
 		git add file1 &&
 		test_tick &&
 		git commit -m "$val" &&
-		git tag $val
+		git tag $val || return 1
 	done
 '
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 6902807ff8..b1f90ba325 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -143,7 +143,7 @@ test_expect_success 'git add with filemode=0, symlinks=0, and unmerged entries'
 	do
 		echo $s > stage$s &&
 		echo "100755 $(git hash-object -w stage$s) $s	file" &&
-		echo "120000 $(printf $s | git hash-object -w -t blob --stdin) $s	symlink"
+		echo "120000 $(printf $s | git hash-object -w -t blob --stdin) $s	symlink" || return 1
 	done | git update-index --index-info &&
 	git config core.filemode 0 &&
 	git config core.symlinks 0 &&
diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index a8ad5462d9..0276edbe3d 100755
--- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -70,7 +70,7 @@ test_crlf_subject_body_and_contents() {
 			for ref in ${LIB_CRLF_BRANCHES}
 			do
 				cat .crlf-${file}-\"\${ref}\".txt >>expect &&
-				printf \"\n\" >>expect
+				printf \"\n\" >>expect || return 1
 			done &&
 			git $command_and_args --format=\"%${atom}\" >actual &&
 			test_cmp expect actual
@@ -90,7 +90,7 @@ test_expect_success 'branch: --verbose works with messages using CRLF' '
 	do
 		printf "  " >>expect &&
 		cat .crlf-subject-${branch}.txt >>expect &&
-		printf "\n" >>expect
+		printf "\n" >>expect || return 1
 	done &&
 	git branch -v >tmp &&
 	# Remove first two columns, and the line for the currently checked out branch
-- 
2.34.1.307.g9b7440fafd

