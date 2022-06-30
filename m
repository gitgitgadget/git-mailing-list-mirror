Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8BDC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 02:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiF3CiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 22:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiF3Chu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 22:37:50 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2361D23162
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:37:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x4so16838222pfq.2
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyBk/n5Xb1g9Y6Zvz48uQ/XmYg2QSFrTAGliHe5zU3k=;
        b=BEJ6w6XKIQuZBV7QzcOaGXzDEIcNP36CLM5K08UTK8u9/peSWxRjdL3gPU/Ud4gjfA
         uQfEXALFMgJLBfwRiPx23ikBFr5AG34kGe+vtNisxRuN7sJjAb56i9H32KGHp+y0s7dQ
         hjMHg9aF7ylzBemqMipwEuVnU8IKzLCTGxOXM4Yupj/eiVbebY9V0LjPtDIpj8sMKyGb
         rNS8Zxx70ODjoBDIiCvsFuwMjfUxM8xCLDlMtk9Uy2nsMc4PH5Cyl5q57Hkg1WMzV5pG
         Zg2WJZ6xEqCa5XVF3qK6eHpRTkcb4ewVvs2/vM+vnBoUGs2sucUH+AsiNJcUUangAwtS
         4hsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyBk/n5Xb1g9Y6Zvz48uQ/XmYg2QSFrTAGliHe5zU3k=;
        b=abUzrKNOWLaFMw+Ze61PwhsPRDJztuFRIYITiNjg/lV4WGw0TXZRmV4YeFQ4zk33fT
         VA+Og241kyWlxdL8sn6AcMSFScjrEIeW6HpYKCM2suXF0waljm9Rcb0vsNp+nTC3N01p
         7oXjuG82AlL9HuxF1/DY88LYvLGriOI+IQlZMFzApm0A8f46Z74cnB8/JNTKygOgThf8
         2EA6v+MMvV0YjwHqrCvOHKBO5XEaVHkETNo0lp+P9mAx7Yjn0ZYiQlvjfZpRTLl3wDrt
         c5fXZe0ie0hVwZ7tF9FrJwnUrMXXY45QJC9lRbvSFbW97mgXxS+Rb6/hNPLjVQ3zGzne
         eYZA==
X-Gm-Message-State: AJIora/9wRp8VhwEOZom7Il/40CfHQFakBUfo7zVqQ9jJyIehfeC4v7L
        yP7ZU8kVQG4QPbLdCT4G7Lm3JAQBc/4=
X-Google-Smtp-Source: AGRyM1s3YchN3qBxb0pQIH9GQu6Xt1NWyurmzGG6VUvrcUQHqD4gC+FxsiaNkHoammNoaeyJs8E9pw==
X-Received: by 2002:a05:6a00:3006:b0:525:266a:852e with SMTP id ay6-20020a056a00300600b00525266a852emr13294421pfb.60.1656556669450;
        Wed, 29 Jun 2022 19:37:49 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.226.29])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902b69000b001678dcb4c5asm12157509pls.100.2022.06.29.19.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 19:37:48 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v5 1/8] t7002: add tests for moving out-of-cone file/directory
Date:   Thu, 30 Jun 2022 10:37:30 +0800
Message-Id: <20220630023737.473690-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220630023737.473690-1-shaoxuan.yuan02@gmail.com>
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

