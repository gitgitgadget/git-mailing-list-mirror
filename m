Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5439CC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242616AbiCGMut (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242594AbiCGMul (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:41 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5004ECEC
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:49:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id k24so13627674wrd.7
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RLPUMTg+r6kguee1gxc5YZ/axrcYQnmZnuw+JeJGDPo=;
        b=ZQxl/EfRNV0ls6/Ofuf5WbWSBCYI9IabKieXcEYcam9Dmzz1lGBoMRGe6w+dr6igR/
         5DJn0LSn2kXnyu1VgeCbFXlpapr2OnMe1anm4YZk+0KyzkT1202Zk4yy2zfLmAuML3qv
         bNyJWl8ZqfK1kCSvvtXJUxO2DaOOlNK6NbRrJUoRWyyz8Zc+ztGgS4qLId3V8XgDiRso
         xpPbxpjv5R7XxdHkAtdJp7uC6qYZdsZTAf203d5T2p4LVudhCmpdhtiB/SNqk9/arbfD
         zXTzRDOKvWIO7AfssVhWNYI2Wv0Bgkw6L7dnq6/HxihUhXvQTjreCyM0N3xWB4qWol8r
         tA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RLPUMTg+r6kguee1gxc5YZ/axrcYQnmZnuw+JeJGDPo=;
        b=cfm5fGMzDHLKxyc8po8qEmOkfQ3d+xSA/SK5i2GGzwRuf4MPD3FOEhVKpC7q7Gh2RP
         DpETztvuhR2b7ahFbYIwqk39lWMxNQbn5WqkRexHJRl0WSDOqaxyM7M89o2PsMxhoWnk
         U0Uy+zvna+/DyKx/EFnwTwoXX2ckINOoWFamsH9Dobkc8OB697GYLF/uanT9I1NoNhdI
         bw+CcYb6VWjm2Mbuhcxav1K0vUAUy0hdbNpJdvINRgNv2i/0xR4w6OSFN0bioFY9gtfS
         iC7lzU4NpQ4lngj5166Ye3X4uBzIa1gLs/ihGQYTwpgWGPsvFH/1GUH4LHP8cY57py1S
         C3hg==
X-Gm-Message-State: AOAM5317a6Rp/dLQ8fqcZzpugiySV531FmZgm8fP/kQyDOGWiAdRY91n
        aCPVzzB8rgMA90/8/kZaJ0XFFkNqcSyM5g==
X-Google-Smtp-Source: ABdhPJwAO5d1Xmcn03+pwms690GMVpB2MQ+3MKbJkwTK2XZwaHm9+VnXR7cI7ddDjwlLmmmVK1+b6A==
X-Received: by 2002:a05:6000:1a86:b0:1f0:3437:86af with SMTP id f6-20020a0560001a8600b001f0343786afmr8133638wry.700.1646657373407;
        Mon, 07 Mar 2022 04:49:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm12729091wmc.47.2022.03.07.04.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:49:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/15] notes tests: don't ignore "git" exit code
Date:   Mon,  7 Mar 2022 13:49:00 +0100
Message-Id: <patch-v2-09.15-ca9e12f2bac-20220307T124817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a fragile test pattern that's been with us ever since these
tests were introduced in [1], [2] and [3] to properly return the exit
code of the failing command on failure.

Because of this I'd marked this test as passing under SANITIZE=leak in
[4] and [5]. We need to remove those annotations as these tests will
no longer pass.

1. 9081a421a6d (checkout: fix "branch info" memory leaks, 2021-11-16)
2. 0057c0917d3 (Add selftests verifying that we can parse notes trees
   with various fanouts, 2009-10-09)
3. 048cdd4665e (t3305: Verify that adding many notes with git-notes
   triggers increased fanout, 2010-02-13)
4. ca089724952 (leak tests: mark some notes tests as passing with
   SANITIZE=leak, 2021-10-31)
5. 9081a421a6d (checkout: fix "branch info" memory leaks, 2021-11-16)
---
 t/t3302-notes-index-expensive.sh |  6 +++---
 t/t3303-notes-subtrees.sh        |  9 ++++-----
 t/t3305-notes-fanout.sh          | 14 +++++++-------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index bc9d8ee1e6a..bb5fea02a03 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -8,7 +8,6 @@ test_description='Test commit notes index (expensive!)'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_repo () {
@@ -65,7 +64,8 @@ create_repo () {
 test_notes () {
 	count=$1 &&
 	git config core.notesRef refs/notes/commits &&
-	git log | grep "^    " >output &&
+	git log >tmp &&
+	grep "^    " tmp >output &&
 	i=$count &&
 	while test $i -gt 0
 	do
@@ -90,7 +90,7 @@ write_script time_notes <<\EOF
 			unset GIT_NOTES_REF
 			;;
 		esac
-		git log
+		git log || exit $?
 		i=$(($i+1))
 	done >/dev/null
 EOF
diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index 7e0a8960af8..eac193757bf 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -5,7 +5,6 @@ test_description='Test commit notes organized in subtrees'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 number_of_commits=100
@@ -79,7 +78,7 @@ test_sha1_based () {
 	(
 		start_note_commit &&
 		nr=$number_of_commits &&
-		git rev-list refs/heads/main |
+		git rev-list refs/heads/main >out &&
 		while read sha1; do
 			note_path=$(echo "$sha1" | sed "$1")
 			cat <<INPUT_END &&
@@ -91,9 +90,9 @@ EOF
 INPUT_END
 
 			nr=$(($nr-1))
-		done
-	) |
-	git fast-import --quiet
+		done <out
+	) >gfi &&
+	git fast-import --quiet <gfi
 }
 
 test_expect_success 'test notes in 2/38-fanout' 'test_sha1_based "s|^..|&/|"'
diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 1f5964865ae..9976d787f47 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -2,7 +2,6 @@
 
 test_description='Test that adding/removing many notes triggers automatic fanout restructuring'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 path_has_fanout() {
@@ -24,7 +23,7 @@ touched_one_note_with_fanout() {
 all_notes_have_fanout() {
 	notes_commit=$1 &&
 	fanout=$2 &&
-	git ls-tree -r --name-only $notes_commit 2>/dev/null |
+	git ls-tree -r --name-only $notes_commit |
 	while read path
 	do
 		path_has_fanout $path $fanout || return 1
@@ -51,8 +50,9 @@ test_expect_success 'creating many notes with git-notes' '
 	done
 '
 
-test_expect_success 'many notes created correctly with git-notes' '
-	git log | grep "^    " > output &&
+test_expect_success !SANITIZE_LEAK 'many notes created correctly with git-notes' '
+	git log >output.raw &&
+	grep "^    " output.raw >output &&
 	i=$num_notes &&
 	while test $i -gt 0
 	do
@@ -91,13 +91,13 @@ test_expect_success 'stable fanout 0 is followed by stable fanout 1' '
 test_expect_success 'deleting most notes with git-notes' '
 	remove_notes=285 &&
 	i=0 &&
-	git rev-list HEAD |
+	git rev-list HEAD >revs &&
 	while test $i -lt $remove_notes && read sha1
 	do
 		i=$(($i + 1)) &&
 		test_tick &&
-		git notes remove "$sha1" 2>/dev/null || return 1
-	done
+		git notes remove "$sha1" || return 1
+	done <revs
 '
 
 test_expect_success 'most notes deleted correctly with git-notes' '
-- 
2.35.1.1242.gfeba0eae32b

