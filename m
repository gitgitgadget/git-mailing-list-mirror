Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587FDE82CCC
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjI0T5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjI0T4f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:35 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359BDCEF
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:12 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79f989480e0so376959639f.3
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844571; x=1696449371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ku1SPtYJYS0jAS4sy8h0S6jPalVmdQPKuhDb6UU5UX8=;
        b=fibxaY6tQf0Gr2XNAUHMn/wEFNoE7iRAXeOM7u88JmlwkU4czHUMLU8WIvO6p5WDQ9
         TlaTKN6Uu8kyVJkJurR53B8GoTqpTcF0EFiGzOEw7xUnvek3Pske0qJ0EYgaTlM1t2Ai
         /Bt7zezeaDGD7+gNjX7EyghSIofH8GOCZVsq3hJ9Enz+1Z1i+Emrq5Syck6V86Ejqp2C
         MPLm9JVE4aPa/Cyf21n1EmvxEZRHkJDBR0o1SEv6pCOlptV2PVAvWSeBBe4HU4R7stS1
         z+7Q4whXgX9XU2v3eI15OVSXlIYH/URXme1r2nSuum7lxjg+JSKFZz72L7fMyjXb3F5w
         90TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844571; x=1696449371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ku1SPtYJYS0jAS4sy8h0S6jPalVmdQPKuhDb6UU5UX8=;
        b=CZj2sISotysIptVhPyUtRlZHRxb71gW+2jw6DTlVLPSXaVGNkkA7iLms1DDcJj2s+T
         xrNjqhMFnTC99nRTCA/9eKG3CROyOH/NdrqwgAePR0sGL+2TXHTnIbw8qhxzChleSpyW
         La/KqikTtXFyrstHfJ4Q9DCBooqOr2Sv7MXc6OQRHaHg2LwhlAI/UONuI6TGDViZ4z98
         M4BomfAchW3e8GV1kFqGTPuunR3Hk5Bqnorro2TAIFdc2uSLjU1ESrvIomiGWM+h/Lbi
         tyhseSsByU0wA85ieMay83F2LwOIMgwut2U5X5rPpJVpiHePpZobTz2TtBZzBHBUEqxK
         F0xQ==
X-Gm-Message-State: AOJu0YxCPBR5O1pJ1lTvcGDytAvwOfmyPU9Id9ql7MtVzWGoYhJHmgwt
        DDsoCYMjs8a6p/Zt3AdIUlM=
X-Google-Smtp-Source: AGHT+IG/jwix3gDvcQDj9ELUbtkzXjoRfXb7LwyRZyN7D2SN9rpOFhaXvHRoAzTfOTYFokW/kObIqg==
X-Received: by 2002:a5d:8794:0:b0:790:f866:d71b with SMTP id f20-20020a5d8794000000b00790f866d71bmr3032874ion.13.1695844571296;
        Wed, 27 Sep 2023 12:56:11 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:10 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 28/30] t1006: Rename sha1 to oid
Date:   Wed, 27 Sep 2023 14:55:35 -0500
Message-Id: <20230927195537.1682-28-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Before I extend this test, changing the naming of the relevant
hash from sha1 to oid.  Calling the hash sha1 is incorrect today
as it can be either sha1 or sha256 depending on the value of
GIT_DEFAULT_HASH_FUNCTION when the test is called.

I plan to test sha1 and sha256 simultaneously in the same repository.
Having a name like sha1 will be even more confusing.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 t/t1006-cat-file.sh | 220 ++++++++++++++++++++++----------------------
 1 file changed, 110 insertions(+), 110 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d73a0be1b9d1..9b018b538950 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -112,65 +112,65 @@ strlen () {
 
 run_tests () {
     type=$1
-    sha1=$2
+    oid=$2
     size=$3
     content=$4
     pretty_content=$5
 
-    batch_output="$sha1 $type $size
+    batch_output="$oid $type $size
 $content"
 
     test_expect_success "$type exists" '
-	git cat-file -e $sha1
+	git cat-file -e $oid
     '
 
     test_expect_success "Type of $type is correct" '
 	echo $type >expect &&
-	git cat-file -t $sha1 >actual &&
+	git cat-file -t $oid >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "Size of $type is correct" '
 	echo $size >expect &&
-	git cat-file -s $sha1 >actual &&
+	git cat-file -s $oid >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "Type of $type is correct using --allow-unknown-type" '
 	echo $type >expect &&
-	git cat-file -t --allow-unknown-type $sha1 >actual &&
+	git cat-file -t --allow-unknown-type $oid >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "Size of $type is correct using --allow-unknown-type" '
 	echo $size >expect &&
-	git cat-file -s --allow-unknown-type $sha1 >actual &&
+	git cat-file -s --allow-unknown-type $oid >actual &&
 	test_cmp expect actual
     '
 
     test -z "$content" ||
     test_expect_success "Content of $type is correct" '
 	echo_without_newline "$content" >expect &&
-	git cat-file $type $sha1 >actual &&
+	git cat-file $type $oid >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "Pretty content of $type is correct" '
 	echo_without_newline "$pretty_content" >expect &&
-	git cat-file -p $sha1 >actual &&
+	git cat-file -p $oid >actual &&
 	test_cmp expect actual
     '
 
     test -z "$content" ||
     test_expect_success "--batch output of $type is correct" '
 	echo "$batch_output" >expect &&
-	echo $sha1 | git cat-file --batch >actual &&
+	echo $oid | git cat-file --batch >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "--batch-check output of $type is correct" '
-	echo "$sha1 $type $size" >expect &&
-	echo_without_newline $sha1 | git cat-file --batch-check >actual &&
+	echo "$oid $type $size" >expect &&
+	echo_without_newline $oid | git cat-file --batch-check >actual &&
 	test_cmp expect actual
     '
 
@@ -179,33 +179,33 @@ $content"
 	test -z "$content" ||
 		test_expect_success "--batch-command $opt output of $type content is correct" '
 		echo "$batch_output" >expect &&
-		test_write_lines "contents $sha1" | git cat-file --batch-command $opt >actual &&
+		test_write_lines "contents $oid" | git cat-file --batch-command $opt >actual &&
 		test_cmp expect actual
 	'
 
 	test_expect_success "--batch-command $opt output of $type info is correct" '
-		echo "$sha1 $type $size" >expect &&
-		test_write_lines "info $sha1" |
+		echo "$oid $type $size" >expect &&
+		test_write_lines "info $oid" |
 		git cat-file --batch-command $opt >actual &&
 		test_cmp expect actual
 	'
     done
 
     test_expect_success "custom --batch-check format" '
-	echo "$type $sha1" >expect &&
-	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
+	echo "$type $oid" >expect &&
+	echo $oid | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "custom --batch-command format" '
-	echo "$type $sha1" >expect &&
-	echo "info $sha1" | git cat-file --batch-command="%(objecttype) %(objectname)" >actual &&
+	echo "$type $oid" >expect &&
+	echo "info $oid" | git cat-file --batch-command="%(objecttype) %(objectname)" >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success '--batch-check with %(rest)' '
 	echo "$type this is some extra content" >expect &&
-	echo "$sha1    this is some extra content" |
+	echo "$oid    this is some extra content" |
 		git cat-file --batch-check="%(objecttype) %(rest)" >actual &&
 	test_cmp expect actual
     '
@@ -216,7 +216,7 @@ $content"
 		echo "$size" &&
 		echo "$content"
 	} >expect &&
-	echo $sha1 | git cat-file --batch="%(objectsize)" >actual &&
+	echo $oid | git cat-file --batch="%(objectsize)" >actual &&
 	test_cmp expect actual
     '
 
@@ -226,25 +226,25 @@ $content"
 		echo "$type" &&
 		echo "$content"
 	} >expect &&
-	echo $sha1 | git cat-file --batch="%(objecttype)" >actual &&
+	echo $oid | git cat-file --batch="%(objecttype)" >actual &&
 	test_cmp expect actual
     '
 }
 
 hello_content="Hello World"
 hello_size=$(strlen "$hello_content")
-hello_sha1=$(echo_without_newline "$hello_content" | git hash-object --stdin)
+hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
 
 test_expect_success "setup" '
 	echo_without_newline "$hello_content" > hello &&
 	git update-index --add hello
 '
 
-run_tests 'blob' $hello_sha1 $hello_size "$hello_content" "$hello_content"
+run_tests 'blob' $hello_oid $hello_size "$hello_content" "$hello_content"
 
 test_expect_success '--batch-command --buffer with flush for blob info' '
-	echo "$hello_sha1 blob $hello_size" >expect &&
-	test_write_lines "info $hello_sha1" "flush" |
+	echo "$hello_oid blob $hello_size" >expect &&
+	test_write_lines "info $hello_oid" "flush" |
 	GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT=1 \
 	git cat-file --batch-command --buffer >actual &&
 	test_cmp expect actual
@@ -252,38 +252,38 @@ test_expect_success '--batch-command --buffer with flush for blob info' '
 
 test_expect_success '--batch-command --buffer without flush for blob info' '
 	touch output &&
-	test_write_lines "info $hello_sha1" |
+	test_write_lines "info $hello_oid" |
 	GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT=1 \
 	git cat-file --batch-command --buffer >>output &&
 	test_must_be_empty output
 '
 
 test_expect_success '--batch-check without %(rest) considers whole line' '
-	echo "$hello_sha1 blob $hello_size" >expect &&
-	git update-index --add --cacheinfo 100644 $hello_sha1 "white space" &&
+	echo "$hello_oid blob $hello_size" >expect &&
+	git update-index --add --cacheinfo 100644 $hello_oid "white space" &&
 	test_when_finished "git update-index --remove \"white space\"" &&
 	echo ":white space" | git cat-file --batch-check >actual &&
 	test_cmp expect actual
 '
 
-tree_sha1=$(git write-tree)
+tree_oid=$(git write-tree)
 tree_size=$(($(test_oid rawsz) + 13))
-tree_pretty_content="100644 blob $hello_sha1	hello${LF}"
+tree_pretty_content="100644 blob $hello_oid	hello${LF}"
 
-run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
+run_tests 'tree' $tree_oid $tree_size "" "$tree_pretty_content"
 
 commit_message="Initial commit"
-commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
+commit_oid=$(echo_without_newline "$commit_message" | git commit-tree $tree_oid)
 commit_size=$(($(test_oid hexsz) + 137))
-commit_content="tree $tree_sha1
+commit_content="tree $tree_oid
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 $commit_message"
 
-run_tests 'commit' $commit_sha1 $commit_size "$commit_content" "$commit_content"
+run_tests 'commit' $commit_oid $commit_size "$commit_content" "$commit_content"
 
-tag_header_without_timestamp="object $hello_sha1
+tag_header_without_timestamp="object $hello_oid
 type blob
 tag hellotag
 tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
@@ -292,14 +292,14 @@ tag_content="$tag_header_without_timestamp 0 +0000
 
 $tag_description"
 
-tag_sha1=$(echo_without_newline "$tag_content" | git hash-object -t tag --stdin -w)
+tag_oid=$(echo_without_newline "$tag_content" | git hash-object -t tag --stdin -w)
 tag_size=$(strlen "$tag_content")
 
-run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content"
+run_tests 'tag' $tag_oid $tag_size "$tag_content" "$tag_content"
 
 test_expect_success "Reach a blob from a tag pointing to it" '
 	echo_without_newline "$hello_content" >expect &&
-	git cat-file blob $tag_sha1 >actual &&
+	git cat-file blob $tag_oid >actual &&
 	test_cmp expect actual
 '
 
@@ -308,31 +308,31 @@ do
     for opt in t s e p
     do
 	test_expect_success "Passing -$opt with --$batch fails" '
-	    test_must_fail git cat-file --$batch -$opt $hello_sha1
+	    test_must_fail git cat-file --$batch -$opt $hello_oid
 	'
 
 	test_expect_success "Passing --$batch with -$opt fails" '
-	    test_must_fail git cat-file -$opt --$batch $hello_sha1
+	    test_must_fail git cat-file -$opt --$batch $hello_oid
 	'
     done
 
     test_expect_success "Passing <type> with --$batch fails" '
-	test_must_fail git cat-file --$batch blob $hello_sha1
+	test_must_fail git cat-file --$batch blob $hello_oid
     '
 
     test_expect_success "Passing --$batch with <type> fails" '
-	test_must_fail git cat-file blob --$batch $hello_sha1
+	test_must_fail git cat-file blob --$batch $hello_oid
     '
 
-    test_expect_success "Passing sha1 with --$batch fails" '
-	test_must_fail git cat-file --$batch $hello_sha1
+    test_expect_success "Passing oid with --$batch fails" '
+	test_must_fail git cat-file --$batch $hello_oid
     '
 done
 
 for opt in t s e p
 do
     test_expect_success "Passing -$opt with --follow-symlinks fails" '
-	    test_must_fail git cat-file --follow-symlinks -$opt $hello_sha1
+	    test_must_fail git cat-file --follow-symlinks -$opt $hello_oid
 	'
 done
 
@@ -360,12 +360,12 @@ test_expect_success "--batch-check for a non-existent hash" '
 
 test_expect_success "--batch for an existent and a non-existent hash" '
 	cat >expect <<-EOF &&
-	$tag_sha1 tag $tag_size
+	$tag_oid tag $tag_size
 	$tag_content
 	0000000000000000000000000000000000000000 missing
 	EOF
 
-	printf "$tag_sha1\n0000000000000000000000000000000000000000" >in &&
+	printf "$tag_oid\n0000000000000000000000000000000000000000" >in &&
 	git cat-file --batch <in >actual &&
 	test_cmp expect actual
 '
@@ -386,74 +386,74 @@ test_expect_success 'empty --batch-check notices missing object' '
 	test_cmp expect actual
 '
 
-batch_input="$hello_sha1
-$commit_sha1
-$tag_sha1
+batch_input="$hello_oid
+$commit_oid
+$tag_oid
 deadbeef
 
 "
 
 printf "%s\0" \
-	"$hello_sha1 blob $hello_size" \
+	"$hello_oid blob $hello_size" \
 	"$hello_content" \
-	"$commit_sha1 commit $commit_size" \
+	"$commit_oid commit $commit_size" \
 	"$commit_content" \
-	"$tag_sha1 tag $tag_size" \
+	"$tag_oid tag $tag_size" \
 	"$tag_content" \
 	"deadbeef missing" \
 	" missing" >batch_output
 
-test_expect_success '--batch with multiple sha1s gives correct format' '
+test_expect_success '--batch with multiple oids gives correct format' '
 	tr "\0" "\n" <batch_output >expect &&
 	echo_without_newline "$batch_input" >in &&
 	git cat-file --batch <in >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success '--batch, -z with multiple sha1s gives correct format' '
+test_expect_success '--batch, -z with multiple oids gives correct format' '
 	echo_without_newline_nul "$batch_input" >in &&
 	tr "\0" "\n" <batch_output >expect &&
 	git cat-file --batch -z <in >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success '--batch, -Z with multiple sha1s gives correct format' '
+test_expect_success '--batch, -Z with multiple oids gives correct format' '
 	echo_without_newline_nul "$batch_input" >in &&
 	git cat-file --batch -Z <in >actual &&
 	test_cmp batch_output actual
 '
 
-batch_check_input="$hello_sha1
-$tree_sha1
-$commit_sha1
-$tag_sha1
+batch_check_input="$hello_oid
+$tree_oid
+$commit_oid
+$tag_oid
 deadbeef
 
 "
 
 printf "%s\0" \
-	"$hello_sha1 blob $hello_size" \
-	"$tree_sha1 tree $tree_size" \
-	"$commit_sha1 commit $commit_size" \
-	"$tag_sha1 tag $tag_size" \
+	"$hello_oid blob $hello_size" \
+	"$tree_oid tree $tree_size" \
+	"$commit_oid commit $commit_size" \
+	"$tag_oid tag $tag_size" \
 	"deadbeef missing" \
 	" missing" >batch_check_output
 
-test_expect_success "--batch-check with multiple sha1s gives correct format" '
+test_expect_success "--batch-check with multiple oids gives correct format" '
 	tr "\0" "\n" <batch_check_output >expect &&
 	echo_without_newline "$batch_check_input" >in &&
 	git cat-file --batch-check <in >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success "--batch-check, -z with multiple sha1s gives correct format" '
+test_expect_success "--batch-check, -z with multiple oids gives correct format" '
 	tr "\0" "\n" <batch_check_output >expect &&
 	echo_without_newline_nul "$batch_check_input" >in &&
 	git cat-file --batch-check -z <in >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success "--batch-check, -Z with multiple sha1s gives correct format" '
+test_expect_success "--batch-check, -Z with multiple oids gives correct format" '
 	echo_without_newline_nul "$batch_check_input" >in &&
 	git cat-file --batch-check -Z <in >actual &&
 	test_cmp batch_check_output actual
@@ -480,18 +480,18 @@ test_expect_success FUNNYNAMES '--batch-check, -Z with newline in input' '
 	test_cmp expect actual
 '
 
-batch_command_multiple_info="info $hello_sha1
-info $tree_sha1
-info $commit_sha1
-info $tag_sha1
+batch_command_multiple_info="info $hello_oid
+info $tree_oid
+info $commit_oid
+info $tag_oid
 info deadbeef"
 
 test_expect_success '--batch-command with multiple info calls gives correct format' '
 	cat >expect <<-EOF &&
-	$hello_sha1 blob $hello_size
-	$tree_sha1 tree $tree_size
-	$commit_sha1 commit $commit_size
-	$tag_sha1 tag $tag_size
+	$hello_oid blob $hello_size
+	$tree_oid tree $tree_size
+	$commit_oid commit $commit_size
+	$tag_oid tag $tag_size
 	deadbeef missing
 	EOF
 
@@ -512,19 +512,19 @@ test_expect_success '--batch-command with multiple info calls gives correct form
 	test_cmp expect_nul actual
 '
 
-batch_command_multiple_contents="contents $hello_sha1
-contents $commit_sha1
-contents $tag_sha1
+batch_command_multiple_contents="contents $hello_oid
+contents $commit_oid
+contents $tag_oid
 contents deadbeef
 flush"
 
 test_expect_success '--batch-command with multiple command calls gives correct format' '
 	printf "%s\0" \
-		"$hello_sha1 blob $hello_size" \
+		"$hello_oid blob $hello_size" \
 		"$hello_content" \
-		"$commit_sha1 commit $commit_size" \
+		"$commit_oid commit $commit_size" \
 		"$commit_content" \
-		"$tag_sha1 tag $tag_size" \
+		"$tag_oid tag $tag_size" \
 		"$tag_content" \
 		"deadbeef missing" >expect_nul &&
 	tr "\0" "\n" <expect_nul >expect &&
@@ -569,7 +569,7 @@ test_expect_success 'confirm that neither loose blob is a delta' '
 # we will check only that one of the two objects is a delta
 # against the other, but not the order. We can do so by just
 # asking for the base of both, and checking whether either
-# sha1 appears in the output.
+# oid appears in the output.
 test_expect_success '%(deltabase) reports packed delta bases' '
 	git repack -ad &&
 	git cat-file --batch-check="%(deltabase)" <blobs >actual &&
@@ -583,12 +583,12 @@ test_expect_success 'setup bogus data' '
 	bogus_short_type="bogus" &&
 	bogus_short_content="bogus" &&
 	bogus_short_size=$(strlen "$bogus_short_content") &&
-	bogus_short_sha1=$(echo_without_newline "$bogus_short_content" | git hash-object -t $bogus_short_type --literally -w --stdin) &&
+	bogus_short_oid=$(echo_without_newline "$bogus_short_content" | git hash-object -t $bogus_short_type --literally -w --stdin) &&
 
 	bogus_long_type="abcdefghijklmnopqrstuvwxyz1234679" &&
 	bogus_long_content="bogus" &&
 	bogus_long_size=$(strlen "$bogus_long_content") &&
-	bogus_long_sha1=$(echo_without_newline "$bogus_long_content" | git hash-object -t $bogus_long_type --literally -w --stdin)
+	bogus_long_oid=$(echo_without_newline "$bogus_long_content" | git hash-object -t $bogus_long_type --literally -w --stdin)
 '
 
 for arg1 in '' --allow-unknown-type
@@ -608,9 +608,9 @@ do
 
 			if test "$arg1" = "--allow-unknown-type"
 			then
-				git cat-file $arg1 $arg2 $bogus_short_sha1
+				git cat-file $arg1 $arg2 $bogus_short_oid
 			else
-				test_must_fail git cat-file $arg1 $arg2 $bogus_short_sha1 >out 2>actual &&
+				test_must_fail git cat-file $arg1 $arg2 $bogus_short_oid >out 2>actual &&
 				test_must_be_empty out &&
 				test_cmp expect actual
 			fi
@@ -620,21 +620,21 @@ do
 			if test "$arg2" = "-p"
 			then
 				cat >expect <<-EOF
-				error: header for $bogus_long_sha1 too long, exceeds 32 bytes
-				fatal: Not a valid object name $bogus_long_sha1
+				error: header for $bogus_long_oid too long, exceeds 32 bytes
+				fatal: Not a valid object name $bogus_long_oid
 				EOF
 			else
 				cat >expect <<-EOF
-				error: header for $bogus_long_sha1 too long, exceeds 32 bytes
+				error: header for $bogus_long_oid too long, exceeds 32 bytes
 				fatal: git cat-file: could not get object info
 				EOF
 			fi &&
 
 			if test "$arg1" = "--allow-unknown-type"
 			then
-				git cat-file $arg1 $arg2 $bogus_short_sha1
+				git cat-file $arg1 $arg2 $bogus_short_oid
 			else
-				test_must_fail git cat-file $arg1 $arg2 $bogus_long_sha1 >out 2>actual &&
+				test_must_fail git cat-file $arg1 $arg2 $bogus_long_oid >out 2>actual &&
 				test_must_be_empty out &&
 				test_cmp expect actual
 			fi
@@ -668,28 +668,28 @@ do
 done
 
 test_expect_success '-e is OK with a broken object without --allow-unknown-type' '
-	git cat-file -e $bogus_short_sha1
+	git cat-file -e $bogus_short_oid
 '
 
 test_expect_success '-e can not be combined with --allow-unknown-type' '
-	test_expect_code 128 git cat-file -e --allow-unknown-type $bogus_short_sha1
+	test_expect_code 128 git cat-file -e --allow-unknown-type $bogus_short_oid
 '
 
 test_expect_success '-p cannot print a broken object even with --allow-unknown-type' '
-	test_must_fail git cat-file -p $bogus_short_sha1 &&
-	test_expect_code 128 git cat-file -p --allow-unknown-type $bogus_short_sha1
+	test_must_fail git cat-file -p $bogus_short_oid &&
+	test_expect_code 128 git cat-file -p --allow-unknown-type $bogus_short_oid
 '
 
 test_expect_success '<type> <hash> does not work with objects of broken types' '
 	cat >err.expect <<-\EOF &&
 	fatal: invalid object type "bogus"
 	EOF
-	test_must_fail git cat-file $bogus_short_type $bogus_short_sha1 2>err.actual &&
+	test_must_fail git cat-file $bogus_short_type $bogus_short_oid 2>err.actual &&
 	test_cmp err.expect err.actual
 '
 
 test_expect_success 'broken types combined with --batch and --batch-check' '
-	echo $bogus_short_sha1 >bogus-oid &&
+	echo $bogus_short_oid >bogus-oid &&
 
 	cat >err.expect <<-\EOF &&
 	fatal: invalid object type
@@ -711,52 +711,52 @@ test_expect_success 'the --allow-unknown-type option does not consider replaceme
 	cat >expect <<-EOF &&
 	$bogus_short_type
 	EOF
-	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
+	git cat-file -t --allow-unknown-type $bogus_short_oid >actual &&
 	test_cmp expect actual &&
 
 	# Create it manually, as "git replace" will die on bogus
 	# types.
 	head=$(git rev-parse --verify HEAD) &&
-	test_when_finished "test-tool ref-store main delete-refs 0 msg refs/replace/$bogus_short_sha1" &&
-	test-tool ref-store main update-ref msg "refs/replace/$bogus_short_sha1" $head $ZERO_OID REF_SKIP_OID_VERIFICATION &&
+	test_when_finished "test-tool ref-store main delete-refs 0 msg refs/replace/$bogus_short_oid" &&
+	test-tool ref-store main update-ref msg "refs/replace/$bogus_short_oid" $head $ZERO_OID REF_SKIP_OID_VERIFICATION &&
 
 	cat >expect <<-EOF &&
 	commit
 	EOF
-	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
+	git cat-file -t --allow-unknown-type $bogus_short_oid >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success "Type of broken object is correct" '
 	echo $bogus_short_type >expect &&
-	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
+	git cat-file -t --allow-unknown-type $bogus_short_oid >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success "Size of broken object is correct" '
 	echo $bogus_short_size >expect &&
-	git cat-file -s --allow-unknown-type $bogus_short_sha1 >actual &&
+	git cat-file -s --allow-unknown-type $bogus_short_oid >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'clean up broken object' '
-	rm .git/objects/$(test_oid_to_path $bogus_short_sha1)
+	rm .git/objects/$(test_oid_to_path $bogus_short_oid)
 '
 
 test_expect_success "Type of broken object is correct when type is large" '
 	echo $bogus_long_type >expect &&
-	git cat-file -t --allow-unknown-type $bogus_long_sha1 >actual &&
+	git cat-file -t --allow-unknown-type $bogus_long_oid >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success "Size of large broken object is correct when type is large" '
 	echo $bogus_long_size >expect &&
-	git cat-file -s --allow-unknown-type $bogus_long_sha1 >actual &&
+	git cat-file -s --allow-unknown-type $bogus_long_oid >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'clean up broken object' '
-	rm .git/objects/$(test_oid_to_path $bogus_long_sha1)
+	rm .git/objects/$(test_oid_to_path $bogus_long_oid)
 '
 
 test_expect_success 'cat-file -t and -s on corrupt loose object' '
@@ -853,7 +853,7 @@ test_expect_success 'prep for symlink tests' '
 	test_ln_s_add loop2 loop1 &&
 	git add morx dir/subdir/ind2 dir/ind1 &&
 	git commit -am "test" &&
-	echo $hello_sha1 blob $hello_size >found
+	echo $hello_oid blob $hello_size >found
 '
 
 test_expect_success 'git cat-file --batch-check --follow-symlinks works for non-links' '
@@ -941,7 +941,7 @@ test_expect_success 'git cat-file --batch-check --follow-symlinks works for dir/
 	echo HEAD:dirlink/morx >>expect &&
 	echo HEAD:dirlink/morx | git cat-file --batch-check --follow-symlinks >actual &&
 	test_cmp expect actual &&
-	echo $hello_sha1 blob $hello_size >expect &&
+	echo $hello_oid blob $hello_size >expect &&
 	echo HEAD:dirlink/ind1 | git cat-file --batch-check --follow-symlinks >actual &&
 	test_cmp expect actual
 '
-- 
2.41.0

