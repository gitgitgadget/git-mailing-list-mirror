Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EC5C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 10:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350806AbiE0KIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 06:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiE0KIS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 06:08:18 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBC21269A8
        for <git@vger.kernel.org>; Fri, 27 May 2022 03:08:17 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id x12so3532124pgj.7
        for <git@vger.kernel.org>; Fri, 27 May 2022 03:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=97uccG1tYdlFvF5aepnpCDElyZCX5Vq6MsGirlNlioI=;
        b=QzEl+gxVggXeERR1DLA7Ubr/pQaA95Tmb3K5j4gUyNtUI4PMJY9P7/QlPDxvkrgoBu
         5G89il6HC+1uqcfMc6RQIN+YwVbmaiuPFBwsGxFqwblrJZ7quL/fipHUKla+jv7j704c
         z8h41O2EgosDYXj5CfIgogoYMAJ4VQ5QFHs3yfTOFxg6THlgQky6+dvmUJtwkUCFiqzQ
         Wu59ihhQ/VVeEoa11fHdT4dR63SmTX4jlt1cPurpEbdDu15fCFKKTpjf9IdZyaDHFlNE
         0U0dSAHYnHb+JKkECQUy/O4zSOgb/vnKMx6DrSdlJMl41UeNe/5B+cku/v9PvQ4EtmYo
         WHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=97uccG1tYdlFvF5aepnpCDElyZCX5Vq6MsGirlNlioI=;
        b=Aip1qZBvdYVWCWlpaWkRtAfHcHxnyKtuAoQvUcHKdMzHHdA06b4aIAwK2KLVTGaYIL
         mTf/h1ClEY1E469kjv5Riaer9OP7ktDxrwNbyVGPWg0i2jyD77KwrDfk04kRUNjEViXi
         /nJ8Z9i/agODcjX6YKKLt2SutJopR8r5COV0uAgzcuSMkET2krlfNKEvEFrw3HB2ohi4
         f1IGGhFEj93ozPwBWGKBVgGPDP8FxVYNyrGUaFWigCsvEYDk4TSYbC3b6Oe3xZeSueNo
         gP+aewFnkV43k8xMJxfmlKHZiDntcFUcb9cAN8fN4djZQbpzUqeQ+OHGnmzLWX+Pv0MI
         mYnA==
X-Gm-Message-State: AOAM53075SJo5jhX7/omN/p37tytpEHCReS0DNAyLQPHE0GyQTQZSDgA
        uKZ79gEIvJymV36U77U6iHEALvKZnhMNwg==
X-Google-Smtp-Source: ABdhPJzPlO2Z+sqqGx7B+v4mQRWJifdjWLBMBJ9oejPW1Pgb1/o6Nc+FnaiSY8Mb4tgblVhH+Iue0w==
X-Received: by 2002:a63:5518:0:b0:3fa:2f02:1a36 with SMTP id j24-20020a635518000000b003fa2f021a36mr22902123pgb.153.1653646097094;
        Fri, 27 May 2022 03:08:17 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.142.42])
        by smtp.gmail.com with ESMTPSA id p26-20020a056a0026da00b005184640c939sm2994262pfw.207.2022.05.27.03.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:08:16 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        newren@gmail.com, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [WIP v2 1/5] t7002: add tests for moving out-of-cone file/directory
Date:   Fri, 27 May 2022 18:08:00 +0800
Message-Id: <20220527100804.209890-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add corresponding tests to test following situations:

* 'refuse to move out-of-cone directory without --sparse'
* 'can move out-of-cone directory with --sparse'
* 'refuse to move out-of-cone file without --sparse'
* 'can move out-of-cone file with --sparse'
* 'refuse to move sparse file to existing destination'
* 'move sparse file to existing destination with --force and --sparse'

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 t/t7002-mv-sparse-checkout.sh | 98 +++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 1d3d2aca21..963cb512e2 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -206,4 +206,102 @@ test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
 	test_cmp expect stderr
 '
 
+test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
+	git sparse-checkout disable &&
+	git reset --hard &&
+	mkdir folder1 &&
+	touch folder1/file1 &&
+	git add folder1 &&
+	git sparse-checkout init --cone &&
+	git sparse-checkout set sub &&
+
+	test_must_fail git mv folder1 sub 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo folder1/file1 >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr
+'
+
+test_expect_failure 'can move out-of-cone directory with --sparse' '
+	git sparse-checkout disable &&
+	git reset --hard &&
+	mkdir folder1 &&
+	touch folder1/file1 &&
+	git add folder1 &&
+	git sparse-checkout init --cone &&
+	git sparse-checkout set sub &&
+
+	git mv --sparse folder1 sub 1>actual 2>stderr &&
+	test_must_be_empty stderr &&
+
+	git sparse-checkout reapply &&
+	test_path_is_dir sub/folder1 &&
+	test_path_is_file sub/folder1/file1
+'
+
+test_expect_failure 'refuse to move out-of-cone file without --sparse' '
+	git sparse-checkout disable &&
+	git reset --hard &&
+	mkdir folder1 &&
+	touch folder1/file1 &&
+	git add folder1 &&
+	git sparse-checkout init --cone &&
+	git sparse-checkout set sub &&
+
+	test_must_fail git mv folder1/file1 sub 2>stderr &&
+	cat sparse_error_header >expect &&
+	echo folder1/file1 >>expect &&
+	cat sparse_hint >>expect &&
+	test_cmp expect stderr
+'
+
+test_expect_failure 'can move out-of-cone file with --sparse' '
+	git sparse-checkout disable &&
+	git reset --hard &&
+	mkdir folder1 &&
+	touch folder1/file1 &&
+	git add folder1 &&
+	git sparse-checkout init --cone &&
+	git sparse-checkout set sub &&
+
+	git mv --sparse folder1/file1 sub 1>actual 2>stderr &&
+	test_must_be_empty stderr &&
+
+	git sparse-checkout reapply &&
+	! test_path_is_dir sub/folder1 &&
+	test_path_is_file sub/file1
+'
+
+test_expect_failure 'refuse to move sparse file to existing destination' '
+	git sparse-checkout disable &&
+	git reset --hard &&
+	mkdir folder1 &&
+	touch folder1/file1 &&
+	touch sub/file1 &&
+	git add folder1 sub/file1 &&
+	git sparse-checkout init --cone &&
+	git sparse-checkout set sub &&
+
+	test_must_fail git mv --sparse folder1/file1 sub 2>stderr &&
+	echo "fatal: destination exists, source=folder1/file1, destination=sub/file1" >expect &&
+	test_cmp expect stderr
+'
+
+test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
+	git sparse-checkout disable &&
+	git reset --hard &&
+	mkdir folder1 &&
+	touch folder1/file1 &&
+	touch sub/file1 &&
+	echo "overwrite" >folder1/file1 &&
+	git add folder1 sub/file1 &&
+	git sparse-checkout init --cone &&
+	git sparse-checkout set sub &&
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

