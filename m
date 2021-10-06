Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3EAC433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E18610FB
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbhJFJwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbhJFJwk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 05:52:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B2DC061764
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 02:50:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z20so7469948edc.13
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 02:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Durb7W2TNNYQpAz03K79c7drPF3f/t+Mka8I6byRVGY=;
        b=lYnd+Rt0rAhCbcZ62zX0V3Msi72RDrNTMt+2MXkKzU5gcz41/ThLjHq7kE2TtrY6WT
         GRJXyKOVvGaPAH8UpOGj9XIsgmasksSpzginVxTYhx+azIQT3ZOSapMnQPPPxkJG9VPh
         R4wYb3F9NFK4JgvQP6M2XbIQnCW6ofhxUvIKMORuciq2JfxelShKDm9Kx9gz23JMDQvP
         863h48J3GhZJvP9EuRmAYXpUa0VoyQ5qZI/TvWFSGoEczqXLW4haQ1ZeQLCk1HsH28O6
         gDFT40fJvKT+0/QUHC2/QonkGnDV/XqEi2YucYsLH4lte5sUC1PwVLKaNqpWlKNvA75Y
         CYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Durb7W2TNNYQpAz03K79c7drPF3f/t+Mka8I6byRVGY=;
        b=MlBO2WYh+bi32YJifnMI8yPt00aP8WCVQiMwSBu2j/NrZ6PGZlXeASr6XDSMgZgS3p
         lXqAhFaSSDPPbzZ6CfcuAOV5SQrsSz9Bz4I7eXNJnCY75iIUV5vaVM+wekENQKfJkQis
         HoPR5P/nywu51sunMLteidZfQqrgWnYmwyGd/7UV4OQ3pLvcnpUj8m07d0z5sYW/6ief
         wkNeieu9zz4lsaUjH9xEw6Gn3FBUDkCq8wKiNUOdTtCaS0tLcjo6CUNXrIA7PFWqsGIW
         rMKoSJ8SohDkT3fEP3aH7G0t4R3WrbIUCNqdgS5PIGKySTSqdWW3p3v8AgjHTaD6FdxV
         Ov2Q==
X-Gm-Message-State: AOAM530w96wnnlxjGL5JWiSyt4nPrBd4iX4LekB/ueaihQ5KxbpbfLR7
        W+GuXOG1eCyHXcNPuscfZF8p5AQg+8kiRQ==
X-Google-Smtp-Source: ABdhPJxniru6+t65OVnu2QSpDYMzNnHQajuk2DZa5kSNpBRdADL6sgrRdYOpL78G5fLdRUbQ47hH3Q==
X-Received: by 2002:a05:6402:393:: with SMTP id o19mr7858525edv.349.1633513844703;
        Wed, 06 Oct 2021 02:50:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm9886243edu.48.2021.10.06.02.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:50:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/10] leak tests: mark some ls-files tests as passing with SANITIZE=leak
Date:   Wed,  6 Oct 2021 11:50:34 +0200
Message-Id: <patch-07.10-b913feca9d8-20211006T094705Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*ls-files*" as passing when git is
compiled with SANITIZE=leak. They'll now be whitelisted as running
under the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the
"linux-leaks" CI target). We still have others that match '*ls-files*"
that fail under SANITIZE=leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3000-ls-files-others.sh              | 2 ++
 t/t3002-ls-files-dashpath.sh            | 2 ++
 t/t3003-ls-files-exclude.sh             | 2 ++
 t/t3004-ls-files-basic.sh               | 1 +
 t/t3006-ls-files-long.sh                | 2 ++
 t/t3008-ls-files-lazy-init-name-hash.sh | 1 +
 6 files changed, 10 insertions(+)

diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 740ce56eab5..11af4552f74 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -15,6 +15,8 @@ filesystem.
     path3/file3 - a file in a directory
     path4       - an empty directory
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t3002-ls-files-dashpath.sh b/t/t3002-ls-files-dashpath.sh
index 8704b04e1b4..54d22a45dfb 100755
--- a/t/t3002-ls-files-dashpath.sh
+++ b/t/t3002-ls-files-dashpath.sh
@@ -12,6 +12,8 @@ filesystem.
     -foo	- a file with a funny name.
     --		- another file with a funny name.
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t3003-ls-files-exclude.sh b/t/t3003-ls-files-exclude.sh
index c41c4f046ab..7933dff9b38 100755
--- a/t/t3003-ls-files-exclude.sh
+++ b/t/t3003-ls-files-exclude.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='ls-files --exclude does not affect index files'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create repo with file' '
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index 9fd5a1f188a..a16e25c79bd 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -6,6 +6,7 @@ This test runs git ls-files with various unusual or malformed
 command-line arguments.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'ls-files in empty repository' '
diff --git a/t/t3006-ls-files-long.sh b/t/t3006-ls-files-long.sh
index e109c3fbfb5..2aaf91ebc8c 100755
--- a/t/t3006-ls-files-long.sh
+++ b/t/t3006-ls-files-long.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='overly long paths'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
index 85f37049587..51d3dffaa66 100755
--- a/t/t3008-ls-files-lazy-init-name-hash.sh
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -2,6 +2,7 @@
 
 test_description='Test the lazy init name hash with various folder structures'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test 1 -eq $(test-tool online-cpus)
-- 
2.33.0.1441.gbbcdb4c3c66

