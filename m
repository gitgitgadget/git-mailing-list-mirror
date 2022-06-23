Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A919FC43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 11:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiFWLlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 07:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiFWLls (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 07:41:48 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EED4BFEF
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id jb13so4341292plb.9
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyBk/n5Xb1g9Y6Zvz48uQ/XmYg2QSFrTAGliHe5zU3k=;
        b=MCDGLmys9dmi+KHIFLV0OJTUnzyadPCGrreipMw2LU6Gr695Rjt+FYic8Hu7evBNT6
         byTDJdWOG5FsnM0mtGAFxbkTUkQFc7JJpZ9/rdk7MUe9WDJKLUPe+DSxdl0uwEjmWR/x
         e25kiGkOpGTCM5HTtT1bqdxc60bCVFZ/JbheNagAvVHtIM0jEzHDQcC1xu3yhwyAE0y9
         rsQEV5L6yVwEWepaVRaxCQvA0rcwlYalRSp/EgFPVnOIHf0GIdLA05Nv2nFTyPYCNYlo
         HEQ/fhXPHdWwbIi1BaJs11IfpTEk+v3ZeuyGDc3CH6V9Drec+zHj6PgjJx06sty+g1PP
         Cc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyBk/n5Xb1g9Y6Zvz48uQ/XmYg2QSFrTAGliHe5zU3k=;
        b=KeOjtl8XDCe0UGwZEzOiFAxwRr01R2lB/Myy9nygo0Sr8OmIRNqa+xEWUegY4L7dsV
         3vmMkU4SiMeRTs/ChC+gQgij8AoKVKgzFTnHsV+LmPYbosfC3lgPIPkiTDBqWS4pq6q0
         C89luB2N4PJUy2LSbhxiWkYqvZXGDwKHuCwKhiuJmJzGP/YoPtNykc5LBWUxHwt1aa0U
         gHzIXzEgxQpTKiKdXCPQFMtb5zncT9CQ2HWQRAdrur1a07XrdWE5QImlPkPcfNatfgu4
         rsdEmG4g0E9ym8bb+qGaVEO7Ytuao3j3fjgLt93ffFpH8RfdfJeJ4K0k3SDE66G1As81
         4+ag==
X-Gm-Message-State: AJIora/Jr+oO5MmelE6X+gFpxutHFAhkCJ+LmMciT+/7tShHR17V1pla
        8w3HDgWssHUyx1xxWf8yk9jXhTNkYq5H1zhT
X-Google-Smtp-Source: AGRyM1vZr3zIEDql97Q4JRGk2Yxfk3yC/CNpU8fBHBjOZuqqWwCS6VBcLV3S+TJIuwiJnmGMu9RVmQ==
X-Received: by 2002:a17:90b:4b48:b0:1ec:fc87:691c with SMTP id mi8-20020a17090b4b4800b001ecfc87691cmr3600011pjb.120.1655984505652;
        Thu, 23 Jun 2022 04:41:45 -0700 (PDT)
Received: from ffyuanda.localdomain ([112.195.146.236])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090a7e8700b001ec4f258028sm1629299pjl.55.2022.06.23.04.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:41:45 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com
Subject: [PATCH v4 1/7] t7002: add tests for moving out-of-cone file/directory
Date:   Thu, 23 Jun 2022 19:41:14 +0800
Message-Id: <20220623114120.12768-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add corresponding tests to test following situations:

We do not have sufficient coverage of moving files outside
of a sparse-checkout cone. Create new tests covering this
behavior, keeping in mind that the user can include --sparse
(or not), move a file or directory, and the destination can
already exist in the index (in this case user can use --force
to overwrite existing entry).

Helped-by: Victoria Dye <vdye@github.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 t/t7002-mv-sparse-checkout.sh | 84 +++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index f0f7cbfcdb..023e657c9e 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -4,6 +4,18 @@ test_description='git mv in sparse working trees'
 
 . ./test-lib.sh
 
+setup_sparse_checkout () {
+	mkdir folder1 &&
+	touch folder1/file1 &&
+	git add folder1 &&
+	git sparse-checkout set --cone sub
+}
+
+cleanup_sparse_checkout () {
+	git sparse-checkout disable &&
+	git reset --hard
+}
+
 test_expect_success 'setup' "
 	mkdir -p sub/dir sub/dir2 &&
 	touch a b c sub/d sub/dir/e sub/dir2/e &&
@@ -196,6 +208,7 @@ test_expect_success 'can move files to non-sparse dir' '
 '
 
 test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
+	test_when_finished "cleanup_sparse_checkout" &&
 	git reset --hard &&
 	git sparse-checkout init --no-cone &&
 	git sparse-checkout set a !/x y/ !x/y/z &&
@@ -206,4 +219,75 @@ test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
 	test_cmp expect stderr
 '
 
+test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
+	test_when_finished "cleanup_sparse_checkout" &&
+	setup_sparse_checkout &&
+
+	test_must_fail git mv folder1 sub 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo folder1/file1 >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr
+'
+
+test_expect_failure 'can move out-of-cone directory with --sparse' '
+	test_when_finished "cleanup_sparse_checkout" &&
+	setup_sparse_checkout &&
+
+	git mv --sparse folder1 sub 2>stderr &&
+	test_must_be_empty stderr &&
+
+	test_path_is_dir sub/folder1 &&
+	test_path_is_file sub/folder1/file1
+'
+
+test_expect_failure 'refuse to move out-of-cone file without --sparse' '
+	test_when_finished "cleanup_sparse_checkout" &&
+	setup_sparse_checkout &&
+
+	test_must_fail git mv folder1/file1 sub 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo folder1/file1 >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr
+'
+
+test_expect_failure 'can move out-of-cone file with --sparse' '
+	test_when_finished "cleanup_sparse_checkout" &&
+	setup_sparse_checkout &&
+
+	git mv --sparse folder1/file1 sub 2>stderr &&
+	test_must_be_empty stderr &&
+
+	test_path_is_file sub/file1
+'
+
+test_expect_failure 'refuse to move sparse file to existing destination' '
+	test_when_finished "cleanup_sparse_checkout" &&
+	mkdir folder1 &&
+	touch folder1/file1 &&
+	touch sub/file1 &&
+	git add folder1 sub/file1 &&
+	git sparse-checkout set --cone sub &&
+
+	test_must_fail git mv --sparse folder1/file1 sub 2>stderr &&
+	echo "fatal: destination exists, source=folder1/file1, destination=sub/file1" >expect &&
+	test_cmp expect stderr
+'
+
+test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
+	test_when_finished "cleanup_sparse_checkout" &&
+	mkdir folder1 &&
+	touch folder1/file1 &&
+	touch sub/file1 &&
+	echo "overwrite" >folder1/file1 &&
+	git add folder1 sub/file1 &&
+	git sparse-checkout set --cone sub &&
+
+	git mv --sparse --force folder1/file1 sub 2>stderr &&
+	test_must_be_empty stderr &&
+	echo "overwrite" >expect &&
+	test_cmp expect sub/file1
+'
+
 test_done
-- 
2.35.1

