Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FB6E784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbjJBCl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbjJBCla (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:30 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA67CE7
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:41:05 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79faba5fe12so473922239f.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214464; x=1696819264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIp5xN1/FiLxLp7U+weLwdU6T91ZE64ygxLvw8ASvC4=;
        b=Pbr/hdjvriikTKIcVB4S5gCPnqCYwu7RIEYqlZyzG9CYJ7WnrGqR+zE8Ej8nxQBxW2
         AOQOJ5oBsTzm6+L7WSeddKfOmzqlMLIWOkmCZCwodoOLE+woo63hu+fxwtUTfYLVzvyk
         KND/rN+H5jGQCnH7LHvFvpB+JjWJ6p6+YH18m3i/UkUR+JYh7qTR/uJRN1AGbqFr2sBe
         wKe190w0wKj3kZ69EOwG+amZl9xhKeyicJM40Mtmj2BAJ3Ogxc8AebgR2wNFES8tpEiy
         z7moJx3cLCQf3evk0G4N6bSFzDdn2BxfRTMZR9WDAVfxT+c22wh5Aa27q5Udmvgggv8Y
         Wtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214464; x=1696819264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIp5xN1/FiLxLp7U+weLwdU6T91ZE64ygxLvw8ASvC4=;
        b=k2SGqgbjBa/nMnDSnvNw/USmFguisVYqg3R8wr1rZIjSZ3Disx4n3xF9jU7slo6lOK
         IPb1xrCyqY6omZoJwqF/oOAjI9Fy8eXorZET1Ci/lPxutQ3HtXDX820k4ratGGMIYHO2
         pOdKNQ7/0ydUACI9ckZBGcxLf58XnKq4D3FftVJjI6+IDf2luOP3v7bGAUl6pPQIUWbY
         La9hn9zRROMO4swA1n2WfFOc8fH4NJ4AJo5mLmYjGo+4d71GOLqxPE9uev0lBcUF4DNl
         td9jGbSJi7oZbficWIYuhii+wd6c5fH8ZcHLqMF7NqE7OjlC5K8U9uwU+0M3n0qSnyxd
         oiDw==
X-Gm-Message-State: AOJu0YwXgb+LSteN3/YdPPGnYIt9fsjl6AE7rQnjUu2yWut2XIZoXCEe
        HX0BlqaWDFYrvM8K/EEN8Ak=
X-Google-Smtp-Source: AGHT+IFfwhSGB/hE/r/F8bIeENRSx3HRHVPt8cEmHUtLkjsmruh6HTobQtsq4fB4k5ksfg05zsTVUQ==
X-Received: by 2002:a6b:4405:0:b0:792:4cfc:178f with SMTP id r5-20020a6b4405000000b007924cfc178fmr12248304ioa.16.1696214464560;
        Sun, 01 Oct 2023 19:41:04 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:41:04 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 29/30] t1006: test oid compatibility with cat-file
Date:   Sun,  1 Oct 2023 21:40:33 -0500
Message-Id: <20231002024034.2611-29-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
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

