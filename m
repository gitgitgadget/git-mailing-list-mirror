Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699CAC433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhLIFQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbhLIFP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:56 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71722C061353
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:23 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id s11so4287235ilv.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aBTXdlwgZVvHMYw+xnVnYJ65tbJqUJMyho9qlhG378k=;
        b=pueIbUYiEFA5ZzFysHFNstfFcbWiOtpe/odrueKg4xc2SdlpV1t1GSsbEX0uxsRVsI
         ftZj+50sTgiMQ2IF6Y+IjoMYLAktsyP03dRVMeiw2Ky1iV/v5rm2FhsNE0zm1IfpZfzu
         Xh2LqDjC3eu71PLexim+WUCnME0pzdQXUDkIpMzAlNQvLpzAeMjeVkaZLc4JV08pxpe7
         BRg/64iL17avS60aUw9KEbvHdjLR0dO7o1BaGwWXBUHMVYSu6Tk0L2dmCOyp4Hi+3OoZ
         eNkmJf44eICVru1eXcIYvhGRYmFc0VM4TOfbMdiV0fDLvMesT0SWXEu+XNjP/NUR6hjq
         bclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aBTXdlwgZVvHMYw+xnVnYJ65tbJqUJMyho9qlhG378k=;
        b=uau+j+qpi9GETy6283IitXjg78vg1kqK60hB0OT35qhlBv8sdFcXbRMaLM7AfmV4g6
         qLnR6ouBIN7foXZhtxsAdnOKwqqTnLEm5vZABvW+11lC0QErCfMX3evnQqja3tE142Er
         OJwPIHMZ41IvjaxQtk1HF+m07QMNmw0tNc0KqPrycTPHyVfIx6Yx8Z1X9gT49Zl8hxY5
         Kfz/yrJc71BCkIgIsRhR69DeYlChkd4hZJBQR1buoJp+0TSTUz0DlIRM/4Fz7TtjrAkQ
         QHvDp6/QGocY7idYiC3uEIWXxRwnrib/eMqlkpekRjcGAz6Y4+Vge8eq+G9ny3ymiMGq
         WN/A==
X-Gm-Message-State: AOAM5339Pf4JN5FJeGFGnal2DfN9EUmbh9/XUld4FMD+jIROqBUeRhoF
        +H5txsv7QeEZAFsxCut70DpKB7GoHFntrw==
X-Google-Smtp-Source: ABdhPJxdoIQHrU5A9V+hjgsFJapadRW4kPdjeINfuuj0VgS9G5jhpfbu4TUpDyW3VwiYUw5jTj462A==
X-Received: by 2002:a05:6e02:1d81:: with SMTP id h1mr12125688ila.265.1639026742465;
        Wed, 08 Dec 2021 21:12:22 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:22 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 19/19] t6000-t9999: detect and signal failure within loop
Date:   Thu,  9 Dec 2021 00:11:15 -0500
Message-Id: <20211209051115.52629-20-sunshine@sunshineco.com>
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
 contrib/mw-to-git/t/t9365-continuing-queries.sh |  2 +-
 t/annotate-tests.sh                             |  2 +-
 t/t6005-rev-list-count.sh                       |  2 +-
 t/t6009-rev-list-parent.sh                      |  4 ++--
 t/t6101-rev-parse-parents.sh                    |  2 +-
 t/t6112-rev-list-filters-objects.sh             |  8 ++++----
 t/t6120-describe.sh                             |  6 +++---
 t/t6132-pathspec-exclude.sh                     |  2 +-
 t/t6200-fmt-merge-msg.sh                        |  2 +-
 t/t6300-for-each-ref.sh                         |  2 +-
 t/t6412-merge-large-rename.sh                   |  8 ++++----
 t/t6430-merge-recursive.sh                      |  2 +-
 t/t6600-test-reach.sh                           |  4 ++--
 t/t7004-tag.sh                                  |  2 +-
 t/t7505-prepare-commit-msg-hook.sh              |  2 +-
 t/t7600-merge.sh                                |  2 +-
 t/t7602-merge-octopus-many.sh                   |  2 +-
 t/t7603-merge-reduce-heads.sh                   |  4 ++--
 t/t7700-repack.sh                               |  2 +-
 t/t8014-blame-ignore-fuzzy.sh                   |  4 ++--
 t/t9104-git-svn-follow-parent.sh                |  4 ++--
 t/t9130-git-svn-authors-file.sh                 |  4 ++--
 t/t9134-git-svn-ignore-paths.sh                 | 16 ++++++++--------
 t/t9138-git-svn-authors-prog.sh                 |  2 +-
 t/t9146-git-svn-empty-dirs.sh                   |  4 ++--
 t/t9147-git-svn-include-paths.sh                | 16 ++++++++--------
 t/t9152-svn-empty-dirs-after-gc.sh              |  2 +-
 t/t9304-fast-import-marks.sh                    |  2 +-
 t/t9400-git-cvsserver-server.sh                 |  4 ++--
 t/t9800-git-p4-basic.sh                         |  2 +-
 t/t9818-git-p4-block.sh                         |  6 +++---
 t/t9902-completion.sh                           |  4 ++--
 32 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/contrib/mw-to-git/t/t9365-continuing-queries.sh b/contrib/mw-to-git/t/t9365-continuing-queries.sh
index 016454749f..d3e7312659 100755
--- a/contrib/mw-to-git/t/t9365-continuing-queries.sh
+++ b/contrib/mw-to-git/t/t9365-continuing-queries.sh
@@ -12,7 +12,7 @@ test_expect_success 'creating page w/ >500 revisions' '
 	for i in $(test_seq 501)
 	do
 		echo "creating revision $i" &&
-		wiki_editpage foo "revision $i<br/>" true
+		wiki_editpage foo "revision $i<br/>" true || return 1
 	done
 '
 
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index d3b299e75c..09e86f9ba0 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -161,7 +161,7 @@ test_expect_success 'blame huge graft' '
 			GIT_AUTHOR_NAME=$i$j GIT_AUTHOR_EMAIL=$i$j@test.git \
 			git commit -a -m "$i$j" &&
 			commit=$(git rev-parse --verify HEAD) &&
-			graft="$graft$commit "
+			graft="$graft$commit " || return 1
 		done
 	done &&
 	printf "%s " $graft >.git/info/grafts &&
diff --git a/t/t6005-rev-list-count.sh b/t/t6005-rev-list-count.sh
index 32b152095a..06d801032b 100755
--- a/t/t6005-rev-list-count.sh
+++ b/t/t6005-rev-list-count.sh
@@ -8,7 +8,7 @@ test_expect_success 'setup' '
     for n in 1 2 3 4 5 ; do
         echo $n > a &&
         git add a &&
-        git commit -m "$n"
+        git commit -m "$n" || return 1
     done
 '
 
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index dc8160aa45..5a67bbc760 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -124,7 +124,7 @@ test_expect_success 'dodecapus' '
 		git checkout -b root$i five &&
 		test_commit $i &&
 		roots="$roots root$i" ||
-		return
+		return 1
 	done &&
 	git checkout main &&
 	test_tick &&
@@ -143,7 +143,7 @@ test_expect_success 'ancestors with the same commit time' '
 	test_tick_keep=$test_tick &&
 	for i in 1 2 3 4 5 6 7 8; do
 		test_tick=$test_tick_keep &&
-		test_commit t$i
+		test_commit t$i || return 1
 	done &&
 	git rev-list t1^! --not t$i >result &&
 	test_must_be_empty result
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 78b5851780..c571fa5179 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -32,7 +32,7 @@ test_expect_success 'setup' '
 		test_tick &&
 		git commit --allow-empty -m "$i" &&
 		commit=$(git rev-parse --verify HEAD) &&
-		printf "$commit " >>.git/info/grafts
+		printf "$commit " >>.git/info/grafts || return 1
 	done
 '
 
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 9848425192..8d9d6604f0 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -18,7 +18,7 @@ test_expect_success 'setup r1' '
 	do
 		echo "This is file: $n" > r1/file.$n &&
 		git -C r1 add file.$n &&
-		git -C r1 commit -m "$n"
+		git -C r1 commit -m "$n" || return 1
 	done
 '
 
@@ -75,7 +75,7 @@ test_expect_success 'setup r2' '
 	do
 		printf "%"$n"s" X > r2/large.$n &&
 		git -C r2 add large.$n &&
-		git -C r2 commit -m "$n"
+		git -C r2 commit -m "$n" || return 1
 	done
 '
 
@@ -248,7 +248,7 @@ test_expect_success 'setup r3' '
 		echo "This is file: $n" > r3/$n &&
 		git -C r3 add $n &&
 		echo "This is file: dir1/$n" > r3/dir1/$n &&
-		git -C r3 add dir1/$n
+		git -C r3 add dir1/$n || return 1
 	done &&
 	git -C r3 commit -m "sparse" &&
 	echo dir1/ >pattern1 &&
@@ -672,7 +672,7 @@ test_expect_success 'rev-list W/ --missing=print' '
 
 	for id in `cat expected | sed "s|..|&/|"`
 	do
-		rm r1/.git/objects/$id
+		rm r1/.git/objects/$id || return 1
 	done &&
 
 	git -C r1 rev-list --quiet --missing=print --objects HEAD >revs &&
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 9b2cc066f7..d8af2bb9d2 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -262,7 +262,7 @@ test_expect_success 'name-rev --all' '
 	>expect.unsorted &&
 	for rev in $(git rev-list --all)
 	do
-		git name-rev $rev >>expect.unsorted
+		git name-rev $rev >>expect.unsorted || return 1
 	done &&
 	sort <expect.unsorted >expect &&
 	git name-rev --all >actual.unsorted &&
@@ -275,7 +275,7 @@ test_expect_success 'name-rev --stdin' '
 	for rev in $(git rev-list --all)
 	do
 		name=$(git name-rev --name-only $rev) &&
-		echo "$rev ($name)" >>expect.unsorted
+		echo "$rev ($name)" >>expect.unsorted || return 1
 	done &&
 	sort <expect.unsorted >expect &&
 	git rev-list --all | git name-rev --stdin >actual.unsorted &&
@@ -395,7 +395,7 @@ EOF" &&
 		then
 			echo "from refs/heads/main^0"
 		fi &&
-		i=$(($i + 1))
+		i=$(($i + 1)) || return 1
 	done | git fast-import &&
 	git checkout main &&
 	git tag far-far-away HEAD^ &&
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 30328b87f0..8ff1d76f79 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -11,7 +11,7 @@ test_expect_success 'setup' '
 		fi &&
 		: >$p &&
 		git add $p &&
-		git commit -m $p
+		git commit -m $p || return 1
 	done &&
 	git log --oneline --format=%s >actual &&
 	cat <<EOF >expect &&
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 06c5fb5615..5cf7b7673e 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -519,7 +519,7 @@ test_expect_success 'merge-msg lots of commits' '
 		while test $i -gt 9
 		do
 			echo "  $i" &&
-			i=$(($i-1))
+			i=$(($i-1)) || return 1
 		done &&
 		echo "  ..."
 	} >expected &&
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index aae57908f8..abc8e1495a 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1338,7 +1338,7 @@ test_expect_success ':remotename and :remoteref' '
 			echo "${pair#*=}" >expect &&
 			git for-each-ref --format="${pair%=*}" \
 				refs/heads/main >actual &&
-			test_cmp expect actual
+			test_cmp expect actual || exit 1
 		done &&
 		git branch push-simple &&
 		git config branch.push-simple.pushRemote from &&
diff --git a/t/t6412-merge-large-rename.sh b/t/t6412-merge-large-rename.sh
index ed40801380..ca018d11f5 100755
--- a/t/t6412-merge-large-rename.sh
+++ b/t/t6412-merge-large-rename.sh
@@ -37,18 +37,18 @@ test_rename() {
 	test_might_fail git branch -D test$n &&
 	git reset --hard initial &&
 	for i in $(count $n); do
-		make_text $i initial initial >$i
+		make_text $i initial initial >$i || return 1
 	done &&
 	git add . &&
 	git commit -m add=$n &&
 	for i in $(count $n); do
-		make_text $i changed initial >$i
+		make_text $i changed initial >$i || return 1
 	done &&
 	git commit -a -m change=$n &&
 	git checkout -b test$n HEAD^ &&
 	for i in $(count $n); do
 		git rm $i &&
-		make_text $i initial changed >$i.moved
+		make_text $i initial changed >$i.moved || return 1
 	done &&
 	git add . &&
 	git commit -m change+rename=$n &&
@@ -79,7 +79,7 @@ test_expect_success 'setup large simple rename' '
 
 	git reset --hard initial &&
 	for i in $(count 200); do
-		make_text foo bar baz >$i
+		make_text foo bar baz >$i || return 1
 	done &&
 	git add . &&
 	git commit -m create-files &&
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index a0efe7cb6d..07067bb347 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -706,7 +706,7 @@ test_expect_success 'merge-recursive remembers the names of all base trees' '
 	# more trees than static slots used by oid_to_hex()
 	for commit in $c0 $c2 $c4 $c5 $c6 $c7
 	do
-		git rev-parse "$commit^{tree}"
+		git rev-parse "$commit^{tree}" || return 1
 	done >trees &&
 
 	# ignore the return code; it only fails because the input is weird...
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 3d7a62ddab..338a9c46a2 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -32,7 +32,7 @@ test_expect_success 'setup' '
 	do
 		test_commit "1-$i" &&
 		git branch -f commit-1-$i &&
-		git tag -a -m "1-$i" tag-1-$i commit-1-$i
+		git tag -a -m "1-$i" tag-1-$i commit-1-$i || return 1
 	done &&
 	for j in $(test_seq 1 9)
 	do
@@ -46,7 +46,7 @@ test_expect_success 'setup' '
 		do
 			git merge commit-$j-$i -m "$x-$i" &&
 			git branch -f commit-$x-$i &&
-			git tag -a -m "$x-$i" tag-$x-$i commit-$x-$i
+			git tag -a -m "$x-$i" tag-$x-$i commit-$x-$i || return 1
 		done
 	done &&
 	git commit-graph write --reachable &&
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 660cde5a63..25a26563dd 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1981,7 +1981,7 @@ EOF" &&
 		then
 			echo "from refs/heads/main^0"
 		fi &&
-		i=$(($i + 1))
+		i=$(($i + 1)) || return 1
 	done | git fast-import &&
 	git checkout main &&
 	git tag far-far-away HEAD^ &&
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 2a07c70867..e39c809ca4 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -16,7 +16,7 @@ test_expect_success 'set up commits for rebasing' '
 	test_commit rebase-b b bb &&
 	for i in $(test_seq 1 13)
 	do
-		test_commit rebase-$i c $i
+		test_commit rebase-$i c $i || return 1
 	done &&
 	git checkout main &&
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index c773e30b3f..f0f6fda150 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -967,7 +967,7 @@ test_expect_success 'set up mod-256 conflict scenario' '
 	# 256 near-identical stanzas...
 	for i in $(test_seq 1 256); do
 		for j in 1 2 3 4 5; do
-			echo $i-$j
+			echo $i-$j || return 1
 		done
 	done >file &&
 	git add file &&
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index ddf64dc5f7..ff085b086c 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -30,7 +30,7 @@ test_expect_success 'merge c1 with c2, c3, c4, ... c29' '
 	while test $i -le 30
 	do
 		refs="$refs c$i" &&
-		i=$(expr $i + 1)
+		i=$(expr $i + 1) || return 1
 	done &&
 	git merge $refs &&
 	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
index 27cd94ad6f..4887ca705b 100755
--- a/t/t7603-merge-reduce-heads.sh
+++ b/t/t7603-merge-reduce-heads.sh
@@ -95,7 +95,7 @@ test_expect_success 'setup' '
 		echo $i > $i.c &&
 		git add $i.c &&
 		git commit -m $i &&
-		git tag $i
+		git tag $i || return 1
 	done &&
 	git reset --hard A &&
 	for i in F G H I
@@ -103,7 +103,7 @@ test_expect_success 'setup' '
 		echo $i > $i.c &&
 		git add $i.c &&
 		git commit -m $i &&
-		git tag $i
+		git tag $i || return 1
 	done
 '
 
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 0260ad6f0e..4693f8dc2b 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -117,7 +117,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 			rm alt_objects/pack/$base_name.keep
 		else
 			touch alt_objects/pack/$base_name.keep
-		fi
+		fi || return 1
 	done &&
 	git repack -a -d &&
 	test_no_missing_in_packs
diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
index e68e6115a6..0bd0341301 100755
--- a/t/t8014-blame-ignore-fuzzy.sh
+++ b/t/t8014-blame-ignore-fuzzy.sh
@@ -310,7 +310,7 @@ test_expect_success setup '
 			echo "$line" >>"$i" &&
 			git add "$i" &&
 			test_tick &&
-			GIT_AUTHOR_NAME="$line_count" git commit -m "$line_count"
+			GIT_AUTHOR_NAME="$line_count" git commit -m "$line_count" || return 1
 		done <"a$i"
 	done &&
 
@@ -318,7 +318,7 @@ test_expect_success setup '
 	do
 		# Overwrite the files with the final content.
 		cp b$i $i &&
-		git add $i
+		git add $i || return 1
 	done &&
 	test_tick &&
 
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 67eed2fefc..c7d8e0bf00 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -117,7 +117,7 @@ test_expect_success 'follow-parent avoids deleting relevant info' '
 	mkdir -p import/trunk/subversion/bindings/swig/perl/t &&
 	for i in a b c ; do \
 	  echo $i > import/trunk/subversion/bindings/swig/perl/$i.pm &&
-	  echo _$i > import/trunk/subversion/bindings/swig/perl/t/$i.t; \
+	  echo _$i > import/trunk/subversion/bindings/swig/perl/t/$i.t || return 1
 	done &&
 	  echo "bad delete test" > \
 	   import/trunk/subversion/bindings/swig/perl/t/larger-parent &&
@@ -134,7 +134,7 @@ test_expect_success 'follow-parent avoids deleting relevant info' '
 		svn mv t native/t &&
 		for i in a b c
 		do
-			svn mv $i.pm native/$i.pm
+			svn mv $i.pm native/$i.pm || return 1
 		done &&
 		echo z >>native/t/c.t &&
 		poke native/t/c.t &&
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index b4081fefba..90325db909 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -15,7 +15,7 @@ EOF
 test_expect_success 'setup svnrepo' '
 	for i in aa bb cc dd
 	do
-		svn_cmd mkdir -m $i --username $i "$svnrepo"/$i
+		svn_cmd mkdir -m $i --username $i "$svnrepo"/$i || return 1
 	done
 	'
 
@@ -60,7 +60,7 @@ test_expect_success 'authors-file against globs' '
 	for i in bb ee cc
 	do
 		branch="aa/branches/$i" &&
-		svn_cmd mkdir -m "$branch" --username $i "$svnrepo/$branch"
+		svn_cmd mkdir -m "$branch" --username $i "$svnrepo/$branch" || return 1
 	done
 	'
 
diff --git a/t/t9134-git-svn-ignore-paths.sh b/t/t9134-git-svn-ignore-paths.sh
index fff49c4100..4a77eb9f60 100755
--- a/t/t9134-git-svn-ignore-paths.sh
+++ b/t/t9134-git-svn-ignore-paths.sh
@@ -27,7 +27,7 @@ test_expect_success 'setup test repository' '
 test_expect_success 'clone an SVN repository with ignored www directory' '
 	git svn clone --ignore-paths="^www" "$svnrepo" g &&
 	echo test_qqq > expect &&
-	for i in g/*/*.txt; do cat $i >> expect2; done &&
+	for i in g/*/*.txt; do cat $i >> expect2 || return 1; done &&
 	test_cmp expect expect2
 '
 
@@ -36,7 +36,7 @@ test_expect_success 'init+fetch an SVN repository with ignored www directory' '
 	( cd c && git svn fetch --ignore-paths="^www" ) &&
 	rm expect2 &&
 	echo test_qqq > expect &&
-	for i in c/*/*.txt; do cat $i >> expect2; done &&
+	for i in c/*/*.txt; do cat $i >> expect2 || return 1; done &&
 	test_cmp expect expect2
 '
 
@@ -62,7 +62,7 @@ test_expect_success 'update git svn-cloned repo (config ignore)' '
 		cd g &&
 		git svn rebase &&
 		printf "test_qqq\nb\n" > expect &&
-		for i in */*.txt; do cat $i >> expect2; done &&
+		for i in */*.txt; do cat $i >> expect2 || exit 1; done &&
 		test_cmp expect2 expect &&
 		rm expect expect2
 	)
@@ -73,7 +73,7 @@ test_expect_success 'update git svn-cloned repo (option ignore)' '
 		cd c &&
 		git svn rebase --ignore-paths="^www" &&
 		printf "test_qqq\nb\n" > expect &&
-		for i in */*.txt; do cat $i >> expect2; done &&
+		for i in */*.txt; do cat $i >> expect2 || exit 1; done &&
 		test_cmp expect2 expect &&
 		rm expect expect2
 	)
@@ -94,7 +94,7 @@ test_expect_success 'update git svn-cloned repo (config ignore)' '
 		cd g &&
 		git svn rebase &&
 		printf "test_qqq\nb\n" > expect &&
-		for i in */*.txt; do cat $i >> expect2; done &&
+		for i in */*.txt; do cat $i >> expect2 || exit 1; done &&
 		test_cmp expect2 expect &&
 		rm expect expect2
 	)
@@ -105,7 +105,7 @@ test_expect_success 'update git svn-cloned repo (option ignore)' '
 		cd c &&
 		git svn rebase --ignore-paths="^www" &&
 		printf "test_qqq\nb\n" > expect &&
-		for i in */*.txt; do cat $i >> expect2; done &&
+		for i in */*.txt; do cat $i >> expect2 || exit 1; done &&
 		test_cmp expect2 expect &&
 		rm expect expect2
 	)
@@ -127,7 +127,7 @@ test_expect_success 'update git svn-cloned repo again (config ignore)' '
 		cd g &&
 		git svn rebase &&
 		printf "test_qqq\nb\nygg\n" > expect &&
-		for i in */*.txt; do cat $i >> expect2; done &&
+		for i in */*.txt; do cat $i >> expect2 || exit 1; done &&
 		test_cmp expect2 expect &&
 		rm expect expect2
 	)
@@ -138,7 +138,7 @@ test_expect_success 'update git svn-cloned repo again (option ignore)' '
 		cd c &&
 		git svn rebase --ignore-paths="^www" &&
 		printf "test_qqq\nb\nygg\n" > expect &&
-		for i in */*.txt; do cat $i >> expect2; done &&
+		for i in */*.txt; do cat $i >> expect2 || exit 1; done &&
 		test_cmp expect2 expect &&
 		rm expect expect2
 	)
diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
index 027b416720..784ec7fc2d 100755
--- a/t/t9138-git-svn-authors-prog.sh
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -27,7 +27,7 @@ test_expect_success 'svn-authors setup' '
 test_expect_success 'setup svnrepo' '
 	for i in aa bb cc-sub dd-sub ee-foo ff
 	do
-		svn mkdir -m $i --username $i "$svnrepo"/$i
+		svn mkdir -m $i --username $i "$svnrepo"/$i || return 1
 	done
 '
 
diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
index 5f91c0d68b..80cb55fee7 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -8,7 +8,7 @@ test_description='git svn creates empty directories'
 test_expect_success 'initialize repo' '
 	for i in a b c d d/e d/e/f "weird file name"
 	do
-		svn_cmd mkdir -m "mkdir $i" "$svnrepo"/"$i"
+		svn_cmd mkdir -m "mkdir $i" "$svnrepo"/"$i" || return 1
 	done
 '
 
@@ -102,7 +102,7 @@ test_expect_success 'git svn mkdirs -r works' '
 test_expect_success 'initialize trunk' '
 	for i in trunk trunk/a trunk/"weird file name"
 	do
-		svn_cmd mkdir -m "mkdir $i" "$svnrepo"/"$i"
+		svn_cmd mkdir -m "mkdir $i" "$svnrepo"/"$i" || return 1
 	done
 '
 
diff --git a/t/t9147-git-svn-include-paths.sh b/t/t9147-git-svn-include-paths.sh
index d292bf9f55..257fc8f2f8 100755
--- a/t/t9147-git-svn-include-paths.sh
+++ b/t/t9147-git-svn-include-paths.sh
@@ -28,7 +28,7 @@ test_expect_success 'setup test repository' '
 test_expect_success 'clone an SVN repository with filter to include qqq directory' '
 	git svn clone --include-paths="qqq" "$svnrepo" g &&
 	echo test_qqq > expect &&
-	for i in g/*/*.txt; do cat $i >> expect2; done &&
+	for i in g/*/*.txt; do cat $i >> expect2 || return 1; done &&
 	test_cmp expect expect2
 '
 
@@ -38,7 +38,7 @@ test_expect_success 'init+fetch an SVN repository with included qqq directory' '
 	( cd c && git svn fetch --include-paths="qqq" ) &&
 	rm expect2 &&
 	echo test_qqq > expect &&
-	for i in c/*/*.txt; do cat $i >> expect2; done &&
+	for i in c/*/*.txt; do cat $i >> expect2 || return 1; done &&
 	test_cmp expect expect2
 '
 
@@ -64,7 +64,7 @@ test_expect_success 'update git svn-cloned repo (config include)' '
 		cd g &&
 		git svn rebase &&
 		printf "test_qqq\nb\n" > expect &&
-		for i in */*.txt; do cat $i >> expect2; done &&
+		for i in */*.txt; do cat $i >> expect2 || exit 1; done &&
 		test_cmp expect2 expect &&
 		rm expect expect2
 	)
@@ -75,7 +75,7 @@ test_expect_success 'update git svn-cloned repo (option include)' '
 		cd c &&
 		git svn rebase --include-paths="qqq" &&
 		printf "test_qqq\nb\n" > expect &&
-		for i in */*.txt; do cat $i >> expect2; done &&
+		for i in */*.txt; do cat $i >> expect2 || exit 1; done &&
 		test_cmp expect2 expect &&
 		rm expect expect2
 	)
@@ -96,7 +96,7 @@ test_expect_success 'update git svn-cloned repo (config include)' '
 		cd g &&
 		git svn rebase &&
 		printf "test_qqq\nb\n" > expect &&
-		for i in */*.txt; do cat $i >> expect2; done &&
+		for i in */*.txt; do cat $i >> expect2 || exit 1; done &&
 		test_cmp expect2 expect &&
 		rm expect expect2
 	)
@@ -107,7 +107,7 @@ test_expect_success 'update git svn-cloned repo (option include)' '
 		cd c &&
 		git svn rebase --include-paths="qqq" &&
 		printf "test_qqq\nb\n" > expect &&
-		for i in */*.txt; do cat $i >> expect2; done &&
+		for i in */*.txt; do cat $i >> expect2 || exit 1; done &&
 		test_cmp expect2 expect &&
 		rm expect expect2
 	)
@@ -129,7 +129,7 @@ test_expect_success 'update git svn-cloned repo again (config include)' '
 		cd g &&
 		git svn rebase &&
 		printf "test_qqq\nb\nygg\n" > expect &&
-		for i in */*.txt; do cat $i >> expect2; done &&
+		for i in */*.txt; do cat $i >> expect2 || exit 1; done &&
 		test_cmp expect2 expect &&
 		rm expect expect2
 	)
@@ -140,7 +140,7 @@ test_expect_success 'update git svn-cloned repo again (option include)' '
 		cd c &&
 		git svn rebase --include-paths="qqq" &&
 		printf "test_qqq\nb\nygg\n" > expect &&
-		for i in */*.txt; do cat $i >> expect2; done &&
+		for i in */*.txt; do cat $i >> expect2 || exit 1; done &&
 		test_cmp expect2 expect &&
 		rm expect expect2
 	)
diff --git a/t/t9152-svn-empty-dirs-after-gc.sh b/t/t9152-svn-empty-dirs-after-gc.sh
index 89f285d082..a597c42f77 100755
--- a/t/t9152-svn-empty-dirs-after-gc.sh
+++ b/t/t9152-svn-empty-dirs-after-gc.sh
@@ -8,7 +8,7 @@ test_description='git svn creates empty directories, calls git gc, makes sure th
 test_expect_success 'initialize repo' '
 	for i in a b c d d/e d/e/f "weird file name"
 	do
-		svn_cmd mkdir -m "mkdir $i" "$svnrepo"/"$i"
+		svn_cmd mkdir -m "mkdir $i" "$svnrepo"/"$i" || return 1
 	done
 '
 
diff --git a/t/t9304-fast-import-marks.sh b/t/t9304-fast-import-marks.sh
index d4359dba21..bed01c99ea 100755
--- a/t/t9304-fast-import-marks.sh
+++ b/t/t9304-fast-import-marks.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup large marks file' '
 	blob=$(git rev-parse HEAD:one.t) &&
 	for i in $(test_seq 1024 16384)
 	do
-		echo ":$i $blob"
+		echo ":$i $blob" || return 1
 	done >>marks
 '
 
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index a60fe2e19f..dd378df730 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -338,7 +338,7 @@ test_expect_success 'cvs update (subdirectories)' \
   '(for dir in A A/B A/B/C A/D E; do
       mkdir $dir &&
       echo "test file in $dir" >"$dir/file_in_$(echo $dir|sed -e "s#/# #g")"  &&
-      git add $dir
+      git add $dir || exit 1
    done) &&
    git commit -q -m "deep sub directory structure" &&
    git push gitcvs.git >/dev/null &&
@@ -381,7 +381,7 @@ test_expect_success 'cvs update (merge)' \
    for i in 1 2 3 4 5 6 7
    do
      echo Line $i >>merge &&
-     echo Line $i >>expected
+     echo Line $i >>expected || return 1
    done &&
    echo Line 8 >>expected &&
    git add merge &&
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 81bc8e8da1..806005a793 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -171,7 +171,7 @@ test_expect_success 'clone using non-numeric revision ranges' '
 			cd "$git" &&
 			git ls-files >lines &&
 			test_line_count = 8 lines
-		)
+		) || return 1
 	done
 '
 
diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
index 0db7ab9918..de591d875c 100755
--- a/t/t9818-git-p4-block.sh
+++ b/t/t9818-git-p4-block.sh
@@ -92,11 +92,11 @@ test_expect_success 'Add some more files' '
 	for i in $(test_seq 0 10)
 	do
 		p4_add_file "included/x$i" &&
-		p4_add_file "excluded/x$i"
+		p4_add_file "excluded/x$i" || return 1
 	done &&
 	for i in $(test_seq 0 10)
 	do
-		p4_add_file "excluded/y$i"
+		p4_add_file "excluded/y$i" || return 1
 	done
 '
 
@@ -123,7 +123,7 @@ test_expect_success 'Create a repo with multiple depot paths' '
 	do
 		for i in $(test_seq 1 10)
 		do
-			p4_add_file "$p/file$p$i"
+			p4_add_file "$p/file$p$i" || return 1
 		done
 	done
 '
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 518203fbe0..caa9d2dc9b 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -879,7 +879,7 @@ test_expect_success '__git_refs - unique remote branches for git checkout DWIMer
 		refs/remotes/remote/branch-in-remote
 	do
 		git update-ref $remote_ref main &&
-		test_when_finished "git update-ref -d $remote_ref"
+		test_when_finished "git update-ref -d $remote_ref" || return 1
 	done &&
 	(
 		cur= &&
@@ -1052,7 +1052,7 @@ test_expect_success '__git_refs - only matching refs - checkout DWIMery' '
 		refs/remotes/remote/branch-in-remote
 	do
 		git update-ref $remote_ref main &&
-		test_when_finished "git update-ref -d $remote_ref"
+		test_when_finished "git update-ref -d $remote_ref" || return 1
 	done &&
 	(
 		cur=mat &&
-- 
2.34.1.307.g9b7440fafd

