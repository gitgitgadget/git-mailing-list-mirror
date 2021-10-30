Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9D2C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D1560F38
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhJ3W1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhJ3W1E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9643C061746
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso14469133wmd.3
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m0jbK6/twxmnfoRok+ThnkHSE8Lr8QnTgyyXFD09tWA=;
        b=dQLRRB9y6ygKw8f6mGpZTln+ABJm7mp2ndj7e0sqQV3mkPa3f7NHUEppLai6z7thTc
         2ncrMUdQPqEWl4CkOtDgphavQRVUJM2OlaMFAhmdQ2o9lJ6kkJTDQoiZPICl9O4vLbnP
         WbI12SgbtdagxTqnDwKfG4fz7hHVuYkfFhOIYkaq4cl1tQEqrYbsafFcFi7KeGregfG3
         sio7a8UqyBtWfVbRz2AOPBX/fk1/Wm4XscSxGWSm4dRa8ICQOohmYwGSasQPAvUELnYQ
         +hmjKs8wZb2uo6+THb/ObUkSAwprFlJgSYkTbwwYIYbri5aM1eMoiJrCyFrooHuL9h5B
         S/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0jbK6/twxmnfoRok+ThnkHSE8Lr8QnTgyyXFD09tWA=;
        b=6SzPgp2mJxSzdHCCDB6VcXRcGCUhNZ6T/7bsJlI94qrW0FYr+kUhUWW9Dr4ML6qA/c
         TFxE76zNfJ4UcrDOPAzCO7kk6EVTRGgC11701xeZ0fNm7Ngw50wc8w8eFwT92AxdwPXu
         wqZkqq2SS7dVWFTpNtm2x/71sRuwwlbBnD+zIiF6fPxLfApfgoDS8qczXWX61JIo5x/j
         iEw+l5aXpQ/Kkvl4YbONasymcVdbvF3t5P3Yvio2AzQ/QR696LoF+cxMfW+sC837TsTz
         8Bv03JAnHMxTRVYWCdaO/C5Sqtf9ZMO7zostH+xCkLk1TDAz0zhy47pwthhfiIgsNQr4
         qgdg==
X-Gm-Message-State: AOAM533O+eZ8jfRC8oqpjiFLE4TFaAz9zjd3LxJL0f9WEuw1MWgaOJOl
        wORIsmds7ovn2l656tuECtHIvziOx5U98A==
X-Google-Smtp-Source: ABdhPJx0iByi5XCIaxwux6fNtRBeHqT39iF7H9+yC5eFO47XMRNlePpxF5I5+LPLYfCqwIF+6tfhnQ==
X-Received: by 2002:a1c:ed02:: with SMTP id l2mr20806723wmh.115.1635632672076;
        Sat, 30 Oct 2021 15:24:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/15] leak tests: mark some rev-parse tests as passing with SANITIZE=leak
Date:   Sun, 31 Oct 2021 00:24:15 +0200
Message-Id: <patch-06.15-fc5a3ef362c-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*rev-parse*" as passing when git is
compiled with SANITIZE=leak. They'll now be listed as running under
the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks"
CI target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1503-rev-parse-verify.sh       | 1 +
 t/t1506-rev-parse-diagnosis.sh    | 1 +
 t/t1513-rev-parse-prefix.sh       | 1 +
 t/t1515-rev-parse-outside-repo.sh | 2 ++
 4 files changed, 5 insertions(+)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 40958615ebb..94fe413ee37 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -9,6 +9,7 @@ exec </dev/null
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 add_line_into_file()
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 65a154a8a20..18688cae17d 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -7,6 +7,7 @@ exec </dev/null
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_did_you_mean ()
diff --git a/t/t1513-rev-parse-prefix.sh b/t/t1513-rev-parse-prefix.sh
index 5f437be8c9e..ba43387bf16 100755
--- a/t/t1513-rev-parse-prefix.sh
+++ b/t/t1513-rev-parse-prefix.sh
@@ -5,6 +5,7 @@ test_description='Tests for rev-parse --prefix'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1515-rev-parse-outside-repo.sh b/t/t1515-rev-parse-outside-repo.sh
index 3ec2971ee5b..cdb26a30d72 100755
--- a/t/t1515-rev-parse-outside-repo.sh
+++ b/t/t1515-rev-parse-outside-repo.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='check that certain rev-parse options work outside repo'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up non-repo directory' '
-- 
2.33.1.1570.g069344fdd45

