Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E7AC3DA6E
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 12:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiLTMnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 07:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiLTMnE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 07:43:04 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA861ADAE
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i187-20020a1c3bc4000000b003d1e906ca23so8108250wma.3
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSzeH7luLu4Pkp0byFVjuqOXJIB7KyJBRfz3RD90wb4=;
        b=Jv+sH94/aRL0t/HX9F+X69QFpMUGseP7GpOY74rflu4BDs4JEhCMIciXRkrBypT3Wb
         qaq7mxh8jtMttf8Btf3sxrtrZkeofLFicbBWFy1hE4zCUG/LU8CNN4saXy+ZqyKT/z1W
         w/LVrBudHqhpzlUidlkIUWAGOtBE75/e97BpcMO1oy/zp+YmHNzM+Tj1/uQ/3yTVLQ8D
         RZ1jEV+4dFxaEd9EhXdrWOhciOwJHMVCUR2FKS/6qvzCngA0k6FyGiRTdzU0MmPrJnui
         0x3FqCIkbaXPDSLFT1tE/FkK/T7HTW4dPNMgES/WJWCNo40/c9UG8qYj7cMXKo+7KNa3
         zGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSzeH7luLu4Pkp0byFVjuqOXJIB7KyJBRfz3RD90wb4=;
        b=yYtueas8OkyAqnSWDr5GqmQ+t4CoVyUYo4qxEK4klj1vKM8mRBojT8T42tW2aqS9fR
         1SB9BDSw/Ec5n8p3TNHY3AzFufTPwmgpIfd1JRGFPY0lOvAdkVpiy/SN8M2KNGlUMsE6
         zgpKE/eEOpNwdoAiVOmh4Y113OAMMgAJ/m5tv+Q/z1mC72mNAvTvswutCvZqCzlJTYoX
         aYcwLunEKHyypcDe2ZHwwZjL34JmUJplWwbir4LwbUE8E7mUWrzjMv+eKuTdzExQ4Iiw
         4MXcKK3j6h4O4I2nPfiilpVWppPqVSd7N/WqIZ7LH1aHRCfhlBNvngsMFYOW/P0MX1o8
         xWyQ==
X-Gm-Message-State: AFqh2kqoTm8/q0z4XNdJGh4dTyx14HrRNikPaB8AM43eOHyMc3+58MNP
        zTl03AYXZwsZVVK2rpPc1yZipHJ8mHvuuw==
X-Google-Smtp-Source: AMrXdXu27uFDBCfL7+PQkeJnSYn8J24Oaoj8w2kq9LF1PQTgzT/lJpbX8ZwpOqzmjAj5m1fLhFue/Q==
X-Received: by 2002:a05:600c:3d1b:b0:3cf:497c:c59e with SMTP id bh27-20020a05600c3d1b00b003cf497cc59emr1513087wmb.6.1671540002236;
        Tue, 20 Dec 2022 04:40:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003d355ad9bb7sm9630759wmq.20.2022.12.20.04.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:40:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 1/9] submodule absorbgitdirs tests: add missing "Migrating git..." tests
Date:   Tue, 20 Dec 2022 13:39:48 +0100
Message-Id: <patch-v5-1.9-f062cb2f265-20221220T104519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1106.g08bce9674be
In-Reply-To: <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blind spots in the tests surrounding "submodule absorbgitdirs"
and test what output we emit, and how emitted the message and behavior
interacts with a "git worktree" where the repository isn't at the base
of the working directory.

The "$(pwd)" instead of "$PWD" here is needed due to Windows, where
the latter will be a path like "/d/a/git/[...]", whereas we need
"D:/a/git/[...]".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7412-submodule-absorbgitdirs.sh | 64 ++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 2859695c6d2..f7783218576 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -10,6 +10,7 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a real submodule' '
+	cwd="$(pwd)" &&
 	git init sub1 &&
 	test_commit -C sub1 first &&
 	git submodule add ./sub1 &&
@@ -18,13 +19,21 @@ test_expect_success 'setup a real submodule' '
 '
 
 test_expect_success 'absorb the git dir' '
+	>expect &&
+	>actual &&
 	>expect.1 &&
 	>expect.2 &&
 	>actual.1 &&
 	>actual.2 &&
 	git status >expect.1 &&
 	git -C sub1 rev-parse HEAD >expect.2 &&
-	git submodule absorbgitdirs &&
+	cat >expect <<-EOF &&
+	Migrating git directory of '\''sub1'\'' from
+	'\''$cwd/sub1/.git'\'' to
+	'\''$cwd/.git/modules/sub1'\''
+	EOF
+	git submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual &&
 	git fsck &&
 	test -f sub1/.git &&
 	test -d .git/modules/sub1 &&
@@ -37,7 +46,8 @@ test_expect_success 'absorb the git dir' '
 test_expect_success 'absorbing does not fail for deinitialized submodules' '
 	test_when_finished "git submodule update --init" &&
 	git submodule deinit --all &&
-	git submodule absorbgitdirs &&
+	git submodule absorbgitdirs 2>err &&
+	test_must_be_empty err &&
 	test -d .git/modules/sub1 &&
 	test -d sub1 &&
 	! test -e sub1/.git
@@ -56,7 +66,13 @@ test_expect_success 'setup nested submodule' '
 test_expect_success 'absorb the git dir in a nested submodule' '
 	git status >expect.1 &&
 	git -C sub1/nested rev-parse HEAD >expect.2 &&
-	git submodule absorbgitdirs &&
+	cat >expect <<-EOF &&
+	Migrating git directory of '\''sub1/nested'\'' from
+	'\''$cwd/sub1/nested/.git'\'' to
+	'\''$cwd/.git/modules/sub1/modules/nested'\''
+	EOF
+	git submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual &&
 	test -f sub1/nested/.git &&
 	test -d .git/modules/sub1/modules/nested &&
 	git status >actual.1 &&
@@ -87,7 +103,13 @@ test_expect_success 're-setup nested submodule' '
 test_expect_success 'absorb the git dir in a nested submodule' '
 	git status >expect.1 &&
 	git -C sub1/nested rev-parse HEAD >expect.2 &&
-	git submodule absorbgitdirs &&
+	cat >expect <<-EOF &&
+	Migrating git directory of '\''sub1'\'' from
+	'\''$cwd/sub1/.git'\'' to
+	'\''$cwd/.git/modules/sub1'\''
+	EOF
+	git submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual &&
 	test -f sub1/.git &&
 	test -f sub1/nested/.git &&
 	test -d .git/modules/sub1/modules/nested &&
@@ -97,6 +119,27 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	test_cmp expect.2 actual.2
 '
 
+test_expect_success 'absorb the git dir outside of primary worktree' '
+	test_when_finished "rm -rf repo-bare.git" &&
+	git clone --bare . repo-bare.git &&
+	test_when_finished "rm -rf repo-wt" &&
+	git -C repo-bare.git worktree add ../repo-wt &&
+
+	test_when_finished "rm -f .gitconfig" &&
+	test_config_global protocol.file.allow always &&
+	git -C repo-wt submodule update --init &&
+	git init repo-wt/sub2 &&
+	test_commit -C repo-wt/sub2 A &&
+	git -C repo-wt submodule add ./sub2 sub2 &&
+	cat >expect <<-EOF &&
+	Migrating git directory of '\''sub2'\'' from
+	'\''$cwd/repo-wt/sub2/.git'\'' to
+	'\''$cwd/repo-bare.git/worktrees/repo-wt/modules/sub2'\''
+	EOF
+	git -C repo-wt submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup a gitlink with missing .gitmodules entry' '
 	git init sub2 &&
 	test_commit -C sub2 first &&
@@ -107,7 +150,11 @@ test_expect_success 'setup a gitlink with missing .gitmodules entry' '
 test_expect_success 'absorbing the git dir fails for incomplete submodules' '
 	git status >expect.1 &&
 	git -C sub2 rev-parse HEAD >expect.2 &&
-	test_must_fail git submodule absorbgitdirs &&
+	cat >expect <<-\EOF &&
+	fatal: could not lookup name for submodule '\''sub2'\''
+	EOF
+	test_must_fail git submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual &&
 	git -C sub2 fsck &&
 	test -d sub2/.git &&
 	git status >actual &&
@@ -127,8 +174,11 @@ test_expect_success 'setup a submodule with multiple worktrees' '
 '
 
 test_expect_success 'absorbing fails for a submodule with multiple worktrees' '
-	test_must_fail git submodule absorbgitdirs sub3 2>error &&
-	test_i18ngrep "not supported" error
+	cat >expect <<-\EOF &&
+	fatal: could not lookup name for submodule '\''sub2'\''
+	EOF
+	test_must_fail git submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.39.0.1071.g97ce8966538

