Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02496C4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 12:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiKSMlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 07:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiKSMlg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 07:41:36 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CEC6A6A5
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:34 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id vv4so9760127ejc.2
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0kVJPrcxV2Y2760PKx7s3eI1MtlXEdJGronuXW6Qbs=;
        b=PvkJjxV1QbPiOGqBS8vr4m2wbYOZx/cWY1NxUUlbxCo0An6auX/7UlLoaZ/LR5Pl7K
         DAsIiAYxLWFawTHk9e5wfD/qA3GvFMK6OURut5nn9x1HJC1dU2YxHcsttlln1QTgjEOT
         nRv86lHhAXo4Kud0FR6x5z2s/eHK5gRBAFVMjFh5YvzcV5cpU1R8z+2KqfsTz9UohRkv
         u7fUMV3z2a72BWWqIV+8LT/996rYjO5yGUqT9dEnmTLviRVrToQjbpr6GKZSiI86rDMi
         o+LP0A0K+7qo3hS+lOhO6opzICNBo0oybtkp74bL6hrD0jFscBxqcfeatQxv6VwFvgvT
         Mbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0kVJPrcxV2Y2760PKx7s3eI1MtlXEdJGronuXW6Qbs=;
        b=4zn15rbDqFLv/NZ1YEXQCOCvDp8QPGnktSNfgh17DnXRPyrsfXiDRFnRh71/yQfciz
         CLXeLGdKQaQPTszvfBSS9ZfMNirvIPBZ3SzR6f+fGDCV6QA5PxCrTHRThXrq3BgPCN5h
         6/i4xtbbO3hbjgJO5OpN91DnI9mjkBlpVRJZnaY3REY8sQilS7T9HfMvcTJwqGP8+ujC
         T2LJKKH/Esj4hRD0itgLO1tqyB/hiD6KiZiXs9bcbhXQI4yKVzFiTZAiYsMjTevb6jF9
         xgiGGW/vfvxhafWAvOKH/rxkK7ZMmJHg8t1wcLNLlScaG74y3Tgmskez8ZTFoG6fFR4F
         JUtw==
X-Gm-Message-State: ANoB5pngd1ek2RNdPhCHlAxIEQBG9Dsr8KWcGNtL2MgaumhYN93Ha/wt
        R33/QFnc2XQXOhaqj15oHU6b6YmeZOm9RQ==
X-Google-Smtp-Source: AA0mqf7vOkGq2y223L7PyezaG+cOnTGZMnkdEFwOAHYLH9zp+2/b1BrLbXJyGUdoOlaErviPhs1vcQ==
X-Received: by 2002:a17:907:9151:b0:7ae:df97:c03d with SMTP id l17-20020a170907915100b007aedf97c03dmr1451724ejs.125.1668861692931;
        Sat, 19 Nov 2022 04:41:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id la19-20020a170907781300b007b29eb8a4dbsm2909276ejc.13.2022.11.19.04.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 04:41:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/9] read-tree + fetch tests: test failing "--super-prefix" interaction
Date:   Sat, 19 Nov 2022 13:41:20 +0100
Message-Id: <patch-v3-1.9-c930fc38356-20221119T122853Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Ever since "git fetch --refetch" was introduced in 0f5e8851737 (Merge
branch 'rc/fetch-refetch', 2022-04-04) the test being added here would
fail. This is because "restore" will "read-tree .. --reset <hash>",
which will in turn invoke "fetch". The "fetch" will then die with:

	fatal: fetch doesn't support --super-prefix

This edge case and other "--super-prefix" bugs will be fixed in
subsequent commits, but let's first add a "test_expect_failure" test
for it. It passes until the very last command in the test.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5616-partial-clone.sh | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 037941b95d2..2846ec6629c 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -644,6 +644,49 @@ test_expect_success 'repack does not loosen promisor objects' '
 	grep "loosen_unused_packed_objects/loosened:0" trace
 '
 
+test_expect_failure 'lazy-fetch in submodule succeeds' '
+	# setup
+	test_config_global protocol.file.allow always &&
+
+	test_when_finished "rm -rf src-sub" &&
+	git init src-sub &&
+	git -C src-sub config uploadpack.allowfilter 1 &&
+	git -C src-sub config uploadpack.allowanysha1inwant 1 &&
+
+	# This blob must be missing in the subsequent commit.
+	echo foo >src-sub/file &&
+	git -C src-sub add file &&
+	git -C src-sub commit -m "submodule one" &&
+	SUB_ONE=$(git -C src-sub rev-parse HEAD) &&
+
+	echo bar >src-sub/file &&
+	git -C src-sub add file &&
+	git -C src-sub commit -m "submodule two" &&
+	SUB_TWO=$(git -C src-sub rev-parse HEAD) &&
+
+	test_when_finished "rm -rf src-super" &&
+	git init src-super &&
+	git -C src-super config uploadpack.allowfilter 1 &&
+	git -C src-super config uploadpack.allowanysha1inwant 1 &&
+	git -C src-super submodule add ../src-sub src-sub &&
+
+	git -C src-super/src-sub checkout $SUB_ONE &&
+	git -C src-super add src-sub &&
+	git -C src-super commit -m "superproject one" &&
+
+	git -C src-super/src-sub checkout $SUB_TWO &&
+	git -C src-super add src-sub &&
+	git -C src-super commit -m "superproject two" &&
+
+	# the fetch
+	test_when_finished "rm -rf client" &&
+	git clone --filter=blob:none --also-filter-submodules \
+		--recurse-submodules "file://$(pwd)/src-super" client &&
+
+	# Trigger lazy-fetch from the superproject
+	git -C client restore --recurse-submodules --source=HEAD^ :/
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.38.0.1509.g9445af83948

