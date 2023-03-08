Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E39C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 09:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCHJII (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCHJIC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 04:08:02 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F398B690C
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 01:07:28 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id g3so14617354wri.6
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 01:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haGEaFXC8N6H13uRobelgkXdB/bRG8I9aJEAxY5PWo8=;
        b=RbN3logzU235MyUIbxPkrRX8o+JfQcsJe6IbHKEBqMVDcpP/4m/vXA6nVNJGAlv2eW
         iIC/zNKSJrW5tHKD8opjw8VKRPXt8FsNNLMbJCTSy6qUQKdLoM+C55ySDxXuKbbn2Ch2
         v1P6LNnZhDUplavFHiHCFnHtvj0lY+6HXXcUEi5TBQSw//naQ7zfNSeBRVQuidIQ98PA
         IcdK7JVbdN6V690Hude+cWu+BbJxzOzYmzhJkg3TucGlvCKkN70YSY3n7vBuq1Oe/w7J
         Qy8IEPCurBvLOxA3Fz5K7QV1tLyvHOZVXj74wwUK0Dl5uZJkqjnpemruinVCO5mWCqZd
         6SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haGEaFXC8N6H13uRobelgkXdB/bRG8I9aJEAxY5PWo8=;
        b=RTSuGvXgB1KBCVX3NCX2hIl7mCFgIm1r0NcLqmuVu18eH9KkSh1JVlQdFdjUh0eGDg
         3xMhnoAbsjUafDjnLqi3L3Vy5XP7FfgIbvdsDmBnZ7szOv6NZCa/8UnTV1a0nASZVtny
         hACwCz9tH8cif2d0DIRlzNKOeoMaS77af+gvG2ju7BC6/m15Tj4OUXz/tvMhxnczyYQw
         gW3eEA6qeGN2EUrkcV3LpS/7pRhhnidOmhAlaBIqKtez9q0R3lxfsmlES2LHsxJSsbmm
         NZ8jdEsfbL3m+0fzpzrI99hg5feHGkvaoEwgQHL/efTv2Wv3k2hjAG1tYMjgwCLLvn/u
         WoaA==
X-Gm-Message-State: AO0yUKWR4mWj/8EcmLZxzZrGYaMsV7H4z1kmQXCIAEpLEJFZ25aS5pRX
        oHRMX70+UnFIm6AmPSjmcYgT6lzV347XlQ==
X-Google-Smtp-Source: AK7set/MDS7rpWH6Vcm7XM5uLRRx5jJYTPpEYfugM4rqXMFxtW+BeLpoN7mO8dvNj2YyfZyxw2pSug==
X-Received: by 2002:a5d:4b91:0:b0:2ce:8184:4fcf with SMTP id b17-20020a5d4b91000000b002ce81844fcfmr1132831wrt.49.1678266445084;
        Wed, 08 Mar 2023 01:07:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s17-20020adfea91000000b002c6e8cb612fsm14435156wrm.92.2023.03.08.01.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:07:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 7/9] config API users: test for *_get_value_multi() segfaults
Date:   Wed,  8 Mar 2023 10:06:49 +0100
Message-Id: <patch-v7-7.9-57db0fcd91f-20230308T090513Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com> <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we'll discuss in the subsequent commit these tests all
show *_get_value_multi() API users unable to handle there being a
value-less key in the config, which is represented with a "NULL" for
that entry in the "string" member of the returned "struct
string_list", causing a segfault.

These added tests exhaustively test for that issue, as we'll see in a
subsequent commit we'll need to change all of the API users
of *_get_value_multi(). These cases were discovered by triggering each
one individually, and then adding these tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4202-log.sh                 | 11 +++++++++++
 t/t5310-pack-bitmaps.sh        | 16 ++++++++++++++++
 t/t7004-tag.sh                 | 12 ++++++++++++
 t/t7413-submodule-is-active.sh | 12 ++++++++++++
 t/t7900-maintenance.sh         | 23 +++++++++++++++++++++++
 5 files changed, 74 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2ce2b41174d..e4f02d8208b 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -835,6 +835,17 @@ test_expect_success 'log.decorate configuration' '
 
 '
 
+test_expect_failure 'parse log.excludeDecoration with no value' '
+	cp .git/config .git/config.orig &&
+	test_when_finished mv .git/config.orig .git/config &&
+
+	cat >>.git/config <<-\EOF &&
+	[log]
+		excludeDecoration
+	EOF
+	git log --decorate=short
+'
+
 test_expect_success 'decorate-refs with glob' '
 	cat >expect.decorate <<-\EOF &&
 	Merge-tag-reach
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 7d8dee41b0d..0306b399188 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -404,6 +404,22 @@ test_bitmap_cases () {
 		)
 	'
 
+	test_expect_failure 'pack.preferBitmapTips' '
+		git init repo &&
+		test_when_finished "rm -rf repo" &&
+		(
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+			test_commit_bulk --message="%s" 103 &&
+
+			cat >>.git/config <<-\EOF &&
+			[pack]
+				preferBitmapTips
+			EOF
+			git repack -adb
+		)
+	'
+
 	test_expect_success 'complains about multiple pack bitmaps' '
 		rm -fr repo &&
 		git init repo &&
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 9aa1660651b..f343551a7d4 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1843,6 +1843,18 @@ test_expect_success 'invalid sort parameter in configuratoin' '
 	test_must_fail git tag -l "foo*"
 '
 
+test_expect_failure 'version sort handles empty value for versionsort.{prereleaseSuffix,suffix}' '
+	cp .git/config .git/config.orig &&
+	test_when_finished mv .git/config.orig .git/config &&
+
+	cat >>.git/config <<-\EOF &&
+	[versionsort]
+		prereleaseSuffix
+		suffix
+	EOF
+	git tag -l --sort=version:refname
+'
+
 test_expect_success 'version sort with prerelease reordering' '
 	test_config versionsort.prereleaseSuffix -rc &&
 	git tag foo1.6-rc1 &&
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index 7cdc2637649..bfe27e50732 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -51,6 +51,18 @@ test_expect_success 'is-active works with submodule.<name>.active config' '
 	test-tool -C super submodule is-active sub1
 '
 
+test_expect_failure 'is-active handles submodule.active config missing a value' '
+	cp super/.git/config super/.git/config.orig &&
+	test_when_finished mv super/.git/config.orig super/.git/config &&
+
+	cat >>super/.git/config <<-\EOF &&
+	[submodule]
+		active
+	EOF
+
+	test-tool -C super submodule is-active sub1
+'
+
 test_expect_success 'is-active works with basic submodule.active config' '
 	test_when_finished "git -C super config submodule.sub1.URL ../sub" &&
 	test_when_finished "git -C super config --unset-all submodule.active" &&
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 823331e44a0..d82eac6a471 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -524,6 +524,29 @@ test_expect_success 'register and unregister' '
 	git maintenance unregister --config-file ./other --force
 '
 
+test_expect_failure 'register with no value for maintenance.repo' '
+	cp .git/config .git/config.orig &&
+	test_when_finished mv .git/config.orig .git/config &&
+
+	cat >>.git/config <<-\EOF &&
+	[maintenance]
+		repo
+	EOF
+	git maintenance register
+'
+
+test_expect_failure 'unregister with no value for maintenance.repo' '
+	cp .git/config .git/config.orig &&
+	test_when_finished mv .git/config.orig .git/config &&
+
+	cat >>.git/config <<-\EOF &&
+	[maintenance]
+		repo
+	EOF
+	git maintenance unregister &&
+	git maintenance unregister --force
+'
+
 test_expect_success !MINGW 'register and unregister with regex metacharacters' '
 	META="a+b*c" &&
 	git init "$META" &&
-- 
2.40.0.rc1.1034.g5867a1b10c5

