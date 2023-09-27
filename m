Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788A6E82CCF
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjI0T5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjI0T4f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:35 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07766CF3
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:13 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-76c64da0e46so425681439f.0
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844572; x=1696449372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIp5xN1/FiLxLp7U+weLwdU6T91ZE64ygxLvw8ASvC4=;
        b=LN4Zqw5iGpx+OswWuyi5J0ACnb9+4wS28GNb12ZEks+ek3IeVP6+N7i1Zhak3NYvF/
         i+/ynCJ2jv6Yzi5p6ATi3U9xuppVtE8Vex4staXxm9AOTwrPrV7XFGOPgWmclA/fJazh
         hPT+L7X8pYTW4d9rbTgyAoGwMok5JeKgix/RYexlAR8Tr6/bjtS3BXM14d2AqaGUTqFj
         7oaQOvlxg5V9OTIpT0DTSjoV2Che4gPqc4/c2iLUazg58bjkRBYSlFUU+fHBRO9/KI6B
         JmDz5t+D0ewzOS8aZJRcPlPn/0xtGmRKnkSIPTJJ4t2V3a3ICwXf7Vfzh75zwxi91J+h
         nTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844572; x=1696449372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIp5xN1/FiLxLp7U+weLwdU6T91ZE64ygxLvw8ASvC4=;
        b=RXCcyQKRq/3VEuL6rMTMAg+52dWvGq1gllz5lx+PLQJqkP0qGD9IOl/wOexVG84Tmz
         j7TGIZCxSbgeDg2eoBOS0rqOxhT6483JuMprXvpc5oPXnscwCA22C+juniRpesRlQCB+
         47BuoHIygqTsCy84nkwTffUb+kfq3ej7Yt4AHT18+fTWUTuOG4S4WGxy4uYi5SNo/wRT
         C8IsJgIwaehmaGpXijefPk9uKdEOSqWCNwGJTlgKUEBji6RFdBZQzhdWQWMoeZES4JBg
         Bg5YsJ+xLdZKcZCjBZ0TUoDkSsZK2zurR6+jCgKFuNfMhY1ezRfKujllZsLMBOcuoo0f
         lglA==
X-Gm-Message-State: AOJu0YzP2ukwvagx5/etRFpN/W4cz48xJcpJi+hzRYn2AjuDFDjbTZTp
        VwfZxc4dt2FrksZ7pezZKXo=
X-Google-Smtp-Source: AGHT+IFpu+Ghc/pWTm3/4DUfrfKzBQByIbKemQ5HIMzZYUrGUyaHBZnQMVmFd1VBlK/ycPzIPtuH+Q==
X-Received: by 2002:a6b:d90f:0:b0:799:36c2:fa49 with SMTP id r15-20020a6bd90f000000b0079936c2fa49mr3014365ioc.15.1695844572225;
        Wed, 27 Sep 2023 12:56:12 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:11 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 29/30] t1006: Test oid compatibility with cat-file
Date:   Wed, 27 Sep 2023 14:55:36 -0500
Message-Id: <20230927195537.1682-29-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Update the existing tests that are oid based to test that cat-file
works correctly with the normal oid and the compat_oid.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 t/t1006-cat-file.sh | 251 +++++++++++++++++++++++++++-----------------
 1 file changed, 154 insertions(+), 97 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 9b018b538950..23d3d37283bb 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -236,27 +236,38 @@ hello_size=$(strlen "$hello_content")
 hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
 
 test_expect_success "setup" '
+	git config core.repositoryformatversion 1 &&
+	git config extensions.objectformat $test_hash_algo &&
+	git config extensions.compatobjectformat $test_compat_hash_algo &&
 	echo_without_newline "$hello_content" > hello &&
 	git update-index --add hello
 '
 
-run_tests 'blob' $hello_oid $hello_size "$hello_content" "$hello_content"
+run_blob_tests () {
+    oid=$1
 
-test_expect_success '--batch-command --buffer with flush for blob info' '
-	echo "$hello_oid blob $hello_size" >expect &&
-	test_write_lines "info $hello_oid" "flush" |
+    run_tests 'blob' $oid $hello_size "$hello_content" "$hello_content"
+
+    test_expect_success '--batch-command --buffer with flush for blob info' '
+	echo "$oid blob $hello_size" >expect &&
+	test_write_lines "info $oid" "flush" |
 	GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT=1 \
 	git cat-file --batch-command --buffer >actual &&
 	test_cmp expect actual
-'
+    '
 
-test_expect_success '--batch-command --buffer without flush for blob info' '
+    test_expect_success '--batch-command --buffer without flush for blob info' '
 	touch output &&
-	test_write_lines "info $hello_oid" |
+	test_write_lines "info $oid" |
 	GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT=1 \
 	git cat-file --batch-command --buffer >>output &&
 	test_must_be_empty output
-'
+    '
+}
+
+hello_compat_oid=$(git rev-parse --output-object-format=$test_compat_hash_algo $hello_oid)
+run_blob_tests $hello_oid
+run_blob_tests $hello_compat_oid
 
 test_expect_success '--batch-check without %(rest) considers whole line' '
 	echo "$hello_oid blob $hello_size" >expect &&
@@ -267,35 +278,58 @@ test_expect_success '--batch-check without %(rest) considers whole line' '
 '
 
 tree_oid=$(git write-tree)
+tree_compat_oid=$(git rev-parse --output-object-format=$test_compat_hash_algo $tree_oid)
 tree_size=$(($(test_oid rawsz) + 13))
+tree_compat_size=$(($(test_oid --hash=compat rawsz) + 13))
 tree_pretty_content="100644 blob $hello_oid	hello${LF}"
+tree_compat_pretty_content="100644 blob $hello_compat_oid	hello${LF}"
 
 run_tests 'tree' $tree_oid $tree_size "" "$tree_pretty_content"
+run_tests 'tree' $tree_compat_oid $tree_compat_size "" "$tree_compat_pretty_content"
 
 commit_message="Initial commit"
 commit_oid=$(echo_without_newline "$commit_message" | git commit-tree $tree_oid)
+commit_compat_oid=$(git rev-parse --output-object-format=$test_compat_hash_algo $commit_oid)
 commit_size=$(($(test_oid hexsz) + 137))
+commit_compat_size=$(($(test_oid --hash=compat hexsz) + 137))
 commit_content="tree $tree_oid
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 $commit_message"
 
+commit_compat_content="tree $tree_compat_oid
+author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+
+$commit_message"
+
 run_tests 'commit' $commit_oid $commit_size "$commit_content" "$commit_content"
+run_tests 'commit' $commit_compat_oid $commit_compat_size "$commit_compat_content" "$commit_compat_content"
 
-tag_header_without_timestamp="object $hello_oid
-type blob
+tag_header_without_oid="type blob
 tag hellotag
 tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+tag_header_without_timestamp="object $hello_oid
+$tag_header_without_oid"
+tag_compat_header_without_timestamp="object $hello_compat_oid
+$tag_header_without_oid"
 tag_description="This is a tag"
 tag_content="$tag_header_without_timestamp 0 +0000
 
+$tag_description"
+tag_compat_content="$tag_compat_header_without_timestamp 0 +0000
+
 $tag_description"
 
 tag_oid=$(echo_without_newline "$tag_content" | git hash-object -t tag --stdin -w)
 tag_size=$(strlen "$tag_content")
 
+tag_compat_oid=$(git rev-parse --output-object-format=$test_compat_hash_algo $tag_oid)
+tag_compat_size=$(strlen "$tag_compat_content")
+
 run_tests 'tag' $tag_oid $tag_size "$tag_content" "$tag_content"
+run_tests 'tag' $tag_compat_oid $tag_compat_size "$tag_compat_content" "$tag_compat_content"
 
 test_expect_success "Reach a blob from a tag pointing to it" '
 	echo_without_newline "$hello_content" >expect &&
@@ -303,37 +337,43 @@ test_expect_success "Reach a blob from a tag pointing to it" '
 	test_cmp expect actual
 '
 
-for batch in batch batch-check batch-command
+for oid in $hello_oid $hello_compat_oid
 do
-    for opt in t s e p
+    for batch in batch batch-check batch-command
     do
+	for opt in t s e p
+	do
 	test_expect_success "Passing -$opt with --$batch fails" '
-	    test_must_fail git cat-file --$batch -$opt $hello_oid
+	    test_must_fail git cat-file --$batch -$opt $oid
 	'
 
 	test_expect_success "Passing --$batch with -$opt fails" '
-	    test_must_fail git cat-file -$opt --$batch $hello_oid
+	    test_must_fail git cat-file -$opt --$batch $oid
 	'
-    done
+	done
 
-    test_expect_success "Passing <type> with --$batch fails" '
-	test_must_fail git cat-file --$batch blob $hello_oid
-    '
+	test_expect_success "Passing <type> with --$batch fails" '
+	test_must_fail git cat-file --$batch blob $oid
+	'
 
-    test_expect_success "Passing --$batch with <type> fails" '
-	test_must_fail git cat-file blob --$batch $hello_oid
-    '
+	test_expect_success "Passing --$batch with <type> fails" '
+	test_must_fail git cat-file blob --$batch $oid
+	'
 
-    test_expect_success "Passing oid with --$batch fails" '
-	test_must_fail git cat-file --$batch $hello_oid
-    '
+	test_expect_success "Passing oid with --$batch fails" '
+	test_must_fail git cat-file --$batch $oid
+	'
+    done
 done
 
-for opt in t s e p
+for oid in $hello_oid $hello_compat_oid
 do
-    test_expect_success "Passing -$opt with --follow-symlinks fails" '
-	    test_must_fail git cat-file --follow-symlinks -$opt $hello_oid
+    for opt in t s e p
+    do
+	test_expect_success "Passing -$opt with --follow-symlinks fails" '
+	    test_must_fail git cat-file --follow-symlinks -$opt $oid
 	'
+    done
 done
 
 test_expect_success "--batch-check for a non-existent named object" '
@@ -386,112 +426,102 @@ test_expect_success 'empty --batch-check notices missing object' '
 	test_cmp expect actual
 '
 
-batch_input="$hello_oid
-$commit_oid
-$tag_oid
+batch_tests () {
+    boid=$1
+    loid=$2
+    lsize=$3
+    coid=$4
+    csize=$5
+    ccontent=$6
+    toid=$7
+    tsize=$8
+    tcontent=$9
+
+    batch_input="$boid
+$coid
+$toid
 deadbeef
 
 "
 
-printf "%s\0" \
-	"$hello_oid blob $hello_size" \
+    printf "%s\0" \
+	"$boid blob $hello_size" \
 	"$hello_content" \
-	"$commit_oid commit $commit_size" \
-	"$commit_content" \
-	"$tag_oid tag $tag_size" \
-	"$tag_content" \
+	"$coid commit $csize" \
+	"$ccontent" \
+	"$toid tag $tsize" \
+	"$tcontent" \
 	"deadbeef missing" \
 	" missing" >batch_output
 
-test_expect_success '--batch with multiple oids gives correct format' '
+    test_expect_success '--batch with multiple oids gives correct format' '
 	tr "\0" "\n" <batch_output >expect &&
 	echo_without_newline "$batch_input" >in &&
 	git cat-file --batch <in >actual &&
 	test_cmp expect actual
-'
+    '
 
-test_expect_success '--batch, -z with multiple oids gives correct format' '
+    test_expect_success '--batch, -z with multiple oids gives correct format' '
 	echo_without_newline_nul "$batch_input" >in &&
 	tr "\0" "\n" <batch_output >expect &&
 	git cat-file --batch -z <in >actual &&
 	test_cmp expect actual
-'
+    '
 
-test_expect_success '--batch, -Z with multiple oids gives correct format' '
+    test_expect_success '--batch, -Z with multiple oids gives correct format' '
 	echo_without_newline_nul "$batch_input" >in &&
 	git cat-file --batch -Z <in >actual &&
 	test_cmp batch_output actual
-'
+    '
 
-batch_check_input="$hello_oid
-$tree_oid
-$commit_oid
-$tag_oid
+batch_check_input="$boid
+$loid
+$coid
+$toid
 deadbeef
 
 "
 
-printf "%s\0" \
-	"$hello_oid blob $hello_size" \
-	"$tree_oid tree $tree_size" \
-	"$commit_oid commit $commit_size" \
-	"$tag_oid tag $tag_size" \
+    printf "%s\0" \
+	"$boid blob $hello_size" \
+	"$loid tree $lsize" \
+	"$coid commit $csize" \
+	"$toid tag $tsize" \
 	"deadbeef missing" \
 	" missing" >batch_check_output
 
-test_expect_success "--batch-check with multiple oids gives correct format" '
+    test_expect_success "--batch-check with multiple oids gives correct format" '
 	tr "\0" "\n" <batch_check_output >expect &&
 	echo_without_newline "$batch_check_input" >in &&
 	git cat-file --batch-check <in >actual &&
 	test_cmp expect actual
-'
+    '
 
-test_expect_success "--batch-check, -z with multiple oids gives correct format" '
+    test_expect_success "--batch-check, -z with multiple oids gives correct format" '
 	tr "\0" "\n" <batch_check_output >expect &&
 	echo_without_newline_nul "$batch_check_input" >in &&
 	git cat-file --batch-check -z <in >actual &&
 	test_cmp expect actual
-'
+    '
 
-test_expect_success "--batch-check, -Z with multiple oids gives correct format" '
+    test_expect_success "--batch-check, -Z with multiple oids gives correct format" '
 	echo_without_newline_nul "$batch_check_input" >in &&
 	git cat-file --batch-check -Z <in >actual &&
 	test_cmp batch_check_output actual
-'
-
-test_expect_success FUNNYNAMES 'setup with newline in input' '
-	touch -- "newline${LF}embedded" &&
-	git add -- "newline${LF}embedded" &&
-	git commit -m "file with newline embedded" &&
-	test_tick &&
-
-	printf "HEAD:newline${LF}embedded" >in
-'
-
-test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
-	git cat-file --batch-check -z <in >actual &&
-	echo "$(git rev-parse "HEAD:newline${LF}embedded") blob 0" >expect &&
-	test_cmp expect actual
-'
-
-test_expect_success FUNNYNAMES '--batch-check, -Z with newline in input' '
-	git cat-file --batch-check -Z <in >actual &&
-	printf "%s\0" "$(git rev-parse "HEAD:newline${LF}embedded") blob 0" >expect &&
-	test_cmp expect actual
-'
+    '
 
-batch_command_multiple_info="info $hello_oid
-info $tree_oid
-info $commit_oid
-info $tag_oid
+batch_command_multiple_info="info $boid
+info $loid
+info $coid
+info $toid
 info deadbeef"
 
-test_expect_success '--batch-command with multiple info calls gives correct format' '
+    test_expect_success '--batch-command with multiple info calls gives correct format' '
 	cat >expect <<-EOF &&
-	$hello_oid blob $hello_size
-	$tree_oid tree $tree_size
-	$commit_oid commit $commit_size
-	$tag_oid tag $tag_size
+	$boid blob $hello_size
+	$loid tree $lsize
+	$coid commit $csize
+	$toid tag $tsize
 	deadbeef missing
 	EOF
 
@@ -510,22 +540,22 @@ test_expect_success '--batch-command with multiple info calls gives correct form
 	git cat-file --batch-command --buffer -Z <in >actual &&
 
 	test_cmp expect_nul actual
-'
+    '
 
-batch_command_multiple_contents="contents $hello_oid
-contents $commit_oid
-contents $tag_oid
+batch_command_multiple_contents="contents $boid
+contents $coid
+contents $toid
 contents deadbeef
 flush"
 
-test_expect_success '--batch-command with multiple command calls gives correct format' '
+    test_expect_success '--batch-command with multiple command calls gives correct format' '
 	printf "%s\0" \
-		"$hello_oid blob $hello_size" \
+		"$boid blob $hello_size" \
 		"$hello_content" \
-		"$commit_oid commit $commit_size" \
-		"$commit_content" \
-		"$tag_oid tag $tag_size" \
-		"$tag_content" \
+		"$coid commit $csize" \
+		"$ccontent" \
+		"$toid tag $tsize" \
+		"$tcontent" \
 		"deadbeef missing" >expect_nul &&
 	tr "\0" "\n" <expect_nul >expect &&
 
@@ -543,6 +573,33 @@ test_expect_success '--batch-command with multiple command calls gives correct f
 	git cat-file --batch-command --buffer -Z <in >actual &&
 
 	test_cmp expect_nul actual
+    '
+
+}
+
+batch_tests $hello_oid $tree_oid $tree_size $commit_oid $commit_size "$commit_content" $tag_oid $tag_size "$tag_content"
+batch_tests $hello_compat_oid $tree_compat_oid $tree_compat_size $commit_compat_oid $commit_compat_size "$commit_compat_content" $tag_compat_oid $tag_compat_size "$tag_compat_content"
+
+
+test_expect_success FUNNYNAMES 'setup with newline in input' '
+	touch -- "newline${LF}embedded" &&
+	git add -- "newline${LF}embedded" &&
+	git commit -m "file with newline embedded" &&
+	test_tick &&
+
+	printf "HEAD:newline${LF}embedded" >in
+'
+
+test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
+	git cat-file --batch-check -z <in >actual &&
+	echo "$(git rev-parse "HEAD:newline${LF}embedded") blob 0" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success FUNNYNAMES '--batch-check, -Z with newline in input' '
+	git cat-file --batch-check -Z <in >actual &&
+	printf "%s\0" "$(git rev-parse "HEAD:newline${LF}embedded") blob 0" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'setup blobs which are likely to delta' '
-- 
2.41.0

