Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A56C4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1496420738
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="llxUlodH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391067AbgJ2CQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgJ2CQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:16:29 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B9EC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:29 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id f6so46682qtc.7
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJH0dcQnUkMYeBvsD6V1EHfXQ/Y49yH3IXl4nhN33iw=;
        b=llxUlodHAwFFYa7G38NqZttXbYqHzK15+AqKvPuQerjqgTDLrqUf4mjDi83xmLPxfF
         ymnlRBYG8qkdidW3LQ3FhN03wsEUopAFxfr2k6UoreG0zkZv9mi8YsDJ3TLt68a1GmOb
         E1BfqjpPcHe4Xo6pE+Ykel1MKZoiZOjwSWCU7CMTqoJ5tV/8cU/z2ZyNdZYqsvs1GGqH
         4gq5r0ahcUzjAp5cNcqRS8Ht5utEW46pcGo5tXJeCX4bYX07OKXzYhrjgwoa+n1/U2vH
         XFTrBP3/OjppRlx1Jw6mPphGva/spoGvQxZ28gfjcgkgxc3mVOPhttd+CcAnED1chItR
         8vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJH0dcQnUkMYeBvsD6V1EHfXQ/Y49yH3IXl4nhN33iw=;
        b=sxK2nZp4X260spdgkor1RyfylkB5qfn0U55S/1fCeiOoaFr7l35M1hza1zpY9IYI44
         5/kV1K3rof8aAWsERufPQ3fVR2Ax0LaKhyjjoiPLBkSmADZVW/cw9Xeda8fuyw7WK0W/
         5OyZQCfIJyb0y5+kHHlaa2xgXZa/WyCV1s8KH0ibkzvp8grmh2cnuUE3C3TyI1Vw9LtX
         D2NIBsQkaAAMlJK4PWgZrDRWzuAqifHTWz3FLCM0ARzs2yv/zr5jP+rmSkhZYrsZCfi/
         jG6SSM5s0uysiJ8VRlY3drJRaJp6bVXafcvBG+x7yYGzKQjAn8KkaKJB1t6aUQb+4vls
         P+rA==
X-Gm-Message-State: AOAM530v8RoaTJcdfkxWwjN8Oc+1CpmsHUD8Oo9Z+Chi5oU3uhaklC9R
        LuePE5LekHRPxM9Rf/diVdqZ1ixAxywfFQ==
X-Google-Smtp-Source: ABdhPJytGvAOxQOzS+ynE0lZNPMUglGepgEQa2j4kMaziiP0pnEiGyjUUhkp6FWGu2H3JAoWuWQrNQ==
X-Received: by 2002:ac8:7517:: with SMTP id u23mr1766468qtq.261.1603937788148;
        Wed, 28 Oct 2020 19:16:28 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:16:27 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v3 17/19] parallel-checkout: add tests related to clone collisions
Date:   Wed, 28 Oct 2020 23:14:54 -0300
Message-Id: <3d140dcacbd7fd49ea2dfb7bc0839e57b11427de.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
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

