Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83851C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhLIFQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhLIFPy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:54 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AE9C061B38
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:21 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id y16so5309694ioc.8
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2CSabg1FVzRSG6xmGZ0oP1WHUlImBKV54lXh6Kayl4=;
        b=LaPmLsPx6TqaqxXh0VwJsapVeKppbmuz2Ql+m3yo9w9dTbFzlTxO1abhrYlqLCBthI
         rVJzCJ1D8AFsHzCm2TvsH3lfGu+/rCeYop2wmX3+nh21BhUY+IZoS6BdRsf1Nx+nNOpo
         QQaF/NsXkKuuERN9ZUr6sH6VwapbHlTgBklB3gCGNAIEXgpxoN9K3oIlhqPmYrK8yFik
         7vndrBGzBMomeBCh23mLXxBjX+WGt7U4Y9Wx9LZkp/75dVr/T15ZZEaEqRvfIrfkHKIc
         Q5XAPRH4ITYDZaDo3BtpDTbnpT92rk0CPqHRSzix1ZHQ6TUykAaMCd08eN0ZLtECcY3N
         Uaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=o2CSabg1FVzRSG6xmGZ0oP1WHUlImBKV54lXh6Kayl4=;
        b=dcpkYdDYHqQDD/yg1zhIuLefHopdozrVI60KpRh13VRuCc+3jjZwX4DnocrYsJD5nw
         Es+Vb3rmtJjtrl5IQvQILGEbotV7FF4lJWjXGjYvmCTSKzHkVYtupXyVabEQP4xtdsAK
         qtEK7wjyAvwFmBsBuat+easY9pw/nmsLRjjvKOkZa9hpQEL/cGj0LEegEdrt95WgqUxT
         KAr5Ps2hcV/ijXf1eXggM5UKg8SsUbg8v+AHDKxGIA8eWqlzbVttemix4rtIyUHfANgm
         Mb0f4CdYns4BDZMKrx8OD1J1ST/XIqimJ/LBrz+aEJyxARjoUH9mSumtVJP1OqGvik2L
         89eA==
X-Gm-Message-State: AOAM532noME7/YEMgfk8cbJEvqoN3Q5fwk+Jt5b5AWYN+OtTKpJ7GtAr
        HBMKxYNC39s259SyJIYoStiKeV2z8IR7Xw==
X-Google-Smtp-Source: ABdhPJyM2gn2szKwmM17JuwAI0ttqJsRtFITh65y0hv1omvIfZGwG1lm+2BLKqiw4oFwq8tiRIvwSQ==
X-Received: by 2002:a05:6638:25c8:: with SMTP id u8mr6219930jat.23.1639026739244;
        Wed, 08 Dec 2021 21:12:19 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:18 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 15/19] tests: simplify by dropping unnecessary `for` loops
Date:   Thu,  9 Dec 2021 00:11:11 -0500
Message-Id: <20211209051115.52629-16-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than manually looping over a set of items and plugging those
items into a template string which is printed repeatedly, achieve the
same effect by taking advantage of `printf` which loops over its
arguments automatically.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3005-ls-files-relative.sh      | 10 ++--------
 t/t3600-rm.sh                     |  5 +----
 t/t4025-hunk-header.sh            | 10 ++--------
 t/t4125-apply-ws-fuzz.sh          |  5 +----
 t/t6416-recursive-corner-cases.sh | 30 ++++++------------------------
 t/t7110-reset-merge.sh            |  2 +-
 t/t9400-git-cvsserver-server.sh   |  2 +-
 7 files changed, 14 insertions(+), 50 deletions(-)

diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
index 6ba8b589cd..fbfa210a50 100755
--- a/t/t3005-ls-files-relative.sh
+++ b/t/t3005-ls-files-relative.sh
@@ -39,10 +39,7 @@ test_expect_success 'ls-files with mixed levels' '
 test_expect_success 'ls-files -c' '
 	(
 		cd top/sub &&
-		for f in ../y*
-		do
-			echo "error: pathspec $SQ$f$SQ did not match any file(s) known to git"
-		done >expect.err &&
+		printf "error: pathspec $SQ%s$SQ did not match any file(s) known to git\n" ../y* >expect.err &&
 		echo "Did you forget to ${SQ}git add${SQ}?" >>expect.err &&
 		ls ../x* >expect.out &&
 		test_must_fail git ls-files -c --error-unmatch ../[xy]* >actual.out 2>actual.err &&
@@ -54,10 +51,7 @@ test_expect_success 'ls-files -c' '
 test_expect_success 'ls-files -o' '
 	(
 		cd top/sub &&
-		for f in ../x*
-		do
-			echo "error: pathspec $SQ$f$SQ did not match any file(s) known to git"
-		done >expect.err &&
+		printf "error: pathspec $SQ%s$SQ did not match any file(s) known to git\n" ../x* >expect.err &&
 		echo "Did you forget to ${SQ}git add${SQ}?" >>expect.err &&
 		ls ../y* >expect.out &&
 		test_must_fail git ls-files -o --error-unmatch ../[xy]* >actual.out 2>actual.err &&
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index ed3952eb98..e74a318ac3 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -274,10 +274,7 @@ test_expect_success 'Resolving by removal is not a warning-worthy event' '
 	git reset -q --hard &&
 	test_when_finished "rm -f .git/index.lock msg && git reset -q --hard" &&
 	blob=$(echo blob | git hash-object -w --stdin) &&
-	for stage in 1 2 3
-	do
-		echo "100644 $blob $stage	blob"
-	done | git update-index --index-info &&
+	printf "100644 $blob %d\tblob\n" 1 2 3 | git update-index --index-info &&
 	git rm blob >msg 2>&1 &&
 	test_i18ngrep ! "needs merge" msg &&
 	test_must_fail git ls-files -s --error-unmatch blob
diff --git a/t/t4025-hunk-header.sh b/t/t4025-hunk-header.sh
index 6356961de4..5397cb7d42 100755
--- a/t/t4025-hunk-header.sh
+++ b/t/t4025-hunk-header.sh
@@ -14,15 +14,9 @@ test_expect_success setup '
 
 	(
 		echo "A $NS" &&
-		for c in B C D E F G H I J K
-		do
-			echo "  $c"
-		done &&
+		printf "  %s\n" B C D E F G H I J K &&
 		echo "L  $NS" &&
-		for c in M N O P Q R S T U V
-		do
-			echo "  $c"
-		done
+		printf "  %s\n" M N O P Q R S T U V
 	) >file &&
 	git add file &&
 
diff --git a/t/t4125-apply-ws-fuzz.sh b/t/t4125-apply-ws-fuzz.sh
index 9671de7999..090987c89b 100755
--- a/t/t4125-apply-ws-fuzz.sh
+++ b/t/t4125-apply-ws-fuzz.sh
@@ -10,10 +10,7 @@ test_expect_success setup '
 	git add file &&
 
 	# file-0 is full of whitespace breakages
-	for l in a bb c d eeee f ggg h
-	do
-		echo "$l "
-	done >file-0 &&
+	printf "%s \n" a bb c d eeee f ggg h >file-0 &&
 
 	# patch-0 creates a whitespace broken file
 	cat file-0 >file &&
diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index 84f5082366..690c8482b1 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -24,14 +24,8 @@ test_expect_success 'setup basic criss-cross + rename with no modifications' '
 		cd basic-rename &&
 
 		ten="0 1 2 3 4 5 6 7 8 9" &&
-		for i in $ten
-		do
-			echo line $i in a sample file
-		done >one &&
-		for i in $ten
-		do
-			echo line $i in another sample file
-		done >two &&
+		printf "line %d in a sample file\n" $ten >one &&
+		printf "line %d in another sample file\n" $ten >two &&
 		git add one two &&
 		test_tick && git commit -m initial &&
 
@@ -96,14 +90,8 @@ test_expect_success 'setup criss-cross + rename merges with basic modification'
 		cd rename-modify &&
 
 		ten="0 1 2 3 4 5 6 7 8 9" &&
-		for i in $ten
-		do
-			echo line $i in a sample file
-		done >one &&
-		for i in $ten
-		do
-			echo line $i in another sample file
-		done >two &&
+		printf "line %d in a sample file\n" $ten >one &&
+		printf "line %d in another sample file\n" $ten >two &&
 		git add one two &&
 		test_tick && git commit -m initial &&
 
@@ -1588,10 +1576,7 @@ test_expect_success 'setup nested conflicts' '
 		cd nested_conflicts &&
 
 		# Create some related files now
-		for i in $(test_seq 1 10)
-		do
-			echo Random base content line $i
-		done >initial &&
+		printf "Random base content line %d\n" $(test_seq 1 10) >initial &&
 
 		cp initial b_L1 &&
 		cp initial b_R1 &&
@@ -1777,10 +1762,7 @@ test_expect_success 'setup virtual merge base with nested conflicts' '
 		cd virtual_merge_base_has_nested_conflicts &&
 
 		# Create some related files now
-		for i in $(test_seq 1 10)
-		do
-			echo Random base content line $i
-		done >content &&
+		printf "Random base content line %d\n" $(test_seq 1 10) >content &&
 
 		# Setup original commit
 		git add content &&
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index a82a07a04a..3d62e10b53 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -8,7 +8,7 @@ test_description='Tests for "git reset" with "--merge" and "--keep" options'
 . ./test-lib.sh
 
 test_expect_success setup '
-    for i in 1 2 3; do echo line $i; done >file1 &&
+    printf "line %d\n" 1 2 3 >file1 &&
     cat file1 >file2 &&
     git add file1 file2 &&
     test_tick &&
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index a6a73effde..a60fe2e19f 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -591,7 +591,7 @@ test_expect_success 'cvs annotate' '
     cd cvswork &&
     GIT_CONFIG="$git_config" cvs annotate merge >../out &&
     sed -e "s/ .*//" ../out >../actual &&
-    for i in 3 1 1 1 1 1 1 1 2 4; do echo 1.$i; done >../expect &&
+    printf "1.%d\n" 3 1 1 1 1 1 1 1 2 4 >../expect &&
     test_cmp ../expect ../actual
 '
 
-- 
2.34.1.307.g9b7440fafd

