Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7013BC433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 16:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B197613BC
	for <git@archiver.kernel.org>; Tue,  4 May 2021 16:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhEDQ2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 12:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhEDQ2x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 12:28:53 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782F6C06174A
        for <git@vger.kernel.org>; Tue,  4 May 2021 09:27:58 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o5so9163183qkb.0
        for <git@vger.kernel.org>; Tue, 04 May 2021 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t23D3WB4vmdvDXKy81WrtRCExr2GHpVXwNDoKFSvJ7E=;
        b=gdPvbIUbK6sgOu+JAc0A1XIJwtKaebcIRF07+wMiPDpUZpov0ohm8b9r22NgqHm0go
         xrqWM4eee8XCXoRXxEzwlHKRlu80ocGLApxXG7KeuIADoSfbzVK9b+fArtSOqf78jWvz
         x1Q2mg8Z6EWoftJjl7Xf6qqHPCf8bqiyKfQfRDp6EH3YSTkCcy6MXKd+1sGmz9CJS1nI
         2EIpIIPsTWmi5XlrAokwTD9fadVNBHlvs/BnXBQxtf8OKh1xDn0rieFSfJR5/OT48JVo
         4+ebB/d5CwvmShB10wAYi0ecFiFK3Crk+3DQU0QF6XImtCiii6hMBCsKF2bI5Q7IXgcC
         JgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t23D3WB4vmdvDXKy81WrtRCExr2GHpVXwNDoKFSvJ7E=;
        b=AsPNeLIZsonTyT6/nYTuxfZb5oalYxEiBtS3U1N8tqIpvI9BHonEsJviO20ZGQyeHs
         mGEjyEOYTQqZ6/YOXxts/ZyMrEhJSYc4Ld8Cu/zk6vndcWagjyhSBGNwlJ00GRnlk7xq
         ztV+ZwiX6m9KbPr+L1zcLTTyoueVGsCaxSLZboe7SfZlL5xMgzigal2XMl+CWIUsp+Yx
         4LGN3KPkDr67/Wp+B+yQ97IGMEYsHqRP08NyrIL7bAlrRmvhc85Nt6vpONYIlHj2BXLT
         gxtU9Jx465w5pLKY3pnWvlSV6j5f1fW/MBUePP7CGmsJ5YLIaLae6M3xJX51ac6Imhg+
         70Hg==
X-Gm-Message-State: AOAM530z+1DYhi5po5lVg+NdYqbEYjf1/CEE0yE51Q/MEvwdc+y2KeQs
        ztcEGWEmwFtzimXEXCTnz7tQcyHPWkD4LA==
X-Google-Smtp-Source: ABdhPJyyH6v07GPn14TsC9URTzl6oYTL3y/x/fnu9FJK1+tLeJIdZ7KZHbNE1gG84L0wEB5s3RGDRg==
X-Received: by 2002:a37:e40f:: with SMTP id y15mr7832073qkf.314.1620145677358;
        Tue, 04 May 2021 09:27:57 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id x19sm11202689qkx.107.2021.05.04.09.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:27:57 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com,
        stolee@gmail.com, tboegi@web.de
Subject: [PATCH v3 5/8] parallel-checkout: add tests related to path collisions
Date:   Tue,  4 May 2021 13:27:32 -0300
Message-Id: <dcb3acab1d6ed8304da32b10a1eaa9c3f6f81d3a.1620145501.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1620145501.git.matheus.bernardino@usp.br>
References: <cover.1620145501.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to confirm that path collisions are properly detected by
checkout workers, both to avoid race conditions and to report colliding
entries on clone.

Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 parallel-checkout.c                     |   4 +
 t/lib-parallel-checkout.sh              |   4 +-
 t/t2081-parallel-checkout-collisions.sh | 162 ++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 2 deletions(-)
 create mode 100755 t/t2081-parallel-checkout-collisions.sh

diff --git a/parallel-checkout.c b/parallel-checkout.c
index 09e8b10a35..6fb3f1e6c9 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -8,6 +8,7 @@
 #include "sigchain.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "trace2.h"
 
 struct pc_worker {
 	struct child_process cp;
@@ -326,6 +327,7 @@ void write_pc_item(struct parallel_checkout_item *pc_item,
 	if (dir_sep && !has_dirs_only_path(path.buf, dir_sep - path.buf,
 					   state->base_dir_len)) {
 		pc_item->status = PC_ITEM_COLLIDED;
+		trace2_data_string("pcheckout", NULL, "collision/dirname", path.buf);
 		goto out;
 	}
 
@@ -341,6 +343,8 @@ void write_pc_item(struct parallel_checkout_item *pc_item,
 			 * call should have already caught these cases.
 			 */
 			pc_item->status = PC_ITEM_COLLIDED;
+			trace2_data_string("pcheckout", NULL,
+					   "collision/basename", path.buf);
 		} else {
 			error_errno("failed to open file '%s'", path.buf);
 			pc_item->status = PC_ITEM_FAILED;
diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
index f60b22ef34..d6740425b1 100644
--- a/t/lib-parallel-checkout.sh
+++ b/t/lib-parallel-checkout.sh
@@ -22,12 +22,12 @@ test_checkout_workers () {
 
 	local trace_file=trace-test-checkout-workers &&
 	rm -f "$trace_file" &&
-	GIT_TRACE2="$(pwd)/$trace_file" "$@" &&
+	GIT_TRACE2="$(pwd)/$trace_file" "$@" 2>&8 &&
 
 	local workers=$(grep "child_start\[..*\] git checkout--worker" "$trace_file" | wc -l) &&
 	test $workers -eq $expected_workers &&
 	rm "$trace_file"
-}
+} 8>&2 2>&4
 
 # Verify that both the working tree and the index were created correctly
 verify_checkout () {
diff --git a/t/t2081-parallel-checkout-collisions.sh b/t/t2081-parallel-checkout-collisions.sh
new file mode 100755
index 0000000000..f6fcfc0c1e
--- /dev/null
+++ b/t/t2081-parallel-checkout-collisions.sh
@@ -0,0 +1,162 @@
+#!/bin/sh
+
+test_description="path collisions during parallel checkout
+
+Parallel checkout must detect path collisions to:
+
+1) Avoid racily writing to different paths that represent the same file on disk.
+2) Report the colliding entries on clone.
+
+The tests in this file exercise parallel checkout's collision detection code in
+both these mechanics.
+"
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
+
+TEST_ROOT="$PWD"
+
+test_expect_success CASE_INSENSITIVE_FS 'setup' '
+	empty_oid=$(git hash-object -w --stdin </dev/null) &&
+	cat >objs <<-EOF &&
+	100644 $empty_oid	FILE_X
+	100644 $empty_oid	FILE_x
+	100644 $empty_oid	file_X
+	100644 $empty_oid	file_x
+	EOF
+	git update-index --index-info <objs &&
+	git commit -m "colliding files" &&
+	git tag basename_collision &&
+
+	write_script "$TEST_ROOT"/logger_script <<-\EOF
+	echo "$@" >>filter.log
+	EOF
+'
+
+test_workers_in_event_trace ()
+{
+	test $1 -eq $(grep ".event.:.child_start..*checkout--worker" $2 | wc -l)
+}
+
+test_expect_success CASE_INSENSITIVE_FS 'worker detects basename collision' '
+	GIT_TRACE2_EVENT="$(pwd)/trace" git \
+		-c checkout.workers=2 -c checkout.thresholdForParallelism=0 \
+		checkout . &&
+
+	test_workers_in_event_trace 2 trace &&
+	collisions=$(grep -i "category.:.pcheckout.,.key.:.collision/basename.,.value.:.file_x.}" trace | wc -l) &&
+	test $collisions -eq 3
+'
+
+test_expect_success CASE_INSENSITIVE_FS 'worker detects dirname collision' '
+	test_config filter.logger.smudge "\"$TEST_ROOT/logger_script\" %f" &&
+	empty_oid=$(git hash-object -w --stdin </dev/null) &&
+
+	# By setting a filter command to "a", we make it ineligible for parallel
+	# checkout, and thus it is checked out *first*. This way we can ensure
+	# that "A/B" and "A/C" will both collide with the regular file "a".
+	#
+	attr_oid=$(echo "a filter=logger" | git hash-object -w --stdin) &&
+
+	cat >objs <<-EOF &&
+	100644 $empty_oid	A/B
+	100644 $empty_oid	A/C
+	100644 $empty_oid	a
+	100644 $attr_oid	.gitattributes
+	EOF
+	git rm -rf . &&
+	git update-index --index-info <objs &&
+
+	rm -f trace filter.log &&
+	GIT_TRACE2_EVENT="$(pwd)/trace" git \
+		-c checkout.workers=2 -c checkout.thresholdForParallelism=0 \
+		checkout . &&
+
+	# Check that "a" (and only "a") was filtered
+	echo a >expected.log &&
+	test_cmp filter.log expected.log &&
+
+	# Check that it used the right number of workers and detected the collisions
+	test_workers_in_event_trace 2 trace &&
+	grep "category.:.pcheckout.,.key.:.collision/dirname.,.value.:.A/B.}" trace &&
+	grep "category.:.pcheckout.,.key.:.collision/dirname.,.value.:.A/C.}" trace
+'
+
+test_expect_success SYMLINKS,CASE_INSENSITIVE_FS 'do not follow symlinks colliding with leading dir' '
+	empty_oid=$(git hash-object -w --stdin </dev/null) &&
+	symlink_oid=$(echo "./e" | git hash-object -w --stdin) &&
+	mkdir e &&
+
+	cat >objs <<-EOF &&
+	120000 $symlink_oid	D
+	100644 $empty_oid	d/x
+	100644 $empty_oid	e/y
+	EOF
+	git rm -rf . &&
+	git update-index --index-info <objs &&
+
+	set_checkout_config 2 0 &&
+	test_checkout_workers 2 git checkout . &&
+	test_path_is_dir e &&
+	test_path_is_missing e/x
+'
+
+# The two following tests check that parallel checkout correctly reports
+# colliding entries on clone. The sequential code detects a collision by
+# calling lstat() before trying to open(O_CREAT) a file. (Note that this only
+# works for clone.) Then, to find the pair of a colliding item k, it searches
+# cache_entry[0, k-1]. This is not sufficient in parallel checkout because:
+#
+# - A colliding file may be created between the lstat() and open() calls;
+# - A colliding entry might appear in the second half of the cache_entry array.
+#
+test_expect_success CASE_INSENSITIVE_FS 'collision report on clone (w/ racy file creation)' '
+	git reset --hard basename_collision &&
+	set_checkout_config 2 0 &&
+	test_checkout_workers 2 git clone . clone-repo 2>stderr &&
+
+	grep FILE_X stderr &&
+	grep FILE_x stderr &&
+	grep file_X stderr &&
+	grep file_x stderr &&
+	grep "the following paths have collided" stderr
+'
+
+# This test ensures that the collision report code is correctly looking for
+# colliding peers in the second half of the cache_entry array. This is done by
+# defining a smudge command for the *last* array entry, which makes it
+# non-eligible for parallel-checkout. Thus, it is checked out *first*, before
+# spawning the workers.
+#
+# Note: this test doesn't work on Windows because, on this system, the
+# collision report code uses strcmp() to find the colliding pairs when
+# core.ignoreCase is false. And we need this setting for this test so that only
+# 'file_x' matches the pattern of the filter attribute. But the test works on
+# OSX, where the colliding pairs are found using inode.
+#
+test_expect_success CASE_INSENSITIVE_FS,!MINGW,!CYGWIN \
+	'collision report on clone (w/ colliding peer after the detected entry)' '
+
+	test_config_global filter.logger.smudge "\"$TEST_ROOT/logger_script\" %f" &&
+	git reset --hard basename_collision &&
+	echo "file_x filter=logger" >.gitattributes &&
+	git add .gitattributes &&
+	git commit -m "filter for file_x" &&
+
+	rm -rf clone-repo &&
+	set_checkout_config 2 0 &&
+	test_checkout_workers 2 \
+		git -c core.ignoreCase=false clone . clone-repo 2>stderr &&
+
+	grep FILE_X stderr &&
+	grep FILE_x stderr &&
+	grep file_X stderr &&
+	grep file_x stderr &&
+	grep "the following paths have collided" stderr &&
+
+	# Check that only "file_x" was filtered
+	echo file_x >expected.log &&
+	test_cmp clone-repo/filter.log expected.log
+'
+
+test_done
-- 
2.30.1

