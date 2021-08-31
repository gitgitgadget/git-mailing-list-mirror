Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CB3C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F58760F6B
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbhHaNgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbhHaNgs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:36:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C11C061760
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso2586110wmi.5
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NkaMF66/gxPvxQklQ1iRKnwee5Pfa5Lmuwpu9cV8T/4=;
        b=a1bDW0b8peV7P78p8LbLTmFjHpmX2P1WarTxD8rNupudD1P1vp11yaZGgsY+xvIbEr
         6BxBy8FDjoPRJr3UetVBk2ps1dZOV43rJFxeWdP9dNyWEQtDONg9/K7bZ0BYCYM1QKnc
         MpRCHWJo2qjGes0hmnyghCnSn9GIa12/0TryMTst9oBviqGT8Ct/UOg6fjisII85j3vA
         aOuDaV/fXVSCShkPzxy7jqaKelP6fu4COyN6yreryjuxiyJ0oCvYyYKl2OSkqgRmBw3o
         DOrpVcIIQPD+p1yV0Vn8wwQZttiJUbbclYq1xFgtvkY9Q5Vlj2hE8zn92q7HCZROt/2+
         ci9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NkaMF66/gxPvxQklQ1iRKnwee5Pfa5Lmuwpu9cV8T/4=;
        b=rF/gOn9srr0g5yfOQNVQ31+8AknhWe+VGadxl89ttizBtiN8hqcicNFrTAXN07nL8P
         KYs4NCyIjLqj4cx1I0GdbRq3LmWkuO9gFXCIYGSV3QbCBRJ1zuZ3HLJMHCprToc1PFhQ
         zowj46JEL84iOP/HURDVX707CR1z75MnGCL1gZGdoruC0LOWXTGX0iqZMZtfAHdJYb7n
         thztn6ZnczLaNYInN4bNC4mVKyfcpIdkDyq8aIzKwujqpC14uBavWmaX2AvfOOV9WyH/
         i8R5pe9qliEYsINMTKhKVu10jz6kkZ0Xcavh79RE3P35u2mLNazjOd5f0ow0Kk9Le/ye
         zHRQ==
X-Gm-Message-State: AOAM5312gU/7+TwmJNa//gSAZTzdGXdbBbKSGpgaWAG1iVVSQsbTOObA
        uvgfCSHzlCGzDBsIWUy7UsmcJONAXwi7Ow==
X-Google-Smtp-Source: ABdhPJwFOeFYs3dY0xOCF7MEzAo6C5SQAvtdeD7IurciLbJLcZHLeIbXpWWGL2tb9hXMkuiNH+hfWw==
X-Received: by 2002:a05:600c:1912:: with SMTP id j18mr4362120wmq.29.1630416951755;
        Tue, 31 Aug 2021 06:35:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u27sm19073451wru.2.2021.08.31.06.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:35:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/8] tests: annotate t001*.sh with TEST_PASSES_SANITIZE_LEAK=true
Date:   Tue, 31 Aug 2021 15:35:39 +0200
Message-Id: <patch-v3-5.8-ed5f5705755-20210831T132607Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.805.g739b16c2189
In-Reply-To: <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Annotate the t001*.sh tests that pass under SANITIZE=leak, these tests
now pass under GIT_TEST_PASSING_SANITIZE_LEAK=true. We skip
t0012-help.sh, t0014-alias.sh, t0015-hash.sh and t0019-json-writer.sh
due to outstanding memory leaks.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0010-racy-git.sh   | 1 +
 t/t0011-hashmap.sh    | 1 +
 t/t0013-sha1dc.sh     | 1 +
 t/t0016-oidmap.sh     | 1 +
 t/t0017-env-helper.sh | 1 +
 t/t0018-advice.sh     | 1 +
 6 files changed, 6 insertions(+)

diff --git a/t/t0010-racy-git.sh b/t/t0010-racy-git.sh
index 5657c5a87b6..9a627077be4 100755
--- a/t/t0010-racy-git.sh
+++ b/t/t0010-racy-git.sh
@@ -2,6 +2,7 @@
 
 test_description='racy GIT'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 # This test can give false success if your machine is sufficiently
diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
index 5343ffd3f92..02b07ffa75c 100755
--- a/t/t0011-hashmap.sh
+++ b/t/t0011-hashmap.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 
 test_description='test hashmap and string hash functions'
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_hashmap() {
diff --git a/t/t0013-sha1dc.sh b/t/t0013-sha1dc.sh
index 419f31a8f7d..812b5fcaff3 100755
--- a/t/t0013-sha1dc.sh
+++ b/t/t0013-sha1dc.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 
 test_description='test sha1 collision detection'
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 TEST_DATA="$TEST_DIRECTORY/t0013"
 
diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
index 31f8276ba82..a9e135d859b 100755
--- a/t/t0016-oidmap.sh
+++ b/t/t0016-oidmap.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 
 test_description='test oidmap'
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 # This purposefully is very similar to t0011-hashmap.sh
diff --git a/t/t0017-env-helper.sh b/t/t0017-env-helper.sh
index 4a159f99e44..14bb6797b30 100755
--- a/t/t0017-env-helper.sh
+++ b/t/t0017-env-helper.sh
@@ -2,6 +2,7 @@
 
 test_description='test env--helper'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index 39e5e4b34f8..326752a9711 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -2,6 +2,7 @@
 
 test_description='Test advise_if_enabled functionality'
 
+. ./test-pragma-SANITIZE=leak-ok.sh
 . ./test-lib.sh
 
 test_expect_success 'advice should be printed when config variable is unset' '
-- 
2.33.0.805.g739b16c2189

