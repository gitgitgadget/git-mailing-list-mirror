Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E2C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhLIFP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhLIFPu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:50 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED722C061D72
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:16 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z18so5336853iof.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LAJGHStKektvvifAkNEUoZJ7kBUKIx2m1MLBGlNzJJs=;
        b=hBCJLg9tLx1/N20L6GY0ggtQXOBIw/M1no6I8ZgUTaTQWP7sgsoF858ScvpedJ/ZjG
         naxiiWz+jIiNPYdVsPD+iBApa81JZ7gze/pLositgazHBhYAX0LJBbLJLcF9XN63LKmo
         kNPE0dZcZWBkYfVNY8vJ78aO0+oowhK96wyG9Wqsb9jPNpF1Gsio2EbNRhiSo5a7OwK7
         1u9czKtuiaCX6Ga3fbDOBrjey1cHt02uWHkZ5l2f6uB1YWOsuZy82wWJVvi72025bf/I
         7LHLSCmu2g37ZpbJR6RzSkRvljWdJirG2yz0oIXxTDcqhDHSF29kCYaUpDClka7LMMCg
         otqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LAJGHStKektvvifAkNEUoZJ7kBUKIx2m1MLBGlNzJJs=;
        b=3WM/mEmP4sew+yeON46a5Fob9wb+ngBP5ukhfiYOLQO6sc0xzZU3VVa3NA0YLjX6OO
         RYKfQv974Dc/mJ/ez+TTVjcBfeTw/5Sf6jP3eAdtpYPvpH1Db8GQp8MfKwnTCi3mBD6e
         ZROIwtMx72bZEWDoVojjIB7TivNmatwKH+fDyjQv1hF1AYF8JwrHKDV5+ZKRjpDQnwvN
         fFeCDXvqieBc7B1gJKvvyBYC16Z1MPTL9fsEutdH/4JVqTkewtZS0nQkf4Zl9Wz+M9fT
         cWJPraIXEaC+Mi02qSeTiKH668fn3G34IqbuRM8lsctOq8Z9TT5cuEdZooWchrpXmfxn
         JOag==
X-Gm-Message-State: AOAM533WFllpxA4F1xg4+Htl2YLNENu0sbMOgafUIwTBleZNAfNMDMJJ
        uaJjiyI+Ik0Xk4usFaNxOU3HAJOX+bckSQ==
X-Google-Smtp-Source: ABdhPJy3Au2Av8ZYVv875iKYFmJiVlLf8xoeXQ148hJw2ztEAzG7+q/ZZ012plCGWsBRNxyyLV6jLg==
X-Received: by 2002:a05:6638:4091:: with SMTP id m17mr5956906jam.41.1639026734913;
        Wed, 08 Dec 2021 21:12:14 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:14 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 09/19] tests: use test_write_lines() to generate line-oriented output
Date:   Thu,  9 Dec 2021 00:11:05 -0500
Message-Id: <20211209051115.52629-10-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take advantage of test_write_lines() to generate line-oriented output
rather than using for-loops or a series of `echo` commands. Not only is
test_write_lines() a natural fit for such a task, but there is less
opportunity for a broken &&-chain.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t0020-crlf.sh                        | 28 ++++++-------
 t/t0026-eol-config.sh                  |  4 +-
 t/t1020-subdirectory.sh                |  4 +-
 t/t1512-rev-parse-disambiguation.sh    | 10 +----
 t/t2103-update-index-ignore-missing.sh |  2 +-
 t/t3417-rebase-whitespace-fix.sh       |  4 +-
 t/t4013-diff-various.sh                | 22 +++++-----
 t/t4014-format-patch.sh                | 26 ++++++------
 t/t4019-diff-wserror.sh                |  4 +-
 t/t4105-apply-fuzz.sh                  | 10 +----
 t/t4116-apply-reverse.sh               |  4 +-
 t/t4117-apply-reject.sh                | 20 ++-------
 t/t4118-apply-empty-context.sh         |  6 +--
 t/t4124-apply-ws-rule.sh               | 56 +++++++++++++-------------
 t/t4126-apply-empty.sh                 |  5 +--
 t/t4127-apply-same-fn.sh               |  5 +--
 t/t4151-am-abort.sh                    | 10 +----
 t/t5300-pack-object.sh                 | 12 +-----
 t/t5306-pack-nobase.sh                 |  2 +-
 t/t5611-clone-config.sh                |  2 +-
 t/t6019-rev-list-ancestry-path.sh      | 10 ++---
 t/t6060-merge-index.sh                 |  4 +-
 t/t6409-merge-subtree.sh               |  6 +--
 t/t6417-merge-ours-theirs.sh           |  5 +--
 t/t7501-commit-basic-functionality.sh  |  5 +--
 t/t8003-blame-corner-cases.sh          | 10 +----
 26 files changed, 106 insertions(+), 170 deletions(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index f25ae8b5e1..0bd6ff21c8 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -22,10 +22,10 @@ test_expect_success setup '
 
 	git config core.autocrlf false &&
 
-	for w in Hello world how are you; do echo $w; done >one &&
+	test_write_lines Hello world how are you >one &&
 	mkdir dir &&
-	for w in I am very very fine thank you; do echo $w; done >dir/two &&
-	for w in Oh here is NULQin text here; do echo $w; done | q_to_nul >three &&
+	test_write_lines I am very very fine thank you >dir/two &&
+	test_write_lines Oh here is NULQin text here | q_to_nul >three &&
 	git add . &&
 
 	git commit -m initial &&
@@ -35,7 +35,7 @@ test_expect_success setup '
 	two=$(git rev-parse HEAD:dir/two) &&
 	three=$(git rev-parse HEAD:three) &&
 
-	for w in Some extra lines here; do echo $w; done >>one &&
+	test_write_lines Some extra lines here >>one &&
 	git diff >patch.file &&
 	patched=$(git hash-object --stdin <one) &&
 	git read-tree --reset -u HEAD
@@ -46,7 +46,7 @@ test_expect_success 'safecrlf: autocrlf=input, all CRLF' '
 	git config core.autocrlf input &&
 	git config core.safecrlf true &&
 
-	for w in I am all CRLF; do echo $w; done | append_cr >allcrlf &&
+	test_write_lines I am all CRLF | append_cr >allcrlf &&
 	test_must_fail git add allcrlf
 '
 
@@ -55,7 +55,7 @@ test_expect_success 'safecrlf: autocrlf=input, mixed LF/CRLF' '
 	git config core.autocrlf input &&
 	git config core.safecrlf true &&
 
-	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >mixed &&
+	test_write_lines Oh here is CRLFQ in text | q_to_cr >mixed &&
 	test_must_fail git add mixed
 '
 
@@ -64,7 +64,7 @@ test_expect_success 'safecrlf: autocrlf=true, all LF' '
 	git config core.autocrlf true &&
 	git config core.safecrlf true &&
 
-	for w in I am all LF; do echo $w; done >alllf &&
+	test_write_lines I am all LF >alllf &&
 	test_must_fail git add alllf
 '
 
@@ -73,7 +73,7 @@ test_expect_success 'safecrlf: autocrlf=true mixed LF/CRLF' '
 	git config core.autocrlf true &&
 	git config core.safecrlf true &&
 
-	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >mixed &&
+	test_write_lines Oh here is CRLFQ in text | q_to_cr >mixed &&
 	test_must_fail git add mixed
 '
 
@@ -82,10 +82,10 @@ test_expect_success 'safecrlf: print warning only once' '
 	git config core.autocrlf input &&
 	git config core.safecrlf warn &&
 
-	for w in I am all LF; do echo $w; done >doublewarn &&
+	test_write_lines I am all LF >doublewarn &&
 	git add doublewarn &&
 	git commit -m "nowarn" &&
-	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >doublewarn &&
+	test_write_lines Oh here is CRLFQ in text | q_to_cr >doublewarn &&
 	git add doublewarn 2>err &&
 	grep "CRLF will be replaced by LF" err >err.warnings &&
 	test_line_count = 1 err.warnings
@@ -103,7 +103,7 @@ test_expect_success 'safecrlf: no warning with safecrlf=false' '
 	git config core.autocrlf input &&
 	git config core.safecrlf false &&
 
-	for w in I am all CRLF; do echo $w; done | append_cr >allcrlf &&
+	test_write_lines I am all CRLF | append_cr >allcrlf &&
 	git add allcrlf 2>err &&
 	test_must_be_empty err
 '
@@ -351,9 +351,9 @@ test_expect_success 'setting up for new autocrlf tests' '
 	git config core.autocrlf false &&
 	git config core.safecrlf false &&
 	rm -rf .????* * &&
-	for w in I am all LF; do echo $w; done >alllf &&
-	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >mixed &&
-	for w in I am all CRLF; do echo $w; done | append_cr >allcrlf &&
+	test_write_lines I am all LF >alllf &&
+	test_write_lines Oh here is CRLFQ in text | q_to_cr >mixed &&
+	test_write_lines I am all CRLF | append_cr >allcrlf &&
 	git add -A . &&
 	git commit -m "alllf, allcrlf and mixed only" &&
 	git tag -a -m "message" autocrlf-checkpoint
diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
index cdcafcdff7..f426a185bb 100755
--- a/t/t0026-eol-config.sh
+++ b/t/t0026-eol-config.sh
@@ -15,8 +15,8 @@ test_expect_success setup '
 
 	echo "one text" > .gitattributes &&
 
-	for w in Hello world how are you; do echo $w; done >one &&
-	for w in I am very very fine thank you; do echo $w; done >two &&
+	test_write_lines Hello world how are you >one &&
+	test_write_lines I am very very fine thank you >two &&
 	git add . &&
 
 	git commit -m initial &&
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index da19c06fb5..9fdbb2af80 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -11,9 +11,9 @@ test_description='Try various core-level commands in subdirectory.
 
 test_expect_success setup '
 	long="a b c d e f g h i j k l m n o p q r s t u v w x y z" &&
-	for c in $long; do echo $c; done >one &&
+	test_write_lines $long >one &&
 	mkdir dir &&
-	for c in x y z $long a b c; do echo $c; done >dir/two &&
+	test_write_lines x y z $long a b c >dir/two &&
 	cp one original.one &&
 	cp dir/two original.two
 '
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 7891a6becf..15188a408b 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -34,10 +34,7 @@ fi
 test_expect_success 'blob and tree' '
 	test_tick &&
 	(
-		for i in 0 1 2 3 4 5 6 7 8 9
-		do
-			echo $i
-		done &&
+		test_write_lines 0 1 2 3 4 5 6 7 8 9 &&
 		echo &&
 		echo b1rwzyc3
 	) >a0blgqsjc &&
@@ -204,10 +201,7 @@ test_expect_success 'more history' '
 	git checkout v1.0.0^0 &&
 	git mv a0blgqsjc f5518nwu &&
 
-	for i in h62xsjeu j08bekfvt kg7xflhm
-	do
-		echo $i
-	done >>f5518nwu &&
+	test_write_lines h62xsjeu j08bekfvt kg7xflhm >>f5518nwu &&
 	git add f5518nwu &&
 
 	test_tick &&
diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-index-ignore-missing.sh
index 0114f05228..6938ecca86 100755
--- a/t/t2103-update-index-ignore-missing.sh
+++ b/t/t2103-update-index-ignore-missing.sh
@@ -23,7 +23,7 @@ test_expect_success basics '
 	test_cmp expect actual &&
 
 	git update-index --add one two three &&
-	for i in one three two; do echo $i; done >expect &&
+	test_write_lines one three two >expect &&
 	git ls-files >actual &&
 	test_cmp expect actual &&
 
diff --git a/t/t3417-rebase-whitespace-fix.sh b/t/t3417-rebase-whitespace-fix.sh
index 946e92f8da..96f2cf22fa 100755
--- a/t/t3417-rebase-whitespace-fix.sh
+++ b/t/t3417-rebase-whitespace-fix.sh
@@ -115,9 +115,7 @@ test_expect_success 'at beginning of file' '
 	git config core.whitespace "blank-at-eol" &&
 	cp beginning file &&
 	git commit -m beginning file &&
-	for i in 1 2 3 4 5; do
-		echo $i
-	done >> file &&
+	test_write_lines 1 2 3 4 5 >>file &&
 	git commit -m more file &&
 	git rebase --whitespace=fix HEAD^^ &&
 	test_cmp expect-beginning file
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 28683d059d..750aee17ea 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -19,8 +19,8 @@ test_expect_success setup '
 
 	mkdir dir &&
 	mkdir dir2 &&
-	for i in 1 2 3; do echo $i; done >file0 &&
-	for i in A B; do echo $i; done >dir/sub &&
+	test_write_lines 1 2 3 >file0 &&
+	test_write_lines A B >dir/sub &&
 	cat file0 >file2 &&
 	git add file0 file2 dir/sub &&
 	git commit -m Initial &&
@@ -32,8 +32,8 @@ test_expect_success setup '
 	GIT_COMMITTER_DATE="2006-06-26 00:01:00 +0000" &&
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
 
-	for i in 4 5 6; do echo $i; done >>file0 &&
-	for i in C D; do echo $i; done >>dir/sub &&
+	test_write_lines 4 5 6 >>file0 &&
+	test_write_lines C D >>dir/sub &&
 	rm -f file2 &&
 	git update-index --remove file0 file2 dir/sub &&
 	git commit -m "Second${LF}${LF}This is the second commit." &&
@@ -42,9 +42,9 @@ test_expect_success setup '
 	GIT_COMMITTER_DATE="2006-06-26 00:02:00 +0000" &&
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
 
-	for i in A B C; do echo $i; done >file1 &&
+	test_write_lines A B C >file1 &&
 	git add file1 &&
-	for i in E F; do echo $i; done >>dir/sub &&
+	test_write_lines E F >>dir/sub &&
 	git update-index dir/sub &&
 	git commit -m Third &&
 
@@ -53,8 +53,8 @@ test_expect_success setup '
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
 
 	git checkout side &&
-	for i in A B C; do echo $i; done >>file0 &&
-	for i in 1 2; do echo $i; done >>dir/sub &&
+	test_write_lines A B C >>file0 &&
+	test_write_lines 1 2 >>dir/sub &&
 	cat dir/sub >file3 &&
 	git add file3 &&
 	git update-index file0 dir/sub &&
@@ -71,8 +71,8 @@ test_expect_success setup '
 	GIT_COMMITTER_DATE="2006-06-26 00:05:00 +0000" &&
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
 
-	for i in A B C; do echo $i; done >>file0 &&
-	for i in 1 2; do echo $i; done >>dir/sub &&
+	test_write_lines A B C >>file0 &&
+	test_write_lines 1 2 >>dir/sub &&
 	git update-index file0 dir/sub &&
 
 	mkdir dir3 &&
@@ -86,7 +86,7 @@ test_expect_success setup '
 	GIT_COMMITTER_DATE="2006-06-26 00:06:00 +0000" &&
 	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
 	git checkout -b rearrange initial &&
-	for i in B A; do echo $i; done >dir/sub &&
+	test_write_lines B A >dir/sub &&
 	git add dir/sub &&
 	git commit -m "Rearranged lines in dir/sub" &&
 	git checkout master &&
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 712d4b5ddf..eefe815fca 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -12,25 +12,25 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success setup '
-	for i in 1 2 3 4 5 6 7 8 9 10; do echo "$i"; done >file &&
+	test_write_lines 1 2 3 4 5 6 7 8 9 10 >file &&
 	cat file >elif &&
 	git add file elif &&
 	test_tick &&
 	git commit -m Initial &&
 	git checkout -b side &&
 
-	for i in 1 2 5 6 A B C 7 8 9 10; do echo "$i"; done >file &&
+	test_write_lines 1 2 5 6 A B C 7 8 9 10 >file &&
 	test_chmod +x elif &&
 	test_tick &&
 	git commit -m "Side changes #1" &&
 
-	for i in D E F; do echo "$i"; done >>file &&
+	test_write_lines D E F >>file &&
 	git update-index file &&
 	test_tick &&
 	git commit -m "Side changes #2" &&
 	git tag C2 &&
 
-	for i in 5 6 1 2 3 A 4 B C 7 8 9 10 D E F; do echo "$i"; done >file &&
+	test_write_lines 5 6 1 2 3 A 4 B C 7 8 9 10 D E F >file &&
 	git update-index file &&
 	test_tick &&
 	git commit -m "Side changes #3 with \\n backslash-n in it." &&
@@ -43,18 +43,18 @@ test_expect_success setup '
 
 	git checkout side &&
 	git checkout -b patchid &&
-	for i in 5 6 1 2 3 A 4 B C 7 8 9 10 D E F; do echo "$i"; done >file2 &&
-	for i in 1 2 3 A 4 B C 7 8 9 10 D E F 5 6; do echo "$i"; done >file3 &&
-	for i in 8 9 10; do echo "$i"; done >file &&
+	test_write_lines 5 6 1 2 3 A 4 B C 7 8 9 10 D E F >file2 &&
+	test_write_lines 1 2 3 A 4 B C 7 8 9 10 D E F 5 6 >file3 &&
+	test_write_lines 8 9 10 >file &&
 	git add file file2 file3 &&
 	test_tick &&
 	git commit -m "patchid 1" &&
-	for i in 4 A B 7 8 9 10; do echo "$i"; done >file2 &&
-	for i in 8 9 10 5 6; do echo "$i"; done >file3 &&
+	test_write_lines 4 A B 7 8 9 10 >file2 &&
+	test_write_lines 8 9 10 5 6 >file3 &&
 	git add file2 file3 &&
 	test_tick &&
 	git commit -m "patchid 2" &&
-	for i in 10 5 6; do echo "$i"; done >file &&
+	test_write_lines 10 5 6 >file &&
 	git add file &&
 	test_tick &&
 	git commit -m "patchid 3" &&
@@ -653,7 +653,7 @@ test_expect_success 'excessive subject' '
 	git checkout side &&
 	before=$(git hash-object file) &&
 	before=$(git rev-parse --short $before) &&
-	for i in 5 6 1 2 3 A 4 B C 7 8 9 10 D E F; do echo "$i"; done >>file &&
+	test_write_lines 5 6 1 2 3 A 4 B C 7 8 9 10 D E F >>file &&
 	after=$(git hash-object file) &&
 	after=$(git rev-parse --short $after) &&
 	git update-index file &&
@@ -1086,7 +1086,7 @@ test_expect_success TTY 'format-patch --stdout paginates' '
 test_expect_success 'format-patch handles multi-line subjects' '
 	rm -rf patches/ &&
 	echo content >>file &&
-	for i in one two three; do echo $i; done >msg &&
+	test_write_lines one two three >msg &&
 	git add file &&
 	git commit -F msg &&
 	git format-patch -o patches -1 &&
@@ -1098,7 +1098,7 @@ test_expect_success 'format-patch handles multi-line subjects' '
 test_expect_success 'format-patch handles multi-line encoded subjects' '
 	rm -rf patches/ &&
 	echo content >>file &&
-	for i in en två tre; do echo $i; done >msg &&
+	test_write_lines en två tre >msg &&
 	git add file &&
 	git commit -F msg &&
 	git format-patch -o patches -1 &&
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index c68729ac09..d2b3109c2d 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -287,9 +287,9 @@ test_expect_success 'do not color trailing cr in context' '
 '
 
 test_expect_success 'color new trailing blank lines' '
-	{ echo a; echo b; echo; echo; } >x &&
+	test_write_lines a b "" "" >x &&
 	git add x &&
-	{ echo a; echo; echo; echo; echo c; echo; echo; echo; echo; } >x &&
+	test_write_lines a "" "" "" c "" "" "" "" >x &&
 	git diff --color x >output &&
 	cnt=$($grep_a "${blue_grep}" output | wc -l) &&
 	test $cnt = 2
diff --git a/t/t4105-apply-fuzz.sh b/t/t4105-apply-fuzz.sh
index 3266e39400..b80ec20801 100755
--- a/t/t4105-apply-fuzz.sh
+++ b/t/t4105-apply-fuzz.sh
@@ -15,15 +15,9 @@ dotest () {
 
 test_expect_success setup '
 
-	for i in 1 2 3 4 5 6 7 8 9 10 11 12
-	do
-		echo $i
-	done >file &&
+	test_write_lines 1 2 3 4 5 6 7 8 9 10 11 12 >file &&
 	git update-index --add file &&
-	for i in 1 2 3 4 5 6 7 a b c d e 8 9 10 11 12
-	do
-		echo $i
-	done >file &&
+	test_write_lines 1 2 3 4 5 6 7 a b c d e 8 9 10 11 12 >file &&
 	cat file >expect &&
 	git diff >O0.diff &&
 
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index b99e65c086..fa3fa44e51 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -11,14 +11,14 @@ test_description='git apply in reverse
 
 test_expect_success setup '
 
-	for i in a b c d e f g h i j k l m n; do echo $i; done >file1 &&
+	test_write_lines a b c d e f g h i j k l m n >file1 &&
 	perl -pe "y/ijk/\\000\\001\\002/" <file1 >file2 &&
 
 	git add file1 file2 &&
 	git commit -m initial &&
 	git tag initial &&
 
-	for i in a b c g h i J K L m o n p q; do echo $i; done >file1 &&
+	test_write_lines a b c g h i J K L m o n p q >file1 &&
 	perl -pe "y/mon/\\000\\001\\002/" <file1 >file2 &&
 
 	git commit -a -m second &&
diff --git a/t/t4117-apply-reject.sh b/t/t4117-apply-reject.sh
index 0ee93fe845..c86d05a96f 100755
--- a/t/t4117-apply-reject.sh
+++ b/t/t4117-apply-reject.sh
@@ -10,25 +10,16 @@ test_description='git apply with rejects
 . ./test-lib.sh
 
 test_expect_success setup '
-	for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
-	do
-		echo $i
-	done >file1 &&
+	test_write_lines 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 >file1 &&
 	cat file1 >saved.file1 &&
 	git update-index --add file1 &&
 	git commit -m initial &&
 
-	for i in 1 2 A B 4 5 6 7 8 9 10 11 12 C 13 14 15 16 17 18 19 20 D 21
-	do
-		echo $i
-	done >file1 &&
+	test_write_lines 1 2 A B 4 5 6 7 8 9 10 11 12 C 13 14 15 16 17 18 19 20 D 21 >file1 &&
 	git diff >patch.1 &&
 	cat file1 >clean &&
 
-	for i in 1 E 2 3 4 5 6 7 8 9 10 11 12 C 13 14 15 16 17 18 19 20 F 21
-	do
-		echo $i
-	done >expected &&
+	test_write_lines 1 E 2 3 4 5 6 7 8 9 10 11 12 C 13 14 15 16 17 18 19 20 F 21 >expected &&
 
 	mv file1 file2 &&
 	git update-index --add --remove file1 file2 &&
@@ -38,10 +29,7 @@ test_expect_success setup '
 	mv saved.file1 file1 &&
 	git update-index --add --remove file1 file2 &&
 
-	for i in 1 E 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 F 21
-	do
-		echo $i
-	done >file1 &&
+	test_write_lines 1 E 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 F 21 >file1 &&
 
 	cat file1 >saved.file1
 '
diff --git a/t/t4118-apply-empty-context.sh b/t/t4118-apply-empty-context.sh
index 65f2e4c3ef..1bce118600 100755
--- a/t/t4118-apply-empty-context.sh
+++ b/t/t4118-apply-empty-context.sh
@@ -10,11 +10,7 @@ test_description='git apply with new style GNU diff with empty context
 . ./test-lib.sh
 
 test_expect_success setup '
-	{
-		echo; echo;
-		echo A; echo B; echo C;
-		echo;
-	} >file1 &&
+	test_write_lines "" "" A B C "" >file1 &&
 	cat file1 >file1.orig &&
 	{
 		cat file1 &&
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 0ca29821ec..ebff6c6883 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -230,9 +230,9 @@ test_expect_success 'blank at EOF with --whitespace=fix (1)' '
 	test_might_fail git config --unset core.whitespace &&
 	rm -f .gitattributes &&
 
-	{ echo a; echo b; echo c; } >one &&
+	test_write_lines a b c >one &&
 	git add one &&
-	{ echo a; echo b; echo c; } >expect &&
+	test_write_lines a b c >expect &&
 	{ cat expect; echo; } >one &&
 	git diff -- one >patch &&
 
@@ -242,10 +242,10 @@ test_expect_success 'blank at EOF with --whitespace=fix (1)' '
 '
 
 test_expect_success 'blank at EOF with --whitespace=fix (2)' '
-	{ echo a; echo b; echo c; } >one &&
+	test_write_lines a b c >one &&
 	git add one &&
-	{ echo a; echo c; } >expect &&
-	{ cat expect; echo; echo; } >one &&
+	test_write_lines a b >expect &&
+	{ cat expect && test_write_lines "" ""; } >one &&
 	git diff -- one >patch &&
 
 	git checkout one &&
@@ -254,10 +254,10 @@ test_expect_success 'blank at EOF with --whitespace=fix (2)' '
 '
 
 test_expect_success 'blank at EOF with --whitespace=fix (3)' '
-	{ echo a; echo b; echo; } >one &&
+	test_write_lines a b "" >one &&
 	git add one &&
-	{ echo a; echo c; echo; } >expect &&
-	{ cat expect; echo; echo; } >one &&
+	test_write_lines a c "" >expect &&
+	{ cat expect && test_write_lines "" ""; } >one &&
 	git diff -- one >patch &&
 
 	git checkout one &&
@@ -266,9 +266,9 @@ test_expect_success 'blank at EOF with --whitespace=fix (3)' '
 '
 
 test_expect_success 'blank at end of hunk, not at EOF with --whitespace=fix' '
-	{ echo a; echo b; echo; echo; echo; echo; echo; echo d; } >one &&
+	test_write_lines a b "" "" "" "" "" d >one &&
 	git add one &&
-	{ echo a; echo c; echo; echo; echo; echo; echo; echo; echo d; } >expect &&
+	test_write_lines a b "" "" "" "" "" "" d >expect &&
 	cp expect one &&
 	git diff -- one >patch &&
 
@@ -278,7 +278,7 @@ test_expect_success 'blank at end of hunk, not at EOF with --whitespace=fix' '
 '
 
 test_expect_success 'blank at EOF with --whitespace=warn' '
-	{ echo a; echo b; echo c; } >one &&
+	test_write_lines a b c >one &&
 	git add one &&
 	echo >>one &&
 	cat one >expect &&
@@ -291,7 +291,7 @@ test_expect_success 'blank at EOF with --whitespace=warn' '
 '
 
 test_expect_success 'blank at EOF with --whitespace=error' '
-	{ echo a; echo b; echo c; } >one &&
+	test_write_lines a b c >one &&
 	git add one &&
 	cat one >expect &&
 	echo >>one &&
@@ -304,7 +304,7 @@ test_expect_success 'blank at EOF with --whitespace=error' '
 '
 
 test_expect_success 'blank but not empty at EOF' '
-	{ echo a; echo b; echo c; } >one &&
+	test_write_lines a b c >one &&
 	git add one &&
 	echo "   " >>one &&
 	cat one >expect &&
@@ -317,13 +317,13 @@ test_expect_success 'blank but not empty at EOF' '
 '
 
 test_expect_success 'applying beyond EOF requires one non-blank context line' '
-	{ echo; echo; echo; echo; } >one &&
+	test_write_lines "" "" "" "" >one &&
 	git add one &&
-	{ echo b; } >>one &&
+	echo b >>one &&
 	git diff -- one >patch &&
 
 	git checkout one &&
-	{ echo a; echo; } >one &&
+	test_write_lines a "" >one &&
 	cp one expect &&
 	test_must_fail git apply --whitespace=fix patch &&
 	test_cmp expect one &&
@@ -333,7 +333,7 @@ test_expect_success 'applying beyond EOF requires one non-blank context line' '
 
 test_expect_success 'tons of blanks at EOF should not apply' '
 	for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16; do
-		echo; echo; echo; echo;
+		test_write_lines "" "" "" ""
 	done >one &&
 	git add one &&
 	echo a >>one &&
@@ -362,9 +362,9 @@ test_expect_success 'missing blank line at end with --whitespace=fix' '
 '
 
 test_expect_success 'two missing blank lines at end with --whitespace=fix' '
-	{ echo a; echo; echo b; echo c; } >one &&
+	test_write_lines a "" b c >one &&
 	cp one no-blank-lines &&
-	{ echo; echo; } >>one &&
+	test_write_lines "" "" >>one &&
 	git add one &&
 	echo d >>one &&
 	cp one expect &&
@@ -381,9 +381,9 @@ test_expect_success 'two missing blank lines at end with --whitespace=fix' '
 '
 
 test_expect_success 'missing blank line at end, insert before end, --whitespace=fix' '
-	{ echo a; echo; } >one &&
+	test_write_lines a "" >one &&
 	git add one &&
-	{ echo b; echo a; echo; } >one &&
+	test_write_lines b a "" >one &&
 	cp one expect &&
 	git diff -- one >patch &&
 	echo a >one &&
@@ -393,10 +393,10 @@ test_expect_success 'missing blank line at end, insert before end, --whitespace=
 '
 
 test_expect_success 'shrink file with tons of missing blanks at end of file' '
-	{ echo a; echo b; echo c; } >one &&
+	test_write_lines a b c >one &&
 	cp one no-blank-lines &&
 	for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16; do
-		echo; echo; echo; echo;
+		test_write_lines "" "" "" ""
 	done >>one &&
 	git add one &&
 	echo a >one &&
@@ -412,9 +412,9 @@ test_expect_success 'shrink file with tons of missing blanks at end of file' '
 '
 
 test_expect_success 'missing blanks at EOF must only match blank lines' '
-	{ echo a; echo b; } >one &&
+	test_write_lines a b >one &&
 	git add one &&
-	{ echo c; echo d; } >>one &&
+	test_write_lines c d >>one &&
 	git diff -- one >patch &&
 
 	echo a >one &&
@@ -434,9 +434,9 @@ test_expect_success 'missing blank line should match context line with spaces' '
 	git add one &&
 	echo d >>one &&
 	git diff -- one >patch &&
-	{ echo a; echo b; echo c; } >one &&
+	test_write_lines a b c >one &&
 	cp one expect &&
-	{ echo; echo d; } >>expect &&
+	test_write_lines "" d >>expect &&
 	git add one &&
 
 	git apply --whitespace=fix patch &&
@@ -455,7 +455,7 @@ test_expect_success 'same, but with the --ignore-space-option' '
 	echo d >>one &&
 	cp one expect &&
 	git diff -- one >patch &&
-	{ echo a; echo b; echo c; } >one &&
+	test_write_lines a b c >one &&
 	git add one &&
 
 	git checkout-index -f one &&
diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index ceb6a79fe0..7391a5a1d2 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -9,10 +9,7 @@ test_expect_success setup '
 	git add empty &&
 	test_tick &&
 	git commit -m initial &&
-	for i in a b c d e
-	do
-		echo $i
-	done >empty &&
+	test_write_lines a b c d e >empty &&
 	cat empty >expect &&
 	git diff |
 	sed -e "/^diff --git/d" \
diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
index 305b7e649e..079872c714 100755
--- a/t/t4127-apply-same-fn.sh
+++ b/t/t4127-apply-same-fn.sh
@@ -10,10 +10,7 @@ modify () {
 }
 
 test_expect_success setup '
-	for i in a b c d e f g h i j k l m
-	do
-		echo $i
-	done >same_fn &&
+	test_write_lines a b c d e f g h i j k l m >same_fn &&
 	cp same_fn other_fn &&
 	git add same_fn other_fn &&
 	git commit -m initial
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 2374151662..5ed7e22827 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -5,10 +5,7 @@ test_description='am --abort'
 . ./test-lib.sh
 
 test_expect_success setup '
-	for i in a b c d e f g
-	do
-		echo $i
-	done >file-1 &&
+	test_write_lines a b c d e f g >file-1 &&
 	cp file-1 file-2 &&
 	test_tick &&
 	git add file-1 file-2 &&
@@ -43,10 +40,7 @@ do
 
 		test_must_fail git am$with3 000[1245]-*.patch &&
 		git log --pretty=tformat:%s >actual &&
-		for i in 3 2 initial
-		do
-			echo $i
-		done >expect &&
+		test_write_lines 3 2 initial >expect &&
 		test_cmp expect actual
 	'
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index e13a884207..f9877d42d7 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -361,11 +361,7 @@ test_expect_success 'unpacking with --strict' '
 	ST=$(git write-tree) &&
 	git rev-list --objects "$LIST" "$LI" "$ST" >actual &&
 	PACK5=$( git pack-objects test-5 <actual ) &&
-	PACK6=$( (
-			echo "$LIST"
-			echo "$LI"
-			echo "$ST"
-		 ) | git pack-objects test-6 ) &&
+	PACK6=$( test_write_lines "$LIST" "$LI" "$ST" | git pack-objects test-6 ) &&
 	test_create_repo test-5 &&
 	(
 		cd test-5 &&
@@ -408,11 +404,7 @@ test_expect_success 'index-pack with --strict' '
 	ST=$(git write-tree) &&
 	git rev-list --objects "$LIST" "$LI" "$ST" >actual &&
 	PACK5=$( git pack-objects test-5 <actual ) &&
-	PACK6=$( (
-			echo "$LIST"
-			echo "$LI"
-			echo "$ST"
-		 ) | git pack-objects test-6 ) &&
+	PACK6=$( test_write_lines "$LIST" "$LI" "$ST" | git pack-objects test-6 ) &&
 	test_create_repo test-7 &&
 	(
 		cd test-7 &&
diff --git a/t/t5306-pack-nobase.sh b/t/t5306-pack-nobase.sh
index f4931c0c2a..51973f4a51 100755
--- a/t/t5306-pack-nobase.sh
+++ b/t/t5306-pack-nobase.sh
@@ -12,7 +12,7 @@ test_description='git-pack-object with missing base
 #
 test_expect_success \
     'setup base' \
-    'for a in a b c d e f g h i; do echo $a >>text; done &&
+    'test_write_lines a b c d e f g h i >text &&
      echo side >side &&
      git update-index --add text side &&
      A=$(echo A | git commit-tree $(git write-tree)) &&
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index f8625f9158..4b3877216e 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -17,7 +17,7 @@ test_expect_success 'clone -c sets config in cloned repo' '
 test_expect_success 'clone -c can set multi-keys' '
 	rm -rf child &&
 	git clone -c core.foo=bar -c core.foo=baz . child &&
-	{ echo bar; echo baz; } >expect &&
+	test_write_lines bar baz >expect &&
 	git --git-dir=child/.git config --get-all core.foo >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index 20adbece65..af57a04b7f 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -51,7 +51,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'rev-list D..M' '
-	for c in E F G H I J K L M; do echo $c; done >expect &&
+	test_write_lines E F G H I J K L M >expect &&
 	git rev-list --format=%s D..M |
 	sed -e "/^commit /d" |
 	sort >actual &&
@@ -59,7 +59,7 @@ test_expect_success 'rev-list D..M' '
 '
 
 test_expect_success 'rev-list --ancestry-path D..M' '
-	for c in E F H I J L M; do echo $c; done >expect &&
+	test_write_lines E F H I J L M >expect &&
 	git rev-list --ancestry-path --format=%s D..M |
 	sed -e "/^commit /d" |
 	sort >actual &&
@@ -81,7 +81,7 @@ test_expect_success 'rev-list --ancestry-path D..M -- M.t' '
 '
 
 test_expect_success 'rev-list F...I' '
-	for c in F G H I; do echo $c; done >expect &&
+	test_write_lines F G H I >expect &&
 	git rev-list --format=%s F...I |
 	sed -e "/^commit /d" |
 	sort >actual &&
@@ -89,7 +89,7 @@ test_expect_success 'rev-list F...I' '
 '
 
 test_expect_success 'rev-list --ancestry-path F...I' '
-	for c in F H I; do echo $c; done >expect &&
+	test_write_lines F H I >expect &&
 	git rev-list --ancestry-path --format=%s F...I |
 	sed -e "/^commit /d" |
 	sort >actual &&
@@ -111,7 +111,7 @@ test_expect_success 'rev-list --ancestry-path G..M -- G.t' '
 '
 
 test_expect_success 'rev-list --ancestry-path --simplify-merges G^..M -- G.t' '
-	for c in G L; do echo $c; done >expect &&
+	test_write_lines G L >expect &&
 	git rev-list --ancestry-path --simplify-merges --format=%s G^..M -- G.t |
 	sed -e "/^commit /d" |
 	sort >actual &&
diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index ddf34f0115..ed449abe55 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -4,9 +4,7 @@ test_description='basic git merge-index / git-merge-one-file tests'
 . ./test-lib.sh
 
 test_expect_success 'setup diverging branches' '
-	for i in 1 2 3 4 5 6 7 8 9 10; do
-		echo $i
-	done >file &&
+	test_write_lines 1 2 3 4 5 6 7 8 9 10 >file &&
 	git add file &&
 	git commit -m base &&
 	git tag base &&
diff --git a/t/t6409-merge-subtree.sh b/t/t6409-merge-subtree.sh
index ba7890ec52..e9ba6f1690 100755
--- a/t/t6409-merge-subtree.sh
+++ b/t/t6409-merge-subtree.sh
@@ -10,7 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 test_expect_success setup '
 
 	s="1 2 3 4 5 6 7 8" &&
-	for i in $s; do echo $i; done >hello &&
+	test_write_lines $s >hello &&
 	git add hello &&
 	git commit -m initial &&
 	git checkout -b side &&
@@ -18,7 +18,7 @@ test_expect_success setup '
 	git add hello &&
 	git commit -m second &&
 	git checkout main &&
-	for i in mundo $s; do echo $i; done >hello &&
+	test_write_lines mundo $s >hello &&
 	git add hello &&
 	git commit -m main
 
@@ -27,7 +27,7 @@ test_expect_success setup '
 test_expect_success 'subtree available and works like recursive' '
 
 	git merge -s subtree side &&
-	for i in mundo $s world; do echo $i; done >expect &&
+	test_write_lines mundo $s world >expect &&
 	test_cmp expect hello
 
 '
diff --git a/t/t6417-merge-ours-theirs.sh b/t/t6417-merge-ours-theirs.sh
index ec065d6a65..62d1406119 100755
--- a/t/t6417-merge-ours-theirs.sh
+++ b/t/t6417-merge-ours-theirs.sh
@@ -7,10 +7,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success setup '
-	for i in 1 2 3 4 5 6 7 8 9
-	do
-		echo "$i"
-	done >file &&
+	test_write_lines 1 2 3 4 5 6 7 8 9 >file &&
 	git add file &&
 	cp file elif &&
 	git commit -m initial &&
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 512ae2781f..fb5417d5e7 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -667,10 +667,7 @@ test_expect_success 'amend can copy notes' '
 
 test_expect_success 'commit a file whose name is a dash' '
 	git reset --hard &&
-	for i in 1 2 3 4 5
-	do
-		echo $i
-	done >./- &&
+	test_write_lines 1 2 3 4 5 >./- &&
 	git add ./- &&
 	test_tick &&
 	git commit -m "add dash" >output </dev/null &&
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index da80f815ce..d751d48b7d 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -13,14 +13,8 @@ test_expect_success setup '
 	echo B B B B B >two &&
 	echo C C C C C >tres &&
 	echo ABC >mouse &&
-	for i in 1 2 3 4 5 6 7 8 9
-	do
-		echo $i
-	done >nine_lines &&
-	for i in 1 2 3 4 5 6 7 8 9 a
-	do
-		echo $i
-	done >ten_lines &&
+	test_write_lines 1 2 3 4 5 6 7 8 9 >nine_lines &&
+	test_write_lines 1 2 3 4 5 6 7 8 9 a >ten_lines &&
 	git add one two tres mouse nine_lines ten_lines &&
 	test_tick &&
 	GIT_AUTHOR_NAME=Initial git commit -m Initial &&
-- 
2.34.1.307.g9b7440fafd

