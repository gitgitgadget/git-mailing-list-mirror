Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E79BC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0E820795
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="GuFejMMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbgKDUeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732165AbgKDUea (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:34:30 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0964C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:34:29 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id b18so20622719qkc.9
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJH0dcQnUkMYeBvsD6V1EHfXQ/Y49yH3IXl4nhN33iw=;
        b=GuFejMMMTQNSOU3CV1T7a77a06SGSnp1HYwgAkmACxmztYgFLLvGHZlVwRSzkqVDeV
         RFm3m4utq0FFc1iC5x+h2G/sn2JgpJ2FcWLPTlfjEHYlMe8nxhGBlFS2l4yLdMaX1Zue
         vyewQ5idqTXU6U5RDAMnHpiwzWECFzhpA/8QuWAxQiNGoW09LTTinjycZnrt/yw1U3Gu
         WZC/Fo8OLKOaph06kJAdvdXI6cW5uYZfchv2uYqzfcTuEVMbdKmNidleyBxF/BDuSIqn
         8kL3tYNt2ola//9n5bRNH5r5++6hKU8TzkKZz3eQCilNZWHutSswGbwqDiCGxWSpio3F
         M1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJH0dcQnUkMYeBvsD6V1EHfXQ/Y49yH3IXl4nhN33iw=;
        b=GaZQ0gYF/P6jc+/iYLgX8nTBV5nX2YWjUOL2CwRf4wv76HAK+Q6nL8GWKBR1a8cVVJ
         10bUtUkfgmeKiFGTQBFHlp47vje//nfVT+GOgWboz5b/Abo7lfnaRKGyZEq0F1vCSPFU
         waS7IVHDyYcssryEo6Gn8btayulVzVWvowdnEmc7SCEC8EDQ35hy5KJATZjJXXCUnocY
         04S/28AQ9y10haoFoSaem4v+v5qV/9P8NCXcLNC31HMBJ5yOcJRUK7zU83FDrDMSNBMB
         y16jRLRR1EDUJu89m4toc0r1LzTrU4gTZkDRp037l1xIMtEMK/78d8Rah1Pm72/f9src
         DXkA==
X-Gm-Message-State: AOAM530T5LMoRWjjFZ7nPJWK66utr1tDbWZu/Qgi9YseOZxXtxZSZvpA
        1/0ejnq096BxqaNpmOHQcdss2hH7cvHXbQ==
X-Google-Smtp-Source: ABdhPJx7qd+T8VEahFeUNEz8UMP5OSHZ76GgQv+eoh1sGoveQKHozv4oJvGHkJQXoJt6obnbD38mOQ==
X-Received: by 2002:a37:6311:: with SMTP id x17mr27037320qkb.323.1604522068407;
        Wed, 04 Nov 2020 12:34:28 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:34:27 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v4 17/19] parallel-checkout: add tests related to clone collisions
Date:   Wed,  4 Nov 2020 17:33:16 -0300
Message-Id: <c8a2974f814a2d0709c4628933fc240e43a1bfb6.1604521276.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to confirm that path collisions are properly reported during a
clone operation using parallel-checkout.

Original-patch-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/lib-parallel-checkout.sh              |  4 +-
 t/t2081-parallel-checkout-collisions.sh | 98 +++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 2 deletions(-)
 create mode 100755 t/t2081-parallel-checkout-collisions.sh

diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
index 4dad9043fb..e62a433eb1 100644
--- a/t/lib-parallel-checkout.sh
+++ b/t/lib-parallel-checkout.sh
@@ -18,7 +18,7 @@ git_pc()
 		-c checkout.workers=$workers \
 		-c checkout.thresholdForParallelism=$threshold \
 		-c advice.detachedHead=0 \
-		"$@" &&
+		"$@" 2>&8 &&
 
 	# Check that the expected number of workers has been used. Note that it
 	# can be different from the requested number in two cases: when the
@@ -28,7 +28,7 @@ git_pc()
 	local workers_in_trace=$(grep "child_start\[..*\] git checkout--helper" trace | wc -l) &&
 	test $workers_in_trace -eq $expected_workers &&
 	rm -f trace
-}
+} 8>&2 2>&4
 
 # Verify that both the working tree and the index were created correctly
 verify_checkout()
diff --git a/t/t2081-parallel-checkout-collisions.sh b/t/t2081-parallel-checkout-collisions.sh
new file mode 100755
index 0000000000..5cab2dcd2c
--- /dev/null
+++ b/t/t2081-parallel-checkout-collisions.sh
@@ -0,0 +1,98 @@
+#!/bin/sh
+
+test_description='parallel-checkout collisions
+
+When there are path collisions during a clone, Git should report a warning
+listing all of the colliding entries. The sequential code detects a collision
+by calling lstat() before trying to open(O_CREAT) the file. Then, to find the
+colliding pair of an item k, it searches cache_entry[0, k-1].
+
+This is not sufficient in parallel checkout since:
+
+- A colliding file may be created between the lstat() and open() calls;
+- A colliding entry might appear in the second half of the cache_entry array.
+
+The tests in this file make sure that the collision detection code is extended
+for parallel checkout.
+'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
+
+TEST_ROOT="$PWD"
+
+test_expect_success CASE_INSENSITIVE_FS 'setup' '
+	file_x_hex=$(git hash-object -w --stdin </dev/null) &&
+	file_x_oct=$(echo $file_x_hex | hex2oct) &&
+
+	attr_hex=$(echo "file_x filter=logger" | git hash-object -w --stdin) &&
+	attr_oct=$(echo $attr_hex | hex2oct) &&
+
+	printf "100644 FILE_X\0${file_x_oct}" >tree &&
+	printf "100644 FILE_x\0${file_x_oct}" >>tree &&
+	printf "100644 file_X\0${file_x_oct}" >>tree &&
+	printf "100644 file_x\0${file_x_oct}" >>tree &&
+	printf "100644 .gitattributes\0${attr_oct}" >>tree &&
+
+	tree_hex=$(git hash-object -w -t tree --stdin <tree) &&
+	commit_hex=$(git commit-tree -m collisions $tree_hex) &&
+	git update-ref refs/heads/collisions $commit_hex &&
+
+	write_script "$TEST_ROOT"/logger_script <<-\EOF
+	echo "$@" >>filter.log
+	EOF
+'
+
+for mode in parallel sequential-fallback
+do
+
+	case $mode in
+	parallel)		workers=2 threshold=0 expected_workers=2 ;;
+	sequential-fallback)	workers=2 threshold=100 expected_workers=0 ;;
+	esac
+
+	test_expect_success CASE_INSENSITIVE_FS "collision detection on $mode clone" '
+		git_pc $workers $threshold $expected_workers \
+			clone --branch=collisions . $mode 2>$mode.stderr &&
+
+		grep FILE_X $mode.stderr &&
+		grep FILE_x $mode.stderr &&
+		grep file_X $mode.stderr &&
+		grep file_x $mode.stderr &&
+		test_i18ngrep "the following paths have collided" $mode.stderr
+	'
+
+	# The following test ensures that the collision detection code is
+	# correctly looking for colliding peers in the second half of the
+	# cache_entry array. This is done by defining a smudge command for the
+	# *last* array entry, which makes it non-eligible for parallel-checkout.
+	# The last entry is then checked out *before* any worker is spawned,
+	# making it succeed and the workers' entries collide.
+	#
+	# Note: this test don't work on Windows because, on this system,
+	# collision detection uses strcmp() when core.ignoreCase=false. And we
+	# have to set core.ignoreCase=false so that only 'file_x' matches the
+	# pattern of the filter attribute. But it works on OSX, where collision
+	# detection uses inode.
+	#
+	test_expect_success CASE_INSENSITIVE_FS,!MINGW,!CYGWIN "collision detection on $mode clone w/ filter" '
+		git_pc $workers $threshold $expected_workers \
+			-c core.ignoreCase=false \
+			-c filter.logger.smudge="\"$TEST_ROOT/logger_script\" %f" \
+			clone --branch=collisions . ${mode}_with_filter \
+			2>${mode}_with_filter.stderr &&
+
+		grep FILE_X ${mode}_with_filter.stderr &&
+		grep FILE_x ${mode}_with_filter.stderr &&
+		grep file_X ${mode}_with_filter.stderr &&
+		grep file_x ${mode}_with_filter.stderr &&
+		test_i18ngrep "the following paths have collided" ${mode}_with_filter.stderr &&
+
+		# Make sure only "file_x" was filtered
+		test_path_is_file ${mode}_with_filter/filter.log &&
+		echo file_x >expected.filter.log &&
+		test_cmp ${mode}_with_filter/filter.log expected.filter.log
+	'
+done
+
+test_done
-- 
2.28.0

