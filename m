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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21399C433E6
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 09:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17F220829
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 09:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbhACJih (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 04:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbhACJig (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 04:38:36 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2536C0613CF
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 01:37:55 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id y19so57531672lfa.13
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 01:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XClaAPDqPKJ2pjsDU3Q20hVdUOKIsnRj6sZJs89IMJk=;
        b=BWUVu7qrnrpuIsmD4+tGqyT/8RBlDXYAgM1jy7UuJCt6iBJzrC7owF6FNoXoRsFCXB
         J+/g3bazd4Dg2ZBXojl5sSzLktu35fC3wPCnMXZOcEx4KTGQzLqB2edZC4ND/eLB7c0y
         z2Jr3nupw9CXHbV5z10D/pKbmAe8yfcDX0O8392P9ZE1rQOk55FY5kBoYboXEGoz/TOM
         rAsglswan3ja2MJ+CxcoN8HhKxUeFX3Wk6MFcxFeNYXKZ6uvhhqgtWtWqPCMCZk79pen
         3X+cs280zwQqvLztHgWoGGTEylNTI/90VpfIdEpx+swYZRmEjS5c7opwvh/R5MaKE91E
         Ym9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XClaAPDqPKJ2pjsDU3Q20hVdUOKIsnRj6sZJs89IMJk=;
        b=PCcHhyVhLmodXrrkFjVtleoAyoDaVK65vco9/M7Ef2bOG7UkK6Sf33ygcYqTjoDm0O
         cF/pqPrYRePsv0bZPfzy7UrqNlSng8gXvbWLgK7eqykpybnh0TmLkVrB83E8jvrJIIAx
         gpfQ36Y4iUqLogAFEqmsjO60f1MrQFjypQv3u4MvyOBGZvTN45CduLUFfwmhu+PLG8YC
         bmV0K3yH7BucnYNH2ndiOMzvVHooli+dqTgemoRLlRtS8qQKe0k8/PO1YQaBN9HNLhk6
         OBegpjbtN6wQFISSD7BIRS1WDDK/WjQLzMoq4lF5Go66+G2Zlltxging0j7oXTuMujiC
         BGrw==
X-Gm-Message-State: AOAM531hLvrcg1ga/feqsgmGCIU7LMb30q2hdBWflsyd2Da0yBoxFuj0
        /Pyero1IZwl0Tf4WD8JFPmm6YeC+yg0=
X-Google-Smtp-Source: ABdhPJyftoMrm4kwiAIO1vw9i6/UGwc2641nUoUmOlwfi3zK8/z3GMECPwmHDs0q31/Q0bspA4mc/A==
X-Received: by 2002:ac2:5333:: with SMTP id f19mr32129928lfh.344.1609666674118;
        Sun, 03 Jan 2021 01:37:54 -0800 (PST)
Received: from localhost.localdomain (host-189-203-5.junet.se. [207.189.203.5])
        by smtp.gmail.com with ESMTPSA id h13sm7025202lfj.110.2021.01.03.01.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 01:37:53 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 2/3] t1300: remove duplicate test for `--file no-such-file`
Date:   Sun,  3 Jan 2021 10:36:47 +0100
Message-Id: <20210103093649.2221-3-martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210103093649.2221-1-martin.agren@gmail.com>
References: <20210103093649.2221-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We test that we can handle `git config --file symlink` and the error
case of `git config --file symlink-to-missing-file`. For good measure,
we also throw in a test to check that we correctly handle referencing a
missing regular file. But we have such a test earlier in this script.
They both check that we fail to use `--file no-such-file --list`.

Drop the latter of these and keep the one that is in the general area
where we test `--file` and `GIT_CONFIG`. The one we're dropping also
checks that we can't even get a specific key from the missing file --
let's make sure we check that in the test we keep.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t1300-config.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 302821fb02..1439d870d6 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -469,7 +469,8 @@ test_expect_success 'new variable inserts into proper section' '
 '
 
 test_expect_success 'alternative --file (non-existing file should fail)' '
-	test_must_fail git config --file non-existing-config -l
+	test_must_fail git config --file non-existing-config -l &&
+	test_must_fail git config --file non-existing-config test.xyzzy
 '
 
 cat > other-config << EOF
@@ -1032,11 +1033,6 @@ test_expect_success SYMLINKS 'symlinked configuration' '
 	test_cmp expect actual
 '
 
-test_expect_success 'nonexistent configuration' '
-	test_must_fail git config --file=doesnotexist --list &&
-	test_must_fail git config --file=doesnotexist test.xyzzy
-'
-
 test_expect_success SYMLINKS 'symlink to nonexistent configuration' '
 	ln -s doesnotexist linktonada &&
 	ln -s linktonada linktolinktonada &&
-- 
2.30.0

