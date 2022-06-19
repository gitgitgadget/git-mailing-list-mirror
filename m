Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A241EC433EF
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 03:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiFSD0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 23:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiFSD0L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 23:26:11 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01266B852
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:26:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m14so6983812plg.5
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EG5gWnDNeQ+at6Y9UAM/Z70VqqJBMK4L16z7V5lnPY0=;
        b=nlaeaRiopeDg6jvn35jTu9cQQniwj+nr4HTvheOfPfgCAVkkJdhqP2Sy02/fVrGGSn
         j7T2aijfYpglax2mDZCOVgv9YtPKSKvoyFSznZnq/6r40nVyKm8lA+JLAH6/Joos/35l
         KCV3mUoxsQjjFsJJbbHsR7543/T+lVQAVqIFu6ydvi+qLOPN45Thfb4gcACXbWCQOWCg
         W7cvugUo/R/eoY4z+5Niq/n6DQCyVo9nxP1dQ3fUBOU3s/iYPL75yp34sAiij3oyVsEO
         /S0Bm6o223K940fNtRfR++01EvM74HFjmPo9RyGOd9PsflmgDBKv0OmKgqGLkeINKEZL
         ftUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EG5gWnDNeQ+at6Y9UAM/Z70VqqJBMK4L16z7V5lnPY0=;
        b=QDJt0Cbj0jVsn/dXuN6iO0G0cfjQG6Q8BAfoBlSc7v06QXxjZX0+dTU0p7ObaZACg0
         Pcf3Le7U8Ukabamyzg04qVJGrHaDkdKcWifCrpZ9FiNYr6yIa6ELFALevkOR9clzhMBu
         TeqlGiQJWBJ+E0kJXkuFvDHRNewbliB+Iu+d+b0r/we5fvFFgYQcaC/lRPHOU+R0ehdQ
         AzQ4jzvZdMkj/iP6tKkni2VxPkMqy4Q72eqk2W3FfktUuqq/GuMUJJ85a/K0+GdphIQD
         FzH+QgjoZfogYvnfr3ChXvwiUB32R8VzBzkLaoEgXtz7MUbOZ22zIMBYYa9sgXLpsSp3
         dnZg==
X-Gm-Message-State: AJIora9FNtpDKVZOfE83n1QRYYXxTbD7ncVuJV54fsErFLD4cztNbuRg
        FHUyGNrytFjGtCKZswQlqO4=
X-Google-Smtp-Source: AGRyM1uMMc/ae3Fcz7TMxt/Gbsh2LxV8Lwwm11uIwFdeIVb0v/dSZI7aRhjUIR6nWO0S6FEazYoJJg==
X-Received: by 2002:a17:90b:17d2:b0:1e2:c0a2:80fb with SMTP id me18-20020a17090b17d200b001e2c0a280fbmr31130023pjb.67.1655609169504;
        Sat, 18 Jun 2022 20:26:09 -0700 (PDT)
Received: from ffyuanda.localdomain ([112.195.147.33])
        by smtp.gmail.com with ESMTPSA id u1-20020a170903124100b0016188a4005asm5990650plh.122.2022.06.18.20.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 20:26:09 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com, newren@gmail.com
Subject: [WIP v3 1/7] t7002: add tests for moving out-of-cone file/directory
Date:   Sun, 19 Jun 2022 11:25:43 +0800
Message-Id: <20220619032549.156335-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
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
 t/t7002-mv-sparse-checkout.sh | 87 +++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index f0f7cbfcdb..d6e7315a5a 100755
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
@@ -206,4 +219,78 @@ test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
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
+	git mv --sparse folder1 sub 1>actual 2>stderr &&
+	test_must_be_empty stderr &&
+
+	git sparse-checkout reapply &&
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
+	git mv --sparse folder1/file1 sub 1>actual 2>stderr &&
+	test_must_be_empty stderr &&
+
+	git sparse-checkout reapply &&
+	! test_path_is_dir sub/folder1 &&
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

